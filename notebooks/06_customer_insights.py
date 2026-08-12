#06_customer_insights.py
import pandas as pd

rfm = pd.read_csv("data/processed/customer_segments.csv")

print("="*70)
print("Customer Segment Insights")
print("="*70)

# Revenue by Segment

segment_revenue = (
    rfm.groupby("Segment")["Monetary"]
       .sum()
       .sort_values(ascending=False)
)

print("\nRevenue By Segment")
print(segment_revenue)

# Customers by Segment

segment_customers = (
    rfm["Segment"]
       .value_counts()
)

print("\nCustomers By Segment")
print(segment_customers)

# Average Revenue Per Customer

avg_revenue = (
    rfm.groupby("Segment")["Monetary"]
       .mean()
       .sort_values(ascending=False)
)

print("\nAverage Revenue Per Customer")
print(avg_revenue)