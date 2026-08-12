#04_rfm_analysis.py
import pandas as pd
from datetime import timedelta

print("=" * 70)
print("RFM Analysis")
print("=" * 70)

df = pd.read_csv(
    "data/processed/retail_clean.csv",
    parse_dates=["InvoiceDate"]
)

# -------------------------
# Snapshot Date
# -------------------------

snapshot_date = df["InvoiceDate"].max() + timedelta(days=1)

print("\nSnapshot Date:", snapshot_date)

# -------------------------
# Build RFM Table
# -------------------------

rfm = df.groupby("Customer ID").agg({
    "InvoiceDate": lambda x: (snapshot_date - x.max()).days,
    "Invoice": "nunique",
    "Revenue": "sum"
})

rfm.columns = [
    "Recency",
    "Frequency",
    "Monetary"
]

# -------------------------
# RFM Scores
# -------------------------

rfm["R_Score"] = pd.qcut(
    rfm["Recency"],
    5,
    labels=[5,4,3,2,1]
)

rfm["F_Score"] = pd.qcut(
    rfm["Frequency"].rank(method="first"),
    5,
    labels=[1,2,3,4,5]
)

rfm["M_Score"] = pd.qcut(
    rfm["Monetary"],
    5,
    labels=[1,2,3,4,5]
)

rfm["RFM_Score"] = (
    rfm["R_Score"].astype(str) +
    rfm["F_Score"].astype(str) +
    rfm["M_Score"].astype(str)
)

print("\nRFM Table Created")

print(rfm.head())

rfm.to_csv(
    "data/processed/retail_rfm.csv"
)

print("\nSaved: retail_rfm.csv")