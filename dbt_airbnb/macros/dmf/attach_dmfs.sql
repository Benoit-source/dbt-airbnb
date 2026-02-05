{% macro attach_dmfs(model_name, dmf_list) %}
  {% set target_table = ref(model_name) %}

  {% for dmf in dmf_list %}
    {% set col_param = "" %}
    {% if dmf.column is defined %}
      {% set col_param = ", PARAMETERS => OBJECT_CONSTRUCT('COLUMN','" ~ dmf.column ~ "')" %}
    {% endif %}

    {{ log("Attaching DMF " ~ dmf.dmf_name ~ " to model " ~ model_name ~ " column: " ~ (dmf.column | default("ALL")), info=True) }}
    
    {% do run_query("CALL SYSTEM$ATTACH_DMFS(TARGET_OBJECT => '" ~ target_table ~ "', DMF_NAME => '" ~ dmf.dmf_name ~ "'" ~ col_param ~ ");") %}
  {% endfor %}
{% endmacro %}
