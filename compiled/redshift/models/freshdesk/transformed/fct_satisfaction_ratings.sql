with 


satisfaction_ratings as (
    
    SELECT 
            t."Survey DT",
            t."Survey Feedback",
            "Satisfied with Resolution"                 as "Satisfied with Resolution Score",
            ard.Value                                   as "Satisfied with Resolution",
            ard.Sentiment                               as "Satisfied with Resolution Sentiment",
            "First Contact Resolution"                  as "First Contact Resolution Score",
            case when "First Contact Resolution"=-103 then 'No'  
               else case when "First Contact Resolution"=103   then 'Yes' end end as "First Contact Resolution",
            t."Survey Id",
            t."Ticket Number",
            nvl(a."Owner", 'Not Assigned')              as "Owner",
            "EventLink"

        FROM "dev"."dbt_freshdesk_staging"."stg_satisfaction_ratings" t
        left join "dev"."dbt_freshdesk_staging"."stg_agents" a on t."Agent Id" = a."Owner Id"
        left join "dev"."dbt_freshdesk_staging"."stg_ratings_definition" ard on t."Satisfied with Resolution" = ard.Score
        left join "dev"."dbt_freshdesk_staging"."stg_ratings_definition" ard2 on t."First Contact Resolution" = ard2.Score
        where t."RowNum"=1
)

select * from satisfaction_ratings