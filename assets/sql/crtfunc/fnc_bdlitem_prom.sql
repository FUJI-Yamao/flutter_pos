--=======================================================================================
-- s_bdlitem_mst -> p_promitem_mst
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2015.10.03 : F.Saitoh		: First Edition
-- Modify	: 2016.10.25 : T.Saito		: for delete 
-- Modify	: 2020/04/06 : T.Saito		: for delete (prom_typ)
--=======================================================================================
DROP TRIGGER if exists fnc_bdlitem_prom_upd_ins ON s_bdlitem_mst;
DROP TRIGGER if exists fnc_bdlitem_prom_del ON s_bdlitem_mst;
DROP TRIGGER if exists fnc_bdlitem_prom_truncate ON s_bdlitem_mst;
DROP FUNCTION if exists fnc_bdlitem_prom_upd_ins ( );
DROP FUNCTION if exists fnc_bdlitem_prom_del ( );
DROP FUNCTION if exists fnc_bdlitem_prom_truncate ( );

CREATE FUNCTION fnc_bdlitem_prom_upd_ins ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	s_bdlitem_mst%ROWTYPE;
	BEGIN
		IF TG_OP = ''UPDATE'' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.bdl_cd = old.bdl_cd;
			dt.plu_cd = old.plu_cd;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.bdl_cd = new.bdl_cd;
			dt.plu_cd = new.plu_cd;
		END IF;
		UPDATE p_promitem_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.bdl_cd,
			prom_typ = 2, item_cd = new.plu_cd, item_cd2 = '''', grp_cd = 0, stop_flg = new.stop_flg,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime,
			status = new.status, send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.bdl_cd AND 
			item_cd = dt.plu_cd AND item_cd2 = '''' AND grp_cd=0;
		IF NOT FOUND THEN
			INSERT INTO p_promitem_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				prom_typ, item_cd, item_cd2, grp_cd, stop_flg,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
			)
			SELECT
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.bdl_cd,
				2, new.plu_cd, '''', 0, new.stop_flg,
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
			WHERE new.bdl_cd NOT IN (SELECT prom_cd FROM p_promitem_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.bdl_cd AND
				item_cd = new.plu_cd AND item_cd2 = '''' AND grp_cd=0);
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_bdlitem_prom_del ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promitem_mst WHERE comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar AND prom_cd = old.bdl_cd AND 
		item_cd = old.plu_cd AND item_cd2 = '''' AND prom_typ=2;
		return old;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_bdlitem_prom_truncate ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promitem_mst WHERE prom_typ=2;
		return old;
	END;
' LANGUAGE 'plpgsql';
---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_bdlitem_prom_upd_ins BEFORE insert OR update
 ON                s_bdlitem_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_bdlitem_prom_upd_ins ( );

CREATE TRIGGER     fnc_bdlitem_prom_del BEFORE delete
 ON                s_bdlitem_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_bdlitem_prom_del ( );

CREATE TRIGGER     fnc_bdlitem_prom_truncate BEFORE truncate
 ON                s_bdlitem_mst FOR STATEMENT
 EXECUTE PROCEDURE fnc_bdlitem_prom_truncate ( );
