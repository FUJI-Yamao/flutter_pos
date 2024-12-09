--=======================================================================================
-- c_prcchg_mst to histlog_mst update PL/PGSQL TRIGGER Function
--
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2004.Oct.27 : F.Saitoh : First Edition
-- Modify	: 2006.Oct.04 : F.Saitoh : Modify postgresql 8.1.4
-- Modify	: 2017/10/17  : S.Uchino    : V１対応を行なった
--=======================================================================================
DROP TRIGGER if exists fnc_prcchg_i ON c_prcchg_mst;
DROP FUNCTION if exists fnc_prcchg_i ( );
CREATE FUNCTION fnc_prcchg_i ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	c_prcchg_mst%ROWTYPE;
		histdt	c_histlog_mst%ROWTYPE;
		pludt	c_plu_mst%ROWTYPE;
		mark	text :=''\t'';
	BEGIN
-- 2006/10/04
		IF new.plu_cd = NULL THEN
			RAISE EXCEPTION ''plu_cd is NULL'';
		END IF;

		dt.serial_no := (CASE WHEN new.serial_no is NULL THEN 0 ELSE new.serial_no END);
		IF dt.serial_no = 0 THEN
			RAISE EXCEPTION ''serial_no is NULL or 0'';
		END IF;

		dt.seq_no := (CASE WHEN new.seq_no is NULL THEN 0 ELSE new.seq_no END);
		IF dt.seq_no = 0 THEN
			RAISE EXCEPTION ''seq_no is NULL or 0'';
		END IF;

		dt.comp_cd := (CASE WHEN new.comp_cd is NULL THEN 0 ELSE new.comp_cd END);
		IF dt.comp_cd = 0 THEN
			RAISE EXCEPTION ''comp_cd is NULL or 0'';
		END IF;

		dt.stre_cd := (CASE WHEN new.stre_cd is NULL THEN 0 ELSE new.stre_cd END);
		IF dt.stre_cd = 0 THEN
			RAISE EXCEPTION ''stre_cd is NULL or 0'';
		END IF;

		dt.plu_cd := new.plu_cd;
		dt.pos_prc := (CASE WHEN new.pos_prc is NULL THEN 0 ELSE new.pos_prc END);
		dt.cust_prc := (CASE WHEN new.cust_prc is NULL THEN 0 ELSE new.cust_prc END);
		dt.mac_no := (CASE WHEN new.mac_no is NULL THEN 0 ELSE new.mac_no END);
		dt.staff_cd := (CASE WHEN new.staff_cd is NULL THEN 0 ELSE new.staff_cd END);
		dt.maker_cd := (CASE WHEN new.maker_cd is NULL THEN 0 ELSE new.maker_cd END);
		dt.ins_datetime := (CASE WHEN new.ins_datetime is NULL THEN ''||now()||'' ELSE new.ins_datetime END);
		dt.upd_datetime := (CASE WHEN new.upd_datetime is NULL THEN ''||now()||'' ELSE new.upd_datetime END);

		SELECT * INTO pludt FROM c_plu_mst WHERE comp_cd=dt.comp_cd AND stre_cd=dt.stre_cd AND plu_cd=dt.plu_cd;

--		RAISE NOTICE ''dt.comp_cd % dt.stre_cd % dt.plu_cd % lrgcls_cd %'', dt.comp_cd,dt.stre_cd,dt.plu_cd, pludt.lrgcls_cd;
		
		histdt.data1 :=
			dt.comp_cd			|| mark || dt.stre_cd			|| mark || dt.plu_cd			|| mark ||
			pludt.lrgcls_cd			|| mark || pludt.mdlcls_cd		|| mark || pludt.smlcls_cd		|| mark ||
			pludt.tnycls_cd			|| mark ;		

-- NULL check
		IF pludt.eos_cd NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.eos_cd;
		END IF;

		histdt.data1 := 
			histdt.data1			|| mark || pludt.bar_typ		|| mark || pludt.item_typ		|| mark ;

-- NULL check
		IF pludt.item_name NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.item_name;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark ;

-- NULL check
		IF pludt.pos_name NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.pos_name;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark ;

-- NULL check
		IF pludt.list_typcapa NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.list_typcapa;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || pludt.list_prc		|| mark || pludt.instruct_prc		|| mark ||
			dt.pos_prc			|| mark || dt.cust_prc			|| mark || pludt.cost_prc		|| mark ||
			pludt.chk_amt			|| mark || pludt.tax_cd_1		|| mark || pludt.tax_cd_2		|| mark ||
			pludt.tax_cd_3			|| mark || pludt.tax_cd_4		|| mark || pludt.cost_tax_cd		|| mark ||
			pludt.cost_per			|| mark || pludt.rbtpremium_per		|| mark || pludt.nonact_flg		|| mark ||
			pludt.prc_chg_flg		|| mark || pludt.rbttarget_flg		|| mark || pludt.stl_dsc_flg		|| mark ||
			pludt.weight_cnt		|| mark || pludt.plu_tare		|| mark || pludt.self_cnt_flg		|| mark ||
			pludt.guara_month		|| mark || pludt.multprc_flg		|| mark || pludt.multprc_per		|| mark ||
			pludt.weight_flg		|| mark || pludt.mbrdsc_flg		|| mark || pludt.mbrdsc_prc		|| mark ||
			pludt.mny_tckt_flg		|| mark || pludt.stlplus_flg		|| mark || pludt.prom_tckt_no		|| mark ||
			pludt.weight			|| mark || pludt.pctr_tckt_flg		|| mark || pludt.btl_prc		|| mark ||
			pludt.clsdsc_flg		|| mark || pludt.cpn_flg		|| mark || pludt.cpn_prc		|| mark ||
			pludt.plu_cd_flg		|| mark || pludt.self_alert_flg		|| mark || pludt.chg_ckt_flg		|| mark ||
			pludt.self_weight_flg		|| mark ;

-- NULL check
		IF pludt.msg_name NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.msg_name;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || pludt.msg_flg		|| mark || pludt.msg_name_cd		|| mark ;

-- NULL check
		IF pludt.pop_msg NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.pop_msg;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || pludt.pop_msg_flg		|| mark || pludt.pop_msg_cd		|| mark ||
			pludt.liqrcls_cd		|| mark || pludt.liqr_typcapa		|| mark || pludt.alcohol_per		|| mark ||
			pludt.liqrtax_cd		|| mark ;

-- NULL check
		IF pludt.use1_start_date NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.use1_start_date;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark ;
-- NULL check
		IF pludt.use2_start_date NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.use2_start_date;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || pludt.prc_exe_flg		|| mark || pludt.tmp_exe_flg		|| mark ||
			pludt.cust_dtl_flg		|| mark || pludt.tax_exemption_flg	|| mark || pludt.point_add		|| mark ||
			pludt.coupon_flg		|| mark || pludt.kitchen_prn_flg	|| mark || pludt.pricing_flg		|| mark ||
			pludt.bc_tckt_cnt		|| mark ; 


-- NULL check
		IF pludt.last_sale_datetime NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.last_sale_datetime;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || dt.maker_cd			|| mark || pludt.user_val_1		|| mark ||
			pludt.user_val_2		|| mark || pludt.user_val_3		|| mark || pludt.user_val_4		|| mark ||
			pludt.user_val_5		|| mark ;

-- NULL check
		IF pludt.user_val_6 NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.user_val_6;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || pludt.prc_upd_system	|| mark ;

-- NULL check
		IF pludt.ins_datetime NOTNULL THEN
			histdt.data1 := histdt.data1	|| pludt.ins_datetime;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark ;

-- NULL check
		IF pludt.upd_datetime NOTNULL THEN
			histdt.data1 := histdt.data1	|| dt.upd_datetime;
		END IF;

		histdt.data1 :=
			histdt.data1			|| mark || pludt.status			|| mark || pludt.send_flg 		|| mark ||
			dt.staff_cd			|| mark || pludt.upd_system		|| mark || pludt.cust_prc2		|| mark ||
			pludt.mbrdsc_prc2		|| mark || pludt.producer_cd ;
			
--		RAISE NOTICE ''histdt.data1 %'', histdt.data1;


		INSERT INTO c_histlog_mst(
			ins_datetime, comp_cd, stre_cd, table_name, mode, mac_flg, data1, data2
		) VALUES (
			now(), dt.comp_cd, dt.stre_cd, ''c_plu_mst'', ''0'', ''1'', histdt.data1, NULL
		);

		return new;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_prcchg_i AFTER insert
 ON                c_prcchg_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_prcchg_i ( );
