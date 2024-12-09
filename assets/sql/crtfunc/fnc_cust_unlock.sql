/*
 * ファイル名	: fnc_cust_unlock.sql
 * 機能概要	: 顧客累計に対してアンロック制御を行う
 *		:
 *		: 使用方法	SELECT fnc_stdcust_unlock(ope_mode, comp_cd, stre_cd, mac_no, cust_no);
 *		: 戻り値	0: 正常  1: アンロック不可  9: その他のエラー
 *		:
 * 改訂履歴	: T.Ando	2017/11/13	初版
 *		: 
 */
/*
 * (C) 2017 TERAOKA SEIKO CO., LTD./株式会社　寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

CREATE or REPLACE FUNCTION fnc_stdcust_unlock(
	_ope_mode		NUMERIC(4),
	_comp_cd		NUMERIC(9),
	_stre_cd		NUMERIC(9),
	_mac_no			NUMERIC(9),
	_cust_no		VARCHAR(20)
) RETURNS TABLE (sp_status integer) AS
$FUNC$
	DECLARE _sv_comp_cd	NUMERIC(9);
	DECLARE _enq_comp_cd	NUMERIC(9);
	DECLARE _enq_stre_cd	NUMERIC(9);
	DECLARE _enq_mac_no	NUMERIC(9);
	DECLARE _enq_datetime	TIMESTAMP;
	DECLARE _enq_clrtime	integer;
	DECLARE _enq_passed	integer;
BEGIN
	-- mode:2000 訓練
	IF _ope_mode = 2000 THEN
		RETURN QUERY SELECT 0::integer;
	ELSE
		-- 現在ロック中ならエラーで返す
		-- ロックの状態とは
		-- enq_datetimeがNULL以外＆経過時刻を越えていない＆自レジ以外
		-- (自レジ：enq_comp_cd, enq_stre_cd, enq_mac_noが同じ)
		SELECT comp_cd, enq_comp_cd, enq_stre_cd, enq_mac_no, enq_datetime
			INTO _sv_comp_cd, _enq_comp_cd, _enq_stre_cd, _enq_mac_no, _enq_datetime
			FROM s_cust_ttl_tbl WHERE cust_no = _cust_no limit 1;

		IF NOT FOUND THEN
			-- 別企業
			RETURN QUERY SELECT 9::integer;
		ELSE
			IF _sv_comp_cd <> _comp_cd THEN
				RETURN QUERY SELECT 9::integer;
			ELSE
				IF _enq_datetime is NULL THEN
					-- ロック無し
					RETURN QUERY SELECT 0::integer;
				ELSE
					-- ロック状態
					IF _enq_comp_cd = _comp_cd AND _enq_stre_cd = _stre_cd AND _enq_mac_no = _mac_no THEN
						UPDATE s_cust_ttl_tbl SET enq_comp_cd=0, enq_stre_cd=0, enq_mac_no=0, enq_datetime=null
							WHERE cust_no = _cust_no AND comp_cd = _comp_cd;
						RETURN QUERY SELECT 0::integer;
					ELSE
						-- 経過時刻
						_enq_clrtime := (SELECT ctrl_data::integer FROM c_ctrl_mst WHERE comp_cd = _comp_cd AND ctrl_cd = 32);
						_enq_passed := (SELECT EXTRACT(EPOCH FROM clock_timestamp() - _enq_datetime))::integer;

						IF _enq_clrtime IS NULL THEN
							_enq_clrtime := 20;
						END IF;

						IF _enq_passed > _enq_clrtime * 60 THEN
							RETURN QUERY UPDATE s_cust_ttl_tbl
								SET enq_comp_cd=0, enq_stre_cd=0, enq_mac_no=0, enq_datetime=null
								WHERE cust_no = _cust_no AND comp_cd = _comp_cd
								RETURNING 0::integer;
						ELSE
							RETURN QUERY SELECT 1::integer;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
END
$FUNC$ LANGUAGE plpgsql;

