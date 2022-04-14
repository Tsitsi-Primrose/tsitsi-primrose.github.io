select 
    fulfillment_parcel_id,
    parcel_total_amount_excl
from "dev"."dbt_parcel_costs"."fct_combined_costs"
where (cost_per_item < 0)