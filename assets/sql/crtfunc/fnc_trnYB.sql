--=======================================================================================
-- c_liqrtax_mst
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- comp code
--		$5 -- store code
--		$6 -- data1
--			liqrtax_cd		-- 6 digit
--			liqrtax_rate		-- 9 digit
--			liqrtax_alc		-- 4 digit
--			liqrtax_add		-- 4 digit
--			liqrtax_add_amt		-- 9 digit
--		$7 -- name1
------------------------------------------------------------------------------------------
-- Author	: Y.Okada
-- Start	: 2021/12/01 : Y.Okada      : 新規作成
-- Modify	:            :              : 
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnYB(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(50), VARCHAR(50)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_name1			alias for $7;
		
		dt			c_liqrtax_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 32;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.liqrtax_cd		:= substring(_data1 FROM 1 FOR 6);
		dt.liqrtax_rate		:= substring(_data1 FROM 7 FOR 9);
		dt.liqrtax_alc		:= substring(_data1 FROM 16 FOR 2) || ''.'' || substring(_data1 FROM 18 FOR 2);
		dt.liqrtax_add		:= substring(_data1 FROM 20 FOR 2) || ''.'' || substring(_data1 FROM 22 FOR 2);
		dt.liqrtax_add_amt	:= substring(_data1 FROM 24 FOR 9);
		dt.liqrtax_name		:= _name1;

		IF _send_who = 0 THEN
			dt.upd_user	:= 999999;
			dt.upd_system	:= 0;
		ELSE
			IF _send_who = 1 THEN
				dt.upd_user	:= 999999;
				dt.upd_system	:= 1;
			ELSE
				dt.upd_user	:= 999999;
				dt.upd_system	:= 2;
			END IF;
		END IF;

		IF _set_type = 0 THEN
			UPDATE c_liqrtax_mst SET
				liqrtax_name=dt.liqrtax_name, liqrtax_rate=dt.liqrtax_rate, liqrtax_alc=dt.liqrtax_alc,
				liqrtax_add=dt.liqrtax_add, liqrtax_add_amt=dt.liqrtax_add_amt,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE comp_cd = _comp_cd AND liqrtax_cd = dt.liqrtax_cd;

			IF NOT FOUND THEN
				INSERT INTO c_liqrtax_mst(
					comp_cd, liqrtax_cd, liqrtax_name, liqrtax_rate, liqrtax_alc,
					liqrtax_add, liqrtax_add_amt, liqrtax_odd_flg,
					data_c_01, data_n_01, data_n_02, data_n_03,
					ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
				SELECT  _comp_cd, dt.liqrtax_cd, dt.liqrtax_name, dt.liqrtax_rate, dt.liqrtax_alc,
					dt.liqrtax_add, dt.liqrtax_add_amt, 0,
					NULL, 0, 0, 0.0,
					_updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system
				WHERE dt.liqrtax_cd NOT IN (SELECT liqrtax_cd FROM c_liqrtax_mst WHERE comp_cd = _comp_cd AND liqrtax_cd = dt.liqrtax_cd);
			END IF;

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_liqrtax_mst WHERE comp_cd = _comp_cd AND liqrtax_cd = dt.liqrtax_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
