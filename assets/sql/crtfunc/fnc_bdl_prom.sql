--=======================================================================================
-- s_bdlsch_mst -> p_promsch_mst
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2015.10.03 : F.Saitoh		: First Edition
-- Modify	: 2016.02.01 : F.Saitoh		: Add promo_ext_id
--       	: 2019.04.04 : Y.Okada 		: date_flg1~5を追加、WHERE句にprom_typを追加
--=======================================================================================
DROP TRIGGER if exists fnc_bdlsch_prom_upd_ins ON s_bdlsch_mst;
DROP TRIGGER if exists fnc_bdlsch_prom_del ON s_bdlsch_mst;
DROP TRIGGER if exists fnc_bdlsch_prom_truncate ON s_bdlsch_mst;
DROP FUNCTION if exists fnc_bdlsch_prom_upd_ins ( );
DROP FUNCTION if exists fnc_bdlsch_prom_del ( );
DROP FUNCTION if exists fnc_bdlsch_prom_truncate ( );

CREATE FUNCTION fnc_bdlsch_prom_upd_ins ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	s_bdlsch_mst%ROWTYPE;
	BEGIN
		IF TG_OP = ''UPDATE'' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.bdl_cd = old.bdl_cd;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.bdl_cd = new.bdl_cd;
		END IF;
		UPDATE p_promsch_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.bdl_cd,
			prom_typ = 2, sch_typ = new.bdl_typ, prom_name = new.name,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, trends_typ = new.trends_typ,
			form_qty1 = new.bdl_qty1, form_qty2 = new.bdl_qty2, form_qty3 = new.bdl_qty3,
			form_qty4 = new.bdl_qty4, form_qty5 = new.bdl_qty5,
			form_prc1 = new.bdl_prc1, form_prc2 = new.bdl_prc2, form_prc3 = new.bdl_prc3,
			form_prc4 = new.bdl_prc4, form_prc5 = new.bdl_prc5,
			av_prc = new.bdl_avprc, rec_limit = new.limit_cnt, low_limit = new.low_limit,
			cust_form_prc1 = new.mbdl_prc1, cust_form_prc2 = new.mbdl_prc2, cust_form_prc3 = new.mbdl_prc3,
			cust_form_prc4 = new.mbdl_prc4, cust_form_prc5 = new.mbdl_prc5,
			cust_av_prc = new.mbdl_avprc, stop_flg = new.stop_flg, div_cd = new.div_cd,
			avprc_adpt_flg = new.avprc_adpt_flg, avprc_util_flg = new.avprc_util_flg,
			promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			date_flg1 = new.date_flg1, date_flg2 = new.date_flg2, date_flg3 = new.date_flg3,
			date_flg4 = new.date_flg4, date_flg5 = new.date_flg5
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.bdl_cd
			AND prom_typ=2 AND item_cd='''' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
		IF NOT FOUND THEN
			INSERT INTO p_promsch_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				prom_typ, sch_typ, prom_name,
				start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ,
				form_qty1, form_qty2, form_qty3, form_qty4, form_qty5,
				form_prc1, form_prc2, form_prc3, form_prc4, form_prc5,
				av_prc, rec_limit, low_limit,
				cust_form_prc1, cust_form_prc2, cust_form_prc3, cust_form_prc4, cust_form_prc5,
				cust_av_prc, stop_flg, div_cd,
				avprc_adpt_flg, avprc_util_flg, promo_ext_id, item_cd,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
				date_flg1, date_flg2, date_flg3, date_flg4, date_flg5
			)
			SELECT 
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.bdl_cd,
				2, new.bdl_typ, new.name,
				new.start_datetime, new.end_datetime, new.timesch_flg,
				new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.trends_typ,
				new.bdl_qty1, new.bdl_qty2, new.bdl_qty3, new.bdl_qty4, new.bdl_qty5,
				new.bdl_prc1, new.bdl_prc2, new.bdl_prc3, new.bdl_prc4, new.bdl_prc5,
				new.bdl_avprc, new.limit_cnt, new.low_limit,
				new.mbdl_prc1, new.mbdl_prc2, new.mbdl_prc3, new.mbdl_prc4, new.mbdl_prc5,
				new.mbdl_avprc, new.stop_flg, new.div_cd,
				new.avprc_adpt_flg, new.avprc_util_flg, new.promo_ext_id, '''',
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
				new.date_flg1, new.date_flg2, new.date_flg3, new.date_flg4, new.date_flg5
			WHERE new.bdl_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.bdl_cd
				AND prom_typ=2 AND item_cd='''' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_bdlsch_prom_del ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar AND prom_cd = old.bdl_cd AND prom_typ=2 AND item_cd='''' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
		return old;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_bdlsch_prom_truncate ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE prom_typ = 2;
		return old;
	END;
' LANGUAGE 'plpgsql';
---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_bdlsch_prom_upd_ins BEFORE insert OR update
 ON                s_bdlsch_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_bdlsch_prom_upd_ins ( );

CREATE TRIGGER     fnc_bdlsch_prom_del BEFORE delete
 ON                s_bdlsch_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_bdlsch_prom_del ( );

CREATE TRIGGER     fnc_bdlsch_prom_truncate BEFORE truncate
 ON                s_bdlsch_mst FOR STATEMENT
 EXECUTE PROCEDURE fnc_bdlsch_prom_truncate ( );

