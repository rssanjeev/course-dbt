{{
  config(
    materialized='table'
  )
}}

SELECT
	ORDER_ID,
	PRODUCT_ID,
	QUANTITY
FROM {{source('greenery','order_items')}}