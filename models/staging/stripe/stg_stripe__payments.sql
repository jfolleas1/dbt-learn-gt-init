with source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        -- amount is stored in cents, convert it to dollars
        {{ cents_to_dollars("amount", 4) }} as amount,
        created,
        _batched_at

    from source

)

select * from renamed