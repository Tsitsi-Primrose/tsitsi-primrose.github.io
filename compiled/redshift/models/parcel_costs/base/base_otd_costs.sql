WITH 
    otd_parcel_costs as( 
    SELECT
        shipmentid                                                                      as shipment_id,
        parcelid                                                                        as parcel_id,
        poadate                                                                         as poa_date_dt,
        trunc(dateadd(d, cast(split_part(poa_date_dt, '.', 1) as int), '1899-12-30'))   as poa_date_part_dt,
        cast(concat('0.', split_part(poa_date_dt, '.', 2)) as numeric(17,5))            as poa_date_time_dt,
        pohdate                                                                         as poh_date_dt,
        trunc(dateadd(d, cast(split_part(poh_date_dt, '.', 1) as int), '1899-12-30'))   as poh_date_part_dt,
        cast(concat('0.',split_part(poh_date_dt, '.', 2)) as numeric(17,5))             as poh_date_time_dt,
        primarycustomerid                                                               as primary_customer_id,
        client                                                                          as client,
        "sender name"                                                                   as sender_name,
        "length"                                                                        as "length",
        "width"                                                                         as "width",
        "height"                                                                        as "height",
        "weight"                                                                        as "weight",
        chargeablemass                                                                  as chargeable_mass,
        shippername                                                                     as shipper_name,
        shipper                                                                         as shipper,
        "service"                                                                       as "service",
        "zone"                                                                          as "zone",
        "chargeout excl"                                                                as chargeout_excl,
        shipmentname                                                                    as shipment_name,
        shipmentcountryid                                                               as shipment_country_id,
        poddate                                                                         as pod_date_dt,
        clientsite                                                                      as client_site,
        costingdate                                                                     as costing_date_dt,
        order_number2                                                                   as order_number2,
        brand                                                                           as brand,
        total_brands                                                                    as total_brands,
        order_cat                                                                       as order_cat
    FROM
        "dev"."dbt_tsitsi"."otd_parcel_costs"
    )
SELECT * FROM otd_parcel_costs