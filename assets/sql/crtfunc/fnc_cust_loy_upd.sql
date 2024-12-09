/*
 * ファイル名	: fnc_cust_loy_upd.sql
 * 機能概要	: 顧客プロモーションテーブルを更新する
 *		:
 *		: 使用方法	select fnc_cust_loy_upd(cust_no, serial_no);
 *		: 戻り値	0: 処理終了
 *		:
 * 改訂履歴	: T.Ando	2017/11/13	初版
 *		: T.Ando	2017/11/14	DROP FUNCTION コマンドを削除
 *		: T.Ando	2018/07/17	M/BS連鎖で実績上げが正しく行われない不具合を修正
 *		: T.Ando	2018/12/26	標準ロイヤリティ仕様に対応
 *		: T.Ando	2019/06/11	s_cust_loy_tbl の plan_cd に INSERT する値を変更
 */
/*
 * (C) 2017 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

CREATE or REPLACE FUNCTION fnc_cust_loy_upd(
	_cust_no	varchar(24),
	_serial_no	numeric(43)
) RETURNS integer AS
$FUNC$
DECLARE
	_comp_cd	numeric(9);
	_cpn_id		numeric;
	_plan_cd	numeric;
	_cshr_no	numeric;
	_r0		int;
	_loy_cnt	int2;
	_tday_cnt	int2[];
	_total_cnt	int2[];
	_endtime	timestamp;
	_last_sellday	timestamp;
	_sql		text;
	_dd		varchar(2);
BEGIN
	_comp_cd := substr(_serial_no::text, 9, 9)::numeric;
	_dd := substr(_serial_no::text, 7, 2);

	_sql := 'SELECT c_data7::numeric cpn_id, c_data8::numeric plan_cd, n_data1::int2 loy_cnt, endtime, cshr_no FROM c_data_log_'  || _dd
		|| ' JOIN c_header_log_' || _dd
		|| ' USING (serial_no) WHERE func_cd=106000 AND serial_no=' || _serial_no;

	FOR _cpn_id, _plan_cd, _loy_cnt, _endtime, _cshr_no IN EXECUTE _sql LOOP
		IF _cpn_id IS NULL THEN EXIT; END IF;

		EXECUTE 'SELECT 1, tday_cnt, total_cnt, last_sellday FROM s_cust_loy_tbl'
			|| ' WHERE cust_no = ' || quote_literal(_cust_no)
			|| ' AND cpn_id = ' || _cpn_id
			|| ' AND comp_cd = ' || _comp_cd
			INTO _r0, _tday_cnt, _total_cnt, _last_sellday;

		IF _r0 IS NOT NULL THEN
			_total_cnt[1] := _total_cnt[1] + _loy_cnt;

			IF _last_sellday::date = _endtime::date THEN
				_tday_cnt[1] := _tday_cnt[1] + _loy_cnt;
			ELSE
				_tday_cnt[1] := _loy_cnt;
			END IF;

			EXECUTE 'UPDATE s_cust_loy_tbl SET'
				|| ' tday_cnt = ' || quote_literal(_tday_cnt)
				|| ',total_cnt = ' || quote_literal(_total_cnt)
				|| ',last_sellday = ' || quote_literal(_endtime)
				|| ',upd_datetime = ' || quote_literal(now())
				|| ',upd_user = ' || _cshr_no
				|| ' WHERE cust_no = ' || quote_literal(_cust_no)
				|| ' AND cpn_id = ' || _cpn_id
				|| ' AND comp_cd = ' || _comp_cd;
		ELSE
			_tday_cnt[1] := _loy_cnt;
			_total_cnt[1] := _loy_cnt;

			EXECUTE 'INSERT INTO s_cust_loy_tbl ('
				|| 'cust_no, cpn_id, comp_cd,'
				|| ' plan_cd, tday_cnt, total_cnt, last_sellday, stop_flg,'
				|| ' ins_datetime, upd_datetime, upd_user,'
				|| ' status, send_flg, upd_system'
				|| ') VALUES (' || quote_literal(_cust_no)
				|| ',' || _cpn_id
				|| ',' || _comp_cd
				|| ',' || quote_literal(ARRAY[_plan_cd])
				|| ',' || quote_literal(_tday_cnt)
				|| ',' || quote_literal(_total_cnt)
				|| ',' || quote_literal(_endtime)
				|| ',' || quote_literal(ARRAY[0])
				|| ',' || quote_literal(now())
				|| ',' || quote_literal(now())
				|| ',' || _cshr_no
				|| ',0,0,2)';
		END IF;
	END LOOP;

	RETURN 0;
END
$FUNC$ LANGUAGE plpgsql;

