with final_table as (

    select id                   as "Status Id",
            label               as "Status"
            from "dev"."freshdeskstaging"."ticketsfields_status"
)

select * from final_table