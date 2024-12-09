/*
 * ファイル名	: fnc_cust_cpn_upd.sql
 * 機能概要	: 顧客クーポン印字情報を更新する
 *		:
 *		: 使用方法	select fnc_cust_cpn_upd(cust_no, serial_no);
 *		: 戻り値	0: 処理終了
 *		:
 * 改訂履歴	: T.Ando	2017/11/13	初版
 *		: T.Ando	2017/11/14	DROP FUNCTION コマンドを削除
 *		: T.Ando	2018/07/17	M/BS連鎖で実績上げが正しく行われない不具合を修正
 *		: T.Ando	2018/12/26	標準クーポン発行仕様に対応
 */
/*
 * (C) 2017 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

CREATE or REPLACE FUNCTION fnc_cust_cpn_upd(
	_cust_no	varchar(24),
	_serial_no	numeric(43)
) RETURNS integer AS
$FUNC$
DECLARE
	_comp_cd	numeric;
	_stre_cd	numeric;
	_mac_no		numeric;
	_cshr_no	numeric;
	_cpn_id		numeric;
	_endtime	timestamp;
	_print_datetime	timestamp;
	_cnt		int;
	_tday_cnt	int;
	_total_cnt	int;
	_r0		int;
	_sql		text;
	_dd		varchar(2);
BEGIN
	_comp_cd := substr(_serial_no::text, 9, 9)::numeric;
	_dd := substr(_serial_no::text, 7, 2);

	_sql := 'SELECT comp_cd, stre_cd, mac_no, cshr_no, c_data7::numeric, n_data1::integer, endtime FROM c_data_log_' || _dd
		|| ' d JOIN c_header_log_' || _dd
		|| ' h USING (serial_no) WHERE func_cd=106501 AND d.serial_no=' || _serial_no;

	FOR _comp_cd, _stre_cd, _mac_no, _cshr_no, _cpn_id, _cnt, _endtime IN EXECUTE _sql LOOP
		IF _cnt = 0 THEN CONTINUE; END IF;

		EXECUTE 'SELECT 1, print_datetime, tday_cnt, total_cnt FROM s_cust_cpn_tbl'
			|| ' WHERE cust_no = ' || quote_literal(_cust_no)
			|| ' AND cpn_id = ' || _cpn_id
			|| ' AND comp_cd = ' || _comp_cd
			INTO _r0, _print_datetime, _tday_cnt, _total_cnt;

		IF _r0 IS NOT NULL THEN
			_total_cnt := _total_cnt + _cnt;

			IF _print_datetime::date = _endtime::date THEN
				_tday_cnt := _tday_cnt + _cnt;
			ELSE
				_tday_cnt := _cnt;
			END IF;

			EXECUTE 'UPDATE s_cust_cpn_tbl SET'
				|| ' print_datetime = ' || quote_literal(_endtime)
				|| ',prn_comp_cd = ' || _comp_cd
				|| ',prn_stre_cd = ' || _stre_cd
				|| ',prn_mac_no = ' || _mac_no
				|| ',prn_staff_cd = ' || _cshr_no
				|| ',prn_datetime = ' || quote_literal(_endtime)
				|| ',upd_datetime = ' || quote_literal(now())
				|| ',upd_user = ' || _cshr_no
				|| ',tday_cnt = ' || _tday_cnt
				|| ',total_cnt = ' || _total_cnt
				|| ' WHERE cust_no = ' || quote_literal(_cust_no)
				|| ' AND cpn_id = ' || _cpn_id
				|| ' AND comp_cd = ' || _comp_cd;
		ELSE
			EXECUTE 'INSERT INTO s_cust_cpn_tbl ('
				|| 'cust_no, cpn_id, comp_cd,'
				|| ' print_datetime, prn_comp_cd, prn_stre_cd, prn_mac_no, prn_staff_cd, prn_datetime,'
				|| ' ins_datetime, upd_datetime, upd_user, tday_cnt, total_cnt,'
				|| ' stop_flg, status, send_flg, upd_system'
				|| ') VALUES (' || quote_literal(_cust_no)
				|| ',' || _cpn_id
				|| ',' || _comp_cd
				|| ',' || quote_literal(_endtime)
				|| ',' || _comp_cd
				|| ',' || _stre_cd
				|| ',' || _mac_no
				|| ',' || _cshr_no
				|| ',' || quote_literal(_endtime)
				|| ',' || quote_literal(now())
				|| ',' || quote_literal(now())
				|| ',' || _cshr_no
				|| ',' || _cnt
				|| ',' || _cnt
				|| ',0,0,0,2)';
		END IF;
	END LOOP;

	RETURN 0;
END
$FUNC$ LANGUAGE plpgsql;

