--=======================================================================================
-- c_tax_mst
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			tax_cd		-- 2 digit
--			tax_typ		-- 2 digit
--			tax_per		-- 4 digit (example: 1234 -> 12.34)
--			mov_cd		-- 2 digit
--			odd_flg		-- 2 digit
--		$6 -- tax_name
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2013.10.27 : T.Saito      : First Edition
--		: 2013.11.11 : T.Saito      : Append tax_name
--		: 2021/06/30 : Y.Okada      : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnSD(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(50), VARCHAR(20)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_data2			alias for $7;
		
		dt			c_tax_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 12;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.tax_cd	:= substring(_data1 FROM 1 FOR 2);
		dt.tax_typ	:= substring(_data1 FROM 3 FOR 2);
		dt.tax_per	:= substring(_data1 FROM 5 FOR 2) || ''.'' || substring(_data1 FROM 7 FOR 2);
		dt.mov_cd	:= substring(_data1 FROM 9 FOR 2);
		dt.odd_flg	:= substring(_data1 FROM 11 FOR 2);
		dt.tax_name	:= _data2;

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
			UPDATE c_tax_mst SET
				tax_typ=dt.tax_typ, odd_flg=dt.odd_flg, tax_per=dt.tax_per, mov_cd=dt.mov_cd, tax_name=dt.tax_name,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE comp_cd = _comp_cd AND tax_cd = dt.tax_cd;

			IF NOT FOUND THEN
				INSERT INTO c_tax_mst(
					comp_cd, tax_cd, tax_name, tax_typ, odd_flg, tax_per, mov_cd,
					ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system)
				SELECT  _comp_cd, dt.tax_cd, dt.tax_name, dt.tax_typ, dt.odd_flg, dt.tax_per, dt.mov_cd,
					_updins_datetime, _updins_datetime, 0, 0, dt.upd_user,dt.upd_system
				WHERE dt.tax_cd NOT IN (SELECT tax_cd FROM c_tax_mst WHERE comp_cd = _comp_cd AND tax_cd = dt.tax_cd);
			END IF;

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_tax_mst WHERE comp_cd = _comp_cd AND tax_cd = dt.tax_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
