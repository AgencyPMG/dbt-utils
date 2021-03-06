
{% set columns = dbt_utils.get_column_values(ref('data_get_column_values'), 'field') %}


{% if target.type == 'snowflake' %}

select
    {% set columns = columns if columns is iterable else [] %}
    {% for column in columns -%}

        sum(case when field = '{{ column }}' then 1 else 0 end) as count_{{ column }}
        {%- if not loop.last %},{% endif -%}

    {%- endfor %}

from {{ ref('data_get_column_values') }}

{% else %}

select
    {% set columns = columns if columns is iterable else [] %}
    {% for column in columns -%}

        {{dbt_utils.safe_cast("sum(case when field = '" ~ column ~ "' then 1 else 0 end)", dbt_utils.type_string()) }} as count_{{ column }}
        {%- if not loop.last %},{% endif -%}

    {%- endfor %}

from {{ ref('data_get_column_values') }}

{% endif %}
