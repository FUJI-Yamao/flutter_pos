--=======================================================================================
-- s_cust_ttl_tbl point add mentenance -> Update PL/PGSQL Function
--
--	Parameter
--		$1  -- send_who -> 0:ts-2100 1:web2100 2:SC
--		$2  -- set_type -> 0:Update Only
--		$3  -- insert datetime or update datetime
--		$4  -- store code
--		$5  -- data1
--			cust_no			-- 13 digit
--			total_point		--  8 digit(累計ポイント)
--			total_buy_rslt		-- 10 digit(累計購入金額)
--			anyprc_term_mny		--  8 digit(1verでは無い)
--			term_chg_amt		--  8 digit(1verでは無い)
--			total_hesoamt		--  8 digit(1verでは無い)
--			mny_ttl_amt		--  8 digit(1verでは無い)
--						total 63
------------------------------------------------------------------------------------------
-- Author	: F.Saitoh
-- Start	: 2002.Sep.20 : F.Saitoh : First Edition
-- Modify	: 2003.Mar.11 : F.Saitoh : Append mny_ttl_amt
--		: 2003.Mar.24 : F.Saitoh : term_chg_amt is write field -> add field
--		: 2003.Mar.27 : F.Saitoh : Change add field check NULL
--		: 2011.May.12 : T.Saito  : Change last_visit_date Set (for postgres ver up)
--		: 2021/06/30  : Y.Okada  : 1ver対応
--		: 2023/04/09  : T.Saito  : acct_cd = 800の対応
--========================================================================================

--DROP FUNCTION fnc_trn72(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(300));
--CREATE FUNCTION fnc_trn72(INT, INT, TIMESTAMP, NUMERIC(9,0), NUMERIC(9,0), VARCHAR(300)) RETURNS int AS '
CREATE or REPLACE FUNCTION fnc_trn72(
	  _send_who		int
	, _set_type		int
	, _updins_datetime	timestamp
	, _comp_cd		numeric(09)
	, _stre_cd		numeric(09)
	, _data1		varchar(300)
) RETURNS integer AS
$FUNC$
	DECLARE
		dt			s_cust_ttl_tbl%ROWTYPE;
		_last_visit_date	s_cust_ttl_tbl.last_visit_date%TYPE;

		_set_length		int;
		_cmp_length		int;
		_total_buy_rslt		s_cust_ttl_tbl.month_amt_1%TYPE;
		_mm			varchar(2);
		_old_month_amt_x	s_cust_ttl_tbl.month_amt_1%TYPE;
		_old_month_visit_date_x	s_cust_ttl_tbl.month_visit_date_1%TYPE;
		_old_ttl_amt		s_cust_ttl_tbl.ttl_amt%TYPE;
		_upsql			text;
	BEGIN
		IF _set_type != 0 THEN
			RAISE EXCEPTION 'set_type is only 0 %', _set_type;
		END IF;
		_cmp_length := 63;
		_set_length := octet_length(_data1);
		IF _set_length < _cmp_length THEN
			RAISE EXCEPTION 'data1 params error % = %', _cmp_length, _set_length;
		ELSE
			dt.cust_no 		:= substring(_data1 FROM 1 FOR 13);
			dt.acct_totalpnt_1	:= substring(_data1 FROM 14 FOR 8);
			_total_buy_rslt		:= substring(_data1 FROM 22 FOR 10);
--			dt.anyprc_term_mny	:= substring(_data1 FROM 32 FOR 8);
--			dt.term_chg_amt		:= substring(_data1 FROM 40 FOR 8);
--			dt.total_hesoamt	:= substring(_data1 FROM 48 FOR 8);
--			dt.mny_ttl_amt		:= substring(_data1 FROM 56 FOR 8);
		END IF;

		IF _updins_datetime IS NULL THEN
			RETURN 0;
		END IF;

		dt.upd_datetime := _updins_datetime;
		dt.last_visit_date := substring((_updins_datetime)::varchar FROM 1 FOR 10);
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

		SELECT last_visit_date into _last_visit_date FROM s_cust_ttl_tbl WHERE cust_no=dt.cust_no;
		IF NOT FOUND THEN
			RAISE EXCEPTION 'cust_no % is not found !!', dt.cust_no;
		ELSE
			IF ( dt.last_visit_date < _last_visit_date ) THEN
				dt.last_visit_date = _last_visit_date;
			END IF;
		END IF;

		_mm := to_char(date_part('month',_updins_datetime)::numeric,'FM99');
		EXECUTE 'SELECT month_amt_' || _mm || ', month_visit_date_' || _mm || ', ttl_amt 
			FROM s_cust_ttl_tbl WHERE cust_no=' || quote_literal(dt.cust_no) || ' AND comp_cd = ' || _comp_cd
			INTO _old_month_amt_x, _old_month_visit_date_x, _old_ttl_amt;


		-- s_cust_ttl_tbl のUPDATE用のSQLを作成
		_upsql := 'UPDATE s_cust_ttl_tbl SET upd_datetime = ' || quote_literal(dt.upd_datetime) || ', status = 1, upd_user = '
			|| dt.upd_user || ', upd_system = ' || dt.upd_system || ', last_visit_date = ' || quote_literal(dt.last_visit_date);

		_upsql := _upsql || ', acct_cd_1 = 800 ';
		_upsql := _upsql || ', acct_totalpnt_1 = acct_totalpnt_1 + ' || dt.acct_totalpnt_1;

		IF to_char(_old_month_visit_date_x,'YYYYMM') = to_char(_updins_datetime,'YYYYMM') THEN
			_upsql := _upsql || ', month_amt_' || _mm || ' = month_amt_' || _mm || ' +' || _total_buy_rslt
				|| ', month_visit_date_' || _mm || ' = ' || quote_literal(_updins_datetime);
		ELSE
			_upsql := _upsql || ', month_amt_' || _mm || ' = ' || _total_buy_rslt
				|| ', month_visit_date_' || _mm || ' = ' || quote_literal(_updins_datetime);
		END IF;

		IF to_char(_last_visit_date, 'YYYYMM') < to_char(_updins_datetime,'YYYYMM') THEN
			_upsql := _upsql || ', ttl_amt = ' || _total_buy_rslt;
		ELSIF to_char(_last_visit_date, 'YYYYMM') > to_char(_updins_datetime,'YYYYMM') THEN
			_upsql := _upsql;
		ELSE
			_upsql := _upsql || ', ttl_amt = ttl_amt + ' || _total_buy_rslt;
		END IF;

		_upsql := _upsql || ' WHERE cust_no =' || quote_literal(dt.cust_no) || ' AND comp_cd =' || _comp_cd;

		EXECUTE _upsql;

		RETURN 1;
	END;
$FUNC$ LANGUAGE plpgsql;
