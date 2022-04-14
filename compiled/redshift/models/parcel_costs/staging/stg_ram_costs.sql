WITH 
staging_ram_costs as
(
    SELECT 
        "date_dt",
        EXTRACT(MONTH FROM "date_dt")                                       as "month_dt",
        EXTRACT(DAY FROM "date_dt")                                         as "day_of_month_dt",
        EXTRACT(DAYOFWEEK from "date_dt")                                   as "day_of_week_dt",
        "time_dt",
        "consignment",
        "suburb_a",
        "hub_a",
        "suburb_b",
        "hub_b",
        area,
        parcels,
        weight,
        "vol_weight",
        "charge_kg",
        service,
        

    
     cast(basic_rate as DECIMAL(10,2))
    

                                as basic_rate,
        

    
     cast(fuel_surcharge as DECIMAL(10,2))
    

                            as fuel_surcharge,
        

    
     cast(waybill_charge as DECIMAL(10,2))
    

                            as waybill_charge,
        

    
     cast(s_surcharge as DECIMAL(10,2))
    

                               as s_surcharge,
        

    
     cast(saturday_charge as DECIMAL(10,2))
    

                           as saturday_charge,
        

    
     cast(after_hours_charge as DECIMAL(10,2))
    

                        as after_hours_charge,
        

    
     cast(armoured_vehicle_charge as DECIMAL(10,2))
    

                   as armoured_vehicle_charge,
        

    
     cast(card_assembly_charge as DECIMAL(10,2))
    

                      as card_assembly_charge,
        

    
     cast(township_charge as DECIMAL(10,2))
    

                           as township_charge,
        

    
     cast(insured_value as DECIMAL(10,2))
    

                             as insured_value,
        

    
     cast(sub_total as DECIMAL(10,2))
    

                                 as sub_total,
        

    
     cast(vat as DECIMAL(10,2))
    

                                       as vat,
        

    
     cast(total as DECIMAL(10,2))
    

                                     as total,
        delivered_dt,
        to_date(delivered_dt, 'DD/MM/YYYY')                                 as delivered_date_dt,
        DATEDIFF(day, "date_dt", delivered_date_dt)                         as duration_of_fulfillment
    FROM 
        "dev"."dbt_parcel_costs_staging"."base_ram_costs"
)
SELECT * FROM staging_ram_costs