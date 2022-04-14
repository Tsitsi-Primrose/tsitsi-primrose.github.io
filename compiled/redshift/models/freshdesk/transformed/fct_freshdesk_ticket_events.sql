with

 prev_status as (

    select "Ticket Number",
            "Status Id",
            LAG("Status Id", 1)
                OVER (PARTITION BY "Ticket Number" ORDER BY rownum desc ) as PrevStatus,
            "Ticket Modified DT"
        FROM "dev"."dbt_freshdesk_staging"."stg_tickets"
        order by rownum

),

reopened_dates as (
    select "Ticket Number",
            "Ticket Modified DT"
        from prev_status
        where "Status Id" not in (4,5) and PrevStatus in (4,5)
),


Created as (

    SELECT
            'Created' AS "Event Type",
            "EventLink",
	        "Contact Type", 
            "Category",
            "SubCategory",
            "Service",
            "Source",
            "Brand",
            trunc("Ticket Created DT") as "DateKey",
            "Ticket Created DT"                                 as "Event DT",
            "EventLink" || '|'  || 'Created'                    as "Primary Key",
            "Flag Spam"
    FROM "dev"."dbt_freshdesk"."fct_freshdesk_tickets"
    where "Ticket Created DT" is not null
    ),

Resolved as (

    SELECT
            'Resolved' AS "Event Type",
            "EventLink",
	        "Contact Type",  
            "Category",
            "SubCategory",
            "Service",
            "Source",
            "Brand",
            trunc("Resolved By DT")    as "DateKey",
            "Resolved By DT"                                    as "Event DT",
            "EventLink" || '|'  || 'Resolved'                   as "Primary Key",
            "Flag Spam"
    FROM "dev"."dbt_freshdesk"."fct_freshdesk_tickets"
    where "Resolved By DT" is not null
    and "Ticket Status" IN ('Resolved', 'Cancelled', 'Closed')
    ),

 Reopened as (

    SELECT
            'Reopened'                                          AS "Event Type",
            fct."EventLink",
	        fct."Contact Type",  
            fct."Category",
            fct."SubCategory",
            fct."Service",
            fct."Source",
            fct."Brand",
            trunc(rd."Ticket Modified DT")                      as "DateKey",
            rd."Ticket Modified DT"                             as "Event DT",
            fct."EventLink" || '|'  || 'Reopened'               as "Primary Key",
            fct."Flag Spam"
    FROM "dev"."dbt_freshdesk"."fct_freshdesk_tickets" fct
    inner join reopened_dates rd on fct."Ticket Number" = rd."Ticket Number"
    where fct."Flag Reopened"=1
    ),



  Survey as (

    SELECT
            'Survey'                                         AS "Event Type",
            fct."EventLink",
	        fct."Contact Type",  
            fct."Category",
            fct."SubCategory",
            fct."Service",
            fct."Source",
            fct."Brand",
            trunc(rd."Survey DT")                           as "DateKey",
            rd."Survey DT"                                  as "Event DT",
            fct."EventLink" || '|'  || 'Survey'             as "Primary Key",
            fct."Flag Spam"
    FROM "dev"."dbt_freshdesk"."fct_freshdesk_tickets" fct
    inner join "dev"."dbt_freshdesk"."fct_satisfaction_ratings" rd on fct."Ticket Number" = rd."Ticket Number"
    ),





    final_table as (

        
       
	   

        select * from Created

        union all

    

        select * from Resolved

        union all

    

        select * from Reopened

        union all

    

        select * from Survey

        

    

    )

    select * from final_table