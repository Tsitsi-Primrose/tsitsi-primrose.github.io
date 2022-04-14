select 
    number_of_items
from "dev"."dbt_parcel_costs"."fct_combined_costs"
where cost_per_item < 0