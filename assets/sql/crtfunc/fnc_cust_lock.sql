/*
 * ファイル名	: fnc_cust_lock.sql
 * 機能概要	: 顧客累計に対してロック制御を行う
 *		:
 *		: 使用方法	select fnc_stdcust_lock(ope_mode, comp_cd, stre_cd, mac_no, cust_no, lock_flg);
 *		: パラメータ	lock_flg  0: ロックする  1: ロックしない
 *		: 戻り値	0: 正常  3: ロック中  99: その他エラー
 *		:
 * 改訂履歴	: T.Ando	2017/11/13	初版
 *		: T.Ando	2017/11/14	DROP TYPE コマンドに IF EXISTS を追加
 */
/*
 * (C) 2017 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

DROP TYPE IF EXISTS typ_stdcust_lock cascade;
CREATE TYPE typ_stdcust_lock AS (
	sp_status		int2,
	cust_no			character varying(20),
	comp_cd			numeric(9,0),
	stre_cd			numeric(9,0),
	srch_cust_no		character varying(20),
	acct_cd_1		numeric(9,0),
	acct_totalpnt_1		numeric(9,0),
	acct_totalamt_1		numeric(9,0),
	acct_totalqty_1		numeric(9,0),
	acct_cd_2		numeric(9,0),
	acct_totalpnt_2		numeric(9,0),
	acct_totalamt_2		numeric(9,0),
	acct_totalqty_2		numeric(9,0),
	acct_cd_3		numeric(9,0),
	acct_totalpnt_3		numeric(9,0),
	acct_totalamt_3		numeric(9,0),
	acct_totalqty_3		numeric(9,0),
	acct_cd_4		numeric(9,0),
	acct_totalpnt_4		numeric(9,0),
	acct_totalamt_4		numeric(9,0),
	acct_totalqty_4		numeric(9,0),
	acct_cd_5		numeric(9,0),
	acct_totalpnt_5		numeric(9,0),
	acct_totalamt_5		numeric(9,0),
	acct_totalqty_5		numeric(9,0),
	month_amt_1		numeric(9,0),
	month_amt_2		numeric(9,0),
	month_amt_3		numeric(9,0),
	month_amt_4		numeric(9,0),
	month_amt_5		numeric(9,0),
	month_amt_6		numeric(9,0),
	month_amt_7		numeric(9,0),
	month_amt_8		numeric(9,0),
	month_amt_9		numeric(9,0),
	month_amt_10		numeric(9,0),
	month_amt_11		numeric(9,0),
	month_amt_12		numeric(9,0),
	month_visit_date_1	timestamp without time zone,
	month_visit_date_2	timestamp without time zone,
	month_visit_date_3	timestamp without time zone,
	month_visit_date_4	timestamp without time zone,
	month_visit_date_5	timestamp without time zone,
	month_visit_date_6	timestamp without time zone,
	month_visit_date_7	timestamp without time zone,
	month_visit_date_8	timestamp without time zone,
	month_visit_date_9	timestamp without time zone,
	month_visit_date_10	timestamp without time zone,
	month_visit_date_11	timestamp without time zone,
	month_visit_date_12	timestamp without time zone,
	month_visit_cnt_1	smallint,
	month_visit_cnt_2	smallint,
	month_visit_cnt_3	smallint,
	month_visit_cnt_4	smallint,
	month_visit_cnt_5	smallint,
	month_visit_cnt_6	smallint,
	month_visit_cnt_7	smallint,
	month_visit_cnt_8	smallint,
	month_visit_cnt_9	smallint,
	month_visit_cnt_10	smallint,
	month_visit_cnt_11	smallint,
	month_visit_cnt_12	smallint,
	bnsdsc_amt		numeric(9,0),
	bnsdsc_visit_date	timestamp without time zone,
	ttl_amt			numeric(9,0),
	delivery_date		timestamp without time zone,
	last_name		character varying(50),
	first_name		character varying(50),
	birth_day		timestamp without time zone,
	tel_no1			character varying(25),
	tel_no2			character varying(25),
	last_visit_date		timestamp without time zone,
	pnt_service_type	smallint,
	pnt_service_limit	numeric(7,0),
	portal_flg		smallint,
	enq_comp_cd		numeric(9,0),
	enq_stre_cd		numeric(9,0),
	enq_mac_no		numeric(9,0),
	enq_datetime		timestamp without time zone,
	cust_status		smallint,
	ins_datetime		timestamp without time zone,
	upd_datetime		timestamp without time zone,
	status			smallint,
	send_flg		smallint,
	upd_user		numeric(10,0),
	upd_system		smallint,
	targ_typ		smallint,
	staff_flg		smallint,
	cust_prc_type		smallint,
	sch_acct_cd_1		numeric(9,0),
	acct_accval_1		numeric(9,0),
	acct_optotal_1		numeric(9,0),
	sch_acct_cd_2		numeric(9,0),
	acct_accval_2		numeric(9,0),
	acct_optotal_2		numeric(9,0),
	sch_acct_cd_3		numeric(9,0),
	acct_accval_3		numeric(9,0),
	acct_optotal_3		numeric(9,0),
	sch_acct_cd_4		numeric(9,0),
	acct_accval_4		numeric(9,0),
	acct_optotal_4		numeric(9,0),
	sch_acct_cd_5		numeric(9,0),
	acct_accval_5		numeric(9,0),
	acct_optotal_5		numeric(9,0),
	c_data1			character varying(20),
	n_data1			numeric(10,0),
	n_data2			numeric(9,0),
	n_data3			numeric(9,0),
	n_data4			numeric(9,0),
	n_data5			numeric(9,0),
	n_data6			numeric(9,0),
	n_data7			numeric(9,0),
	n_data8			numeric(9,0),
	n_data9			numeric(9,0),
	n_data10		numeric(9,0),
	n_data11		numeric(9,0),
	n_data12		numeric(9,0),
	n_data13		numeric(9,0),
	n_data14		numeric(9,0),
	n_data15		numeric(9,0),
	n_data16		numeric(9,0),
	s_data1			smallint,
	s_data2			smallint,
	s_data3			smallint,
	d_data1			timestamp without time zone,
	d_data2			timestamp without time zone,
	d_data3			timestamp without time zone,
	d_data4			timestamp without time zone,
	d_data5			timestamp without time zone,
	d_data6			timestamp without time zone,
	d_data7			timestamp without time zone,
	d_data8			timestamp without time zone,
	d_data9			timestamp without time zone,
	d_data10		timestamp without time zone
);

CREATE or REPLACE FUNCTION fnc_stdcust_lock(
	_ope_mode		NUMERIC(4),
	_comp_cd		NUMERIC(9),
	_stre_cd		NUMERIC(9),
	_mac_no			NUMERIC(9),
	_cust_no		VARCHAR(20),
	_lock_flg		int2
) RETURNS SETOF typ_stdcust_lock AS
$FUNC$
	DECLARE	_sv_comp_cd	NUMERIC(9);
	DECLARE	_enq_comp_cd	NUMERIC(9);
	DECLARE	_enq_stre_cd	NUMERIC(9);
	DECLARE	_enq_mac_no	NUMERIC(9);
	DECLARE	_enq_datetime	TIMESTAMP;
	DECLARE	_enq_clrtime	integer;
	DECLARE	_enq_passed	integer;
	DECLARE	_cust_status	int2;
BEGIN
	-- 現在ロック中ならエラーで返す
	-- ロックの状態とは
	-- enq_datetimeがNULL以外＆経過時刻を越えていない＆自レジ以外
	-- (自レジ：enq_comp_cd, enq_stre_cd, enq_mac_noが同じ)
	SELECT comp_cd, enq_comp_cd, enq_stre_cd, enq_mac_no, enq_datetime, cust_status
		INTO _sv_comp_cd, _enq_comp_cd, _enq_stre_cd, _enq_mac_no, _enq_datetime, _cust_status
		FROM s_cust_ttl_tbl WHERE cust_no = _cust_no AND comp_cd = _comp_cd;

	IF _sv_comp_cd IS NULL THEN
		DROP TABLE IF EXISTS tmp_s_cust_ttl_tbl;
		CREATE TEMP TABLE tmp_s_cust_ttl_tbl AS select * from s_cust_ttl_tbl WHERE FALSE;
		-- その他エラー
		RETURN QUERY INSERT INTO tmp_s_cust_ttl_tbl (cust_no,comp_cd,stre_cd)
			SELECT _cust_no, _comp_cd, _stre_cd
			RETURNING 99::smallint, *;
	ELSE
		IF _ope_mode = 2000 OR _lock_flg <> 0 THEN
			-- 訓練モードまたは
			RETURN QUERY SELECT 0::smallint, * from s_cust_ttl_tbl WHERE cust_no = _cust_no limit 1;
		ELSE
			IF _enq_datetime is NULL THEN
				-- ロックしていない
				RETURN QUERY UPDATE s_cust_ttl_tbl SET enq_comp_cd = _comp_cd, enq_stre_cd = _stre_cd,
					enq_mac_no = _mac_no, enq_datetime = clock_timestamp()
					WHERE cust_no = _cust_no AND comp_cd = _comp_cd
					RETURNING 0::smallint, *;
			ELSE
				-- 経過時刻
				_enq_clrtime := (SELECT ctrl_data::integer FROM c_ctrl_mst WHERE comp_cd = _comp_cd AND ctrl_cd = 32);
				_enq_passed := (SELECT EXTRACT(EPOCH FROM clock_timestamp() - _enq_datetime))::integer;
				IF _enq_clrtime IS NULL THEN
					_enq_clrtime := 20;
				END IF;
				IF _enq_passed > _enq_clrtime * 60 THEN
					RETURN QUERY UPDATE s_cust_ttl_tbl SET enq_comp_cd = _comp_cd, enq_stre_cd = _stre_cd,
						enq_mac_no = _mac_no, enq_datetime = clock_timestamp()
						WHERE cust_no = _cust_no AND comp_cd = _comp_cd
						RETURNING 0::smallint, *;
				ELSE
					RETURN QUERY SELECT 3::smallint, * from s_cust_ttl_tbl WHERE cust_no = _cust_no AND comp_cd = _comp_cd;
				END IF;
			END IF;
		END IF;
	END IF;
END
$FUNC$ LANGUAGE plpgsql;

