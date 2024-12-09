--=======================================================================================
-- c_header_log -> wk_que 
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2016.12.28 : F.Saitoh		: First Edition
-- Modify	: 
--=======================================================================================
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_01;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_02;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_03;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_04;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_05;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_06;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_07;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_08;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_09;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_10;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_11;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_12;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_13;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_14;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_15;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_16;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_17;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_18;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_19;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_20;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_21;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_22;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_23;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_24;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_25;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_26;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_27;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_28;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_29;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_30;
DROP TRIGGER if exists fnc_header_log_ins ON c_header_log_31;

DROP FUNCTION if exists fnc_header_log_ins ( );

CREATE FUNCTION fnc_header_log_ins ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		INSERT INTO wk_que(serial_no, pid, wk_step, endtime)
			SELECT new.serial_no, 0, 0, new.endtime;
		return new;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_01 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_02 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_03 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_04 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_05 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_06 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_07 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_08 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_09 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_10 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_11 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_12 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_13 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_14 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_15 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_16 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_17 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_18 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_19 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_20 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_21 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_22 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_23 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_24 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_25 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_26 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_27 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_28 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_29 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_30 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
CREATE TRIGGER     fnc_header_log_ins BEFORE insert ON c_header_log_31 FOR EACH ROW EXECUTE PROCEDURE fnc_header_log_ins ( );
