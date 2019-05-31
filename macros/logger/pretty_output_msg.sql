{% macro pretty_output_msg(message) %}
{{ return( 10 * ' ' ~ '+ ' ~ dbt_utils.pretty_time() ~ ' | ' ~ message) }}

{% endmacro %}
