--=======================================================================================
-- s_clssch_mst -> p_promsch_mst
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2015.10.08 : F.Saitoh		: First Edition
-- Modify	: 2019.04.04 : Y.Okada          : WHERE句にprom_typを追加
--=======================================================================================
DROP TRIGGER if exists fnc_clssch_prom_upd_ins ON s_clssch_mst;
DROP TRIGGER if exists fnc_clssch_prom_del ON s_clssch_mst;
DROP TRIGGER if exists fnc_clssch_prom_truncate ON s_clssch_mst;
DROP FUNCTION if exists fnc_clssch_prom_upd_ins ( );
DROP FUNCTION if exists fnc_clssch_prom_del ( );
DROP FUNCTION if exists fnc_clssch_prom_truncate ( );

CREATE FUNCTION fnc_clssch_prom_upd_ins ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	s_clssch_mst%ROWTYPE;
	BEGIN
		IF TG_OP = ''UPDATE'' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.sch_cd = old.sch_cd;
			dt.lrgcls_cd = old.lrgcls_cd;
			dt.mdlcls_cd = old.mdlcls_cd;
			dt.smlcls_cd = old.smlcls_cd;
			dt.tnycls_cd = old.tnycls_cd;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.sch_cd = new.sch_cd;
			dt.lrgcls_cd = new.lrgcls_cd;
			dt.mdlcls_cd = new.mdlcls_cd;
			dt.smlcls_cd = new.smlcls_cd;
			dt.tnycls_cd = new.tnycls_cd;
		END IF;
		UPDATE p_promsch_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.sch_cd,
			lrgcls_cd = new.lrgcls_cd, mdlcls_cd = new.mdlcls_cd, smlcls_cd = new.smlcls_cd, tnycls_cd = new.tnycls_cd,
			prom_typ = 4, sch_typ = new.svs_class, prom_name = new.name,
			svs_typ = new.svs_typ, dsc_typ = new.dsc_typ, dsc_val = new.dsc_prc, cust_dsc_val = new.mdsc_prc,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, trends_typ = new.trends_typ,
			stop_flg = new.stop_flg, div_cd = new.div_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.sch_cd
			AND prom_typ=4 AND item_cd='''' AND lrgcls_cd=dt.lrgcls_cd AND mdlcls_cd=dt.mdlcls_cd AND smlcls_cd=dt.smlcls_cd AND tnycls_cd=dt.tnycls_cd;
		IF NOT FOUND THEN
			INSERT INTO p_promsch_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd,
				prom_typ, sch_typ, prom_name,
				svs_typ, dsc_typ, dsc_val, cust_dsc_val,
				start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, trends_typ,
				stop_flg, div_cd, promo_ext_id, item_cd,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
			)
			SELECT 
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.sch_cd,
				new.lrgcls_cd, new.mdlcls_cd, new.smlcls_cd, new.tnycls_cd,
				4, new.svs_class, new.name,
				new.svs_typ, new.dsc_typ, new.dsc_prc, new.mdsc_prc,
				new.start_datetime, new.end_datetime, new.timesch_flg,
				new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.trends_typ,
				new.stop_flg, new.div_cd, new.promo_ext_id, '''',
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
			WHERE new.sch_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.sch_cd
				AND prom_typ=4 AND item_cd='''' AND lrgcls_cd=new.lrgcls_cd AND mdlcls_cd=new.mdlcls_cd AND smlcls_cd=new.smlcls_cd AND tnycls_cd=new.tnycls_cd);
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_clssch_prom_del ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar AND prom_cd = old.sch_cd AND prom_typ=4 AND item_cd='''' AND lrgcls_cd=old.lrgcls_cd AND mdlcls_cd=old.mdlcls_cd AND smlcls_cd=old.smlcls_cd AND tnycls_cd=old.tnycls_cd;
		return old;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_clssch_prom_truncate ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE prom_typ = 4;
		return old;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_clssch_prom_upd_ins BEFORE insert OR update
 ON                s_clssch_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_clssch_prom_upd_ins ( );

CREATE TRIGGER     fnc_clssch_prom_del BEFORE delete
 ON                s_clssch_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_clssch_prom_del ( );

CREATE TRIGGER     fnc_clssch_prom_truncate BEFORE truncate
 ON                s_clssch_mst FOR STATEMENT
 EXECUTE PROCEDURE fnc_clssch_prom_truncate ( );