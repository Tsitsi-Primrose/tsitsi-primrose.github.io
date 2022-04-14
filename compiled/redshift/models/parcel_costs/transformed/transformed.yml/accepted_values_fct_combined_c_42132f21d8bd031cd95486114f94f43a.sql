
    
    

with all_values as (

    select
        fulfillment_partner as value_field,
        count(*) as n_records

    from "dev"."dbt_parcel_costs"."fct_combined_costs"
    group by fulfillment_partner

)

select *
from all_values
where value_field not in (
    'RAM','RTT','OTD'
)


