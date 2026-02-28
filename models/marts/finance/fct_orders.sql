{{
    config(
        materialized='incremental',
        unique_key = 'order_id',
        incremental_strategy = 'merge',
    )
}} 

with final as(
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        payments.amount

    from {{ ref('stg_jaffle_shop__orders')}} as orders

    left join {{ ref('stg_stripe__payments')}} as payments using (order_id)
)

select * from final 
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date >= (select max(this.order_date) from {{ this }} AS this) 
{% endif %}