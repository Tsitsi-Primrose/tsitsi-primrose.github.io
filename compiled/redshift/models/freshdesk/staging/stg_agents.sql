with agent as (

    select available        as "Flag Agent Available",
            contact_name    as "Owner",
            id              as "Owner Id"
        from "dev"."freshdeskstaging"."agents"
)

select * from agent