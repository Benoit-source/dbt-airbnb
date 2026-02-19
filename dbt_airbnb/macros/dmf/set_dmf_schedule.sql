{% macro set_dmf_schedule(table_name, schedule) %}

ALTER TABLE {{ this.database }}.{{ this.schema }}.{{ table_name }}
SET DATA_METRIC_SCHEDULE = '{{ schedule }}';

{% endmacro %}
