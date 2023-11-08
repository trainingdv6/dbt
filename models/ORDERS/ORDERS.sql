{{ config(materialized='table') }}
with ORD as
(
select 
O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE, O_ORDERPRIORITY
from RAW.ORDERS
)
select * from ORD
