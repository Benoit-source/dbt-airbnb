{% macro ensure_tags_and_apply(this) %}

  {# 1. Créer les tags si absents #}
  {% for tag in var('tags_to_create') %}
    {% do run_query("CREATE TAG IF NOT EXISTS " ~ this.database ~ '.' ~ this.schema ~ '.' ~ tag ~ "") %}
  {% endfor %}

  {# 2. Charger la config YAML #}
  {% set tags_yaml = fromyaml(var('table_tags')) %}
  {% set table_name = this.identifier %}

  {% if table_name in tags_yaml %}
    {% set meta = tags_yaml[table_name] %}
    {% set fq_table = '' ~ this.database ~ '.' ~ this.schema ~ '.' ~ this.identifier ~ '' %}

    {# Tags table #}
    {% if meta.business_owner %}
      {% do run_query("ALTER TABLE " ~ fq_table ~ " SET TAG " ~ this.database ~ '.' ~ this.schema ~ '.' "BUSINESS_OWNER = '" ~ meta.business_owner ~ "'") %}
    {% endif %}
    {% if meta.sensitivity_level %}
      {% do run_query("ALTER TABLE " ~ fq_table ~ " SET TAG " ~ this.database ~ '.' ~ this.schema ~ '.' "SENSITIVITY_LEVEL = '" ~ meta.sensitivity_level ~ "'") %}
    {% endif %}

    {# Tags colonnes #}
    {% for col_name, col_meta in meta.columns.items() %}
      {% set fq_col = '' ~ col_name ~ '' %}
      {% if col_meta.business_owner %}
        {% do run_query("ALTER TABLE " ~ fq_table ~ " MODIFY COLUMN " ~ fq_col ~ " SET TAG " ~ this.database ~ '.' ~ this.schema ~ '.' "BUSINESS_OWNER = '" ~ col_meta.business_owner ~ "'") %}
      {% endif %}
      {% if col_meta.sensitivity_level %}
        {% do run_query("ALTER TABLE " ~ fq_table ~ " MODIFY COLUMN " ~ fq_col ~ " SET TAG " ~ this.database ~ '.' ~ this.schema ~ '.' "SENSITIVITY_LEVEL = '" ~ col_meta.sensitivity_level ~ "'") %}
      {% endif %}
    {% endfor %}
  {% endif %}
{% endmacro %}
