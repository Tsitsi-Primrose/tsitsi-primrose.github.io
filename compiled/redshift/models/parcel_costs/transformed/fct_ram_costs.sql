

WITH 
transformed_ram_costs as 
(   
    SELECT 
        transformed_ram_costs.date_dt                                   as fulfillment_start_date_dt,
        transformed_ram_costs.month_dt                                  as fulfillment_start_month_dt,
        transformed_ram_costs.day_of_month_dt                           as fulfillment_start_day_of_month_dt,
        transformed_ram_costs.day_of_week_dt                            as fulfillment_start_day_of_week_dt,
        transformed_ram_costs.time_dt                                   as fulfillment_start_time_dt,
        transformed_ram_costs.consignment                               as consigment,
        transformed_ram_costs.hub_a                                     as hub_a,
        transformed_ram_costs.hub_b                                     as hub_b,
        transformed_ram_costs.area                                      as area,
        transformed_ram_costs.parcels                                   as number_of_parcels,
        transformed_ram_costs.weight                                    as parcel_weight,
        transformed_ram_costs.vol_weight                                as parcel_vol_weight,
        transformed_ram_costs.charge_kg                                 as parcel_charge_kg,
        transformed_ram_costs.service                                   as service,
        transformed_ram_costs.basic_rate                                as parcel_basic_rate,
        transformed_ram_costs.fuel_surcharge                            as parcel_fuel_surcharge,
        transformed_ram_costs.s_surcharge                               as parcel_s_surcharge,
        transformed_ram_costs.township_charge                           as parcel_township_charge,
        transformed_ram_costs.sub_total                                 as parcel_sub_total,
        transformed_ram_costs.vat                                       as parcel_vat,
        transformed_ram_costs.total                                     as parcel_total,
        transformed_ram_costs.date_dt                                   as parcel_delivery_date_dt,
        transformed_ram_costs.duration_of_fulfillment                   as duration_of_fulfillment,
        item_order_details."parcel no"                                  as parcel_no,
        COUNT(item_order_details."parcel no")                           as number_of_items,
        (parcel_sub_total / number_of_items)::DECIMAL(10,2)             as cost_per_item
    FROM
        "dev"."dbt_parcel_costs_staging"."stg_ram_costs" transformed_ram_costs
    JOIN 
        "dev"."exasol"."omni_orders_fct_order_item_details" item_order_details
    ON 
        item_order_details."parcel no" = consignment
    GROUP BY 
        fulfillment_start_date_dt, fulfillment_start_month_dt, fulfillment_start_day_of_month_dt, fulfillment_start_day_of_week_dt, fulfillment_start_time_dt, consignment, 
        hub_a, hub_b, area, number_of_parcels, parcel_weight, parcel_vol_weight, parcel_charge_kg, 
        service, parcel_basic_rate, parcel_fuel_surcharge, parcel_s_surcharge, parcel_township_charge, parcel_sub_total, parcel_vat,
        parcel_total, parcel_delivery_date_dt, duration_of_fulfillment, parcel_no

)
SELECT * FROM transformed_ram_costs