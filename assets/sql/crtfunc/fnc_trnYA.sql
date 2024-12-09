--=======================================================================================
-- c_liqritem_mst
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- comp code
--		$5 -- store code
--		$6 -- data1
--			liqritem_cd		-- 6 digit
--			powliqr_flg		-- 1 digit
--		$7 -- name1
--		$8 -- name2
--		$9 -- name3
------------------------------------------------------------------------------------------
-- Author	: Y.Okada
-- Start	: 2021/12/01 : Y.Okada      : 新規作成
-- Modify	:            :              : 
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnYA(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_name1			alias for $7;
		_name2			alias for $8;
		_name3			alias for $9;
		
		dt			c_liqritem_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 7;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.liqritem_cd		:= substring(_data1 FROM 1 FOR 6);
		dt.powliqr_flg		:= substring(_data1 FROM 7 FOR 1);
		dt.liqritem_name1	:= _name1;
		dt.liqritem_name2	:= _name2;
		dt.liqritem_name3	:= _name3;

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
			UPDATE c_liqritem_mst SET
				liqritem_name1=dt.liqritem_name1, liqritem_name2=dt.liqritem_name2, liqritem_name3=dt.liqritem_name3,
				powliqr_flg=dt.powliqr_flg,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE comp_cd = _comp_cd AND liqritem_cd = dt.liqritem_cd;

			IF NOT FOUND THEN
				INSERT INTO c_liqritem_mst(
					comp_cd, liqritem_cd, liqritem_name1, liqritem_name2, liqritem_name3,
					powliqr_flg, data_c_01, data_c_02, data_n_01, data_n_02,
					ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
				SELECT  _comp_cd, dt.liqritem_cd, dt.liqritem_name1, dt.liqritem_name2, dt.liqritem_name3,
					dt.powliqr_flg, NULL, NULL, 0, 0,
					_updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system
				WHERE dt.liqritem_cd NOT IN (SELECT liqritem_cd FROM c_liqritem_mst WHERE comp_cd = _comp_cd AND liqritem_cd = dt.liqritem_cd);
			END IF;

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_liqritem_mst WHERE comp_cd = _comp_cd AND liqritem_cd = dt.liqritem_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
