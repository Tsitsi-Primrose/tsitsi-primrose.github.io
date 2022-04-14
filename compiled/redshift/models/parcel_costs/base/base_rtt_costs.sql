WITH 
rtt_parcel_costs as
(
    SELECT
        client,
        cast("date" as date)                                              as date_dt,
        "carton number"                                                   as parcel_number,
        "sender suburb"                                                   as sender_suburb,
        "sender hub"                                                      as sender_hub,
        "sender area"                                                     as sender_area,
        "consignee suburb"                                                as consignee_suburb,
        "consignee hub"                                                   as consignee_hub,
        "consignee area"                                                  as consignee_area,
        area,
        "route",
        svl,
        "nr parcels"                                                      as nr_parcels, 
        "actual weight"                                                   as actual_weight,
        "volume weight"                                                   as volume_weight,
        "weight billed"                                                   as weight_billed,
        " min. chge "                                                     as "min_change",
        "add on kg"                                                       as add_on_kg,
        

   TRIM('R, ' FROM "rate/ kg")


                        as rate_per_kg,
        

   TRIM('R, ' FROM "rate charge")


                     as rate_charge,
        

   TRIM('R, ' FROM "outlying rate charge")


            as outlying_rate_charge,
        

   TRIM('R, ' FROM " subtotal ")


                      as subtotal,
        

   TRIM('R, ' FROM " fuel surcharge ")


                as fuel_surcharge,
        

   TRIM('R, ' FROM " total exclusive ")


               as total_exclusive,
        

   TRIM('R, ' FROM " vat ")


                           as vat,
        

   TRIM('R, ' FROM " total inclusive ")


               as total_inclusive
FROM
  
  "dev"."dbt_tsitsi"."one_stock_parcel_costs"
)
SELECT * FROM rtt_parcel_costs