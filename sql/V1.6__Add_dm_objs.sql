
CREATE OR REPLACE FUNCTION hr.DMORAND(seedVal IN  VARCHAR2) RETURN NUMBER IS BEGIN dbms_random.seed(seedVal); RETURN dbms_random.VALUE(); END;
/

CREATE OR REPLACE TYPE hr.DMO_RIDTYPE AS OBJECT (rid VARCHAR2(100))
/

CREATE OR REPLACE TYPE hr.DMO_RIDTYPE_TAB IS TABLE OF DMO_RIDTYPE
/

