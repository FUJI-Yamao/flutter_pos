--=======================================================================================
-- s_stmsch_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			stm_cd			--  9 digit
--			plan_cd			--  9 digit
--		$6 -- stm name			-- 50 digit
--		$7 -- stm short name		-- 10 digit
--		$8 -- data2
--			start_datetime		-- 12 digit
--			end_datetime		-- 12 digit
--			timesch_flg		--  1 digit( 0:disable 1:enable )
--			sun_flg			--  1 digit( 0:disable 1:enable )
--			mon_flg			--  1 digit( 0:disable 1:enable )
--			tue_flg			--  1 digit( 0:disable 1:enable )
--			wed_flg			--  1 digit( 0:disable 1:enable )
--			thu_flg			--  1 digit( 0:disable 1:enable )
--			fri_flg			--  1 digit( 0:disable 1:enable )
--			sat_flg			--  1 digit( 0:disable 1:enable )
--			member_qty		--  3 digit
--			stm_prc			--  7 digit
--			limit_cnt		--  2 digit( 0:not limit 1--:--cnt )
--			poppy_flg		--  1 digit( 0:yes 1:no )(1verは無い)
--			stop_flg		--  1 digit( 0:continue 1:stop )
--			trends_typ		--  1 digit
--			efct_flg		--  1 digit(1verは無い)
--			mstm_prc		--  7 digit
--			dsc_flg			--  1 digit
--			stm_prc2		--  7 digit
--			stm_prc3		--  7 digit
--			stm_prc4		--  7 digit
--			stm_prc5		--  7 digit
--			mstm_prc2		--  7 digit
--			mstm_prc3		--  7 digit
--			mstm_prc4		--  7 digit
--			mstm_prc5		--  7 digit
------------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2007.Jul.27 : F.Saitoh : First Edition
-- Modify	: 2021/06/30 : Y.Okada   : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_stmsch2(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(50), VARCHAR(10), VARCHAR(200)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_stm_name		alias for $7;
		_stm_short_name		alias for $8;
		_data2			alias for $9;

		_stm_cd			s_stmsch_mst.stm_cd%TYPE;		-- 9 digit
		_plan_cd		s_stmsch_mst.plan_cd%TYPE;		-- 9 digit

		_start_datetime		s_stmsch_mst.start_datetime%TYPE;	-- 12 digit
		_end_datetime		s_stmsch_mst.end_datetime%TYPE;	-- 12 digit
		_timesch_flg		s_stmsch_mst.timesch_flg%TYPE;		-- 1 digit
		_sun_flg		s_stmsch_mst.sun_flg%TYPE;		-- 1 digit
		_mon_flg		s_stmsch_mst.mon_flg%TYPE;		-- 1 digit
		_tue_flg		s_stmsch_mst.tue_flg%TYPE;		-- 1 digit
		_wed_flg		s_stmsch_mst.wed_flg%TYPE;		-- 1 digit
		_thu_flg		s_stmsch_mst.thu_flg%TYPE;		-- 1 digit
		_fri_flg		s_stmsch_mst.fri_flg%TYPE;		-- 1 digit
		_sat_flg		s_stmsch_mst.sat_flg%TYPE;		-- 1 digit
		_member_qty		s_stmsch_mst.member_qty%TYPE;		-- 3 digit
		_stm_prc		s_stmsch_mst.stm_prc%TYPE;		-- 7 digit
		_limit_cnt		s_stmsch_mst.limit_cnt%TYPE;		-- 2 digit
		_stop_flg		s_stmsch_mst.stop_flg%TYPE;		-- 1 digit
		_trends_typ		s_stmsch_mst.trends_typ%TYPE;		-- 1 digit
		_upd_user		s_stmsch_mst.upd_user%TYPE;
		_upd_system		s_stmsch_mst.upd_system%TYPE;
		_mstm_prc		s_stmsch_mst.mstm_prc%TYPE;
		_dsc_flg		s_stmsch_mst.dsc_flg%TYPE;		-- 1 digit
		_stm_prc2		s_stmsch_mst.stm_prc2%TYPE;		-- 7 digit
		_stm_prc3		s_stmsch_mst.stm_prc3%TYPE;		-- 7 digit
		_stm_prc4		s_stmsch_mst.stm_prc4%TYPE;		-- 7 digit
		_stm_prc5		s_stmsch_mst.stm_prc5%TYPE;		-- 7 digit
		_mstm_prc2		s_stmsch_mst.mstm_prc2%TYPE;		-- 7 digit
		_mstm_prc3		s_stmsch_mst.mstm_prc3%TYPE;		-- 7 digit
		_mstm_prc4		s_stmsch_mst.mstm_prc4%TYPE;		-- 7 digit
		_mstm_prc5		s_stmsch_mst.mstm_prc5%TYPE;		-- 7 digit
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 18;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			IF _set_length = 9 THEN
				_plan_cd := NULL;
			ELSE
				RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
			END IF;
		ELSE
			_plan_cd := substring(_data1 FROM 10 FOR 9);
		END IF;

		IF _set_type = 0 THEN
			_cmp_length := 24+8+10+6+7+1+56;
			_set_length := octet_length(_data2);
			IF _set_length < _cmp_length THEN
				RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
			END IF;
		END IF;

		_stm_cd := substring(_data1 FROM 1 FOR 9);

		IF _set_type = 0 THEN
			_start_datetime := substring(_data2 FROM 1 FOR 4) || ''-'' || substring(_data2 FROM 5 FOR 2) || ''-'' || substring(_data2 FROM 7 FOR 2) || '' '' ||
					substring(_data2 FROM 9 FOR 2) || '':'' || substring(_data2 FROM 11 FOR 2) || '':00'';
			_end_datetime   := substring(_data2 FROM 13 FOR 4) || ''-'' || substring(_data2 FROM 17 FOR 2) || ''-'' || substring(_data2 FROM 19 FOR 2) || '' '' ||
					substring(_data2 FROM 21 FOR 2) || '':'' || substring(_data2 FROM 23 FOR 2) || '':00'';
			_timesch_flg := substring(_data2 FROM 25 FOR 1);
			_sun_flg := substring(_data2 FROM 26 FOR 1);
			_mon_flg := substring(_data2 FROM 27 FOR 1);
			_tue_flg := substring(_data2 FROM 28 FOR 1);
			_wed_flg := substring(_data2 FROM 29 FOR 1);
			_thu_flg := substring(_data2 FROM 30 FOR 1);
			_fri_flg := substring(_data2 FROM 31 FOR 1);
			_sat_flg := substring(_data2 FROM 32 FOR 1);
			_member_qty := substring(_data2 FROM 33 FOR 3);
			_stm_prc := substring(_data2 FROM 36 FOR 7);
			_limit_cnt := substring(_data2 FROM 43 FOR 2);
--			_poppy_flg := substring(_data2 FROM 45 FOR 1);
			_stop_flg := substring(_data2 FROM 46 FOR 1);
			_trends_typ := substring(_data2 FROM 47 FOR 1);
--			_efct_flg := substring(_data2 FROM 48 FOR 1);
			_mstm_prc := substring(_data2 FROM 49 FOR 7);
			_dsc_flg := substring(_data2 FROM 56 FOR 1);
			_stm_prc2 := substring(_data2 FROM 57 FOR 7);
			_stm_prc3 := substring(_data2 FROM 64 FOR 7);
			_stm_prc4 := substring(_data2 FROM 71 FOR 7);
			_stm_prc5 := substring(_data2 FROM 78 FOR 7);
			_mstm_prc2 := substring(_data2 FROM 85 FOR 7);
			_mstm_prc3 := substring(_data2 FROM 92 FOR 7);
			_mstm_prc4 := substring(_data2 FROM 99 FOR 7);
			_mstm_prc5 := substring(_data2 FROM 106 FOR 7);

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
-- update s_stmsch_mst, c_plan_mst
			UPDATE s_stmsch_mst SET
				name = _stm_name, short_name = _stm_short_name, start_datetime = _start_datetime,
				end_datetime = _end_datetime, timesch_flg = _timesch_flg, sun_flg = _sun_flg, mon_flg = _mon_flg,
				tue_flg = _tue_flg, wed_flg = _wed_flg, thu_flg = _thu_flg, fri_flg = _fri_flg, sat_flg = _sat_flg,
				member_qty = _member_qty, stm_prc = _stm_prc,
				limit_cnt = _limit_cnt, stop_flg = _stop_flg, trends_typ = _trends_typ,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system,
				mstm_prc = _mstm_prc, dsc_flg=_dsc_flg, stm_prc2=_stm_prc2, stm_prc3=_stm_prc3, stm_prc4=_stm_prc4, stm_prc5=_stm_prc5,
				mstm_prc2=_mstm_prc2, mstm_prc3=_mstm_prc3, mstm_prc4=_mstm_prc4, mstm_prc5=_mstm_prc5
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd;

			UPDATE c_plan_mst SET
				name = _stm_name, start_datetime = _start_datetime,
				end_datetime = _end_datetime, trends_typ = 2,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_stmsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd);

-- insert s_stmsch_mst, c_plan_mst
			INSERT INTO s_stmsch_mst(
				comp_cd, stre_cd, stm_cd, plan_cd, name, short_name, start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg,
				member_qty, stm_prc, limit_cnt, stop_flg, trends_typ,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,  mstm_prc,
				dsc_flg, stm_prc2, stm_prc3, stm_prc4, stm_prc5, mstm_prc2, mstm_prc3, mstm_prc4, mstm_prc5)
			SELECT _comp_cd, _stre_cd, _stm_cd, _plan_cd, _stm_name, _stm_short_name, _start_datetime, _end_datetime, _timesch_flg,
				_sun_flg, _mon_flg, _tue_flg, _wed_flg, _thu_flg, _fri_flg, _sat_flg,
				_member_qty, _stm_prc, _limit_cnt, _stop_flg, _trends_typ,
				_updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system, _mstm_prc,
				_dsc_flg, _stm_prc2, _stm_prc3, _stm_prc4, _stm_prc5, _mstm_prc2, _mstm_prc3, _mstm_prc4, _mstm_prc5
			WHERE _stm_cd NOT IN (SELECT stm_cd FROM s_stmsch_mst WHERE comp_cd = _comp_cd AND  stre_cd = _stre_cd AND stm_cd = _stm_cd);

			INSERT INTO c_plan_mst(
				comp_cd, stre_cd, plan_cd, name, short_name, prom_typ, start_datetime, end_datetime,
				trends_typ, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				)
			SELECT _comp_cd, _stre_cd, _plan_cd, _stm_name, _stm_short_name, 3, _start_datetime, _end_datetime,
				2, _updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
			WHERE _plan_cd NOT IN (SELECT plan_cd FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd = _plan_cd);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_stmsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd);
			DELETE FROM s_stmsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd;
			DELETE FROM s_stmitem_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd;
			DELETE FROM rdly_prom WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND sch_cd = _stm_cd AND prom_typ = 3;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
