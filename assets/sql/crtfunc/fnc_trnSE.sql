--=======================================================================================
-- c_plu_mst -> (Update & Insert) or Delete PL/PGSQL Function (CSS ONLY)
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete 2:Change pos_name only
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			plu_cd			-- 13 digit
--		$6 -- plu name
--		$8 -- data2
--			instruct_prc		-- 7 digit
--			instruct_cost		-- 9 digit( dummy )
--			pos_prc			-- 7 digit
--			cost_prc		-- 9 digit( example 123456789 -> 1234567.89 )
--			cust_prc		-- 7 digit
--			tax_cd_1		-- 2 digit
--                                     data2 all  41 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2013.10.31 : T.Saito      : First Edition
-- Modify	: 2014.02.03 : T.Saito      : BugFix pos_name
--       	: 2021/06/30 : Y.Okada      : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnSE(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(50), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_plu_name		alias for $7;
		_data2			alias for $8;
		
		 dt                     c_plu_mst%ROWTYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 13;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;
		dt.plu_cd		:= substring(_data1 FROM 1 FOR 13);

		_cmp_length := 7+9+7+9+7+2;
		_set_length := octet_length(_data2);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
		END IF;
		dt.instruct_prc		:= substring(_data2 FROM 1 FOR 7);
		dt.pos_prc		:= substring(_data2 FROM 17 FOR 7);
		dt.cost_prc		:= substring(_data2 FROM 24 FOR 7) || ''.'' || substring(_data2 FROM 31 FOR 2);
		dt.cust_prc		:= substring(_data2 FROM 33 FOR 7);
		dt.tax_cd_1		:= substring(_data2 FROM 40 FOR 2);
	
		IF _send_who = 0 THEN
			dt.upd_user := 999999;
			dt.upd_system := 0;
		ELSE
			IF _send_who = 1 THEN
				dt.upd_user := 999999;
				dt.upd_system := 1;
			ELSE
				dt.upd_user := 999999;
				dt.upd_system := 2;
			END IF;
		END IF;

		IF _set_type = 0 THEN
			UPDATE c_plu_mst SET
				pos_name = (CASE WHEN octet_length(_plu_name) > 0 THEN _plu_name ELSE pos_name END),
				instruct_prc=dt.instruct_prc, pos_prc=dt.pos_prc, cost_prc=dt.cost_prc, cust_prc=dt.cust_prc, tax_cd_1=dt.tax_cd_1,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND plu_cd=dt.plu_cd;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
