-- PL/SQL Text

CREATE OR REPLACE PROCEDURE hr.GET_CONTACTS( p_rc OUT SYS_REFCURSOR )
AS
BEGIN
  OPEN p_rc FOR
  SELECT * FROM CONTACTS;
  -- SELECT FIRST_NAME, LAST_NAME, EMAIL FROM CONTACTS;
END;
/