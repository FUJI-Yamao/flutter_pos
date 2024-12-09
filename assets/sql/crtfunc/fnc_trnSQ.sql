--=======================================================================================
-- c_loypln_mst
--		-> (Update & Insert) or Delete PL/PGSQL Function
--	Parameter 
--		$1 -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2 -- set_type -> 0:Update&Insert 1:Delete
--		$3 -- insert datetime or update datetime
--		$4 -- comp code
--		$5 -- store code
--		$6 -- plan code
--		$7 -- prom name
--		$8 -- rcpt name
--		$9 -- loy barcode
--		$10-- data1
--			all_cust_flg		-- 2 digit
--			svs_class		-- 2 digit
--			svs_typ			-- 2 digit
--			reward_val		-- 9 digit
--			start_datetime		-- 19 digit YYYY-MM-DD HH:MM:SS
--			end_datetime		-- 19 digit YYYY-MM-DD HH:MM:SS
--			stop_flg		-- 1 digit
--			timesch_flg		-- 1 digit			
--			sun_flg			-- 1 digit
--			mon_flg			-- 1 digit
--			tue_flg			-- 1 digit
--			wed_flg			-- 1 digit
--			thu_flg			-- 1 digit
--			fri_flg			-- 1 digit
--			sat_flg			-- 1 digit
--			reward_flg		-- 1 digit
--						----------
--						  63 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2023/06/10 : T.Saito      : 新規作成
-- Modify	:            :              : 
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trnSQ(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), NUMERIC(18,0), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_plan_cd		alias for $6;
		_prom_name		alias for $7;
		_rcpt_name		alias for $8;
		_loy_bcd		alias for $9;
		_data1			alias for $10;
		
		dt			c_loypln_mst%ROWTYPE;

		_set_length		int;
		_cmp_length		int;

	BEGIN
		_cmp_length := 63;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
		END IF;

		dt.all_cust_flg		:= substring(_data1 FROM 1 FOR 2);
		dt.svs_class		:= substring(_data1 FROM 3 FOR 2);
		dt.svs_typ		:= substring(_data1 FROM 5 FOR 2);
		dt.reward_val		:= substring(_data1 FROM 7 FOR 9);
		dt.start_datetime	:= substring(_data1 FROM 16 FOR 19);
		dt.end_datetime		:= substring(_data1 FROM 35 FOR 19);
		dt.stop_flg		:= substring(_data1 FROM 54 FOR 1);
		dt.timesch_flg		:= substring(_data1 FROM 55 FOR 1);
		dt.sun_flg		:= substring(_data1 FROM 56 FOR 1);
		dt.mon_flg		:= substring(_data1 FROM 57 FOR 1);
		dt.tue_flg		:= substring(_data1 FROM 58 FOR 1);
		dt.wed_flg		:= substring(_data1 FROM 59 FOR 1);
		dt.thu_flg		:= substring(_data1 FROM 60 FOR 1);
		dt.fri_flg		:= substring(_data1 FROM 61 FOR 1);
		dt.sat_flg		:= substring(_data1 FROM 62 FOR 1);
		dt.reward_flg		:= substring(_data1 FROM 63 FOR 1);

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
			UPDATE c_loypln_mst SET
				 prom_name = _prom_name
				,rcpt_name = _rcpt_name
				,loy_bcd = _loy_bcd
				,all_cust_flg = dt.all_cust_flg
				,svs_class = dt.svs_class		
				,svs_typ = dt.svs_typ		
				,reward_val = dt.reward_val		
				,start_datetime = dt.start_datetime	
				,end_datetime = dt.end_datetime		
				,stop_flg = dt.stop_flg		
				,timesch_flg = dt.timesch_flg		
				,sun_flg = dt.sun_flg		
				,mon_flg = dt.mon_flg		
				,tue_flg = dt.tue_flg		
				,wed_flg = dt.wed_flg		
				,thu_flg = dt.thu_flg		
				,fri_flg = dt.fri_flg		
				,sat_flg = dt.sat_flg		
				,reward_flg = dt.reward_flg		
				,upd_datetime = _updins_datetime, status = 1, upd_user = dt.upd_user, upd_system = dt.upd_system
			WHERE comp_cd = _comp_cd AND plan_cd = _plan_cd;

			IF NOT FOUND THEN
				INSERT INTO c_loypln_mst(
					 plan_cd
					,comp_cd
					,prom_name 
					,rcpt_name 
					,loy_bcd 
					,all_cust_flg 
					,svs_class 
					,svs_typ 
					,reward_val 
					,start_datetime 
					,end_datetime 
					,stop_flg 
					,timesch_flg 
					,sun_flg 
					,mon_flg 
					,tue_flg 
					,wed_flg 
					,thu_flg 
					,fri_flg 
					,sat_flg 
					,reward_flg 
					,all_stre_flg 
					,cust_kind_trgt
					,ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system)
				SELECT   _plan_cd
					,_comp_cd
					,_prom_name
					,_rcpt_name
					,_loy_bcd
					,dt.all_cust_flg
					,dt.svs_class		
					,dt.svs_typ		
					,dt.reward_val		
					,dt.start_datetime	
					,dt.end_datetime		
					,dt.stop_flg		
					,dt.timesch_flg		
					,dt.sun_flg		
					,dt.mon_flg		
					,dt.tue_flg		
					,dt.wed_flg		
					,dt.thu_flg		
					,dt.fri_flg		
					,dt.sat_flg		
					,dt.reward_flg
					, 1
					, ''{1}''
					,_updins_datetime, _updins_datetime, 0, 0, dt.upd_user, dt.upd_system
				WHERE _plan_cd NOT IN (SELECT plan_cd FROM c_loypln_mst WHERE comp_cd = _comp_cd AND plan_cd = _plan_cd);
			END IF;

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_loypln_mst WHERE comp_cd = _comp_cd AND plan_cd = _plan_cd;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
