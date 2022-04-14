select 
    fulfillment_parcel_id,
    cost_per_item
from "dev"."dbt_parcel_costs"."fct_combined_costs"
where (cost_per_item < 0)