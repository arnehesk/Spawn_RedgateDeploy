alter system set db_create_file_dest='C:/Oracle/oradata/ORCL/ACCEPTANCE';

alter pluggable database acceptance close immediate;
drop pluggable database acceptance including datafiles;
create pluggable database acceptance from production;
alter pluggable database acceptance open;
alter session set container=acceptance;
create user HR_DMSTATS identified by Redgate1;
GRANT DBA to HR_DMSTATS;
exit;