{% materialization dynamic_table, adapter='snowflake' %}

  {% set target_relation = this %}

  {% call statement('create_dynamic_table') %}
    CREATE OR REPLACE DYNAMIC TABLE {{ target_relation }}
    TARGET_LAG = '{{ config.get("target_lag") }}'
    WAREHOUSE = {{ config.get("warehouse") }}
    AS
    {{ sql }}
  {% endcall %}

  {{ apply_dmfs(target_relation) }}

  {{ return({'relations': [target_relation]}) }}

{% endmaterialization %}