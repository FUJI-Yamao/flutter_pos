--=======================================================================================
-- c_preset_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- store code
--		$5 -- data
--			preset_grp_cd		-- 6 digit
--			preset_cd		-- 4 digit
--			preset_no		-- 2 digit
--			presetcolor		-- 2 digit( 0 -- 15 )
--			ky_cd			-- 3 digit
--			ky_plu_cd		-- 13 digit
--			ky_smlcls_cd		-- 6 digit
--			ky_size_flg		-- 1 digit( 0:1 1:2 2:4 )
--			ky_status		-- 1 digit( not use )
--		$6 -- preset key name
------------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2002.Feb.21 : F.Saitoh : First Edition
--      	: 2021/06/30  : Y.Okada  : 1ver対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_preset(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(100), VARCHAR(68)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_data			alias for $6;
		_ky_name		alias for $7;

		_preset_grp_cd		c_preset_mst.preset_grp_cd%TYPE;	-- 6 digit
		_preset_cd		c_preset_mst.preset_cd%TYPE;		-- 4 digit
		_preset_no		c_preset_mst.preset_no%TYPE;		-- 2 digit
		_presetcolor		c_preset_mst.presetcolor%TYPE;		-- 2 digit( 0 -- 15 )
		_ky_cd			c_preset_mst.ky_cd%TYPE;		-- 3 digit
		_ky_plu_cd		c_preset_mst.ky_plu_cd%TYPE;		-- 13 digit
		_ky_smlcls_cd		c_preset_mst.ky_smlcls_cd%TYPE;		-- 6 digit
		_ky_size_flg		c_preset_mst.ky_size_flg%TYPE;		-- 1 digit( 0:1 1:2 2:4 )
		_ky_status		c_preset_mst.ky_status%TYPE;		-- 1 digit( not use )

		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 6+4+2+2+3+13+6+1+1;
		_set_length := octet_length(_data);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		_preset_grp_cd	:= substring(_data FROM 1 FOR 6);
		_preset_cd	:= substring(_data FROM 7 FOR 4);
		_preset_no	:= substring(_data FROM 11 FOR 2);
		_presetcolor	:= substring(_data FROM 13 FOR 2);
		_ky_cd		:= substring(_data FROM 15 FOR 3);
		_ky_plu_cd	:= substring(_data FROM 18 FOR 13);
		_ky_smlcls_cd	:= substring(_data FROM 31 FOR 6);
		_ky_size_flg	:= substring(_data FROM 37 FOR 1);
		_ky_status	:= substring(_data FROM 38 FOR 1);

		IF _ky_plu_cd = ''0000000000000'' THEN
			_ky_plu_cd := NULL;
		ELSE IF _ky_plu_cd = ''             '' THEN
			_ky_plu_cd := NULL;
			END IF;
		END IF;
--		IF _ky_smlcls_cd = 0 THEN
--			_ky_smlcls_cd := NULL;
--		END IF;

		IF _set_type = 0 THEN
-- update c_preset_mst
			UPDATE c_preset_mst SET
				presetcolor=_presetcolor, ky_cd=_ky_cd, ky_plu_cd=_ky_plu_cd, ky_smlcls_cd=_ky_smlcls_cd,
				ky_size_flg=_ky_size_flg, ky_status=_ky_status, ky_name=_ky_name
			WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND preset_grp_cd=_preset_grp_cd AND preset_cd=_preset_cd AND preset_no=_preset_no;

-- insert c_preset_mst
			INSERT INTO c_preset_mst(
				comp_cd, stre_cd, preset_grp_cd, preset_cd, preset_no, presetcolor, ky_cd,
				ky_plu_cd, ky_smlcls_cd, ky_size_flg, ky_status, ky_name)
			SELECT _comp_cd, _stre_cd, _preset_grp_cd, _preset_cd, _preset_no, _presetcolor, _ky_cd,
				_ky_plu_cd, _ky_smlcls_cd, _ky_size_flg, _ky_status, _ky_name
			WHERE _preset_cd NOT IN (SELECT preset_cd FROM c_preset_mst WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND preset_grp_cd=_preset_grp_cd AND preset_cd=_preset_cd AND preset_no=_preset_no);

		ELSE IF _set_type = 1 THEN
-- delete c_preset_mst
			DELETE FROM c_preset_mst WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND preset_grp_cd=_preset_grp_cd AND preset_cd=_preset_cd AND preset_no=_preset_no;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
