with tickets as (
    
    SELECT distinct
            "id"                                    as "Ticket Number",
            nvl("type",'Not Assigned')              as "Ticket Type",
            "source"                                as "Source Id",
            dateadd(hour,2,"created_at")            as "Ticket Created DT",
            "status"                                as "Status Id",    
            'Online Shopping'                       as "Service",
            "group_id"                              as "Owner Team Id",
            "responder_id"                          as "Owner Id",   
            priority                                as "Priority Id",
            dateadd(hour,2,"updated_at")            as "Ticket Modified DT",
	        case when "status" NOT in (4,5) then 1
		        else 0 end 							as "Flag Open",
            cast(datediff(hour,"created_at", getdate())as float)/24             as "Open Days",
            cast('Freshdesk' as varchar(11)) 	    as "Contact Type",
            json_extract_path_text(custom_fields, 'cf_order_number_'||2157727)    as "Order Number",
            json_extract_path_text(custom_fields, 'cf_brand_'||2157727)           as "Brand",
            json_extract_path_text(custom_fields, 'cf_query_type_'||2157727)      as "Category",
            json_extract_path_text(custom_fields, 'cf_category_'||2157727)        as "SubCategory",
            cast(deleted as integer)                as "Flag Ticket Deleted"   ,
            cast(spam as integer)                   as "Flag Spam"                      
    FROM "dev"."freshdeskstaging"."tickets"
    where "created_at" >= '2022-03-22 19:31:00' and "id"> 1037
),

final_table as (
    select *,
            ROW_NUMBER() OVER (PARTITION BY "Ticket Number" ORDER BY "Ticket Modified DT" desc, "Status Id" desc)    AS "RowNum"
        from tickets
)

select * from final_table

-- "Response Days"