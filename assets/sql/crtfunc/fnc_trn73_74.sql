--=======================================================================================
-- c_cust_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1  -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2  -- set_type -> 0:Update&Insert 1:Delete
--		$3  -- insert datetime or update datetime
--		$4  -- comp code
--		$5  -- store code
--		$6  -- kana name
--		$7  -- cust name
--		$8  -- address1
--		$9  -- address2
--		$10  -- address3
--		$11  -- srch_telno
--		$12  -- telno1
--		$13 -- telno2
--		$14 -- fax
--		$15 -- data1
--			cust_no			-- 13 digit
--			shot_cust_no		--  8 digit(1verは無い)
--			post_no			--  7 digit
--			custzone_cd		--  6 digit
--			admission_date		--  8 digit(YYYYMMDD)
--			efct_date		--  8 digit(YYYYMMDD)(1verは無い)
--			sex			--  1 digit(0:woman 1:man 2:unknown)
--			birth_day		--  8 digit(YYYYMMDD)
--			anvkind_1		--  1 digit(1verは無い)
--			anvkind_2		--  1 digit(1verは無い)
--			anvkind_3		--  1 digit(1verは無い)
--			anvkind_4		--  1 digit(1verは無い)
--			anvkind_5		--  1 digit(1verは無い)
--			anv_date_1		--  4 digit(MMDD)(1verは無い)
--			anv_date_2		--  4 digit(MMDD)(1verは無い)
--			anv_date_3		--  4 digit(MMDD)(1verは無い)
--			anv_date_4		--  4 digit(MMDD)(1verは無い)
--			anv_date_5		--  4 digit(MMDD)(1verは無い)
--			svs_cls_cd		--  6 digit
--			cust_status		--  1 digit(0:normal 1:rest 2:withdrawal)
--			withdraw_date		--  8 digit(YYYYMMDD)
--			point_add_magn		--  4 digit( example 1234 -> 12.34 )(1verは無い)
--			anyprc_add_magn		--  4 digit( example 1234 -> 12.34 )(1verは無い)
--			targ_typ		--  1 digit(0:extra point 1:exclusion extra point)
--			anyprc_add_mem_typ	--  1 digit(0:FSP 1:not FSP)(1verは無い)
--			parent_cust_no		-- 13 digit(1verは無い)
--			change_add_mem_typ	--  1 digit(1verは無い)
--			heso_add_mem_typ	--  1 digit(1verは無い)
--						total 124
------------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2002.Sep.19 : F.Saitoh : First Edition
-- Modify	: 2002.Sep.26 : F.Saitoh : Change When YYYYMMDD is ''00000000'', NULL
-- 		: 2009.Apl.30 : T.Saito  : Change last_visit_date
-- 		: 2021/06/30  : Y.Okada  : 1ver対応
-- 		: 2023/03/21  : T.Saito  : 特定ユーザー向け対応
--========================================================================================

CREATE or REPLACE FUNCTION fnc_trn73_74(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(50), VARCHAR(50), VARCHAR(20), VARCHAR(20), VARCHAR(40), VARCHAR(20), VARCHAR(25), VARCHAR(25), VARCHAR(25), VARCHAR(400)) RETURNS int AS '
	DECLARE
		dt			c_cust_mst%ROWTYPE;
--		_last_visit_date	s_cust_ttl_tbl.last_visit_date%TYPE;
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_comp_cd		alias for $4;
		_stre_cd		alias for $5;
		_kana_name		alias for $6;
		_cust_name		alias for $7;
		_address1		alias for $8;	-- change
		_address2		alias for $9;	-- append
		_address3		alias for $10;	-- append
		_srch_telno		alias for $11;
		_telno1			alias for $12;
		_telno2			alias for $13;
		_fax			alias for $14;
		_data1			alias for $15;
		_tmp_date		char(8);

		_set_length		int;
		_cmp_length		int;
	BEGIN
		_cmp_length := 124;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			IF _set_length = 13 AND _set_type = 1 THEN
				dt.cust_no := substring(_data1 FROM 1 FOR 13);
			ELSE
				RAISE EXCEPTION ''data1 params error % = %'', _cmp_length, _set_length;
			END IF;
		ELSE
			dt.stre_cd		:= _stre_cd;
--			dt.kana_name		:= _kana_name;
			_tmp_date		:= substring(_kana_name FROM 1 FOR 3);
			IF _tmp_date = ''001'' THEN
				dt.mail_addr		:= substring(_kana_name FROM 4 FOR 5);
			END IF;

			dt.last_name		:= _cust_name;
			dt.address1		:= _address1;
			dt.address2		:= _address2;
			dt.address3		:= _address3;
--			dt.srch_telno		:= _srch_telno;
			dt.tel_no1		:= _telno1;
			dt.tel_no2		:= _telno2;
--			dt.fax			:= _fax;
			dt.cust_no 		:= substring(_data1 FROM 1 FOR 13);
--			dt.shot_cust_no		:= substring(_data1 FROM 14 FOR 8);
			dt.post_no		:= substring(_data1 FROM 22 FOR 7);
			dt.custzone_cd		:= substring(_data1 FROM 29 FOR 6);
			_tmp_date		:= substring(_data1 FROM 35 FOR 8);
			IF _tmp_date = ''00000000'' THEN
				dt.admission_date	:= NULL;
			ELSE
				dt.admission_date	:= _tmp_date;
			END IF;
--			_tmp_date		:= substring(_data1 FROM 43 FOR 8);
--			IF _tmp_date = ''00000000'' THEN
--				dt.efct_date	:= NULL;
--			ELSE
--				dt.efct_date	:= _tmp_date;
--			END IF;
			dt.sex			:= substring(_data1 FROM 51 FOR 1);
			_tmp_date		:= substring(_data1 FROM 52 FOR 8);
			IF _tmp_date = ''00000000'' THEN
				dt.birth_day	:= NULL;
			ELSE
				dt.birth_day	:= _tmp_date;
			END IF;
--			dt.anvkind_1		:= substring(_data1 FROM 60 FOR 1);
--			dt.anvkind_2		:= substring(_data1 FROM 61 FOR 1);
--			dt.anvkind_3		:= substring(_data1 FROM 62 FOR 1);
--			dt.anvkind_4		:= substring(_data1 FROM 63 FOR 1);
--			dt.anvkind_5		:= substring(_data1 FROM 64 FOR 1);
--			dt.anv_date_1		:= substring(_data1 FROM 65 FOR 4);
--			dt.anv_date_2		:= substring(_data1 FROM 69 FOR 4);
--			dt.anv_date_3		:= substring(_data1 FROM 73 FOR 4);
--			dt.anv_date_4		:= substring(_data1 FROM 77 FOR 4);
--			dt.anv_date_5		:= substring(_data1 FROM 81 FOR 4);
			dt.svs_cls_cd		:= substring(_data1 FROM 85 FOR 6);
			dt.cust_status		:= substring(_data1 FROM 91 FOR 1);
			_tmp_date		:= substring(_data1 FROM 92 FOR 8);
			IF _tmp_date = ''00000000'' THEN
				dt.withdraw_date	:= NULL;
			ELSE
				dt.withdraw_date	:= substring(_data1 FROM 92 FOR 4) || ''-''
							|| substring(_data1 FROM 96 FOR 2) || ''-''
							|| substring(_data1 FROM 98 FOR 2) || '' 00:00:00'';
			END IF;
--			dt.point_add_magn	:= substring(_data1 FROM 100 FOR 2) || ''.''
--						|| substring(_data1 FROM 102 FOR 2);
--			dt.anyprc_add_magn	:= substring(_data1 FROM 104 FOR 2) || ''.''
--						|| substring(_data1 FROM 106 FOR 2);
			dt.targ_typ		:= substring(_data1 FROM 108 FOR 1);
--			dt.anyprc_add_mem_typ	:= substring(_data1 FROM 109 FOR 1);
--			dt.parent_cust_no	:= substring(_data1 FROM 110 FOR 13);
--			dt.change_add_mem_typ	:= substring(_data1 FROM 123 FOR 1);
--			dt.heso_add_mem_typ	:= substring(_data1 FROM 124 FOR 1);

		END IF;

		dt.ins_datetime := _updins_datetime;
		dt.upd_datetime := _updins_datetime;
--		_last_visit_date := ''00000000'';
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
			UPDATE c_cust_mst SET
				stre_cd=dt.stre_cd, last_name=dt.last_name, post_no=dt.post_no,
				address1=dt.address1, address2=dt.address2, address3=dt.address3,
				custzone_cd=dt.custzone_cd, tel_no1=dt.tel_no1, tel_no2=dt.tel_no2,
				admission_date=dt.admission_date, sex=dt.sex, birth_day=dt.birth_day,
				svs_cls_cd=dt.svs_cls_cd, cust_status=dt.cust_status, withdraw_date=dt.withdraw_date,
				targ_typ=dt.targ_typ,
				mail_addr=dt.mail_addr,
				upd_datetime=dt.upd_datetime, status=1, upd_user=dt.upd_user, upd_system=dt.upd_system
			WHERE comp_cd=_comp_cd AND cust_no=dt.cust_no;

			INSERT INTO c_cust_mst (
				cust_no, comp_cd, stre_cd, last_name, post_no, address1, address2, address3, custzone_cd,
				tel_no1, tel_no2, admission_date, sex, birth_day,
				svs_cls_cd, cust_status, withdraw_date,
				targ_typ,
				mail_addr,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				)
			SELECT  dt.cust_no, _comp_cd, dt.stre_cd, dt.last_name, dt.post_no, dt.address1, dt.address2, dt.address3, dt.custzone_cd,
				dt.tel_no1, dt.tel_no2, dt.admission_date, dt.sex, dt.birth_day,
				dt.svs_cls_cd, dt.cust_status, dt.withdraw_date,
				dt.targ_typ,
				dt.mail_addr,
				dt.ins_datetime, dt.upd_datetime, 0, 0, dt.upd_user, dt.upd_system
			WHERE dt.cust_no NOT IN (SELECT cust_no FROM c_cust_mst WHERE cust_no=dt.cust_no);

			UPDATE s_cust_ttl_tbl SET
				stre_cd=dt.stre_cd, last_name=dt.last_name, tel_no1=dt.tel_no1, tel_no2=dt.tel_no2,
				birth_day=dt.birth_day, cust_status=dt.cust_status, targ_typ=dt.targ_typ,
				upd_datetime=dt.upd_datetime, status=1, upd_user=dt.upd_user, upd_system=dt.upd_system
			WHERE cust_no=dt.cust_no;

			INSERT INTO s_cust_ttl_tbl (
				cust_no, comp_cd, stre_cd, last_name, tel_no1, tel_no2,
				birth_day, cust_status, targ_typ,
				ins_datetime, upd_datetime, status, send_flg, upd_user, upd_system
				)
			SELECT  dt.cust_no, _comp_cd, _stre_cd, dt.last_name, dt.tel_no1, dt.tel_no2,
				dt.birth_day, dt.cust_status, dt.targ_typ,
				dt.ins_datetime, dt.upd_datetime, 0, 0, dt.upd_user, dt.upd_system
			WHERE dt.cust_no NOT IN (SELECT cust_no FROM s_cust_ttl_tbl WHERE comp_cd=_comp_cd AND cust_no=dt.cust_no);

		ELSE IF _set_type = 1 THEN
			DELETE FROM c_cust_mst WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND cust_no=dt.cust_no;
			DELETE FROM s_cust_ttl_tbl WHERE comp_cd=_comp_cd AND stre_cd=_stre_cd AND cust_no=dt.cust_no;
			DELETE FROM s_cust_loy_tbl WHERE comp_cd=_comp_cd AND cust_no=dt.cust_no;
			DELETE FROM s_cust_cpn_tbl WHERE comp_cd=_comp_cd AND cust_no=dt.cust_no;
			END IF;
		END IF;

		RETURN 2;
	END;
' LANGUAGE 'plpgsql';
