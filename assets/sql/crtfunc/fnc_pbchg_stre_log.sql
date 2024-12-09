--=======================================================================================
-- c_pbchg_log_01 to pbchg_balance_tbl update PL/PGSQL TRIGGER Function
--
------------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2010.Jan.13 : F.Saitoh : First Edition
-- Modify	: 2010.Mar.03 : F.Saitoh : Modify charge1
--              : 2018/05/10  : F.Fujibayashi : WHERE 'stre_cd' ADD
--              : 2018/05/16  : F.Fujibayashi : WHERE 'stre_cd' DELETE
--              : 2018/10/15  : F.Fujibayashi : WHERE 'stre_cd' ADD
--              : 2021/10/07  : T.Saito       : 記述を更新
--========================================================================================

DROP TRIGGER if exists fnc_pbchg_log_i ON c_pbchg_log_01;
DROP FUNCTION if exists fnc_pbchg_log_i ( );
CREATE FUNCTION fnc_pbchg_log_i ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
-- 2010/03/03
-- RAISE NOTICE ''settlestatus:%'', new.settlestatus;
		IF new.settlestatus = ''0'' THEN
-- RAISE NOTICE ''UPDATE cashamt:% % % %'', new.cashamt, new.charge1, new.groupcd, new.officecd;

			UPDATE p_pbchg_balance_tbl SET
				now_balance = (CASE WHEN now_balance is NULL THEN -(new.cashamt + new.charge1) ELSE now_balance - (new.cashamt + new.charge1) END),
				pay_amt = (CASE WHEN now_balance is NULL THEN new.cashamt + new.charge1 ELSE pay_amt + new.cashamt + new.charge1 END),
				settle_flg = 0
			WHERE stre_cd = new.stre_cd AND groupcd = new.groupcd AND officecd = new.officecd;
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_pbchg_log_i AFTER insert
 ON                c_pbchg_log_01     FOR EACH ROW
 EXECUTE PROCEDURE fnc_pbchg_log_i ( );
