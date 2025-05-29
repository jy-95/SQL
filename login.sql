set linesize 150
set pagesize 40

col dno format 9999
col eno format 9999
col fname format a15
col ename format a20
col year_sal format a20 
col job format a10
col email format a30

sho user
select count(tname) as number_of_tables from tab;
