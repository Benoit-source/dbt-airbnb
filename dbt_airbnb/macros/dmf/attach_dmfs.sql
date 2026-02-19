{% macro attach_dmfs(dmfs) %}

{% for dmf in dmfs %}
ALTER TABLE {{ this }}
ADD DATA METRIC FUNCTION {{ dmf.name }}
ON ({{ dmf.column }});
{% endfor %}

{% endmacro %}
