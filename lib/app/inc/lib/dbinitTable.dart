/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: dbInitTable.h
/// Database Initialize Table Header File

// ignore_for_file: constant_identifier_names

/// *** Query Strings ****
const String QUERY_TRUNCATE = "TRUNCATE %s"; /* Delete All Record */
const String QUERY_TRUNCATE_2 =
    "TRUNCATE %s_%02d"; /* Delete All Record */
const String QUERY_CHECK = "SELECT COUNT(*) FROM %s"; /* Table Check */
const String QUERY_SETVAL =
    "SELECT SETVAL ('%s','1');"; /* Sequence Clean */
const String QUERY_TBL_EXIST =
    "SELECT tablename FROM pg_tables WHERE tablename='%s';"; /* Table Exist Check */
const String QUERY_TRUNCATE_OLD =
    "TRUNCATE %s_old"; /* Delete All Record */
const String QUERY_TBL_EXIST_OLD =
    "SELECT tablename FROM pg_tables WHERE tablename='%s_old';"; /* Table Exist Check */

/***** Log File*****/
const String REGFILE1 = "item_log.normal"; /* Online Backup */
const String REGFILE2 = "item_log.off"; /* Offline Backup */
const String BK_REGFILE = "backup.normal"; /* 実績再集計バックアップファイル*/

/***** Log File Format *****/
const String ONLINE = "item_log%s.normal"; /* Online Backup Log */
const String OFFLINE = "item_log%s.off"; /* Offline Backup Log */

/***** Log File Dir *****/
const String ONLINE_DIR = "/tran_backup/"; /* Online Backup Dir */
const String OFFLINE_DIR =
    "/tran_backup/offline/"; /* Offline Backup Dir */

/***** Bmp File*****/
const String REGFILE3 = "receipt.bmp"; /* Receipt Logo */
const String REGFILE4 = "l_receipt.bmp"; /* L_Receipit Logo */
const String REGFILE5 = "stamp1.bmp"; /* Stamp Logo1 */
const String REGFILE6 = "stamp2.bmp"; /* Stamp Logo2 */
const String REGFILE7 = "stamp3.bmp"; /* Stamp Logo3 */
const String REGFILE8 = "stamp4.bmp"; /* Stamp Logo4 */
const String REGFILE9 = "stamp5.bmp"; /* Stamp Logo5 */
const String REGFILE10 = "anvsrywk.bmp"; /* Anniversary Logo */
const String REGFILE11 = "anvsry01.bmp"; /* Anniversary Logo1 */
const String REGFILE12 = "anvsry02.bmp"; /* Anniversary Logo2 */
const String REGFILE13 = "anvsry03.bmp"; /* Anniversary Logo3 */
const String REGFILE14 = "anvsry04.bmp"; /* Anniversary Logo4 */
const String REGFILE15 = "anvsry05.bmp"; /* Anniversary Logo5 */
const String REGFILE16 = "spltckt.bmp"; /* Ticket Logo */
const String REGFILE17 = "spltti00.bmp"; /* Ticket Logo0 */
const String REGFILE18 = "spltti01.bmp"; /* Ticket Logo1 */
const String REGFILE19 = "spltti02.bmp"; /* Ticket Logo2 */
const String REGFILE20 = "spltti03.bmp"; /* Ticket Logo3 */
const String REGFILE21 = "spltti04.bmp"; /* Ticket Logo4 */
const String REGFILE22 = "spltti05.bmp"; /* Ticket Logo5 */
const String REGFILE23 = "mnytcktwk.bmp"; /* Money Ticket Logo */
const String REGFILE24 = "promtcktwk.bmp"; /* Promotion Ticket Logo */
const String REGFILE25 = "vmctcktwk.bmp"; /* Vismac Ticket Logo */
const String REGFILE26 = "spltti06.bmp"; /* Ticket Logo6 */
const String REGFILE27 = "spltti07.bmp"; /* Ticket Logo7 */
const String REGFILE28 = "spltti08.bmp"; /* Ticket Logo8 */
const String REGFILE29 = "request_drw.bmp"; /* Request Drawer */
const String REGFILE30 = "void_reason.bmp"; /* Void Reason */
const String REGFILE31 = "refund_reason.bmp"; /* Refund Reason */
const String REGFILE32 = "cancel_reason.bmp"; /* Cancel Reason */
const String REGFILE33 =
    "all_refund_reason.bmp"; /* Call Refund Reason */
const String REGFILE34 = "rfm_receipt.bmp"; /* Rfm Receipt Logo */
const String REGFILE35 = "cash_recycle_ctrl"; /* キャッシュリサイクル指示ファイル*/

const String REGFILE36 = "spec"; /* スペック関連 */
const String REGFILE37 = "qcjc"; /* スペック関連(QCJC) */
const String REGFILE38 =
    "jmups_sales_report"; /* Verifone/J-Mups売上レポートファイル*/

const String MASTER_LOGO = "xxxxxx"; /* Top part of master logo file */

/***** Bmp File Dir *****/
const String LOGO_FROM_DIR = "/bmp/"; /* Original Logo File Dir */
const String LOGO_TO_DIR = "/bmp/rct/"; /* Send to Logo File Dir */
//#define	MASTER_LOGO_DIR	"/web21logo/"			/* Master Logo File Dir	*/

const String MASTER_LOGO_DIR =
    "/web21ftp/bmp/"; /* Master Logo File Dir */ /* 2003/03/11 */

/* ***** Credit Log File ****/
const String CRDTLOG = "crdt"; /* Credit log tbl name */
const String CRDTLOGP =
    "/web21ftp/crdt_backup/"; /* Credit log files' directory path */

/***** E-journal File *****/
const String EJOURNAL = "ejnl"; /* Electric journal file */
const String EJOURNAL_DIR = "tmp"; /* Electric journal Dir */
const int EJ_NUM = 3; /* Number of electric journal file */

List<String> ej_tbl = [
  ".euc",
  ".sjl",
  ".utf",
];

/***** SIMS File *****/
const String SIMS_LOG = "sims_log";
const String SIMS_DIR = "tmp/sims";
const String SIMSLOG = "LOG";

/***** customer File *****/
const String CUST_MST = "c_cust_mst";

/***** customer backup dir *****/
const String BACKUP_DIR = "/tmp/cust/";

const String BACKUP_CUST =
    "copy c_cust_mst to '%s%sc_cust_mst%02d%02d%02d%02d%02db.txt' delimiters ',' WITH NULL AS '';";
const String BACKUP_CUST_ENQ =
    "copy c_cust_enq_tbl to '%s%sc_cust_enq_tbl%02d%02d%02d%02d%02db.txt' delimiters ',' WITH NULL AS '';";

/***** HQ *****/
const String HQ_PATH = "/conf/";
const String HQ_PATH_DF = "default/";
const String HQ_FTP = "hqftp";
const String HQ_HIST = "hqhist";
const String HQ_HIST_CT = "hqhist_ct";
const String HQ_HIST_CT2ND = "hqhist_ct2nd";
const String HQHIST_CD_UP = "hqhist_cd_up";
const String HQHIST_CD_DOWN = "hqhist_cd_down";
const String INI_HQ_SET = "ini_hq_set";
const String HQ_INI = ".ini";
const String HQ_INI_DF = ".default";

/***** image  *****/
/* target file */
const String TARGET_IMG_PRESET = "img_preset";
/* file & dir */
const String IMG_PATH = "/web2100/xpm/";

/* netDoA転送用ファイル格納ディレクトリの削除 */
// const String CMD_DELETE_IMG_FTP_DIR = "rmdir /web21ftp/xpm/";
const String CMD_DELETE_IMG_FTP_DIR = "/web21ftp/xpm/";

/* netDoA転送用ファイルの削除 */
// const String CMD_DELETE_IMG_FTP_FILE =
//     "rm -f /web21ftp/xpm/??????_??????????_preset_img_netDoA.tar.gz";
const String CMD_DELETE_IMG_FTP_FILE_DIR = "/web21ftp/xpm/";
const String CMD_DELETE_IMG_FTP_FILE_PTN =
    "^.{6}_.{10}_preset_img_netDoA.tar.gz\$";
// "rm -f /web21ftp/xpm/??????_??????????_preset_img_netDoA.tar.gz";

/* command */
// const String CMD_DELETE_USER = "rm -rf %spresetu*.jpg";
const String CMD_DELETE_USER_PRE = "presetu";
const String CMD_DELETE_USER_EXT = ".jpg";
// const String CMD_DELTE_PACK = "rm -rf /home/web2100/preset_img.tar.gz";
const String CMD_DELTE_PACK = "/home/web2100/preset_img.tar.gz";
const String CMD_DELTE_PACK_X = "/home/web2100/preset_img_xpm.tar.gz";
// "rm -rf /home/web2100/preset_img_xpm.tar.gz";

/***** SPECIFICFTP *****/
const String SPFTP_FTP_CHK = "spcificftp";
const String SPFTP_FTP = "specificftp";

/***** FTP BACKUP *****/
const String FTP_BKUP_PATH = "/hqftp/backup/";
const String CMD_RM_FTP_BKUP = "rm -rf %s%s*";

const String CMD_RM_FTP_BKUP_JNL = "rm -rf %s%sej*"; // "ej*" を削除
const String CMD_RM_FTP_BKUP_TXT =
    "ls %s%s* | grep -v ^%s%sej | xargs rm -r"; // "ej*" 以外を削除

const String TARGET_FTP_BKUP_JNL = "ftp_backup_jnl";
const String TARGET_FTP_BKUP_TXT = "ftp_backup_txt";

const int FTPBACKUP_TYPE_JNL = 1; // 電子ジャーナル
const int FTPBACKUP_TYPE_TXT = 2; // 本部送信/テキストデータ

/**/
const String BATTXT_FILE = "chprice%d.txt";
const String RM_BATTXT_FILE = "rm -f %s%s%s";
const String BATTXT_PATH = "/tmp/";

/* c_trm_mst */
const String CUST_TRM_MST = "c_cust_trm_mst";

const String CUST_TTL_TBL = "s_cust_ttl_tbl";
const String CUST_CPN_TBL = "s_cust_cpn_tbl";
const String CUST_LOY_TBL = "s_cust_loy_tbl";

const String MBRREAL_INI = "mbrreal.ini";
const String MBRREAL_INI_DEFAULT = ".default";
const String MBRREAL_CONF_PATH = "/conf/";
const String MBRREAL_DEFAULT_PATH = "default/";

const String COUNTER = "counter2";
const String TMP_REGS_DATA = "TmpRegsData"; // 登録ﾃﾞｰﾀ用

/* readdata_ret_inf */
const String READDATA_RET_INF = "readdata_ret_inf";
const String REPT_READ_PATH = "/tmp/rept_read/";

/* netwlpr_inf */
const String NETWLPR_INF = "netwlpr_inf";
const String NETWLPR_CONF_PATH = "/conf";
const String NETWLPR_DEFAULT_PATH = "/default";
const String NETWLPR_STAFF_FILE = "/netwlpr_staff";
const String NETWLPR_STAFF_LIST_FILE = "/netwlpr_staff_list";
const String NETWLPR_DEAL_FILE = "/netwlpr_deal";
const String NETWLPR_DEAL_LIST_FILE = "/netwlpr_deal_list";
const String NETWLPR_INI = ".ini";
const String NETWLPR_INI_DEDAULT = ".default";

/* staffopen_inf */
const String STAFFOPEN_MST = "staffopen_inf";
const String STAFFOPEN_CONF_PATH = "/conf";
const String STAFFOPEN_DEFAULT_PATH = "/default";
const String STAFFOPEN_FILE = "/staff";
const String STAFFOPEN_INI = ".ini";
const String STAFFOPEN_INI_DEDAULT = ".default";

/* taxchg_ret_inf */
const String TAXCHG_RET_INF = "taxchg_ret_inf";
const String TAXCHG_READ_PATH = "/tmp/taxchg/";

/* upd_err_inf */
const String UPD_ERR_INF = "upd_err_inf";

/* mobile_file */
const String MOBILE_FILE = "mobile_file";

/* memo */
const String FINIT_MEMO = "memo";

const String MAC_INFO_INI = "mac_info.ini";
const String CSVBKUP_INI = "csvbkup.ini";
const String FJSS_INI = "fjss.ini";
const String SPECIFICFTP_INI = "specificftp.ini";
const String SYS_PARAM_INI = "sys_param.ini";
const String EAT_IN_INI = "eat_in.ini";
const String HQFTP_INI = "hqftp.ini";
const String HQHIST_INI = "hqhist.ini";
const String HQPROD_INI = "hqprod.ini";
const String VERSION_INI = "version.ini";
const String HQ_SET_INI = "hq_set.ini";

/* non_act */
const String NON_ACT = "non_act";

/* MENTE_NG */
const String MENTE_NG = "mente_ng";
const String MSEG_BKUP = "mseg_bkup";
const String MSEG_BKUP_PATH = "tmp/mseg_trm_bkup";

/* 一時ﾌｧｲﾙ */
const String TMP_KCSRCVMK = "KCSRCVMK";
const String TMP_PATH = "/tmp/";

const String DIR_LOG_SSPS = "log/ssps";
// const String DIR_LOG_SSPS_REMOVE = "rm -rf %s/log/ssps";
const String DIR_LOG_SSPS_REMOVE_DIR = "/log/ssps";
const String SELF_MOVE_INFO_INI = "movie_info.ini";
const String SELF_QS_MOVIE_START = "qs_movie_start_dsp.ini";
const String SELF_CONF_PATH = "/conf/";
const String SELF_DEFAULT_PATH = "default/";
const String SELF_INI_DEDAULT = ".default";
const String SELF_CSV_TXT = "ssps_csv_txt";

const String SPQC_SRV_PATH = "/tmp/QRSrv/";
const String SPQC_CLT_PATH = "/tmp/QRClt/";
const String SPQC_TXT = "spqc_txt";

const String QCASHIER_INI = "qcashier.ini";
const String SPEEZA_INI = "speeza.ini";
const String QCSTRDSP_INI = "qc_start_dsp.ini";
const String SPEEZA_COM_INI = "speeza_com.ini";
const String FSELF_CONTENT = "fself_content";
const String F_SELF_CONTENT_INI = "f_self_content.ini";
const String F_SELF_IMG_INI = "f_self_img.ini";
const String WEBAPI_KEY_INI = "webapi_key.ini";

/* CM Logo BMP */
const String TARGET_CMLOGO = "cm_logo";
const String HOME_WEB2100_PATH = "/home/web2100/";
const String CMLOGO_PATH = "/bmp/cmlogo/";
const String CMLOGO_TAR_NAME = "cmlogo.tar.gz";
const String MK_CMLOGO_PATH = "mkdir %s%s";
const String OW_CMLOGO_PATH = "chmod 777 %s%s";
const String CMLOGO_DEFAULT_PATH = "default/";

const String TAR_PASTCOMP = "PASTCOMP";

/* reserve custreal setup */
const String RSV_CUSTREAL_INI = "rsv_custreal.ini";
const String RSV_CUSTREAL_CONF_PATH = "/conf/";
const String RSV_CUSTREAL_DEFAULT_PATH = "default/";
const String RSV_CUSTREAL_INI_DEDAULT = ".default";

/* reserve */
const String TARGET_RESERV = "reserv_ini";
const String RESERV_CONF_PATH = "/conf/";
const String RESERV_PRN_INI = "reserv_prn.ini";

/* center server */
const String TARGET_CSRV_TXT = "csrv_txt";

/* quick reserve setup */
const String SKINICON_INI = "image.ini";
const String SKINICON_CONF_PATH = "/conf/";
const String SKINICON_DEFAULT_PATH = "default/";
const String SKINICON_INI_DEDAULT = ".default";

/* pbchg */
const String TARGET_PBCHG = "pbchg_ini";
const String TARGET_PBCHG_CHECK = "pbchg_check";
const String PBCHG_CONF_PATH = "/conf/";
const String PBCHG_TMP_PATH = "/tmp/";
const String PBCHG_INI = "pbchg.ini";
const String PBCHG_DEFAULT_PATH = "default/";
const String PBCHG_INI_DEDAULT = ".default";
// const String PBCHG_CHK_INF = "pbchg_check_info_*.txt";
const String PBCHG_CHK_INF_PRE = "pbchg_check_info_";
const String PBCHG_CHK_INF_EXT = ".txt";


/* Wiz */
const String WIZ_TARGET_INI = "wiz_ini";
const String WIZ_CNCT_INI = "wiz_cnct.ini";
const String WIZ_CONF_PATH = "/conf/";
const String WIZ_DEFAULT_PATH = "default/";
const String WIZ_INI_DEDAULT = ".default";

const String WIZ_TARGET_TRAN = "wiz_tran";
const String WIZ_TRAN_PATH = "/web21ftp/Wiz/";

/* spec change */
const String TARGET_SPECCHG = "spec_chg";
const String SPECCHG_OLD_PATH = "/tmp/spec_chg/";
const String SPECCHG_SRV_PATH = "/home/web2100/spec_chg/";

/* usbcam */
const String TARGET_CAMAVI = "cam_avi";
const String CMD_RM_CAMAVI_FL =
    "echo %s*.avi %sold/*.avi| xargs /bin/rm -f";

/* auto.ini */
//#define	TARGET_AUTOINI			"auto_ini"
//#define	TARGET_AUTOLOCALINI		"auto_local_ini"
const String AUTO_CONF_PATH = "/conf/";
const String AUTO_DEFAULT_PATH = "default/";
const String AUTO_INI_DEDAULT = ".default";

/* quick data */
const String TARGET_QUICK_MAKE = "quick_make";
const String QUICK_MAKE_PATH = "tmp/quick_make";

/* taxchg_reserve.ini */
const String FINIT_TAXCHG_RESERVE_INI = "taxchg_reserve.ini";
const String FINIT_TAXCHG_RESERVE_INI_TARGET = "taxchg_reserve_ini";

/* 上位接続ﾏｽﾀ予約変更ﾌｧｲﾙ */
const String TARGET_HQ_PLAN_UPDATE = "hq_plan_update";

/* 税率変更日付設定 */
const String FINIT_MM_REPT_TAXCHG = "mm_rept_taxchg.ini";
const String FINIT_MM_REPT_TAXCHG_CONF_PATH = "/conf/";
const String FINIT_MM_REPT_TAXCHG_DEFAULT_PATH = "default/";
const String FINIT_MM_REPT_TAXCHG_DEDAULT = ".default";

/* 登録画面の表示設定 */
const String ADD_PARTS_INI = "add_parts.ini";

/* 設定画面のオプション */
const String SET_OPTION_INI = "set_option.ini";

/* 抽選関連 */
const String LOTTERY_INI = "lottery.ini";

/* Tﾎﾟｲﾝﾄ用ﾋﾞｯﾄﾏｯﾌﾟ関連 */
const String TPOINT_BMP = "tpoint_bmp";

/* UPDファイル */
const String FINIT_UPD_FILE = "upd_file";

/* カラー客表メッセージ表示用画像関連 */
const String COLORDSPMSG_IMG = "colordspmsg_img";

/* 特定CR2用ﾋﾞｯﾄﾏｯﾌﾟ関連 */
const String CR2BMP = "cr2_bmp";
const String CR2BMP_INIT_PATH = "/bmp/cr40/";

/* 15インチカラー客表関連 */
const String COLORFIP15_INI = "colorfip15.ini";

/* ｵｰﾊﾞｰﾌﾛｰ庫移動関連 */
const String TARGET_OVERFLOW_MOV = "overflow_mov_txt";
const String OVERFLOW_ORG_PATH = "/tmp/";
const String OVERFLOW_NEW_PATH = "/log/";
const String ACX_OVERFLOW_MOV_FILE = "acx_overflow_mov.txt";

/* ﾌｧｲﾙ初期・ﾘｸｴｽﾄ関連 */
const String TARGET_AFTER_VUP_FREQ_TXT = "after_vup_freq_txt";

/* KPI関連 */
const String EXCEPT_CLS_INI = "except_cls.ini";

/*免税電子化関連 */
const String TAXFREE_RIREK_FILE = "taxfree_data"; /* 免税電子化連携ファイル*/

/* 楽天ポイント関連  */
const String RPOINT_INI = "rpoint.ini";

/* Tポイント関連  */
const String TPOINT_INI = "tpoint.ini";
const String TPOINT_DUMMY_INI = "tpoint_dummy.ini";

/* 標準プロモーションﾋﾞｯﾄﾏｯﾌﾟ関連 */
const String STDPROMBMP = "std_prom";
const String STDPROMBMP_LCL_PATH = "/bmp/std_prom/";

/***** FINIT SRC/DES FILES (freq.h より移動)*****/
const String SYS_DES = "/conf/sys.ini";
const String SYS_SRC = "/conf/default/sys.ini.default";
const String MAC_DES = "/conf/mac_info.ini";
const String MAC_SRC = "/conf/default/mac_info.ini.default";
const String MAC_JCC_DES = "/conf/mac_info_JC_C.ini";
const String MAC_JCC_SRC = "/conf/default/mac_info_JC_C.ini.default";
const String CNT_DES = "/conf/counter.ini";
const String CNT_SRC = "/conf/default/counter.ini.default";
const String CNT_JCC_DES = "/conf/counter_JC_C.ini";
const String CNT_JCC_SRC = "/conf/default/counter_JC_C.ini.default";
const String MUPDCNT_DES = "/conf/mupdate_counter.ini";
const String MUPDCNT_SRC = "/conf/default/mupdate_counter.ini.default";
const String UPDCNT_DES = "/conf/update_counter.ini";
const String UPDCNT_SRC = "/conf/default/update_counter.ini.default";
const String UPS_DES = "/conf/ups.ini";
const String UPS_SRC = "/conf/default/ups.ini.default";
const String HOSTS_DES = "/etc/hosts";
const String HOSTS_SRC = "/conf/default/hosts.default";
const String ETH_DES = "/etc/sysconfig/network-scripts/ifcfg-eth0";
const String ETH_SRC = "/conf/default/ifcfg-eth0.default";
const String NETWORK_DES = "/etc/sysconfig/network";
const String NETWORK_SRC = "/conf/default/network.default";
const String WOL_DES = "/conf/wol.ini";
const String WOL_SRC = "/conf/default/wol.ini.default";
const String MSRCHK_DES = "/conf/msr_chk.ini";
const String MSRCHK_SRC = "/conf/default/msr_chk.ini.default";

const String CNCT_SIO_DES = "/conf/cnct_sio.ini";
const String CNCT_SIO_SRC = "/conf/default/cnct_sio.ini.default";

const String PRINTCAP_DES = "/etc/printcap";
const String PRINTCAP_SRC = "/conf/default/printcap.default";

const String ROUTEETH_DES =
    "/etc/sysconfig/network-scripts/route-eth0";

const String SERVICES_DES = "/etc/services";
const String SERVICES_SRC = "/conf/default/services.default";

const String BARCODEPAY_DES = "/conf/barcode_pay.ini";
const String BARCODEPAY_SRC = "/conf/default/barcode_pay.ini.default";

const String BM_MISS_DEF = "/conf/default/bm_missmach.txt.default";
const String BM_MISS_SRC = "/web21ftp/tmp/bm_missmach.txt";

const String QUICK_SELF_DEF = "/conf/default/quick_self.ini.default";
const String QUICK_SELF_SRC = "/conf/quick_self.ini";

const String QUICK_SELF_EDY_DEF = "/conf/default/quick_self.ini.edy";
const String QUICK_SELF_EDY_SRC = "/conf/quick_self.ini.edy";

const String QUICK_SELF_SUICA_DEF =
    "/conf/default/quick_self.ini.suica";
const String QUICK_SELF_SUICA_SRC = "/conf/quick_self.ini.suica";

const String QUICK_SELF_PASMO_DEF =
    "/conf/default/quick_self.ini.pasmo";
const String QUICK_SELF_PASMO_SRC = "/conf/quick_self.ini.pasmo";

const String OPENVPN_DEF = "/conf/default/openvpn.conf.default";
const String OPENVPN_SRC = "/etc/openvpn/openvpn.conf";

const String SNMP_DEF = "/conf/default/snmpd.conf.default";
const String SNMP_SRC = "/etc/snmp/snmpd.conf";

const String SYSCHK_DEF = "/conf/default/SystemCheck.ini.default";
const String SYSCHK_SRC = "/conf/SystemCheck.ini";

const String ECS_FW_DEF = "/conf/default/ecs_fw.ini.default";
const String ECS_FW_SRC = "/conf/ecs_fw.ini";

const String CMD_RM_HTTPD_DIR = "/etc/rc.d/rc5.d/S95httpd";
const String CMD_RM_RECOGKEY_DIR = "/web21ftp/tmp/";
const String CMD_RM_RECOGKEY_PRE = "recogkey_";
const String CMD_RM_RECOGKEY_EXT = ".txt";
const String CMD_RM_MACADD_DIR = "/web21ftp/tmp/";
const String CMD_RM_MACADD_PRE = "macadd_";
const String CMD_RM_MACADD_EXT = ".txt";
const String CMD_RM_S60LPD_DIR = "/etc/rc.d/rc5.d/S60lpd";

const String SPEC_MMTYPE_TIPE_FROM_S = "/etc/rc.d/init.d/ntpd";
const String SPEC_MMTYPE_TIPE_TO_S = "/etc/rc.d/rc5.d/S99ntpd";

const String SPEC_MMTYPE_TIPE_M_STOP = "stop";
const String SPEC_MMTYPE_TIPE_M = "/etc/rc.d/rc5.d/S99ntpd";
