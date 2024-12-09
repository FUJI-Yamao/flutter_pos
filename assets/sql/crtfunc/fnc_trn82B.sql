--=======================================================================================
-- c_cls_mst(smlcls)
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			small class code	-- 6 digit ( 1 -- 999999 )
--			middle class code	-- 6 digit ( 1 -- 999999 )
--		$6 -- small class kana name
--		$7 -- small class name
--		$8 -- data2
--			max_prc			-- 7 digit
--			min_prc			-- 7 digit
--			cost_per		-- 4 digit ( example : 1234 -> 12.34 )
--			rbtpremium_per		-- 2 digit ( not use )
--			tax code		-- 2 digit ( 1 -- 10 )
--			no_compensation_flg	-- 1 digit ( not use )
--			prc_chg_flg		-- 1 digit ( 1:enable , 2:disable )
--			rbttarget_flg		-- 1 digit ( 1:enable , 2:disable )
--			minus_item_flg		-- 1 digit ( not use )
--			stl_dsc_flg		-- 1 digit ( 0:disable , 1:enable )
--			local_tax_flg		-- 1 digit ( not use )
--			time_zone_flg		-- 1 digit ( not use )
--			regsale_flg		-- 1 digit ( 0:normal , 1:out middle class )
--			mdl_perdsc_flg		-- 1 digit ( not use )
--			nonact_flg		-- 1 digit ( 1:enable , 2:disable )
--			dsc_flg			-- 1 digit ( 0:disable, 1:discount, 2:percent discount, 3:price )(1verは無い)
--			dsc_prc			-- 7 digit(1verは無い)
--			cloth_flg		-- 1 digit ( not use )
--			srv_amt1_flg		-- 1 digit ( not use )
--			srv_amt2_flg		-- 1 digit ( not use )
--			late_amt1_flg		-- 1 digit ( not use )
--			late_amt2_flg		-- 1 digit
--			rbtpremium_per		-- 4 digit ( examplu : 1234 -> 12.23 )
--			self_alert_flg		-- 1 digit
--			fil2			-- 1 digit(1verは無い)
--			autoorder_typ		-- 3 digit
--			tax_exemption_flg	-- 1 digit ( 0:設定外, 1:消耗品, 2:一般, 3:対象外)
--			stlplus_flg		-- 1 digit ( not use )
--			cls_flg			-- 2 digit ( 1:一般 62:免税事業者 )
--						----------
--						--58 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2012.06.12 : T.Saito      : First Edition
-- Modify	: 2018/03/12  :	S.Okiyama   : 免税区分"tax_exemption_flg"を追加
--       	: 2021/06/30  :	Y.Okada     : 1ver対応
--       	: 2023/01/24  :	Y.Okada     : 分類区分(免税事業者フラグ)"cls_flg"を追加
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn82B(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(50), VARCHAR(50), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_smlcls_kana_name	alias for $7;
		_smlcls_name		alias for $8;
		_data2			alias for $9;
		
		dt			c_cls_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 6+6;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;
		_cmp_length := 54;
		_set_length := octet_length(_data2);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.smlcls_cd	:= substring(_data1 FROM 1 FOR 6);
		dt.mdlcls_cd	:= substring(_data1 FROM 7 FOR 6);

		dt.max_prc	:= substring(_data2 FROM 1 FOR 7);
		dt.min_prc	:= substring(_data2 FROM 8 FOR 7);
		dt.cost_per	:= substring(_data2 FROM 15 FOR 2) || ''.'' || substring(_data2 FROM 17 FOR 2);
		dt.tax_cd1	:= substring(_data2 FROM 21 FOR 2);
		dt.prc_chg_flg	:= substring(_data2 FROM 24 FOR 1);
		dt.rbttarget_flg	:= substring(_data2 FROM 25 FOR 1);
		dt.stl_dsc_flg	:= substring(_data2 FROM 27 FOR 1);
		dt.regsale_flg	:= substring(_data2 FROM 30 FOR 1);
		dt.nonact_flg	:= substring(_data2 FROM 32 FOR 1);
--		dt.dsc_flg	:= substring(_data2 FROM 33 FOR 1);
--		dt.dsc_prc	:= substring(_data2 FROM 34 FOR 7);
		dt.rbtpremium_per	:= substring(_data2 FROM 46 FOR 2) || ''.'' || substring(_data2 FROM 48 FOR 2);
		dt.self_alert_flg	:= substring(_data2 FROM 50 FOR 1);
--		dt.fil2		:= substring(_data2 FROM 51 FOR 1);
		dt.autoorder_typ	:= substring(_data2 FROM 52 FOR 3);
		dt.tnycls_cd	:= 999999;
		dt.lrgcls_cd	:= 999999;

		dt.tax_exemption_flg	:= 3;	-- 免税区分に初期値"対象外"をセット
		-- data2に免税区分が含まれていればセットする
		IF _set_length >= (_cmp_length+1) THEN
			dt.tax_exemption_flg	:= substring(_data2 FROM 55 FOR 1);
		END IF;

		dt.cls_flg	:= 1;	-- 分類区分(免税事業者フラグ)に初期値"一般"をセット
		IF _set_length	>= (_cmp_length+1+1+2) THEN
			dt.cls_flg	:= substring(_data2 FROM 57 FOR 2);
		END IF;

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
			SELECT INTO dt.lrgcls_cd lrgcls_cd
				FROM c_cls_mst
				WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND mdlcls_cd = dt.mdlcls_cd AND cls_typ = 2;
			IF NOT FOUND THEN
				RAISE EXCEPTION ''lrgcls_cd not found where c_cls_mst mdlcls_cd:%'', dt.mdlcls_cd;
			END IF;

-- c_smlcls_mst
			UPDATE c_cls_mst SET
				mdlcls_cd = dt.mdlcls_cd, tax_cd1 = dt.tax_cd1, regsale_flg = dt.regsale_flg, name = _smlcls_name,
				kana_name = _smlcls_kana_name, dfltcls_cd = dt.tnycls_cd, upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user,
				upd_system = dt.upd_system,
				nonact_flg = dt.nonact_flg, max_prc = dt.max_prc, min_prc = dt.min_prc,
				cost_per = dt.cost_per, rbtpremium_per = dt.rbtpremium_per, prc_chg_flg = dt.prc_chg_flg,
				rbttarget_flg = dt.rbttarget_flg, stl_dsc_flg = dt.stl_dsc_flg, multprc_flg = 1,
				stlplus_flg = 1, clothing_flg = 2,
				self_alert_flg = dt.self_alert_flg, autoorder_typ = dt.autoorder_typ,
				tax_exemption_flg = dt.tax_exemption_flg
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND smlcls_cd = dt.smlcls_cd and cls_typ = 3;

			-- data2に分類区分(免税事業者フラグ)が含まれていればUPDATE
			IF _set_length	>= (_cmp_length+1+1+2) THEN
				UPDATE c_cls_mst SET
					cls_flg = dt.cls_flg
				WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND smlcls_cd = dt.smlcls_cd and cls_typ = 3;
			END IF;

			INSERT INTO c_cls_mst(
				comp_cd, stre_cd, cls_typ, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, tax_cd1, cls_flg, name, short_name, kana_name,
				margin_flg, itemstock_flg, orderpatrn_flg, regsale_flg, clothdeal_flg,
				nonact_flg, max_prc, min_prc,
				safestock_per, cost_per, loss_per, rbtpremium_per, autoorder_typ,
				orderbook_flg, prc_chg_flg, rbttarget_flg, stl_dsc_flg,
				labeldept_cd, multprc_flg, multprc_per,
				tax_exemption_flg, stlplus_flg, clothing_flg, pctr_tckt_flg, self_alert_flg,
				dfltcls_cd, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
			SELECT _comp_cd, _stre_cd, 3, dt.lrgcls_cd, dt.mdlcls_cd, dt.smlcls_cd, 0, dt.tax_cd1, dt.cls_flg, _smlcls_name, '''', _smlcls_kana_name,
				0, 0, 0, dt.regsale_flg, 0,
				dt.nonact_flg, dt.max_prc, dt.min_prc,
				0, dt.cost_per, 0, dt.rbtpremium_per, dt.autoorder_typ,
				0, dt.prc_chg_flg, dt.rbttarget_flg, dt.stl_dsc_flg,
				0, 1, 0,
				dt.tax_exemption_flg, 1, 2, 1, dt.self_alert_flg,
				dt.tnycls_cd, _updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system
			WHERE dt.smlcls_cd NOT IN (SELECT smlcls_cd FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND smlcls_cd = dt.smlcls_cd AND cls_typ = 3);

-- c_tnycls_mst
			INSERT INTO c_cls_mst(
				comp_cd, stre_cd, cls_typ, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, tax_cd1, cls_flg, name, short_name, kana_name,
				margin_flg, nonact_flg, max_prc, min_prc, safestock_per,
				cost_per, loss_per, rbtpremium_per, autoorder_typ, orderbook_flg,
				prc_chg_flg, rbttarget_flg, stl_dsc_flg, labeldept_cd, multprc_flg, multprc_per,
				itemstock_flg, orderpatrn_flg, regsale_flg, clothdeal_flg, ins_datetime,
				upd_datetime, status, send_flg, upd_user, upd_system)
			SELECT _comp_cd, _stre_cd, 4, dt.lrgcls_cd, dt.mdlcls_cd, dt.smlcls_cd, dt.tnycls_cd, 0, 0, NULL, NULL, NULL,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, _updins_datetime,
				_updins_datetime, 0, 0, dt.upd_user, dt.upd_system
			WHERE dt.tnycls_cd NOT IN (SELECT tnycls_cd FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND tnycls_cd = dt.tnycls_cd AND smlcls_cd = dt.smlcls_cd AND cls_typ = 4);


		ELSE IF _set_type = 1 THEN
			DELETE FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND smlcls_cd = dt.smlcls_cd AND cls_typ = 3;
			DELETE FROM c_cls_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND tnycls_cd = dt.tnycls_cd AND smlcls_cd = dt.smlcls_cd AND cls_typ = 4;
			END IF;
		END IF;
				
		RETURN 4;
	END;
' LANGUAGE 'plpgsql';
