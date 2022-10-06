{{
  config(
    materialized='table'
  )
}}

SELECT
	PRODUCT_ID,
	NAME,
	PRICE,
	INVENTORY
from {{source('greenery','products')}}