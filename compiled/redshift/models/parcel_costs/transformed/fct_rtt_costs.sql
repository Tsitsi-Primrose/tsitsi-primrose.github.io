

WITH 
transformed_rtt_costs as 
(
    SELECT 
        transformed_one_stock_columns.parcel_number                         as one_stock_parcel_number,
        transformed_one_stock_columns.client                                as client,
        transformed_one_stock_columns.date_dt                               as fulfillment_start_date_dt,
        transformed_one_stock_columns.month_dt                              as fulfillment_start_month_dt,
        transformed_one_stock_columns.day_of_month_dt                       as fulfillment_start_day_of_month_dt,
        transformed_one_stock_columns.day_of_week_dt                        as fulfillment_start_day_of_week_dt,
        transformed_one_stock_columns.sender_hub                            as sender_hub,
        transformed_one_stock_columns.sender_area                           as sender_area,
        transformed_one_stock_columns.consignee_hub                         as consignee_hub,
        transformed_one_stock_columns.consignee_area                        as consignee_area,
        transformed_one_stock_columns.area                                  as area,
        transformed_one_stock_columns.route                                 as route,
        transformed_one_stock_columns.nr_parcels                            as nr_parcels,
        transformed_one_stock_columns.actual_weight                         as parcel_actual_weight,
        transformed_one_stock_columns.volume_weight                         as parcel_volume_weight,
        transformed_one_stock_columns.weight_billed                         as parcel_weight_billed,
        transformed_one_stock_columns.min_change                            as parcel_min_change,
        transformed_one_stock_columns.add_on_kg                             as parcel_add_on_kg,
        transformed_one_stock_columns.rate_per_kg                           as parcel_rate_per_kg,
        transformed_one_stock_columns.total_exclusive                       as parcel_total_exclusive,
        transformed_one_stock_columns.subtotal                              as parcel_subtotal,
        transformed_one_stock_columns.fuel_surcharge                        as parcel_fuel_surcharge,
        transformed_one_stock_columns.vat                                   as parcel_vat,
        transformed_one_stock_columns.total_inclusive                       as parcel_total_inclusive,
        item_order_details."parcel no"                                      as item_parcel_no,
        COUNT(item_order_details."parcel no")                               as number_of_items,
        (parcel_total_exclusive / number_of_items)::DECIMAL(10,2)           as cost_per_item

    FROM
  
        "dev"."dbt_parcel_costs_staging"."stg_rtt_costs" transformed_one_stock_columns
    JOIN 
        "dev"."exasol"."omni_orders_fct_order_item_details" item_order_details
    ON 
        item_order_details."parcel no" = transformed_one_stock_columns.parcel_number
 
    GROUP BY 
        one_stock_parcel_number, client, fulfillment_start_date_dt, fulfillment_start_month_dt, fulfillment_start_day_of_month_dt, fulfillment_start_day_of_week_dt,  
        sender_hub, sender_area, consignee_hub, consignee_area, area, route, nr_parcels, parcel_actual_weight, 
        parcel_volume_weight, parcel_weight_billed, parcel_min_change, parcel_add_on_kg, parcel_rate_per_kg, parcel_total_exclusive,
        parcel_subtotal, parcel_fuel_surcharge, parcel_vat, parcel_total_inclusive, item_parcel_no
)
SELECT * FROM transformed_rtt_costs