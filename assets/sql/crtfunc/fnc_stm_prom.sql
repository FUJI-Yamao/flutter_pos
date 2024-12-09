--=======================================================================================
-- s_stmsch_mst -> p_promsch_mst
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2015.10.03 : F.Saitoh		: First Edition
-- Modify	: 2016.02.01 : F.Saitoh		: Add promo_ext_id
--       	: 2019.04.04 : Y.Okada 		: date_flg1~5を追加、WHERE句にprom_typを追加
--=======================================================================================
DROP TRIGGER if exists fnc_stmsch_prom_upd_ins ON s_stmsch_mst;
DROP TRIGGER if exists fnc_stmsch_prom_del ON s_stmsch_mst;
DROP TRIGGER if exists fnc_stmsch_prom_truncate ON s_stmsch_mst;
DROP FUNCTION if exists fnc_stmsch_prom_upd_ins ( );
DROP FUNCTION if exists fnc_stmsch_prom_del ( );
DROP FUNCTION if exists fnc_stmsch_prom_truncate ( );

CREATE FUNCTION fnc_stmsch_prom_upd_ins ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	s_stmsch_mst%ROWTYPE;
	BEGIN
		IF TG_OP = ''UPDATE'' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.stm_cd = old.stm_cd;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.stm_cd = new.stm_cd;
		END IF;
		UPDATE p_promsch_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.stm_cd,
			prom_typ = 3, prom_name = new.name,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg,
			member_qty = new.member_qty, rec_limit = new.limit_cnt, stop_flg = new.stop_flg, trends_typ = new.trends_typ,
			sch_typ = new.dsc_flg,
			form_prc1 = new.stm_prc, form_prc2 = new.stm_prc2, form_prc3 = new.stm_prc3,
			form_prc4 = new.stm_prc4, form_prc5 = new.stm_prc5,
			cust_form_prc1 = new.mstm_prc, cust_form_prc2 = new.mstm_prc2, cust_form_prc3 = new.mstm_prc3,
			cust_form_prc4 = new.mstm_prc4, cust_form_prc5 = new.mstm_prc5,
			div_cd = new.div_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			date_flg1 = new.date_flg1, date_flg2 = new.date_flg2, date_flg3 = new.date_flg3,
			date_flg4 = new.date_flg4, date_flg5 = new.date_flg5
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.stm_cd
			AND prom_typ=3 AND item_cd='''' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
		IF NOT FOUND THEN
			INSERT INTO p_promsch_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				prom_typ, prom_name,
				start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg,
				member_qty, rec_limit, stop_flg, trends_typ,
				sch_typ,
				form_prc1, form_prc2, form_prc3, form_prc4, form_prc5,
				cust_form_prc1, cust_form_prc2, cust_form_prc3, cust_form_prc4, cust_form_prc5,
				div_cd, promo_ext_id, item_cd,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
				date_flg1, date_flg2, date_flg3, date_flg4, date_flg5
			)
			SELECT 
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.stm_cd,
				3, new.name,
				new.start_datetime, new.end_datetime, new.timesch_flg,
				new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg,
				new.member_qty, new.limit_cnt, new.stop_flg, new.trends_typ,
				new.dsc_flg,
				new.stm_prc, new.stm_prc2, new.stm_prc3, new.stm_prc4, new.stm_prc5,
				new.mstm_prc, new.mstm_prc2, new.mstm_prc3, new.mstm_prc4, new.mstm_prc5,
				new.div_cd, new.promo_ext_id, '''',
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
				new.date_flg1, new.date_flg2, new.date_flg3, new.date_flg4, new.date_flg5
			WHERE new.stm_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.stm_cd
				AND prom_typ=3 AND item_cd='''' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_stmsch_prom_del ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar AND prom_cd = old.stm_cd AND prom_typ=3 AND item_cd='''' AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
		return old;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_stmsch_prom_truncate ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE prom_typ = 3;
		return old;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_stmsch_prom_upd_ins BEFORE insert OR update
 ON                s_stmsch_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_stmsch_prom_upd_ins ( );

CREATE TRIGGER     fnc_stmsch_prom_del BEFORE delete
 ON                s_stmsch_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_stmsch_prom_del ( );

CREATE TRIGGER     fnc_stmsch_prom_truncate BEFORE truncate
 ON                s_stmsch_mst FOR STATEMENT
 EXECUTE PROCEDURE fnc_stmsch_prom_truncate ( );
