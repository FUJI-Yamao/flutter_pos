/*
 * ファイル名	: fnc_cust_stp_upd.sql
 * 機能概要	: 顧客スタンプカードテーブルを更新する
 *		:
 *		: 使用方法	select fnc_cust_stp_upd(cust_no, serial_no);
 *		: 戻り値	0: 処理終了
 *		:
 * 改訂履歴	: G.Fujii	2019/10/29	初版
 *		:
 */
/* 
 * (C) 2019 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

CREATE or REPLACE FUNCTION fnc_cust_stp_upd(
	_cust_no	varchar(24),
	_serial_no	numeric(43)
) RETURNS integer AS
$FUNC$
DECLARE
	_comp_cd	numeric(9);
	_cpn_id		numeric;
	_plan_cd	numeric;
	_cshr_no	numeric;
	_r0		numeric;
	_stp_cnt	numeric;
	_rdm_cnt	numeric;
	_tday_acc_amt	numeric;
	_acc_amt	numeric;
	_red_amt	numeric;
	_endtime	timestamp;
	_last_upd_date	timestamp;
	_sql		text;
	_dd		varchar(2);
BEGIN
	_comp_cd := substr(_serial_no::text, 9, 9)::numeric;
	_dd := substr(_serial_no::text, 7, 2);

	_sql := 'SELECT c_data7::numeric cpn_id, c_data8::numeric plan_cd, n_data1::numeric stp_cnt, n_data3::numeric rdm_cnt, endtime, cshr_no FROM c_data_log_'  || _dd
		|| ' JOIN c_header_log_' || _dd
		|| ' USING (serial_no) WHERE func_cd=106100 AND serial_no=' || _serial_no;

	FOR _cpn_id, _plan_cd, _stp_cnt, _rdm_cnt, _endtime, _cshr_no IN EXECUTE _sql LOOP
		IF _cpn_id IS NULL THEN EXIT; END IF;

		EXECUTE 'SELECT 1, tday_acc_amt, acc_amt, red_amt, last_upd_date FROM s_cust_stp_tbl'
			|| ' WHERE cust_no = ' || quote_literal(_cust_no)
			|| ' AND cpn_id = ' || _cpn_id
			|| ' AND comp_cd = ' || _comp_cd
			INTO _r0, _tday_acc_amt, _acc_amt, _red_amt, _last_upd_date;

		IF _r0 IS NOT NULL THEN
			_acc_amt := _acc_amt + _stp_cnt;
			_red_amt := _red_amt + _rdm_cnt;

			IF _last_upd_date::date = _endtime::date THEN
				_tday_acc_amt := _tday_acc_amt + _stp_cnt;
			ELSE
				_tday_acc_amt := _stp_cnt;
			END IF;

			EXECUTE 'UPDATE s_cust_stp_tbl SET'
				|| ' tday_acc_amt = ' || quote_literal(_tday_acc_amt)
				|| ',acc_amt = ' || quote_literal(_acc_amt)
				|| ',red_amt = ' || quote_literal(_red_amt)
				|| ',last_upd_date = ' || quote_literal(_endtime)
				|| ',upd_datetime = ' || quote_literal(now())
				|| ',upd_user = ' || _cshr_no
				|| ' WHERE cust_no = ' || quote_literal(_cust_no)
				|| ' AND cpn_id = ' || _cpn_id
				|| ' AND comp_cd = ' || _comp_cd;
		ELSE
			_tday_acc_amt := _stp_cnt;
			_acc_amt := _stp_cnt;
			_red_amt := _rdm_cnt;

			EXECUTE 'INSERT INTO s_cust_stp_tbl ('
				|| 'cust_no, cpn_id, comp_cd,'
				|| ' tday_acc_amt, acc_amt, red_amt, last_upd_date,'
				|| ' ins_datetime, upd_datetime, upd_user,'
				|| ' acct_cd, stop_flg, status, send_flg, upd_system'
				|| ') VALUES (' || quote_literal(_cust_no)
				|| ',' || _cpn_id
				|| ',' || _comp_cd
				|| ',' || quote_literal(_tday_acc_amt)
				|| ',' || quote_literal(_acc_amt)
				|| ',' || quote_literal(_red_amt)
				|| ',' || quote_literal(_endtime)
				|| ',' || quote_literal(now())
				|| ',' || quote_literal(now())
				|| ',' || _cshr_no
				|| ',0,0,0,0,2)';
		END IF;
	END LOOP;

	RETURN 0;
END
$FUNC$ LANGUAGE plpgsql;

