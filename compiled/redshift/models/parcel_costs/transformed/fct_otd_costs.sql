

WITH 
transformed_otd_costs as 
(
    SELECT
        transformed_otd_costs.shipment_id                                                                   as fulfillment_shipment_id,
        transformed_otd_costs.parcel_id                                                                     as fulfillment_parcel_id,
        transformed_otd_costs.poa_date_dt                                                                   as fulfillment_poa_date_dt,
        transformed_otd_costs.poa_date_part_dt                                                              as fulfillment_poa_date_part_dt,
        cast(transformed_otd_costs.poa_time as time)                                                        as fulfillment_poa_time_dt,
        cast(transformed_otd_costs.poh_time as time)                                                        as fulfillment_poh_time_dt,
        transformed_otd_costs.poa_month_dt                                                                  as poa_month_dt,
        transformed_otd_costs.poa_day_of_month_dt                                                           as poa_day_of_month_dt,
        transformed_otd_costs.poa_day_of_week_dt                                                            as poa_day_of_week_dt,   
        transformed_otd_costs.poh_date_dt                                                                   as fulfillment_poh_date_dt,
        transformed_otd_costs.poh_date_part_dt                                                              as fulfillment_poh_date_part_dt,
        transformed_otd_costs.poh_month_dt                                                                  as poh_month_dt,
        transformed_otd_costs.poh_day_of_month_dt                                                           as poh_day_of_month_dt,
        transformed_otd_costs.poh_day_of_week_dt                                                            as poh_day_of_week_dt,
        transformed_otd_costs.primary_customer_id                                                           as fulfillment_primary_customer_id,
        transformed_otd_costs.client                                                                        as client,
        transformed_otd_costs.sender_name                                                                   as sender_name,
        transformed_otd_costs.weight                                                                        as parcel_weight,
        transformed_otd_costs.length                                                                        as parcel_length,
        transformed_otd_costs.width                                                                         as parcel_width,
        transformed_otd_costs.height                                                                        as parcel_height,
        transformed_otd_costs.chargeable_mass                                                               as parcel_chargeable_mass,
        transformed_otd_costs.shipper_name                                                                  as shipper_name,
        transformed_otd_costs.shipper                                                                       as shipper,
        transformed_otd_costs.service                                                                       as service,
        transformed_otd_costs.zone                                                                          as zone,
        transformed_otd_costs.chargeout_excl                                                                as chargeout_excl,
        transformed_otd_costs.shipment_name                                                                 as shipment_name,
        transformed_otd_costs.shipment_country_id                                                           as shipment_country_id,
        transformed_otd_costs.pod_date_dt                                                                   as pod_date_dt,
        transformed_otd_costs.costing_date_dt                                                               as costing_date_dt,
        transformed_otd_costs.client_site                                                                   as client_site,
        transformed_otd_costs.order_number2                                                                 as order_number2,
        transformed_otd_costs.brand                                                                         as parcel_brand,
        transformed_otd_costs.total_brands                                                                  as total_brands,
        transformed_otd_costs.order_cat                                                                     as order_cat,
        DATEDIFF(day, transformed_otd_costs."poa_date_part_dt", transformed_otd_costs.pod_date_dt)          as duration_of_fulfillment,  
        item_order_details."parcel no"                                                                      as parcel_no,
        COUNT(item_order_details."parcel no")                                                               as number_of_items,
        (chargeout_excl / number_of_items)::DECIMAL(10,2)                                                   as cost_per_item
    FROM
        "dev"."dbt_parcel_costs_staging"."stg_otd_costs" transformed_otd_costs
    JOIN 
        "dev"."exasol"."omni_orders_fct_order_item_details" item_order_details
    ON 
        item_order_details."parcel no" = parcel_id
    GROUP BY 
        fulfillment_shipment_id, fulfillment_parcel_id, fulfillment_poa_date_dt, fulfillment_poa_date_part_dt, fulfillment_poh_date_part_dt, fulfillment_poh_date_dt, poa_month_dt, poh_month_dt, 
        poa_day_of_month_dt, fulfillment_poa_time_dt, fulfillment_poh_time_dt, poh_day_of_month_dt, poa_day_of_week_dt, poh_day_of_week_dt, fulfillment_primary_customer_id, client, 
        sender_name, parcel_weight, parcel_length, parcel_width, parcel_height, parcel_chargeable_mass, shipper_name, 
        shipper, service, zone, chargeout_excl, shipment_name, shipment_country_id, pod_date_dt,costing_date_dt,
        client_site, order_number2, parcel_brand, total_brands,  order_cat, duration_of_fulfillment, parcel_no

)
SELECT * FROM transformed_otd_costs