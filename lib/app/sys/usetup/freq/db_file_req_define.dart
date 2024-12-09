/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: dbFileReq.h
class DbFileReqDefine {
  /***** set_tbl_typ *****/
  static const FREQ_SETTBLTYP_TABLE = 0;	// テーブル
  static const FREQ_SETTBLTYP_SETFILE = 1;	// 設定ファイル
  static const FREQ_SETTBLTYP_IMFFILE = 2;	// 画像ファイル

/***** OPERATION MODE *****/
  static const FQALL = 0;	/* ALL RECORD COPY MODE */
  static const FQMAKETEMP = 1;	/* TEMPORARY MAKEING MODE */
  static const FQFTP = 2;	/* FTP MODE */
  static const FQMENTE = 3;	/* histlog_mst mente mode */
  static const FQSJL = 4;	/* get *.sjl *.euc */			/* 02/04/09 H.Sakamoto */
  static const FQSIMSLOG = 5;	/* get LOG*.* */ 				/* 02/07/17 H.Sakamoto */
  static const FQCOUNTER = 6;	/* receipt or journal No. */	/* 02/08/23 */
  static const FQIMGPRESET = 7;	/* get *.xpm */ 				/* 02/10/03 */
  static const FQSPFTP = 8;	/* FTP MODE 2 */ 				/* 03/03/05 */
  static const FQSCHCTRL = 9;	/* c_schctrl_mst */				/* 03/03/12 */
  static const FQMAS = 10;	/* get logo */
  static const FQNETWLPR = 11;	/* get netwlpr_ini */
  static const FQBATPRCCHG = 12;	/* c_batprcchg_mst */
  static const FQFTPCD = 14;	/* get /pj/tprx/hqftp/backup/.  */
  static const FQMEMO = 15;	/* get /pj/tprx/tmp/FBMemo*  */
  static const FQSELF = 16;	/* get self system file  */
  static const FQMREGBKUP = 17;	/* get m-reg spec file  */
  static const FQREPORT = 18;	/* get c_report_cnt report_cnt_cd==1002 */
  static const FQFTPTUO = 19;	/* get /pj/tprx/tmp/-								*/
  static const FQCHANGER = 20;	/* get changer error_gui_ini & sst1_img file */
  static const FQFTPCMLOGO = 21;	/* get ($TPRX_HOME)/bmp/cmlogo/? */
  static const FQFTPMRDATE = 22;	/* get /web21ftp/file_data/ampm/mst_read/mst_read_date.txt */
  static const FQFTPPROMLOGO = 23;	/* get /web21ftp/bmp/promtcktwk.bmp */
  static const FQRESERVTBLBKUP = 24;	/* get /pj/tprx/tran_bkup/reserv_tbl* */
  static const FQFTPPBCHGCHK = 25;	/* get /pj/tprx/tmp/pbchg_check_info_*.txt */
  static const FQFTPPBCHGBKUP = 27;	/* get /pj/tprx/tran_backup/c_pbchg_log_01[YYYYMMDDhhmmss].txt */
  static const FQFTPSPQCSRV = 28;	/* get /pj/tprx/tmp/QRSrv/.* */
  static const FQFTPDPS = 29;	/* get /pj/tprx/conf/sys_param.ini */
  static const FQFTPQCINI = 30;	/* get /pj/tprx/conf/qcashier.ini */
  static const FQFTP_ANYINIFILE = 31;	/* get /pj/tprx/conf/xxx.ini: 任意のiniファイル */
  static const FQFTP_HOME_WEB2100 = 33;	/* get /home/web2100/ : 任意のファイル */
  static const FQTAXCHG = 34;	/* get /pj/tprx/conf  */
  static const FQFTP_TPOINTCOUPONBMP = 35;	/* get /pj/tprx/bmp/tpoint/  */
  static const FQDAILYLOG = 36;	/* ALL RECORD COPY MODE FOR DAILY LOG  */
  static const FQCOUPONIMG = 37;	/* get coupon image (FTP) */
  static const FQFTP_SPEC_BKUP = 38;	/* get /home/web2100/spec_bkup/ : 全ファイル */
  static const FQCOLORDSPIMG = 40;	/* get colordsp image (FTP) */
  static const FQFTP_CR2BMP = 41;	/* get /pj/tprx/bmp/cr40/  */
  static const FQFTP_WEBAPI = 42;	/* get /pj/tprx/conf/webapi_key.ini (FTP) */
  static const FQRCTLOGO_UPDATE = 43;	/* Update ReceiptLogo (Posstmp01.bmp) */
  static const FQFTP_PASTCOMP = 44;	/* get /pj/tprx/tran_backup/bkcomp_file/ : 全ファイル */
  static const FQDPOINTCOUNTER = 45;	/* dpoint_counter : ｄポイント端末処理通番*/
  static const FQFTP_STDPROMBMP = 46;	/* get /pj/tprx/bmp/std_prom/  */
  static const FQEND = -1;	/* stoper */

}
