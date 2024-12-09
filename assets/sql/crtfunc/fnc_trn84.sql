--=======================================================================================
-- c_cls_mst(lrgcls)
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			lrgcls_cd	-- 6 digit ( 1 -- 999999 )
--		$6 -- large class name
--		$7 -- data2
--			tax_cd1		-- 2 digit
--			cls_flg		-- 2 digit
--			regsale_flg	-- 1 digit
--			nonact_flg	-- 1 digit
--			dsc_flg		-- 1 digit(1verは無い)
--			dsc_prc		-- 7 digit(1verは無い)
--			max_prc		-- 7 digit
--			min_prc		-- 7 digit
--			cost_per	-- 4 digit( example 1234 -> 12.34 )
--			rbtpremium_per	-- 4 digit( example 1234 -> 12.34 )
--			prc_chg_flg	-- 1 digit
--			rbttarget_flg	-- 1 digit
--			stl_dsc_flg	-- 1 digit
--			mbrdsc_flg	-- 7 digit
--			self_alert_flg		-- 1 digit
--					----------
--					--47 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2012.06.17 : T.Saito      : First Edition
-- Modify	: 2021/06/30 : Y.Okada      : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn84(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(100), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_lrgcls_name		alias for $7;
		_data2			alias for $8;
		
		dt			c_cls_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 6;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;
		_cmp_length := 47;
		_set_length := octet_length(_data2);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.lrgcls_cd	:= substring(_data1 FROM 1 FOR 6);
		dt.tax_cd1	:= substring(_data2 FROM 1 FOR 2);
		dt.cls_flg	:= substring(_data2 FROM 3 FOR 2);
		dt.regsale_flg	:= substring(_data2 FROM 5 FOR 1);
		dt.nonact_flg	:= substring(_data2 FROM 6 FOR 1);
--		dt.dsc_flg	:= substring(_data2 FROM 7 FOR 1);
--		dt.dsc_prc	:= substring(_data2 FROM 8 FOR 7);
		dt.max_prc	:= substring(_data2 FROM 15 FOR 7);
		dt.min_prc	:= substring(_data2 FROM 22 FOR 7);
		dt.cost_per	:= substring(_data2 FROM 29 FOR 2) || ''.'' || substring(_data2 FROM 31 FOR 2);
		dt.rbtpremium_per	:= substring(_data2 FROM 33 FOR 2) || ''.'' || substring(_data2 FROM 35 FOR 2);
		dt.prc_chg_flg	:= substring(_data2 FROM 37 FOR 1);
		dt.rbttarget_flg	:= substring(_data2 FROM 38 FOR 1);
		dt.stl_dsc_flg	:= substring(_data2 FROM 39 FOR 1);
--		dt.mbrdsc_prc	:= substring(_data2 FROM 40 FOR 7);
		dt.self_alert_flg		:= substring(_data2 FROM 47 FOR 1);

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
			UPDATE c_cls_mst SET
				tax_cd1 = dt.tax_cd1, regsale_flg = dt.regsale_flg, name = _lrgcls_name, short_name = '''', kana_name = '''',
				nonact_flg = dt.nonact_flg, max_prc = dt.max_prc, min_prc = dt.min_prc,
				cost_per = dt.cost_per, rbtpremium_per = dt.rbtpremium_per, prc_chg_flg = dt.prc_chg_flg,
				rbttarget_flg = dt.rbttarget_flg, stl_dsc_flg = dt.stl_dsc_flg, multprc_flg = 1,
				stlplus_flg = 1, clothing_flg = 2, self_alert_flg = dt.self_alert_flg,
				dfltcls_cd = 999999, upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user,
				upd_system = dt.upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND lrgcls_cd = dt.lrgcls_cd AND cls_typ = 1;

			INSERT INTO c_cls_mst(
				comp_cd, stre_cd, cls_typ, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, tax_cd1, cls_flg, name, short_name, kana_name,
				margin_flg, itemstock_flg, orderpatrn_flg, regsale_flg, clothdeal_flg,
				nonact_flg, max_prc, min_prc,
				safestock_per, cost_per, loss_per, rbtpremium_per, autoorder_typ,
				orderbook_flg, prc_chg_flg, rbttarget_flg, stl_dsc_flg,
				labeldept_cd, multprc_flg, multprc_per, tax_exemption_flg,
				stlplus_flg, clothing_flg, pctr_tckt_flg, self_alert_flg,
				dfltcls_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
			SELECT _comp_cd, _stre_cd, 1, dt.lrgcls_cd, 0, 0, 0, dt.tax_cd1, dt.cls_flg, _lrgcls_name, '''', '''',
				0, 0, 0, dt.regsale_flg, 0,
				dt.nonact_flg, dt.max_prc, dt.min_prc,
				0, dt.cost_per, 0, dt.rbtpremium_per, 0,
				0, dt.prc_chg_flg, dt.rbttarget_flg, dt.stl_dsc_flg,
				0, 1, 0, 0,
				1, 2, 1, dt.self_alert_flg,
				999999, _updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system
			WHERE dt.lrgcls_cd NOT IN (SELECT lrgcls_cd FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND lrgcls_cd = dt.lrgcls_cd AND cls_typ = 1);


		ELSE IF _set_type = 1 THEN
			DELETE FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND lrgcls_cd = dt.lrgcls_cd AND cls_typ = 1;
			END IF;
		END IF;
				
		RETURN 4;
	END;
' LANGUAGE 'plpgsql';
