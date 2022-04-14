WITH 
    ram_parcel_costs as(
    SELECT
        to_date("date", 'DD/MM/YYYY')                                                       as "date_dt",
        cast(to_char(to_timestamp(time::text, 'HH12:MI:SS am'), 'HH24:MI:SS') as time)      as time_dt,
        "consignment",
        "suburb a"                                                                          as suburb_a,
        "hub a"                                                                             as hub_a,
        "suburb b"                                                                          as suburb_b,
        "hub b"                                                                             as hub_b,
        area,
        parcels,
        weight,
        "vol weight"                                                                        as vol_weight,
        "charge kg"                                                                         as charge_kg,
        service,
        

   TRIM('R, ' FROM "basic rate")


                                        as basic_rate,
        

   TRIM('R, ' FROM "fuel surcharge")


                                    as fuel_surcharge,
        

   TRIM('R, ' FROM "waybill charge")


                                    as waybill_charge,
        

   TRIM('R, ' FROM "s surcharge")


                                       as s_surcharge,
        

   TRIM('R, ' FROM "saturday charge")


                                   as saturday_charge,
        

   TRIM('R, ' FROM "after hours charge")


                                as after_hours_charge,
        

   TRIM('R, ' FROM "armoured vehicle charge")


                           as armoured_vehicle_charge,
        

   TRIM('R, ' FROM "card assembly charge")


                              as card_assembly_charge,
        

   TRIM('R, ' FROM "township charge")


                                   as township_charge,
        

   TRIM('R, ' FROM "insured value")


                                     as insured_value,
        

   TRIM('R, ' FROM "sub total")


                                         as sub_total,
        

   TRIM('R, ' FROM vat)


                                                 as vat,
        

   TRIM('R, ' FROM total)


                                               as total,
        

   TRIM('R, ' FROM delivered)


                                           as delivered_dt
FROM
  
  "dev"."dbt_tsitsi"."ram_parcel_costs" 
)

SELECT * FROM ram_parcel_costs