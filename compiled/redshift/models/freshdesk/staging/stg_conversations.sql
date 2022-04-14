with conversations as (

    select distinct "body_text"           as "Conversation Text",
            "id"                          as "Conversation Id",
            "from_email"			      as "Conversation From Email", 
            "ticket_id"                   as "Ticket Number",
            dateadd(hour,2,"created_at")  as "Conversation DT"
        from "dev"."freshdeskstaging"."conversations"
)

select * from conversations