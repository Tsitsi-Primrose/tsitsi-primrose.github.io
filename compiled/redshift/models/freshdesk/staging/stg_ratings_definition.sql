with final_table as (

    select -103 as "Score", 'Very dissatisfied' as "Value", 'Negative' as "Sentiment"
    union all
    select -102 as "Score", 'Dissatisfied' as "Value", 'Negative' as "Sentiment"
    union all
    select 100 as "Score", 'Neutral' as "Value", 'Neutral' as "Sentiment"
    union all
    select 102 as "Score", 'Satisfied' as "Value", 'Positive' as "Sentiment"
    union all
    select 103 as "Score", 'Very satisfied' as "Value", 'Positive' as "Sentiment"

)

select * from final_table