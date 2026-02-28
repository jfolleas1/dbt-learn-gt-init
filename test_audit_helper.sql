----------------------------------------------------------
-- Compare row counts
----------------------------------------------------------

{% set old_relation = adapter.get_relation(
      database = "old_database",
      schema = "old_schema",
      identifier = "fct_orders"
) -%}

{% set dbt_relation = ref('fct_orders') %}

{{ audit_helper.compare_row_counts(
    a_relation = old_relation,
    b_relation = dbt_relation
) }}

----------------------------------------------------------
-- Compare all collumns
----------------------------------------------------------


{% set old_relation = adapter.get_relation(
      database = "old_database",
      schema = "old_schema",
      identifier = "fct_orders"
) -%}

{% set dbt_relation = ref('fct_orders') %}

{{ audit_helper.compare_all_columns(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key = "order_id"
) }}
