/*
 * ファイル名	: fnc_custsvs_prom.sql
 * 機能概要	: サービス分類スケジュール用トリガー関数
 *		:
 * 改訂履歴	: T.Ando	2018/04/11	初版
 *		: Y.Okada	2019/04/04	WHERE句にprom_typを追加
 */
/*
 * (C) 2018 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

DROP TRIGGER IF EXISTS fnc_custsvs_prom_upd_ins ON s_svs_sch_mst;
DROP TRIGGER IF EXISTS fnc_custsvs_prom_del ON s_svs_sch_mst;
DROP TRIGGER IF EXISTS fnc_custsvs_prom_truncate ON s_svs_sch_mst;
DROP FUNCTION IF EXISTS fnc_custsvs_prom_upd_ins();
DROP FUNCTION IF EXISTS fnc_custsvs_prom_del();
DROP FUNCTION IF EXISTS fnc_custsvs_prom_truncate();


CREATE FUNCTION fnc_custsvs_prom_upd_ins() RETURNS TRIGGER AS
$FUNC1$
	DECLARE
		dt	s_svs_sch_mst%ROWTYPE;
	BEGIN
		IF TG_OP = 'UPDATE' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.svs_cls_sch_cd = old.svs_cls_sch_cd;
			dt.svs_cls_cd = old.svs_cls_cd;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.svs_cls_sch_cd = new.svs_cls_sch_cd;
			dt.svs_cls_cd = new.svs_cls_cd;
		END IF;
		UPDATE p_promsch_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.svs_cls_sch_cd,
			prom_typ = 8, item_cd = new.svs_cls_cd::varchar, prom_name = new.svs_cls_sch_name,
			point_add_magn = new.point_add_magn, point_add_mem_typ = new.point_add_mem_typ,
			svs_cls_f_data1 = new.f_data1, svs_cls_s_data1 = new.s_data1, svs_cls_s_data2 = new.s_data2, svs_cls_s_data3 = new.s_data3,
			start_datetime = new.start_datetime, end_datetime = new.end_datetime, timesch_flg = new.timesch_flg,
			sun_flg = new.sun_flg, mon_flg = new.mon_flg, tue_flg = new.tue_flg, wed_flg = new.wed_flg,
			thu_flg = new.thu_flg, fri_flg = new.fri_flg, sat_flg = new.sat_flg, stop_flg = new.stop_flg,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime, status = new.status,
			send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system, acct_cd = new.acct_cd
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.svs_cls_sch_cd
			AND prom_typ=8 AND item_cd = dt.svs_cls_cd::varchar AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
		IF NOT FOUND THEN
			INSERT INTO p_promsch_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				prom_typ, item_cd, prom_name,
				point_add_magn, point_add_mem_typ, svs_cls_f_data1, svs_cls_s_data1, svs_cls_s_data2, svs_cls_s_data3,
				start_datetime, end_datetime, timesch_flg,
				sun_flg, mon_flg, tue_flg, wed_flg, thu_flg, fri_flg, sat_flg, stop_flg,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system,
				acct_cd)
			SELECT
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.svs_cls_sch_cd,
				8, new.svs_cls_cd::varchar, new.svs_cls_sch_name,
				new.point_add_magn, new.point_add_mem_typ, new.f_data1, new.s_data1, new.s_data2, new.s_data3,
				new.start_datetime, new.end_datetime, new.timesch_flg,
				new.sun_flg, new.mon_flg, new.tue_flg, new.wed_flg, new.thu_flg, new.fri_flg, new.sat_flg, new.stop_flg,
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system,
				new.acct_cd
			WHERE new.svs_cls_sch_cd NOT IN (SELECT prom_cd FROM p_promsch_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.svs_cls_sch_cd
				AND prom_typ=8 AND item_cd = new.svs_cls_cd::varchar AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0);
		END IF;
		return new;
	END;
$FUNC1$ LANGUAGE plpgsql;

CREATE FUNCTION fnc_custsvs_prom_del() RETURNS TRIGGER AS
$FUNC2$
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar
			AND prom_cd = old.svs_cls_sch_cd AND prom_typ=8 AND item_cd = old.svs_cls_cd::varchar
			AND lrgcls_cd=0 AND mdlcls_cd=0 AND smlcls_cd=0 AND tnycls_cd=0;
		return old;
	END;
$FUNC2$ LANGUAGE plpgsql;

CREATE FUNCTION fnc_custsvs_prom_truncate() RETURNS TRIGGER AS
$FUNC3$
	DECLARE
	BEGIN
		DELETE FROM p_promsch_mst WHERE prom_typ = 8;
		return old;
	END;
$FUNC3$ LANGUAGE plpgsql;


CREATE TRIGGER fnc_custsvs_prom_upd_ins BEFORE INSERT OR UPDATE
	ON s_svs_sch_mst FOR EACH ROW
	EXECUTE PROCEDURE fnc_custsvs_prom_upd_ins();

CREATE TRIGGER fnc_custsvs_prom_del BEFORE DELETE
	ON s_svs_sch_mst FOR EACH ROW
	EXECUTE PROCEDURE fnc_custsvs_prom_del();

CREATE TRIGGER fnc_custsvs_prom_truncate BEFORE TRUNCATE
	ON s_svs_sch_mst FOR STATEMENT
	EXECUTE PROCEDURE fnc_custsvs_prom_truncate();

