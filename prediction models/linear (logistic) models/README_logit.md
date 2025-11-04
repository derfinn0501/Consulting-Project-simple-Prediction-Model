### Zweck
Logistische Regression mit `statsmodels` mit Prädiktoren `X_*` auf das Ziel `P_chest_tube` (yes/no).

(`logit_prediction.py` war ein intialer Anlauf, bevor ich gemerkt hab, dass nicht-inferentiell funktioniert. Zur Dokumentation und als potenzielle Benchmark drin gelassen)

### Datenanforderungen
- CSV: `full_data_logit.csv` (Semikolon-separiert)
- Zielvariable: `P_chest_tube` mit Werten "yes"/"no"
- Prädiktoren: alle Spalten beginnend mit `X_`
- Spezielle numerische Scores: `X_ISS`, `X_RibScore`, `X_Elixhauser`, `X_TTSS`

Gegenüber full_data_cleaned.xlsx wurden in `full_data_logit.csv` folgende `X_*` Variablen gedroppt
- X_PTX_side und X_HTX_side
- X_known_preconditions 
- Alle preconditions, die in den Elixhauser eingehen 
- X_Horowitz_quotient rausgenommen, weil jeder zweite Patient da NaN hat 
- X_broken_ribs_6plus, X_bilaterial_rib_fractures, X_flail_chest, X_dislogged_ribs_3plus, X_fracture_first_rib, X_rib_fracture_every_region rausgeschmissen, weil die im RibScore enthalten sind und ihn als Linearkombination ergeben 
- X_max_AIS_* alle raus (werden im ISS wieder aufgegriffen -> Kollinearität)
- X_HTX_size_right, X_HTX_size_left raus weil bei fast allen not_applicable 
- X_antikoagulation_antiplatelet raus 
    - Einige seltene Unterkategorien 
    - Man möchte hier ja wahrscheinlich vor allem wissen welche Betäubungsmittel oder so man dem Patienten geben kann? Also für den konkreten Einsatz der Chest tube weniger ausschlaggebend 


### Pipeline (Kurzüberblick)
- Laden: CSV einlesen, Zeilen mit `not_available` oder `Nicht verfügbar` verwerfen.
- Typkonvertierung: obige Scores von Komma- zu Punktformat, in `float`.
- Missing Values: vollständige Zeilen mit NaNs droppen.
- Feature-Engineering:
  - Dummy-Kodierung aller kategorialen `X_*`-Variablen, Ref-Kategorie bevorzugt `not_applicable` oder `none` (sonst `drop_first=True`).
  - Reine numerische Variablen als `float` belassen.
  - Konstante Spalten entfernen.
  - Konservative Separation-Prüfung: 0/1-Dummies werden nur gedroppt, wenn (col==1) groß genug ist und strikt eine Outcome-Kategorie fehlt, während (col==0) beide Outcomes enthält.
- Modell:
  - `statsmodels.Logit` mit Konstante, Optimierer `bfgs`, `maxiter=500`.
- Ausgabe:
  - Modell-Summary.
  - Tabelle mit Odds Ratios, 95%-Konfidenzintervallen und p-Werten, nach p-Wert sortiert.

### Voraussetzungen
- Python 3.9+
- Pakete: `pandas`, `numpy`, `statsmodels`

### Ausführen
```bash
python log_inference.py
```

### Output-Beispiele
- Konsolen-Output mit `result.summary()`
- Konsolen-Output: OR-Tabelle inkl. 95%-KI und p-Werten

### Hinweise
- Der Datensatz wird durch Droppen von NaNs und „not_available“ verkleinert. Für mehr Power ggf. Imputation in Erwägung ziehen
    - Aktuel gehen 653 Datenpunkte ein (Verlust von ~40 Patienten)
- Die konservative Separation-Prüfung vermeidet falsches Entfernen seltener Dummies, kann aber bei extremen Imbalancen weiterhin Spalten droppen. Anpassbar via `min_group_n` und `min_group_frac`. 
    - Es wird ausgegeben, welche Spalten gedroppt wurden


