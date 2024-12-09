--=======================================================================================
-- s_stmitem_mst -> p_promitem_mst
-- PL/PGSQL Trigger Function
-- 
-----------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2015.10.03 : F.Saitoh		: First Edition
-- Modify	: 2020/04/06 : T.Saito          : for delete (prom_typ)
--=======================================================================================
DROP TRIGGER if exists fnc_stmitem_prom_upd_ins ON s_stmitem_mst;
DROP TRIGGER if exists fnc_stmitem_prom_del ON s_stmitem_mst;
DROP TRIGGER if exists fnc_stmitem_prom_truncate ON s_stmitem_mst;
DROP FUNCTION if exists fnc_stmitem_prom_upd_ins ( );
DROP FUNCTION if exists fnc_stmitem_prom_del ( );
DROP FUNCTION if exists fnc_stmitem_prom_truncate ( );

CREATE FUNCTION fnc_stmitem_prom_upd_ins ( ) RETURNS TRIGGER AS '
	DECLARE
		dt	s_stmitem_mst%ROWTYPE;
	BEGIN
		IF TG_OP = ''UPDATE'' THEN
			dt.comp_cd = old.comp_cd;
			dt.stre_cd = old.stre_cd;
			dt.plan_cd = old.plan_cd;
			dt.stm_cd = old.stm_cd;
			dt.plu_cd = old.plu_cd;
			dt.grpno = old.grpno;
		ELSE
			dt.comp_cd = new.comp_cd;
			dt.stre_cd = new.stre_cd;
			dt.plan_cd = new.plan_cd;
			dt.stm_cd = new.stm_cd;
			dt.plu_cd = new.plu_cd;
			dt.grpno = new.grpno;
		END IF;
		UPDATE p_promitem_mst SET
			comp_cd = new.comp_cd, stre_cd = new.stre_cd, plan_cd = new.plan_cd::varchar, prom_cd = new.stm_cd,
			prom_typ=3, item_cd = new.plu_cd, item_cd2 = '''', grp_cd = new.grpno, set_qty = new.stm_qty, stop_flg = new.stop_flg,
			ins_datetime = new.ins_datetime, upd_datetime = new.upd_datetime,
			status = new.status, send_flg = new.send_flg, upd_user = new.upd_user, upd_system = new.upd_system
		WHERE comp_cd = dt.comp_cd AND stre_cd = dt.stre_cd AND plan_cd = dt.plan_cd::varchar AND prom_cd = dt.stm_cd AND 
			item_cd = dt.plu_cd AND item_cd2 = '''' AND grp_cd = dt.grpno;
		IF NOT FOUND THEN
			INSERT INTO p_promitem_mst (
				comp_cd, stre_cd, plan_cd, prom_cd,
				prom_typ, item_cd, item_cd2, grp_cd, set_qty, stop_flg,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
			)
			SELECT
				new.comp_cd, new.stre_cd, new.plan_cd::varchar, new.stm_cd,
				3, new.plu_cd, '''', new.grpno, new.stm_qty, new.stop_flg,
				new.ins_datetime, new.upd_datetime, new.status, new.send_flg, new.upd_user, new.upd_system
			WHERE new.stm_cd NOT IN (SELECT prom_cd FROM p_promitem_mst WHERE
				comp_cd = new.comp_cd AND stre_cd = new.stre_cd AND plan_cd = new.plan_cd::varchar AND prom_cd = new.stm_cd AND
				item_cd = new.plu_cd AND item_cd2 = '''' AND grp_cd = new.grpno);
		END IF;
		return new;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_stmitem_prom_del ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promitem_mst WHERE 
			comp_cd = old.comp_cd AND stre_cd = old.stre_cd AND plan_cd = old.plan_cd::varchar AND prom_cd = old.stm_cd AND
			item_cd = old.plu_cd AND item_cd2 = '''' AND grp_cd = old.grpno AND prom_typ = 3;
		return old;
	END;
' LANGUAGE 'plpgsql';

CREATE FUNCTION fnc_stmitem_prom_truncate ( ) RETURNS TRIGGER AS '
	DECLARE
	BEGIN
		DELETE FROM p_promitem_mst WHERE prom_typ = 3;
		return old;
	END;
' LANGUAGE 'plpgsql';

---------------
-- Trigger
---------------
CREATE TRIGGER     fnc_stmitem_prom_upd_ins BEFORE insert OR update
 ON                s_stmitem_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_stmitem_prom_upd_ins ( );

CREATE TRIGGER     fnc_stmitem_prom_del BEFORE delete
 ON                s_stmitem_mst FOR EACH ROW
 EXECUTE PROCEDURE fnc_stmitem_prom_del ( );

CREATE TRIGGER     fnc_stmitem_prom_truncate BEFORE truncate
 ON                s_stmitem_mst FOR STATEMENT
 EXECUTE PROCEDURE fnc_stmitem_prom_truncate ( );
