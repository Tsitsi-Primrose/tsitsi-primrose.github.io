

WITH 
order_items_with_costs as 
(
SELECT 
    fct_combined_costs.fulfillment_partner,
    fct_combined_costs.fulfillment_parcel_id,
    fct_combined_costs.fulfillment_start_date_dt,
    fct_combined_costs.fulfillment_month_dt,
    fct_combined_costs.fulfillment_day_of_month_dt,
    fct_combined_costs.fulfillment_day_of_week,
    fct_combined_costs.parcel_weight,
    fct_combined_costs.parcel_total_amount_excl,
    fct_combined_costs.parcel_delivery_regulated_area,
    fct_combined_costs.parcel_delivery_zone,
    fct_combined_costs.number_of_items,
    fct_combined_costs.cost_per_item,

    item_order_details."order item id",
    item_order_details."order no",
    item_order_details."order id",
    item_order_details."order type id",
    item_order_details."order type",
    item_order_details."allocation id",
    item_order_details."brand",
    item_order_details."brand id",
    item_order_details."operating division",
    item_order_details."order source",
    item_order_details."platform",
    item_order_details."device category",
    item_order_details."website",
    item_order_details."order item status",
    item_order_details."order item status id",
    item_order_details."order status",
    item_order_details."paid status",
    item_order_details."flag paid",
    item_order_details."sku",
    item_order_details."company id",
    item_order_details."product link",
    item_order_details."item type",
    item_order_details."payment types",
    item_order_details."flag staff order",
    item_order_details."is staff order",
    item_order_details."is ibt",
    item_order_details."flag ibt",
    item_order_details."is future order",
    item_order_details."flag future order",
    item_order_details."is furniture order",
    item_order_details."flag furniture order",
    item_order_details."is gift wrapped",
    item_order_details."is gift",
    item_order_details."is on gift registry",
    item_order_details."flag on gift registry",
    item_order_details."selling price orig",
    item_order_details."selling price act",
    item_order_details."selling price act (excl vat)",
    item_order_details."discount amount",
    item_order_details."sale type",
    item_order_details."vat",
    item_order_details."quantity",
    item_order_details."ff centre",
    item_order_details."fulfillment centre type id",
    item_order_details."otd vs os",
    item_order_details."tracking code",
    item_order_details."parcel no",
    item_order_details."has parcel no",
    item_order_details."flag parcel no",
    item_order_details."claim branch",
    item_order_details."is cancelled",
    item_order_details."flag cancelled",
    item_order_details."cancelled status",
    item_order_details."egs no",
    item_order_details."courier",
    item_order_details."size sku",
    item_order_details."service type",
    item_order_details."order dt",
    item_order_details."release dt",
    item_order_details."packed dt",
    item_order_details."response status",
    item_order_details."flag cnc order",
    item_order_details."is cnc order",
    item_order_details."shipping address line1",
    item_order_details."shipping address line2",
    item_order_details."shipping address postal code",
    item_order_details."shipping address city",
    item_order_details."shipping address latitude",
    item_order_details."shipping address longitude",
    item_order_details."shipping address region",
    item_order_details."shipping address province",
    item_order_details."fulfillment province",
    item_order_details."flag same fulfillment province",
    item_order_details."pup code",
    item_order_details."pup branch code",
    item_order_details."flag cnc brand match",
    item_order_details."delivery option",
    item_order_details."flag os size active",
    item_order_details."is os size active",
    item_order_details."flag return",
    item_order_details."return code",
    item_order_details."cancel dt",
    item_order_details."return reason",
    item_order_details."return dt",
    item_order_details."return transaction number",
    item_order_details."refund processed",
    item_order_details."allow refund",
    item_order_details."merchandise type",
    item_order_details."merchandise category",
    item_order_details."paid dt",
    item_order_details."courier fulfillment status",
    item_order_details."customer mobile",
    item_order_details."customer email",
    item_order_details."customer name",
    item_order_details."guest checkout",
    item_order_details."flag guest checkout",
    item_order_details."on manifest dt",
    item_order_details."courier notified dt",
    item_order_details."courier handed over dt",
    item_order_details."courier out on delivery dt",
    item_order_details."client missed courier dt",
    item_order_details."courier delivered dt",
    item_order_details."cnc arrived dt",
    item_order_details."cnc ready for collection dt",
    item_order_details."cnc customer collected dt",
    item_order_details."cnc customer failed collection dt",
    item_order_details."claim sent dt",
    item_order_details."claimed dt",
    item_order_details."is delivered",
    item_order_details."flag delivered",
    item_order_details."is courier delivered",
    item_order_details."flag courier delivered",
    item_order_details."is dispatched",
    item_order_details."flag dispatched",
    item_order_details."is packed",
    item_order_details."flag packed",
    item_order_details."cnc status",
    item_order_details."flag cnc missing ready date",
    item_order_details."order aging end dt adj",
    item_order_details."order aging courier end dt adj",
    item_order_details."delivery status",
    item_order_details."order placed to customer wd",
    item_order_details."order placed to customer cd",
    item_order_details."order placed to delivered wd",
    item_order_details."order placed to delivered cd",
    item_order_details."courier notified to h/o wd",
    item_order_details."courier notified to h/o cd",
    item_order_details."courier h/o to customer wd",
    item_order_details."courier h/o to customer cd",
    item_order_details."courier h/o to delivered wd",
    item_order_details."courier h/o to delivered cd",
    item_order_details."packed date to customer wd",
    item_order_details."packed date to delivered wd",
    item_order_details."packed date to delivered cd",
    item_order_details."arrived at pup to ready for collectiondt wd",
    item_order_details."arrived at pup to ready for collectiondt cd",
    item_order_details."paid to packed wd",
    item_order_details."paid to pack cd",
    item_order_details."cnc ready to collected wd",
    item_order_details."cnc ready to collected cd",
    item_order_details."cnc arrived to ready hr",
    item_order_details."cnc arrived to ready hr bins",
    item_order_details."cnc ready to collected wd bins",
    item_order_details."cnc ready to collected cd bins",
    item_order_details."order placed to customer cd bins",
    item_order_details."order placed to customer wd bins",
    item_order_details."courier notified to h/o wd bins",
    item_order_details."courier notified to h/o cd bins",
    item_order_details."courier h/o to delivered wd bins",
    item_order_details."courier h/o to delivered cd bins",
    item_order_details."customer 5wd sla",
    item_order_details."customer 5cd sla",
    item_order_details."courier 3wd sla"
FROM "dev"."exasol"."omni_orders_fct_order_item_details" item_order_details

LEFT OUTER JOIN "dev"."dbt_parcel_costs"."fct_combined_costs" fct_combined_costs

ON 
fct_combined_costs.fulfillment_parcel_id = item_order_details."parcel no"

)

SELECT * FROM order_items_with_costs