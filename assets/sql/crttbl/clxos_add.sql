

-- カートごとのキャッシュ情報
-- plu_cd は 商品 or 部門 or 顧客コード
-- rec_flg は 0: 商品 or 部門  1: 顧客
--drop table p_cart_log;
CREATE TABLE IF NOT EXISTS p_cart_log (
   cart_id VARCHAR(100)
  , plu_cd VARCHAR(32)
  , sku_cd VARCHAR(32)
  , rec_flg SMALLINT default 0 not null
  , ins_datetime TIMESTAMP
  , calc_data TEXT
, constraint p_cart_log_PKC primary key (cart_id, plu_cd)
) ;

CREATE INDEX IF NOT EXISTS p_cart_log_idx ON p_cart_log ( rec_flg );

-- CLxOSレジごとのカウンター
CREATE TABLE IF NOT EXISTS  p_regcounter_log (
    comp_cd NUMERIC(9) default 0 not null
  , stre_cd NUMERIC(9) default 0 not null
  , mac_no NUMERIC(9) default 0 not null
  , sale_date TIMESTAMP
  , last_sale_date TIMESTAMP
  , ins_datetime TIMESTAMP
  , upd_datetime TIMESTAMP
  , cnt_json_data JSONB
, constraint p_regcounter_log_PKC primary key (comp_cd, stre_cd, mac_no)
) ;

-- CLxOSレジごとの実績格納ログ
CREATE TABLE IF NOT EXISTS  p_sales_log (
    serial_no NUMERIC(43)
  , cart_id VARCHAR(100)
  , comp_cd NUMERIC(9) default 0 not null
  , stre_cd NUMERIC(9) default 0 not null
  , mac_no NUMERIC(9) default 0 not null
  , sale_date TIMESTAMP
  , receipt_no NUMERIC(4) default 0 not null
  , print_no NUMERIC(4) default 0 not null
  , ope_mode_flg NUMERIC(9) default 0 not null
  , prn_typ SMALLINT default 0 not null
  , decision_flg SMALLINT default 0 not null
  , tran_flg SMALLINT default 0 not null
  , send_flg SMALLINT default 0 not null
  , ttl_valid_flg SMALLINT default 0 not null
  , item_valid_flg SMALLINT default 0 not null
  , ins_datetime TIMESTAMP
  , upd_datetime TIMESTAMP
  , respons_log TEXT
  , request_log TEXT
  , quick_json_data JSONB
  , sale_json_data JSONB
  , sale_json_log JSONB
  , constraint p_sales_log_PKC primary key (serial_no, cart_id)
) ;

CREATE INDEX IF NOT EXISTS p_sales_log_idx ON p_sales_log ( comp_cd, stre_cd, mac_no, sale_date, receipt_no, print_no, ope_mode_flg, prn_typ, decision_flg, tran_flg, send_flg );
