--=======================================================================================
-- c_stre_mst -> (Update & Insert) PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- name
--		$6 -- entry_no
------------------------------------------------------------------------------------------
-- Author	: Y.Okada
-- Start	: 2023/01/24 : Y.Okada    : First Edition
-- Modify	: 2023/03/09 : T.Saito    : WL -> WNに変更
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnWN(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(50), VARCHAR(32)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_name			alias for $6;
		_entry_no		alias for $7;

		dt			c_stre_mst%ROWTYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
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
			UPDATE c_stre_mst SET
				upd_datetime=_updins_datetime, status=1, upd_user=dt.upd_user, upd_system=dt.upd_system,
				name=_name, entry_no=_entry_no
			WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd;

			IF NOT FOUND THEN
				INSERT INTO c_stre_mst(
					comp_cd, stre_cd, name, entry_no, ins_datetime, status, upd_user, upd_system )
				SELECT
					_comp_cd, _stre_cd, _name, _entry_no, _updins_datetime, 0, dt.upd_user, dt.upd_system
				WHERE
					_stre_cd NOT IN (SELECT stre_cd FROM c_stre_mst WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd);
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
