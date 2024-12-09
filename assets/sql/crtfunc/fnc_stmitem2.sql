--=======================================================================================
-- s_stmitem_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete 3:delete from plu_cd
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data
--			plu_cd			-- 13 digit
--			stm_cd			--  9 digit
--			grpno			--  1 digit
--			stm_qty			--  3 digit
--			showorder		--  4 digit
--			poppy_flg		--  1 digit
--			stop_flg		--  1 digit( 0:continue 1:stop )
------------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2007.Jul.25 : F.Saitoh : First Edition
-- Modify	: 2021/06/30  : Y.Okada  : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_stmitem2(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data			alias for $6;

		_plu_cd			s_stmitem_mst.plu_cd%TYPE;		-- 13 digit
		_stm_cd			s_stmitem_mst.stm_cd%TYPE;		--  9 digit
		_grpno			s_stmitem_mst.grpno%TYPE;		--  1 digit
		_stm_qty		s_stmitem_mst.stm_qty%TYPE;		--  3 digit
		_showorder		s_stmitem_mst.showorder%TYPE;		--  4 digit
		_poppy_flg		s_stmitem_mst.poppy_flg%TYPE;		--  1 digit
		_stop_flg		s_stmitem_mst.stop_flg%TYPE;		--  1 digit
		_upd_user		s_stmitem_mst.upd_user%TYPE;
		_upd_system		s_stmitem_mst.upd_system%TYPE;
		_set_length		int;
		_cmp_length		int;
		_plan_cd		s_stmitem_mst.plan_cd%TYPE;	--1ver
	BEGIN
		_cmp_length := 13+9+1+3+4+2;
		_set_length := octet_length(_data);
		IF _set_length < _cmp_length THEN
			IF _set_length = 23 AND _set_type = 1 THEN
				_plu_cd := substring(_data FROM 1 FOR 13);
				_stm_cd := substring(_data FROM 14 FOR 9);
				_grpno := substring(_data FROM 23 FOR 1);
			ELSE
				 IF _set_length = 13 AND _set_type = 3 THEN
				    _plu_cd := substring(_data FROM 1 FOR 13);

				 ELSE
				    RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
				 END IF;
			END IF;
		ELSE
			_plu_cd := substring(_data FROM 1 FOR 13);
			_stm_cd := substring(_data FROM 14 FOR 9);
			_grpno := substring(_data FROM 23 FOR 1);
			_stm_qty := substring(_data FROM 24 FOR 3);
			_showorder := substring(_data FROM 27 FOR 4);
			_poppy_flg := substring(_data FROM 31 FOR 1);
			_stop_flg := substring(_data FROM 32 FOR 1);
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
-- update s_stmitem_mst
			SELECT INTO _plan_cd plan_cd
				FROM s_stmsch_mst
				WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd;
			IF NOT FOUND THEN
				RAISE EXCEPTION ''plan_cd not found where s_stmsch_mst:%'', _stm_cd;
			END IF;

			UPDATE s_stmitem_mst SET
				stm_qty = _stm_qty, showorder = _showorder, poppy_flg = _poppy_flg, stop_flg = _stop_flg,
				upd_datetime = _updins_datetime, status = 1, upd_user = _upd_user, upd_system = _upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd AND grpno=_grpno AND plu_cd = _plu_cd;

-- insert s_stmitem_mst
			INSERT INTO s_stmitem_mst(
				comp_cd, stre_cd, plan_cd, plu_cd, stm_cd, grpno, stm_qty, showorder, poppy_flg, stop_flg,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
			SELECT _comp_cd, _stre_cd, _plan_cd, _plu_cd, _stm_cd, _grpno, _stm_qty, _showorder, _poppy_flg, _stop_flg,
				_updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
			WHERE _plu_cd NOT IN (SELECT plu_cd FROM s_stmitem_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd AND grpno=_grpno AND plu_cd = _plu_cd);

		ELSE
			IF _set_type = 1 THEN
-- delete s_stmitem_mst
				DELETE FROM s_stmitem_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND stm_cd = _stm_cd AND grpno=_grpno AND plu_cd = _plu_cd;
			
			ELSE IF _set_type = 3 THEN
				DELETE FROM s_stmitem_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plu_cd = _plu_cd;
				END IF;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
