--=======================================================================================
-- c_producer_mst
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- category name
--		$6 -- kana name
--		$7 -- data
--			producer_cd		-- 9 digit
--			cost_per		-- 4 digit ( examplu : 1234 -> 12.34 )(1verは無い)
--			dsc_flg			-- 1 digit(1verは無い)
--			dsc_val			-- 7 digit(1verは無い)
--			tax_cd			-- 2 digit
--			producer_misc_1		-- 2 digit
--                                              ----------
--                                      data all  25 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2019/04/08 : T.Saito     : First Edition
-- Modify	: 2021/06/30 : Y.Okada     : 1ver対応
-- 		: 2023/01/24 : Y.Okada     : 生産者区分(免税事業者フラグ)"producer_misc_1"を追加
--
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn86B(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(50), VARCHAR(20), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_cat_name		alias for $6;
		_kana_name		alias for $7;
		_data			alias for $8;

		dt			c_producer_mst%ROWTYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 9+4+1+7+2;
		_set_length := octet_length(_data);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.producer_cd	:= substring(_data FROM 1 FOR 9);
--		dt.cost_per	:= substring(_data FROM 10 FOR 2) || ''.'' || substring(_data FROM 12 FOR 2);
--		dt.dsc_flg	:= substring(_data FROM 14 FOR 1);
--		dt.dsc_val	:= substring(_data FROM 15 FOR 7);
		dt.tax_cd	:= substring(_data FROM 22 FOR 2);

		dt.producer_misc_1	:= 0;	-- 生産者区分(免税事業者フラグ)
		IF _set_length	>= (_cmp_length+2) THEN
			dt.producer_misc_1	:= substring(_data FROM 24 FOR 2);
		END IF;

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
			UPDATE c_producer_mst SET
				comp_cd = _comp_cd, stre_cd = _stre_cd, producer_cd = dt.producer_cd, name = _cat_name,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, tax_cd = dt.tax_cd,
				upd_system = dt.upd_system
			WHERE producer_cd = dt.producer_cd;

			-- dataに生産者区分(免税事業者フラグ)が含まれていればUPDATE
			IF _set_length	>= (_cmp_length+2) THEN
				UPDATE c_producer_mst SET
					producer_misc_1 = dt.producer_misc_1
				WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND producer_cd = dt.producer_cd;
			END IF;

			INSERT INTO c_producer_mst(
				comp_cd, stre_cd, producer_cd, name,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, tax_cd,
				producer_misc_1)
			SELECT _comp_cd, _stre_cd, dt.producer_cd, _cat_name,
				_updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system, dt.tax_cd,
				dt.producer_misc_1
			WHERE dt.producer_cd NOT IN (SELECT producer_cd FROM c_producer_mst WHERE producer_cd = dt.producer_cd AND comp_cd = _comp_cd AND stre_cd = _stre_cd);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_producer_mst WHERE producer_cd = dt.producer_cd AND comp_cd = _comp_cd AND stre_cd = _stre_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
