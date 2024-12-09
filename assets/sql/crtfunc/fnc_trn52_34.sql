--=======================================================================================
-- s_brgn_mst -> (Update & Insert) or Delete PL/PGSQL Function
--			(Only connect SIMMS)
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data
--			brgn_cd			--  9 digit
--			plu_cd			-- 13 digit
--			brgn_prc		--  7 digit
--			brgncust_prc		--  7 digit
--			brgn_cost		--  7 digit(example 1234567 -> 12345.67)
--			brgncust_cost		--  7 digit(not use)
--			stop_flg		--  1 digit(0:continue 1:stop)
--			brgn_typ		--  2 digit
--			brgn_dsc		--  9 digit
--			mbrbrgn_dsc		--  9 digit
--			brgn_costper		--  9 digit
--			brgn_div		--  2 digit
------------------------------------------------------------------------------------------
-- Author	: T.Baba
-- Start	: 2003.Oct : T.Baba : First Edition
-- Modify	: 2005.May.17 : T.Baba      : Change size of brgn_cd(3->9)
--		: 2021/01/27  : T.Saito     : brgn_typ, brgn_dsc, mbrbrgn_dsc, brgn_costper
--		: 2021/06/30  : Y.Okada     : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn52(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data			alias for $6;

		_brgn_cd		s_brgn_mst.brgn_cd%TYPE;		--  9 digit
		_plu_cd			s_brgn_mst.plu_cd%TYPE;		-- 13 digit
		_brgn_prc		s_brgn_mst.brgn_prc%TYPE;		--  7 digit
		_brgncust_prc		s_brgn_mst.brgncust_prc%TYPE;	--  7 digit
		_brgn_cost		s_brgn_mst.brgn_cost%TYPE;		--  9 digit
		_brgncust_cost		s_brgn_mst.brgn_cost%TYPE;		--  9 digit
		_stop_flg		s_brgn_mst.stop_flg%TYPE;		--  1 digit
		_upd_user		s_brgn_mst.upd_user%TYPE;
		_upd_system		s_brgn_mst.upd_system%TYPE;
		_brgn_typ		s_brgn_mst.brgn_typ%TYPE;
		_brgn_dsc		s_brgn_mst.brgn_prc%TYPE;	-- 1ver not use
		_mbrbrgn_dsc		s_brgn_mst.brgncust_prc%TYPE;	-- 1ver not use
		_brgn_costper		s_brgn_mst.brgn_costper%TYPE;
		_brgn_div		s_brgn_mst.brgn_div%TYPE;
		_set_length		int;
		_cmp_length		int;
		_plan_cd		s_brgn_mst.plan_cd%TYPE;	-- 1ver
		_name			s_brgn_mst.name%TYPE;		-- 1ver
		_svs_typ		s_brgn_mst.svs_typ%TYPE;	-- 1ver
		_start_datetime		s_brgn_mst.start_datetime%TYPE;	-- 1ver
		_end_datetime		s_brgn_mst.end_datetime%TYPE;	-- 1ver
	BEGIN
		_cmp_length := 9+13+7+7+9+9+1;
		_set_length := octet_length(_data);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		_brgn_cd := substring(_data FROM 1 FOR 9);
		_plu_cd := substring(_data FROM 10 FOR 13);
		_brgn_prc := substring(_data FROM 23 FOR 7);
		_brgncust_prc := substring(_data FROM 30 FOR 7);
		_brgn_cost := substring(_data FROM 37 FOR 7) || ''.'' || substring(_data FROM 44 FOR 2);
		_brgncust_cost := substring(_data FROM 46 FOR 7) || ''.'' || substring(_data FROM 53 FOR 2);
		_stop_flg := substring(_data FROM 55 FOR 1);

		_brgn_typ := 0;
		_brgn_dsc := 0;
		_mbrbrgn_dsc := 0;
		_brgn_costper := 0.00;
		_brgn_div := 0;
		IF _set_length  >= (_cmp_length+2+9+9+9+2) THEN
			_brgn_typ	:= substring(_data FROM 56 FOR 2);
			_brgn_dsc	:= substring(_data FROM 58 FOR 9);
			_mbrbrgn_dsc	:= substring(_data FROM 67 FOR 9);
			_brgn_costper	:= substring(_data FROM 76 FOR 7)  || ''.'' || substring(_data FROM 83 FOR 2);
			_brgn_div	:= substring(_data FROM 85 FOR 2);
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
-- update s_brgn_mst
			SELECT plan_cd, name, svs_typ, start_datetime, end_datetime
				INTO _plan_cd, _name, _svs_typ, _start_datetime, _end_datetime
				FROM s_brgn_mst
				WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd AND plu_cd = ''0000000000000'';
			IF NOT FOUND THEN
				RAISE EXCEPTION ''plan_cd not found where s_brgn_mst:%'', _brgn_cd;
			END IF;

			UPDATE s_brgn_mst SET
				brgn_typ = _brgn_typ, brgn_prc = _brgn_prc, brgn_cost = _brgn_cost, brgncust_prc = _brgncust_prc, stop_flg = _stop_flg,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
				, brgn_costper = _brgn_costper, brgn_div = _brgn_div
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd AND plu_cd = _plu_cd;

-- insert s_brgn_mst
			INSERT INTO s_brgn_mst(
				comp_cd, stre_cd, plu_cd, plan_cd, brgn_cd, brgn_typ, showorder, brgn_prc, brgn_cost, brgncust_prc, consist_val1,
				gram_prc, markdown_flg, markdown, imagedata_cd, advantize_cd, labelsize, stop_flg,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				, brgn_costper, brgn_div
				, name, svs_typ, start_datetime, end_datetime
				, sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ, sale_cnt
				, card1, card2, card3, card4, card5
				)
			SELECT _comp_cd, _stre_cd, _plu_cd, _plan_cd, _brgn_cd, _brgn_typ, 0, _brgn_prc, _brgn_cost, _brgncust_prc, 0,
				0, 0, -1, -1, -1, 0, _stop_flg,
				_updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
				, _brgn_costper, _brgn_div
				, _name, _svs_typ, _start_datetime, _end_datetime
				, 1, 1, 1, 1, 1, 1, 1, 2, -1
				, -1, -1, -1, -1, -1
			WHERE _plu_cd NOT IN (SELECT plu_cd FROM s_brgn_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd AND plu_cd = _plu_cd);
		ELSE IF _set_type = 1 THEN
-- delete s_brgn_mst
			DELETE FROM s_brgn_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND brgn_cd = _brgn_cd AND plu_cd = _plu_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
