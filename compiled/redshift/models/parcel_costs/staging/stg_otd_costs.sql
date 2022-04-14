WITH 
    base_otd_costs as( 
    SELECT
        shipment_id,                      
        parcel_id,                       
        poa_date_dt,  
        poa_date_part_dt,
        EXTRACT(MONTH FROM "poa_date_part_dt")                                                                      as "poa_month_dt",
        EXTRACT(DAY FROM "poa_date_part_dt")                                                                        as "poa_day_of_month_dt",
        EXTRACT(DAYOFWEEK from "poa_date_part_dt")                                                                  as "poa_day_of_week_dt",  
        poa_date_time_dt * 24                                                                                       as poa_hr,
        (poa_hr - floor(poa_hr)) * 60                                                                               as poa_min,
        (poa_min - floor(poa_min)) * 60                                                                             as poa_sec,
        concat(concat(concat(concat(cast(poa_hr as int),':'),cast(poa_min as int)),':'),cast(poa_sec as int))       as poa_time,
        poh_date_dt,    
        poh_date_part_dt,
        EXTRACT(MONTH FROM "poh_date_part_dt")                                                                      as "poh_month_dt",
        EXTRACT(DAY FROM "poh_date_part_dt")                                                                        as "poh_day_of_month_dt",
        EXTRACT(DAYOFWEEK from "poh_date_part_dt")                                                                  as "poh_day_of_week_dt", 
        poh_date_time_dt * 24                                                                                       as poh_hr,
        (poh_hr - floor(poh_hr)) * 60                                                                               as poh_min,
        (poh_min - floor(poh_min)) * 60                                                                             as poh_sec,
        concat(concat(concat(concat(cast(poh_hr as int),':'),cast(poh_min as int)),':'),cast(poh_sec as int))       as poh_time,
        primary_customer_id,               
        client,                         
        sender_name,                     
        "length",                        
        "width",                         
        "height",                        
        "weight",                        
        chargeable_mass,                 
        shipper_name,                     
        shipper,                        
        "service",                       
        "zone",                         
        

    
     cast(chargeout_excl as DECIMAL(10,2))
    

                                                                    as chargeout_excl,             
        shipment_name,                   
        shipment_country_id,  
        trunc(dateadd(d,cast(pod_date_dt as int),'1899-12-30'))                                                     as pod_date_dt,
        trunc(dateadd(d,cast(costing_date_dt as int),'1899-12-30'))                                                 as costing_date_dt,   
        client_site,                     
        order_number2,                   
        brand,                          
        total_brands,                 
        order_cat                      
    FROM
        "dev"."dbt_parcel_costs_staging"."base_otd_costs"
    )
SELECT * FROM base_otd_costs