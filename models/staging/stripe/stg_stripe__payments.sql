with source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id,
        orderid,
        paymentmethod,
        status,
        -- amount is stored in cents, convert it to dollars
        amount / 100 as amount,
        created,
        _batched_at

    from source

)

select * from renamed