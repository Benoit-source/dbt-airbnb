{% macro set_dmf_schedule(table_name, schedule) %}

ALTER TABLE {{ this }}
SET DATA_METRIC_SCHEDULE = '{{ schedule }}';

{% endmacro %}
