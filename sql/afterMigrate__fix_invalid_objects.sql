
    
    -- The content of the Oracle afterMigrate__fix_invalid_objects.sql file is a command that re-compiles any invalid database objects.
    -- This is required because objects such as procedures, which are managed in repeatable migrations, can have dependencies
    -- on other objects but Flyway runs all repeatable migrations in alphabetical order regardless of any dependencies.
    -- Therefore some objects may not be properly compiled after flyway migrate completes.
   
    BEGIN
      FOR cur_rec IN (SELECT owner,
                             object_name,
                             object_type,
                             DECODE(object_type, 'PACKAGE', 1, 'PACKAGE BODY', 2, 3) AS recompile_order
                      FROM all_objects
                      WHERE status != 'VALID'
                      ORDER BY recompile_order)
      LOOP
        BEGIN
          IF cur_rec.object_type = 'PACKAGE BODY' THEN
            EXECUTE IMMEDIATE 'ALTER PACKAGE "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE BODY';
          ElSE
            EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(cur_rec.object_type || ' : ' || cur_rec.owner || ' : ' || cur_rec.object_name || 'could not be compiled');
        END;
      END LOOP;
     END;