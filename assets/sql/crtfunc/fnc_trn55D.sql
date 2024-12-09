--=======================================================================================
-- c_plu_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete 2:Change pos_name only
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			plu_cd			-- 13 digit
--		$6 -- plu kana name
--		$7 -- plu name
--		$8 -- data2
--			pos_prc			-- 7 digit
--			cust_prc		-- 7 digit
--			smlcls_cd		-- 6 digit
--			cost_prc		-- 9 digit( example 123456789 -> 1234567.89 )
--			rbtpremium_per		-- 4 digit( example 1234 -> 12.34 )
--			tax_cd_1		-- 2 digit
--			prc_chg_flg		-- 1 digit( 1:enable 2:disable )
--			rbttarget_flg		-- 1 digit( 1:enable 2:disable )
--			stl_dsc_flg		-- 1 digit( 1:enable 2:disable )
--			nonact_flg		-- 1 digit( 1:enable 2:disable )
--			multprc_flg		-- 1 digit( 1:enable 2:disable )
--			pctr_tckt_flg		-- 1 digit( 0:no object 1:object )
--			item_typ		-- 2 digit
--			weight_flg		-- 1 digit( 0:normal 1:weight )
--			btl_prc			-- 5 digit( TW: surtax)
--			clsdsc_flg		-- 1 digit
--			point_add		-- 7 digit
--			instruct_prc		-- 7 digit
--			producer_cd		-- 9 digit
--			guara_month		-- 3 digit
--			self_alert_flg		-- 1 digit
--			mny_tckt_flg		-- 1 digit
--			brgn_cd4		-- 3 digit(1verは無い)
--			mbrdsc_flg		-- 1 digit
--			mbrdsc_prc		-- 7 digit
--			tax_exemption_flg	-- 1 digit( 0:上位参照、1:消耗品、2:一般、3:対象外 )
--			instruct_prc_tax	-- 7 digit(1verは無い)
--			bc_tckt_cnt		-- 3 digit
--			liqr_typcapa		-- 7 digit
--			alcohol_per		-- 4 digit( example 1234 -> 12.34 )
--			user_val_1		-- 7 digit
--			liqrtax_cd		-- 6 digit
--			user_val_2		-- 6 digit
--                                     data2 all 130 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2021/01/27 : T.Saito     : First Edition  trn55C -> trn55D
-- Modify	: 2021/06/30 : Y.Okada     : 1ver対応
-- 		: 2021/11/26 : Y.Okada     : 酒税免税対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn55D(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(50), VARCHAR(50), VARCHAR(200)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;	--1ver
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_plu_kana_name		alias for $7;
		_plu_name		alias for $8;
		_data2			alias for $9;
		
		 dt                     c_plu_mst%ROWTYPE;
		_org_plu_name		c_plu_mst.pos_name%TYPE;		-- 50 digit
		_set_plu_name		c_plu_mst.pos_name%TYPE;		-- 50 digit
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 13;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;
		_cmp_length := 14+6+9+4+2+9+5+1+7+7+9+3+1+1+3+1+7+1+7+3;
		_set_length := octet_length(_data2);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.plu_cd		:= substring(_data1 FROM 1 FOR 13);

		dt.pos_prc		:= substring(_data2 FROM 1 FOR 7);
		dt.cust_prc		:= substring(_data2 FROM 8 FOR 7);
		dt.smlcls_cd		:= substring(_data2 FROM 15 FOR 6);
		dt.cost_prc		:= substring(_data2 FROM 21 FOR 7) || ''.'' || substring(_data2 FROM 28 FOR 2);
		dt.rbtpremium_per	:= substring(_data2 FROM 30 FOR 2) || ''.'' || substring(_data2 FROM 32 FOR 2);
		dt.tax_cd_1		:= substring(_data2 FROM 34 FOR 2);
		dt.prc_chg_flg		:= substring(_data2 FROM 36 FOR 1);
	 	dt.rbttarget_flg	:= substring(_data2 FROM 37 FOR 1);
		dt.stl_dsc_flg		:= substring(_data2 FROM 38 FOR 1);
		dt.nonact_flg		:= substring(_data2 FROM 39 FOR 1);
		dt.multprc_flg		:= substring(_data2 FROM 40 FOR 1);
		dt.pctr_tckt_flg	:= substring(_data2 FROM 41 FOR 1);
		dt.item_typ		:= substring(_data2 FROM 42 FOR 2);
		dt.weight_flg		:= substring(_data2 FROM 44 FOR 1);
		dt.btl_prc              := substring(_data2 FROM 45 FOR 5);
		dt.clsdsc_flg		:= substring(_data2 FROM 50 FOR 1);
		dt.point_add		:= substring(_data2 FROM 51 FOR 7);
		dt.instruct_prc		:= substring(_data2 FROM 58 FOR 7);
		dt.producer_cd		:= substring(_data2 FROM 65 FOR 9);
		dt.guara_month		:= substring(_data2 FROM 74 FOR 3);
		dt.self_alert_flg	:= substring(_data2 FROM 77 FOR 1);
		dt.mny_tckt_flg		:= substring(_data2 FROM 78 FOR 1);
--		dt.brgn_cd4		:= substring(_data2 FROM 79 FOR 3);
		dt.mbrdsc_flg		:= substring(_data2 FROM 82 FOR 1);
		dt.mbrdsc_prc		:= substring(_data2 FROM 83 FOR 7);
		dt.tax_exemption_flg	:= substring(_data2 FROM 90 FOR 1);
--		dt.instruct_prc_tax	:= substring(_data2 FROM 91 FOR 7);
		dt.bc_tckt_cnt		:= substring(_data2 FROM 98 FOR 3);
		dt.liqr_typcapa		:= 0;
		dt.alcohol_per		:= 0.0;
		dt.user_val_1		:= 0;
		dt.liqrtax_cd		:= 0;
		dt.user_val_2		:= 0;

		IF _set_length > _cmp_length THEN
			dt.liqr_typcapa	:= substring(_data2 FROM 101 FOR 7);
			dt.alcohol_per	:= substring(_data2 FROM 108 FOR 2) || ''.'' || substring(_data2 FROM 110 FOR 2);
			dt.user_val_1	:= substring(_data2 FROM 112 FOR 7);
			dt.liqrtax_cd	:= substring(_data2 FROM 119 FOR 6);
			dt.user_val_2	:= substring(_data2 FROM 125 FOR 6);
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
-- update c_plu_mst
			SELECT INTO dt.mdlcls_cd mdlcls_cd FROM c_cls_mst WHERE smlcls_cd = dt.smlcls_cd AND cls_typ = 3;
			IF NOT FOUND THEN
				RAISE EXCEPTION ''mdlcls_cd not found where smlcls_cd:%'', dt.smlcls_cd;
			END IF;

			SELECT INTO dt.lrgcls_cd lrgcls_cd FROM c_cls_mst WHERE mdlcls_cd = dt.mdlcls_cd AND cls_typ = 2;
			IF NOT FOUND THEN
				RAISE EXCEPTION ''mdlcls_cd not found where mdlcls_cd:%'', dt.mdlcls_cd;
			END IF;

			dt.tnycls_cd := 999999;
			SELECT INTO _org_plu_name pos_name FROM c_plu_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plu_cd = dt.plu_cd;
			IF octet_length(_plu_name) = 0 THEN
				_set_plu_name := _org_plu_name;
			ELSE
				_set_plu_name := _plu_name;
			END IF;

-- update c_plu_mst 
			UPDATE c_plu_mst SET
				lrgcls_cd=dt.lrgcls_cd, mdlcls_cd=dt.mdlcls_cd, smlcls_cd=dt.smlcls_cd, tnycls_cd=dt.tnycls_cd,
				pos_name=_set_plu_name, item_name=_set_plu_name, pos_prc=dt.pos_prc, cust_prc=dt.cust_prc, 
				cost_prc=dt.cost_prc, cost_per=0.0, rbtpremium_per=dt.rbtpremium_per, tax_cd_1=dt.tax_cd_1, nonact_flg=dt.nonact_flg,
				prc_chg_flg=dt.prc_chg_flg, rbttarget_flg=dt.rbttarget_flg, stl_dsc_flg=dt.stl_dsc_flg, item_typ = dt.item_typ,
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system,
				weight_flg=dt.weight_flg, pctr_tckt_flg=dt.pctr_tckt_flg, multprc_flg=dt.multprc_flg,
				btl_prc=dt.btl_prc, clsdsc_flg=dt.clsdsc_flg, point_add=dt.point_add, instruct_prc=dt.instruct_prc
				, producer_cd=dt.producer_cd, guara_month=dt.guara_month, self_alert_flg=dt.self_alert_flg, mny_tckt_flg=dt.mny_tckt_flg
				, mbrdsc_flg=dt.mbrdsc_flg, mbrdsc_prc=dt.mbrdsc_prc, tax_exemption_flg=dt.tax_exemption_flg
				, bc_tckt_cnt = dt.bc_tckt_cnt, liqr_typcapa=dt.liqr_typcapa, alcohol_per=dt.alcohol_per
				, user_val_1=dt.user_val_1, liqrtax_cd=dt.liqrtax_cd, user_val_2=dt.user_val_2
			WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND plu_cd=dt.plu_cd;

-- insert c_plu_mst
			IF NOT FOUND THEN
				INSERT INTO c_plu_mst(
					comp_cd, stre_cd, plu_cd, lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, producer_cd, bar_typ,
					item_typ, pos_name, item_name, instruct_prc, pos_prc, cust_prc,
					cost_prc, cost_per, rbtpremium_per, tax_cd_1, nonact_flg, prc_chg_flg, rbttarget_flg, stl_dsc_flg,
					bc_tckt_cnt, weight_cnt, plu_tare, self_cnt_flg, guara_month,
					multprc_flg, multprc_per, ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system, weight_flg, pctr_tckt_flg, 
					btl_prc, clsdsc_flg, point_add, mny_tckt_flg, self_alert_flg, mbrdsc_flg, mbrdsc_prc, tax_exemption_flg,
					liqr_typcapa, alcohol_per, user_val_1, liqrtax_cd, user_val_2
					)
				SELECT _comp_cd, _stre_cd, dt.plu_cd, dt.lrgcls_cd, dt.mdlcls_cd, dt.smlcls_cd, dt.tnycls_cd, dt.producer_cd, 0,
					dt.item_typ, _set_plu_name, _set_plu_name, dt.instruct_prc, dt.pos_prc, dt.cust_prc,
					dt.cost_prc, 0.0, dt.rbtpremium_per, dt.tax_cd_1, dt.nonact_flg, dt.prc_chg_flg, dt.rbttarget_flg, dt.stl_dsc_flg,
					dt.bc_tckt_cnt, 0, 0, 0, dt.guara_month,
					dt.multprc_flg, 0.0, _updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system, dt.weight_flg, dt.pctr_tckt_flg,
					dt.btl_prc, dt.clsdsc_flg, dt.point_add, dt.mny_tckt_flg, dt.self_alert_flg, dt.mbrdsc_flg, dt.mbrdsc_prc, dt.tax_exemption_flg,
					dt.liqr_typcapa, dt.alcohol_per, dt.user_val_1, dt.liqrtax_cd, dt.user_val_2
				WHERE dt.plu_cd NOT IN (SELECT plu_cd FROM c_plu_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plu_cd = dt.plu_cd);
			END IF;

		ELSE
			IF _set_type = 2 THEN
-- change pos_name
				UPDATE c_plu_mst SET pos_name=_plu_name, item_name=_plu_name, upd_datetime=_updins_datetime, status = 1,
					upd_user = _upd_user, upd_system = dt.upd_system
				WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND plu_cd=dt.plu_cd;


			ELSE IF _set_type = 1 THEN
-- delete c_plu_mst
				DELETE FROM c_plu_mst WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND plu_cd = dt.plu_cd;
				END IF;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
