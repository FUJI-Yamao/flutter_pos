--=======================================================================================
-- c_staff_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			staff_cd		-- 6 digit
--		$6 -- staff_name
--		$7 -- passwd
--		$8 -- data2
--			cs_lvlcd		-- 1 digit
--			sc_lvlcd		-- 1 digit
--			auth_lvl(tpr_lvlcd)		-- 1 digit(1:regstration 2:setting 3:management)
--			poppy_lvlcd		-- 1 digit
--			webht_lvlcd		-- 1 digit
--			jot_lvlcd		-- 1 digit
--			dsc_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			pdsc_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			void_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			ref_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			cha_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			loan_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			pick_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			cin_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			out_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			evoid_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			cncl_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			drw_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
--			acb_opelvl		-- 1 digit(0:staff code judgement 1:use ok 2:use ng)
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2011.05.20 : T.Saito	: First Edition
-- Modify	: 2021/06/30 : Y.Okada	: 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn8A(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(50), VARCHAR(8), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_staff_name		alias for $7;
		_passwd			alias for $8;
		_data2			alias for $9;

		dt			c_staff_mst%ROWTYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 6;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.staff_cd := substring(_data1 FROM 1 FOR 6);
		IF _set_type = 0 THEN
			_cmp_length := 19;
			_set_length := octet_length(_data2);
			IF _set_length < _cmp_length THEN
				RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
			END IF;

--			dt.cs_lvlcd := substring(_data2 FROM 1 FOR 1);
--			dt.sc_lvlcd := substring(_data2 FROM 2 FOR 1);
			dt.auth_lvl := substring(_data2 FROM 3 FOR 1);
--			dt.poppy_lvlcd := substring(_data2 FROM 4 FOR 1);
--			dt.webht_lvlcd := substring(_data2 FROM 5 FOR 1);
--			dt.jot_lvlcd := substring(_data2 FROM 6 FOR 1);
--			dt.dsc_opelvl := substring(_data2 FROM 7 FOR 1);
--			dt.pdsc_opelvl := substring(_data2 FROM 8 FOR 1);
--			dt.void_opelvl := substring(_data2 FROM 9 FOR 1);
--			dt.ref_opelvl := substring(_data2 FROM 10 FOR 1);
--			dt.cha_opelvl := substring(_data2 FROM 11 FOR 1);
--			dt.loan_opelvl := substring(_data2 FROM 12 FOR 1);
--			dt.pick_opelvl := substring(_data2 FROM 13 FOR 1);
--			dt.cin_opelvl := substring(_data2 FROM 14 FOR 1);
--			dt.out_opelvl := substring(_data2 FROM 15 FOR 1);
--			dt.evoid_opelvl := substring(_data2 FROM 16 FOR 1);
--			dt.cncl_opelvl := substring(_data2 FROM 17 FOR 1);
--			dt.drw_opelvl := substring(_data2 FROM 18 FOR 1);
--			dt.acb_opelvl := substring(_data2 FROM 19 FOR 1);
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
			UPDATE c_staff_mst SET
				name= _staff_name, passwd=_passwd, auth_lvl=dt.auth_lvl,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system,
				stre_cd=_stre_cd
			WHERE comp_cd=_comp_cd AND staff_cd=dt.staff_cd;

			INSERT INTO c_staff_mst(
				staff_cd, name, passwd, auth_lvl,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
				comp_cd, stre_cd)
			SELECT  dt.staff_cd, _staff_name, _passwd, dt.auth_lvl, 
				_updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system,
				_comp_cd, _stre_cd
			WHERE dt.staff_cd NOT IN (SELECT staff_cd FROM c_staff_mst WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND staff_cd=dt.staff_cd);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_staff_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND staff_cd = dt.staff_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
