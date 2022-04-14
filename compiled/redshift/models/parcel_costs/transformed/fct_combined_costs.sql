

WITH 
combined_data as 
(
SELECT 
    'OTD'                                           as fulfillment_partner,
    otd_costs.fulfillment_parcel_id                 as fulfillment_parcel_id,
    otd_costs.fulfillment_poa_date_part_dt          as fulfillment_start_date_dt,
    otd_costs.poa_month_dt                          as fulfillment_month_dt,
    otd_costs.poa_day_of_month_dt                   as fulfillment_day_of_month_dt,
    otd_costs.poa_day_of_week_dt                    as fulfillment_day_of_week,
    otd_costs.parcel_weight                         as parcel_weight,
    otd_costs.chargeout_excl                        as parcel_total_amount_excl,
    
    case
        when zone = 'LOCAL OUTLYING' then 'Outlying'
        when zone = 'MAIN OUTLYING' then 'Outlying'
        when zone = 'LOCAL' then 'Local'
        when zone = 'MAIN' then 'Main'
        when zone = 'L' then 'Local'
        when zone = 'M' then 'Main'
        when zone = 'Local' then 'Local'
        when zone = 'Local Township' then 'Local'
        when zone = 'Outlying' then 'Outlying'
        when zone = 'Main Township' then 'Main'
        when zone = 'Main Centre' then 'Main'
        when zone = 'Regional' then 'Regional'
        when zone = 'R' then 'Regional'
        when zone = 'Regional Township' then 'Regional'
        when zone = 'Remote' then 'Remote'
        else null end
                  as parcel_delivery_regulated_area,
    otd_costs.zone                                  as parcel_delivery_zone,
    otd_costs.number_of_items                       as number_of_items,
    otd_costs.cost_per_item                         as cost_per_item
FROM "dev"."dbt_parcel_costs"."fct_otd_costs" otd_costs

UNION
SELECT 
    'RAM'                                           as fulfillment_partner,
    ram_costs.consigment                            as fulfillment_parcel_id,
    ram_costs.fulfillment_start_date_dt             as fulfillment_start_date_dt,
    ram_costs.fulfillment_start_month_dt            as fulfillment_month_dt,
    ram_costs.fulfillment_start_day_of_month_dt     as fulfillment_day_of_month_dt,
    ram_costs.fulfillment_start_day_of_week_dt      as fulfillment_day_of_week,
    ram_costs.parcel_weight                         as parcel_weight,
    ram_costs.parcel_total                          as parcel_total_amount_excl,
    
    case
        when area = 'LOCAL OUTLYING' then 'Outlying'
        when area = 'MAIN OUTLYING' then 'Outlying'
        when area = 'LOCAL' then 'Local'
        when area = 'MAIN' then 'Main'
        when area = 'L' then 'Local'
        when area = 'M' then 'Main'
        when area = 'Local' then 'Local'
        when area = 'Local Township' then 'Local'
        when area = 'Outlying' then 'Outlying'
        when area = 'Main Township' then 'Main'
        when area = 'Main Centre' then 'Main'
        when area = 'Regional' then 'Regional'
        when area = 'R' then 'Regional'
        when area = 'Regional Township' then 'Regional'
        when area = 'Remote' then 'Remote'
        else null end
                  as parcel_delivery_regulated_area,
    ram_costs.area                                  as parcel_delivery_zone,
    ram_costs.number_of_items                       as number_of_items,
    ram_costs.cost_per_item                         as cost_per_item
FROM "dev"."dbt_parcel_costs"."fct_ram_costs" ram_costs
UNION
SELECT
    'RTT'                                           as fulfillment_partner,
    rtt_costs.one_stock_parcel_number               as fulfillment_parcel_id,
    rtt_costs.fulfillment_start_date_dt             as fulfillment_start_date_dt,
    rtt_costs.fulfillment_start_month_dt            as fulfillment_month_dt,
    rtt_costs.fulfillment_start_day_of_month_dt     as fulfillment_day_of_month_dt,
    rtt_costs.fulfillment_start_day_of_week_dt      as fulfillment_day_of_week,
    rtt_costs.parcel_actual_weight                  as parcel_weight,
    rtt_costs.parcel_total_inclusive                as parcel_total_amount_excl,
    
    case
        when area = 'LOCAL OUTLYING' then 'Outlying'
        when area = 'MAIN OUTLYING' then 'Outlying'
        when area = 'LOCAL' then 'Local'
        when area = 'MAIN' then 'Main'
        when area = 'L' then 'Local'
        when area = 'M' then 'Main'
        when area = 'Local' then 'Local'
        when area = 'Local Township' then 'Local'
        when area = 'Outlying' then 'Outlying'
        when area = 'Main Township' then 'Main'
        when area = 'Main Centre' then 'Main'
        when area = 'Regional' then 'Regional'
        when area = 'R' then 'Regional'
        when area = 'Regional Township' then 'Regional'
        when area = 'Remote' then 'Remote'
        else null end
                  as parcel_delivery_regulated_area,
    rtt_costs.area                                  as parcel_delivery_zone,
    rtt_costs.number_of_items                       as number_of_items,
    rtt_costs.cost_per_item                         as cost_per_item
  
FROM "dev"."dbt_parcel_costs"."fct_rtt_costs" rtt_costs

)

SELECT * FROM combined_data