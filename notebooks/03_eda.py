#03_eda.py
import pandas as pd

print("="*70)
print("Retail Customer Analytics - EDA")
print("="*70)

df = pd.read_csv(
    "data/processed/retail_clean.csv",
    parse_dates=["InvoiceDate"]
)

print("\nDataset Shape")
print(df.shape)

# ---------------------
# KPIs
# ---------------------

total_revenue = df["Revenue"].sum()

total_orders = df["Invoice"].nunique()

total_customers = df["Customer ID"].nunique()

total_products = df["StockCode"].nunique()

print("\nKPI Summary")

print(f"Total Revenue     : £{total_revenue:,.2f}")
print(f"Total Orders      : {total_orders:,}")
print(f"Total Customers   : {total_customers:,}")
print(f"Total Products    : {total_products:,}")

# ---------------------
# Top Countries
# ---------------------

print("\nTop Countries by Revenue")

top_countries = (
    df.groupby("Country")["Revenue"]
      .sum()
      .sort_values(ascending=False)
      .head(10)
)

print(top_countries)

# ---------------------
# Top Products
# ---------------------

print("\nTop Products by Revenue")

top_products = (
    df.groupby("Description")["Revenue"]
      .sum()
      .sort_values(ascending=False)
      .head(10)
)

print(top_products)

# ---------------------
# Monthly Revenue
# ---------------------

df["YearMonth"] = df["InvoiceDate"].dt.to_period("M")

monthly_revenue = (
    df.groupby("YearMonth")["Revenue"]
      .sum()
      .sort_index()
)

print("\nMonthly Revenue Trend")

print(monthly_revenue.head())

# ---------------------
# Top Customers
# ---------------------

print("\nTop Customers by Revenue")

top_customers = (
    df.groupby("Customer ID")["Revenue"]
      .sum()
      .sort_values(ascending=False)
      .head(10)
)

print(top_customers)