{% macro attach_all_dmfs() %}

{% set sql_commands = [] %}

{# Parcours de tous les tests du graph DBT #}
{% for node in graph.nodes.values() %}
    {% if node.resource_type == 'test' %}
        
        {% set test_name = node.test_metadata.name %}
        {% set model_ref = node.test_metadata.kwargs.model %}
        {% set column = node.test_metadata.kwargs.column_name %}
        
        {# 🔹 Ignorer les tests dynamiques get_where_subquery() #}
        {% if model_ref is string and 'get_where_subquery' in model_ref %}
            {% continue %}
        {% endif %}
        
        {# 🔹 Récupérer le modèle DBT réel (nom du fichier ou alias) #}
        {% if model_ref in graph.nodes %}
            {% set model_node = graph.nodes[model_ref] %}
            {% set table_physical = model_node.alias %}
        {% else %}
            {# fallback : utiliser directement le ref #}
            {% set table_physical = model_ref %}
        {% endif %}

        {# 🔹 Nom de la DMF #}
        {% if test_name in ['not_null','unique','accepted_values'] %}
            {% set dmf_function = "dmf_" ~ column ~ "_" ~ test_name ~ "()" %}
        {% else %}
            {% set dmf_function = "dmf_" ~ column ~ "_" ~ test_name ~ "()" %}
        {% endif %}

        {# 🔹 Commande ALTER TABLE #}
        {% do sql_commands.append("ALTER TABLE " ~ adapter.quote(table_physical) ~ " ADD DATA METRIC FUNCTION " ~ dmf_function ~ ";") %}

    {% endif %}
{% endfor %}

{# Exécution de toutes les commandes SQL #}
{% for cmd in sql_commands %}
    {{ log("Executing DMF command: " ~ cmd, info=True) }}
    {{ run_query(cmd) }}
{% endfor %}

{% endmacro %}
