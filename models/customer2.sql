{{ config(materialized='ephimeral') }}
select 
C_CUSTKEY, C_NAME, C_ADDRESS, C_NATIONKEY, C_PHONE, C_ACCTBAL
from RAW.CUSTOMER