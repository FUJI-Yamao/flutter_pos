/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: dberror.h
class DbError {
  static const DB_SUCCESS = 000;	/* success */
  static const DB_ARGERR = 100; 	/* argument error */
  static const DB_STATERR = 101; 	/* stat error */
  static const DB_MALLOCERR = 102; 	/* malloc error */
  static const DB_FILECPYERR = 103; 	/* file copy error */
  static const DB_FILEDELERR = 104; 	/* file delete error */
  static const DB_FILEEXISTERR = 105; 	/* file exist error */
  static const DB_FILENOTEXISTERR = 106; 	/* file not exist error */
  static const DB_PARAMERR = 107;	/* parameter number error */
  static const DB_SKIP = 108;	/* skip */
  static const DB_SKIP2 = 109;	/* skip2 */
  static const DB_PRAMFLOPNERR = 200; 	/* parameter file open error */
  static const DB_PARAMFLREADERR = 201;	/* parameter file read error */
  static const DB_PARAMFLWRITEERR = 202; 	/* parameter file write error */
  static const DB_OUTFILEOPNERR = 300;	/* output file open error */
  static const DB_OUTFILEREADERR = 301;	/* output file read error */
  static const DB_OUTFILEWRITEERR = 302;	/* output file write error */
  static const DB_CONNECTIONERR = 400;	/* DB connection error */
  static const DB_QUERYERR = 401; 	/* query error */
  static const DB_TBLCREATEERR = 402; 	/* teble create error */
  static const DB_TBLDELETEERR = 403; 	/* table delete error */
  static const DB_INSERTERR = 404; 	/* data insert error */
  static const DB_DELETEERR = 405; 	/* data delete eor */
  static const DB_DATANOTEXIST = 406; 	/* data not exist */
  static const DB_DATAGETERR = 407; 	/* data get error */
  static const DB_FIELDUNMATCH = 408;	/* DB,array unmatch */
  static const DB_TABLENOTFOUND = 409;	/* table not found */
  static const DB_COPYREQUESTERR = 410;	/* copy request error */
  static const DB_COPYGETLINEERR = 411;	/* PQgetline error */
  static const DB_COPYPUTLINEERR = 412;	/* PQputline error */
  static const DB_ENDCOPYERR = 413;	/* PQendcopy error */
  static const DB_TRANSTARTERR = 414;	/* BEGIN command error */
  static const DB_TRANENDERR = 415;	/* END command error */
  static const DB_ROLLBACKERR = 416;	/* ROLLBACK command error */
  static const DB_FTPOPENERR = 417;	/* FTP OPEN COMMAND ERROR */
  static const DB_FTPGETERR = 418;	/* FTP GET COMMAND ERROR */
  static const DB_RENAMEERR = 419;	/* FILE Rename Error */
  static const DB_SALEDATEGETERR = 420;	/* SALE DATE GET ERROR */
  static const DB_MSG_TAXNONFILE = 421;
  static const DB_MSG_TAXNONEREC = 422;
  static const DB_MEMERR = 423;	/* Memory access error */
  static const DB_TSLNKWEBERR = 424; /* tsLnkWeb ERROR */
  static const DB_FTPFILENOTEXIST = 425;	/* FTP ファイル存在しない */
  // #if SS_CR2
  static const DB_RECEIPTLOGO_FILENONE = 426;	/* 特定CR2用 ロゴ更新 対象なし */
  static const DB_RECEIPTLOGO_NG = 427;	/* 特定CR2用 ロゴ更新 失敗 */
  static const DB_RECEIPTLOGO_WAIT = 428;	/* 特定CR2用 ロゴ更新 待ち合わせ中 */
  // #endif
  static const DB_OTHERERR = 500;	/* other */

  /// 関連tprxソース: db.h - DBERR_TXT
  static const DBERR_TXT = '%s/log/dberr.txt';
}
