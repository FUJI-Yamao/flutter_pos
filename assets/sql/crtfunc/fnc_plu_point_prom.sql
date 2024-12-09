--=======================================================================================
-- s_plu_point_mst -> p_promsch_mst
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2015.10.03 : F.Saitoh		: First Edition
-- Modify	: 2018.04.11 : T.Ando		: 商品倍率ポイントに対応
--		: 
--=======================================================================================
DROP TRIGGER if exists fnc_plu_point_prom_upd_ins ON s_plu_point_mst;
DROP TRIGGER if exists fnc_plu_point_prom_del ON s_plu_point_mst;
DROP TRIGGER if exists fnc_plu_point_prom_truncate ON s_plu_point_mst;
DROP FUNCTION if exists fnc_plu_point_prom_upd_ins ( );
DROP FUNCTION if exists fnc_plu_point_prom_del ( );
DROP FUNCTION if exists fnc_plu_point_prom_truncate ( );

CREATE FUNCTION fnc_plu_point_prom_upd_ins ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	s_plu_point_mst%ROWTYPE;
	BEGIN
		IF TG_OP = ''UPDATE'' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.plusch_cd = old.plusch_cd;
			dt.plu_cd = old.plu_cd;
			dt.lrgcls_cd = old.lrgcls_cd;
			dt.mdlcls_cd = old.mdlcls_cd;
			dt.smlcls_cd = old.smlcls_cd;
			dt.tnycls_cd = old.tnycls_cd;
			dt.plu_cls_flg = old.plu_cls_flg;
			dt.pts_type = old.pts_type;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.plusch_cd = new.plusch_cd;
			dt.plu_cd = new.plu_cd;
			dt.lrgcls_cd = new.lrgcls_cd;
			dt.mdlcls_cd = new.mdlcls_cd;
			dt.smlcls_cd = new.smlcls_cd;
			dt.tnycls_cd = new.tnycls_cd;
			dt.plu_cls_flg = new.plu_cls_flg;
			dt.pts_type = new.pts_type;
		END IF;
		UPDATE p_promsch_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.plusch_cd,
			prom_typ = (CASE WHEN new.pts_type = 0 THEN 6 ELSE 9 END),
			item_cd = new.plu_cd, prom_name = new.name, reward_val = new.point_add,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, stop_flg = new.stop_flg, trends_typ = new.trends_typ,
			acct_cd = new.acct_cd, promo_ext_id = new.promo_ext_id,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system,
			lrgcls_cd = new.lrgcls_cd, mdlcls_cd = new.mdlcls_cd, smlcls_cd = new.smlcls_cd, tnycls_cd = new.tnycls_cd,
			sch_typ = new.plu_cls_flg, plupts_rate = new.pts_rate
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.plusch_cd
			AND item_cd = dt.plu_cd AND lrgcls_cd = dt.lrgcls_cd AND mdlcls_cd = dt.mdlcls_cd
			AND smlcls_cd = dt.smlcls_cd AND tnycls_cd = dt.tnycls_cd AND sch_typ = dt.plu_cls_flg
			AND prom_typ = (CASE WHEN dt.pts_type = 0 THEN 6 ELSE 9 END);
		IF NOT FOUND THEN
			INSERT INTO p_promsch_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				prom_typ, item_cd, prom_name, reward_val,
				start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, stop_flg, trends_typ,
				acct_cd, promo_ext_id,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
				lrgcls_cd, mdlcls_cd, smlcls_cd, tnycls_cd, sch_typ, plupts_rate
			)
			SELECT 
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.plusch_cd,
				(CASE WHEN new.pts_type = 0 THEN 6 ELSE 9 END), new.plu_cd, new.name, new.point_add,
				new.start_datetime, new.end_datetime, new.timesch_flg,
				new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.stop_flg, new.trends_typ,
				new.acct_cd, new.promo_ext_id,
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
				new.lrgcls_cd, new.mdlcls_cd, new.smlcls_cd, new.tnycls_cd, new.plu_cls_flg, new.pts_rate
			WHERE new.plusch_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.plusch_cd
				AND item_cd = new.plu_cd AND lrgcls_cd = new.lrgcls_cd AND mdlcls_cd = new.mdlcls_cd
				AND smlcls_cd = new.smlcls_cd AND tnycls_cd = new.tnycls_cd AND sch_typ = new.plu_cls_flg
				AND prom_typ = (CASE WHEN new.pts_type = 0 THEN 6 ELSE 9 END));
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_plu_point_prom_del ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar AND prom_cd = old.plusch_cd AND item_cd = old.plu_cd AND lrgcls_cd = old.lrgcls_cd AND mdlcls_cd = old.mdlcls_cd AND smlcls_cd = old.smlcls_cd AND tnycls_cd = old.tnycls_cd AND sch_typ = old.plu_cls_flg AND prom_typ = (CASE WHEN old.pts_type = 0 THEN 6 ELSE 9 END);
		return old;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_plu_point_prom_truncate ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE prom_typ = 6 OR prom_typ = 9;
		return old;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_plu_point_prom_upd_ins BEFORE insert OR update
 ON                s_plu_point_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_plu_point_prom_upd_ins ( );

CREATE TRIGGER     fnc_plu_point_prom_del BEFORE delete
 ON                s_plu_point_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_plu_point_prom_del ( );

CREATE TRIGGER     fnc_plu_point_prom_truncate BEFORE truncate
 ON                s_plu_point_mst FOR STATEMENT
 EXECUTE PROCEDURE fnc_plu_point_prom_truncate ( );
