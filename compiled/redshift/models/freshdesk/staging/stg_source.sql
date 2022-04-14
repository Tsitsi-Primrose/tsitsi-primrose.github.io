with final_table as (

    select id                           as "Source Id",
            case when label = 'Phone' then 'Telephone'
                else label  end         as "Source"
            from"dev"."freshdeskstaging"."ticketsfields_source"
)

select * from final_table