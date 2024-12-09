--=======================================================================================
-- c_divide_mst ()
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			kind_cd		-- 8 digit
--			div_cd	-- 8 digit
--		$6 -- reason name
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2013.03.12 : T.Saito      : First Edition
-- Modify	: 2021/06/30 : Y.Okada      : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnW8(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_reason_name		alias for $7;
		
		dt			c_divide_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 16;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.kind_cd	:= substring(_data1 FROM 1 FOR 8);
		dt.div_cd	:= substring(_data1 FROM 9 FOR 8);

		IF _send_who = 0 THEN
			dt.upd_user	:= 999999;
		ELSE
			IF _send_who = 1 THEN
				dt.upd_user	:= 999999;
			ELSE
				dt.upd_user	:= 999999;
			END IF;
		END IF;

		IF _set_type = 0 THEN
			UPDATE c_divide_mst SET
				name = _reason_name, 
				upd_datetime = _updins_datetime, upd_user = dt.upd_user
			WHERE comp_cd = _comp_cd AND kind_cd = dt.kind_cd AND div_cd = dt.div_cd;

			INSERT INTO c_divide_mst(
				comp_cd, kind_cd, div_cd, name, exp_cd1, exp_cd2,
				ins_datetime, upd_datetime, upd_user)
			SELECT _comp_cd, dt.kind_cd, dt.div_cd, _reason_name, 0, 0,
				_updins_datetime, _updins_datetime, dt.upd_user
			WHERE dt.div_cd NOT IN (SELECT div_cd FROM c_divide_mst WHERE comp_cd = _comp_cd AND kind_cd = dt.kind_cd);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_divide_mst WHERE comp_cd = _comp_cd AND kind_cd = dt.kind_cd AND div_cd = dt.div_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
