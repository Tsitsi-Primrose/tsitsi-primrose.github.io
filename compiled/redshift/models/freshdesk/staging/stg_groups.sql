with groups as (

    select description          as "Owner Team Description",
            name                as "Owner Team",
            group_type			as "Owner Team Type", 
            id                  as "Owner Team Id"
        from "dev"."freshdeskstaging"."groups"
)

select * from groups