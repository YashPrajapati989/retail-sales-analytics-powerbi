#05_customer_segmentation.py
import pandas as pd

rfm = pd.read_csv("data/processed/retail_rfm.csv")

rfm["RFM_Total"] = (
    rfm["R_Score"].astype(int) +
    rfm["F_Score"].astype(int) +
    rfm["M_Score"].astype(int)
)

def segment_customer(score):

    if score >= 13:
        return "Champions"

    elif score >= 11:
        return "Loyal Customers"

    elif score >= 9:
        return "Potential Loyalists"

    elif score >= 7:
        return "Need Attention"

    elif score >= 5:
        return "At Risk"

    else:
        return "Lost Customers"

rfm["Segment"] = rfm["RFM_Total"].apply(segment_customer)

print("\nCustomer Segments")

print(rfm["Segment"].value_counts())

rfm.to_csv(
    "data/processed/customer_segments.csv",
    index=False
)

print("\nCustomer Segments Saved")