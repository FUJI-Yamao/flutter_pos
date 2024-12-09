--=======================================================================================
-- s_subtsch_mst ()
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			subt_cd		-- 9 digit
--			svs_typ		-- 2 digit
--			dsc_prc		-- 9 digit
--			mdsc_prc	-- 9 digit
--			stl_form_amt	-- 9 digit
--			start_datetime	--14 digit
--			end_datetime	--14 digit
--			timesch_flg	-- 1 digit
--			mon_flg		-- 1 digit
--			tue_flg		-- 1 digit
--			wed_flg		-- 1 digit
--			thu_flg		-- 1 digit
--			fri_flg		-- 1 digit
--			sat_flg		-- 1 digit
--			sun_flg		-- 1 digit
--			stop_flg	-- 1 digit
--			--------------------------
--			total		--75 digit
--		$6 -- name
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2021/01/27 : T.Saito      : First Edition
-- Modify	: 2021/06/30 : Y.Okada      : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn5D(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), NUMERIC(14,0), VARCHAR(20), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;	--1ver
		_stre_cd		alias for $5;
		_plan_cd		alias for $6;	--1ver
		_data1			alias for $7;
		_name			alias for $8;
		
		dt			s_subtsch_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 75;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.subt_cd		:= substring(_data1 FROM 1 FOR 9);
		dt.svs_typ		:= substring(_data1 FROM 10 FOR 2);
		dt.dsc_prc		:= substring(_data1 FROM 12 FOR 9);
		dt.mdsc_prc		:= substring(_data1 FROM 21 FOR 9);
		dt.stl_form_amt		:= substring(_data1 FROM 30 FOR 9);
		dt.start_datetime := substring(_data1 FROM 39 FOR 4) || ''-'' || substring(_data1 FROM 43 FOR 2) || ''-'' || substring(_data1 FROM 45 FOR 2) || '' '' ||
				substring(_data1 FROM 47 FOR 2) || '':'' || substring(_data1 FROM 49 FOR 2) || '':'' || substring(_data1 FROM 51 FOR 2) ; 
		dt.end_datetime   := substring(_data1 FROM 53 FOR 4) || ''-'' || substring(_data1 FROM 57 FOR 2) || ''-'' || substring(_data1 FROM 59 FOR 2) || '' '' ||
				substring(_data1 FROM 61 FOR 2) || '':'' || substring(_data1 FROM 63 FOR 2) || '':'' || substring(_data1 FROM 65 FOR 2) ;
--		dt.start_datetime	:= substring(_data1 FROM 39 FOR 8);
--		dt.end_datetime		:= substring(_data1 FROM 47 FOR 8);
		dt.timesch_flg		:= substring(_data1 FROM 67 FOR 1);
		dt.mon_flg		:= substring(_data1 FROM 68 FOR 1);
		dt.tue_flg		:= substring(_data1 FROM 69 FOR 1);
		dt.wed_flg		:= substring(_data1 FROM 70 FOR 1);
		dt.thu_flg		:= substring(_data1 FROM 71 FOR 1);
		dt.fri_flg		:= substring(_data1 FROM 72 FOR 1);
		dt.sat_flg		:= substring(_data1 FROM 73 FOR 1);
		dt.sun_flg		:= substring(_data1 FROM 74 FOR 1);
		dt.stop_flg		:= substring(_data1 FROM 75 FOR 1);

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
			UPDATE s_subtsch_mst SET
				name = _name
				, svs_typ = dt.svs_typ, dsc_prc = dt.dsc_prc, mdsc_prc = dt.mdsc_prc, stl_form_amt = dt.stl_form_amt
				, start_datetime = dt.start_datetime, end_datetime = dt.end_datetime, timesch_flg = dt.timesch_flg		
				, mon_flg = dt.mon_flg, tue_flg = dt.tue_flg, wed_flg = dt.wed_flg, thu_flg = dt.thu_flg		
				, fri_flg = dt.fri_flg, sat_flg = dt.sat_flg, sun_flg = dt.sun_flg, stop_flg = dt.stop_flg		
				, upd_datetime = _updins_datetime, upd_user = dt.upd_user
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND subt_cd = dt.subt_cd ;

			UPDATE c_plan_mst SET
				name = _name
				, start_datetime = dt.start_datetime, end_datetime = dt.end_datetime, trends_typ = 2
				, upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_subtsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND subt_cd = dt.subt_cd);

			INSERT INTO s_subtsch_mst (
				comp_cd, stre_cd, plan_cd, subt_cd, name
				, svs_typ, dsc_prc, mdsc_prc, stl_form_amt
				, start_datetime, end_datetime, timesch_flg
				, mon_flg, tue_flg, wed_flg, thu_flg
				, fri_flg, sat_flg, sun_flg, stop_flg
				, ins_datetime, upd_datetime, upd_user
				)
			SELECT 
				_comp_cd, _stre_cd, _plan_cd, dt.subt_cd, _name
				, dt.svs_typ, dt.dsc_prc, dt.mdsc_prc, dt.stl_form_amt
				, dt.start_datetime, dt.end_datetime, dt.timesch_flg
				, dt.mon_flg, dt.tue_flg, dt.wed_flg, dt.thu_flg
				, dt.fri_flg, dt.sat_flg, dt.sun_flg, dt.stop_flg
				, _updins_datetime, _updins_datetime, dt.upd_user
			WHERE dt.subt_cd NOT IN (SELECT subt_cd FROM s_subtsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND subt_cd = dt.subt_cd );

			INSERT INTO c_plan_mst(
				comp_cd, stre_cd, plan_cd, name, short_name, prom_typ, start_datetime, end_datetime,
				trends_typ, ins_datetime, upd_datetime, status, send_flg, upd_user
				)
			SELECT _comp_cd, _stre_cd, _plan_cd, _name, '''', 7, dt.start_datetime, dt.end_datetime,
				2, _updins_datetime, _updins_datetime, 0, 0, dt.upd_user
			WHERE _plan_cd NOT IN (SELECT plan_cd FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd = _plan_cd);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_subtsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND subt_cd = dt.subt_cd);
			DELETE FROM s_subtsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND subt_cd = dt.subt_cd ;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
