--=======================================================================================
-- c_cls_mst(smlcls) -> (Update & Insert) or Delete PL/PGSQL Function (ONLY CSS)
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data1
--			middle class code	-- 6 digit ( 1 -- 999999 )
--			small class code	-- 6 digit ( 1 -- 999999 )
--		$6 -- small class name
--		$8 -- data2
--			tax_cd1			-- 2 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2013.10.31 : T.Saito      : First Edition
-- Modify	: 2021/06/30 : Y.Okada      : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnSF(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(20), VARCHAR(50), VARCHAR(20)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data1			alias for $6;
		_smlcls_name		alias for $7;
		_data2			alias for $8;
		
		dt			c_cls_mst%ROWTYPE;
		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 6+6;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;
		dt.mdlcls_cd := substring(_data1 FROM 1 FOR 6);
		dt.smlcls_cd := substring(_data1 FROM 7 FOR 6);

		_cmp_length := 2;
		_set_length := octet_length(_data2);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
		END IF;
		dt.tax_cd1 := substring(_data2 FROM 1 FOR 2);

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
			UPDATE c_cls_mst SET
				mdlcls_cd = dt.mdlcls_cd, tax_cd1 = dt.tax_cd1,
				name = (CASE WHEN octet_length(_smlcls_name) > 0 THEN _smlcls_name ELSE name END),
				upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND smlcls_cd = dt.smlcls_cd;
		END IF;
				
		RETURN 4;
	END;
' LANGUAGE 'plpgsql';
