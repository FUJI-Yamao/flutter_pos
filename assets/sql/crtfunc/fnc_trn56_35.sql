--=======================================================================================
-- s_bdlsch_mst -> (Update & Insert) or Delete PL/PGSQL Function
--			(Only connect SIMMS)
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			bdl_cd			--  9 digit
--		$6 -- bdl name
--		$7 -- data2
--			bdl_qty1		--  3 digit
--			bdl_prc1		--  7 digit
--			bdl_qty2		--  3 digit
--			bdl_prc2		--  7 digit
--			bdl_qty3		--  3 digit
--			bdl_prc3		--  7 digit
--			bdl_qty4		--  3 digit
--			bdl_prc4		--  7 digit
--			bdl_qty5		--  3 digit
--			bdl_prc5		--  7 digit
--			start_datetime		-- 12 digit(YYYYMMDDHHMM)
--			end_datetime		-- 12 digit(YYYYMMDDHHMM)
--			limit_cnt		--  2 digit(0:not limit 1--:--cnt)
--			stop_flg		--  1 digit( 0:continue 1:stop )
--			sat_flg			--  1 digit( 0:disable 1:enable )
--			fri_flg			--  1 digit( 0:disable 1:enable )
--			thu_flg			--  1 digit( 0:disable 1:enable )
--			wed_flg			--  1 digit( 0:disable 1:enable )
--			tue_flg			--  1 digit( 0:disable 1:enable )
--			mon_flg			--  1 digit( 0:disable 1:enable )
--			sun_flg			--  1 digit( 0:disable 1:enable )
--			timesch_flg		--  1 digit( 0:disable 1:enable )
--			mbdl_prc1		--  7 digit
--			mbdl_prc2		--  7 digit
--			mbdl_prc3		--  7 digit
--			mbdl_prc4		--  7 digit
--			mbdl_prc5		--  7 digit
--			bdl_typ			--  2 digit
------------------------------------------------------------------------------------------
-- Author	: T.Baba
-- Start	: 2003.Oct.01 : T.Baba      : First Edition
-- Modify	: 2005.May.17 : T.Baba      : Change size of bdl_cd(3->9)
-- Modify	: 2007.Feb.27 : M.Nishihara : Change size of bdl_qty*(2->3), bdl_prc*(6->7)
-- Modify	: 2008.Oct.21 : T.Saito     : Change size of limit_cnt(1->2)
-- Modify	: 2008.Nov.21 : T.Saito     : Append mbdl_prc1, mbdl_prc2, mbdl_prc3, mbdl_prc4, mbdl_prc5, bdl_typ
-- Modify	: 2021/06/30  : Y.Okada     : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn56(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), NUMERIC(14,0), VARCHAR(20), VARCHAR(50), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;	--1ver
		_stre_cd		alias for $5;
		_plan_cd		alias for $6;	--1ver
		_data1			alias for $7;
		_bdl_name		alias for $8;
		_data2			alias for $9;

		_bdl_cd			s_bdlsch_mst.bdl_cd%TYPE;		-- 9 digit
		_bdl_qty1		s_bdlsch_mst.bdl_qty1%TYPE;		-- 3 digit
		_bdl_prc1		s_bdlsch_mst.bdl_prc1%TYPE;		-- 7 digit
		_bdl_qty2		s_bdlsch_mst.bdl_qty2%TYPE;		-- 3 digit
		_bdl_prc2		s_bdlsch_mst.bdl_prc2%TYPE;		-- 7 digit
		_bdl_qty3		s_bdlsch_mst.bdl_qty3%TYPE;		-- 3 digit
		_bdl_prc3		s_bdlsch_mst.bdl_prc3%TYPE;		-- 7 digit
		_bdl_qty4		s_bdlsch_mst.bdl_qty4%TYPE;		-- 3 digit
		_bdl_prc4		s_bdlsch_mst.bdl_prc4%TYPE;		-- 7 digit
		_bdl_qty5		s_bdlsch_mst.bdl_qty5%TYPE;		-- 3 digit
		_bdl_prc5		s_bdlsch_mst.bdl_prc5%TYPE;		-- 7 digit
		_start_datetime		s_bdlsch_mst.start_datetime%TYPE;	-- 12 digit
		_end_datetime		s_bdlsch_mst.end_datetime%TYPE;		-- 12 digit
		_limit_cnt		s_bdlsch_mst.limit_cnt%TYPE;		-- 2 digit
		_stop_flg		s_bdlsch_mst.stop_flg%TYPE;		-- 1 digit
		_sat_flg		s_bdlsch_mst.sat_flg%TYPE;		-- 1 digit
		_fri_flg		s_bdlsch_mst.fri_flg%TYPE;		-- 1 digit
		_thu_flg		s_bdlsch_mst.thu_flg%TYPE;		-- 1 digit
		_wed_flg		s_bdlsch_mst.wed_flg%TYPE;		-- 1 digit
		_tue_flg		s_bdlsch_mst.tue_flg%TYPE;		-- 1 digit
		_mon_flg		s_bdlsch_mst.mon_flg%TYPE;		-- 1 digit
		_sun_flg		s_bdlsch_mst.sun_flg%TYPE;		-- 1 digit
		_timesch_flg		s_bdlsch_mst.timesch_flg%TYPE;		-- 1 digit
		_mbdl_prc1		s_bdlsch_mst.mbdl_prc1%TYPE;		-- 7 digit
		_mbdl_prc2		s_bdlsch_mst.mbdl_prc2%TYPE;		-- 7 digit
		_mbdl_prc3		s_bdlsch_mst.mbdl_prc3%TYPE;		-- 7 digit
		_mbdl_prc4		s_bdlsch_mst.mbdl_prc4%TYPE;		-- 7 digit
		_mbdl_prc5		s_bdlsch_mst.mbdl_prc5%TYPE;		-- 7 digit
		_bdl_typ		s_bdlsch_mst.bdl_typ%TYPE;		-- 2 digit
		_upd_user		s_bdlsch_mst.upd_user%TYPE;
		_upd_system		s_bdlsch_mst.upd_system%TYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 9;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		_cmp_length := 3+7+3+7+3+7+3+7+3+7+12+12+2+1+7+1+7+7+7+7+7+2;
		_set_length := octet_length(_data2);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
		END IF;

		_bdl_cd := substring(_data1 FROM 1 FOR 9);

		_bdl_qty1 := substring(_data2 FROM 1 FOR 3);
		_bdl_prc1 := substring(_data2 FROM 4 FOR 7);
		_bdl_qty2 := substring(_data2 FROM 11 FOR 3);
		_bdl_prc2 := substring(_data2 FROM 14 FOR 7);
		_bdl_qty3 := substring(_data2 FROM 21 FOR 3);
		_bdl_prc3 := substring(_data2 FROM 24 FOR 7);
		_bdl_qty4 := substring(_data2 FROM 31 FOR 3);
		_bdl_prc4 := substring(_data2 FROM 34 FOR 7);
		_bdl_qty5 := substring(_data2 FROM 41 FOR 3);
		_bdl_prc5 := substring(_data2 FROM 44 FOR 7);
		_start_datetime := substring(_data2 FROM 51 FOR 4) || ''-'' || substring(_data2 FROM 55 FOR 2) || ''-'' || substring(_data2 FROM 57 FOR 2) || '' '' ||
				substring(_data2 FROM 59 FOR 2) || '':'' || substring(_data2 FROM 61 FOR 2) || '':00'';
		_end_datetime   := substring(_data2 FROM 63 FOR 4) || ''-'' || substring(_data2 FROM 67 FOR 2) || ''-'' || substring(_data2 FROM 69 FOR 2) || '' '' ||
				substring(_data2 FROM 71 FOR 2) || '':'' || substring(_data2 FROM 73 FOR 2) || '':00'';
		_limit_cnt := substring(_data2 FROM 75 FOR 2);
		_stop_flg := substring(_data2 FROM 77 FOR 1);
		_sat_flg := substring(_data2 FROM 78 FOR 1);
		_fri_flg := substring(_data2 FROM 79 FOR 1);
		_thu_flg := substring(_data2 FROM 80 FOR 1);
		_wed_flg := substring(_data2 FROM 81 FOR 1);
		_tue_flg := substring(_data2 FROM 82 FOR 1);
		_mon_flg := substring(_data2 FROM 83 FOR 1);
		_sun_flg := substring(_data2 FROM 84 FOR 1);
		_timesch_flg := substring(_data2 FROM 85 FOR 1);
		_mbdl_prc1 := substring(_data2 FROM 86 FOR 7);
		_mbdl_prc2 := substring(_data2 FROM 93 FOR 7);
		_mbdl_prc3 := substring(_data2 FROM 100 FOR 7);
		_mbdl_prc4 := substring(_data2 FROM 107 FOR 7);
		_mbdl_prc5 := substring(_data2 FROM 114 FOR 7);
		_bdl_typ := substring(_data2 FROM 121 FOR 2);

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
-- update s_bdlsch_mst, c_plan_mst
			UPDATE s_bdlsch_mst SET
				name = _bdl_name, start_datetime = _start_datetime,
				end_datetime = _end_datetime, timesch_flg = _timesch_flg, sun_flg = _sun_flg, mon_flg = _mon_flg,
				tue_flg = _tue_flg, wed_flg = _wed_flg, thu_flg = _thu_flg, fri_flg = _fri_flg, sat_flg = _sat_flg,
				bdl_qty1 = _bdl_qty1, bdl_qty2 = _bdl_qty2, bdl_qty3 = _bdl_qty3, bdl_qty4 = _bdl_qty4, bdl_qty5 = _bdl_qty5,
				bdl_prc1 = _bdl_prc1, bdl_prc2 = _bdl_prc2, bdl_prc3 = _bdl_prc3, bdl_prc4 = _bdl_prc4, bdl_prc5 = _bdl_prc5,
				limit_cnt = _limit_cnt, stop_flg = _stop_flg, trends_typ = 2,
				mbdl_prc1 = _mbdl_prc1, mbdl_prc2 = _mbdl_prc2, mbdl_prc3 = _mbdl_prc3, mbdl_prc4 = _mbdl_prc4, mbdl_prc5 = _mbdl_prc5,
				bdl_typ = _bdl_typ,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND bdl_cd = _bdl_cd;

			UPDATE c_plan_mst SET
				name = _bdl_name, start_datetime = _start_datetime,
				end_datetime = _end_datetime, trends_typ = 2,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_bdlsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND bdl_cd = _bdl_cd);

-- insert s_bdlsch_mst, c_plan_mst
			INSERT INTO s_bdlsch_mst(
				comp_cd, stre_cd, bdl_cd, plan_cd, name, short_name, start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg,
				bdl_qty1, bdl_qty2, bdl_qty3, bdl_qty4, bdl_qty5,
				bdl_prc1, bdl_prc2, bdl_prc3, bdl_prc4, bdl_prc5,
				limit_cnt, stop_flg, trends_typ,
				mbdl_prc1, mbdl_prc2, mbdl_prc3, mbdl_prc4, mbdl_prc5, bdl_typ,
				card1, card2, card3, card4, card5,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
			SELECT _comp_cd, _stre_cd, _bdl_cd, _plan_cd, _bdl_name, NULL, _start_datetime, _end_datetime, _timesch_flg,
				_sun_flg, _mon_flg, _tue_flg, _wed_flg, _thu_flg, _fri_flg, _sat_flg,
				_bdl_qty1, _bdl_qty2, _bdl_qty3, _bdl_qty4, _bdl_qty5,
				_bdl_prc1, _bdl_prc2, _bdl_prc3, _bdl_prc4, _bdl_prc5,
				_limit_cnt, _stop_flg, 2,
				_mbdl_prc1, _mbdl_prc2, _mbdl_prc3, _mbdl_prc4, _mbdl_prc5, _bdl_typ,
				-1, -1, -1, -1, -1,
				_updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
			WHERE _bdl_cd NOT IN (SELECT bdl_cd FROM s_bdlsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND bdl_cd = _bdl_cd);

			INSERT INTO c_plan_mst(
				comp_cd, stre_cd, plan_cd, name, short_name, prom_typ, start_datetime, end_datetime,
				trends_typ, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				)
			SELECT _comp_cd, _stre_cd, _plan_cd, _bdl_name, '''', 2, _start_datetime, _end_datetime,
				2, _updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
			WHERE _plan_cd NOT IN (SELECT plan_cd FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd = _plan_cd);

		ELSE IF _set_type = 1 THEN
-- delete s_bdlsch_mst
			DELETE FROM c_plan_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plan_cd IN (SELECT plan_cd FROM s_bdlsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND bdl_cd = _bdl_cd);
			DELETE FROM s_bdlsch_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND bdl_cd = _bdl_cd;
			DELETE FROM s_bdlitem_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND bdl_cd = _bdl_cd;
			DELETE FROM rdly_prom WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND sch_cd = _bdl_cd AND prom_typ = 2;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
