
{{ config(materialized='table') }}

WITH AGG AS
(
SELECT 
YEAR(O_ORDERDATE) YR, MONTH(O_ORDERDATE) MNTH,SUM(O_TOTALPRICE) AMOUNT
FROM DB_DEV.RAW.ORDERS
WHERE O_ORDERSTATUS = 'O'
GROUP BY YEAR(O_ORDERDATE), MONTH(O_ORDERDATE)
)
SELECT * FROM AGG
ORDER BY YR,MNTH