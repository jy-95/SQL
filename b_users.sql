col username format a25
col ACCOUNT_STATUS format a25
set linesize 120
set pagesize 25

select
username, ACCOUNT_STATUS
from dba_users; 