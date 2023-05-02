with
radiopharmaceutical as (
    select distinct case
        when "Injection_Radiopharmaceutical"::text = 'UMLS:C0439673' then 'Unknown'
        else "Injection_Radiopharmaceutical"::text
        end as "code_text"
    from
        {{ ref('OSIRIS_pivot_Injection') }}
),

contrastbolusagent as (
    select distinct case
        when "Injection_ContrastBolusAgent"::text = 'UMLS:C0439673' then 'Unknown'
        else "Injection_ContrastBolusAgent"::text
        end as "code_text"
    from
        {{ ref('OSIRIS_pivot_Injection') }}
),

union_medication as (
    select *
    from
        radiopharmaceutical
    union
    select *
    from
        contrastbolusagent
)

select
    *,
    'medication_identifier' || ROW_NUMBER() over () as id_medication
from
    union_medication
