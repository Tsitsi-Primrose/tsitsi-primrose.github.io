with satisfactionratings as (
    
    SELECT agent_id                         as "Agent Id",
            dateadd(hour,2,created_at)      as "Survey DT",
            feedback                        as "Survey Feedback",
            id                              as "Survey Id",
            ratings_default_question        as "Satisfied with Resolution",
            ratings_question_101000037586   as "First Contact Resolution",
            ticket_id                       as "Ticket Number",
            dateadd(hour,2,updated_at)      as "Survey Modified DT",
            cast(ticket_id as varchar(50)) || '|FreshDesk'  as "EventLink"


    FROM "dev"."freshdeskstaging"."satisfactionratings"
),

final_table as (
    select *,
            ROW_NUMBER() OVER (PARTITION BY "Ticket Number" ORDER BY "Survey Modified DT" desc)    AS "RowNum"
        from satisfactionratings
)

select * from final_table