--=======================================================================================
-- c_reginfo_mst and c_reginfo_grp_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1  -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2  -- set_type -> 0:Update&Insert 1:Delete
--		$3  -- insert datetime or update datetime
--		$4  -- data1
--			comp_cd			--  9 digit
--			stre_cd			--  9 digit
--			mac_no			--  9 digit
--		$5  -- data2
--			mac_typ			--  4 digit
--			org_mac_no		--  9 digit
--			set_owner_flg		--  3 digit
--			mac_role1		--  2 digit
--			mac_role2		--  2 digit
--			mac_role3		--  2 digit
--			pbchg_flg		--  2 digit
--			upd_user		-- 10 digit
--			upd_system		--  2 digit
--		$6  --  mac_addr
--		$7  --  ip_addr
--		$8  --  brdcast_addr
--		$9  --  ip_addr2
--		$10 --  brdcast_addr2
--		$11 --  crdt_trm_cd
--		$12 --  start_datetime
--		$13 --  end_datetime
--		$14 -- data3
--			cls_grp_cd		--  9 digit
--			trm_grp_cd		--  9 digit
--			preset_grp_cd		--  9 digit
--			kopt_grp_cd		--  9 digit
--			batch_grp_cd		--  9 digit
--			img_grp_cd		--  9 digit
--			msg_grp_cd		--  9 digit
--			cashrecycle_grp_cd	--  9 digit
--			card_comp_cd		--  9 digit
--			card_stre_cd		--  9 digit
--			autoopncls_grp_cd	--  9 digit
------------------------------------------------------------------------------------------
-- Author	: T.Saito
-- Start	: 2015/08/18 : T.Saito		: First Edition
-- 		: 2016/09/20 : I.Ohno		: add autoopncls_grp_cd.
-- 		: 2017/12/16 : S.Uchino		: auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cdを10桁に拡張
--========================================================================================

DROP FUNCTION if exists fnc_reginfo(INT, INT, TIMESTAMP, VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(25), TIMESTAMP, TIMESTAMP, VARCHAR(100));
CREATE FUNCTION fnc_reginfo(INT, INT, TIMESTAMP, VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(25), TIMESTAMP, TIMESTAMP, VARCHAR(100)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_data1			alias for $4;
		_data2			alias for $5;
		_mac_addr		alias for $6;
		_ip_addr		alias for $7;
		_brdcast_addr		alias for $8;
		_ip_addr2		alias for $9;
		_brdcast_addr2		alias for $10;
		_crdt_trm_cd		alias for $11;
		_start_datetime		alias for $12;
		_end_datetime		alias for $13;
		_data3			alias for $14;

		inf			c_reginfo_mst%ROWTYPE;
		_cls_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_trm_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_preset_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_kopt_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_batch_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_img_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_msg_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_cashrecycle_grp_cd	c_reginfo_grp_mst.grp_cd%TYPE;
		_card_comp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_card_stre_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_autoopncls_grp_cd	c_reginfo_grp_mst.grp_cd%TYPE;
		_set_length		int;
		_cmp_length		int;
		_set_grp_flg		int;
		_count			int;
		_grp_cd			c_reginfo_grp_mst.grp_cd%TYPE;
		_grp_typ		c_reginfo_grp_mst.grp_typ%TYPE;
	BEGIN
		_set_grp_flg := 0;
		_cmp_length := 27;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		inf.comp_cd	:= substring(_data1 FROM 1 FOR 9);
		inf.stre_cd	:= substring(_data1 FROM 10 FOR 9);
		inf.mac_no	:= substring(_data1 FROM 19 FOR 9);

		IF _set_type = 0 THEN
			_cmp_length := 36;
			_set_length := octet_length(_data2);
			IF _set_length < _cmp_length THEN
				RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
			END IF;

			inf.mac_typ		:= substring(_data2 FROM 1 FOR 4);
			inf.org_mac_no		:= substring(_data2 FROM 5 FOR 9);
			inf.set_owner_flg	:= substring(_data2 FROM 14 FOR 3);
			inf.mac_role1		:= substring(_data2 FROM 17 FOR 2);
			inf.mac_role2		:= substring(_data2 FROM 19 FOR 2);
			inf.mac_role3		:= substring(_data2 FROM 21 FOR 2);
			inf.pbchg_flg		:= substring(_data2 FROM 23 FOR 2);
			inf.upd_user		:= substring(_data2 FROM 25 FOR 10);
			inf.upd_system		:= substring(_data2 FROM 35 FOR 2);

			_cmp_length := 99;
			_set_length := octet_length(_data3);
			IF _set_length = _cmp_length THEN
				_set_grp_flg		:= 1;
				_cls_grp_cd		:= substring(_data3 FROM 1 FOR 9);
				_trm_grp_cd		:= substring(_data3 FROM 10 FOR 9);
				_preset_grp_cd		:= substring(_data3 FROM 19 FOR 9);
				_kopt_grp_cd		:= substring(_data3 FROM 28 FOR 9);
				_batch_grp_cd		:= substring(_data3 FROM 37 FOR 9);
				_img_grp_cd		:= substring(_data3 FROM 46 FOR 9);
				_msg_grp_cd		:= substring(_data3 FROM 55 FOR 9);
				_cashrecycle_grp_cd	:= substring(_data3 FROM 64 FOR 9);
				_card_comp_cd		:= substring(_data3 FROM 73 FOR 9);
				_card_stre_cd		:= substring(_data3 FROM 82 FOR 9);
				_autoopncls_grp_cd	:= substring(_data3 FROM 91 FOR 9);
			END IF;
		END IF;

		IF _set_type = 0 THEN
			UPDATE c_reginfo_mst SET
				mac_typ = inf.mac_typ, mac_addr = _mac_addr, ip_addr = _ip_addr, brdcast_addr = _brdcast_addr, ip_addr2 = _ip_addr2,
				brdcast_addr2 = _brdcast_addr2, org_mac_no = inf.org_mac_no, crdt_trm_cd =_crdt_trm_cd, set_owner_flg = inf.set_owner_flg,
				mac_role1 = inf.mac_role1, mac_role2 = inf.mac_role2, mac_role3 = inf.mac_role3, pbchg_flg = inf.pbchg_flg,
				start_datetime = _start_datetime, end_datetime = _end_datetime, upd_datetime = _updins_datetime,
				status = 0, send_flg = 0, upd_user = inf.upd_user, upd_system = inf.upd_system
			WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no;

			IF NOT FOUND THEN
				INSERT INTO c_reginfo_mst (
					comp_cd, stre_cd, mac_no,
					mac_typ, mac_addr, ip_addr, brdcast_addr, ip_addr2,
					brdcast_addr2, org_mac_no, crdt_trm_cd, set_owner_flg,
					mac_role1, mac_role2, mac_role3, pbchg_flg,
					start_datetime, end_datetime, ins_datetime, upd_datetime,
					status, send_flg, upd_user, upd_system)
				VALUES  (
					inf.comp_cd, inf.stre_cd, inf.mac_no,
					inf.mac_typ, _mac_addr, _ip_addr, _brdcast_addr, _ip_addr2,
					_brdcast_addr2, inf.org_mac_no, _crdt_trm_cd, inf.set_owner_flg, 
					inf.mac_role1, inf.mac_role2, inf.mac_role3, inf.pbchg_flg,
					_start_datetime, _end_datetime, _updins_datetime, _updins_datetime,
					0, 0, inf.upd_user, inf.upd_system );
			END IF;

			IF _set_grp_flg = 1 THEN
-- LOOP Start
				_count	:= 1;
				LOOP
					IF _count = 1 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _cls_grp_cd;
					ELSIF _count = 2 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _trm_grp_cd;
					ELSIF _count = 3 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _preset_grp_cd;
					ELSIF _count = 4 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _kopt_grp_cd;
					ELSIF _count = 5 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _batch_grp_cd;
					ELSIF _count = 6 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _img_grp_cd;
					ELSIF _count = 7 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _msg_grp_cd;
					ELSIF _count = 8 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _cashrecycle_grp_cd;
					ELSIF _count = 9 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _card_comp_cd;
					ELSIF _count = 10 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _card_stre_cd;
					ELSIF _count = 11 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _autoopncls_grp_cd;
					ELSE					
						EXIT;
					END IF;

-- RAISE NOTICE ''CHK % % %'', _count, _grp_typ, _grp_cd;
					UPDATE c_reginfo_grp_mst SET
						grp_cd = _grp_cd, upd_datetime = _updins_datetime, 
						status = 0, send_flg = 0, upd_user = inf.upd_user, upd_system = inf.upd_system
					WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no AND grp_typ = _grp_typ;
					IF NOT FOUND THEN
						INSERT INTO c_reginfo_grp_mst (
							comp_cd, stre_cd, mac_no, grp_typ, grp_cd, ins_datetime, upd_datetime,
							status, send_flg, upd_user, upd_system )
						VALUES (inf.comp_cd, inf.stre_cd, inf.mac_no, _grp_typ, _grp_cd, _updins_datetime, _updins_datetime,
							0, 0, inf.upd_user, inf.upd_system);
					END IF;

					_count	:= _count + 1;

				END LOOP;
			END IF;
		ELSE IF _set_type = 1 THEN
			DELETE FROM c_reginfo_mst WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no;
			DELETE FROM c_reginfo_grp_mst WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';

--=======================================================================================
-- c_reginfo_mst and c_reginfo_grp_mst -> (Update & Insert) or Delete PL/PGSQL Function
--
--	Parameter
--		$1  -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2  -- set_type -> 0:Update&Insert 1:Delete
--		$3  -- insert datetime or update datetime
--		$4  -- data1
--			comp_cd			--  9 digit
--			stre_cd			--  9 digit
--			mac_no			--  9 digit
--		$5  -- data2
--			mac_typ			--  4 digit
--			org_mac_no		--  9 digit
--			set_owner_flg		--  3 digit
--			mac_role1		--  2 digit
--			mac_role2		--  2 digit
--			mac_role3		--  2 digit
--			pbchg_flg		--  2 digit
--			upd_user		-- 10 digit
--			upd_system		--  2 digit
--		$6  --  mac_addr
--		$7  --  ip_addr
--		$8  --  brdcast_addr
--		$9  --  ip_addr2
--		$10 --  brdcast_addr2
--		$11 --  crdt_trm_cd
--		$12 --  start_datetime
--		$13 --  end_datetime
--		$14 -- data3
--			cls_grp_cd		--  9 digit
--			trm_grp_cd		--  9 digit
--			preset_grp_cd		--  9 digit
--			kopt_grp_cd		--  9 digit
--			batch_grp_cd		--  9 digit
--			img_grp_cd		--  9 digit
--			msg_grp_cd		--  9 digit
--			cashrecycle_grp_cd	--  9 digit
--			card_comp_cd		--  9 digit
--			card_stre_cd		--  9 digit
--			autoopncls_grp_cd	--  9 digit
--			auto_cls_time     	--  9 digit *
--		$15 -- auto_opn_cshr_cd   	--  10 digit *
--                     auto_opn_chkr_cd   	--  10 digit *
--                     auto_cls_cshr_cd   	--  10 digit *
------------------------------------------------------------------------------------------
-- Author	: I.Ohno
-- Start	: 2017/10/17 : I.Ohno		: ADD auto_cls_time,auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cd FROM fnc_reginfo
--========================================================================================

DROP FUNCTION if exists fnc_reginfo2(INT, INT, TIMESTAMP, VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(25), TIMESTAMP, TIMESTAMP, VARCHAR(110), VARCHAR(50));
CREATE FUNCTION fnc_reginfo2(INT, INT, TIMESTAMP, VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(50), VARCHAR(25), TIMESTAMP, TIMESTAMP, VARCHAR(110), VARCHAR(50)) RETURNS int AS '
	DECLARE
		_send_who		alias for $1;
		_set_type		alias for $2;
		_updins_datetime	alias for $3;
		_data1			alias for $4;
		_data2			alias for $5;
		_mac_addr		alias for $6;
		_ip_addr		alias for $7;
		_brdcast_addr		alias for $8;
		_ip_addr2		alias for $9;
		_brdcast_addr2		alias for $10;
		_crdt_trm_cd		alias for $11;
		_start_datetime		alias for $12;
		_end_datetime		alias for $13;
		_data3			alias for $14;
		_data4			alias for $15;

		inf			c_reginfo_mst%ROWTYPE;
		_cls_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_trm_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_preset_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_kopt_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_batch_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_img_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_msg_grp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_cashrecycle_grp_cd	c_reginfo_grp_mst.grp_cd%TYPE;
		_card_comp_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_card_stre_cd		c_reginfo_grp_mst.grp_cd%TYPE;
		_autoopncls_grp_cd	c_reginfo_grp_mst.grp_cd%TYPE;
		_set_length		int;
		_cmp_length		int;
		_set_grp_flg		int;
		_count			int;
		_grp_cd			c_reginfo_grp_mst.grp_cd%TYPE;
		_grp_typ		c_reginfo_grp_mst.grp_typ%TYPE;
		_auto_cls_time		c_reginfo_grp_mst.grp_cd%TYPE;
		_auto_opn_cshr_cd	c_reginfo_mst.auto_opn_cshr_cd%TYPE;
		_auto_opn_chkr_cd	c_reginfo_mst.auto_opn_chkr_cd%TYPE;
		_auto_cls_cshr_cd	c_reginfo_mst.auto_cls_cshr_cd%TYPE;
	BEGIN
		_set_grp_flg := 0;
		_cmp_length := 27;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION ''data params error % = %'', _cmp_length, _set_length;
		END IF;

		inf.comp_cd	:= substring(_data1 FROM 1 FOR 9);
		inf.stre_cd	:= substring(_data1 FROM 10 FOR 9);
		inf.mac_no	:= substring(_data1 FROM 19 FOR 9);

		IF _set_type = 0 THEN
			_cmp_length := 36;
			_set_length := octet_length(_data2);
			IF _set_length < _cmp_length THEN
				RAISE EXCEPTION ''data2 params error % = %'', _cmp_length, _set_length;
			END IF;

			inf.mac_typ		:= substring(_data2 FROM 1 FOR 4);
			inf.org_mac_no		:= substring(_data2 FROM 5 FOR 9);
			inf.set_owner_flg	:= substring(_data2 FROM 14 FOR 3);
			inf.mac_role1		:= substring(_data2 FROM 17 FOR 2);
			inf.mac_role2		:= substring(_data2 FROM 19 FOR 2);
			inf.mac_role3		:= substring(_data2 FROM 21 FOR 2);
			inf.pbchg_flg		:= substring(_data2 FROM 23 FOR 2);
			inf.upd_user		:= substring(_data2 FROM 25 FOR 10);
			inf.upd_system		:= substring(_data2 FROM 35 FOR 2);

			_cmp_length := 108;
			_set_length := octet_length(_data3);
			IF _set_length = _cmp_length THEN
				_set_grp_flg		:= 1;
				_cls_grp_cd		:= substring(_data3 FROM 1 FOR 9);
				_trm_grp_cd		:= substring(_data3 FROM 10 FOR 9);
				_preset_grp_cd		:= substring(_data3 FROM 19 FOR 9);
				_kopt_grp_cd		:= substring(_data3 FROM 28 FOR 9);
				_batch_grp_cd		:= substring(_data3 FROM 37 FOR 9);
				_img_grp_cd		:= substring(_data3 FROM 46 FOR 9);
				_msg_grp_cd		:= substring(_data3 FROM 55 FOR 9);
				_cashrecycle_grp_cd	:= substring(_data3 FROM 64 FOR 9);
				_card_comp_cd		:= substring(_data3 FROM 73 FOR 9);
				_card_stre_cd		:= substring(_data3 FROM 82 FOR 9);
				_autoopncls_grp_cd	:= substring(_data3 FROM 91 FOR 9);
				_auto_cls_time		:= substring(_data3 FROM 100 FOR 9);
			END IF;

			_cmp_length := 30;
			_set_length := octet_length(_data4);
			IF _set_length = _cmp_length THEN
				_auto_opn_cshr_cd	:= substring(_data4 FROM 1 FOR 10);
				_auto_opn_chkr_cd	:= substring(_data4 FROM 11 FOR 10);
				_auto_cls_cshr_cd	:= substring(_data4 FROM 21 FOR 10);
			END IF;

		END IF;

		IF _set_type = 0 THEN
			UPDATE c_reginfo_mst SET
				mac_typ = inf.mac_typ, mac_addr = _mac_addr, ip_addr = _ip_addr, brdcast_addr = _brdcast_addr, ip_addr2 = _ip_addr2,
				brdcast_addr2 = _brdcast_addr2, org_mac_no = inf.org_mac_no, crdt_trm_cd =_crdt_trm_cd, set_owner_flg = inf.set_owner_flg,
				mac_role1 = inf.mac_role1, mac_role2 = inf.mac_role2, mac_role3 = inf.mac_role3, pbchg_flg = inf.pbchg_flg,
				start_datetime = _start_datetime, end_datetime = _end_datetime, upd_datetime = _updins_datetime,
				status = 0, send_flg = 0, upd_user = inf.upd_user, upd_system = inf.upd_system,
				auto_opn_cshr_cd = _auto_opn_cshr_cd, auto_opn_chkr_cd = _auto_opn_chkr_cd, auto_cls_cshr_cd = _auto_cls_cshr_cd
			WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no;

			IF NOT FOUND THEN
				INSERT INTO c_reginfo_mst (
					comp_cd, stre_cd, mac_no,
					mac_typ, mac_addr, ip_addr, brdcast_addr, ip_addr2,
					brdcast_addr2, org_mac_no, crdt_trm_cd, set_owner_flg,
					mac_role1, mac_role2, mac_role3, pbchg_flg,
					start_datetime, end_datetime, ins_datetime, upd_datetime,
					status, send_flg, upd_user, upd_system,
					auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cd)
				VALUES  (
					inf.comp_cd, inf.stre_cd, inf.mac_no,
					inf.mac_typ, _mac_addr, _ip_addr, _brdcast_addr, _ip_addr2,
					_brdcast_addr2, inf.org_mac_no, _crdt_trm_cd, inf.set_owner_flg, 
					inf.mac_role1, inf.mac_role2, inf.mac_role3, inf.pbchg_flg,
					_start_datetime, _end_datetime, _updins_datetime, _updins_datetime,
					0, 0, inf.upd_user, inf.upd_system,
					_auto_opn_cshr_cd, _auto_opn_chkr_cd, _auto_cls_cshr_cd );
			END IF;

			IF _set_grp_flg = 1 THEN
-- LOOP Start
				_count	:= 1;
				LOOP
					IF _count = 1 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _cls_grp_cd;
					ELSIF _count = 2 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _trm_grp_cd;
					ELSIF _count = 3 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _preset_grp_cd;
					ELSIF _count = 4 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _kopt_grp_cd;
					ELSIF _count = 5 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _batch_grp_cd;
					ELSIF _count = 6 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _img_grp_cd;
					ELSIF _count = 7 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _msg_grp_cd;
					ELSIF _count = 8 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _cashrecycle_grp_cd;
					ELSIF _count = 9 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _card_comp_cd;
					ELSIF _count = 10 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _card_stre_cd;
					ELSIF _count = 11 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _autoopncls_grp_cd;
					ELSIF _count = 12 THEN
						_grp_typ	:= _count;
						_grp_cd		:= _auto_cls_time;
					ELSE					
						EXIT;
					END IF;

-- RAISE NOTICE ''CHK % % %'', _count, _grp_typ, _grp_cd;
					UPDATE c_reginfo_grp_mst SET
						grp_cd = _grp_cd, upd_datetime = _updins_datetime, 
						status = 0, send_flg = 0, upd_user = inf.upd_user, upd_system = inf.upd_system
					WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no AND grp_typ = _grp_typ;
					IF NOT FOUND THEN
						INSERT INTO c_reginfo_grp_mst (
							comp_cd, stre_cd, mac_no, grp_typ, grp_cd, ins_datetime, upd_datetime,
							status, send_flg, upd_user, upd_system )
						VALUES (inf.comp_cd, inf.stre_cd, inf.mac_no, _grp_typ, _grp_cd, _updins_datetime, _updins_datetime,
							0, 0, inf.upd_user, inf.upd_system);
					END IF;

					_count	:= _count + 1;

				END LOOP;
			END IF;
		ELSE IF _set_type = 1 THEN
			DELETE FROM c_reginfo_mst WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no;
			DELETE FROM c_reginfo_grp_mst WHERE comp_cd = inf.comp_cd AND stre_cd = inf.stre_cd AND mac_no = inf.mac_no;
			END IF;
		END IF;

		RETURN 1;
	END;
' LANGUAGE 'plpgsql';
