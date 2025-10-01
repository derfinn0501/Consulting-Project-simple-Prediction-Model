from numpy import column_stack
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.impute import SimpleImputer


# load data
data = pd.read_csv("/Users/maxbur/Desktop/full_data_cleaned.csv", sep = ";") 
data = data[~data["P_chest_tube"].isin(["not_applicable", "not_available"])] ## entfernt die drei Patienten, bei denen Chest tube not_applicable ist


# define target and predictors
y = data["P_chest_tube"]
X = data[[col for col in data.columns if col.startswith("X")]]

# separate numerical and categorical features
numeric_features = X.select_dtypes(include = ["int64", "float64"]).columns
categorical_features = X.select_dtypes(include = ["object"]).columns

# pre-processing 
numeric_transformer = Pipeline(steps = [
    ("imputer", SimpleImputer(strategy = "median")), ##imputer bis die missing values ersetzt sind
    ("scalar", StandardScaler())
])
categorical_transformer = Pipeline(steps = [
    ("imputer", SimpleImputer(strategy = "most_frequent")),
    ("encoder", OneHotEncoder(handle_unknown = "ignore"))
])

preprocessor = ColumnTransformer(
    transformers = [
        ("numeric", numeric_transformer, numeric_features),
        ("categorical", categorical_transformer, categorical_features)
])

# model pipeline 
model = Pipeline(
    steps = [
        ("preprocessor", preprocessor),
        ("classifier", LogisticRegression(max_iter = 1000, class_weight = "balanced", random_state = 3))
    ])

# train- & test sets 
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 42)

# train model and predict
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))


