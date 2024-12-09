--=======================================================================================
-- c_loyplu_mst
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- comp code
--		$5 -- store code
--		$6 -- plan code
--		$7 -- prom code
--		$8 -- data1
--			stop_flg		-- 1 digit
--			val			-- 11 digit			
--						----------
--						  12 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2023/06/10 : T.Saito      : 新規作成
-- Modify	:            :              : 
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnSR(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), NUMERIC(18,0), VARCHAR(50), VARCHAR(50) ) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_plan_cd		alias for $6;
		_prom_cd		alias for $7;
		_data1			alias for $8;
		
		dt			c_loyplu_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 12;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.stop_flg		:= substring(_data1 FROM 1 FOR 1);
		dt.val			:= substring(_data1 FROM 2 FOR 9) || ''.'' || substring(_data1 FROM 11 FOR 2) ; 

		IF _send_who = 0 THEN
			dt.upd_user	:= 999999;
			dt.upd_system	:= 0;
		ELSE
			IF _send_who = 1 THEN
				dt.upd_user	:= 999999;
				dt.upd_system	:= 1;
			ELSE
				dt.upd_user	:= 999999;
				dt.upd_system	:= 2;
			END IF;
		END IF;

		IF _set_type = 0 THEN
			UPDATE c_loyplu_mst SET
				 stop_flg = dt.stop_flg
				,val = dt.val
				,upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE plan_cd = _plan_cd AND prom_cd = _prom_cd;

			IF NOT FOUND THEN
				INSERT INTO c_loyplu_mst(
					 plan_cd
					,prom_cd
					,stop_flg
					,val

					,comp_cd
					,ref_flg
					,ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
				SELECT   _plan_cd
					,_prom_cd
					,dt.stop_flg		
					,dt.val

					,_comp_cd
					,0
					,_updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system
				WHERE _plan_cd NOT IN (SELECT plan_cd FROM c_loyplu_mst WHERE plan_cd = _plan_cd AND prom_cd = _prom_cd);
			END IF;

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_loyplu_mst WHERE plan_cd = _plan_cd AND prom_cd = _prom_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
