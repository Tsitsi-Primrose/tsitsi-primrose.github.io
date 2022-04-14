with 

--if ticket is reopened after being resolved we get the last instance of it being open so we can find the soonest resolved date after this
last_open_instance as (

    select "Ticket Number",
            min("RowNum")   as "Min RowNum"
        FROM "dev"."dbt_freshdesk_staging"."stg_tickets"
        where "Status Id" not in (4,5)
        group by "Ticket Number"
),

first_response as (

    select "Ticket Number",
            min("Conversation DT")   as "Response DT"
        FROM "dev"."dbt_freshdesk_staging"."stg_conversations"
        group by "Ticket Number"
),

resolved_date as (

    select t."Ticket Number",
            min(t."Ticket Modified DT")   as "Resolved By DT"
        FROM "dev"."dbt_freshdesk_staging"."stg_tickets" t
        left join last_open_instance loi on t."Ticket Number" = loi."Ticket Number"
        where t."Status Id" in (4,5) and (t."RowNum" < loi."Min RowNum" or loi."Min RowNum" is null)
        group by t."Ticket Number"
),

reopened_flag_temp as (
        select t."Ticket Number",
                max(t."RowNum" )        as "RowNum" 
        FROM "dev"."dbt_freshdesk_staging"."stg_tickets" t
        where t."Status Id" in (4,5) 
        group by t."Ticket Number"
),

reopened_flag as (
        select t."Ticket Number",
                1 as "Flag Reopened"
        FROM reopened_flag_temp t
        left join last_open_instance loi on t."Ticket Number" = loi."Ticket Number"
        where t."RowNum" > loi."Min RowNum"
),

tickets as (
    
    SELECT 
            t."Ticket Number",
            t."Ticket Type",
            t."Contact Type",
            nvl(so."Source",cast(t."Source Id" as varchar))                     as "Source",
            t."Ticket Created DT",
            nvl(st."Status",cast(t."Status Id" as varchar))                     as "Ticket Status",
            case when t."Category" = '' then 'Not Assigned'
                else t."Category" end                                           as "Category",   
            t."Service", 
            nvl(g."Owner Team",'Not Assigned')                                  as "Owner Team",
            nvl(a."Owner", 'Not Assigned')                                      as "Owner",
            case when t."Brand" = '' then 'Not Assigned'
                else  t."Brand" end                                             as "Brand",  
            t."Order Number",
            case when t."SubCategory" = '' then 'Not Assigned'
                else  t."SubCategory"   end                                     as "SubCategory",
            t."Priority Id",
            nvl(p."Priority",cast(t."Priority Id" as varchar))                  as "Priority",
            t."Ticket Modified DT",
            case when t."Flag Open" = 0 then rd."Resolved By DT"   end          as "Resolved By DT",
            case when t."Flag Open" = 0 then cast(datediff(hour,t."Ticket Created DT",rd."Resolved By DT") as float)/24 end        as "Resolved Days",
            case when "Flag Open" = 0 then
                case when datediff(hour,t."Ticket Created DT",rd."Resolved By DT")<24 then 1 
                        else 0 end end                                          as "Flag <24 Hours Resolved",
            cast(datediff(hour,t."Ticket Created DT",fr."Response DT") as float)/24        as "Response Days",
            case when cast(datediff(hour,t."Ticket Created DT",fr."Response DT") as float)<2 then 1
                        else 0 end                                              as "Flag <2 Hours Responded",
            fr."Response DT",
            t."Open Days"                                                       as "Open Days",
	    
    case when floor("Open Days") = 0 then '< 24 Hours'
		 when floor("Open Days") = 1 then '1 Day'
		 when floor("Open Days") = 2 then '2 Days'
		 when floor("Open Days") = 3 then '3 Days'
		 when floor("Open Days") >3 and floor("Open Days") <10 then '4 - 10 Days'
		 when floor("Open Days") >=10 and floor("Open Days") <21 then '10 - 20 Days'
		 when floor("Open Days") >=21 and floor("Open Days") <42 then '21 - 42 Days'
		 else '> 42 Days' end
                        as "Open Days Age",	
	    
    case when floor("Open Days") = 0 then 1
		 when floor("Open Days") = 1 then 2
		 when floor("Open Days") = 2 then 3
		 when floor("Open Days") = 3 then 4
		 when floor("Open Days") >3 and floor("Open Days") <10 then 5
		 when floor("Open Days") >=10 and floor("Open Days") <21 then 6
		 when floor("Open Days") >=21 and floor("Open Days") <42 then 7
		 else 8 end
                        as "Open Days Age Sort",
            t."Flag Open",
            cast(t."Ticket Number" as varchar(50)) || '|FreshDesk'              as "EventLink",
            case when "Flag Reopened" is null then 0 
                else "Flag Reopened"    end                                     as "Flag Reopened",
            case when "Flag Reopened" = 1 then 'Reopened' 
                else 'Not Reopened'    end                                      as "Is Reopened",
            "Flag Ticket Deleted",            
            case when "Flag Ticket Deleted" =1 then 'Deleted'
                else 'Not Deleted'     end                                      as "Is Ticket Deleted"   ,
            "Flag Spam"
        FROM "dev"."dbt_freshdesk_staging"."stg_tickets" t
        left join "dev"."dbt_freshdesk_staging"."stg_agents" a on t."Owner Id" = a."Owner Id"
        left join "dev"."dbt_freshdesk_staging"."stg_groups" g on t."Owner Team Id" = g."Owner Team Id"
        left join "dev"."dbt_freshdesk_staging"."stg_priority" p on t."Priority Id" = p."Priority Id"
        left join "dev"."dbt_freshdesk_staging"."stg_source" so on t."Source Id" = so."Source Id"
        left join "dev"."dbt_freshdesk_staging"."stg_status" st on t."Status Id" = st."Status Id"
        left join resolved_date rd on t."Ticket Number" = rd."Ticket Number"
        left join reopened_flag rof on t."Ticket Number" = rof."Ticket Number"
        left join first_response fr on t."Ticket Number" = fr."Ticket Number"
        where t."RowNum"=1
)

select * from tickets