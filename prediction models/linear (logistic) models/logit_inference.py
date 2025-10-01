import pandas as pd
import numpy as np
import statsmodels.api as sm


# --------------------------
# Daten laden
# --------------------------
data = pd.read_csv("/Users/maxbur/Desktop/full_data.csv", sep=";")
cols_to_keep = [c for c in data.columns if not c.startswith("P") or c == "P_chest_tube"]
data = data[cols_to_keep]
initial_data_amount = len(data)



# die Scores in floats transformieren
for col in ["X_ISS", "X_RibScore", "X_Elixhauser", "X_TTSS"]:
    if col in data.columns:
        data[col] = data[col].astype(str).str.replace(",", ".").astype(float)

# Alle NaNs entfernen
data = data.dropna()

# Alle Zeilen löschen, die irgendwo "not_available" und "Nicht verfügbar" (letzteres nur X_antikoagulation_antiplatelet) enthalten
mask = data.astype(str).apply(lambda row: row.str.contains("not_available|Nicht verfügbar")).any(axis=1)
data = data.loc[mask == False]

# Zielvariable binär
y = (data["P_chest_tube"] == "yes").astype(int)
X = data[[col for col in data.columns if col.startswith("X")]]


# --------------------------
# 2) Dummy-Kodierung pro Variable mit drop_first=True
# --------------------------

# Liste der numerischen Features, die als float bleiben sollen
true_numeric = ["X_ISS", "X_RibScore", "X_Elixhauser", "X_TTSS"]

X_proc = pd.DataFrame(index=X.index)

for col in X.columns:
    if col in true_numeric:
        # echte numerische Variablen direkt als float übernehmen
        X_proc[col] = X[col].astype(float)
    else:
        categories = X[col].astype(str).unique().tolist()
        
        # Wähle Referenz falls möglich
        if "not_applicable" in categories:
            ref = "not_applicable"
        elif "none" in categories:
            ref = "none"
        else:
            ref = None
        
        if ref is not None:
            dummies = pd.get_dummies(X[col].astype(str), prefix=col)
            if f"{col}_{ref}" in dummies.columns:
                dummies = dummies.drop(columns=[f"{col}_{ref}"])
        else:
            # Standard: drop_first=True
            dummies = pd.get_dummies(X[col].astype(str), prefix=col, drop_first=True)
        
        # Dummies anhängen
        X_proc = pd.concat([X_proc, dummies], axis=1)

X_proc = X_proc.astype(float)



# --------------------------
# 4) Problematische Spalten filtern
# --------------------------

# Spalten ohne Varianz
X_clean = X_proc.loc[:, X_proc.nunique() > 1]
"""
# Funktion zum Finden und Entfernen von Perfect-Separation-Spalten
def drop_perfect_separators(X, y):
    sep_cols = []
    for col in X.columns:
        tab = pd.crosstab(X[col], y)
        if (tab.shape[0] == 2) and (0 in tab.values):  # Perfect separation
            sep_cols.append(col)
    print("ACHTUNG -- Perfect Separator Spalten entfernt:", sep_cols)
    return X.drop(columns=sep_cols, errors="ignore"), sep_cols

# Anwendung
X_clean, removed_separators = drop_perfect_separators(X_clean, y)
"""
def drop_perfect_separators_conservative(
    X: pd.DataFrame,
    y: pd.Series,
    min_group_n: int = 5,
    min_group_frac: float = 0.01,
    verbose: bool = True,
):
    """
    Entfernt nur 0/1-Dummy-Spalten mit starker Evidenz für Perfect Separation.
    Kriterien:
      - Spalte ist binär {0,1}
      - Gruppe (col==1) hat genügende Größe (>= max(min_group_n, min_group_frac*len))
      - In Gruppe (col==1) fehlt eine Outcome-Kategorie komplett (alle 0 oder alle 1)
      - Vergleichsgruppe (col==0) enthält beide Outcome-Kategorien (nicht separiert)
    """
    y = pd.Series(y).astype(int)
    n = len(y)
    min_group_size = max(min_group_n, int(np.ceil(min_group_frac * n)))

    cols_to_drop = []
    reasons = {}

    for col in X.columns:
        s = X[col]
        if s.nunique() <= 1:
            continue

        # Nur binäre Dummies prüfen
        uniq = set(pd.unique(s.dropna().astype(float)))
        if not uniq.issubset({0.0, 1.0}):
            continue

        mask1 = s == 1
        grp1_size = int(mask1.sum())
        if grp1_size < min_group_size:
            continue  # zu wenig Evidenz in der 1‑Gruppe

        # Outcome-Verteilung in beiden Gruppen
        pos1 = int(y[mask1].sum())
        neg1 = int(grp1_size - pos1)

        mask0 = s == 0
        grp0_size = int(mask0.sum())
        pos0 = int(y[mask0].sum())
        neg0 = int(grp0_size - pos0)

        # Separation nur droppen, wenn 1‑Gruppe strikt separiert ist
        # und 0‑Gruppe beide Outcomes enthält (zur Absicherung gegen Artefakte)
        group1_separated = (pos1 == 0) or (neg1 == 0)
        group0_has_both = (pos0 > 0) and (neg0 > 0)

        if group1_separated and group0_has_both:
            cols_to_drop.append(col)
            reasons[col] = {
                "grp1_size": grp1_size,
                "pos1": pos1,
                "neg1": neg1,
                "grp0_size": grp0_size,
                "pos0": pos0,
                "neg0": neg0,
            }

    if verbose and cols_to_drop:
        print("ACHTUNG -- konservativ entfernte Separator-Dummies:")
        for c in cols_to_drop:
            print(f"  {c}: {reasons[c]}")

    return X.drop(columns=cols_to_drop, errors="ignore"), cols_to_drop

# Konservative Separation-Prüfung
X_clean, removed_separators = drop_perfect_separators_conservative(X_clean, y, min_group_n=5, min_group_frac=0.01, verbose=True)




# --------------------------
# 5) Logistische Regression 
# --------------------------
X_clean = sm.add_constant(X_clean.astype(float))
logit_model = sm.Logit(y, X_clean)
result = logit_model.fit(method = "bfgs", maxiter = 500)

print(result.summary())



# --------------------------
# 6) Odds Ratios + 95%-Konfidenzintervalle
# --------------------------
params = result.params
conf = result.conf_int()
odds_ratios = np.exp(params)
conf_int = np.exp(conf)

or_table = pd.DataFrame({
    "OR": odds_ratios,
    "2.5%": conf_int[0],
    "97.5%": conf_int[1],
    "p-value": result.pvalues
})
print("\n--- Odds Ratios mit Konfidenzintervallen ---")
print(or_table.sort_values("p-value", ascending=True))


