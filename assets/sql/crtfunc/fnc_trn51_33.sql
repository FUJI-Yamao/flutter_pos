--=======================================================================================
-- s_brgn_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data
--			schedule code		--  9 digit
--			start date time		-- 12 digit(YYYYMMDDHHMM)
--			end date time		-- 12 digit(YYYYMMDDHHMM)
--			sat_flg			--  1 digit( 0:disable 1:enable )
--			fri_flg			--  1 digit( 0:disable 1:enable )
--			thu_flg			--  1 digit( 0:disable 1:enable )
--			wed_flg			--  1 digit( 0:disable 1:enable )
--			tue_flg			--  1 digit( 0:disable 1:enable )
--			mon_flg			--  1 digit( 0:disable 1:enable )
--			sun_flg			--  1 digit( 0:disable 1:enable )
--			stop_flg		--  1 digit( 0:continue 1:stop )
--			timesch_flg		--  1 digit( 0:disable 1:enable )
--			brgn_typ		--  2 digit
--		$6 -- name
------------------------------------------------------------------------------------------
-- Author	: T.Baba
-- Start	: 2003.Oct.01 : T.Baba      : First Edition
-- Modify	: 2005.May.17 : T.Baba      : Change size of brgn_cd(3->9)
--		: 2021/01/27  : T.Saito     : Add brgn_typ
--		: 2021/06/30  : Y.Okada     : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn51(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), NUMERIC(14,0), VARCHAR(100), VARCHAR(50)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;	--1ver
		_stre_cd		alias for $5;
		_plan_cd		alias for $6;	--1ver
		_data			alias for $7;
		_brgn_name		alias for $8;

		_brgn_cd		s_brgn_mst.brgn_cd%TYPE;		--  9 digit
		_start_datetime		s_brgn_mst.start_datetime%TYPE;	-- 12 digit
		_end_datetime		s_brgn_mst.end_datetime%TYPE;	-- 12 digit
		_sat_flg		s_brgn_mst.sat_flg%TYPE;		--  1 digit
		_fri_flg		s_brgn_mst.fri_flg%TYPE;		--  1 digit
		_thu_flg		s_brgn_mst.thu_flg%TYPE;		--  1 digit
		_wed_flg		s_brgn_mst.wed_flg%TYPE;		--  1 digit
		_tue_flg		s_brgn_mst.tue_flg%TYPE;		--  1 digit
		_mon_flg		s_brgn_mst.mon_flg%TYPE;		--  1 digit
		_sun_flg		s_brgn_mst.sun_flg%TYPE;		--  1 digit
		_stop_flg		s_brgn_mst.stop_flg%TYPE;		--  1 digit
		_timesch_flg		s_brgn_mst.timesch_flg%TYPE;		--  1 digit
		_upd_user		s_brgn_mst.upd_user%TYPE;
		_upd_system		s_brgn_mst.upd_system%TYPE;
		_brgn_typ		s_brgn_mst.brgn_typ%TYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 9+12+12+7+1+1;
		_set_length := octet_length(_data);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		_brgn_cd := substring(_data FROM 1 FOR 9);
		_start_datetime := substring(_data FROM 10 FOR 4) || ''-'' || substring(_data FROM 14 FOR 2) || ''-'' || substring(_data FROM 16 FOR 2) || '' '' ||
				substring(_data FROM 18 FOR 2) || '':'' || substring(_data FROM 20 FOR 2) || '':00'';
		_end_datetime   := substring(_data FROM 22 FOR 4) || ''-'' || substring(_data FROM 26 FOR 2) || ''-'' || substring(_data FROM 28 FOR 2) || '' '' ||
				substring(_data FROM 30 FOR 2) || '':'' || substring(_data FROM 32 FOR 2) || '':00'';
		_sat_flg := substring(_data FROM 34 FOR 1);
		_fri_flg := substring(_data FROM 35 FOR 1);
		_thu_flg := substring(_data FROM 36 FOR 1);
		_wed_flg := substring(_data FROM 37 FOR 1);
		_tue_flg := substring(_data FROM 38 FOR 1);
		_mon_flg := substring(_data FROM 39 FOR 1);
		_sun_flg := substring(_data FROM 40 FOR 1);
		_stop_flg := substring(_data FROM 41 FOR 1);
		_timesch_flg := substring(_data FROM 42 FOR 1);

		_brgn_typ := 0;
		IF _set_length  >= (_cmp_length+2) THEN
			_brgn_typ	:= substring(_data FROM 43 FOR 2);
		END IF;

		IF _send_who = 0 THEN
			_upd_user := 999999;
			_upd_system := 0;
		ELSE
			IF _send_who = 1 THEN
				_upd_user := 999999;
				_upd_system := 1;
			ELSE
				_upd_user := 999999;
				_upd_system := 2;
			END IF;
		END IF;

		IF _set_type = 0 THEN
-- update s_brgn_mst, c_plan_mst
			UPDATE s_brgn_mst SET
				name = _brgn_name, start_datetime = _start_datetime,
				end_datetime = _end_datetime, timesch_flg = _timesch_flg, sun_flg = _sun_flg, mon_flg = _mon_flg,
				tue_flg = _tue_flg, wed_flg = _wed_flg, thu_flg = _thu_flg, fri_flg = _fri_flg, sat_flg = _sat_flg,
				stop_flg = _stop_flg, trends_typ = 2,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
				, brgn_typ = _brgn_typ
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd;

			UPDATE c_plan_mst SET
				name = _brgn_name, start_datetime = _start_datetime,
				end_datetime = _end_datetime, trends_typ = 2,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_brgn_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd);

-- insert s_brgn_mst, c_plan_mst
			INSERT INTO s_brgn_mst(
				comp_cd, stre_cd, plan_cd, brgn_cd, plu_cd, name, short_name, start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg,
				stop_flg, trends_typ, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				, brgn_typ
				)
			SELECT _comp_cd, _stre_cd, _plan_cd, _brgn_cd, ''0000000000000'', _brgn_name, '''', _start_datetime, _end_datetime, _timesch_flg,
				_sun_flg, _mon_flg, _tue_flg, _wed_flg, _thu_flg, _fri_flg, _sat_flg,
				_stop_flg, 2, _updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
				, _brgn_typ
			WHERE _brgn_cd NOT IN (SELECT brgn_cd FROM s_brgn_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd);

			INSERT INTO c_plan_mst(
				comp_cd, stre_cd, plan_cd, name, short_name, prom_typ, start_datetime, end_datetime,
				trends_typ, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				)
			SELECT _comp_cd, _stre_cd, _plan_cd, _brgn_name, '''', 1, _start_datetime, _end_datetime,
				2, _updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
			WHERE _plan_cd NOT IN (SELECT plan_cd FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd = _plan_cd);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_brgn_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd);
			DELETE FROM s_brgn_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd;
			DELETE FROM rdly_prom WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND sch_cd = _brgn_cd AND prom_typ = 1;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
