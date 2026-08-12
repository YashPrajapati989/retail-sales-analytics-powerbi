import pandas as pd

print("="*70)
print("Loading Dataset")
print("="*70)

file_path = "online_retail_II.xlsx"
xls = pd.ExcelFile(file_path)

print("\nSheets:")
print(xls.sheet_names)

df1 = pd.read_excel(file_path, sheet_name=0)
df2 = pd.read_excel(file_path, sheet_name=1)

df = pd.concat([df1, df2], ignore_index=True)

print("\nDataset Shape")
print(df.shape)

print("\nColumns")
print(df.columns.tolist())

print("\nData Types")
print(df.dtypes)

print("\nMissing Values")
print(df.isnull().sum())

print("\nDuplicate Rows")
print(df.duplicated().sum())

print("\nSample Data")
print(df.head())

print("\nDate Range")
print(df["InvoiceDate"].min())
print(df["InvoiceDate"].max())

print("\nUnique Customers")
print(df["Customer ID"].nunique())

print("\nUnique Products")
print(df["StockCode"].nunique())

print("\nCountries")
print(df["Country"].nunique())

print("\nTop Countries")
print(df["Country"].value_counts().head(10))
