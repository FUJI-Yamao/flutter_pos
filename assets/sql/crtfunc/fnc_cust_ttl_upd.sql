/*
 * ファイル名	: fnc_cust_ttl_upd.sql
 * 機能概要	: 顧客累計に対して実績更新とアンロックを行う
 *		:
 *		: 使用方法	select fnc_cust_ttl_upd(comp_cd, stre_cd, mac_no, cust_no, serial_no);
 *		: 戻り値	0: 処理終了
 *		:
 * 改訂履歴	: T.Ando	2017/11/13	初版
 *		: T.Ando	2018/07/17	M/BS連鎖で実績上げが正しく行われない不具合を修正
 */
/*
 * (C) 2017 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

CREATE or REPLACE FUNCTION fnc_cust_ttl_upd(
	_comp_cd		numeric(09),
	_stre_cd		numeric(09),
	_mac_no			numeric(09),
	_cust_no		varchar(20),
	_sday			timestamp,
	_cshr			numeric(10),
	_serial_no		numeric(43)
) RETURNS integer AS
$FUNC$
DECLARE
	_acct_cd		numeric(9)[];
	_acct_totalpnt		numeric(9)[];
	_acct_totalamt		numeric(9)[];
	_acct_totalqty		numeric(9)[];
	_acct_new_cd		numeric(9)[];
	_sql			text;
	_upsql			text;
	_month_amt		numeric(9);
	_month_visit_date	timestamp;
	_month_visit_cnt	numeric(9);
	_bnsdsc_visit_date	timestamp;
	_ttl_amt		numeric(9);
	_delivery		numeric(9);
	_acctcd			numeric(9);
	_accttotalpnt		numeric(9);
	_accttotalamt		numeric(9);
	_accttotalqty		numeric(9);
	_tflg			int2[];
	_ii			int2;
	_jj			int2;
	_n107000		int;
	_mm			varchar(2);
	_dd			varchar(2);
	_last_ym		timestamp;
	_amt_2000		numeric(9);
	_ym_2000		timestamp;
	_unlock_flg		numeric(9);
	_last_visit_date	timestamp;
	_acc_650		numeric(9);
BEGIN
	_dd := substr(_serial_no::text, 7, 2);

	-- F100700 取得
	EXECUTE 'SELECT n_data8, d_data1, n_data4, d_data1 AS d2, n_data6, n_data22 FROM c_data_log_' || _dd
		|| ' WHERE func_cd=100700 AND serial_no= ' || _serial_no
		INTO _month_amt, _month_visit_date, _month_visit_cnt, _bnsdsc_visit_date, _ttl_amt, _unlock_flg;

	IF _month_visit_date IS NULL THEN
		RETURN 0;
	END IF;

	_mm := to_char(date_part('month',_month_visit_date)::numeric,'FM99');

	-- s_cust_ttl_tbl の情報を取得、acct_cd_1は800固定
	EXECUTE 'SELECT ARRAY[800,acct_cd_2,acct_cd_3,acct_cd_4,acct_cd_5] AS acct_cd,
		ARRAY[acct_totalpnt_1,acct_totalpnt_2,acct_totalpnt_3,acct_totalpnt_4,acct_totalpnt_5] AS acct_totalpnt,
		ARRAY[acct_totalamt_1,acct_totalamt_2,acct_totalamt_3,acct_totalamt_4,acct_totalamt_5] AS acct_totalamt,
		ARRAY[acct_totalqty_1,acct_totalqty_2,acct_totalqty_3,acct_totalqty_4,acct_totalqty_5] AS acct_totalqty,
		month_visit_date_' ||  _mm || ', bnsdsc_visit_date, last_visit_date
		FROM s_cust_ttl_tbl WHERE cust_no=' || quote_literal(_cust_no) || ' AND comp_cd = ' || _comp_cd
		INTO _acct_cd, _acct_totalpnt, _acct_totalamt, _acct_totalqty, _last_ym, _ym_2000, _last_visit_date;

	-- アカウント1は800固定
	-- アカウント2～5を更新する
	_tflg := '{1,0,0,0,0,0,0,0,0,0}'::int2[];
	SELECT ARRAY(SELECT acct_cd FROM c_acct_mst WHERE end_date >= _month_visit_date AND
		start_date <= coalesce(_last_visit_date,_month_visit_date) AND acct_cd = ANY(_acct_cd)) INTO _acct_new_cd;

	IF _acct_cd[2] = ANY(_acct_new_cd) THEN _tflg[2] := 1; END IF;
	IF _acct_cd[3] = ANY(_acct_new_cd) THEN _tflg[3] := 1; END IF;
	IF _acct_cd[4] = ANY(_acct_new_cd) THEN _tflg[4] := 1; END IF;
	IF _acct_cd[5] = ANY(_acct_new_cd) THEN _tflg[5] := 1; END IF;

	-- F107000(n) 取得
	_sql := 'SELECT n_data1, CASE WHEN n_data1=800 THEN CASE WHEN ope_mode_flg=3000 THEN n_data3 + n_data5 ELSE'
		|| ' n_data3 - n_data5 END ELSE n_data3 END, n_data6, n_data7 FROM c_data_log_' || _dd || ' JOIN c_header_log_' || _dd
		|| ' USING (serial_no) WHERE func_cd=107000 AND (n_data2=0 OR n_data1=650) AND serial_no= ' || _serial_no || ' ORDER BY 1';

	_amt_2000 := 0;
	_n107000 := 0;
	_acc_650 := 0;
	FOR _acctcd, _accttotalpnt, _accttotalamt, _accttotalqty IN EXECUTE _sql LOOP
		_n107000 := 1;
		IF _acctcd = 2000 OR _acctcd = 650 THEN
			IF _acctcd = 650 THEN
			  	_acc_650 := 1;
			ELSE
				_amt_2000 := _amt_2000 + _accttotalamt + _accttotalpnt;
			END IF;
		ELSE
			FOR _ii IN 1..10 LOOP
				IF _acctcd = _acct_cd[_ii] THEN
					IF _tflg[_ii] = 0 THEN
						_acct_totalpnt[_ii] := _accttotalpnt;
						_acct_totalamt[_ii] := _accttotalamt;
						_acct_totalqty[_ii] := _accttotalqty;
						_tflg[_ii] := 1;
					ELSE
						_acct_totalpnt[_ii] := _acct_totalpnt[_ii] + _accttotalpnt;
						_acct_totalamt[_ii] := _acct_totalamt[_ii] + _accttotalamt;
						_acct_totalqty[_ii] := _acct_totalqty[_ii] + _accttotalqty;
					END IF;
					EXIT;
				END IF;
				IF _acct_cd[_ii] = 0 THEN
					_acct_cd[_ii]		:= _acctcd;
					_acct_totalpnt[_ii]	:= _accttotalpnt;
					_acct_totalamt[_ii]	:= _accttotalamt;
					_acct_totalqty[_ii]	:= _accttotalqty;
					_tflg[_ii]		:= 1;
					EXIT;
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	-- F108000 取得
	EXECUTE 'SELECT n_data2 FROM c_data_log_' || _dd || ' WHERE func_cd=108000 AND serial_no= ' || _serial_no INTO _delivery;

	-- s_cust_ttl_tbl のUPDATE用のSQLを作成
	_upsql := 'UPDATE s_cust_ttl_tbl SET upd_datetime=now()';
	_jj := 1;
	FOR _ii IN 1..10 LOOP
		IF _tflg[_ii] = 1 THEN
			_upsql := _upsql || ',acct_cd_' || _jj || ' = ' || _acct_cd[_ii]
					|| ',acct_totalpnt_' || _jj || ' = ' || _acct_totalpnt[_ii] 
					|| ',acct_totalamt_' || _jj || ' = ' || _acct_totalamt[_ii]
					|| ',acct_totalqty_' || _jj || ' = ' || _acct_totalqty[_ii];
			_jj := _jj + 1;
			IF _jj > 5 THEN EXIT; END IF;
		END IF;
	END LOOP;

	WHILE _jj <= 5 LOOP
		_upsql := _upsql || ', acct_cd_' || _jj || ' = 0 ' || ',acct_totalpnt_' || _jj || ' = 0 '
			|| ',acct_totalamt_' || _jj || ' = 0 ' || ',acct_totalqty_' || _jj || ' = 0 ';
		_jj := _jj + 1;
	END LOOP;

	IF to_char(_last_ym, 'YYYYMM') = to_char(_month_visit_date,'YYYYMM') THEN
		_upsql := _upsql || ',month_amt_' || _mm || ' = month_amt_' || _mm || ' +' || _month_amt
			|| ',month_visit_date_' || _mm || ' = ' || quote_literal(_month_visit_date)
			|| ',month_visit_cnt_' || _mm || ' = month_visit_cnt_' || _mm || ' +' || _month_visit_cnt;
	ELSE
		_upsql := _upsql || ',month_amt_' || _mm || ' = ' || _month_amt
			|| ',month_visit_date_' || _mm || ' = ' || quote_literal(_month_visit_date)
			|| ',month_visit_cnt_' || _mm || ' = '  || _month_visit_cnt;
	END IF;

	IF to_char(_sday, 'YYYYMM') <> to_char(_last_visit_date,'YYYYMM') THEN
		_upsql := _upsql || ',ttl_amt = ' || _ttl_amt;
	ELSE
		_upsql := _upsql || ',ttl_amt = ttl_amt + ' || _ttl_amt;
	END IF;

	IF _amt_2000 <> 0 THEN
		IF to_char(_ym_2000, 'YYYYMM') = to_char(_month_visit_date,'YYYYMM') THEN
			_upsql := _upsql || ',bnsdsc_amt = bnsdsc_amt +' || _amt_2000
				|| ',bnsdsc_visit_date = ' || quote_literal(_month_visit_date);
		ELSE
			_upsql := _upsql || ',bnsdsc_amt = ' || _amt_2000
				|| ',bnsdsc_visit_date = ' || quote_literal(_month_visit_date);
		END IF;
	ELSE
		IF _acc_650 <> 0 THEN
			_upsql := _upsql || ',bnsdsc_visit_date = ' || quote_literal(_month_visit_date);
		END IF;
	END IF;

	IF _delivery > 0 and _month_visit_cnt >= 0 THEN
		_upsql := _upsql || ',delivery_date=' || quote_literal(_month_visit_date);
	END IF;

	IF  _unlock_flg = 1 THEN
		_upsql := _upsql || ',enq_comp_cd=0, enq_stre_cd=0, enq_mac_no=0, enq_datetime=NULL';
	END IF;

	IF _last_visit_date IS NULL OR _last_visit_date < _sday THEN
		_upsql := _upsql || ',last_visit_date=' || quote_literal(_sday);
	END IF;

	_upsql := _upsql || ',upd_user=' || _cshr || ',upd_system=2'
		|| ' WHERE cust_no =' || quote_literal(_cust_no) || ' AND comp_cd =' || _comp_cd;

	EXECUTE _upsql;

	-- 初回来店
	IF _last_visit_date IS NULL THEN
		EXECUTE 'UPDATE c_cust_mst SET admission_date=' || quote_literal(_month_visit_date) || '::date, upd_datetime=now()'
			|| ' WHERE cust_no =' || quote_literal(_cust_no) || ' AND comp_cd =' || _comp_cd
			|| ' AND admission_date IS NULL';
	END IF;

	RETURN 0;
END
$FUNC$ LANGUAGE plpgsql;

