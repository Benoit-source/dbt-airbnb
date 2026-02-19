{% macro set_dmf_schedule(schedule) %}

ALTER TABLE {{ this }}
SET DATA_METRIC_SCHEDULE = '{{ schedule }}';

{% endmacro %}
