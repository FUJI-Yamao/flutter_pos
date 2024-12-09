--=======================================================================================
-- c_cls_mst(mdlcls) -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data
--			middle class code	-- 6 digit
--			large class code	-- 6 digit
--			cost percent		-- 4 digit ( example : 1234 -> 12.34 )
--		$6 -- middle class name
--		$7 -- middle class kana name
------------------------------------------------------------------------------------------
-- Author	: T.Baba
-- Start	: 2003.Oct.01 : T.Baba      : First Edition
-- Modify	: 2003.Oct.21 : T.Baba      : Change default value of nonact_flg, prc_chg_flg, rbttarget_flg, stl_dsc_flg, multprc_flg
--		: 2012.Jun.17 : T.Saito     : Append lrgcls_cd, cost_per
--		: 2021/06/30  : Y.Okada     : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn81(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(100), VARCHAR(50), VARCHAR(50)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data			alias for $6;
		_mdlcls_name		alias for $7;
		_mdlcls_kana_name	alias for $8;

		_mdlcls_cd		c_cls_mst.mdlcls_cd%TYPE;		-- 6 digit

		_lrgcls_cd		c_cls_mst.lrgcls_cd%TYPE;
		_cost_per		c_cls_mst.cost_per%TYPE;
		_upd_user		c_cls_mst.upd_user%TYPE;
		_upd_system		c_cls_mst.upd_system%TYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 6;
		_set_length := octet_length(_data);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		_mdlcls_cd := substring(_data FROM 1 FOR 6);

		IF _set_length = (_cmp_length+6+4) THEN
			_lrgcls_cd	:= substring(_data FROM 7 FOR 6);
			_cost_per	:= substring(_data FROM 13 FOR 2) || ''.'' || substring(_data FROM 15 FOR 2);
		ELSE
			_lrgcls_cd	:= 999999;
			_cost_per	:= 0;
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
-- update c_mdlcls_mst
			UPDATE c_cls_mst SET
				name = _mdlcls_name, kana_name = _mdlcls_kana_name, upd_datetime = _updins_datetime, status = 1,
				upd_user = _upd_user, upd_system = _upd_system, lrgcls_cd = _lrgcls_cd,
				cost_per = _cost_per
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND mdlcls_cd = _mdlcls_cd AND cls_typ = 2;

-- insert c_mdlcls_mst
			INSERT INTO c_cls_mst(
				comp_cd, stre_cd, cls_typ, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd,
				plu_cd, cls_flg, tax_cd1, tax_cd2, tax_cd3, tax_cd4, name, short_name, kana_name,
				margin_flg, regsale_flg, clothdeal_flg, itemstock_flg, orderpatrn_flg,
				dfltcls_cd, nonact_flg, max_prc, min_prc, cost_per, loss_per,
				rbtpremium_per, prc_chg_flg, rbttarget_flg, stl_dsc_flg, labeldept_cd,
				multprc_flg, multprc_per, safestock_per, autoorder_typ, orderbook_flg,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
			SELECT _comp_cd, _stre_cd, 2, _lrgcls_cd, _mdlcls_cd, 0, 0,
				'''', 1, 1, 0, 0, 0, _mdlcls_name, '''', _mdlcls_kana_name,
				0, 0, 0, 0, 0,
				999999, 1, 0, 0, _cost_per, 0,
				1, 1, 1, 1, 0,
				1, 0, 0, 0, 0,
				_updins_datetime, _updins_datetime, 0, 0, _upd_user, _upd_system
			WHERE _mdlcls_cd NOT IN (SELECT mdlcls_cd FROM c_cls_mst WHERE mdlcls_cd = _mdlcls_cd);

		ELSE IF _set_type = 1 THEN
-- delete c_mdlcls_mst
			DELETE FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND mdlcls_cd = _mdlcls_cd AND cls_typ = 2;
			END IF;
		END IF;

		RETURN 2;
	END;
' LANGUAGE 'plpgsql';
