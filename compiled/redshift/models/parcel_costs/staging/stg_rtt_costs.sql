WITH 
staging_rtt_costs as 
(
    SELECT 
        client,
        "date_dt",
        EXTRACT(MONTH FROM "date_dt")                               as "month_dt",
        EXTRACT(DAY FROM "date_dt")                                 as "day_of_month_dt",
        EXTRACT(DAYOFWEEK from "date_dt")                           as "day_of_week_dt",
        parcel_number,
        sender_suburb,
        sender_hub,
        sender_area,
        consignee_suburb,
        consignee_hub,
        consignee_area,
        area,
        "route",
        svl,
        nr_parcels, 
        actual_weight,
        volume_weight,
        weight_billed,
        "min_change",
        add_on_kg,
        

    
     cast(rate_per_kg as DECIMAL(10,2))
    

                       as rate_per_kg,
        

    
     cast(rate_charge as DECIMAL(10,2))
    

                       as rate_charge,
        

    
     cast(total_exclusive as DECIMAL(10,2))
    

                   as total_exclusive,
        

    
     cast(outlying_rate_charge as DECIMAL(10,2))
    

              as outlying_rate_charge,
        

    
     cast(subtotal as DECIMAL(10,2))
    

                          as subtotal,
        

    
     cast(fuel_surcharge as DECIMAL(10,2))
    

                    as fuel_surcharge,
        

    
     cast(vat as DECIMAL(10,2))
    

                               as vat,
        

    
     cast(total_inclusive as DECIMAL(10,2))
    

                   as total_inclusive
    FROM 
        "dev"."dbt_parcel_costs_staging"."base_rtt_costs"
)
SELECT * FROM staging_rtt_costs