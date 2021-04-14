echo off
echo Check for invalid objects

SET RG_DEVSCHEMA=%1
SET RG_TESTSCHEMA=%2
SET RG_PWD=%3
SET RG_SERVER=%4
SET RG_SID=%5
SET RG_DBFOLDER=%6
SET RG_SCO=%7

rem Set some defaults if nothing passed into batch file
IF "%RG_DEVSCHEMA%"=="" (
  SET RG_TESTSCHEMA=HR
  SET RG_PWD=Redgate1
  SET RG_SERVER=localhost
  SET RG_SID=XE
  SET RG_DBFOLDER=Database
  SET RG_SCO="C:\Program Files\Red Gate\Schema Compare for Oracle 4\sco.exe"
)

echo RG_DEVSCHEMA is:%RG_DEVSCHEMA%
echo RG_TESTSCHEMA is:%RG_TESTSCHEMA%
echo RG_PWD is:%RG_PWD%
echo RG_SERVER is:%RG_SERVER%
echo RG_SID is:%RG_SID%
echo RG_DBFOLDER is:%RG_DBFOLDER%
echo RG_SCO is:%RG_SCO%

rem Save the script that lists invalid objects to a file
echo SELECT 'Invalid Object', object_type, object_name FROM dba_objects WHERE status != 'VALID' AND owner = '%RG_TESTSCHEMA%' ORDER BY object_type; > get_invalid_objects.sql

rem Execute the script on the database
echo on
Call exit | sqlplus HR/Redgate1@localhost:1521/ci @get_invalid_objects.sql > _invalid_objects.txt
echo off

rem Type the output of the invalid objects query to the console
type _invalid_objects.txt

rem Now search for instances of "Invalid Object"
call find /c "Invalid Object" _invalid_objects.txt

for /f %%A in ('find /c "Invalid Object" ^< _invalid_objects.txt') do (
  if %%A == 0 (
    echo No Invalid Objects
    SET ERRORLEVEL=0
  ) else (
    echo Invalid Objects found
    SET ERRORLEVEL=1
  )
)


:END
EXIT /B %ERRORLEVEL%