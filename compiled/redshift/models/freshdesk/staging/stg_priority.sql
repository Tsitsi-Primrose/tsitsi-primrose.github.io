with 
final_table as (

    select value                as "Priority Id",
            label               as "Priority"
            from "dev"."freshdeskstaging"."ticketsfields_priority"
)

select * from final_table