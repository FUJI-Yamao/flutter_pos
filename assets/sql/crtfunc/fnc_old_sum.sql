/*
 * ファイル名	: fnc_old_sum.sql
 * 機能概要	: 1verの日計実績テーブルから14verの日計実績テーブルに変換する
 *		:
 *		: 使用方法	select fnc_old_sum( '旧テーブル名', set_type, comp_cd, stre_cd, '営業日', '' );
 *		: 引数set_type	0: 作成   1: 削除(1度作成したら追記できないため)
 *		: 戻り値	旧テーブル名が対応していたら, テーブル名を返す. 
 *		: 		それ以外の場合, hqtmpをつけたテーブル名で内容はそのままコピーで返す. かつ, rdly_が付いたテーブルはWHERE句をつける.
 *		:
 * 改訂履歴	: T.Saito	2017/12/26	初版
 *		: T.Saito	2018/04/19	旧実績データに合わせるように調整
 *		: T.Saito	2019/12/05	旧実績以外はそのままコピー出来るようにする
 *		: Y.Okada	2020/07/14	レシートの印紙枚数がカウントされていないので参照する値を変更、それに伴い領収書枚数の情報セット変更
 *		: R.Kawamura	2020/07/27	コード決済実績分け関連のテーブルの対応を追加
 *		: T.Saito	2020/09/09	'rdly_' から始まるテーブルは WHERE句に企業, 店舗, 営業日をセット
 *		: T.Saito	2021/03/30	'reg_dly_tax_deal' を追加
 *		: T.Saito	2021/04/23	wgt データは1/1000するように修正
 *		: T.Saito	2021/04/27	reg_dly_mdl, reg_dly_smlのwgtを対応. 14verの税データをreg_dly_plu(sml/mdl) に追加
 *		: T.Saito	2021/05/26	reg_dly_deal_hour の旧テーブル名により, rdly_deal_hourを元にしたreg_dly_dealを作成するようにした.
 *		: Y.Okada	2021/07/08	reg_dly_deal_hour で作成するテーブル名を変更
 *		: T.Saito	2021/10/08	reg_dly_plu 作成時に同一商品で, 分類番号が異なるものがあった場合のエラーを修正
 *		: T.Saito	2021/10/13	reg_dly_tax_deal 作成時にmode(ope_mode)でGROUP BY しているのを修正
 *		: H.Sakamoto	2022/10/06	reg_dly_plu 体積(vol)を追加
 *		: T.Saito	2023/01/23	reg_dly_mdl TEMP add
 *
 */
/*
 * (C) 2017 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

CREATE or REPLACE FUNCTION fnc_old_sum( VARCHAR(100), INT, NUMERIC(9,0), NUMERIC(9,0), TIMESTAMP, VARCHAR(256) ) RETURNS VARCHAR(30) AS
$FUNC$
	DECLARE
		_tbl_name	alias for $1;
		_set_type	alias for $2;
		_comp_cd	alias for $3;
		_stre_cd	alias for $4;
		_sale_date	alias for $5;
		_ret_name	VARCHAR(100);
		_ordr_flrd	alias for $6;
	BEGIN
		_ret_name := '';

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_flow' THEN
			
			_ret_name := _tbl_name;

			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_flow;
			ELSE
				CREATE TEMP TABLE 
					reg_dly_flow 
				AS SELECT
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,sale_date::timestamp without time zone AS date_hour
					,SUM(CASE WHEN kind=1 AND sub=0 THEN data2 ELSE 0 END) AS cash_cnt
					,SUM(CASE WHEN kind=1 AND sub=0 THEN data1 ELSE 0 END) AS cash_amt
					,SUM(CASE WHEN kind=2 AND sub=1 THEN data2 ELSE 0 END) AS cha_cnt1
					,SUM(CASE WHEN kind=2 AND sub=1 THEN data3 ELSE 0 END) AS cha_qty1
					,SUM(CASE WHEN kind=2 AND sub=1 THEN data1 ELSE 0 END) AS cha_amt1
					,SUM(CASE WHEN kind=2 AND sub=2 THEN data2 ELSE 0 END) AS cha_cnt2
					,SUM(CASE WHEN kind=2 AND sub=2 THEN data3 ELSE 0 END) AS cha_qty2
					,SUM(CASE WHEN kind=2 AND sub=2 THEN data1 ELSE 0 END) AS cha_amt2
					,SUM(CASE WHEN kind=2 AND sub=3 THEN data2 ELSE 0 END) AS cha_cnt3
					,SUM(CASE WHEN kind=2 AND sub=3 THEN data3 ELSE 0 END) AS cha_qty3
					,SUM(CASE WHEN kind=2 AND sub=3 THEN data1 ELSE 0 END) AS cha_amt3
					,SUM(CASE WHEN kind=2 AND sub=4 THEN data2 ELSE 0 END) AS cha_cnt4
					,SUM(CASE WHEN kind=2 AND sub=4 THEN data3 ELSE 0 END) AS cha_qty4
					,SUM(CASE WHEN kind=2 AND sub=4 THEN data1 ELSE 0 END) AS cha_amt4
					,SUM(CASE WHEN kind=2 AND sub=5 THEN data2 ELSE 0 END) AS cha_cnt5
					,SUM(CASE WHEN kind=2 AND sub=5 THEN data3 ELSE 0 END) AS cha_qty5
					,SUM(CASE WHEN kind=2 AND sub=5 THEN data1 ELSE 0 END) AS cha_amt5
					,SUM(CASE WHEN kind=2 AND sub=6 THEN data2 ELSE 0 END) AS cha_cnt6
					,SUM(CASE WHEN kind=2 AND sub=6 THEN data3 ELSE 0 END) AS cha_qty6
					,SUM(CASE WHEN kind=2 AND sub=6 THEN data1 ELSE 0 END) AS cha_amt6
					,SUM(CASE WHEN kind=2 AND sub=7 THEN data2 ELSE 0 END) AS cha_cnt7
					,SUM(CASE WHEN kind=2 AND sub=7 THEN data3 ELSE 0 END) AS cha_qty7
					,SUM(CASE WHEN kind=2 AND sub=7 THEN data1 ELSE 0 END) AS cha_amt7
					,SUM(CASE WHEN kind=2 AND sub=8 THEN data2 ELSE 0 END) AS cha_cnt8
					,SUM(CASE WHEN kind=2 AND sub=8 THEN data3 ELSE 0 END) AS cha_qty8
					,SUM(CASE WHEN kind=2 AND sub=8 THEN data1 ELSE 0 END) AS cha_amt8
					,SUM(CASE WHEN kind=2 AND sub=9 THEN data2 ELSE 0 END) AS cha_cnt9
					,SUM(CASE WHEN kind=2 AND sub=9 THEN data3 ELSE 0 END) AS cha_qty9
					,SUM(CASE WHEN kind=2 AND sub=9 THEN data1 ELSE 0 END) AS cha_amt9
					,SUM(CASE WHEN kind=2 AND sub=10 THEN data2 ELSE 0 END) AS cha_cnt10
					,SUM(CASE WHEN kind=2 AND sub=10 THEN data3 ELSE 0 END) AS cha_qty10
					,SUM(CASE WHEN kind=2 AND sub=10 THEN data1 ELSE 0 END) AS cha_amt10
					,SUM(CASE WHEN kind=4 AND sub=1 THEN data2 ELSE 0 END) AS crdt_cnt1
					,SUM(CASE WHEN kind=4 AND sub=1 THEN data1 ELSE 0 END) AS crdt_amt1
					,SUM(CASE WHEN kind=4 AND sub=2 THEN data2 ELSE 0 END) AS crdt_cnt2
					,SUM(CASE WHEN kind=4 AND sub=2 THEN data1 ELSE 0 END) AS crdt_amt2
					,SUM(CASE WHEN kind=3 AND sub=1 THEN data2 ELSE 0 END) AS chk_cnt1
					,SUM(CASE WHEN kind=3 AND sub=1 THEN data3 ELSE 0 END) AS chk_qty1
					,SUM(CASE WHEN kind=3 AND sub=1 THEN data1 ELSE 0 END) AS chk_amt1
					,SUM(CASE WHEN kind=3 AND sub=2 THEN data2 ELSE 0 END) AS chk_cnt2
					,SUM(CASE WHEN kind=3 AND sub=2 THEN data3 ELSE 0 END) AS chk_qty2
					,SUM(CASE WHEN kind=3 AND sub=2 THEN data1 ELSE 0 END) AS chk_amt2
					,SUM(CASE WHEN kind=3 AND sub=3 THEN data2 ELSE 0 END) AS chk_cnt3
					,SUM(CASE WHEN kind=3 AND sub=3 THEN data3 ELSE 0 END) AS chk_qty3
					,SUM(CASE WHEN kind=3 AND sub=3 THEN data1 ELSE 0 END) AS chk_amt3
					,SUM(CASE WHEN kind=3 AND sub=4 THEN data2 ELSE 0 END) AS chk_cnt4
					,SUM(CASE WHEN kind=3 AND sub=4 THEN data3 ELSE 0 END) AS chk_qty4
					,SUM(CASE WHEN kind=3 AND sub=4 THEN data1 ELSE 0 END) AS chk_amt4
					,SUM(CASE WHEN kind=3 AND sub=5 THEN data2 ELSE 0 END) AS chk_cnt5
					,SUM(CASE WHEN kind=3 AND sub=5 THEN data3 ELSE 0 END) AS chk_qty5
					,SUM(CASE WHEN kind=3 AND sub=5 THEN data1 ELSE 0 END) AS chk_amt5
					,SUM(CASE WHEN kind=1 AND sub=0 THEN data4 ELSE 0 END) AS d_amt
					,SUM(CASE WHEN kind=2 AND sub=1 THEN data4 ELSE 0 END) AS cha_d_amt1
					,SUM(CASE WHEN kind=2 AND sub=2 THEN data4 ELSE 0 END) AS cha_d_amt2
					,SUM(CASE WHEN kind=2 AND sub=3 THEN data4 ELSE 0 END) AS cha_d_amt3
					,SUM(CASE WHEN kind=2 AND sub=4 THEN data4 ELSE 0 END) AS cha_d_amt4
					,SUM(CASE WHEN kind=2 AND sub=5 THEN data4 ELSE 0 END) AS cha_d_amt5
					,SUM(CASE WHEN kind=2 AND sub=6 THEN data4 ELSE 0 END) AS cha_d_amt6
					,SUM(CASE WHEN kind=2 AND sub=7 THEN data4 ELSE 0 END) AS cha_d_amt7
					,SUM(CASE WHEN kind=2 AND sub=8 THEN data4 ELSE 0 END) AS cha_d_amt8
					,SUM(CASE WHEN kind=2 AND sub=9 THEN data4 ELSE 0 END) AS cha_d_amt9
					,SUM(CASE WHEN kind=2 AND sub=10 THEN data4 ELSE 0 END) AS cha_d_amt10
					,SUM(CASE WHEN kind=4 AND sub=1 THEN data4 ELSE 0 END) AS crdt_d_amt1
					,SUM(CASE WHEN kind=4 AND sub=2 THEN data4 ELSE 0 END) AS crdt_d_amt2
					,SUM(CASE WHEN kind=3 AND sub=1 THEN data4 ELSE 0 END) AS chk_d_amt1
					,SUM(CASE WHEN kind=3 AND sub=2 THEN data4 ELSE 0 END) AS chk_d_amt2
					,SUM(CASE WHEN kind=3 AND sub=3 THEN data4 ELSE 0 END) AS chk_d_amt3
					,SUM(CASE WHEN kind=3 AND sub=4 THEN data4 ELSE 0 END) AS chk_d_amt4
					,SUM(CASE WHEN kind=3 AND sub=5 THEN data4 ELSE 0 END) AS chk_d_amt5
					,SUM(CASE WHEN kind=1 AND sub=0 THEN data5 ELSE 0 END) AS a_d_amt
					,SUM(CASE WHEN kind=2 AND sub=1 THEN data5 ELSE 0 END) AS a_cha_d_amt1
					,SUM(CASE WHEN kind=2 AND sub=2 THEN data5 ELSE 0 END) AS a_cha_d_amt2
					,SUM(CASE WHEN kind=2 AND sub=3 THEN data5 ELSE 0 END) AS a_cha_d_amt3
					,SUM(CASE WHEN kind=2 AND sub=4 THEN data5 ELSE 0 END) AS a_cha_d_amt4
					,SUM(CASE WHEN kind=2 AND sub=5 THEN data5 ELSE 0 END) AS a_cha_d_amt5
					,SUM(CASE WHEN kind=2 AND sub=6 THEN data5 ELSE 0 END) AS a_cha_d_amt6
					,SUM(CASE WHEN kind=2 AND sub=7 THEN data5 ELSE 0 END) AS a_cha_d_amt7
					,SUM(CASE WHEN kind=2 AND sub=8 THEN data5 ELSE 0 END) AS a_cha_d_amt8
					,SUM(CASE WHEN kind=2 AND sub=9 THEN data5 ELSE 0 END) AS a_cha_d_amt9
					,SUM(CASE WHEN kind=2 AND sub=10 THEN data5 ELSE 0 END) AS a_cha_d_amt10
					,SUM(CASE WHEN kind=4 AND sub=1 THEN data5 ELSE 0 END) AS a_crdt_d_amt1
					,SUM(CASE WHEN kind=4 AND sub=2 THEN data5 ELSE 0 END) AS a_crdt_d_amt2
					,SUM(CASE WHEN kind=3 AND sub=1 THEN data5 ELSE 0 END) AS a_chk_d_amt1
					,SUM(CASE WHEN kind=3 AND sub=2 THEN data5 ELSE 0 END) AS a_chk_d_amt2
					,SUM(CASE WHEN kind=3 AND sub=3 THEN data5 ELSE 0 END) AS a_chk_d_amt3
					,SUM(CASE WHEN kind=3 AND sub=4 THEN data5 ELSE 0 END) AS a_chk_d_amt4
					,SUM(CASE WHEN kind=3 AND sub=5 THEN data5 ELSE 0 END) AS a_chk_d_amt5
					,SUM(CASE WHEN kind=7 AND sub=0 THEN data2 ELSE 0 END) AS loan_cnt
					,SUM(CASE WHEN kind=7 AND sub=0 THEN data1 ELSE 0 END) AS loan_amt
					,SUM(CASE WHEN kind=5 AND sub=1 THEN data2 ELSE 0 END) AS cin_cnt1
					,SUM(CASE WHEN kind=5 AND sub=1 THEN data1 ELSE 0 END) AS cin_amt1
					,SUM(CASE WHEN kind=5 AND sub=2 THEN data2 ELSE 0 END) AS cin_cnt2
					,SUM(CASE WHEN kind=5 AND sub=2 THEN data1 ELSE 0 END) AS cin_amt2
					,SUM(CASE WHEN kind=5 AND sub=3 THEN data2 ELSE 0 END) AS cin_cnt3
					,SUM(CASE WHEN kind=5 AND sub=3 THEN data1 ELSE 0 END) AS cin_amt3
					,SUM(CASE WHEN kind=5 AND sub=4 THEN data2 ELSE 0 END) AS cin_cnt4
					,SUM(CASE WHEN kind=5 AND sub=4 THEN data1 ELSE 0 END) AS cin_amt4
					,SUM(CASE WHEN kind=5 AND sub=5 THEN data2 ELSE 0 END) AS cin_cnt5
					,SUM(CASE WHEN kind=5 AND sub=5 THEN data1 ELSE 0 END) AS cin_amt5
					,SUM(CASE WHEN kind=5 AND sub=6 THEN data2 ELSE 0 END) AS cin_cnt6
					,SUM(CASE WHEN kind=5 AND sub=6 THEN data1 ELSE 0 END) AS cin_amt6
					,SUM(CASE WHEN kind=5 AND sub=7 THEN data2 ELSE 0 END) AS cin_cnt7
					,SUM(CASE WHEN kind=5 AND sub=7 THEN data1 ELSE 0 END) AS cin_amt7
					,SUM(CASE WHEN kind=5 AND sub=8 THEN data2 ELSE 0 END) AS cin_cnt8
					,SUM(CASE WHEN kind=5 AND sub=8 THEN data1 ELSE 0 END) AS cin_amt8
					,SUM(CASE WHEN kind=5 AND sub=9 THEN data2 ELSE 0 END) AS cin_cnt9
					,SUM(CASE WHEN kind=5 AND sub=9 THEN data1 ELSE 0 END) AS cin_amt9
					,SUM(CASE WHEN kind=5 AND sub=10 THEN data2 ELSE 0 END) AS cin_cnt10
					,SUM(CASE WHEN kind=5 AND sub=10 THEN data1 ELSE 0 END) AS cin_amt10
					,SUM(CASE WHEN kind=5 AND sub=11 THEN data2 ELSE 0 END) AS cin_cnt11
					,SUM(CASE WHEN kind=5 AND sub=11 THEN data1 ELSE 0 END) AS cin_amt11
					,SUM(CASE WHEN kind=5 AND sub=12 THEN data2 ELSE 0 END) AS cin_cnt12
					,SUM(CASE WHEN kind=5 AND sub=12 THEN data1 ELSE 0 END) AS cin_amt12
					,SUM(CASE WHEN kind=5 AND sub=13 THEN data2 ELSE 0 END) AS cin_cnt13
					,SUM(CASE WHEN kind=5 AND sub=13 THEN data1 ELSE 0 END) AS cin_amt13
					,SUM(CASE WHEN kind=5 AND sub=14 THEN data2 ELSE 0 END) AS cin_cnt14
					,SUM(CASE WHEN kind=5 AND sub=14 THEN data1 ELSE 0 END) AS cin_amt14
					,SUM(CASE WHEN kind=5 AND sub=15 THEN data2 ELSE 0 END) AS cin_cnt15
					,SUM(CASE WHEN kind=5 AND sub=15 THEN data1 ELSE 0 END) AS cin_amt15
					,SUM(CASE WHEN kind=5 AND sub=16 THEN data2 ELSE 0 END) AS cin_cnt16
					,SUM(CASE WHEN kind=5 AND sub=16 THEN data1 ELSE 0 END) AS cin_amt16
					,SUM(CASE WHEN kind=6 AND sub=1 THEN data2 ELSE 0 END) AS out_cnt1
					,SUM(CASE WHEN kind=6 AND sub=1 THEN data1 ELSE 0 END) AS out_amt1
					,SUM(CASE WHEN kind=6 AND sub=2 THEN data2 ELSE 0 END) AS out_cnt2
					,SUM(CASE WHEN kind=6 AND sub=2 THEN data1 ELSE 0 END) AS out_amt2
					,SUM(CASE WHEN kind=6 AND sub=3 THEN data2 ELSE 0 END) AS out_cnt3
					,SUM(CASE WHEN kind=6 AND sub=3 THEN data1 ELSE 0 END) AS out_amt3
					,SUM(CASE WHEN kind=6 AND sub=4 THEN data2 ELSE 0 END) AS out_cnt4
					,SUM(CASE WHEN kind=6 AND sub=4 THEN data1 ELSE 0 END) AS out_amt4
					,SUM(CASE WHEN kind=6 AND sub=5 THEN data2 ELSE 0 END) AS out_cnt5
					,SUM(CASE WHEN kind=6 AND sub=5 THEN data1 ELSE 0 END) AS out_amt5
					,SUM(CASE WHEN kind=6 AND sub=6 THEN data2 ELSE 0 END) AS out_cnt6
					,SUM(CASE WHEN kind=6 AND sub=6 THEN data1 ELSE 0 END) AS out_amt6
					,SUM(CASE WHEN kind=6 AND sub=7 THEN data2 ELSE 0 END) AS out_cnt7
					,SUM(CASE WHEN kind=6 AND sub=7 THEN data1 ELSE 0 END) AS out_amt7
					,SUM(CASE WHEN kind=6 AND sub=8 THEN data2 ELSE 0 END) AS out_cnt8
					,SUM(CASE WHEN kind=6 AND sub=8 THEN data1 ELSE 0 END) AS out_amt8
					,SUM(CASE WHEN kind=6 AND sub=9 THEN data2 ELSE 0 END) AS out_cnt9
					,SUM(CASE WHEN kind=6 AND sub=9 THEN data1 ELSE 0 END) AS out_amt9
					,SUM(CASE WHEN kind=6 AND sub=10 THEN data2 ELSE 0 END) AS out_cnt10
					,SUM(CASE WHEN kind=6 AND sub=10 THEN data1 ELSE 0 END) AS out_amt10
					,SUM(CASE WHEN kind=6 AND sub=11 THEN data2 ELSE 0 END) AS out_cnt11
					,SUM(CASE WHEN kind=6 AND sub=11 THEN data1 ELSE 0 END) AS out_amt11
					,SUM(CASE WHEN kind=6 AND sub=12 THEN data2 ELSE 0 END) AS out_cnt12
					,SUM(CASE WHEN kind=6 AND sub=12 THEN data1 ELSE 0 END) AS out_amt12
					,SUM(CASE WHEN kind=6 AND sub=13 THEN data2 ELSE 0 END) AS out_cnt13
					,SUM(CASE WHEN kind=6 AND sub=13 THEN data1 ELSE 0 END) AS out_amt13
					,SUM(CASE WHEN kind=6 AND sub=14 THEN data2 ELSE 0 END) AS out_cnt14
					,SUM(CASE WHEN kind=6 AND sub=14 THEN data1 ELSE 0 END) AS out_amt14
					,SUM(CASE WHEN kind=6 AND sub=15 THEN data2 ELSE 0 END) AS out_cnt15
					,SUM(CASE WHEN kind=6 AND sub=15 THEN data1 ELSE 0 END) AS out_amt15
					,SUM(CASE WHEN kind=6 AND sub=16 THEN data2 ELSE 0 END) AS out_cnt16
					,SUM(CASE WHEN kind=6 AND sub=16 THEN data1 ELSE 0 END) AS out_amt16
					,SUM(CASE WHEN kind=9 AND sub=0 THEN data2 ELSE 0 END) AS pick_cnt
					,SUM(CASE WHEN kind=9 AND sub=0 THEN data1 ELSE 0 END) AS pick_amt
					,SUM(CASE WHEN kind=2 AND sub=1 THEN data6 ELSE 0 END) AS cha_r_amt1
					,SUM(CASE WHEN kind=2 AND sub=2 THEN data6 ELSE 0 END) AS cha_r_amt2
					,SUM(CASE WHEN kind=2 AND sub=3 THEN data6 ELSE 0 END) AS cha_r_amt3
					,SUM(CASE WHEN kind=2 AND sub=4 THEN data6 ELSE 0 END) AS cha_r_amt4
					,SUM(CASE WHEN kind=2 AND sub=5 THEN data6 ELSE 0 END) AS cha_r_amt5
					,SUM(CASE WHEN kind=2 AND sub=6 THEN data6 ELSE 0 END) AS cha_r_amt6
					,SUM(CASE WHEN kind=2 AND sub=7 THEN data6 ELSE 0 END) AS cha_r_amt7
					,SUM(CASE WHEN kind=2 AND sub=8 THEN data6 ELSE 0 END) AS cha_r_amt8
					,SUM(CASE WHEN kind=2 AND sub=9 THEN data6 ELSE 0 END) AS cha_r_amt9
					,SUM(CASE WHEN kind=2 AND sub=10 THEN data6 ELSE 0 END) AS cha_r_amt10
					,SUM(CASE WHEN kind=3 AND sub=1 THEN data6 ELSE 0 END) AS chk_r_amt1
					,SUM(CASE WHEN kind=3 AND sub=2 THEN data6 ELSE 0 END) AS chk_r_amt2
					,SUM(CASE WHEN kind=3 AND sub=3 THEN data6 ELSE 0 END) AS chk_r_amt3
					,SUM(CASE WHEN kind=3 AND sub=4 THEN data6 ELSE 0 END) AS chk_r_amt4
					,SUM(CASE WHEN kind=3 AND sub=5 THEN data6 ELSE 0 END) AS chk_r_amt5
					,SUM(CASE WHEN kind=2 AND sub=11 THEN data2 ELSE 0 END) AS cha_cnt11
					,SUM(CASE WHEN kind=2 AND sub=11 THEN data3 ELSE 0 END) AS cha_qty11
					,SUM(CASE WHEN kind=2 AND sub=11 THEN data1 ELSE 0 END) AS cha_amt11
					,SUM(CASE WHEN kind=2 AND sub=12 THEN data2 ELSE 0 END) AS cha_cnt12
					,SUM(CASE WHEN kind=2 AND sub=12 THEN data3 ELSE 0 END) AS cha_qty12
					,SUM(CASE WHEN kind=2 AND sub=12 THEN data1 ELSE 0 END) AS cha_amt12
					,SUM(CASE WHEN kind=2 AND sub=13 THEN data2 ELSE 0 END) AS cha_cnt13
					,SUM(CASE WHEN kind=2 AND sub=13 THEN data3 ELSE 0 END) AS cha_qty13
					,SUM(CASE WHEN kind=2 AND sub=13 THEN data1 ELSE 0 END) AS cha_amt13
					,SUM(CASE WHEN kind=2 AND sub=14 THEN data2 ELSE 0 END) AS cha_cnt14
					,SUM(CASE WHEN kind=2 AND sub=14 THEN data3 ELSE 0 END) AS cha_qty14
					,SUM(CASE WHEN kind=2 AND sub=14 THEN data1 ELSE 0 END) AS cha_amt14
					,SUM(CASE WHEN kind=2 AND sub=15 THEN data2 ELSE 0 END) AS cha_cnt15
					,SUM(CASE WHEN kind=2 AND sub=15 THEN data3 ELSE 0 END) AS cha_qty15
					,SUM(CASE WHEN kind=2 AND sub=15 THEN data1 ELSE 0 END) AS cha_amt15
					,SUM(CASE WHEN kind=2 AND sub=16 THEN data2 ELSE 0 END) AS cha_cnt16
					,SUM(CASE WHEN kind=2 AND sub=16 THEN data3 ELSE 0 END) AS cha_qty16
					,SUM(CASE WHEN kind=2 AND sub=16 THEN data1 ELSE 0 END) AS cha_amt16
					,SUM(CASE WHEN kind=2 AND sub=17 THEN data2 ELSE 0 END) AS cha_cnt17
					,SUM(CASE WHEN kind=2 AND sub=17 THEN data3 ELSE 0 END) AS cha_qty17
					,SUM(CASE WHEN kind=2 AND sub=17 THEN data1 ELSE 0 END) AS cha_amt17
					,SUM(CASE WHEN kind=2 AND sub=18 THEN data2 ELSE 0 END) AS cha_cnt18
					,SUM(CASE WHEN kind=2 AND sub=18 THEN data3 ELSE 0 END) AS cha_qty18
					,SUM(CASE WHEN kind=2 AND sub=18 THEN data1 ELSE 0 END) AS cha_amt18
					,SUM(CASE WHEN kind=2 AND sub=19 THEN data2 ELSE 0 END) AS cha_cnt19
					,SUM(CASE WHEN kind=2 AND sub=19 THEN data3 ELSE 0 END) AS cha_qty19
					,SUM(CASE WHEN kind=2 AND sub=19 THEN data1 ELSE 0 END) AS cha_amt19
					,SUM(CASE WHEN kind=2 AND sub=20 THEN data2 ELSE 0 END) AS cha_cnt20
					,SUM(CASE WHEN kind=2 AND sub=20 THEN data3 ELSE 0 END) AS cha_qty20
					,SUM(CASE WHEN kind=2 AND sub=20 THEN data1 ELSE 0 END) AS cha_amt20
					,SUM(CASE WHEN kind=2 AND sub=21 THEN data2 ELSE 0 END) AS cha_cnt21
					,SUM(CASE WHEN kind=2 AND sub=21 THEN data3 ELSE 0 END) AS cha_qty21
					,SUM(CASE WHEN kind=2 AND sub=21 THEN data1 ELSE 0 END) AS cha_amt21
					,SUM(CASE WHEN kind=2 AND sub=22 THEN data2 ELSE 0 END) AS cha_cnt22
					,SUM(CASE WHEN kind=2 AND sub=22 THEN data3 ELSE 0 END) AS cha_qty22
					,SUM(CASE WHEN kind=2 AND sub=22 THEN data1 ELSE 0 END) AS cha_amt22
					,SUM(CASE WHEN kind=2 AND sub=23 THEN data2 ELSE 0 END) AS cha_cnt23
					,SUM(CASE WHEN kind=2 AND sub=23 THEN data3 ELSE 0 END) AS cha_qty23
					,SUM(CASE WHEN kind=2 AND sub=23 THEN data1 ELSE 0 END) AS cha_amt23
					,SUM(CASE WHEN kind=2 AND sub=24 THEN data2 ELSE 0 END) AS cha_cnt24
					,SUM(CASE WHEN kind=2 AND sub=24 THEN data3 ELSE 0 END) AS cha_qty24
					,SUM(CASE WHEN kind=2 AND sub=24 THEN data1 ELSE 0 END) AS cha_amt24
					,SUM(CASE WHEN kind=2 AND sub=25 THEN data2 ELSE 0 END) AS cha_cnt25
					,SUM(CASE WHEN kind=2 AND sub=25 THEN data3 ELSE 0 END) AS cha_qty25
					,SUM(CASE WHEN kind=2 AND sub=25 THEN data1 ELSE 0 END) AS cha_amt25
					,SUM(CASE WHEN kind=2 AND sub=26 THEN data2 ELSE 0 END) AS cha_cnt26
					,SUM(CASE WHEN kind=2 AND sub=26 THEN data3 ELSE 0 END) AS cha_qty26
					,SUM(CASE WHEN kind=2 AND sub=26 THEN data1 ELSE 0 END) AS cha_amt26
					,SUM(CASE WHEN kind=2 AND sub=27 THEN data2 ELSE 0 END) AS cha_cnt27
					,SUM(CASE WHEN kind=2 AND sub=27 THEN data3 ELSE 0 END) AS cha_qty27
					,SUM(CASE WHEN kind=2 AND sub=27 THEN data1 ELSE 0 END) AS cha_amt27
					,SUM(CASE WHEN kind=2 AND sub=28 THEN data2 ELSE 0 END) AS cha_cnt28
					,SUM(CASE WHEN kind=2 AND sub=28 THEN data3 ELSE 0 END) AS cha_qty28
					,SUM(CASE WHEN kind=2 AND sub=28 THEN data1 ELSE 0 END) AS cha_amt28
					,SUM(CASE WHEN kind=2 AND sub=29 THEN data2 ELSE 0 END) AS cha_cnt29
					,SUM(CASE WHEN kind=2 AND sub=29 THEN data3 ELSE 0 END) AS cha_qty29
					,SUM(CASE WHEN kind=2 AND sub=29 THEN data1 ELSE 0 END) AS cha_amt29
					,SUM(CASE WHEN kind=2 AND sub=30 THEN data2 ELSE 0 END) AS cha_cnt30
					,SUM(CASE WHEN kind=2 AND sub=30 THEN data3 ELSE 0 END) AS cha_qty30
					,SUM(CASE WHEN kind=2 AND sub=30 THEN data1 ELSE 0 END) AS cha_amt30
					,SUM(CASE WHEN kind=2 AND sub=11 THEN data4 ELSE 0 END) AS cha_d_amt11
					,SUM(CASE WHEN kind=2 AND sub=12 THEN data4 ELSE 0 END) AS cha_d_amt12
					,SUM(CASE WHEN kind=2 AND sub=13 THEN data4 ELSE 0 END) AS cha_d_amt13
					,SUM(CASE WHEN kind=2 AND sub=14 THEN data4 ELSE 0 END) AS cha_d_amt14
					,SUM(CASE WHEN kind=2 AND sub=15 THEN data4 ELSE 0 END) AS cha_d_amt15
					,SUM(CASE WHEN kind=2 AND sub=16 THEN data4 ELSE 0 END) AS cha_d_amt16
					,SUM(CASE WHEN kind=2 AND sub=17 THEN data4 ELSE 0 END) AS cha_d_amt17
					,SUM(CASE WHEN kind=2 AND sub=18 THEN data4 ELSE 0 END) AS cha_d_amt18
					,SUM(CASE WHEN kind=2 AND sub=19 THEN data4 ELSE 0 END) AS cha_d_amt19
					,SUM(CASE WHEN kind=2 AND sub=20 THEN data4 ELSE 0 END) AS cha_d_amt20
					,SUM(CASE WHEN kind=2 AND sub=21 THEN data4 ELSE 0 END) AS cha_d_amt21
					,SUM(CASE WHEN kind=2 AND sub=22 THEN data4 ELSE 0 END) AS cha_d_amt22
					,SUM(CASE WHEN kind=2 AND sub=23 THEN data4 ELSE 0 END) AS cha_d_amt23
					,SUM(CASE WHEN kind=2 AND sub=24 THEN data4 ELSE 0 END) AS cha_d_amt24
					,SUM(CASE WHEN kind=2 AND sub=25 THEN data4 ELSE 0 END) AS cha_d_amt25
					,SUM(CASE WHEN kind=2 AND sub=26 THEN data4 ELSE 0 END) AS cha_d_amt26
					,SUM(CASE WHEN kind=2 AND sub=27 THEN data4 ELSE 0 END) AS cha_d_amt27
					,SUM(CASE WHEN kind=2 AND sub=28 THEN data4 ELSE 0 END) AS cha_d_amt28
					,SUM(CASE WHEN kind=2 AND sub=29 THEN data4 ELSE 0 END) AS cha_d_amt29
					,SUM(CASE WHEN kind=2 AND sub=30 THEN data4 ELSE 0 END) AS cha_d_amt30
					,SUM(CASE WHEN kind=2 AND sub=11 THEN data5 ELSE 0 END) AS a_cha_d_amt11
					,SUM(CASE WHEN kind=2 AND sub=12 THEN data5 ELSE 0 END) AS a_cha_d_amt12
					,SUM(CASE WHEN kind=2 AND sub=13 THEN data5 ELSE 0 END) AS a_cha_d_amt13
					,SUM(CASE WHEN kind=2 AND sub=14 THEN data5 ELSE 0 END) AS a_cha_d_amt14
					,SUM(CASE WHEN kind=2 AND sub=15 THEN data5 ELSE 0 END) AS a_cha_d_amt15
					,SUM(CASE WHEN kind=2 AND sub=16 THEN data5 ELSE 0 END) AS a_cha_d_amt16
					,SUM(CASE WHEN kind=2 AND sub=17 THEN data5 ELSE 0 END) AS a_cha_d_amt17
					,SUM(CASE WHEN kind=2 AND sub=18 THEN data5 ELSE 0 END) AS a_cha_d_amt18
					,SUM(CASE WHEN kind=2 AND sub=19 THEN data5 ELSE 0 END) AS a_cha_d_amt19
					,SUM(CASE WHEN kind=2 AND sub=20 THEN data5 ELSE 0 END) AS a_cha_d_amt20
					,SUM(CASE WHEN kind=2 AND sub=21 THEN data5 ELSE 0 END) AS a_cha_d_amt21
					,SUM(CASE WHEN kind=2 AND sub=22 THEN data5 ELSE 0 END) AS a_cha_d_amt22
					,SUM(CASE WHEN kind=2 AND sub=23 THEN data5 ELSE 0 END) AS a_cha_d_amt23
					,SUM(CASE WHEN kind=2 AND sub=24 THEN data5 ELSE 0 END) AS a_cha_d_amt24
					,SUM(CASE WHEN kind=2 AND sub=25 THEN data5 ELSE 0 END) AS a_cha_d_amt25
					,SUM(CASE WHEN kind=2 AND sub=26 THEN data5 ELSE 0 END) AS a_cha_d_amt26
					,SUM(CASE WHEN kind=2 AND sub=27 THEN data5 ELSE 0 END) AS a_cha_d_amt27
					,SUM(CASE WHEN kind=2 AND sub=28 THEN data5 ELSE 0 END) AS a_cha_d_amt28
					,SUM(CASE WHEN kind=2 AND sub=29 THEN data5 ELSE 0 END) AS a_cha_d_amt29
					,SUM(CASE WHEN kind=2 AND sub=30 THEN data5 ELSE 0 END) AS a_cha_d_amt30
					,SUM(CASE WHEN kind=2 AND sub=11 THEN data6 ELSE 0 END) AS cha_r_amt11
					,SUM(CASE WHEN kind=2 AND sub=12 THEN data6 ELSE 0 END) AS cha_r_amt12
					,SUM(CASE WHEN kind=2 AND sub=13 THEN data6 ELSE 0 END) AS cha_r_amt13
					,SUM(CASE WHEN kind=2 AND sub=14 THEN data6 ELSE 0 END) AS cha_r_amt14
					,SUM(CASE WHEN kind=2 AND sub=15 THEN data6 ELSE 0 END) AS cha_r_amt15
					,SUM(CASE WHEN kind=2 AND sub=16 THEN data6 ELSE 0 END) AS cha_r_amt16
					,SUM(CASE WHEN kind=2 AND sub=17 THEN data6 ELSE 0 END) AS cha_r_amt17
					,SUM(CASE WHEN kind=2 AND sub=18 THEN data6 ELSE 0 END) AS cha_r_amt18
					,SUM(CASE WHEN kind=2 AND sub=19 THEN data6 ELSE 0 END) AS cha_r_amt19
					,SUM(CASE WHEN kind=2 AND sub=20 THEN data6 ELSE 0 END) AS cha_r_amt20
					,SUM(CASE WHEN kind=2 AND sub=21 THEN data6 ELSE 0 END) AS cha_r_amt21
					,SUM(CASE WHEN kind=2 AND sub=22 THEN data6 ELSE 0 END) AS cha_r_amt22
					,SUM(CASE WHEN kind=2 AND sub=23 THEN data6 ELSE 0 END) AS cha_r_amt23
					,SUM(CASE WHEN kind=2 AND sub=24 THEN data6 ELSE 0 END) AS cha_r_amt24
					,SUM(CASE WHEN kind=2 AND sub=25 THEN data6 ELSE 0 END) AS cha_r_amt25
					,SUM(CASE WHEN kind=2 AND sub=26 THEN data6 ELSE 0 END) AS cha_r_amt26
					,SUM(CASE WHEN kind=2 AND sub=27 THEN data6 ELSE 0 END) AS cha_r_amt27
					,SUM(CASE WHEN kind=2 AND sub=28 THEN data6 ELSE 0 END) AS cha_r_amt28
					,SUM(CASE WHEN kind=2 AND sub=29 THEN data6 ELSE 0 END) AS cha_r_amt29
					,SUM(CASE WHEN kind=2 AND sub=30 THEN data6 ELSE 0 END) AS cha_r_amt30
				FROM
					rdly_flow
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					mac_no
					,chkr_no
					,cshr_no
					,sale_date ;
			END IF;
		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_deal' THEN

			_ret_name := _tbl_name;

			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_deal;
			ELSE

				CREATE TEMP TABLE reg_dly_deal (
					 stre_cd NUMERIC(9)
					,mac_no NUMERIC(9)
					,chkr_no NUMERIC(10)
					,cshr_no NUMERIC(10)
					,sale_date timestamp
					,date_hour timestamp
					,sale_amt NUMERIC(12) default '0'
					,grssl_amt NUMERIC(12) default '0'
					,netsl_amt NUMERIC(12) default '0'
					,cust NUMERIC(12) default '0'
					,mbr_cust NUMERIC(12) default '0'
					,people_cnt NUMERIC(12) default '0'
					,qty NUMERIC(12) default '0'
					,wgt NUMERIC(15,3) default '0'
					,prf_amt NUMERIC(14,2) default '0'
					,nontaxbl_qty NUMERIC(12) default '0'
					,nontaxbl NUMERIC(12) default '0'
					,ex_taxbl_qty NUMERIC(12) default '0'
					,ex_taxbl NUMERIC(12) default '0'
					,in_taxbl_qty NUMERIC(12) default '0'
					,in_taxbl NUMERIC(12) default '0'
					,ex_ttax NUMERIC(12) default '0'
					,ex_itax NUMERIC(12) default '0'
					,in_ttax NUMERIC(12) default '0'
					,in_itax NUMERIC(12) default '0'
					,ref_qty NUMERIC(12) default '0'
					,ref_amt NUMERIC(12) default '0'
					,corr_qty NUMERIC(12) default '0'
					,corr_amt NUMERIC(12) default '0'
					,void_qty NUMERIC(12) default '0'
					,void_amt NUMERIC(12) default '0'
					,scrvoid_qty NUMERIC(12) default '0'
					,scrvoid_amt NUMERIC(12) default '0'
					,btl_ret_qty NUMERIC(12) default '0'
					,btl_ret_amt NUMERIC(12) default '0'
					,btl_ret1_qty NUMERIC(12) default '0'
					,btl_ret1_amt NUMERIC(12) default '0'
					,btl_ret1_tax_amt NUMERIC(12) default '0'
					,out_mdlcls_qty NUMERIC(12) default '0'
					,out_mdlcls_amt NUMERIC(12) default '0'
					,man_cnt NUMERIC(12) default '0'
					,cancel_cnt NUMERIC(12) default '0'
					,cancel_amt NUMERIC(12) default '0'
					,mvoid_cnt NUMERIC(12) default '0'
					,mvoid_amt NUMERIC(12) default '0'
					,mvoid_crdt_cnt NUMERIC(12) default '0'
					,mvoid_crdt_amt NUMERIC(12) default '0'
					,mvoid_debit_cnt NUMERIC(12) default '0'
					,mvoid_debit_amt NUMERIC(12) default '0'
					,mscrap_cnt NUMERIC(12) default '0'
					,mscrap_amt NUMERIC(12) default '0'
					,mtrining_cnt NUMERIC(12) default '0'
					,mtrining_amt NUMERIC(12) default '0'
					,mtrining_crdt_cnt NUMERIC(12) default '0'
					,mtrining_crdt_amt NUMERIC(12) default '0'
					,mtrining_debit_cnt NUMERIC(12) default '0'
					,mtrining_debit_amt NUMERIC(12) default '0'
					,exchg_cnt NUMERIC(12) default '0'
					,work_time NUMERIC(12) default '0'
					,scan_time NUMERIC(12) default '0'
					,kyin_time NUMERIC(12) default '0'
					,chkout_time NUMERIC(12) default '0'
					,ly_cust1 NUMERIC(12) default '0'
					,ly_sale_amt1 NUMERIC(12) default '0'
					,ly_cust2 NUMERIC(12) default '0'
					,ly_sale_amt2 NUMERIC(12) default '0'
					,ly_cust3 NUMERIC(12) default '0'
					,ly_sale_amt3 NUMERIC(12) default '0'
					,ly_cust4 NUMERIC(12) default '0'
					,ly_sale_amt4 NUMERIC(12) default '0'
					,ly_cust5 NUMERIC(12) default '0'
					,ly_sale_amt5 NUMERIC(12) default '0'
					,ly_cust6 NUMERIC(12) default '0'
					,ly_sale_amt6 NUMERIC(12) default '0'
					,ly_cust7 NUMERIC(12) default '0'
					,ly_sale_amt7 NUMERIC(12) default '0'
					,ly_cust8 NUMERIC(12) default '0'
					,ly_sale_amt8 NUMERIC(12) default '0'
					,ly_cust9 NUMERIC(12) default '0'
					,ly_sale_amt9 NUMERIC(12) default '0'
					,ly_cust10 NUMERIC(12) default '0'
					,ly_sale_amt10 NUMERIC(12) default '0'
					,dsc_qty1 NUMERIC(12) default '0'
					,dsc_amt1 NUMERIC(12) default '0'
					,dsc_qty2 NUMERIC(12) default '0'
					,dsc_amt2 NUMERIC(12) default '0'
					,dsc_qty3 NUMERIC(12) default '0'
					,dsc_amt3 NUMERIC(12) default '0'
					,dsc_qty4 NUMERIC(12) default '0'
					,dsc_amt4 NUMERIC(12) default '0'
					,dsc_qty5 NUMERIC(12) default '0'
					,dsc_amt5 NUMERIC(12) default '0'
					,pdsc_qty1 NUMERIC(12) default '0'
					,pdsc_amt1 NUMERIC(12) default '0'
					,pdsc_qty2 NUMERIC(12) default '0'
					,pdsc_amt2 NUMERIC(12) default '0'
					,pdsc_qty3 NUMERIC(12) default '0'
					,pdsc_amt3 NUMERIC(12) default '0'
					,pdsc_qty4 NUMERIC(12) default '0'
					,pdsc_amt4 NUMERIC(12) default '0'
					,pdsc_qty5 NUMERIC(12) default '0'
					,pdsc_amt5 NUMERIC(12) default '0'
					,prc_chg_qty NUMERIC(12) default '0'
					,prc_chg_amt NUMERIC(12) default '0'
					,stldsc_cnt1 NUMERIC(12) default '0'
					,stldsc_amt1 NUMERIC(12) default '0'
					,stldsc_cnt2 NUMERIC(12) default '0'
					,stldsc_amt2 NUMERIC(12) default '0'
					,stldsc_cnt3 NUMERIC(12) default '0'
					,stldsc_amt3 NUMERIC(12) default '0'
					,stldsc_cnt4 NUMERIC(12) default '0'
					,stldsc_amt4 NUMERIC(12) default '0'
					,stldsc_cnt5 NUMERIC(12) default '0'
					,stldsc_amt5 NUMERIC(12) default '0'
					,stlpdsc_cnt1 NUMERIC(12) default '0'
					,stlpdsc_amt1 NUMERIC(12) default '0'
					,stlpdsc_cnt2 NUMERIC(12) default '0'
					,stlpdsc_amt2 NUMERIC(12) default '0'
					,stlpdsc_cnt3 NUMERIC(12) default '0'
					,stlpdsc_amt3 NUMERIC(12) default '0'
					,stlpdsc_cnt4 NUMERIC(12) default '0'
					,stlpdsc_amt4 NUMERIC(12) default '0'
					,stlpdsc_cnt5 NUMERIC(12) default '0'
					,stlpdsc_amt5 NUMERIC(12) default '0'
					,bdl_dsc_amt NUMERIC(12) default '0'
					,stm_dsc_amt NUMERIC(12) default '0'
					,cls_dsc_amt NUMERIC(12) default '0'
					,cls_pdsc_amt NUMERIC(12) default '0'
					,cls_samedsc_amt NUMERIC(12) default '0'
					,cat_dsc_amt NUMERIC(12) default '0'
					,cat_pdsc_amt NUMERIC(12) default '0'
					,cat_samedsc_amt NUMERIC(12) default '0'
					,brgncust_qty NUMERIC(12) default '0'
					,brgn_dsc_amt NUMERIC(12) default '0'
					,mbrgncust_qty NUMERIC(12) default '0'
					,mbrgn_dsc_amt NUMERIC(12) default '0'
					,mpricust_qty NUMERIC(12) default '0'
					,mpri_dsc_amt NUMERIC(12) default '0'
					,mbr_stlpdsc_cnt NUMERIC(12) default '0'
					,mbr_stlpdsc_amt NUMERIC(12) default '0'
					,dqty_fsppdsc NUMERIC(12) default '0'
					,dpur_fsppdsc NUMERIC(12) default '0'
					,ddsq_mulcls NUMERIC(12) default '0'
					,ddsa_mulcls NUMERIC(12) default '0'
					,dpdq_mulcls NUMERIC(12) default '0'
					,dpda_mulcls NUMERIC(12) default '0'
					,dsdq_mulcls NUMERIC(12) default '0'
					,dsda_mulcls NUMERIC(12) default '0'
					,dspq_mulcls NUMERIC(12) default '0'
					,sku_dsc_amt NUMERIC(12) default '0'
					,sku_pdsc_amt NUMERIC(12) default '0'
					,sku_samedsc_amt NUMERIC(12) default '0'
					,sptend_cnt NUMERIC(12) default '0'
					,dcau_mspur NUMERIC(14) default '0'
					,dpnt_ttlsrv NUMERIC(12) default '0'
					,dupp_cust NUMERIC(12) default '0'
					,dupp_ttlrv NUMERIC(12) default '0'
					,dupt_ttlrv NUMERIC(12) default '0'
					,dmq1_ttlsrv NUMERIC(12) default '0'
					,dmp1_ttlsrv NUMERIC(12) default '0'
					,daq1_ttlsrv NUMERIC(12) default '0'
					,dap1_ttlsrv NUMERIC(12) default '0'
					,dmq2_ttlsrv NUMERIC(12) default '0'
					,dmp2_ttlsrv NUMERIC(12) default '0'
					,daq2_ttlsrv NUMERIC(12) default '0'
					,dap2_ttlsrv NUMERIC(12) default '0'
					,dtiq_cust NUMERIC(12) default '0'
					,dtiq_ttlsrv NUMERIC(12) default '0'
					,dtip_ttlsrv NUMERIC(12) default '0'
					,dtuq_cust NUMERIC(12) default '0'
					,dtuq_ttlsrv NUMERIC(12) default '0'
					,dtup_ttlsrv NUMERIC(12) default '0'
					,dcau_fsppur NUMERIC(14) default '0'
					,dptq_addpnt NUMERIC(12) default '0'
					,dspt_addpnt NUMERIC(12) default '0'
					,dpur_addmul NUMERIC(14) default '0'
					,dpnt_cust NUMERIC(12) default '0'
					,warranty_cnt NUMERIC(12) default '0'
					,prom_ticket_qty NUMERIC(12) default '0'
					,receipt_gp1_qty NUMERIC(12) default '0'
					,receipt_gp2_qty NUMERIC(12) default '0'
					,receipt_gp3_qty NUMERIC(12) default '0'
					,receipt_gp4_qty NUMERIC(12) default '0'
					,receipt_gp5_qty NUMERIC(12) default '0'
					,receipt_gp6_qty NUMERIC(12) default '0'
					,plu_point_ttl NUMERIC(12) default '0'
					,selfgate_amt NUMERIC(12) default '0'
					,selfgate_cust NUMERIC(12) default '0'
					,selfgate_qty NUMERIC(12) default '0'
					,stamp_cust1 NUMERIC(12) default '0'
					,stamp_point1 NUMERIC(12) default '0'
					,stamp_cust2 NUMERIC(12) default '0'
					,stamp_point2 NUMERIC(12) default '0'
					,stamp_cust3 NUMERIC(12) default '0'
					,stamp_point3 NUMERIC(12) default '0'
					,stamp_cust4 NUMERIC(12) default '0'
					,stamp_point4 NUMERIC(12) default '0'
					,stamp_cust5 NUMERIC(12) default '0'
					,stamp_point5 NUMERIC(12) default '0'
					,vmc_chgtckt_cnt NUMERIC(12) default '0'
					,vmc_chg_amt NUMERIC(12) default '0'
					,total_chgamt NUMERIC(12) default '0'
					,vmc_chg_cnt NUMERIC(12) default '0'
					,vmc_hesotckt_cnt NUMERIC(12) default '0'
					,vmc_heso_amt NUMERIC(12) default '0'
					,total_hesoamt NUMERIC(12) default '0'
					,vmc_heso_cnt NUMERIC(12) default '0'
					,receipt_gp1_amt NUMERIC(12) default '0'
					,receipt_gp2_amt NUMERIC(12) default '0'
					,receipt_gp3_amt NUMERIC(12) default '0'
					,receipt_gp4_amt NUMERIC(12) default '0'
					,receipt_gp5_amt NUMERIC(12) default '0'
					,receipt_gp6_amt NUMERIC(12) default '0'
					,c_mdsc_amt NUMERIC(12) default '0'
					,c_mpdsc_amt NUMERIC(12) default '0'
					,c_msdsc_amt NUMERIC(12) default '0'
					,i_mdsc_amt NUMERIC(12) default '0'
					,i_mpdsc_amt NUMERIC(12) default '0'
					,mstm_dsc_amt NUMERIC(12) default '0'
					,mbdl_dsc_amt NUMERIC(12) default '0'
					,mny_ttl NUMERIC(14) default '0'
					,mny_today_cust NUMERIC(12) default '0'
					,mny_today_amt NUMERIC(12) default '0'
					,mny_tckt_cnt1 NUMERIC(12) default '0'
					,mny_tckt_amt1 NUMERIC(12) default '0'
					,mny_tckt_cnt2 NUMERIC(12) default '0'
					,mny_tckt_amt2 NUMERIC(12) default '0'
					,mny_tckt_cnt3 NUMERIC(12) default '0'
					,mny_tckt_amt3 NUMERIC(12) default '0'
					,mny_next_amt NUMERIC(12) default '0'
					,mny_re_cnt NUMERIC(12) default '0'
					,mny_re_amt NUMERIC(12) default '0'
					,prom_stldsc_cnt NUMERIC(12) default '0'
					,prom_stldsc_amt NUMERIC(12) default '0'
					,prom_stlpdsc_cnt NUMERIC(12) default '0'
					,prom_stlpdsc_amt NUMERIC(12) default '0'
					,plu_point_qty NUMERIC(12) default '0'
					,plu_point_amt NUMERIC(12) default '0'
					,plu_point_cust NUMERIC(12) default '0'
					,rct_rpr_qty NUMERIC(12) default '0'
					,stlplus_cnt1 NUMERIC(12) default '0'
					,stlplus_amt1 NUMERIC(12) default '0'
					,stlplus_cnt2 NUMERIC(12) default '0'
					,stlplus_amt2 NUMERIC(12) default '0'
					,stlplus_cnt3 NUMERIC(12) default '0'
					,stlplus_amt3 NUMERIC(12) default '0'
					,stlplus_cnt4 NUMERIC(12) default '0'
					,stlplus_amt4 NUMERIC(12) default '0'
					,stlplus_cnt5 NUMERIC(12) default '0'
					,stlplus_amt5 NUMERIC(12) default '0'
					,extra_cnt NUMERIC(12) default '0'
					,extra_amt NUMERIC(12) default '0'
					,join_fee_cust NUMERIC(12) default '0'
					,join_fee_amt NUMERIC(12) default '0'
					,nocard_cash_cnt NUMERIC(12) default '0'
					,nocard_cash_amt NUMERIC(12) default '0'
					,nocard_ret_cash_cnt NUMERIC(12) default '0'
					,nocard_ret_cash_amt NUMERIC(12) default '0'
					,card_cash_cnt NUMERIC(12) default '0'
					,card_cash_amt NUMERIC(12) default '0'
					,card_ret_cash_cnt NUMERIC(12) default '0'
					,card_ret_cash_amt NUMERIC(12) default '0'
					,card_deposit_cnt NUMERIC(12) default '0'
					,card_deposit_amt NUMERIC(12) default '0'
					,card_1time_cnt NUMERIC(12) default '0'
					,card_1time_amt NUMERIC(12) default '0'
					,item_kind SMALLINT default '0'
					,bonus_point NUMERIC(12) default '0'
					,nm_stlpdsc_cnt NUMERIC(12) default '0'
					,nm_stlpdsc_amt NUMERIC(12) default '0'
					,daiq_sht NUMERIC(12) default '0'
					,ssps_i_amt NUMERIC(12) default '0'
					,ssps_i_qty NUMERIC(12) default '0'
					,ssps_i_cust NUMERIC(12) default '0'
					,ssps_u_amt NUMERIC(12) default '0'
					,ssps_u_qty NUMERIC(12) default '0'
					,ssps_u_cust NUMERIC(12) default '0'
					,cpn_qty NUMERIC(12) default '0'
					,cpn_amt NUMERIC(12) default '0'
					,cpn_qty2 NUMERIC(12) default '0'
					,cpn_amt2 NUMERIC(12) default '0'
					,t_netsl_amt NUMERIC(12) default '0'
					,t_intax_item_amt NUMERIC(12) default '0'
					,d_intax_amt NUMERIC(12) default '0'
					,other_st_cust NUMERIC(12) default '0'
					,other_st_amt NUMERIC(12) default '0'
					,other_st_qty NUMERIC(12) default '0'
					,edy_alarm_cnt NUMERIC(12) default '0'
					,edy_alarm_amt NUMERIC(12) default '0'
					,mscrap_qty NUMERIC(12) default '0'
					,bg_pchg_amt NUMERIC(12) default '0'
					,bg_pchg_qty NUMERIC(12) default '0'
					,mbg_pchg_amt NUMERIC(12) default '0'
					,mbg_pchg_qty NUMERIC(12) default '0'
					,tckt_iss_amt NUMERIC(12) default '0'
					,stl_waridsc_cnt NUMERIC(12) default '0'
					,stl_waridsc_amt NUMERIC(12) default '0'
					,prfree_qty NUMERIC(12) default '0'
					,stlcrdtdsc_cnt NUMERIC(12) default '0'
					,stlcrdtdsc_amt NUMERIC(12) default '0'
					,chkr_work_time NUMERIC(12) default '0'
					,chkr_scan_time NUMERIC(12) default '0'
					,chkr_kyin_time NUMERIC(12) default '0'
					,chkr_chkout_time NUMERIC(12) default '0'
					,refund_cnt NUMERIC(12) default '0'
					,taxbl_amt1 NUMERIC(12) default '0'
					,tax_amt1 NUMERIC(12) default '0'
					,taxbl_amt2 NUMERIC(12) default '0'
					,tax_amt2 NUMERIC(12) default '0'
					,taxbl_amt3 NUMERIC(12) default '0'
					,tax_amt3 NUMERIC(12) default '0'
					,taxbl_amt4 NUMERIC(12) default '0'
					,tax_amt4 NUMERIC(12) default '0'
					,taxbl_amt5 NUMERIC(12) default '0'
					,tax_amt5 NUMERIC(12) default '0'
					,taxbl_amt6 NUMERIC(12) default '0'
					,tax_amt6 NUMERIC(12) default '0'
					,taxbl_amt7 NUMERIC(12) default '0'
					,tax_amt7 NUMERIC(12) default '0'
					,taxbl_amt8 NUMERIC(12) default '0'
					,tax_amt8 NUMERIC(12) default '0'
					,PRIMARY KEY (stre_cd,mac_no,chkr_no,cshr_no,sale_date,date_hour,item_kind)
				);


				INSERT INTO reg_dly_deal 
					(stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,sale_amt
					,grssl_amt
					,netsl_amt
					,cust
					,mbr_cust
					,people_cnt
					,qty
					,wgt
					,prf_amt
					,nontaxbl_qty
					,nontaxbl
					,ex_taxbl_qty
					,ex_taxbl
					,in_taxbl_qty
					,in_taxbl
					,ex_ttax
					,ex_itax
					,in_ttax
					,in_itax
					,ref_qty
					,ref_amt
					,corr_qty
					,corr_amt
					,void_qty
					,void_amt
					,scrvoid_qty
					,scrvoid_amt
					,btl_ret_qty
					,btl_ret_amt
					,btl_ret1_amt
					,btl_ret1_tax_amt
					,out_mdlcls_qty
					,out_mdlcls_amt
					,man_cnt
					,cancel_cnt
					,cancel_amt
					,mvoid_cnt
					,mvoid_amt
					,mtrining_cnt
					,mtrining_amt
					,exchg_cnt
					,work_time
					,scan_time
					,kyin_time
					,chkout_time
					,ly_cust1
					,ly_sale_amt1
					,ly_cust2
					,ly_sale_amt2
					,ly_cust3
					,ly_sale_amt3
					,ly_cust4
					,ly_sale_amt4
					,ly_cust5
					,ly_sale_amt5
					,ly_cust6
					,ly_sale_amt6
					,ly_cust7
					,ly_sale_amt7
					,ly_cust8
					,ly_sale_amt8
					,ly_cust9
					,ly_sale_amt9
					,ly_cust10
					,ly_sale_amt10
					,dsc_qty1
					,dsc_amt1
					,dsc_qty2
					,dsc_amt2
					,dsc_qty3
					,dsc_amt3
					,dsc_qty4
					,dsc_amt4
					,dsc_qty5
					,dsc_amt5
					,pdsc_qty1
					,pdsc_amt1
					,pdsc_qty2
					,pdsc_amt2
					,pdsc_qty3
					,pdsc_amt3
					,pdsc_qty4
					,pdsc_amt4
					,pdsc_qty5
					,pdsc_amt5
					,prc_chg_qty
					,prc_chg_amt
					,stldsc_cnt1
					,stldsc_amt1
					,stldsc_cnt2
					,stldsc_amt2
					,stldsc_cnt3
					,stldsc_amt3
					,stldsc_cnt4
					,stldsc_amt4
					,stldsc_cnt5
					,stldsc_amt5
					,stlpdsc_cnt1
					,stlpdsc_amt1
					,stlpdsc_cnt2
					,stlpdsc_amt2
					,stlpdsc_cnt3
					,stlpdsc_amt3
					,stlpdsc_cnt4
					,stlpdsc_amt4
					,stlpdsc_cnt5
					,stlpdsc_amt5
					,bdl_dsc_amt
					,stm_dsc_amt
					,cls_dsc_amt
					,cls_pdsc_amt
					,cls_samedsc_amt
					,mbr_stlpdsc_cnt
					,mbr_stlpdsc_amt
					,dcau_mspur
					,dpnt_ttlsrv
					,dupp_cust
					,dupt_ttlrv
					,dmq1_ttlsrv
					,dmp1_ttlsrv
					,daq1_ttlsrv
					,dap1_ttlsrv
					,dmq2_ttlsrv
					,dmp2_ttlsrv
					,daq2_ttlsrv
					,dap2_ttlsrv
					,dtiq_cust
					,dtiq_ttlsrv
					,dtip_ttlsrv
					,dtuq_cust
					,dtuq_ttlsrv
					,dtup_ttlsrv
					,dptq_addpnt
					,dspt_addpnt
					,warranty_cnt
					,receipt_gp1_qty
					,receipt_gp2_qty
					,receipt_gp3_qty
					,receipt_gp4_qty
					,receipt_gp5_qty
					,receipt_gp6_qty
					,selfgate_amt
					,selfgate_cust
					,selfgate_qty
					,stamp_cust1
					,stamp_point1
					,stamp_cust2
					,stamp_point2
					,stamp_cust3
					,stamp_point3
					,stamp_cust4
					,stamp_point4
					,stamp_cust5
					,stamp_point5
					,vmc_chgtckt_cnt
					,vmc_chg_amt
					,vmc_chg_cnt
					,receipt_gp1_amt
					,receipt_gp2_amt
					,receipt_gp3_amt
					,receipt_gp4_amt
					,receipt_gp5_amt
					,receipt_gp6_amt
					,c_mdsc_amt
					,c_mpdsc_amt
					,c_msdsc_amt
					,mstm_dsc_amt
					,mbdl_dsc_amt
					,rct_rpr_qty
					,stlplus_cnt1
					,stlplus_amt1
					,stlplus_cnt2
					,stlplus_amt2
					,stlplus_cnt3
					,stlplus_amt3
					,stlplus_cnt4
					,stlplus_amt4
					,stlplus_cnt5
					,stlplus_amt5
					,extra_cnt
					,extra_amt
					,join_fee_cust
					,join_fee_amt
					,nm_stlpdsc_cnt
					,nm_stlpdsc_amt
					,other_st_cust
					,other_st_amt
					,other_st_qty
					,edy_alarm_cnt
					,edy_alarm_amt
					,bg_pchg_amt
					,bg_pchg_qty
					,mbg_pchg_amt
					,mbg_pchg_qty
					,tckt_iss_amt
					,stl_waridsc_cnt
					,stl_waridsc_amt
					,prfree_qty
					,stlcrdtdsc_cnt
					,stlcrdtdsc_amt
					,chkr_work_time
					,chkr_scan_time
					,chkr_kyin_time
					,chkr_chkout_time
					,refund_cnt
					,taxbl_amt1
					,tax_amt1
					,taxbl_amt2
					,tax_amt2
					,taxbl_amt3
					,tax_amt3
					,taxbl_amt4
					,tax_amt4
					,taxbl_amt5
					,tax_amt5
					,taxbl_amt6
					,tax_amt6
					,taxbl_amt7
					,tax_amt7
					,taxbl_amt8
					,tax_amt8
					)
				SELECT
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,sale_date
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data1 ELSE 0 END)                --sale_amt
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data2 ELSE 0 END)                --grssl_amt
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data3 ELSE 0 END)                --netsl_amt
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data4 ELSE 0 END)                --cust
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data5 ELSE 0 END)                --mbr_cust
					,SUM(CASE WHEN kind_cd='sale' AND sub=1 THEN data1 ELSE 0 END)                --people_cnt
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data6 ELSE 0 END)                --qty
					,SUM(CASE WHEN kind_cd='sale' AND sub=1 THEN data10 / 1000 ELSE 0 END)        --wgt
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data10 ELSE 0 END)               --prf_amt
					,SUM(CASE WHEN kind_cd='tax' AND data5=10 THEN data4 ELSE 0 END)              --nontaxbl_qty
					,SUM(CASE WHEN kind_cd='tax' AND data5=10 THEN data1 ELSE 0 END)              --nontaxbl
					,SUM(CASE WHEN kind_cd='tax' AND data5=0 THEN data4 ELSE 0 END)               --ex_taxbl_qty
					,SUM(CASE WHEN kind_cd='tax' AND data5=0 THEN data1 ELSE 0 END)               --ex_taxbl
					,SUM(CASE WHEN kind_cd='tax' AND data5=1 THEN data4 ELSE 0 END)               --in_taxbl_qty
					,SUM(CASE WHEN kind_cd='tax' AND data5=1 THEN data1 ELSE 0 END)               --in_taxbl
					,SUM(CASE WHEN kind_cd='tax' AND data5=0 THEN data2 ELSE 0 END)               --ex_ttax
					,SUM(CASE WHEN kind_cd='tax' AND data5=0 THEN data3 ELSE 0 END)               --ex_itax
					,SUM(CASE WHEN kind_cd='tax' AND data5=1 THEN data2 ELSE 0 END)               --in_ttax
					,SUM(CASE WHEN kind_cd='tax' AND data5=1 THEN data3 ELSE 0 END)               --in_itax
					,SUM(CASE WHEN kind_cd='ref' AND sub=0 THEN data1 ELSE 0 END)                 --ref_qty
					,SUM(CASE WHEN kind_cd='ref' AND sub=0 THEN data3 ELSE 0 END)                 --ref_amt
					,SUM(CASE WHEN kind_cd='corr' AND sub=0 THEN data1 ELSE 0 END)                --corr_qty
					,SUM(CASE WHEN kind_cd='corr' AND sub=0 THEN data2 ELSE 0 END)                --corr_amt
					,SUM(CASE WHEN kind_cd='corr' AND sub=0 THEN data3 ELSE 0 END)                --void_qty
					,SUM(CASE WHEN kind_cd='corr' AND sub=0 THEN data4 ELSE 0 END)                --void_amt
					,SUM(CASE WHEN kind_cd='corr' AND sub=0 THEN data5 ELSE 0 END)                --scrvoid_qty
					,SUM(CASE WHEN kind_cd='corr' AND sub=0 THEN data6 ELSE 0 END)                --scrvoid_amt
					,SUM(CASE WHEN kind_cd='btl_ret' AND sub=0 THEN data1 ELSE 0 END)             --btl_ret_qty
					,SUM(CASE WHEN kind_cd='btl_ret' AND sub=0 THEN data2 ELSE 0 END)             --btl_ret_amt
					,SUM(CASE WHEN kind_cd='btl_ret' AND sub=0 THEN data3 ELSE 0 END)             --btl_ret1_amt
					,SUM(CASE WHEN kind_cd='btl_ret' AND sub=0 THEN data4 ELSE 0 END)             --btl_ret1_tax_amt
					,SUM(CASE WHEN kind_cd='out_mdl' AND sub=0 THEN data1 ELSE 0 END)             --out_mdlcls_qty
					,SUM(CASE WHEN kind_cd='out_mdl' AND sub=0 THEN data2 ELSE 0 END)             --out_mdlcls_amt
					,SUM(CASE WHEN kind_cd='sale' AND sub=0 THEN data7 ELSE 0 END)                --man_cnt
					,SUM(CASE WHEN kind_cd='cncl' AND sub=0 THEN data1 ELSE 0 END)                --cancel_cnt
					,SUM(CASE WHEN kind_cd='cncl' AND sub=0 THEN data2 ELSE 0 END)                --cancel_amt
					,SUM(CASE WHEN kind_cd='mode' AND sub=3000 THEN data2 ELSE 0 END)             --mvoid_cnt
					,SUM(CASE WHEN kind_cd='mode' AND sub=3000 THEN data3 * -1 ELSE 0 END)        --mvoid_amt
					,SUM(CASE WHEN kind_cd='mode' AND sub=2000 THEN data2 ELSE 0 END)             --mtrining_cnt
					,SUM(CASE WHEN kind_cd='mode' AND sub=2000 THEN data3 ELSE 0 END)             --mtrining_amt
					,SUM(CASE WHEN kind_cd='exchg' AND sub=0 THEN data1 ELSE 0 END)               --exchg_cnt
					,SUM(CASE WHEN kind_cd='cshr' AND sub=0 THEN data1 ELSE 0 END)                --work_time
					,SUM(CASE WHEN kind_cd='cshr' AND sub=0 THEN data2 ELSE 0 END)                --scan_time
					,SUM(CASE WHEN kind_cd='cshr' AND sub=0 THEN data3 ELSE 0 END)                --kyin_time
					,SUM(CASE WHEN kind_cd='cshr' AND sub=0 THEN data4 ELSE 0 END)                --chkout_time
					,SUM(CASE WHEN kind_cd='ly' AND sub=1 THEN data1 ELSE 0 END)                  --ly_cust1
					,SUM(CASE WHEN kind_cd='ly' AND sub=1 THEN data2 ELSE 0 END)                  --ly_sale_amt1
					,SUM(CASE WHEN kind_cd='ly' AND sub=2 THEN data1 ELSE 0 END)                  --ly_cust2
					,SUM(CASE WHEN kind_cd='ly' AND sub=2 THEN data2 ELSE 0 END)                  --ly_sale_amt2
					,SUM(CASE WHEN kind_cd='ly' AND sub=3 THEN data1 ELSE 0 END)                  --ly_cust3
					,SUM(CASE WHEN kind_cd='ly' AND sub=3 THEN data2 ELSE 0 END)                  --ly_sale_amt3
					,SUM(CASE WHEN kind_cd='ly' AND sub=4 THEN data1 ELSE 0 END)                  --ly_cust4
					,SUM(CASE WHEN kind_cd='ly' AND sub=4 THEN data2 ELSE 0 END)                  --ly_sale_amt4
					,SUM(CASE WHEN kind_cd='ly' AND sub=5 THEN data1 ELSE 0 END)                  --ly_cust5
					,SUM(CASE WHEN kind_cd='ly' AND sub=5 THEN data2 ELSE 0 END)                  --ly_sale_amt5
					,SUM(CASE WHEN kind_cd='ly' AND sub=6 THEN data1 ELSE 0 END)                  --ly_cust6
					,SUM(CASE WHEN kind_cd='ly' AND sub=6 THEN data2 ELSE 0 END)                  --ly_sale_amt6
					,SUM(CASE WHEN kind_cd='ly' AND sub=7 THEN data1 ELSE 0 END)                  --ly_cust7
					,SUM(CASE WHEN kind_cd='ly' AND sub=7 THEN data2 ELSE 0 END)                  --ly_sale_amt7
					,SUM(CASE WHEN kind_cd='ly' AND sub=8 THEN data1 ELSE 0 END)                  --ly_cust8
					,SUM(CASE WHEN kind_cd='ly' AND sub=8 THEN data2 ELSE 0 END)                  --ly_sale_amt8
					,SUM(CASE WHEN kind_cd='ly' AND sub=9 THEN data1 ELSE 0 END)                  --ly_cust9
					,SUM(CASE WHEN kind_cd='ly' AND sub=9 THEN data2 ELSE 0 END)                  --ly_sale_amt9
					,SUM(CASE WHEN kind_cd='ly' AND sub=10 THEN data1 ELSE 0 END)                 --ly_cust10
					,SUM(CASE WHEN kind_cd='ly' AND sub=10 THEN data2 ELSE 0 END)                 --ly_sale_amt10
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=1 THEN data1 ELSE 0 END)             --dsc_qty1
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=1 THEN data2 ELSE 0 END)             --dsc_amt1
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=2 THEN data1 ELSE 0 END)             --dsc_qty2
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=2 THEN data2 ELSE 0 END)             --dsc_amt2
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=3 THEN data1 ELSE 0 END)             --dsc_qty3
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=3 THEN data2 ELSE 0 END)             --dsc_amt3
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=4 THEN data1 ELSE 0 END)             --dsc_qty4
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=4 THEN data2 ELSE 0 END)             --dsc_amt4
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=5 THEN data1 ELSE 0 END)             --dsc_qty5
					,SUM(CASE WHEN kind_cd='itm_dsc' AND sub=5 THEN data2 ELSE 0 END)             --dsc_amt5
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=1 THEN data1 ELSE 0 END)            --pdsc_qty1
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=1 THEN data2 ELSE 0 END)            --pdsc_amt1
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=2 THEN data1 ELSE 0 END)            --pdsc_qty2
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=2 THEN data2 ELSE 0 END)            --pdsc_amt2
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=3 THEN data1 ELSE 0 END)            --pdsc_qty3
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=3 THEN data2 ELSE 0 END)            --pdsc_amt3
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=4 THEN data1 ELSE 0 END)            --pdsc_qty4
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=4 THEN data2 ELSE 0 END)            --pdsc_amt4
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=5 THEN data1 ELSE 0 END)            --pdsc_qty5
					,SUM(CASE WHEN kind_cd='itm_pdsc' AND sub=5 THEN data2 ELSE 0 END)            --pdsc_amt5
					,SUM(CASE WHEN kind_cd='pchg_dsc' AND sub=0 THEN data1 ELSE 0 END)            --prc_chg_qty
					,SUM(CASE WHEN kind_cd='pchg_dsc' AND sub=0 THEN data2 ELSE 0 END)            --prc_chg_amt
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=1 THEN data1 ELSE 0 END)             --stldsc_cnt1
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=1 THEN data2 ELSE 0 END)             --stldsc_amt1
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=2 THEN data1 ELSE 0 END)             --stldsc_cnt2
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=2 THEN data2 ELSE 0 END)             --stldsc_amt2
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=3 THEN data1 ELSE 0 END)             --stldsc_cnt3
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=3 THEN data2 ELSE 0 END)             --stldsc_amt3
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=4 THEN data1 ELSE 0 END)             --stldsc_cnt4
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=4 THEN data2 ELSE 0 END)             --stldsc_amt4
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=5 THEN data1 ELSE 0 END)             --stldsc_cnt5
					,SUM(CASE WHEN kind_cd='stl_dsc' AND sub=5 THEN data2 ELSE 0 END)             --stldsc_amt5
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=1 THEN data1 ELSE 0 END)            --stlpdsc_cnt1
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=1 THEN data2 ELSE 0 END)            --stlpdsc_amt1
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=2 THEN data1 ELSE 0 END)            --stlpdsc_cnt2
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=2 THEN data2 ELSE 0 END)            --stlpdsc_amt2
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=3 THEN data1 ELSE 0 END)            --stlpdsc_cnt3
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=3 THEN data2 ELSE 0 END)            --stlpdsc_amt3
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=4 THEN data1 ELSE 0 END)            --stlpdsc_cnt4
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=4 THEN data2 ELSE 0 END)            --stlpdsc_amt4
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=5 THEN data1 ELSE 0 END)            --stlpdsc_cnt5
					,SUM(CASE WHEN kind_cd='stl_pdsc' AND sub=5 THEN data2 ELSE 0 END)            --stlpdsc_amt5
					,SUM(CASE WHEN kind_cd='bdl_dsc' AND sub=0 THEN data2 ELSE 0 END)             --bdl_dsc_amt
					,SUM(CASE WHEN kind_cd='stm_dsc' AND sub=0 THEN data2 ELSE 0 END)             --stm_dsc_amt
					,SUM(CASE WHEN kind_cd='cls_dsc' AND sub=0 THEN data2 ELSE 0 END)             --cls_dsc_amt
					,SUM(CASE WHEN kind_cd='cls_pdsc' AND sub=0 THEN data2 ELSE 0 END)            --cls_pdsc_amt
					,SUM(CASE WHEN kind_cd='cls_same_dsc' AND sub=0 THEN data2 ELSE 0 END)        --cls_samedsc_amt
					,SUM(CASE WHEN kind_cd='mbr_stl_pdsc' AND sub=0 THEN data1 ELSE 0 END)        --mbr_stlpdsc_cnt
					,SUM(CASE WHEN kind_cd='mbr_stl_pdsc' AND sub=0 THEN data2 ELSE 0 END)        --mbr_stlpdsc_amt
					,SUM(CASE WHEN kind_cd='dcau_mspur' AND sub=0 THEN data1 ELSE 0 END)          --dcau_mspur
					,SUM(CASE WHEN kind_cd='sale' AND sub=2 THEN data3 ELSE 0 END)                --dpnt_ttlsrv
					,SUM(CASE WHEN kind_cd='dupt_cust' AND sub=0 THEN data1 ELSE 0 END)           --dupp_cust
					,SUM(CASE WHEN kind_cd='sale' AND sub=2 THEN data5 ELSE 0 END)                --dupt_ttlrv
					,SUM(CASE WHEN kind_cd='m_drwbck' AND sub=1 THEN data1 ELSE 0 END)            --dmq1_ttlsrv
					,SUM(CASE WHEN kind_cd='m_drwbck' AND sub=1 THEN data2 ELSE 0 END)            --dmp1_ttlsrv
					,SUM(CASE WHEN kind_cd='a_drwbck' AND sub=1 THEN data1 ELSE 0 END)            --daq1_ttlsrv
					,SUM(CASE WHEN kind_cd='a_drwbck' AND sub=1 THEN data2 ELSE 0 END)            --dap1_ttlsrv
					,SUM(CASE WHEN kind_cd='m_drwbck' AND sub=2 THEN data1 ELSE 0 END)            --dmq2_ttlsrv
					,SUM(CASE WHEN kind_cd='m_drwbck' AND sub=2 THEN data2 ELSE 0 END)            --dmp2_ttlsrv
					,SUM(CASE WHEN kind_cd='a_drwbck' AND sub=2 THEN data1 ELSE 0 END)            --daq2_ttlsrv
					,SUM(CASE WHEN kind_cd='a_drwbck' AND sub=2 THEN data2 ELSE 0 END)            --dap2_ttlsrv
					,SUM(CASE WHEN kind_cd='tckt' AND sub=1 THEN data1 ELSE 0 END)                --dtiq_cust
					,SUM(CASE WHEN kind_cd='tckt' AND sub=1 THEN data2 ELSE 0 END)                --dtiq_ttlsrv
					,SUM(CASE WHEN kind_cd='tckt' AND sub=1 THEN data3 ELSE 0 END)                --dtip_ttlsrv
					,SUM(CASE WHEN kind_cd='tckt' AND sub=2 THEN data1 ELSE 0 END)                --dtuq_cust
					,SUM(CASE WHEN kind_cd='tckt' AND sub=2 THEN data2 ELSE 0 END)                --dtuq_ttlsrv
					,SUM(CASE WHEN kind_cd='tckt' AND sub=2 THEN data3 ELSE 0 END)                --dtup_ttlsrv
					,SUM(CASE WHEN kind_cd='addpnt' AND sub=0 THEN data1 ELSE 0 END)              --dptq_addpnt
					,SUM(CASE WHEN kind_cd='addpnt' AND sub=0 THEN data2 ELSE 0 END)              --dspt_addpnt
					,SUM(CASE WHEN kind_cd='guarantee' AND sub=0 THEN data1 ELSE 0 END)           --warranty_cnt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=1 THEN data1 ELSE 0 END)           --receipt_gp1_qty
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=2 THEN data1 ELSE 0 END)           --receipt_gp2_qty
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=3 THEN data1 ELSE 0 END)           --receipt_gp3_qty
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=4 THEN data1 ELSE 0 END)           --receipt_gp4_qty
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=5 THEN data1 ELSE 0 END)           --receipt_gp5_qty
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=6 THEN data1 ELSE 0 END)           --receipt_gp6_qty
					,SUM(CASE WHEN kind_cd='selfgate' AND sub=0 THEN data3 ELSE 0 END)            --selfgate_amt
					,SUM(CASE WHEN kind_cd='selfgate' AND sub=0 THEN data2 ELSE 0 END)            --selfgate_cust
					,SUM(CASE WHEN kind_cd='selfgate' AND sub=0 THEN data1 ELSE 0 END)            --selfgate_qty
					,SUM(CASE WHEN kind_cd='stamp' AND sub=1 THEN data1 ELSE 0 END)               --stamp_cust1
					,SUM(CASE WHEN kind_cd='stamp' AND sub=1 THEN data2 ELSE 0 END)               --stamp_point1
					,SUM(CASE WHEN kind_cd='stamp' AND sub=2 THEN data1 ELSE 0 END)               --stamp_cust2
					,SUM(CASE WHEN kind_cd='stamp' AND sub=2 THEN data2 ELSE 0 END)               --stamp_point2
					,SUM(CASE WHEN kind_cd='stamp' AND sub=3 THEN data1 ELSE 0 END)               --stamp_cust3
					,SUM(CASE WHEN kind_cd='stamp' AND sub=3 THEN data2 ELSE 0 END)               --stamp_point3
					,SUM(CASE WHEN kind_cd='stamp' AND sub=4 THEN data1 ELSE 0 END)               --stamp_cust4
					,SUM(CASE WHEN kind_cd='stamp' AND sub=4 THEN data2 ELSE 0 END)               --stamp_point4
					,SUM(CASE WHEN kind_cd='stamp' AND sub=5 THEN data1 ELSE 0 END)               --stamp_cust5
					,SUM(CASE WHEN kind_cd='stamp' AND sub=5 THEN data2 ELSE 0 END)               --stamp_point5
					,SUM(CASE WHEN kind_cd='custody_chg' AND sub=2 THEN data1 ELSE 0 END)         --vmc_chgtckt_cnt
					,SUM(CASE WHEN kind_cd='custody_chg' AND sub=2 THEN data2 ELSE 0 END)         --vmc_chg_amt
					,SUM(CASE WHEN kind_cd='custody_chg' AND sub=1 THEN data1 ELSE 0 END)         --vmc_chg_cnt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=1 THEN data2 ELSE 0 END)           --receipt_gp1_amt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=2 THEN data2 ELSE 0 END)           --receipt_gp2_amt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=3 THEN data2 ELSE 0 END)           --receipt_gp3_amt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=4 THEN data2 ELSE 0 END)           --receipt_gp4_amt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=5 THEN data2 ELSE 0 END)           --receipt_gp5_amt
					,SUM(CASE WHEN kind_cd='rvn_stamp' AND sub=6 THEN data2 ELSE 0 END)           --receipt_gp6_amt
					,SUM(CASE WHEN kind_cd='mbr_cls_dsc' AND sub=0 THEN data2 ELSE 0 END)         --c_mdsc_amt
					,SUM(CASE WHEN kind_cd='mbr_cls_pdsc' AND sub=0 THEN data2 ELSE 0 END)        --c_mpdsc_amt
					,SUM(CASE WHEN kind_cd='mbr_cls_same_dsc' AND sub=0 THEN data2 ELSE 0 END)    --c_msdsc_amt
					,SUM(CASE WHEN kind_cd='mbr_bdl_dsc' AND sub=0 THEN data2 ELSE 0 END)         --mstm_dsc_amt
					,SUM(CASE WHEN kind_cd='mbr_stm_pdsc' AND sub=0 THEN data2 ELSE 0 END)        --mbdl_dsc_amt
					,SUM(CASE WHEN kind_cd='rpr' AND sub=0 THEN data1 ELSE 0 END)                 --rct_rpr_qty
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=1 THEN data1 ELSE 0 END)            --stlplus_cnt1
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=1 THEN data2 ELSE 0 END)            --stlplus_amt1
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=2 THEN data1 ELSE 0 END)            --stlplus_cnt2
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=2 THEN data2 ELSE 0 END)            --stlplus_amt2
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=3 THEN data1 ELSE 0 END)            --stlplus_cnt3
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=3 THEN data2 ELSE 0 END)            --stlplus_amt3
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=4 THEN data1 ELSE 0 END)            --stlplus_cnt4
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=4 THEN data2 ELSE 0 END)            --stlplus_amt4
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=5 THEN data1 ELSE 0 END)            --stlplus_cnt5
					,SUM(CASE WHEN kind_cd='stl_plus' AND sub=5 THEN data2 ELSE 0 END)            --stlplus_amt5
					,SUM(CASE WHEN kind_cd='extra' AND sub=0 THEN data1 ELSE 0 END)               --extra_cnt
					,SUM(CASE WHEN kind_cd='extra' AND sub=0 THEN data2 ELSE 0 END)               --extra_amt
					,SUM(CASE WHEN kind_cd='join_fee' AND sub=0 THEN data1 ELSE 0 END)            --join_fee_cust
					,SUM(CASE WHEN kind_cd='join_fee' AND sub=0 THEN data2 ELSE 0 END)            --join_fee_amt
					,SUM(CASE WHEN kind_cd='normal_stl_pdsc' AND sub=0 THEN data1 ELSE 0 END)     --nm_stlpdsc_cnt
					,SUM(CASE WHEN kind_cd='normal_stl_pdsc' AND sub=0 THEN data2 ELSE 0 END)     --nm_stlpdsc_amt
					,SUM(CASE WHEN kind_cd='oth_mbr' AND sub=0 THEN data2 ELSE 0 END)             --other_st_cust
					,SUM(CASE WHEN kind_cd='oth_mbr' AND sub=0 THEN data3 ELSE 0 END)             --other_st_amt
					,SUM(CASE WHEN kind_cd='oth_mbr' AND sub=0 THEN data1 ELSE 0 END)             --other_st_qty
					,SUM(CASE WHEN kind_cd='edy_alrm' AND sub=0 THEN data1 ELSE 0 END)            --edy_alarm_cnt
					,SUM(CASE WHEN kind_cd='edy_alrm' AND sub=0 THEN data2 ELSE 0 END)            --edy_alarm_amt
					,SUM(CASE WHEN kind_cd='period_pchg_dsc' AND sub=0 THEN data2 ELSE 0 END)     --bg_pchg_amt
					,SUM(CASE WHEN kind_cd='period_pchg_dsc' AND sub=0 THEN data1 ELSE 0 END)     --bg_pchg_qty
					,SUM(CASE WHEN kind_cd='mbr_period_pchg_dsc' AND sub=0 THEN data2 ELSE 0 END) --mbg_pchg_amt
					,SUM(CASE WHEN kind_cd='mbr_period_pchg_dsc' AND sub=0 THEN data1 ELSE 0 END) --mbg_pchg_qty
					,SUM(CASE WHEN kind_cd='tckt' AND sub=1 THEN data4 ELSE 0 END)                --tckt_iss_amt
					,SUM(CASE WHEN kind_cd='expired' AND sub=0 THEN data1 ELSE 0 END)             --stl_waridsc_cnt
					,SUM(CASE WHEN kind_cd='expired' AND sub=0 THEN data2 ELSE 0 END)             --stl_waridsc_amt
					,SUM(CASE WHEN kind_cd='pfree' AND sub=0 THEN data1 ELSE 0 END)               --prfree_qty
					,SUM(CASE WHEN kind_cd='crdt_stl_pdsc' AND sub=0 THEN data1 ELSE 0 END)       --stlcrdtdsc_cnt
					,SUM(CASE WHEN kind_cd='crdt_stl_pdsc' AND sub=0 THEN data2 ELSE 0 END)       --stlcrdtdsc_amt
					,SUM(CASE WHEN kind_cd='chkr' AND sub=0 THEN data1 ELSE 0 END)                --chkr_work_time
					,SUM(CASE WHEN kind_cd='chkr' AND sub=0 THEN data2 ELSE 0 END)                --chkr_scan_time
					,SUM(CASE WHEN kind_cd='chkr' AND sub=0 THEN data3 ELSE 0 END)                --chkr_kyin_time
					,SUM(CASE WHEN kind_cd='chkr' AND sub=0 THEN data4 ELSE 0 END)                --chkr_chkout_time
					,SUM(CASE WHEN kind_cd='ref' AND sub=0 THEN data2 ELSE 0 END)                 --refund_cnt
					,SUM(CASE WHEN kind_cd='tax' AND sub=1 THEN data1 ELSE 0 END)                 --taxbl_amt1
					,SUM(CASE WHEN kind_cd='tax' AND sub=1 THEN data2 ELSE 0 END)                 --tax_amt1
					,SUM(CASE WHEN kind_cd='tax' AND sub=2 THEN data1 ELSE 0 END)                 --taxbl_amt2
					,SUM(CASE WHEN kind_cd='tax' AND sub=2 THEN data2 ELSE 0 END)                 --tax_amt2
					,SUM(CASE WHEN kind_cd='tax' AND sub=3 THEN data1 ELSE 0 END)                 --taxbl_amt3
					,SUM(CASE WHEN kind_cd='tax' AND sub=3 THEN data2 ELSE 0 END)                 --tax_amt3
					,SUM(CASE WHEN kind_cd='tax' AND sub=4 THEN data1 ELSE 0 END)                 --taxbl_amt4
					,SUM(CASE WHEN kind_cd='tax' AND sub=4 THEN data2 ELSE 0 END)                 --tax_amt4
					,SUM(CASE WHEN kind_cd='tax' AND sub=5 THEN data1 ELSE 0 END)                 --taxbl_amt5
					,SUM(CASE WHEN kind_cd='tax' AND sub=5 THEN data2 ELSE 0 END)                 --tax_amt5
					,SUM(CASE WHEN kind_cd='tax' AND sub=6 THEN data1 ELSE 0 END)                 --taxbl_amt6
					,SUM(CASE WHEN kind_cd='tax' AND sub=6 THEN data2 ELSE 0 END)                 --tax_amt6
					,SUM(CASE WHEN kind_cd='tax' AND sub=7 THEN data1 ELSE 0 END)                 --taxbl_amt7
					,SUM(CASE WHEN kind_cd='tax' AND sub=7 THEN data2 ELSE 0 END)                 --tax_amt7
					,SUM(CASE WHEN kind_cd='tax' AND sub=8 THEN data1 ELSE 0 END)                 --taxbl_amt8
					,SUM(CASE WHEN kind_cd='tax' AND sub=8 THEN data2 ELSE 0 END)                 --tax_amt8
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;

				-- scrap data
				INSERT INTO reg_dly_deal 
					(stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mscrap_cnt, mscrap_amt, mscrap_qty, item_kind) 
				SELECT 
					stre_cd, mac_no, chkr_no, cshr_no, sale_date, sale_date, SUM(data2), SUM(data3), SUM(data1), 1
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND kind_cd = 'mode'
					AND sub = 4000
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;

				-- order data
				INSERT INTO reg_dly_deal 
					(stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mscrap_cnt, mscrap_amt, mscrap_qty, item_kind) 
				SELECT 
					stre_cd, mac_no, chkr_no, cshr_no, sale_date, sale_date, SUM(data2), SUM(data3), SUM(data1), 2
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND kind_cd = 'mode'
					AND sub = 5000
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;

				-- stock data
				INSERT INTO reg_dly_deal 
					(stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mscrap_cnt, mscrap_amt, mscrap_qty, item_kind) 
				SELECT 
					stre_cd, mac_no, chkr_no, cshr_no, sale_date, sale_date, SUM(data2), SUM(data3), SUM(data1), 3
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND kind_cd = 'mode'
					AND sub = 6000
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;

				-- producer data
				INSERT INTO reg_dly_deal 
					(stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mscrap_cnt, mscrap_amt, mscrap_qty, item_kind) 
				SELECT 
					stre_cd, mac_no, chkr_no, cshr_no, sale_date, sale_date, SUM(data2), SUM(data3), SUM(data1), 4
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND kind_cd = 'mode'
					AND sub = 7000
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;

				-- receipt data
				INSERT INTO reg_dly_deal 
					(stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mscrap_cnt, mscrap_amt, mscrap_qty, item_kind
					, receipt_gp1_qty, receipt_gp2_qty, receipt_gp3_qty, receipt_gp4_qty, receipt_gp5_qty, receipt_gp6_qty 
					, receipt_gp1_amt, receipt_gp2_amt, receipt_gp3_amt, receipt_gp4_amt, receipt_gp5_amt, receipt_gp6_amt 
					) 
				SELECT 
					stre_cd, mac_no, chkr_no, cshr_no, sale_date, sale_date, SUM(CASE WHEN kind_cd='receipt' AND sub=0 THEN data1 ELSE 0 END), 0, 0, 6
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=1 THEN data1 ELSE 0 END)       --receipt_gp1_qty
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=2 THEN data1 ELSE 0 END)       --receipt_gp2_qty
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=3 THEN data1 ELSE 0 END)       --receipt_gp3_qty
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=4 THEN data1 ELSE 0 END)       --receipt_gp4_qty
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=5 THEN data1 ELSE 0 END)       --receipt_gp5_qty
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=6 THEN data1 ELSE 0 END)       --receipt_gp6_qty
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=1 THEN data2 ELSE 0 END)       --receipt_gp1_amt
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=2 THEN data2 ELSE 0 END)       --receipt_gp2_amt
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=3 THEN data2 ELSE 0 END)       --receipt_gp3_amt
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=4 THEN data2 ELSE 0 END)       --receipt_gp4_amt
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=5 THEN data2 ELSE 0 END)       --receipt_gp5_amt
					,SUM(CASE WHEN kind_cd='receipt_stamp' AND sub=6 THEN data2 ELSE 0 END)       --receipt_gp6_amt
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;


				-- reprint data
				INSERT INTO reg_dly_deal 
					(stre_cd, mac_no, chkr_no, cshr_no, sale_date, date_hour, mscrap_cnt, mscrap_amt, mscrap_qty, item_kind
					, receipt_gp1_qty, receipt_gp2_qty, receipt_gp3_qty, receipt_gp4_qty, receipt_gp5_qty, receipt_gp6_qty 
					, receipt_gp1_amt, receipt_gp2_amt, receipt_gp3_amt, receipt_gp4_amt, receipt_gp5_amt, receipt_gp6_amt 
					) 
				SELECT 
					stre_cd, mac_no, chkr_no, cshr_no, sale_date, sale_date, SUM(CASE WHEN kind_cd='rpr' AND sub=0 THEN data1 ELSE 0 END), 0, 0, 7
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=1 THEN data1 ELSE 0 END)       --receipt_gp1_qty
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=2 THEN data1 ELSE 0 END)       --receipt_gp2_qty
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=3 THEN data1 ELSE 0 END)       --receipt_gp3_qty
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=4 THEN data1 ELSE 0 END)       --receipt_gp4_qty
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=5 THEN data1 ELSE 0 END)       --receipt_gp5_qty
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=6 THEN data1 ELSE 0 END)       --receipt_gp6_qty
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=1 THEN data2 ELSE 0 END)       --receipt_gp1_amt
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=2 THEN data2 ELSE 0 END)       --receipt_gp2_amt
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=3 THEN data2 ELSE 0 END)       --receipt_gp3_amt
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=4 THEN data2 ELSE 0 END)       --receipt_gp4_amt
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=5 THEN data2 ELSE 0 END)       --receipt_gp5_amt
					,SUM(CASE WHEN kind_cd='rpr_stamp' AND sub=6 THEN data2 ELSE 0 END)       --receipt_gp6_amt
				FROM
					rdly_deal
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date ;
			END IF;

		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_deal_hour' THEN

			_ret_name := _tbl_name;

			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_deal_hour;
			ELSE

				CREATE TEMP TABLE reg_dly_deal_hour (
					 stre_cd NUMERIC(9)
					,mac_no NUMERIC(9)
					,chkr_no NUMERIC(10)
					,cshr_no NUMERIC(10)
					,sale_date timestamp
					,date_hour timestamp
					,sale_amt NUMERIC(12) default '0'
					,grssl_amt NUMERIC(12) default '0'
					,netsl_amt NUMERIC(12) default '0'
					,cust NUMERIC(12) default '0'
					,mbr_cust NUMERIC(12) default '0'
					,people_cnt NUMERIC(12) default '0'
					,qty NUMERIC(12) default '0'
					,wgt NUMERIC(15,3) default '0'
					,prf_amt NUMERIC(14,2) default '0'
					,nontaxbl_qty NUMERIC(12) default '0'
					,nontaxbl NUMERIC(12) default '0'
					,ex_taxbl_qty NUMERIC(12) default '0'
					,ex_taxbl NUMERIC(12) default '0'
					,in_taxbl_qty NUMERIC(12) default '0'
					,in_taxbl NUMERIC(12) default '0'
					,ex_ttax NUMERIC(12) default '0'
					,ex_itax NUMERIC(12) default '0'
					,in_ttax NUMERIC(12) default '0'
					,in_itax NUMERIC(12) default '0'
					,ref_qty NUMERIC(12) default '0'
					,ref_amt NUMERIC(12) default '0'
					,corr_qty NUMERIC(12) default '0'
					,corr_amt NUMERIC(12) default '0'
					,void_qty NUMERIC(12) default '0'
					,void_amt NUMERIC(12) default '0'
					,scrvoid_qty NUMERIC(12) default '0'
					,scrvoid_amt NUMERIC(12) default '0'
					,btl_ret_qty NUMERIC(12) default '0'
					,btl_ret_amt NUMERIC(12) default '0'
					,btl_ret1_qty NUMERIC(12) default '0'
					,btl_ret1_amt NUMERIC(12) default '0'
					,btl_ret1_tax_amt NUMERIC(12) default '0'
					,out_mdlcls_qty NUMERIC(12) default '0'
					,out_mdlcls_amt NUMERIC(12) default '0'
					,man_cnt NUMERIC(12) default '0'
					,cancel_cnt NUMERIC(12) default '0'
					,cancel_amt NUMERIC(12) default '0'
					,mvoid_cnt NUMERIC(12) default '0'
					,mvoid_amt NUMERIC(12) default '0'
					,mvoid_crdt_cnt NUMERIC(12) default '0'
					,mvoid_crdt_amt NUMERIC(12) default '0'
					,mvoid_debit_cnt NUMERIC(12) default '0'
					,mvoid_debit_amt NUMERIC(12) default '0'
					,mscrap_cnt NUMERIC(12) default '0'
					,mscrap_amt NUMERIC(12) default '0'
					,mtrining_cnt NUMERIC(12) default '0'
					,mtrining_amt NUMERIC(12) default '0'
					,mtrining_crdt_cnt NUMERIC(12) default '0'
					,mtrining_crdt_amt NUMERIC(12) default '0'
					,mtrining_debit_cnt NUMERIC(12) default '0'
					,mtrining_debit_amt NUMERIC(12) default '0'
					,exchg_cnt NUMERIC(12) default '0'
					,work_time NUMERIC(12) default '0'
					,scan_time NUMERIC(12) default '0'
					,kyin_time NUMERIC(12) default '0'
					,chkout_time NUMERIC(12) default '0'
					,ly_cust1 NUMERIC(12) default '0'
					,ly_sale_amt1 NUMERIC(12) default '0'
					,ly_cust2 NUMERIC(12) default '0'
					,ly_sale_amt2 NUMERIC(12) default '0'
					,ly_cust3 NUMERIC(12) default '0'
					,ly_sale_amt3 NUMERIC(12) default '0'
					,ly_cust4 NUMERIC(12) default '0'
					,ly_sale_amt4 NUMERIC(12) default '0'
					,ly_cust5 NUMERIC(12) default '0'
					,ly_sale_amt5 NUMERIC(12) default '0'
					,ly_cust6 NUMERIC(12) default '0'
					,ly_sale_amt6 NUMERIC(12) default '0'
					,ly_cust7 NUMERIC(12) default '0'
					,ly_sale_amt7 NUMERIC(12) default '0'
					,ly_cust8 NUMERIC(12) default '0'
					,ly_sale_amt8 NUMERIC(12) default '0'
					,ly_cust9 NUMERIC(12) default '0'
					,ly_sale_amt9 NUMERIC(12) default '0'
					,ly_cust10 NUMERIC(12) default '0'
					,ly_sale_amt10 NUMERIC(12) default '0'
					,dsc_qty1 NUMERIC(12) default '0'
					,dsc_amt1 NUMERIC(12) default '0'
					,dsc_qty2 NUMERIC(12) default '0'
					,dsc_amt2 NUMERIC(12) default '0'
					,dsc_qty3 NUMERIC(12) default '0'
					,dsc_amt3 NUMERIC(12) default '0'
					,dsc_qty4 NUMERIC(12) default '0'
					,dsc_amt4 NUMERIC(12) default '0'
					,dsc_qty5 NUMERIC(12) default '0'
					,dsc_amt5 NUMERIC(12) default '0'
					,pdsc_qty1 NUMERIC(12) default '0'
					,pdsc_amt1 NUMERIC(12) default '0'
					,pdsc_qty2 NUMERIC(12) default '0'
					,pdsc_amt2 NUMERIC(12) default '0'
					,pdsc_qty3 NUMERIC(12) default '0'
					,pdsc_amt3 NUMERIC(12) default '0'
					,pdsc_qty4 NUMERIC(12) default '0'
					,pdsc_amt4 NUMERIC(12) default '0'
					,pdsc_qty5 NUMERIC(12) default '0'
					,pdsc_amt5 NUMERIC(12) default '0'
					,prc_chg_qty NUMERIC(12) default '0'
					,prc_chg_amt NUMERIC(12) default '0'
					,stldsc_cnt1 NUMERIC(12) default '0'
					,stldsc_amt1 NUMERIC(12) default '0'
					,stldsc_cnt2 NUMERIC(12) default '0'
					,stldsc_amt2 NUMERIC(12) default '0'
					,stldsc_cnt3 NUMERIC(12) default '0'
					,stldsc_amt3 NUMERIC(12) default '0'
					,stldsc_cnt4 NUMERIC(12) default '0'
					,stldsc_amt4 NUMERIC(12) default '0'
					,stldsc_cnt5 NUMERIC(12) default '0'
					,stldsc_amt5 NUMERIC(12) default '0'
					,stlpdsc_cnt1 NUMERIC(12) default '0'
					,stlpdsc_amt1 NUMERIC(12) default '0'
					,stlpdsc_cnt2 NUMERIC(12) default '0'
					,stlpdsc_amt2 NUMERIC(12) default '0'
					,stlpdsc_cnt3 NUMERIC(12) default '0'
					,stlpdsc_amt3 NUMERIC(12) default '0'
					,stlpdsc_cnt4 NUMERIC(12) default '0'
					,stlpdsc_amt4 NUMERIC(12) default '0'
					,stlpdsc_cnt5 NUMERIC(12) default '0'
					,stlpdsc_amt5 NUMERIC(12) default '0'
					,bdl_dsc_amt NUMERIC(12) default '0'
					,stm_dsc_amt NUMERIC(12) default '0'
					,cls_dsc_amt NUMERIC(12) default '0'
					,cls_pdsc_amt NUMERIC(12) default '0'
					,cls_samedsc_amt NUMERIC(12) default '0'
					,cat_dsc_amt NUMERIC(12) default '0'
					,cat_pdsc_amt NUMERIC(12) default '0'
					,cat_samedsc_amt NUMERIC(12) default '0'
					,brgncust_qty NUMERIC(12) default '0'
					,brgn_dsc_amt NUMERIC(12) default '0'
					,mbrgncust_qty NUMERIC(12) default '0'
					,mbrgn_dsc_amt NUMERIC(12) default '0'
					,mpricust_qty NUMERIC(12) default '0'
					,mpri_dsc_amt NUMERIC(12) default '0'
					,mbr_stlpdsc_cnt NUMERIC(12) default '0'
					,mbr_stlpdsc_amt NUMERIC(12) default '0'
					,dqty_fsppdsc NUMERIC(12) default '0'
					,dpur_fsppdsc NUMERIC(12) default '0'
					,ddsq_mulcls NUMERIC(12) default '0'
					,ddsa_mulcls NUMERIC(12) default '0'
					,dpdq_mulcls NUMERIC(12) default '0'
					,dpda_mulcls NUMERIC(12) default '0'
					,dsdq_mulcls NUMERIC(12) default '0'
					,dsda_mulcls NUMERIC(12) default '0'
					,dspq_mulcls NUMERIC(12) default '0'
					,sku_dsc_amt NUMERIC(12) default '0'
					,sku_pdsc_amt NUMERIC(12) default '0'
					,sku_samedsc_amt NUMERIC(12) default '0'
					,sptend_cnt NUMERIC(12) default '0'
					,dcau_mspur NUMERIC(14) default '0'
					,dpnt_ttlsrv NUMERIC(12) default '0'
					,dupp_cust NUMERIC(12) default '0'
					,dupp_ttlrv NUMERIC(12) default '0'
					,dupt_ttlrv NUMERIC(12) default '0'
					,dmq1_ttlsrv NUMERIC(12) default '0'
					,dmp1_ttlsrv NUMERIC(12) default '0'
					,daq1_ttlsrv NUMERIC(12) default '0'
					,dap1_ttlsrv NUMERIC(12) default '0'
					,dmq2_ttlsrv NUMERIC(12) default '0'
					,dmp2_ttlsrv NUMERIC(12) default '0'
					,daq2_ttlsrv NUMERIC(12) default '0'
					,dap2_ttlsrv NUMERIC(12) default '0'
					,dtiq_cust NUMERIC(12) default '0'
					,dtiq_ttlsrv NUMERIC(12) default '0'
					,dtip_ttlsrv NUMERIC(12) default '0'
					,dtuq_cust NUMERIC(12) default '0'
					,dtuq_ttlsrv NUMERIC(12) default '0'
					,dtup_ttlsrv NUMERIC(12) default '0'
					,dcau_fsppur NUMERIC(14) default '0'
					,dptq_addpnt NUMERIC(12) default '0'
					,dspt_addpnt NUMERIC(12) default '0'
					,dpur_addmul NUMERIC(14) default '0'
					,dpnt_cust NUMERIC(12) default '0'
					,warranty_cnt NUMERIC(12) default '0'
					,prom_ticket_qty NUMERIC(12) default '0'
					,receipt_gp1_qty NUMERIC(12) default '0'
					,receipt_gp2_qty NUMERIC(12) default '0'
					,receipt_gp3_qty NUMERIC(12) default '0'
					,receipt_gp4_qty NUMERIC(12) default '0'
					,receipt_gp5_qty NUMERIC(12) default '0'
					,receipt_gp6_qty NUMERIC(12) default '0'
					,plu_point_ttl NUMERIC(12) default '0'
					,selfgate_amt NUMERIC(12) default '0'
					,selfgate_cust NUMERIC(12) default '0'
					,selfgate_qty NUMERIC(12) default '0'
					,stamp_cust1 NUMERIC(12) default '0'
					,stamp_point1 NUMERIC(12) default '0'
					,stamp_cust2 NUMERIC(12) default '0'
					,stamp_point2 NUMERIC(12) default '0'
					,stamp_cust3 NUMERIC(12) default '0'
					,stamp_point3 NUMERIC(12) default '0'
					,stamp_cust4 NUMERIC(12) default '0'
					,stamp_point4 NUMERIC(12) default '0'
					,stamp_cust5 NUMERIC(12) default '0'
					,stamp_point5 NUMERIC(12) default '0'
					,vmc_chgtckt_cnt NUMERIC(12) default '0'
					,vmc_chg_amt NUMERIC(12) default '0'
					,total_chgamt NUMERIC(12) default '0'
					,vmc_chg_cnt NUMERIC(12) default '0'
					,vmc_hesotckt_cnt NUMERIC(12) default '0'
					,vmc_heso_amt NUMERIC(12) default '0'
					,total_hesoamt NUMERIC(12) default '0'
					,vmc_heso_cnt NUMERIC(12) default '0'
					,receipt_gp1_amt NUMERIC(12) default '0'
					,receipt_gp2_amt NUMERIC(12) default '0'
					,receipt_gp3_amt NUMERIC(12) default '0'
					,receipt_gp4_amt NUMERIC(12) default '0'
					,receipt_gp5_amt NUMERIC(12) default '0'
					,receipt_gp6_amt NUMERIC(12) default '0'
					,c_mdsc_amt NUMERIC(12) default '0'
					,c_mpdsc_amt NUMERIC(12) default '0'
					,c_msdsc_amt NUMERIC(12) default '0'
					,i_mdsc_amt NUMERIC(12) default '0'
					,i_mpdsc_amt NUMERIC(12) default '0'
					,mstm_dsc_amt NUMERIC(12) default '0'
					,mbdl_dsc_amt NUMERIC(12) default '0'
					,mny_ttl NUMERIC(14) default '0'
					,mny_today_cust NUMERIC(12) default '0'
					,mny_today_amt NUMERIC(12) default '0'
					,mny_tckt_cnt1 NUMERIC(12) default '0'
					,mny_tckt_amt1 NUMERIC(12) default '0'
					,mny_tckt_cnt2 NUMERIC(12) default '0'
					,mny_tckt_amt2 NUMERIC(12) default '0'
					,mny_tckt_cnt3 NUMERIC(12) default '0'
					,mny_tckt_amt3 NUMERIC(12) default '0'
					,mny_next_amt NUMERIC(12) default '0'
					,mny_re_cnt NUMERIC(12) default '0'
					,mny_re_amt NUMERIC(12) default '0'
					,prom_stldsc_cnt NUMERIC(12) default '0'
					,prom_stldsc_amt NUMERIC(12) default '0'
					,prom_stlpdsc_cnt NUMERIC(12) default '0'
					,prom_stlpdsc_amt NUMERIC(12) default '0'
					,plu_point_qty NUMERIC(12) default '0'
					,plu_point_amt NUMERIC(12) default '0'
					,plu_point_cust NUMERIC(12) default '0'
					,rct_rpr_qty NUMERIC(12) default '0'
					,stlplus_cnt1 NUMERIC(12) default '0'
					,stlplus_amt1 NUMERIC(12) default '0'
					,stlplus_cnt2 NUMERIC(12) default '0'
					,stlplus_amt2 NUMERIC(12) default '0'
					,stlplus_cnt3 NUMERIC(12) default '0'
					,stlplus_amt3 NUMERIC(12) default '0'
					,stlplus_cnt4 NUMERIC(12) default '0'
					,stlplus_amt4 NUMERIC(12) default '0'
					,stlplus_cnt5 NUMERIC(12) default '0'
					,stlplus_amt5 NUMERIC(12) default '0'
					,extra_cnt NUMERIC(12) default '0'
					,extra_amt NUMERIC(12) default '0'
					,join_fee_cust NUMERIC(12) default '0'
					,join_fee_amt NUMERIC(12) default '0'
					,nocard_cash_cnt NUMERIC(12) default '0'
					,nocard_cash_amt NUMERIC(12) default '0'
					,nocard_ret_cash_cnt NUMERIC(12) default '0'
					,nocard_ret_cash_amt NUMERIC(12) default '0'
					,card_cash_cnt NUMERIC(12) default '0'
					,card_cash_amt NUMERIC(12) default '0'
					,card_ret_cash_cnt NUMERIC(12) default '0'
					,card_ret_cash_amt NUMERIC(12) default '0'
					,card_deposit_cnt NUMERIC(12) default '0'
					,card_deposit_amt NUMERIC(12) default '0'
					,card_1time_cnt NUMERIC(12) default '0'
					,card_1time_amt NUMERIC(12) default '0'
					,item_kind SMALLINT default '0'
					,bonus_point NUMERIC(12) default '0'
					,nm_stlpdsc_cnt NUMERIC(12) default '0'
					,nm_stlpdsc_amt NUMERIC(12) default '0'
					,daiq_sht NUMERIC(12) default '0'
					,ssps_i_amt NUMERIC(12) default '0'
					,ssps_i_qty NUMERIC(12) default '0'
					,ssps_i_cust NUMERIC(12) default '0'
					,ssps_u_amt NUMERIC(12) default '0'
					,ssps_u_qty NUMERIC(12) default '0'
					,ssps_u_cust NUMERIC(12) default '0'
					,cpn_qty NUMERIC(12) default '0'
					,cpn_amt NUMERIC(12) default '0'
					,cpn_qty2 NUMERIC(12) default '0'
					,cpn_amt2 NUMERIC(12) default '0'
					,t_netsl_amt NUMERIC(12) default '0'
					,t_intax_item_amt NUMERIC(12) default '0'
					,d_intax_amt NUMERIC(12) default '0'
					,other_st_cust NUMERIC(12) default '0'
					,other_st_amt NUMERIC(12) default '0'
					,other_st_qty NUMERIC(12) default '0'
					,edy_alarm_cnt NUMERIC(12) default '0'
					,edy_alarm_amt NUMERIC(12) default '0'
					,mscrap_qty NUMERIC(12) default '0'
					,bg_pchg_amt NUMERIC(12) default '0'
					,bg_pchg_qty NUMERIC(12) default '0'
					,mbg_pchg_amt NUMERIC(12) default '0'
					,mbg_pchg_qty NUMERIC(12) default '0'
					,tckt_iss_amt NUMERIC(12) default '0'
					,stl_waridsc_cnt NUMERIC(12) default '0'
					,stl_waridsc_amt NUMERIC(12) default '0'
					,prfree_qty NUMERIC(12) default '0'
					,stlcrdtdsc_cnt NUMERIC(12) default '0'
					,stlcrdtdsc_amt NUMERIC(12) default '0'
					,chkr_work_time NUMERIC(12) default '0'
					,chkr_scan_time NUMERIC(12) default '0'
					,chkr_kyin_time NUMERIC(12) default '0'
					,chkr_chkout_time NUMERIC(12) default '0'
					,refund_cnt NUMERIC(12) default '0'
					,taxbl_amt1 NUMERIC(12) default '0'
					,tax_amt1 NUMERIC(12) default '0'
					,taxbl_amt2 NUMERIC(12) default '0'
					,tax_amt2 NUMERIC(12) default '0'
					,taxbl_amt3 NUMERIC(12) default '0'
					,tax_amt3 NUMERIC(12) default '0'
					,taxbl_amt4 NUMERIC(12) default '0'
					,tax_amt4 NUMERIC(12) default '0'
					,taxbl_amt5 NUMERIC(12) default '0'
					,tax_amt5 NUMERIC(12) default '0'
					,taxbl_amt6 NUMERIC(12) default '0'
					,tax_amt6 NUMERIC(12) default '0'
					,taxbl_amt7 NUMERIC(12) default '0'
					,tax_amt7 NUMERIC(12) default '0'
					,taxbl_amt8 NUMERIC(12) default '0'
					,tax_amt8 NUMERIC(12) default '0'
					,PRIMARY KEY (stre_cd,mac_no,chkr_no,cshr_no,sale_date,date_hour,item_kind)
				);


				INSERT INTO reg_dly_deal_hour 
					(stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,sale_amt
					,grssl_amt
					,netsl_amt
					,cust
					,people_cnt
					,qty
					)
				SELECT
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END)                --sale_amt
					,SUM(CASE WHEN sub=0 THEN data2 ELSE 0 END)                --grssl_amt
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END)                --netsl_amt
					,SUM(CASE WHEN sub=0 THEN data4 ELSE 0 END)                --cust
					,SUM(CASE WHEN sub=0 THEN data6 ELSE 0 END)                --people_cnt
					,SUM(CASE WHEN sub=0 THEN data5 ELSE 0 END)                --qty
				FROM
					rdly_deal_hour
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
				ORDER BY
					 mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour ;

			END IF;

		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_acr' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_acr;
			ELSE
				CREATE TEMP TABLE 
					reg_dly_acr 
				AS SELECT
					 stre_cd
					,mac_no
					,sale_date
					,SUM(acr_1_sht) AS acr_1_sht
					,SUM(acr_5_sht) AS acr_5_sht
					,SUM(acr_10_sht) AS acr_10_sht
					,SUM(acr_50_sht) AS acr_50_sht
					,SUM(acr_100_sht) AS acr_100_sht
					,SUM(acr_500_sht) AS acr_500_sht
					,SUM(acb_1000_sht) AS acb_1000_sht
					,SUM(acb_2000_sht) AS acb_2000_sht
					,SUM(acb_5000_sht) AS acb_5000_sht
					,SUM(acb_10000_sht) AS acb_10000_sht
					,SUM(acr_1_pol_sht) AS acr_1_pol_sht
					,SUM(acr_5_pol_sht) AS acr_5_pol_sht
					,SUM(acr_10_pol_sht) AS acr_10_pol_sht
					,SUM(acr_50_pol_sht) AS acr_50_pol_sht
					,SUM(acr_100_pol_sht) AS acr_100_pol_sht
					,SUM(acr_500_pol_sht) AS acr_500_pol_sht
					,SUM(acr_oth_pol_sht) AS acr_oth_pol_sht
					,SUM(acb_1000_pol_sht) AS acb_1000_pol_sht
					,SUM(acb_2000_pol_sht) AS acb_2000_pol_sht
					,SUM(acb_5000_pol_sht) AS acb_5000_pol_sht
					,SUM(acb_10000_pol_sht) AS acb_10000_pol_sht
					,SUM(acb_fill_pol_sht) AS acb_fill_pol_sht
					,SUM(acb_reject_cnt) AS acb_reject_cnt
				FROM
					rdly_acr
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
				GROUP BY
					 stre_cd
					,mac_no
					,sale_date
				ORDER BY
					 mac_no
					,sale_date ;
			END IF;

		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_plu' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_plu;
			ELSE
				CREATE TEMP TABLE reg_dly_plu (
					  stre_cd numeric(9)
					 ,plu_cd VARCHAR(20)
					 ,sale_date timestamp
					 ,date_hour timestamp
					 ,amt NUMERIC(12) default '0'
					 ,qty NUMERIC(12) default '0'
					 ,cust NUMERIC(12) default '0'
					 ,prft NUMERIC(14,2) default '0'
					 ,wgt NUMERIC(15,3) default '0'
					 ,pos_prc NUMERIC(12) default '0'
					 ,dsc_amt NUMERIC(12) default '0'
					 ,dsc_qty NUMERIC(12) default '0'
					 ,ex_itax NUMERIC(12) default '0'
					 ,in_itax NUMERIC(12) default '0'
					 ,ex_taxbl NUMERIC(12) default '0'
					 ,in_taxbl NUMERIC(12) default '0'
					 ,no_taxbl NUMERIC(12) default '0'
					 ,refund_qty NUMERIC(12) default '0'
					 ,refund_amt NUMERIC(12) default '0'
					 ,item_scan_qty NUMERIC(12) default '0'
					 ,item_preset_qty NUMERIC(12) default '0'
					 ,item_manual_qty NUMERIC(12) default '0'
					 ,dsc_qty1 NUMERIC(12) default '0'
					 ,dsc_amt1 NUMERIC(12) default '0'
					 ,dsc_qty2 NUMERIC(12) default '0'
					 ,dsc_amt2 NUMERIC(12) default '0'
					 ,dsc_qty3 NUMERIC(12) default '0'
					 ,dsc_amt3 NUMERIC(12) default '0'
					 ,dsc_qty4 NUMERIC(12) default '0'
					 ,dsc_amt4 NUMERIC(12) default '0'
					 ,dsc_qty5 NUMERIC(12) default '0'
					 ,dsc_amt5 NUMERIC(12) default '0'
					 ,pdsc_qty1 NUMERIC(12) default '0'
					 ,pdsc_amt1 NUMERIC(12) default '0'
					 ,pdsc_qty2 NUMERIC(12) default '0'
					 ,pdsc_amt2 NUMERIC(12) default '0'
					 ,pdsc_qty3 NUMERIC(12) default '0'
					 ,pdsc_amt3 NUMERIC(12) default '0'
					 ,pdsc_qty4 NUMERIC(12) default '0'
					 ,pdsc_amt4 NUMERIC(12) default '0'
					 ,pdsc_qty5 NUMERIC(12) default '0'
					 ,pdsc_amt5 NUMERIC(12) default '0'
					 ,prc_chg_qty NUMERIC(12) default '0'
					 ,prc_chg_amt NUMERIC(12) default '0'
					 ,stldsc_amt NUMERIC(12) default '0'
					 ,bdl_dsc_amt NUMERIC(12) default '0'
					 ,stm_dsc_amt NUMERIC(12) default '0'
					 ,cls_dsc_qty NUMERIC(12) default '0'
					 ,cls_dsc_amt NUMERIC(12) default '0'
					 ,cls_pdsc_qty NUMERIC(12) default '0'
					 ,cls_pdsc_amt NUMERIC(12) default '0'
					 ,cls_samedsc_qty NUMERIC(12) default '0'
					 ,cls_samedsc_amt NUMERIC(12) default '0'
					 ,cls_same_qty NUMERIC(12) default '0'
					 ,cat_dsc_qty NUMERIC(12) default '0'
					 ,cat_dsc_amt NUMERIC(12) default '0'
					 ,cat_pdsc_qty NUMERIC(12) default '0'
					 ,cat_pdsc_amt NUMERIC(12) default '0'
					 ,cat_samedsc_qty NUMERIC(12) default '0'
					 ,cat_samedsc_amt NUMERIC(12) default '0'
					 ,cat_same_qty NUMERIC(12) default '0'
					 ,brgn_sale NUMERIC(12) default '0'
					 ,brgncust_qty NUMERIC(12) default '0'
					 ,brgn_dsc_amt NUMERIC(12) default '0'
					 ,brgn_prft NUMERIC(14,2) default '0'
					 ,mbrgn_sale NUMERIC(12) default '0'
					 ,mbrgncust_qty NUMERIC(12) default '0'
					 ,mbrgn_dsc_amt NUMERIC(12) default '0'
					 ,mbrgn_prft NUMERIC(14,2) default '0'
					 ,mpricust_qty NUMERIC(12) default '0'
					 ,mpri_dsc_amt NUMERIC(12) default '0'
					 ,cls_muldsc_qty NUMERIC(12) default '0'
					 ,cls_muldsc_amt NUMERIC(12) default '0'
					 ,cls_mulpdsc_qty NUMERIC(12) default '0'
					 ,cls_mulpdsc_amt NUMERIC(12) default '0'
					 ,cls_mulsamedsc_qty NUMERIC(12) default '0'
					 ,cls_mulsamedsc_amt NUMERIC(12) default '0'
					 ,cls_mulsame_qty NUMERIC(12) default '0'
					 ,sku_dsc_qty NUMERIC(12) default '0'
					 ,sku_dsc_amt NUMERIC(12) default '0'
					 ,sku_pdsc_qty NUMERIC(12) default '0'
					 ,sku_pdsc_amt NUMERIC(12) default '0'
					 ,sku_samedsc_qty NUMERIC(12) default '0'
					 ,sku_samedsc_amt NUMERIC(12) default '0'
					 ,sku_same_qty NUMERIC(12) default '0'
					 ,rbt_amt NUMERIC(12) default '0'
					 ,case_dsc_amt NUMERIC(12) default '0'
					 ,last_sale_datetime timestamp
					 ,update_flg NUMERIC(12) default '0'
					 ,smlcls_cd NUMERIC(6) default '0'
					 ,btl_ret_qty NUMERIC(12) default '0'
					 ,btl_ret_amt NUMERIC(12) default '0'
					 ,cat_dsc_cd NUMERIC(9) default '0'
					 ,c_mdsc_qty NUMERIC(12) default '0'
					 ,c_mdsc_amt NUMERIC(12) default '0'
					 ,c_mpdsc_qty NUMERIC(12) default '0'
					 ,c_mpdsc_amt NUMERIC(12) default '0'
					 ,c_msdsc_qty NUMERIC(12) default '0'
					 ,c_msdsc_amt NUMERIC(12) default '0'
					 ,mstm_dsc_amt NUMERIC(12) default '0'
					 ,mbdl_dsc_amt NUMERIC(12) default '0'
					 ,exchg_ttl_qty NUMERIC(12) default '0'
					 ,exchg_ttl_pnt NUMERIC(12) default '0'
					 ,i_mdsc_qty NUMERIC(12) default '0'
					 ,i_mdsc_amt NUMERIC(12) default '0'
					 ,i_mpdsc_qty NUMERIC(12) default '0'
					 ,i_mpdsc_amt NUMERIC(12) default '0'
					 ,plu_point_qty NUMERIC(12) default '0'
					 ,plu_point_amt NUMERIC(12) default '0'
					 ,plu_point_ttl NUMERIC(12) default '0'
					 ,plus_amt NUMERIC(12) default '0'
					 ,plus_qty NUMERIC(12) default '0'
					 ,scrap_qty NUMERIC(12) default '0'
					 ,scrap_amt NUMERIC(12) default '0'
					 ,item_kind smallint default '0'
					 ,cost NUMERIC(9,2) default '0'
					 ,cpn_qty NUMERIC(12) default '0'
					 ,cpn_amt NUMERIC(12) default '0'
					 ,cpn_qty2 NUMERIC(12) default '0'
					 ,cpn_amt2 NUMERIC(12) default '0'
					 ,t_netsl_amt NUMERIC(12) default '0'
					 ,t_intax_item_amt NUMERIC(12) default '0'
					 ,d_intax_amt NUMERIC(12) default '0'
					 ,div_ppoint NUMERIC(12) default '0'
					 ,div_mpoint NUMERIC(12) default '0'
					 ,bg_pchg_amt NUMERIC(12) default '0'
					 ,bg_pchg_qty NUMERIC(12) default '0'
					 ,mbg_pchg_amt NUMERIC(12) default '0'
					 ,mbg_pchg_qty NUMERIC(12) default '0'
					 ,prfree_qty NUMERIC(12) default '0'
					 ,ex_in_tabl NUMERIC(12) default '0'
					 ,stlcrdtdsc_amt NUMERIC(12) default '0'
					,tax_typ1 smallint default '0'
					,tax_per1 NUMERIC(5,2) default '0'
					,taxbl_amt1 NUMERIC(12) default '0'
					,tax_amt1 NUMERIC(12) default '0'
					,tax_qty1 NUMERIC(12) default '0'
					,saleamt1 NUMERIC(12) default '0'
					,tax_typ2 smallint default '0'
					,tax_per2 NUMERIC(5,2) default '0'
					,taxbl_amt2 NUMERIC(12) default '0'
					,tax_amt2 NUMERIC(12) default '0'
					,tax_qty2 NUMERIC(12) default '0'
					,saleamt2 NUMERIC(12) default '0'
					,tax_typ3 smallint default '0'
					,tax_per3 NUMERIC(5,2) default '0'
					,taxbl_amt3 NUMERIC(12) default '0'
					,tax_amt3 NUMERIC(12) default '0'
					,tax_qty3 NUMERIC(12) default '0'
					,saleamt3 NUMERIC(12) default '0'
					,tax_typ4 smallint default '0'
					,tax_per4 NUMERIC(5,2) default '0'
					,taxbl_amt4 NUMERIC(12) default '0'
					,tax_amt4 NUMERIC(12) default '0'
					,tax_qty4 NUMERIC(12) default '0'
					,saleamt4 NUMERIC(12) default '0'
					,tax_typ5 smallint default '0'
					,tax_per5 NUMERIC(5,2) default '0'
					,taxbl_amt5 NUMERIC(12) default '0'
					,tax_amt5 NUMERIC(12) default '0'
					,tax_qty5 NUMERIC(12) default '0'
					,saleamt5 NUMERIC(12) default '0'
					,tax_typ6 smallint default '0'
					,tax_per6 NUMERIC(5,2) default '0'
					,taxbl_amt6 NUMERIC(12) default '0'
					,tax_amt6 NUMERIC(12) default '0'
					,tax_qty6 NUMERIC(12) default '0'
					,saleamt6 NUMERIC(12) default '0'
					,tax_typ7 smallint default '0'
					,tax_per7 NUMERIC(5,2) default '0'
					,taxbl_amt7 NUMERIC(12) default '0'
					,tax_amt7 NUMERIC(12) default '0'
					,tax_qty7 NUMERIC(12) default '0'
					,saleamt7 NUMERIC(12) default '0'
					,tax_typ8 smallint default '0'
					,tax_per8 NUMERIC(5,2) default '0'
					,taxbl_amt8 NUMERIC(12) default '0'
					,tax_amt8 NUMERIC(12) default '0'
					,tax_qty8 NUMERIC(12) default '0'
					,saleamt8 NUMERIC(12) default '0'
					,tax_typ10 smallint default '0'
					,tax_per10 NUMERIC(5,2) default '0'
					,taxbl_amt10 NUMERIC(12) default '0'
					,tax_amt10 NUMERIC(12) default '0'
					,tax_qty10 NUMERIC(12) default '0'
					,saleamt10 NUMERIC(12) default '0'
					,vol NUMERIC(15,3) default '0'	-- 体積(1Verで追加)
					 ,PRIMARY KEY (stre_cd,plu_cd,sale_date,date_hour,item_kind)
				);
				INSERT INTO reg_dly_plu (
					 stre_cd
					,plu_cd
					,sale_date
					,date_hour
					,amt
					,qty
					,cust
					,prft
					,wgt
					,pos_prc
					,dsc_amt
					,ex_itax
					,in_itax
					,ex_taxbl
					,in_taxbl
					,no_taxbl
					,refund_qty
					,refund_amt
					,bdl_dsc_amt
					,stm_dsc_amt
					,brgn_sale
					,brgncust_qty
					,brgn_dsc_amt
					,brgn_prft
					,mbrgn_sale
					,mbrgncust_qty
					,mbrgn_dsc_amt
					,mbrgn_prft
					,last_sale_datetime
					,smlcls_cd
					,cat_dsc_cd -- producer_cd
					,mstm_dsc_amt
					,mbdl_dsc_amt
					,plu_point_ttl
					,item_kind 
					,cost -- cost_prc
					,ex_in_tabl
					,tax_typ1
					,tax_per1
					,taxbl_amt1
					,tax_amt1
					,tax_qty1
					,saleamt1
					,tax_typ2
					,tax_per2
					,taxbl_amt2
					,tax_amt2
					,tax_qty2
					,saleamt2
					,tax_typ3
					,tax_per3
					,taxbl_amt3
					,tax_amt3
					,tax_qty3
					,saleamt3
					,tax_typ4
					,tax_per4
					,taxbl_amt4
					,tax_amt4
					,tax_qty4
					,saleamt4
					,tax_typ5
					,tax_per5
					,taxbl_amt5
					,tax_amt5
					,tax_qty5
					,saleamt5
					,tax_typ6
					,tax_per6
					,taxbl_amt6
					,tax_amt6
					,tax_qty6
					,saleamt6
					,tax_typ7
					,tax_per7
					,taxbl_amt7
					,tax_amt7
					,tax_qty7
					,saleamt7
					,tax_typ8
					,tax_per8
					,taxbl_amt8
					,tax_amt8
					,tax_qty8
					,saleamt8
					,tax_typ10
					,tax_per10
					,taxbl_amt10
					,tax_amt10
					,tax_qty10
					,saleamt10
					,vol
				)
				SELECT 
					 h.stre_cd
					,h.plu_cd
					,h.sale_date
					,h.date_hour
					,SUM(CASE WHEN h.sub=0 THEN h.data1 ELSE 0 END) -- amt
					,SUM(CASE WHEN h.sub=0 THEN h.data3 ELSE 0 END) -- qty
					,SUM(CASE WHEN h.sub=0 THEN h.data2 ELSE 0 END) -- cust
					,SUM(CASE WHEN h.sub=0 THEN h.data21 ELSE 0 END) -- prft
					,SUM(CASE WHEN h.sub=0 THEN h.data14 / 1000 ELSE 0 END) -- wgt
					,m.pos_prc
					,SUM(CASE WHEN h.sub=0 THEN h.data4 ELSE 0 END) -- dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data14 ELSE 0 END) -- ex_itax
					,SUM(CASE WHEN h.sub=1 THEN h.data15 ELSE 0 END) -- in_itax
					,SUM(CASE WHEN h.sub=1 THEN h.data11 ELSE 0 END) -- ex_taxbl
					,SUM(CASE WHEN h.sub=1 THEN h.data12 ELSE 0 END) -- in_taxbl
					,SUM(CASE WHEN h.sub=1 THEN h.data13 ELSE 0 END) -- no_taxbl
					,SUM(CASE WHEN h.sub=0 THEN h.data10 ELSE 0 END) -- refund_qty
					,SUM(CASE WHEN h.sub=0 THEN h.data11 ELSE 0 END) -- refund_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data7 ELSE 0 END) -- bdl_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data8 ELSE 0 END) -- stm_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data1 ELSE 0 END) -- brgn_sale
					,SUM(CASE WHEN h.sub=1 THEN h.data2 ELSE 0 END) -- brgncust_qty
					,SUM(CASE WHEN h.sub=1 THEN h.data3 ELSE 0 END) -- brgn_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data20 ELSE 0 END) -- brgn_prft
					,SUM(CASE WHEN h.sub=1 THEN h.data4 ELSE 0 END) -- mbrgn_sale
					,SUM(CASE WHEN h.sub=1 THEN h.data5 ELSE 0 END) -- mbrgncust_qty
					,SUM(CASE WHEN h.sub=1 THEN h.data6 ELSE 0 END) -- mbrgn_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data21 ELSE 0 END) -- mbrgn_prft
					,MAX(CASE WHEN h.sub=0 THEN h.data22 ELSE h.date_hour END) -- last_sale_datetime
					,m.smlcls_cd
					,m.producer_cd
					,SUM(CASE WHEN h.sub=1 THEN h.data10 ELSE 0 END) -- mstm_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data9 ELSE 0 END) -- mbdl_dsc_amt
					,SUM(CASE WHEN h.sub=0 THEN h.data7 ELSE 0 END) -- plu_point_ttl
					,0 -- item_kind 
					,m.cost_prc
					,SUM(CASE WHEN h.sub=0 THEN h.data12 ELSE 0 END) -- ex_in_tabl
					,MAX(CASE WHEN h.sub=2 THEN h.data1 ELSE 0 END) -- tax_typ1
					,MAX(CASE WHEN h.sub=2 THEN h.data21 ELSE 0 END) -- tax_per1
					,SUM(CASE WHEN h.sub=2 THEN h.data2 ELSE 0 END) -- taxbl_amt1
					,SUM(CASE WHEN h.sub=2 THEN h.data3 ELSE 0 END) -- tax_amt1
					,SUM(CASE WHEN h.sub=2 THEN h.data4 ELSE 0 END) -- tax_qty1
					,SUM(CASE WHEN h.sub=2 THEN h.data5 ELSE 0 END) -- saleamt1
					,MAX(CASE WHEN h.sub=3 THEN h.data1 ELSE 0 END) -- tax_typ2
					,MAX(CASE WHEN h.sub=3 THEN h.data21 ELSE 0 END) -- tax_per2
					,SUM(CASE WHEN h.sub=3 THEN h.data2 ELSE 0 END) -- taxbl_amt2
					,SUM(CASE WHEN h.sub=3 THEN h.data3 ELSE 0 END) -- tax_amt2
					,SUM(CASE WHEN h.sub=3 THEN h.data4 ELSE 0 END) -- tax_qty2
					,SUM(CASE WHEN h.sub=3 THEN h.data5 ELSE 0 END) -- saleamt2
					,MAX(CASE WHEN h.sub=4 THEN h.data1 ELSE 0 END) -- tax_typ3
					,MAX(CASE WHEN h.sub=4 THEN h.data21 ELSE 0 END) -- tax_per3
					,SUM(CASE WHEN h.sub=4 THEN h.data2 ELSE 0 END) -- taxbl_amt3
					,SUM(CASE WHEN h.sub=4 THEN h.data3 ELSE 0 END) -- tax_amt3
					,SUM(CASE WHEN h.sub=4 THEN h.data4 ELSE 0 END) -- tax_qty3
					,SUM(CASE WHEN h.sub=4 THEN h.data5 ELSE 0 END) -- saleamt3
					,MAX(CASE WHEN h.sub=5 THEN h.data1 ELSE 0 END) -- tax_typ4
					,MAX(CASE WHEN h.sub=5 THEN h.data21 ELSE 0 END) -- tax_per4
					,SUM(CASE WHEN h.sub=5 THEN h.data2 ELSE 0 END) -- taxbl_amt4
					,SUM(CASE WHEN h.sub=5 THEN h.data3 ELSE 0 END) -- tax_amt4
					,SUM(CASE WHEN h.sub=5 THEN h.data4 ELSE 0 END) -- tax_qty4
					,SUM(CASE WHEN h.sub=5 THEN h.data5 ELSE 0 END) -- saleamt4
					,MAX(CASE WHEN h.sub=6 THEN h.data1 ELSE 0 END) -- tax_typ5
					,MAX(CASE WHEN h.sub=6 THEN h.data21 ELSE 0 END) -- tax_per5
					,SUM(CASE WHEN h.sub=6 THEN h.data2 ELSE 0 END) -- taxbl_amt5
					,SUM(CASE WHEN h.sub=6 THEN h.data3 ELSE 0 END) -- tax_amt5
					,SUM(CASE WHEN h.sub=6 THEN h.data4 ELSE 0 END) -- tax_qty5
					,SUM(CASE WHEN h.sub=6 THEN h.data5 ELSE 0 END) -- saleamt5
					,MAX(CASE WHEN h.sub=7 THEN h.data1 ELSE 0 END) -- tax_typ6
					,MAX(CASE WHEN h.sub=7 THEN h.data21 ELSE 0 END) -- tax_per6
					,SUM(CASE WHEN h.sub=7 THEN h.data2 ELSE 0 END) -- taxbl_amt6
					,SUM(CASE WHEN h.sub=7 THEN h.data3 ELSE 0 END) -- tax_amt6
					,SUM(CASE WHEN h.sub=7 THEN h.data4 ELSE 0 END) -- tax_qty6
					,SUM(CASE WHEN h.sub=7 THEN h.data5 ELSE 0 END) -- saleamt6
					,MAX(CASE WHEN h.sub=8 THEN h.data1 ELSE 0 END) -- tax_typ7
					,MAX(CASE WHEN h.sub=8 THEN h.data21 ELSE 0 END) -- tax_per7
					,SUM(CASE WHEN h.sub=8 THEN h.data2 ELSE 0 END) -- taxbl_amt7
					,SUM(CASE WHEN h.sub=8 THEN h.data3 ELSE 0 END) -- tax_amt7
					,SUM(CASE WHEN h.sub=8 THEN h.data4 ELSE 0 END) -- tax_qty7
					,SUM(CASE WHEN h.sub=8 THEN h.data5 ELSE 0 END) -- saleamt7
					,MAX(CASE WHEN h.sub=9 THEN h.data1 ELSE 0 END) -- tax_typ8
					,MAX(CASE WHEN h.sub=9 THEN h.data21 ELSE 0 END) -- tax_per8
					,SUM(CASE WHEN h.sub=9 THEN h.data2 ELSE 0 END) -- taxbl_amt8
					,SUM(CASE WHEN h.sub=9 THEN h.data3 ELSE 0 END) -- tax_amt8
					,SUM(CASE WHEN h.sub=9 THEN h.data4 ELSE 0 END) -- tax_qty8
					,SUM(CASE WHEN h.sub=9 THEN h.data5 ELSE 0 END) -- saleamt8
					,MAX(CASE WHEN h.sub=10 THEN h.data1 ELSE 0 END) -- tax_typ10
					,MAX(CASE WHEN h.sub=10 THEN h.data21 ELSE 0 END) -- tax_per10
					,SUM(CASE WHEN h.sub=10 THEN h.data2 ELSE 0 END) -- taxbl_amt10
					,SUM(CASE WHEN h.sub=10 THEN h.data3 ELSE 0 END) -- tax_amt10
					,SUM(CASE WHEN h.sub=10 THEN h.data4 ELSE 0 END) -- tax_qty10
					,SUM(CASE WHEN h.sub=10 THEN h.data5 ELSE 0 END) -- saleamt10
					,SUM(CASE WHEN h.sub=0 THEN h.data18 / 1000 ELSE 0 END) -- vol 体積(1Verで追加)
				FROM
					rdly_plu_hour h
				LEFT OUTER JOIN
					c_plu_mst m
				ON
					h.comp_cd = m.comp_cd
					AND h.stre_cd = m.stre_cd
					AND h.plu_cd = m.plu_cd
				WHERE
					h.comp_cd = _comp_cd
					AND h.stre_cd = _stre_cd
					AND h.sale_date = _sale_date
					AND h.mode in (1000, 3000)
				GROUP BY
					 h.stre_cd
					,h.plu_cd
					,h.sale_date
					,h.date_hour
					,m.pos_prc
					,m.cost_prc
					,m.smlcls_cd
					,m.producer_cd
				ORDER BY
					 h.plu_cd
					,h.sale_date
					,h.date_hour;


				INSERT INTO reg_dly_plu (
					 stre_cd
					,plu_cd
					,sale_date
					,date_hour
					,amt
					,qty
					,cust
					,prft
					,wgt
					,pos_prc
					,dsc_amt
					,ex_itax
					,in_itax
					,ex_taxbl
					,in_taxbl
					,no_taxbl
					,refund_qty
					,refund_amt
					,bdl_dsc_amt
					,stm_dsc_amt
					,brgn_sale
					,brgncust_qty
					,brgn_dsc_amt
					,brgn_prft
					,mbrgn_sale
					,mbrgncust_qty
					,mbrgn_dsc_amt
					,mbrgn_prft
					,last_sale_datetime
					,smlcls_cd
					,cat_dsc_cd -- producer_cd
					,mstm_dsc_amt
					,mbdl_dsc_amt
					,plu_point_ttl
					,item_kind 
					,cost -- cost_prc
					,ex_in_tabl
					,scrap_qty
					,scrap_amt
					,vol
				)
				SELECT 
					 h.stre_cd
					,h.plu_cd
					,h.sale_date
					,h.date_hour
					,SUM(CASE WHEN h.sub=0 THEN h.data1 ELSE 0 END) -- amt
					,SUM(CASE WHEN h.sub=0 THEN h.data3 ELSE 0 END) -- qty
					,SUM(CASE WHEN h.sub=0 THEN h.data2 ELSE 0 END) -- cust
					,SUM(CASE WHEN h.sub=0 THEN h.data21 ELSE 0 END) -- prft
					,SUM(CASE WHEN h.sub=0 THEN h.data14 / 1000 ELSE 0 END) -- wgt
					,m.pos_prc
					,SUM(CASE WHEN h.sub=0 THEN h.data4 ELSE 0 END) -- dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data14 ELSE 0 END) -- ex_itax
					,SUM(CASE WHEN h.sub=1 THEN h.data15 ELSE 0 END) -- in_itax
					,SUM(CASE WHEN h.sub=1 THEN h.data11 ELSE 0 END) -- ex_taxbl
					,SUM(CASE WHEN h.sub=1 THEN h.data12 ELSE 0 END) -- in_taxbl
					,SUM(CASE WHEN h.sub=1 THEN h.data13 ELSE 0 END) -- no_taxbl
					,SUM(CASE WHEN h.sub=0 THEN h.data10 ELSE 0 END) -- refund_qty
					,SUM(CASE WHEN h.sub=0 THEN h.data11 ELSE 0 END) -- refund_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data7 ELSE 0 END) -- bdl_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data8 ELSE 0 END) -- stm_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data1 ELSE 0 END) -- brgn_sale
					,SUM(CASE WHEN h.sub=1 THEN h.data2 ELSE 0 END) -- brgncust_qty
					,SUM(CASE WHEN h.sub=1 THEN h.data3 ELSE 0 END) -- brgn_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data20 ELSE 0 END) -- brgn_prft
					,SUM(CASE WHEN h.sub=1 THEN h.data4 ELSE 0 END) -- mbrgn_sale
					,SUM(CASE WHEN h.sub=1 THEN h.data5 ELSE 0 END) -- mbrgncust_qty
					,SUM(CASE WHEN h.sub=1 THEN h.data6 ELSE 0 END) -- mbrgn_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data21 ELSE 0 END) -- mbrgn_prft
					,h.sale_date -- last_sale_datetime
					,m.smlcls_cd
					,m.producer_cd
					,SUM(CASE WHEN h.sub=1 THEN h.data10 ELSE 0 END) -- mstm_dsc_amt
					,SUM(CASE WHEN h.sub=1 THEN h.data9 ELSE 0 END) -- mbdl_dsc_amt
					,SUM(CASE WHEN h.sub=0 THEN h.data7 ELSE 0 END) -- plu_point_ttl
					,(CASE WHEN h.mode=4000 THEN 1 
					       WHEN h.mode=5000 THEN 2 
					       WHEN h.mode=6000 THEN 3 
					       WHEN h.mode=7000 THEN 4 ELSE 0 END) -- item_kind 
					,m.cost_prc
					,SUM(CASE WHEN h.sub=0 THEN h.data12 ELSE 0 END) -- ex_in_tabl
					,SUM(CASE WHEN h.sub=0 THEN h.data3 ELSE 0 END) -- scrap_qty
					,SUM(CASE WHEN h.sub=0 THEN h.data1 ELSE 0 END) -- scrap_amt
					,SUM(CASE WHEN h.sub=0 THEN h.data18 / 1000 ELSE 0 END) -- vol 体積(1Verで追加)
				FROM
					rdly_plu_hour h
				LEFT OUTER JOIN
					c_plu_mst m
				ON
					h.comp_cd = m.comp_cd
					AND h.stre_cd = m.stre_cd
					AND h.plu_cd = m.plu_cd
				WHERE
					h.comp_cd = _comp_cd
					AND h.stre_cd = _stre_cd
					AND h.sale_date = _sale_date
					AND h.mode in (4000, 5000, 6000, 7000)
				GROUP BY
					 h.stre_cd
					,h.plu_cd
					,h.sale_date
					,h.date_hour
					,h.mode
					,m.pos_prc
					,m.cost_prc
					,m.smlcls_cd
					,m.producer_cd
				ORDER BY
					 h.plu_cd
					,h.sale_date
					,h.date_hour
					,h.mode;

			END IF;

		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_mdl' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_mdl;
			ELSE
				CREATE TEMP TABLE reg_dly_mdl (
					 stre_cd NUMERIC(9)
					,lrgcls_cd NUMERIC(6)
					,mdlcls_cd NUMERIC(6)
					,sale_date timestamp
					,date_hour timestamp
					,amt NUMERIC(12) default '0'
					,qty NUMERIC(12) default '0'
					,cust NUMERIC(12) default '0'
					,prft NUMERIC(14,2) default '0'
					,wgt NUMERIC(15,3) default '0'
					,brgn_sale NUMERIC(12) default '0'
					,brgn_qty NUMERIC(12) default '0'
					,brgn_dsc NUMERIC(12) default '0'
					,brgn_prft NUMERIC(14,2) default '0'
					,bdl_dsc NUMERIC(12) default '0'
					,stm_dsc NUMERIC(12) default '0'
					,dsc_amt NUMERIC(12) default '0'
					,dsc_qty NUMERIC(12) default '0'
					,ex_itax NUMERIC(12) default '0'
					,in_itax NUMERIC(12) default '0'
					,ex_taxbl NUMERIC(12) default '0'
					,in_taxbl NUMERIC(12) default '0'
					,no_taxbl NUMERIC(12) default '0'
					,refund_qty NUMERIC(12) default '0'
					,refund_amt NUMERIC(12) default '0'
					,item_scan_qty NUMERIC(12) default '0'
					,item_preset_qty NUMERIC(12) default '0'
					,item_manual_qty NUMERIC(12) default '0'
					,update_flg NUMERIC(12) default '0'
					,btl_ret_qty NUMERIC(12) default '0'
					,btl_ret_amt NUMERIC(12) default '0'
					,mstm_dsc NUMERIC(12) default '0'
					,mbdl_dsc NUMERIC(12) default '0'
					,plu_point_qty NUMERIC(12) default '0'
					,plu_point_amt NUMERIC(12) default '0'
					,plu_point_ttl NUMERIC(12) default '0'
					,plus_amt NUMERIC(12) default '0'
					,plus_qty NUMERIC(12) default '0'
					,scrap_qty NUMERIC(12) default '0'
					,scrap_amt NUMERIC(12) default '0'
					,item_kind NUMERIC(12) default '0'
					,cpn_qty NUMERIC(12) default '0'
					,cpn_amt NUMERIC(12) default '0'
					,cpn_qty2 NUMERIC(12) default '0'
					,cpn_amt2 NUMERIC(12) default '0'
					,t_netsl_amt NUMERIC(12) default '0'
					,t_intax_item_amt NUMERIC(12) default '0'
					,d_intax_amt NUMERIC(12) default '0'
					,div_ppoint NUMERIC(12) default '0'
					,div_mpoint NUMERIC(12) default '0'
					,bg_pchg_amt NUMERIC(12) default '0'
					,bg_pchg_qty NUMERIC(12) default '0'
					,prfree_qty NUMERIC(12) default '0'
					,tax_typ1 smallint default '0'
					,tax_per1 NUMERIC(5,2) default '0'
					,taxbl_amt1 NUMERIC(12) default '0'
					,tax_amt1 NUMERIC(12) default '0'
					,tax_qty1 NUMERIC(12) default '0'
					,saleamt1 NUMERIC(12) default '0'
					,tax_typ2 smallint default '0'
					,tax_per2 NUMERIC(5,2) default '0'
					,taxbl_amt2 NUMERIC(12) default '0'
					,tax_amt2 NUMERIC(12) default '0'
					,tax_qty2 NUMERIC(12) default '0'
					,saleamt2 NUMERIC(12) default '0'
					,tax_typ3 smallint default '0'
					,tax_per3 NUMERIC(5,2) default '0'
					,taxbl_amt3 NUMERIC(12) default '0'
					,tax_amt3 NUMERIC(12) default '0'
					,tax_qty3 NUMERIC(12) default '0'
					,saleamt3 NUMERIC(12) default '0'
					,tax_typ4 smallint default '0'
					,tax_per4 NUMERIC(5,2) default '0'
					,taxbl_amt4 NUMERIC(12) default '0'
					,tax_amt4 NUMERIC(12) default '0'
					,tax_qty4 NUMERIC(12) default '0'
					,saleamt4 NUMERIC(12) default '0'
					,tax_typ5 smallint default '0'
					,tax_per5 NUMERIC(5,2) default '0'
					,taxbl_amt5 NUMERIC(12) default '0'
					,tax_amt5 NUMERIC(12) default '0'
					,tax_qty5 NUMERIC(12) default '0'
					,saleamt5 NUMERIC(12) default '0'
					,tax_typ6 smallint default '0'
					,tax_per6 NUMERIC(5,2) default '0'
					,taxbl_amt6 NUMERIC(12) default '0'
					,tax_amt6 NUMERIC(12) default '0'
					,tax_qty6 NUMERIC(12) default '0'
					,saleamt6 NUMERIC(12) default '0'
					,tax_typ7 smallint default '0'
					,tax_per7 NUMERIC(5,2) default '0'
					,taxbl_amt7 NUMERIC(12) default '0'
					,tax_amt7 NUMERIC(12) default '0'
					,tax_qty7 NUMERIC(12) default '0'
					,saleamt7 NUMERIC(12) default '0'
					,tax_typ8 smallint default '0'
					,tax_per8 NUMERIC(5,2) default '0'
					,taxbl_amt8 NUMERIC(12) default '0'
					,tax_amt8 NUMERIC(12) default '0'
					,tax_qty8 NUMERIC(12) default '0'
					,saleamt8 NUMERIC(12) default '0'
					,tax_typ10 smallint default '0'
					,tax_per10 NUMERIC(5,2) default '0'
					,taxbl_amt10 NUMERIC(12) default '0'
					,tax_amt10 NUMERIC(12) default '0'
					,tax_qty10 NUMERIC(12) default '0'
					,saleamt10 NUMERIC(12) default '0'
					,PRIMARY KEY (stre_cd,lrgcls_cd,mdlcls_cd,sale_date,date_hour,item_kind)
				);


				INSERT INTO reg_dly_mdl (
					 stre_cd
					,lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
					,amt
					,qty
					,cust
					,prft
					,wgt
					,brgn_sale
					,brgn_qty
					,brgn_dsc
					,brgn_prft
					,bdl_dsc
					,stm_dsc
					,dsc_amt
					,refund_qty
					,refund_amt
					,btl_ret_qty
					,btl_ret_amt
					,mstm_dsc
					,mbdl_dsc
					,plu_point_ttl
					,plus_amt
					,item_kind 
					,prfree_qty 
					,tax_typ1
					,tax_per1
					,taxbl_amt1
					,tax_amt1
					,tax_qty1
					,saleamt1
					,tax_typ2
					,tax_per2
					,taxbl_amt2
					,tax_amt2
					,tax_qty2
					,saleamt2
					,tax_typ3
					,tax_per3
					,taxbl_amt3
					,tax_amt3
					,tax_qty3
					,saleamt3
					,tax_typ4
					,tax_per4
					,taxbl_amt4
					,tax_amt4
					,tax_qty4
					,saleamt4
					,tax_typ5
					,tax_per5
					,taxbl_amt5
					,tax_amt5
					,tax_qty5
					,saleamt5
					,tax_typ6
					,tax_per6
					,taxbl_amt6
					,tax_amt6
					,tax_qty6
					,saleamt6
					,tax_typ7
					,tax_per7
					,taxbl_amt7
					,tax_amt7
					,tax_qty7
					,saleamt7
					,tax_typ8
					,tax_per8
					,taxbl_amt8
					,tax_amt8
					,tax_qty8
					,saleamt8
					,tax_typ10
					,tax_per10
					,taxbl_amt10
					,tax_amt10
					,tax_qty10
					,saleamt10
				)
				SELECT
					 stre_cd
					,lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END) -- amt
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) -- qty
					,SUM(CASE WHEN sub=0 THEN data15 ELSE 0 END) -- cust
					,SUM(CASE WHEN sub=0 THEN data21 ELSE 0 END) -- prft
					,SUM(CASE WHEN sub=0 THEN data14 / 1000 ELSE 0 END) -- wgt
					,SUM(CASE WHEN sub=1 THEN data1 ELSE 0 END) -- brgn_sale
					,SUM(CASE WHEN sub=1 THEN data2 ELSE 0 END) -- brgn_qty
					,SUM(CASE WHEN sub=1 THEN data3 ELSE 0 END) -- brgn_dsc
					,SUM(CASE WHEN sub=1 THEN data20 ELSE 0 END) -- brgn_prft
					,SUM(CASE WHEN sub=1 THEN data7 ELSE 0 END) -- bdl_dsc
					,SUM(CASE WHEN sub=1 THEN data8 ELSE 0 END) -- stm_dsc
					,SUM(CASE WHEN sub=0 THEN data4 ELSE 0 END) -- dsc_amt
					,SUM(CASE WHEN sub=0 THEN data10 ELSE 0 END) -- refund_qty
					,SUM(CASE WHEN sub=0 THEN data11 ELSE 0 END) -- refund_amt
					,SUM(CASE WHEN sub=0 THEN data8 ELSE 0 END) -- btl_ret_qty
					,SUM(CASE WHEN sub=0 THEN data9 ELSE 0 END) -- btl_ret_amt
					,SUM(CASE WHEN sub=1 THEN data10 ELSE 0 END) -- mstm_dsc
					,SUM(CASE WHEN sub=1 THEN data9 ELSE 0 END) -- mbdl_dsc
					,SUM(CASE WHEN sub=0 THEN data7 ELSE 0 END) -- plu_point_ttl
					,SUM(CASE WHEN sub=0 THEN data5 ELSE 0 END) -- plus_amt
					,0 -- item_kind 
					,SUM(CASE WHEN sub=0 THEN data13 ELSE 0 END) -- prfree_qty
					,MAX(CASE WHEN sub=2 THEN data1 ELSE 0 END) -- tax_typ1
					,MAX(CASE WHEN sub=2 THEN data21 ELSE 0 END) -- tax_per1
					,SUM(CASE WHEN sub=2 THEN data2 ELSE 0 END) -- taxbl_amt1
					,SUM(CASE WHEN sub=2 THEN data3 ELSE 0 END) -- tax_amt1
					,SUM(CASE WHEN sub=2 THEN data4 ELSE 0 END) -- tax_qty1
					,SUM(CASE WHEN sub=2 THEN data5 ELSE 0 END) -- saleamt1
					,MAX(CASE WHEN sub=3 THEN data1 ELSE 0 END) -- tax_typ2
					,MAX(CASE WHEN sub=3 THEN data21 ELSE 0 END) -- tax_per2
					,SUM(CASE WHEN sub=3 THEN data2 ELSE 0 END) -- taxbl_amt2
					,SUM(CASE WHEN sub=3 THEN data3 ELSE 0 END) -- tax_amt2
					,SUM(CASE WHEN sub=3 THEN data4 ELSE 0 END) -- tax_qty2
					,SUM(CASE WHEN sub=3 THEN data5 ELSE 0 END) -- saleamt2
					,MAX(CASE WHEN sub=4 THEN data1 ELSE 0 END) -- tax_typ3
					,MAX(CASE WHEN sub=4 THEN data21 ELSE 0 END) -- tax_per3
					,SUM(CASE WHEN sub=4 THEN data2 ELSE 0 END) -- taxbl_amt3
					,SUM(CASE WHEN sub=4 THEN data3 ELSE 0 END) -- tax_amt3
					,SUM(CASE WHEN sub=4 THEN data4 ELSE 0 END) -- tax_qty3
					,SUM(CASE WHEN sub=4 THEN data5 ELSE 0 END) -- saleamt3
					,MAX(CASE WHEN sub=5 THEN data1 ELSE 0 END) -- tax_typ4
					,MAX(CASE WHEN sub=5 THEN data21 ELSE 0 END) -- tax_per4
					,SUM(CASE WHEN sub=5 THEN data2 ELSE 0 END) -- taxbl_amt4
					,SUM(CASE WHEN sub=5 THEN data3 ELSE 0 END) -- tax_amt4
					,SUM(CASE WHEN sub=5 THEN data4 ELSE 0 END) -- tax_qty4
					,SUM(CASE WHEN sub=5 THEN data5 ELSE 0 END) -- saleamt4
					,MAX(CASE WHEN sub=6 THEN data1 ELSE 0 END) -- tax_typ5
					,MAX(CASE WHEN sub=6 THEN data21 ELSE 0 END) -- tax_per5
					,SUM(CASE WHEN sub=6 THEN data2 ELSE 0 END) -- taxbl_amt5
					,SUM(CASE WHEN sub=6 THEN data3 ELSE 0 END) -- tax_amt5
					,SUM(CASE WHEN sub=6 THEN data4 ELSE 0 END) -- tax_qty5
					,SUM(CASE WHEN sub=6 THEN data5 ELSE 0 END) -- saleamt5
					,MAX(CASE WHEN sub=7 THEN data1 ELSE 0 END) -- tax_typ6
					,MAX(CASE WHEN sub=7 THEN data21 ELSE 0 END) -- tax_per6
					,SUM(CASE WHEN sub=7 THEN data2 ELSE 0 END) -- taxbl_amt6
					,SUM(CASE WHEN sub=7 THEN data3 ELSE 0 END) -- tax_amt6
					,SUM(CASE WHEN sub=7 THEN data4 ELSE 0 END) -- tax_qty6
					,SUM(CASE WHEN sub=7 THEN data5 ELSE 0 END) -- saleamt6
					,MAX(CASE WHEN sub=8 THEN data1 ELSE 0 END) -- tax_typ7
					,MAX(CASE WHEN sub=8 THEN data21 ELSE 0 END) -- tax_per7
					,SUM(CASE WHEN sub=8 THEN data2 ELSE 0 END) -- taxbl_amt7
					,SUM(CASE WHEN sub=8 THEN data3 ELSE 0 END) -- tax_amt7
					,SUM(CASE WHEN sub=8 THEN data4 ELSE 0 END) -- tax_qty7
					,SUM(CASE WHEN sub=8 THEN data5 ELSE 0 END) -- saleamt7
					,MAX(CASE WHEN sub=9 THEN data1 ELSE 0 END) -- tax_typ8
					,MAX(CASE WHEN sub=9 THEN data21 ELSE 0 END) -- tax_per8
					,SUM(CASE WHEN sub=9 THEN data2 ELSE 0 END) -- taxbl_amt8
					,SUM(CASE WHEN sub=9 THEN data3 ELSE 0 END) -- tax_amt8
					,SUM(CASE WHEN sub=9 THEN data4 ELSE 0 END) -- tax_qty8
					,SUM(CASE WHEN sub=9 THEN data5 ELSE 0 END) -- saleamt8
					,MAX(CASE WHEN sub=10 THEN data1 ELSE 0 END) -- tax_typ10
					,MAX(CASE WHEN sub=10 THEN data21 ELSE 0 END) -- tax_per10
					,SUM(CASE WHEN sub=10 THEN data2 ELSE 0 END) -- taxbl_amt10
					,SUM(CASE WHEN sub=10 THEN data3 ELSE 0 END) -- tax_amt10
					,SUM(CASE WHEN sub=10 THEN data4 ELSE 0 END) -- tax_qty10
					,SUM(CASE WHEN sub=10 THEN data5 ELSE 0 END) -- saleamt10
				FROM
					rdly_class_hour
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
				ORDER BY
					 lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour ;

				INSERT INTO reg_dly_mdl (
					 stre_cd
					,lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
					,amt
					,qty
					,cust
					,prft
					,brgn_sale
					,brgn_qty
					,brgn_dsc
					,brgn_prft
					,bdl_dsc
					,stm_dsc
					,dsc_amt
					,refund_qty
					,refund_amt
					,btl_ret_qty
					,btl_ret_amt
					,mstm_dsc
					,mbdl_dsc
					,plu_point_ttl
					,plus_amt
					,item_kind 
					,prfree_qty
					,scrap_qty
					,scrap_amt )
				SELECT
					 stre_cd
					,lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END) -- amt
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) -- qty
					,SUM(CASE WHEN sub=0 THEN data15 ELSE 0 END) -- cust
					,SUM(CASE WHEN sub=0 THEN data21 ELSE 0 END) -- prft
					,SUM(CASE WHEN sub=1 THEN data1 ELSE 0 END) -- brgn_sale
					,SUM(CASE WHEN sub=1 THEN data2 ELSE 0 END) -- brgn_qty
					,SUM(CASE WHEN sub=1 THEN data3 ELSE 0 END) -- brgn_dsc
					,SUM(CASE WHEN sub=1 THEN data20 ELSE 0 END) -- brgn_prft
					,SUM(CASE WHEN sub=1 THEN data7 ELSE 0 END) -- bdl_dsc
					,SUM(CASE WHEN sub=1 THEN data8 ELSE 0 END) -- stm_dsc
					,SUM(CASE WHEN sub=0 THEN data4 ELSE 0 END) -- dsc_amt
					,SUM(CASE WHEN sub=0 THEN data10 ELSE 0 END) -- refund_qty
					,SUM(CASE WHEN sub=0 THEN data11 ELSE 0 END) -- refund_amt
					,SUM(CASE WHEN sub=0 THEN data8 ELSE 0 END) -- btl_ret_qty
					,SUM(CASE WHEN sub=0 THEN data9 ELSE 0 END) -- btl_ret_amt
					,SUM(CASE WHEN sub=1 THEN data10 ELSE 0 END) -- mstm_dsc
					,SUM(CASE WHEN sub=1 THEN data9 ELSE 0 END) -- mbdl_dsc
					,SUM(CASE WHEN sub=0 THEN data7 ELSE 0 END) -- plu_point_ttl
					,SUM(CASE WHEN sub=0 THEN data5 ELSE 0 END) -- plus_amt
					,(CASE WHEN mode=4000 THEN 1 
					       WHEN mode=5000 THEN 2 
					       WHEN mode=6000 THEN 3 
					       WHEN mode=7000 THEN 4 ELSE 0 END) -- item_kind 
					,SUM(CASE WHEN sub=0 THEN data13 ELSE 0 END) -- prfree_qty
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) -- scrap_qty
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END) -- scrap_amt
				FROM
					rdly_class_hour
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND mode IN (4000, 5000, 6000, 7000)
				GROUP BY
					 stre_cd
					,lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
					,mode
				ORDER BY
					 lrgcls_cd
					,mdlcls_cd
					,sale_date
					,date_hour
					,mode ;


			END IF;

		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_sml' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_sml;
			ELSE
				CREATE TEMP TABLE reg_dly_sml (
					 stre_cd NUMERIC(9)
					,mdlcls_cd NUMERIC(6)
					,smlcls_cd NUMERIC(6)
					,sale_date timestamp
					,date_hour timestamp
					,amt NUMERIC(12) default '0'
					,qty NUMERIC(12) default '0'
					,cust NUMERIC(12) default '0'
					,prft NUMERIC(14,2) default '0'
					,wgt NUMERIC(15,3) default '0'
					,brgn_sale NUMERIC(12) default '0'
					,brgn_qty NUMERIC(12) default '0'
					,brgn_dsc NUMERIC(12) default '0'
					,brgn_prft NUMERIC(14,2) default '0'
					,bdl_dsc NUMERIC(12) default '0'
					,stm_dsc NUMERIC(12) default '0'
					,dsc_amt NUMERIC(12) default '0'
					,dsc_qty NUMERIC(12) default '0'
					,ex_itax NUMERIC(12) default '0'
					,in_itax NUMERIC(12) default '0'
					,ex_taxbl NUMERIC(12) default '0'
					,in_taxbl NUMERIC(12) default '0'
					,no_taxbl NUMERIC(12) default '0'
					,refund_qty NUMERIC(12) default '0'
					,refund_amt NUMERIC(12) default '0'
					,item_scan_qty NUMERIC(12) default '0'
					,item_preset_qty NUMERIC(12) default '0'
					,item_manual_qty NUMERIC(12) default '0'
					,update_flg NUMERIC(12) default '0'
					,btl_ret_qty NUMERIC(12) default '0'
					,btl_ret_amt NUMERIC(12) default '0'
					,mstm_dsc NUMERIC(12) default '0'
					,mbdl_dsc NUMERIC(12) default '0'
					,plu_point_qty NUMERIC(12) default '0'
					,plu_point_amt NUMERIC(12) default '0'
					,plu_point_ttl NUMERIC(12) default '0'
					,plus_amt NUMERIC(12) default '0'
					,plus_qty NUMERIC(12) default '0'
					,scrap_qty NUMERIC(12) default '0'
					,scrap_amt NUMERIC(12) default '0'
					,item_kind smallint default '0'
					,cpn_qty NUMERIC(12) default '0'
					,cpn_amt NUMERIC(12) default '0'
					,cpn_qty2 NUMERIC(12) default '0'
					,cpn_amt2 NUMERIC(12) default '0'
					,t_netsl_amt NUMERIC(12) default '0'
					,t_intax_item_amt NUMERIC(12) default '0'
					,d_intax_amt NUMERIC(12) default '0'
					,div_ppoint NUMERIC(12) default '0'
					,div_mpoint NUMERIC(12) default '0'
					,bg_pchg_amt NUMERIC(12) default '0'
					,bg_pchg_qty NUMERIC(12) default '0'
					,prfree_qty NUMERIC(12) default '0'
					,tax_typ1 smallint default '0'
					,tax_per1 NUMERIC(5,2) default '0'
					,taxbl_amt1 NUMERIC(12) default '0'
					,tax_amt1 NUMERIC(12) default '0'
					,tax_qty1 NUMERIC(12) default '0'
					,saleamt1 NUMERIC(12) default '0'
					,tax_typ2 smallint default '0'
					,tax_per2 NUMERIC(5,2) default '0'
					,taxbl_amt2 NUMERIC(12) default '0'
					,tax_amt2 NUMERIC(12) default '0'
					,tax_qty2 NUMERIC(12) default '0'
					,saleamt2 NUMERIC(12) default '0'
					,tax_typ3 smallint default '0'
					,tax_per3 NUMERIC(5,2) default '0'
					,taxbl_amt3 NUMERIC(12) default '0'
					,tax_amt3 NUMERIC(12) default '0'
					,tax_qty3 NUMERIC(12) default '0'
					,saleamt3 NUMERIC(12) default '0'
					,tax_typ4 smallint default '0'
					,tax_per4 NUMERIC(5,2) default '0'
					,taxbl_amt4 NUMERIC(12) default '0'
					,tax_amt4 NUMERIC(12) default '0'
					,tax_qty4 NUMERIC(12) default '0'
					,saleamt4 NUMERIC(12) default '0'
					,tax_typ5 smallint default '0'
					,tax_per5 NUMERIC(5,2) default '0'
					,taxbl_amt5 NUMERIC(12) default '0'
					,tax_amt5 NUMERIC(12) default '0'
					,tax_qty5 NUMERIC(12) default '0'
					,saleamt5 NUMERIC(12) default '0'
					,tax_typ6 smallint default '0'
					,tax_per6 NUMERIC(5,2) default '0'
					,taxbl_amt6 NUMERIC(12) default '0'
					,tax_amt6 NUMERIC(12) default '0'
					,tax_qty6 NUMERIC(12) default '0'
					,saleamt6 NUMERIC(12) default '0'
					,tax_typ7 smallint default '0'
					,tax_per7 NUMERIC(5,2) default '0'
					,taxbl_amt7 NUMERIC(12) default '0'
					,tax_amt7 NUMERIC(12) default '0'
					,tax_qty7 NUMERIC(12) default '0'
					,saleamt7 NUMERIC(12) default '0'
					,tax_typ8 smallint default '0'
					,tax_per8 NUMERIC(5,2) default '0'
					,taxbl_amt8 NUMERIC(12) default '0'
					,tax_amt8 NUMERIC(12) default '0'
					,tax_qty8 NUMERIC(12) default '0'
					,saleamt8 NUMERIC(12) default '0'
					,tax_typ10 smallint default '0'
					,tax_per10 NUMERIC(5,2) default '0'
					,taxbl_amt10 NUMERIC(12) default '0'
					,tax_amt10 NUMERIC(12) default '0'
					,tax_qty10 NUMERIC(12) default '0'
					,saleamt10 NUMERIC(12) default '0'
					,PRIMARY KEY (stre_cd,mdlcls_cd,smlcls_cd,sale_date,date_hour,item_kind)
				);

				INSERT INTO reg_dly_sml (
					 stre_cd
					,mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
					,amt
					,qty
					,cust
					,prft
					,wgt
					,brgn_sale
					,brgn_qty
					,brgn_dsc
					,brgn_prft
					,bdl_dsc
					,stm_dsc
					,dsc_amt
					,refund_qty
					,refund_amt
					,btl_ret_qty
					,btl_ret_amt
					,mstm_dsc
					,mbdl_dsc
					,plu_point_ttl
					,plus_amt
					,item_kind 
					,prfree_qty 
					,tax_typ1
					,tax_per1
					,taxbl_amt1
					,tax_amt1
					,tax_qty1
					,saleamt1
					,tax_typ2
					,tax_per2
					,taxbl_amt2
					,tax_amt2
					,tax_qty2
					,saleamt2
					,tax_typ3
					,tax_per3
					,taxbl_amt3
					,tax_amt3
					,tax_qty3
					,saleamt3
					,tax_typ4
					,tax_per4
					,taxbl_amt4
					,tax_amt4
					,tax_qty4
					,saleamt4
					,tax_typ5
					,tax_per5
					,taxbl_amt5
					,tax_amt5
					,tax_qty5
					,saleamt5
					,tax_typ6
					,tax_per6
					,taxbl_amt6
					,tax_amt6
					,tax_qty6
					,saleamt6
					,tax_typ7
					,tax_per7
					,taxbl_amt7
					,tax_amt7
					,tax_qty7
					,saleamt7
					,tax_typ8
					,tax_per8
					,taxbl_amt8
					,tax_amt8
					,tax_qty8
					,saleamt8
					,tax_typ10
					,tax_per10
					,taxbl_amt10
					,tax_amt10
					,tax_qty10
					,saleamt10
				)
				SELECT
					 stre_cd
					,mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END) -- amt
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) -- qty
					,SUM(CASE WHEN sub=0 THEN data16 ELSE 0 END) -- cust
					,SUM(CASE WHEN sub=0 THEN data21 ELSE 0 END) -- prft
					,SUM(CASE WHEN sub=0 THEN data14 / 1000 ELSE 0 END) -- wgt
					,SUM(CASE WHEN sub=1 THEN data1 ELSE 0 END) -- brgn_sale
					,SUM(CASE WHEN sub=1 THEN data2 ELSE 0 END) -- brgn_qty
					,SUM(CASE WHEN sub=1 THEN data3 ELSE 0 END) -- brgn_dsc
					,SUM(CASE WHEN sub=1 THEN data20 ELSE 0 END) -- brgn_prft
					,SUM(CASE WHEN sub=1 THEN data7 ELSE 0 END) -- bdl_dsc
					,SUM(CASE WHEN sub=1 THEN data8 ELSE 0 END) -- stm_dsc
					,SUM(CASE WHEN sub=0 THEN data4 ELSE 0 END) -- dsc_amt
					,SUM(CASE WHEN sub=0 THEN data10 ELSE 0 END) -- refund_qty
					,SUM(CASE WHEN sub=0 THEN data11 ELSE 0 END) -- refund_amt
					,SUM(CASE WHEN sub=0 THEN data8 ELSE 0 END) -- btl_ret_qty
					,SUM(CASE WHEN sub=0 THEN data9 ELSE 0 END) -- btl_ret_amt
					,SUM(CASE WHEN sub=1 THEN data10 ELSE 0 END) -- mstm_dsc
					,SUM(CASE WHEN sub=1 THEN data9 ELSE 0 END) -- mbdl_dsc
					,SUM(CASE WHEN sub=0 THEN data7 ELSE 0 END) -- plu_point_ttl
					,SUM(CASE WHEN sub=0 THEN data5 ELSE 0 END) -- plus_amt
					,0 -- item_kind 
					,SUM(CASE WHEN sub=0 THEN data13 ELSE 0 END) -- prfree_qty
					,MAX(CASE WHEN sub=2 THEN data1 ELSE 0 END) -- tax_typ1
					,MAX(CASE WHEN sub=2 THEN data21 ELSE 0 END) -- tax_per1
					,SUM(CASE WHEN sub=2 THEN data2 ELSE 0 END) -- taxbl_amt1
					,SUM(CASE WHEN sub=2 THEN data3 ELSE 0 END) -- tax_amt1
					,SUM(CASE WHEN sub=2 THEN data4 ELSE 0 END) -- tax_qty1
					,SUM(CASE WHEN sub=2 THEN data5 ELSE 0 END) -- saleamt1
					,MAX(CASE WHEN sub=3 THEN data1 ELSE 0 END) -- tax_typ2
					,MAX(CASE WHEN sub=3 THEN data21 ELSE 0 END) -- tax_per2
					,SUM(CASE WHEN sub=3 THEN data2 ELSE 0 END) -- taxbl_amt2
					,SUM(CASE WHEN sub=3 THEN data3 ELSE 0 END) -- tax_amt2
					,SUM(CASE WHEN sub=3 THEN data4 ELSE 0 END) -- tax_qty2
					,SUM(CASE WHEN sub=3 THEN data5 ELSE 0 END) -- saleamt2
					,MAX(CASE WHEN sub=4 THEN data1 ELSE 0 END) -- tax_typ3
					,MAX(CASE WHEN sub=4 THEN data21 ELSE 0 END) -- tax_per3
					,SUM(CASE WHEN sub=4 THEN data2 ELSE 0 END) -- taxbl_amt3
					,SUM(CASE WHEN sub=4 THEN data3 ELSE 0 END) -- tax_amt3
					,SUM(CASE WHEN sub=4 THEN data4 ELSE 0 END) -- tax_qty3
					,SUM(CASE WHEN sub=4 THEN data5 ELSE 0 END) -- saleamt3
					,MAX(CASE WHEN sub=5 THEN data1 ELSE 0 END) -- tax_typ4
					,MAX(CASE WHEN sub=5 THEN data21 ELSE 0 END) -- tax_per4
					,SUM(CASE WHEN sub=5 THEN data2 ELSE 0 END) -- taxbl_amt4
					,SUM(CASE WHEN sub=5 THEN data3 ELSE 0 END) -- tax_amt4
					,SUM(CASE WHEN sub=5 THEN data4 ELSE 0 END) -- tax_qty4
					,SUM(CASE WHEN sub=5 THEN data5 ELSE 0 END) -- saleamt4
					,MAX(CASE WHEN sub=6 THEN data1 ELSE 0 END) -- tax_typ5
					,MAX(CASE WHEN sub=6 THEN data21 ELSE 0 END) -- tax_per5
					,SUM(CASE WHEN sub=6 THEN data2 ELSE 0 END) -- taxbl_amt5
					,SUM(CASE WHEN sub=6 THEN data3 ELSE 0 END) -- tax_amt5
					,SUM(CASE WHEN sub=6 THEN data4 ELSE 0 END) -- tax_qty5
					,SUM(CASE WHEN sub=6 THEN data5 ELSE 0 END) -- saleamt5
					,MAX(CASE WHEN sub=7 THEN data1 ELSE 0 END) -- tax_typ6
					,MAX(CASE WHEN sub=7 THEN data21 ELSE 0 END) -- tax_per6
					,SUM(CASE WHEN sub=7 THEN data2 ELSE 0 END) -- taxbl_amt6
					,SUM(CASE WHEN sub=7 THEN data3 ELSE 0 END) -- tax_amt6
					,SUM(CASE WHEN sub=7 THEN data4 ELSE 0 END) -- tax_qty6
					,SUM(CASE WHEN sub=7 THEN data5 ELSE 0 END) -- saleamt6
					,MAX(CASE WHEN sub=8 THEN data1 ELSE 0 END) -- tax_typ7
					,MAX(CASE WHEN sub=8 THEN data21 ELSE 0 END) -- tax_per7
					,SUM(CASE WHEN sub=8 THEN data2 ELSE 0 END) -- taxbl_amt7
					,SUM(CASE WHEN sub=8 THEN data3 ELSE 0 END) -- tax_amt7
					,SUM(CASE WHEN sub=8 THEN data4 ELSE 0 END) -- tax_qty7
					,SUM(CASE WHEN sub=8 THEN data5 ELSE 0 END) -- saleamt7
					,MAX(CASE WHEN sub=9 THEN data1 ELSE 0 END) -- tax_typ8
					,MAX(CASE WHEN sub=9 THEN data21 ELSE 0 END) -- tax_per8
					,SUM(CASE WHEN sub=9 THEN data2 ELSE 0 END) -- taxbl_amt8
					,SUM(CASE WHEN sub=9 THEN data3 ELSE 0 END) -- tax_amt8
					,SUM(CASE WHEN sub=9 THEN data4 ELSE 0 END) -- tax_qty8
					,SUM(CASE WHEN sub=9 THEN data5 ELSE 0 END) -- saleamt8
					,MAX(CASE WHEN sub=10 THEN data1 ELSE 0 END) -- tax_typ10
					,MAX(CASE WHEN sub=10 THEN data21 ELSE 0 END) -- tax_per10
					,SUM(CASE WHEN sub=10 THEN data2 ELSE 0 END) -- taxbl_amt10
					,SUM(CASE WHEN sub=10 THEN data3 ELSE 0 END) -- tax_amt10
					,SUM(CASE WHEN sub=10 THEN data4 ELSE 0 END) -- tax_qty10
					,SUM(CASE WHEN sub=10 THEN data5 ELSE 0 END) -- saleamt10
				FROM
					rdly_class_hour
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
				ORDER BY
					 mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour;

				INSERT INTO reg_dly_sml (
					 stre_cd
					,mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
					,amt
					,qty
					,cust
					,prft
					,brgn_sale
					,brgn_qty
					,brgn_dsc
					,brgn_prft
					,bdl_dsc
					,stm_dsc
					,dsc_amt
					,refund_qty
					,refund_amt
					,btl_ret_qty
					,btl_ret_amt
					,mstm_dsc
					,mbdl_dsc
					,plu_point_ttl
					,plus_amt
					,item_kind 
					,prfree_qty
					,scrap_qty
					,scrap_amt )
				SELECT
					 stre_cd
					,mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END) -- amt
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) -- qty
					,SUM(CASE WHEN sub=0 THEN data16 ELSE 0 END) -- cust
					,SUM(CASE WHEN sub=0 THEN data21 ELSE 0 END) -- prft
					,SUM(CASE WHEN sub=1 THEN data1 ELSE 0 END) -- brgn_sale
					,SUM(CASE WHEN sub=1 THEN data2 ELSE 0 END) -- brgn_qty
					,SUM(CASE WHEN sub=1 THEN data3 ELSE 0 END) -- brgn_dsc
					,SUM(CASE WHEN sub=1 THEN data20 ELSE 0 END) -- brgn_prft
					,SUM(CASE WHEN sub=1 THEN data7 ELSE 0 END) -- bdl_dsc
					,SUM(CASE WHEN sub=1 THEN data8 ELSE 0 END) -- stm_dsc
					,SUM(CASE WHEN sub=0 THEN data4 ELSE 0 END) -- dsc_amt
					,SUM(CASE WHEN sub=0 THEN data10 ELSE 0 END) -- refund_qty
					,SUM(CASE WHEN sub=0 THEN data11 ELSE 0 END) -- refund_amt
					,SUM(CASE WHEN sub=0 THEN data8 ELSE 0 END) -- btl_ret_qty
					,SUM(CASE WHEN sub=0 THEN data9 ELSE 0 END) -- btl_ret_amt
					,SUM(CASE WHEN sub=1 THEN data10 ELSE 0 END) -- mstm_dsc
					,SUM(CASE WHEN sub=1 THEN data9 ELSE 0 END) -- mbdl_dsc
					,SUM(CASE WHEN sub=0 THEN data7 ELSE 0 END) -- plu_point_ttl
					,SUM(CASE WHEN sub=0 THEN data5 ELSE 0 END) -- plus_amt
					,(CASE WHEN mode=4000 THEN 1 
					       WHEN mode=5000 THEN 2 
					       WHEN mode=6000 THEN 3 
					       WHEN mode=7000 THEN 4 ELSE 0 END) -- item_kind 
					,SUM(CASE WHEN sub=0 THEN data13 ELSE 0 END) -- prfree_qty
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) -- scrap_qty
					,SUM(CASE WHEN sub=0 THEN data1 ELSE 0 END) -- scrap_amt
				FROM
					rdly_class_hour
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND mode IN (4000, 5000, 6000, 7000)
				GROUP BY
					 stre_cd
					,mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
					,mode
				ORDER BY
					 mdlcls_cd
					,smlcls_cd
					,sale_date
					,date_hour
					,mode;

			END IF;
		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_brgn' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_brgn;
			ELSE
				CREATE TEMP TABLE 
					reg_dly_brgn
				AS SELECT
					 stre_cd
					,plu_cd
					,sale_date
					,sch_cd AS brgn_cd
					,1 AS mbr_div
					,SUM(data1) AS sale
					,SUM(data2) AS qty
					,0 AS cust
					,SUM(data3) AS dsc
					,0.00 AS prft
				FROM
					rdly_prom
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND prom_typ = 1
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,sale_date
					,sch_cd
					,plu_cd
				HAVING
					   SUM(data1) <> 0
					OR SUM(data2) <> 0
					OR SUM(data3) <> 0
				ORDER BY
					 plu_cd
					,sch_cd ;

				-- MBR
				INSERT INTO reg_dly_brgn 
					(stre_cd, plu_cd, sale_date, brgn_cd, mbr_div, sale, qty, cust, dsc, prft) 
				SELECT 
					stre_cd, plu_cd, sale_date, sch_cd, 2, SUM(data4), SUM(data5), 0, SUM(data6), 0.00
				FROM
					rdly_prom
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND prom_typ = 1
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,plu_cd
					,sch_cd
					,sale_date
				HAVING
					   SUM(data4) <> 0
					OR SUM(data5) <> 0
					OR SUM(data6) <> 0
				ORDER BY
					 plu_cd
					,sch_cd ;

			END IF;
		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_mach' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_mach;
			ELSE
				CREATE TEMP TABLE 
					reg_dly_mach
				AS SELECT
					 stre_cd
					,sale_date
					,sch_cd AS mach_cd
					,1 AS div
					,0 AS cnt1
					,0 AS dsc1
					,0 AS cnt2
					,0 AS dsc2
					,0 AS cnt3
					,0 AS dsc3
					,0 AS cnt4
					,0 AS dsc4
					,0 AS cnt5
					,0 AS dsc5
					,SUM(CASE WHEN kind=0 THEN data1 ELSE 0 END) AS form_amt
					,SUM(CASE WHEN kind=0 THEN data2 ELSE 0 END) AS form_qty
					,SUM(CASE WHEN kind=0 THEN data3 ELSE 0 END) AS form_cnt
					,SUM(CASE WHEN kind=0 THEN data4 ELSE 0 END) AS form_dsc
					,SUM(CASE WHEN kind=0 THEN data5 ELSE 0 END) AS sale_amt
					,SUM(CASE WHEN kind=0 THEN data6 ELSE 0 END) AS sale_qty
					,0 AS mcnt1
					,0 AS mdsc1
					,0 AS mcnt2
					,0 AS mdsc2
					,0 AS mcnt3
					,0 AS mdsc3
					,0 AS mcnt4
					,0 AS mdsc4
					,0 AS mcnt5
					,0 AS mdsc5
					,SUM(CASE WHEN kind=1 THEN data1 ELSE 0 END) AS m_form_amt
					,SUM(CASE WHEN kind=1 THEN data2 ELSE 0 END) AS m_form_qty
					,SUM(CASE WHEN kind=1 THEN data3 ELSE 0 END) AS m_form_cnt
					,SUM(CASE WHEN kind=1 THEN data4 ELSE 0 END) AS m_form_dsc
					,SUM(CASE WHEN kind=1 THEN data5 ELSE 0 END) AS m_sale_amt
					,SUM(CASE WHEN kind=1 THEN data6 ELSE 0 END) AS m_sale_qty
					,sch_typ AS bdl_typ
				FROM
					rdly_prom
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND prom_typ = 2
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,sch_cd
					,sale_date
					,sch_typ
				ORDER BY
					 sch_cd ;

				-- STM
				INSERT INTO reg_dly_mach 
					(stre_cd, sale_date, mach_cd, div, 
					form_amt, form_qty, form_cnt, form_dsc, sale_amt, sale_qty, 
					m_form_amt, m_form_qty, m_form_cnt, m_form_dsc, m_sale_amt, m_sale_qty,
					cnt1, dsc1, cnt2, dsc2, cnt3, dsc3, cnt4, dsc4, cnt5, dsc5,
					mcnt1, mdsc1, mcnt2, mdsc2, mcnt3, mdsc3, mcnt4, mdsc4, mcnt5, mdsc5, 
					bdl_typ)
				SELECT 
					stre_cd, sale_date, sch_cd, 2, 
					SUM(CASE WHEN kind=0 THEN data1 ELSE 0 END), 
					SUM(CASE WHEN kind=0 THEN data2 ELSE 0 END), 
					SUM(CASE WHEN kind=0 THEN data3 ELSE 0 END), 
					SUM(CASE WHEN kind=0 THEN data4 ELSE 0 END), 
					SUM(CASE WHEN kind=0 THEN data5 ELSE 0 END), 
					SUM(CASE WHEN kind=0 THEN data6 ELSE 0 END), 
					SUM(CASE WHEN kind=1 THEN data1 ELSE 0 END), 
					SUM(CASE WHEN kind=1 THEN data2 ELSE 0 END), 
					SUM(CASE WHEN kind=1 THEN data3 ELSE 0 END), 
					SUM(CASE WHEN kind=1 THEN data4 ELSE 0 END), 
					SUM(CASE WHEN kind=1 THEN data5 ELSE 0 END), 
					SUM(CASE WHEN kind=1 THEN data6 ELSE 0 END),
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
					0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
					0
				FROM
					rdly_prom
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND prom_typ = 3
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,sch_cd
					,sale_date
				ORDER BY
					sch_cd ;

			END IF;
		END IF;


		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_cdpayflow' THEN
			
			_ret_name := _tbl_name;

			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_cdpayflow;
			ELSE
				CREATE TEMP TABLE reg_dly_cdpayflow (
					 stre_cd NUMERIC(9)
					,mac_no NUMERIC(9)
					,chkr_no NUMERIC(10)
					,cshr_no NUMERIC(10)
					,sale_date timestamp
					,date_hour timestamp
					,tran_cd smallint
					,payopera_cd smallint
					,payopera_typ VARCHAR(50)
					,cdpay_cha_cnt NUMERIC(12) default '0'
					,cdpay_cha_amt NUMERIC(12) default '0'
					,PRIMARY KEY (stre_cd,mac_no,chkr_no,cshr_no,sale_date,date_hour,tran_cd,payopera_cd,payopera_typ)
				);


				INSERT INTO reg_dly_cdpayflow
					(stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,tran_cd
					,payopera_cd
					,payopera_typ
					,cdpay_cha_cnt
					,cdpay_cha_amt
					)
				SELECT
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,sale_date
					,sub+14
					,payopera_cd
					,payopera_typ
					,SUM(data2)
					,SUM(data1)
				FROM
					rdly_cdpayflow
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND sub < 11
					AND payopera_cd = 0
					AND payopera_typ is not NULL
					AND payopera_typ <> ''
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,kind
					,sub
					,payopera_cd
					,payopera_typ
				ORDER BY
					mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,kind
					,sub
					,payopera_cd
					,payopera_typ ;
	

				INSERT INTO reg_dly_cdpayflow
					(stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,tran_cd
					,payopera_cd
					,payopera_typ
					,cdpay_cha_cnt
					,cdpay_cha_amt
					)
				SELECT
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,sale_date
					,sub+373
					,payopera_cd
					,payopera_typ
					,SUM(data2)
					,SUM(data1)
				FROM
					rdly_cdpayflow
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND sub > 10
					AND payopera_cd = 0
					AND payopera_typ is not NULL
					AND payopera_typ <> ''
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,kind
					,sub
					,payopera_cd
					,payopera_typ
				ORDER BY
					mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,kind
					,sub
					,payopera_cd
					,payopera_typ ;

			END IF;
		END IF;

		--  ====================================================================================================
		IF _tbl_name = 'reg_dly_tax_deal' THEN

			_ret_name := _tbl_name;
			IF _set_type = 1 THEN
				DROP TABLE IF EXISTS reg_dly_tax_deal;
			ELSE
				CREATE TEMP TABLE 
					reg_dly_tax_deal
				AS SELECT
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,0 AS item_kind
					,kind
					,SUM(CASE WHEN sub=0 THEN data2 ELSE 0 END) AS taxbl_amt 
					,SUM(CASE WHEN sub=0 THEN data3 ELSE 0 END) AS tax_amt
					,MAX(CASE WHEN sub=0 THEN data1 ELSE 0 END) AS tax_typ
					,MAX(CASE WHEN sub=0 THEN data20 ELSE 0 END) AS tax_per
					,SUM(CASE WHEN sub=0 THEN data4 ELSE 0 END) AS tax_item_amt
					,0 AS stldsc_base_tcd_amt
					,SUM(CASE WHEN sub=2 THEN data1 ELSE 0 END) AS stldscpdsc_tcd_amt
					,SUM(CASE WHEN sub=2 THEN data2 ELSE 0 END) AS stldsc_tcd_amt1
					,SUM(CASE WHEN sub=2 THEN data3 ELSE 0 END) AS stldsc_tcd_amt2
					,SUM(CASE WHEN sub=2 THEN data4 ELSE 0 END) AS stldsc_tcd_amt3
					,SUM(CASE WHEN sub=2 THEN data5 ELSE 0 END) AS stldsc_tcd_amt4
					,SUM(CASE WHEN sub=2 THEN data6 ELSE 0 END) AS stldsc_tcd_amt5
					,SUM(CASE WHEN sub=2 THEN data7 ELSE 0 END) AS stlpdsc_tcd_amt1
					,SUM(CASE WHEN sub=2 THEN data8 ELSE 0 END) AS stlpdsc_tcd_amt2
					,SUM(CASE WHEN sub=2 THEN data9 ELSE 0 END) AS stlpdsc_tcd_amt3
					,SUM(CASE WHEN sub=2 THEN data10 ELSE 0 END) AS stlpdsc_tcd_amt4
					,SUM(CASE WHEN sub=2 THEN data11 ELSE 0 END) AS stlpdsc_tcd_amt5
					,0 AS stlplus_base_tcd_amt
					,SUM(CASE WHEN sub=2 THEN data12 ELSE 0 END) AS stlplus_tcd_amt
					,SUM(CASE WHEN sub=2 THEN data13 ELSE 0 END) AS stlplus_tcd_amt1
					,SUM(CASE WHEN sub=2 THEN data14 ELSE 0 END) AS stlplus_tcd_amt2
					,SUM(CASE WHEN sub=2 THEN data15 ELSE 0 END) AS stlplus_tcd_amt3
					,SUM(CASE WHEN sub=2 THEN data16 ELSE 0 END) AS stlplus_tcd_amt4
					,SUM(CASE WHEN sub=2 THEN data17 ELSE 0 END) AS stlplus_tcd_amt5
					,SUM(CASE WHEN sub=3 THEN data1 ELSE 0 END) AS stlcrdtdsc_tcd_ttl_amt
					,SUM(CASE WHEN sub=3 THEN data2 ELSE 0 END) AS rbt_tcd_ttl_amt
					,SUM(CASE WHEN sub=3 THEN data3 ELSE 0 END) AS tax_free_blamt	
					,SUM(CASE WHEN sub=3 THEN data4 ELSE 0 END) AS tax_free_gen_blamt
					,SUM(CASE WHEN sub=3 THEN data5 ELSE 0 END) AS tax_free_amt
					,SUM(CASE WHEN sub=1 AND func_cd = 14 THEN data2 ELSE 0 END) AS cash_tcd_blamt	
					,SUM(CASE WHEN sub=1 AND func_cd = 15 THEN data2 ELSE 0 END) AS cha_tcd_blamt1	
					,SUM(CASE WHEN sub=1 AND func_cd = 16 THEN data2 ELSE 0 END) AS cha_tcd_blamt2	
					,SUM(CASE WHEN sub=1 AND func_cd = 17 THEN data2 ELSE 0 END) AS cha_tcd_blamt3	
					,SUM(CASE WHEN sub=1 AND func_cd = 18 THEN data2 ELSE 0 END) AS cha_tcd_blamt4	
					,SUM(CASE WHEN sub=1 AND func_cd = 19 THEN data2 ELSE 0 END) AS cha_tcd_blamt5	
					,SUM(CASE WHEN sub=1 AND func_cd = 20 THEN data2 ELSE 0 END) AS cha_tcd_blamt6	
					,SUM(CASE WHEN sub=1 AND func_cd = 21 THEN data2 ELSE 0 END) AS cha_tcd_blamt7
					,SUM(CASE WHEN sub=1 AND func_cd = 22 THEN data2 ELSE 0 END) AS cha_tcd_blamt8
					,SUM(CASE WHEN sub=1 AND func_cd = 23 THEN data2 ELSE 0 END) AS cha_tcd_blamt9
					,SUM(CASE WHEN sub=1 AND func_cd = 24 THEN data2 ELSE 0 END) AS cha_tcd_blamt10
					,SUM(CASE WHEN sub=1 AND func_cd = 384 THEN data2 ELSE 0 END) AS cha_tcd_blamt11
					,SUM(CASE WHEN sub=1 AND func_cd = 385 THEN data2 ELSE 0 END) AS cha_tcd_blamt12
					,SUM(CASE WHEN sub=1 AND func_cd = 386 THEN data2 ELSE 0 END) AS cha_tcd_blamt13
					,SUM(CASE WHEN sub=1 AND func_cd = 387 THEN data2 ELSE 0 END) AS cha_tcd_blamt14
					,SUM(CASE WHEN sub=1 AND func_cd = 388 THEN data2 ELSE 0 END) AS cha_tcd_blamt15
					,SUM(CASE WHEN sub=1 AND func_cd = 389 THEN data2 ELSE 0 END) AS cha_tcd_blamt16
					,SUM(CASE WHEN sub=1 AND func_cd = 390 THEN data2 ELSE 0 END) AS cha_tcd_blamt17
					,SUM(CASE WHEN sub=1 AND func_cd = 391 THEN data2 ELSE 0 END) AS cha_tcd_blamt18
					,SUM(CASE WHEN sub=1 AND func_cd = 392 THEN data2 ELSE 0 END) AS cha_tcd_blamt19
					,SUM(CASE WHEN sub=1 AND func_cd = 393 THEN data2 ELSE 0 END) AS cha_tcd_blamt20
					,SUM(CASE WHEN sub=1 AND func_cd = 394 THEN data2 ELSE 0 END) AS cha_tcd_blamt21
					,SUM(CASE WHEN sub=1 AND func_cd = 395 THEN data2 ELSE 0 END) AS cha_tcd_blamt22
					,SUM(CASE WHEN sub=1 AND func_cd = 396 THEN data2 ELSE 0 END) AS cha_tcd_blamt23
					,SUM(CASE WHEN sub=1 AND func_cd = 397 THEN data2 ELSE 0 END) AS cha_tcd_blamt24
					,SUM(CASE WHEN sub=1 AND func_cd = 398 THEN data2 ELSE 0 END) AS cha_tcd_blamt25
					,SUM(CASE WHEN sub=1 AND func_cd = 399 THEN data2 ELSE 0 END) AS cha_tcd_blamt26
					,SUM(CASE WHEN sub=1 AND func_cd = 400 THEN data2 ELSE 0 END) AS cha_tcd_blamt27
					,SUM(CASE WHEN sub=1 AND func_cd = 401 THEN data2 ELSE 0 END) AS cha_tcd_blamt28
					,SUM(CASE WHEN sub=1 AND func_cd = 402 THEN data2 ELSE 0 END) AS cha_tcd_blamt29
					,SUM(CASE WHEN sub=1 AND func_cd = 403 THEN data2 ELSE 0 END) AS cha_tcd_blamt30
					,SUM(CASE WHEN sub=1 AND func_cd = 26 THEN data2 ELSE 0 END) AS chk_tcd_blamt1	
					,SUM(CASE WHEN sub=1 AND func_cd = 27 THEN data2 ELSE 0 END) AS chk_tcd_blamt2	
					,SUM(CASE WHEN sub=1 AND func_cd = 28 THEN data2 ELSE 0 END) AS chk_tcd_blamt3	
					,SUM(CASE WHEN sub=1 AND func_cd = 29 THEN data2 ELSE 0 END) AS chk_tcd_blamt4	
					,SUM(CASE WHEN sub=1 AND func_cd = 30 THEN data2 ELSE 0 END) AS chk_tcd_blamt5	

					,SUM(CASE WHEN sub=1 AND func_cd = 14 THEN data3 ELSE 0 END) AS cash_tcdamt	
					,SUM(CASE WHEN sub=1 AND func_cd = 15 THEN data3 ELSE 0 END) AS cha_tcdamt1	
					,SUM(CASE WHEN sub=1 AND func_cd = 16 THEN data3 ELSE 0 END) AS cha_tcdamt2	
					,SUM(CASE WHEN sub=1 AND func_cd = 17 THEN data3 ELSE 0 END) AS cha_tcdamt3	
					,SUM(CASE WHEN sub=1 AND func_cd = 18 THEN data3 ELSE 0 END) AS cha_tcdamt4	
					,SUM(CASE WHEN sub=1 AND func_cd = 19 THEN data3 ELSE 0 END) AS cha_tcdamt5	
					,SUM(CASE WHEN sub=1 AND func_cd = 20 THEN data3 ELSE 0 END) AS cha_tcdamt6	
					,SUM(CASE WHEN sub=1 AND func_cd = 21 THEN data3 ELSE 0 END) AS cha_tcdamt7
					,SUM(CASE WHEN sub=1 AND func_cd = 22 THEN data3 ELSE 0 END) AS cha_tcdamt8
					,SUM(CASE WHEN sub=1 AND func_cd = 23 THEN data3 ELSE 0 END) AS cha_tcdamt9
					,SUM(CASE WHEN sub=1 AND func_cd = 24 THEN data3 ELSE 0 END) AS cha_tcdamt10
					,SUM(CASE WHEN sub=1 AND func_cd = 384 THEN data3 ELSE 0 END) AS cha_tcdamt11
					,SUM(CASE WHEN sub=1 AND func_cd = 385 THEN data3 ELSE 0 END) AS cha_tcdamt12
					,SUM(CASE WHEN sub=1 AND func_cd = 386 THEN data3 ELSE 0 END) AS cha_tcdamt13
					,SUM(CASE WHEN sub=1 AND func_cd = 387 THEN data3 ELSE 0 END) AS cha_tcdamt14
					,SUM(CASE WHEN sub=1 AND func_cd = 388 THEN data3 ELSE 0 END) AS cha_tcdamt15
					,SUM(CASE WHEN sub=1 AND func_cd = 389 THEN data3 ELSE 0 END) AS cha_tcdamt16
					,SUM(CASE WHEN sub=1 AND func_cd = 390 THEN data3 ELSE 0 END) AS cha_tcdamt17
					,SUM(CASE WHEN sub=1 AND func_cd = 391 THEN data3 ELSE 0 END) AS cha_tcdamt18
					,SUM(CASE WHEN sub=1 AND func_cd = 392 THEN data3 ELSE 0 END) AS cha_tcdamt19
					,SUM(CASE WHEN sub=1 AND func_cd = 393 THEN data3 ELSE 0 END) AS cha_tcdamt20
					,SUM(CASE WHEN sub=1 AND func_cd = 394 THEN data3 ELSE 0 END) AS cha_tcdamt21
					,SUM(CASE WHEN sub=1 AND func_cd = 395 THEN data3 ELSE 0 END) AS cha_tcdamt22
					,SUM(CASE WHEN sub=1 AND func_cd = 396 THEN data3 ELSE 0 END) AS cha_tcdamt23
					,SUM(CASE WHEN sub=1 AND func_cd = 397 THEN data3 ELSE 0 END) AS cha_tcdamt24
					,SUM(CASE WHEN sub=1 AND func_cd = 398 THEN data3 ELSE 0 END) AS cha_tcdamt25
					,SUM(CASE WHEN sub=1 AND func_cd = 399 THEN data3 ELSE 0 END) AS cha_tcdamt26
					,SUM(CASE WHEN sub=1 AND func_cd = 400 THEN data3 ELSE 0 END) AS cha_tcdamt27
					,SUM(CASE WHEN sub=1 AND func_cd = 401 THEN data3 ELSE 0 END) AS cha_tcdamt28
					,SUM(CASE WHEN sub=1 AND func_cd = 402 THEN data3 ELSE 0 END) AS cha_tcdamt29
					,SUM(CASE WHEN sub=1 AND func_cd = 403 THEN data3 ELSE 0 END) AS cha_tcdamt30
					,SUM(CASE WHEN sub=1 AND func_cd = 26 THEN data3 ELSE 0 END) AS chk_tcdamt1	
					,SUM(CASE WHEN sub=1 AND func_cd = 27 THEN data3 ELSE 0 END) AS chk_tcdamt2	
					,SUM(CASE WHEN sub=1 AND func_cd = 28 THEN data3 ELSE 0 END) AS chk_tcdamt3	
					,SUM(CASE WHEN sub=1 AND func_cd = 29 THEN data3 ELSE 0 END) AS chk_tcdamt4	
					,SUM(CASE WHEN sub=1 AND func_cd = 30 THEN data3 ELSE 0 END) AS chk_tcdamt5	
				FROM
					rdly_tax_deal_hour
				WHERE
					comp_cd = _comp_cd
					AND stre_cd = _stre_cd
					AND sale_date = _sale_date
					AND mode IN (1000, 3000)
				GROUP BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,kind
				ORDER BY
					 stre_cd
					,mac_no
					,chkr_no
					,cshr_no
					,sale_date
					,date_hour
					,kind
					;

			END IF;
		END IF;


		--  その他のテーブル ====================================================================================================
		IF octet_length(_ret_name) = 0 THEN
			_ret_name := 'hqtmp' || _tbl_name;
			IF _set_type = 1 THEN
				EXECUTE 'DROP TABLE IF EXISTS ' || _ret_name ;
			ELSE
				IF _tbl_name LIKE 'rdly_%' THEN
					EXECUTE 'CREATE TEMP TABLE ' || _ret_name || ' AS SELECT * FROM ' ||  _tbl_name || ' 
						WHERE comp_cd = ' || _comp_cd || ' AND stre_cd = ' || _stre_cd || ' AND sale_date =  ' || quote_literal(_sale_date) ;
				ELSE
					EXECUTE 'CREATE TEMP TABLE ' || _ret_name || ' AS SELECT * FROM ' ||  _tbl_name ;
				END IF;

--					|| quote_literal(_total_cnt) || ', tday_cnt=' || quote_literal(_tday_cnt)
--					|| ', last_sellday=' || quote_literal(_endtime) || ' WHERE cust_no=' || quote_literal(_cust_no);

--				CREATE TEMP TABLE _ret_name  AS SELECT * FROM _tbl_name WHERE comp_cd = _comp_cd AND stre_cd = _stre_cd AND sale_date = _sale_date ORDER BY _ordr_flrd;
			END IF;
		END IF;

		RETURN _ret_name;
	END
$FUNC$ LANGUAGE plpgsql;
--	END;
--' LANGUAGE 'plpgsql';


