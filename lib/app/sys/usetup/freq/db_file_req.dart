/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

import 'package:archive/archive.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../webapi/src/webapi.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/environment.dart';
import '../../../inc/apl/compflag.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/lib/cm_sys.dart';
import '../../../inc/lib/db_error.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../inc/sys/tpr_type.dart';
import '../../../lib/apllib/db_comlib.dart';
import '../../../lib/apllib/recog.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import 'db_file_req_define.dart';
import 'package:archive/archive_io.dart';


/// 関連tprxソース: dbFileReq.c
class DbFileReq {

  static const FREQ_DBG = 0;
  static const DEBUG_FILEREQ = 0;

  static int tslnk_err = 0;
  static int	freq_pic_req = 0;


  /// 関連tprxソース: dbFileReq.c - dbCopyTable
  static Future<int> dbCopyTable(TprMID tid,
                String? cpMacno,
                String? copyfrom,
                String? copyto,
                int csrvCnct,
                String? cpCompCd,
                String? cpStreCd,
                String seqName
  ) async {
    DbManipulationPs db = DbManipulationPs();
    Result result;
    RxCommonBuf	pCom;		/* Common Memory */
    int mmSystem = 0;				/* MM System */

    int tsverMrg = 0;
    int srFieldNum = 0;
    int ntuplesNotNull = 0;
    String srTbl = "";			/* 相手のテーブル名 */
    String tprTbl = "";		/* 自分のテーブル名 */
    String tmpTbl = "";		/* テンポラリのテーブル名 */
    String tmpCompCd = "";
    String tmpStreCd = "";
    int ntuples = 0;
    int rtrTyp = 0;
    int serialNo = 0;            		/* serial no */
    String sql;

    // tsvファイル一時格納ディレクトリ
    String tsvDirPath = "${EnvironmentData.TPRX_HOME}temp/";
    // tsvファイルパス
    String tsvFilePath = "";
    // tsvファイル
    late File tsvFile;
    // テーブルカラム数（ダウンロードしたtsvファイルから取得）
    int remoteTableColumnCount = 0;
    int tmpRet = DbError.DB_SUCCESS;
    /*
    char 		sql[1024 + 1];
    char 		*cp_sql;
  //	PGconn *conTP = NULL;
  //	PGconn *conSR = NULL;

    PGresult *srres  = NULL;		/* SR-X Result	   */
    PGresult *tprres = NULL;		/* TPR-X Result	   */
    PGresult *tprres2 = NULL;		/* TPR-X Result	   */

    int		ret = 0;				/* return value	   */
    short 	MacType;				/* machine No. */
    size_t	len;
    short 	mm_system;				/* MM System */
    char 	buf[512];					/* Table Copy Query   */
    int 	counter = 0;				/* sequence table search counter */
    long	serial_no;            		/* serial no */
    RX_COMMON_BUF *pCom;			/* Common Memory */

    int		i;
    char	ini_mac[TPRMAXPATHLEN];
    int		tslnk_timeout;
    //char	key_name[32];			/* key name */
    char	key_name[256];			/* key name */
    struct	stat	freq_stat;
    int				freq_statr = 1;
    char	local_path[TPRMAXPATHLEN];	/* Local Path */
    char	remote_path[TPRMAXPATHLEN];	/* Remote Path */
    char	ftp_path[TPRMAXPATHLEN];	/* Home Dir */
    char	command[CMDNAME_LEN];		/* FTP Command Buffer */
    char	fname[64*2];
    long	ftp_file_size;
    char	stat_buf[TPRMAXPATHLEN];
    int		tsver_mrg;
    char   *HomeDirp;

    char	SrTbl[128];			/* 相手のテーブル名 */
    int		SrFieldNum;			/* 相手のフィールド数 */
    char	SrField[FREQ_SQL_SIZE];		/* 相手のフィールド名（，区切り） */
    char 	TprTbl[128];		/* 自分のテーブル名 */
    char 	TmpTbl[128];		/* テンポラリのテーブル名 */
    int		ntuples;

    char	erlog[512];
    char	ip_buf[512];
    int		TprFieldNum;		/* 自分のフィールド数 */ /* 2013/05/31 */

    char	rollback_fname[TPRMAXPATHLEN];

    char	*pGetMsg;
    int	nGetLine = 0;
    int	nPutLine = 0;

    dbLibCopyParam	cpyParam;	// 2015.12.18 I.Ohno
    CURL		*curl;
    CURLcode	curl_ret;
    char		rd_buf[FREQ_SQL_SIZE+1];
    char		rd_buf_org[FREQ_SQL_SIZE+1];
    char		*rd_buf_enc;
    char		url_buf[FREQ_SQL_SIZE+1];
    char		url_sql[ZHQ_REQ_DATA+1];
    long		res_code =0;
    double		cont_size =0;
    int		zhqreq_cnt =0;
    int		zhqreq_cnt_max =0;
    int		zhqreq_wait_time = 0;
    int		zhqreq_wait_ftp_before_time = 0;
    int		zhqreq_file_cnt =0;
    char		cmd[ZHQ_REQ_DATA+1];
    char			src_name[TPRMAXPATHLEN];
    char			md5_name[TPRMAXPATHLEN];
    FILE			*fp;
    char			tmpbuf[128];
    char			tmpbuf2[128];
    int			net_ret = 0;
    CopyCurlData		CurlData;
    int			curl_ng_retry = 0;
    int			ntuplesNotNull;
    char			NotNullFlg[FREQ_SQL_SIZE];
  #if ZHQ_TS_COOPERATE	// TS側との連携タイミングを計る為のフラグ
    char			tmpCompCd[32];
    char			tmpStreCd[32];
  #endif
    int			rtrTyp = 0;
    */
  /**********************************************************************/
    

    /* パラメータチェック */
    if (cpMacno  == null || cpMacno.isEmpty ||
        (copyfrom  == null) || copyfrom.isEmpty ||
        (copyto    == null) || copyto.isEmpty)
    {

      /***** argument error *****/
      return DbError.DB_ARGERR;
    }

    /* 共通メモリ */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
        return DbError.DB_DATAGETERR;
    }
    pCom = xRet.object;

    if (await dbUpdateChkCustPoint(tid, copyto) != 2) {	/* c_cust_enq_tbl以外 */
      mmSystem = CmCksys.cmMmSystem();
    }
    /* ＴＳバージョン管理 と、フィールド数異なる */
    List<int> zipFile;
    try {
      sql = '''select column_name from information_schema.columns
         where table_name = '$copyto'
         order by ordinal_position asc;''';
      // 取得対象テーブルのカラム一覧を取得
      result = await db.dbCon.execute(sql);
      if (result.isEmpty) {
        return DbError.DB_FILECPYERR;
      } else {
        String columns = result.map((element) => element[0].toString()).toList().join(",");
        TprLog().logAdd(tid, LogLevelDefine.normal, "db_file_req: get tsv data table: $copyto columns $columns");
        zipFile = await WebAPI().getFileRequest(int.parse(cpCompCd!), int.parse(cpStreCd!), copyto, rColumns: columns);
      }
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "$e,$s");
      return DbError.DB_FILECPYERR;
    }
    Directory dir = Directory(tsvDirPath);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    /* ZIPファイル解凍 */
    //　１行目だけ読み捨て（ヘッダ） 10は改行コード
    final archive = ZipDecoder().decodeBytes(zipFile.sublist(zipFile.indexOf(10) + 1));
    // アーカイブ内のファイル／ディレクトリの数だけ繰り返す
    for (final file in archive) {
      // ファイルの場合
      if (file.isFile) {
        // int配列から文字列に変換
        tsvFilePath = "$tsvDirPath${file.name}";
        tsvFile = File(tsvFilePath);

        try{
          remoteTableColumnCount = String.fromCharCodes(file.content.sublist(0, file.content.indexOf(10))).split("\t").length;
          tsvFile.writeAsBytesSync(file.content);
        }catch(e,s){
          TprLog().logAdd(tid, LogLevelDefine.error, "db_file_req: no content data Error $tsvFilePath", errId: -1);
          return DbError.DB_SKIP; /* skip */
        }

        // ディレクトリの場合
      } else {}
    }

    // tsvファイルが格納されていない場合、スキップする
    if (!tsvFile.existsSync()) {
      return DbError.DB_SKIP;
    }

    tsverMrg = await DbComlib.dbComlibChkTsverMrg( tid, remoteTableColumnCount, copyfrom, copyto, csrvCnct);
    if( tsverMrg < 0 )
    {
      TprLog().logAdd(tid, LogLevelDefine.error, "db_file_req: db_comlib_chk_tsver_mrg() Error", errId: -1);
      return DbError.DB_SKIP; /* skip */
    }
    // 自レジのテーブルのフィールドを取得
    srFieldNum = (await DbComlib.dbComlibGetDbFieldName( tid, copyto, false)).$1;
    if( srFieldNum == - 1 ) /* フィールドが取得できなかったので、スキップ */
    {
      return DbError.DB_SKIP; /* skip */
    }

    // 自レジのテーブルの not null フラグを取得
    ntuplesNotNull = (await DbComlib.dbComlibGetDbNotnullFlg(tid, copyto)).$1;
    if (ntuplesNotNull == -1) // フィールドが取得できなかったので、スキップ
    {
      return DbError.DB_SKIP; // skip
    }

    /* テーブル名セット */
    srTbl = copyfrom;
    tprTbl = copyto;
    /* フィールド数が異なる為、テンポラリを作成 */
    if( tsverMrg > 0 )
    {
      tmpTbl = "freq_$tprTbl";
      sql = "SELECT tablename FROM pg_tables WHERE tablename='$tmpTbl';";
      try {
        result = await db.dbCon.execute(sql);
        ntuples = result.length;
      } catch(e) {
        TprLog().logAdd(tid, LogLevelDefine.error, "db_file_req: CREATE TEMP TABLE Error[$tmpTbl]", errId: -1);
        return DbError.DB_TBLCREATEERR;	/* teble create error */
      }
      if( ntuples > 0)
      {
        sql = "TRUNCATE TABLE $tmpTbl;";
        try {
          await db.dbCon.execute(sql);
        } catch(e) {
          TprLog().logAdd(tid, LogLevelDefine.error, "db_file_req: CREATE TEMP TABLE Error[$tmpTbl]", errId: -1);
          return DbError.DB_TBLCREATEERR;	/* teble create error */
        }
      }
      else
      {
        sql = "CREATE TEMP TABLE $tmpTbl( ) inherits ( $tprTbl );";
        try {
          await db.dbCon.execute(sql);
        } catch(e) {
          TprLog().logAdd(tid, LogLevelDefine.error, "db_file_req: CREATE TEMP TABLE Error[$tmpTbl]", errId: -1 );
          return DbError.DB_TBLCREATEERR;	/* teble create error */
        }
              /* マスタをテンポラリにコピー */
        sql = "INSERT INTO $tmpTbl SELECT * FROM $tprTbl;";
        try {
          result = await db.dbCon.execute(sql);
        } catch(e) {
          TprLog().logAdd(tid, LogLevelDefine.error, "db_file_req: ERROR[$sql]", errId: -1);
          return DbError.DB_TBLCREATEERR;	/* teble create error */
        }
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, "db_file_req: FREQ : TPR[$tprTbl] -> TMP[$tmpTbl]  SR[$srTbl] -> TPR[$tprTbl]");
    }

    try {
      await db.dbCon.runTx((txn) async {
        try {
          /* 通常処理の為、自レジの該当Ｔをクリア */
          if(!(( await CmCksys.cmCenterServerSystem() != 0 ) && (( csrvCnct != 0 ) || ( CmCksys.cmMmSystem() == 0 ))))
          {
            /* トランザクションロールバックをするため不要
            //-- TRANCATE(Delete)実行前に、ロールバック用データを出力->エラー発生時にCOPY xx FROM yy コマンドで復旧する
            snprintf( rollback_fname, sizeof(rollback_fname), "%s%s.back", BACKUP_PATH, TprTbl );
            snprintf(sql, sizeof(sql), COPYTO_ROLLBACK, TprTbl, rollback_fname);

            TprLibLogWrite( tid, TPRLOG_NORMAL, 0, sql );

            if((tprres = db_PQexec(tid, DB_ERRLOG, conTP_tbl, sql)) == NULL)
            {
              /***** Cleanup & Disconnect *****/
              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              return(DB_COPYREQUESTERR);
            }
            db_PQclear(tid, tprres);
            tprres = NULL;
            */
            /***** TRUNCATE TABLE for TPR-X *****/
            if(await dbUpdateChkCustPoint(tid, copyto) != 2 ) {	/* c_cust_enq_tbl以外 */
              sql = "TRUNCATE $tprTbl";
              try {
                TprLog().logAdd(tid, LogLevelDefine.normal, sql);
                await txn.execute(sql);
              } catch(e) {
                /***** Table Delete Error *****/
                return DbError.DB_TBLDELETEERR;
              }
            } else {
              /***** TRUNCATE TABLE for TPR-X *****/
              sql = "Delete from $tprTbl";
              try {
                TprLog().logAdd(tid, LogLevelDefine.normal, sql);
                await txn.execute(sql);
              } catch(e) {
                /***** Table Delete Error *****/
                return DbError.DB_TBLDELETEERR;
              }
            }
          }
          /* 実績ログの[serial_no]をリセット */
          if(mmSystem != 0)
          {
            if(seqName.isNotEmpty){
              sql = "select setval('$seqName',1);";
              try {
                TprLog().logAdd(tid, LogLevelDefine.normal, sql);
                await txn.execute(sql);
              } catch(e) {
                tmpRet = DbError.DB_TRANSTARTERR;
                rethrow;
              }
            }
          }

          /* トランザクションはすでに開始しているため不要
          if (await dbUpdateChkCustPoint(tid, copyto) != 2) {	/* c_cust_enq_tb以外 */
            TprLog().logAdd(tid, LogLevelDefine.normal, "dbTran() START(conTP_tbl,conSR_tbl)" );
            /* BEGIN */
            ret = dbTran(tid, conTP_tbl, TRANSTART);
            if(ret)
            {
              snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl,TRANSTART) error\n", __FUNCTION__ );
              TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

              dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

              /***** Cleanup & Disconnect *****/
              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              /***** query error *****/
              return(ret);
            }
            /***** TRANZACTION START *****/
            ret = dbTran(tid, conSR_tbl, TRANSTART);
            if(ret)
            {
              snprintf( erlog, sizeof(erlog), "%s(): dbTran(conSR_tbl,TRANSTART) error\n", __FUNCTION__ );
              TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

              dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

              /***** Cleanup & Disconnect *****/
              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              /***** query error *****/
              return(ret);
            }
          }
          */

          /* メモリ確保のため不要
          /* ＳＱＬが膨大なサイズの為、ここで、確保 */
          cp_sql = malloc( FREQ_SQL_SIZE );
          if( cp_sql == NULL ) {
            TprLibLogWrite( tid, TPRLOG_ERROR, -1, __FILE__": malloc Error" );

            ret = dbTran(tid, conTP_tbl, TRANABORT);
            if(ret)
            {
              snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error1\n", __FUNCTION__ );
              TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

              /***** Cleanup & Disconnect *****/
              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              /***** query error *****/
              return(ret);
            }

            dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

            /***** Cleanup & Disconnect *****/
            dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

            /***** COPY Request Error *****/

            return(DB_MALLOCERR); /* malloc error */
          }
          */



          if (CompileFlag.ZHQ_TS_COOPERATE) { // 取得対象の企業コードと店舗コードを書き換え
            if ((cpCompCd != null)
            &&  (cpStreCd != null))
            {
              // 内部変数にコピー
              tmpCompCd = cpCompCd;
              tmpStreCd = cpStreCd;

              // comp_cdがc_comp_mst.rtr_idであった場合の書き換える対象かチェック
              rtrTyp = await dbChkCompcdEqRtrid (tid, copyto);
              if (rtrTyp != 0)
              {
                // c_comp_mstのリテイラーIDと一致するデータを取得する。
                //（取得元に comp_cd=各レジ のデータはない。comp_cd=リテイラーID の1レコードのみ）
                tmpCompCd = pCom.dbComp.rtr_id.toString();
                if(rtrTyp != 3)
                {
                  tmpStreCd = "0";
                }
              }			

              TprLog().logAdd(tid, LogLevelDefine.normal, 
                "dbCopyTable() TARGET [table:$copyto  comp_cd:$tmpCompCd  stre_cd:$tmpStreCd  rtr_id:${pCom.dbComp.rtr_id}]", 
                errId: 1);
            }
          }
          try {
            sql = "COPY $copyto FROM '${tsvFilePath}' CSV DELIMITER E'\t';";
            TprLog().logAdd(tid, LogLevelDefine.normal, tsvFilePath);
            TprLog().logAdd(tid, LogLevelDefine.normal, sql);
            await txn.execute(sql);
          } catch(e) {
            /***** Table Delete Error *****/
            tmpRet = DbError.DB_INSERTERR;
            rethrow;
          }

          // テーブルのコピーが済み次第tsvファイルを削除
          if (tsvFile.existsSync()) {
            try {
              tsvFile.deleteSync();
            } catch (e) {
              TprLog().logAdd(tid, LogLevelDefine.error, "dbCopyTable: tsvFile delete error [${tsvFile.path}] $e");
            }
          }

          // 別サーバーからのセレクトインサート処理
          // 企業コード、店舗コード指定での取得となったため、置き換え不要
          //   memset( ip_buf, 0x0, sizeof(ip_buf));
          //   if(dbFileReq_ShellExecChk(tid, pCom) == 1)	// サーバーIPを使用
          //   {
          //     net_ret = network_lib_get_addr(tid, "ts2100", ip_buf);
          //   }
          //   else
          //   {
          //     net_ret = network_lib_get_addr(tid, IP_NAME_TSWEBSVR, ip_buf);
          //   }
          // //	if( (net_ret == OK) && (memcmp("0.0.0.0", ip_buf, strlen(ip_buf))))
          //   if ((net_ret == OK)
          //   && (memcmp("0.0.0.0", ip_buf, strlen(ip_buf)))
          //   && (cm_mm_system() == 0))
          //   {
          // #if DEBUG_FILEREQ
          // printf("_/_/_/_/ dbCopyTable (ROOT CHECK 001) _/_/_/_/\n" );
          // #endif

          //         /* ＭＳ仕様＋センターサーバー接続仕様で、接続先がセンターサーバー または ＴＳセンターサーバー接続 */
          // //printf("Center Server STEP 1\n");
          //     memset( ini_mac,     0x00, sizeof(ini_mac));

          //     memset( local_path,  0x00, sizeof(local_path));
          //     memset( remote_path, 0x00, sizeof(remote_path));
          //     memset( ftp_path,    0x00, sizeof(ftp_path));
          //     memset( command,     0x00, sizeof(command));
          //     memset( fname,       0x00, sizeof(fname));



          //     memset( SrTbl,  0x00, sizeof(SrTbl)  );
          //     AplLib_Get_MstName( TprTbl, SrTbl, "", PART_TYPE_NORMAL );
          //     memset( rd_buf_org, 0x0, sizeof(rd_buf_org));
          //     memset( url_buf, 0x0, sizeof(url_buf));
          //     memset( url_sql, 0x0, sizeof(url_sql));

          //     memset( &CurlData, 0x00, sizeof(CurlData) );
          //     CurlData.rd_buf		= rd_buf_org;
          //     CurlData.url_buf	= url_buf;
          //     CurlData.rd_buf_size	= sizeof(rd_buf_org);
          //     CurlData.url_buf_size	= sizeof(url_buf);
          // #if ZHQ_TS_COOPERATE
          //     CurlData.comp_cd	= strtol(tmpCompCd, NULL, 10);
          //     CurlData.stre_cd	= strtol(tmpStreCd, NULL, 10);
          // #else
          //     CurlData.comp_cd	= strtol(cp_comp_cd, NULL, 10);
          //     CurlData.stre_cd	= strtol(cp_stre_cd, NULL, 10);
          // #endif
          //     CurlData.mac_no		= strtol(cp_macno, NULL, 10);
          //     CurlData.tblnm		= SrTbl;
          //     CurlData.TprTbl		= TprTbl;
          //     CurlData.curl_sql	= url_sql;
          //     CurlData.curl_sql_size	= sizeof(url_sql);
          //     CurlData.SrField	= SrField;
          //     CurlData.NotNullFlg	= NotNullFlg;

          //     dbCopyTable_ZHQ_Make_Data(tid, &CurlData, conTPRX, pCom);
          //     //dbCopyTable_ZHQ_Make_Data(tid, rd_buf_org, url_buf, atol(cp_comp_cd), atol(cp_stre_cd), atol(cp_macno), SrTbl, TprTbl, conTPRX, url_sql, SrField);

          //     memset( ini_mac, 0, sizeof(ini_mac) );
          //     sprintf( ini_mac, "%s/conf/sys_param.ini", HomeDirp );
          //     memset( command,     0x00, sizeof(command));
          //     if((TprLibGetIni(ini_mac, "tsweb_sh", "retry_count", command) != 0)) {
          //       zhqreq_cnt_max = 50;
          //     }
          //     else {
          //       zhqreq_cnt_max = atoi(command);
          //     }
          //     memset( command,     0x00, sizeof(command));
          //     if((TprLibGetIni(ini_mac, "tsweb_sh", "wait_time", command) != 0)) {
          //       zhqreq_wait_time = 1;
          //     }
          //     else {
          //       zhqreq_wait_time = atoi(command);
          //     }

          //     if((TprLibGetIni(ini_mac, "tsweb_sh", "wait_ftp_beforetime", command) != 0)) {
          //       zhqreq_wait_ftp_before_time = 1;
          //     }
          //     else {
          //       zhqreq_wait_ftp_before_time = atoi(command);
          //     }

          //     memset( command,     0x00, sizeof(command));

          //     for (curl_ng_retry = 0, zhqreq_cnt = 0; zhqreq_cnt < zhqreq_cnt_max; zhqreq_cnt++)
          //     {
          //       /* Http */
          //       curl_global_init(CURL_GLOBAL_ALL);

          //       curl = curl_easy_init();
          //       if(! curl) {
          //         ret = dbTran(tid, conTP_tbl, TRANABORT);
          //         if(ret)
          //         {
          //           snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error4\n", __FUNCTION__ );
          //           TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           /***** query error *****/
          //           return(ret);
          //         }

          //         dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         snprintf( erlog, sizeof(erlog), "%s() : CONNECT ERROR [zhqRequest] RET curl[%d]\n", __FUNCTION__,(short )curl );
          //         TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);

          //         free( cp_sql );
          //         return(DB_ARGERR);
          //       }

          //       curl_easy_setopt(curl, CURLOPT_TIMEOUT                  , 20        );
          // //			curl_easy_setopt(curl, CURLOPT_URL                      , np_params.url        );
          //       curl_easy_setopt(curl, CURLOPT_URL                      , url_buf        );
          //       rd_buf_enc = curl_easy_escape(curl, url_sql, 0);
          //       memset( rd_buf, 0x0, sizeof(rd_buf));
          //       strncat( rd_buf, rd_buf_org, sizeof(rd_buf));

          //       strncat( rd_buf, rd_buf_enc, sizeof(rd_buf));
          //       curl_easy_setopt(curl, CURLOPT_POSTFIELDS               , rd_buf           );
          //       curl_easy_setopt(curl, CURLOPT_NOPROGRESS               , 1                    );
          //       curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION            , &write_data          );
          //       curl_easy_setopt(curl, CURLOPT_USERAGENT                , "libcurl-agent/1.0"  );

          //       curl_ret = curl_easy_perform(curl);

          //       curl_easy_getinfo(curl, CURLINFO_HTTP_CODE              , &res_code            );
          //       curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD, &cont_size           );

          //       curl_free(rd_buf_enc);
          //       curl_easy_cleanup(curl);
          //       curl_global_cleanup();

          //       sprintf(erlog, "(( curl_ret = %d / res_code = %ld / cont_size = %0.0f )) ng_count[%d]\n", curl_ret, res_code, cont_size, curl_ng_retry);
          //       TprLibLogWrite(tid, TPRLOG_NORMAL, 0, erlog);

          //       if(curl_ret != CURLE_OK) {
          //         if (curl_ng_retry)
          //         {
          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error5\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }

          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           snprintf( erlog, sizeof(erlog), "%s() : COMMAND ERROR [zhqRequest] RET curl_ret[%d]\n", __FUNCTION__,(short)curl_ret );
          //           TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);

          //           free( cp_sql );
          //           tslnk_err = 1;
          //           return(DB_TSLNKWEBERR);
          //         }
          //         else
          //         {
          //           curl_ng_retry++;
          //           continue;
          //         }
          //       }

          //     /* Check Response */
          //       if((res_code / 100) == 0) {
          //         if (curl_ng_retry)
          //         {
          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error6\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }

          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           snprintf( erlog, sizeof(erlog), "%s() : COMMAND ERROR [zhqRequest] RET res err1[%d]\n", __FUNCTION__,res_code );
          //           TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);

          //           free( cp_sql );
          //           tslnk_err = 2;
          //           return(DB_TSLNKWEBERR);
          //         }
          //         else
          //         {
          //           curl_ng_retry++;
          //           continue;
          //         }
          //       }

          //       if((res_code / 100) != 2) {
          //         if (curl_ng_retry)
          //         {
          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error7\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }

          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           snprintf( erlog, sizeof(erlog), "%s() : COMMAND ERROR [zhqRequest] RET res err2[%d]\n", __FUNCTION__,res_code );
          //           TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);

          //           free( cp_sql );
          //           tslnk_err = 3;
          //           return(DB_TSLNKWEBERR);
          //         }
          //         else
          //         {
          //           curl_ng_retry++;
          //           continue;
          //         }
          //       }
          //       curl_ng_retry = 0;	/* ここまで来たらOK扱いなので、NGカウントを０クリアする */

          //       if (strncmp( wr_buf, "WAIT", sizeof(wr_buf)) == 0)
          //       {
          //         sleep(zhqreq_wait_time);
          //         continue;	/* リトライする */
          //       }
          //       else if (strncmp( wr_buf, "OK", sizeof(wr_buf)) == 0)
          //       {
          //         sleep(zhqreq_wait_ftp_before_time);
          //         /* ＦＴＰ */
          //         memset( command,     0x00, sizeof(command));
          //         memset( ftp_path,     0x00, sizeof(ftp_path));
          //         memset( local_path,     0x00, sizeof(local_path));
          //         memset( remote_path,     0x00, sizeof(remote_path));

          //         snprintf( ftp_path, sizeof(ftp_path), HomeDirp );
          //         snprintf( local_path, sizeof(local_path), "%s/tmp/", HomeDirp );
          // #if ZHQ_TS_COOPERATE
          //         snprintf( remote_path, sizeof(remote_path), "~/cpy/%09ld_%09ld/", atol(tmpCompCd), atol(tmpStreCd) );
          // #else
          //         snprintf( remote_path, sizeof(remote_path), "~/cpy/%09ld_%09ld/", atol(cp_comp_cd), atol(cp_stre_cd) );
          // #endif

          //         ret = rxFtpOpen( NULL,        /* 参照する.iniファイル名(NULLはconf/sys_param.ini) */
          //             "master",    /* 参照するセクション名(NULLは[server]) */
          //                     /*  以下、Wftp_open() への引数 */
          //             fqhostname,  /* ホスト名(NULL指定不可、文字列長0は自動取得) */
          //             local_path,	 /* ローカルパス(NULLはTPRX_HOMEから取得) */
          //             remote_path, /* リモートパス(NULLはremotepathから取得) */
          //             0,           /* int file_type */
          //             fqusername,  /* ログイン名(NULLはlogin_nameから取得) */
          //             fqpassword,  /* パスワード(NULLはpasswordから取得) */
          //             command,     /* 出力パラメータ(NULL指定不可) */
          //             ftp_path );  /* ホームディレクトリ(NULLは環境変数HOMEから取得) */
          //         if( ret ) {
          //           snprintf( erlog, sizeof(erlog), "%s(): rxFtpOpen() error\n", __FUNCTION__ );
          //           TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error8\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }

          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           free( cp_sql );
          //           return( DB_FTPOPENERR );
          //         }

          //         for( zhqreq_file_cnt = 0; zhqreq_file_cnt < FREQ_ZHQ_CPY_FNAME_NUM_MAX; zhqreq_file_cnt++)
          //         {
          //           memset (fname, 0x0, sizeof(fname));
          //           snprintf( fname, sizeof(fname), ZHQ_COPY_FNAME[zhqreq_file_cnt], SrTbl, atol(cp_macno));

          //           ret = dbFtpCommonExec( tid, __FUNCTION__, fname, command, RXFTP_GET );
          //           if(zhqreq_file_cnt == 0)
          //           {
          //             if(ret != 0)	/* 1回目でerrファイルが取得できない(errファイルがないので正常終了) */
          //             {
          //               snprintf( erlog, sizeof(erlog), "%s(): dbFtpCommonExec(%s) error file notfound OK\n", __FUNCTION__, fname );
          //               TprLibLogWrite( tid, TPRLOG_NORMAL, ret, erlog );
          //               continue;
          //             }
          //             else
          //             {	/* 1回目でerrファイルが取得できた(errファイルがあるので異常終了) */

          //               snprintf( erlog, sizeof(erlog), "%s(): dbFtpCommonExec(%s) error file found NG\n", __FUNCTION__, fname );
          //               TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //               ret = dbTran(tid, conTP_tbl, TRANABORT);
          //               if(ret)
          //               {
          //                 snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error9\n", __FUNCTION__ );
          //                 TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //                 /***** Cleanup & Disconnect *****/
          //                 dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //                 /***** query error *****/
          //                 return(ret);
          //               }

          //               dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //               dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //               remove( fname );
          //               rxFtpClose( ftp_path );		/* FTPクローズ */
          //               free( cp_sql );
          //               return( DB_FTPGETERR );
          //             }
          //           }
          //           else if((ret != 0) && (zhqreq_file_cnt))	/* 2回目以降でファイルが取得できない */
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbFtpCommonExec(%s) error\n", __FUNCTION__, fname );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );
          //             ret = dbTran(tid, conTP_tbl, TRANABORT);
          //             if(ret)
          //             {
          //               snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error10\n", __FUNCTION__ );
          //               TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //               /***** Cleanup & Disconnect *****/
          //               dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //               /***** query error *****/
          //               return(ret);
          //             }


          //             dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //             dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             free( cp_sql );
          //             return( DB_FTPGETERR );
          //           }
          //         }
          //         /* errファイルが取得できない、endファイル/zipファイル/md5ファイルが取得できた場合（正常時） */
          //         rxFtpClose( ftp_path );		/* FTPクローズ */

          //         /* 取得したmd5ファイルの内容を読み込み */
          //         memset (fname, 0x0, sizeof(fname));
          //         snprintf (fname, sizeof(fname), ZHQ_COPY_FNAME[FREQ_ZHQ_CPY_FNAME_NUM_MD5], SrTbl, atol(cp_macno));
          //         memset (src_name, 0x0, sizeof(src_name));
          //         snprintf (src_name, sizeof(src_name), "%s%s", local_path, fname);
          //         if ((fp = fopen (src_name, "r")) == NULL)
          //         {
          //           snprintf (erlog, sizeof(erlog), "%s fopen(%s) error!! [%d]", __FUNCTION__, src_name, errno);
          //           TprLibLogWrite (tid, TPRLOG_ERROR, -1, erlog);
          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error1\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }


          //           /* md5ファイルを削除 */
          //           dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);
          //           free( cp_sql );
          //           return (DB_COPYGETLINEERR);
          //         }
          // #if FREQ_DBG
          //         memset (erlog, 0, sizeof (erlog));
          //         sprintf (erlog, "Freq : %s(MD5 fileOpen success) file",__FUNCTION__);
          //         TprLibLogWrite (tid, TPRLOG_NORMAL, 0, erlog);
          // #endif
          //         memset (tmpbuf, 0x0, sizeof (tmpbuf));
          //         if (fgets (tmpbuf, sizeof (tmpbuf), fp) == NULL)
          //         {
          //           snprintf (erlog, sizeof (erlog), "%s fgets(%s) error!! [%d]", __FUNCTION__, src_name, errno);
          //           TprLibLogWrite (tid, TPRLOG_ERROR, -1, erlog);
          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error11\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }



          //           /* md5ファイルをクローズし削除 */
          //           fclose (fp);
          //           dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);
          //           free( cp_sql );
          //           return (DB_COPYGETLINEERR);
          //         }
          // #if FREQ_DBG
          //         memset (erlog, 0, sizeof (erlog));
          //         sprintf (erlog, "Freq : %s(MD5 fileRead success) file", __FUNCTION__);
          //         TprLibLogWrite (tid, TPRLOG_NORMAL, 0, erlog);
          // #endif

          //         /* 改行コードが入っていたら削除 */
          //         if (tmpbuf[strlen(tmpbuf)-1] == '\n' )
          //         {
          //           tmpbuf[strlen(tmpbuf)-1] = 0;
          //         }


          //         /* md5ファイルをクローズし削除 */
          //         fclose (fp);
          //         remove (src_name);

          //         /* 取得したmd5ファイルの内容と、取得したファイルのmd5値を比較 */
          //         memset (fname, 0x0, sizeof(fname));
          //         snprintf (fname, sizeof(fname), ZHQ_COPY_FNAME[FREQ_ZHQ_CPY_FNAME_NUM_ZIP], SrTbl, atol(cp_macno));
          //         memset (src_name, 0x0, sizeof(src_name));
          //         snprintf (src_name, sizeof(src_name), "%s%s", local_path, fname);
          //         memset (tmpbuf2, 0x0, sizeof (tmpbuf2));
          //         apl_md5get (0, src_name, tmpbuf2, sizeof (tmpbuf2));
          //         if (strcmp (tmpbuf, tmpbuf2) != 0)	// 比較結果がNG
          //         {
          //           snprintf (erlog, sizeof (erlog), "%s(%s) MD5 ValueCheck error!! [%s]!=[%s]",
          //             __FUNCTION__, src_name, tmpbuf, tmpbuf2);
          //           TprLibLogWrite (tid, TPRLOG_ERROR, -1, erlog);

          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error12\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }


          //           dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);
          //           free( cp_sql );
          //           return (DB_FTPGETERR);
          //         }
          // #if FREQ_DBG
          //         memset (erlog, 0, sizeof (erlog) );
          //         sprintf (erlog, "Freq : dbFileReqImpPreset(MD5-Value Check success) file");
          //         TprLibLogWrite (tid, TPRLOG_NORMAL, 0, erlog);
          // #endif

          //         memset (src_name, 0x0, sizeof(src_name));
          //         snprintf (src_name, sizeof(src_name), "%s%s", local_path, fname);
          //         memset (cmd, 0x0, sizeof (cmd) );
          //         snprintf (cmd, sizeof(cmd),  FREQ_ZHQ_COPY_UNPACK, local_path, SrTbl, atol(cp_macno), local_path );
          //         if( AplLibSystemCmd( TPRAID_STR, cmd ))
          //         {

          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error13\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }


          //           dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);
          //           free( cp_sql );
          //           tslnk_err = 4;
          //           return (DB_TSLNKWEBERR);
          //         }

          //         memset (stat_buf, 0x0, sizeof(stat_buf));
          //         snprintf (stat_buf, sizeof(stat_buf), "%s/"FREQ_ZHQ_COPY_FILENAME_CPY, local_path, SrTbl, atol(cp_macno));
          //         */
          //         /* 取込 */
          //         /* 自ＤＢへの取込を実行 */

          //         // COPY tablename (field_list) FROM filename;
          //         snprintf( cp_sql, FREQ_SQL_SIZE, COPYFROM_FIELD, TprTbl, SrField, stat_buf );

          // //printf("SQL[%s]\n", cp_sql );
          //         TprLibLogWrite( tid, TPRLOG_NORMAL, 0, cp_sql );
          //         if((tprres = db_PQexec(tid, DB_ERRLOG, conTP_tbl, cp_sql)) == NULL) {

          //           snprintf( erlog, sizeof(erlog), "%s(): db_PQexec(conTP_tbl, %s) error\n", __FUNCTION__, cp_sql );
          //           TprLibLogWrite( tid, TPRLOG_ERROR, DB_COPYREQUESTERR, erlog );

          //           free( cp_sql );
          //           /***** TRANZACTION ABORT *****/
          //           ret = dbTran(tid, conTP_tbl, TRANABORT);
          //           if(ret)
          //           {
          //             snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error14\n", __FUNCTION__ );
          //             TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //             remove( stat_buf);
          //             dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //             dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //             /***** Cleanup & Disconnect *****/
          //             dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //             /***** query error *****/
          //             return(ret);
          //           }

          //           remove( stat_buf);
          //           dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));

          //           dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           remove( stat_buf );
          //           snprintf( erlog, sizeof(erlog), __FILE__": dbCopyTable() : remove(%s) error", stat_buf );
          //           TprLibLogWrite( tid, TPRLOG_ERROR, -1, erlog );

          //           /***** COPY Request Error *****/
          //           return(DB_COPYREQUESTERR);
          //         }
          //         db_PQclear( tid, tprres );
          //         tprres = NULL;

          //         dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //         remove( stat_buf );
          //         snprintf( erlog, sizeof(erlog), __FILE__": dbCopyTable() : remove(%s)", stat_buf );
          //         TprLibLogWrite( tid, TPRLOG_NORMAL, 0, erlog );

          //         break;
          //       }
          //     }
          //     if (zhqreq_cnt >=  zhqreq_cnt_max)
          //     {

          //       ret = dbTran(tid, conTP_tbl, TRANABORT);
          //       if(ret)
          //       {
          //         snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error15\n", __FUNCTION__ );
          //         TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /***** query error *****/
          //         return(ret);
          //       }



          //       dbCopyTable_ZHQ_Delete_File( SrTbl, atol(cp_macno));
          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);
          //       free( cp_sql );
          //       return(DB_COPYREQUESTERR);
          //     }
          //     */
          //   }
          //   else	/* 通常のデータＣＯＰＹ */
          //   {
          // #if 0
          // //printf("TS STEP 1\n");
          //     memset( sql, 0x00, sizeof(sql));
          //     if(
          //       dbUpdateChkCustPoint(tid, copyto) == 1
          //       && mm_system
          // #if SEGMENT
          //       && pCom->db_regctrl.set_owner_flg == 0
          // #endif
          //       )   /* m_cust_log && MS接続 && マルチセグメントではない */

          //     {

          //       strcpy(sql, "LOCK TABLE m_cust_log;" );
          //       TprLibLogWrite( tid, TPRLOG_NORMAL,0, sql );

          //       #ifdef DEBUG_DBFR
          //       printf("SR-X COPY REQUEST: %s\n", sql);
          //       #endif

          //       /***** COPY Request for SR-X *****/
          //       if((srres = db_PQexec(tid, DB_ERRLOG, conSR_tbl, sql)) == NULL)
          //       {
          //         #ifdef DEBUG_DBFR
          //         printf("error: SR-X COPY REQUEST\n");
          //         printf("SR-X COPYREQUEST: %s", PQerrorMessage(conSR_tbl));
          //         #endif

          //         dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /***** COPY Request Error *****/
          //         return(DB_COPYREQUESTERR);
          //       }
          //       if(srres) db_PQclear(tid, srres);

          //     }


          //     /* 自ＤＢへの取込を実行 */
          //     if( tsver_mrg > 0 )
          //     {
          // #if CENTOS
          //       snprintf( cp_sql, FREQ_SQL_SIZE, COPYFROM2, /*TmpTbl*/TprTbl, SrField ); /* "COPY %s(%s) FROM stdin" */
          // #else
          //       snprintf( cp_sql, FREQ_SQL_SIZE, COPYFROM, /*TmpTbl*/TprTbl ); /* "COPY %s FROM stdin" */
          // #endif
          //     }
          //     else
          //     {
          //       snprintf( cp_sql, FREQ_SQL_SIZE, COPYFROM, TprTbl ); /* "COPY %s FROM stdin" */
          //     }

          //     /***** COPY Request for TPR-X *****/
          // //printf("SQL[%s]\n", cp_sql );
          //     if((tprres = db_PQexec(tid, DB_ERRLOG, conTP_tbl, cp_sql)) == NULL)
          //     {

          //       free( cp_sql );

          //       /***** TRANZACTION ABORT *****/
          //       ret = dbTran(tid, conTP_tbl, TRANABORT);
          //       if(ret)
          //       {

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /***** query error *****/
          //         return(ret);
          //       }

          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //       /***** Cleanup & Disconnect *****/
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //       /***** COPY Request Error *****/
          //       return(DB_COPYREQUESTERR);
          //     }

          // //printf("TS STEP 2\n");

          //     /* 相手ＤＢからの取出しを実行 */
          //     snprintf(sql, sizeof(sql), COPYTO, SrTbl); /* "COPY %s TO stdin" */

          //     /***** COPY Request for SR-X *****/
          // //printf("SQL[%s]\n", sql );
          //     if((srres = db_PQexec(tid, DB_ERRLOG, conSR_tbl, sql)) == NULL)
          //     {

          //       free( cp_sql );

          //       /* last terminater send to TPR-X */
          //       if(db_PQputline(tid, DB_ERRLOG, conTP_tbl, "\\.\n"))
          //       {
          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         return(DB_COPYPUTLINEERR);
          //       }
          //       /* send copy end to TPR-X */
          //       if(db_PQendcopy(tid, DB_ERRLOG, conTP_tbl))
          //       {
          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         return(DB_ENDCOPYERR);
          //       }

          //       /***** TRANZACTION ROLLBACK *****/
          //       ret = dbTran(tid, conTP_tbl, TRANABORT);
          //       if(ret)
          //       {

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /***** query error *****/
          //         return(ret);
          //       }

          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //       /***** Cleanup & Disconnect *****/
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //       /***** COPY Request Error *****/
          //       return(DB_COPYREQUESTERR);
          //     }

          // //printf("TS STEP 3\n");
          //     /******************************/
          //     /* 行があるだけ繰り返す       */
          //     /******************************/
          //     while(1)
          //     {
          //       /* 相手ＤＢから１行取出し */
          //       if(db_PQgetline(tid, DB_ERRLOG, conSR_tbl, copystring, sizeof(copystring)))
          //       {

          //         free( cp_sql );

          //         /* last terminater send to TPR-X */
          //         if(db_PQputline(tid, DB_ERRLOG, conTP_tbl, "\\.\n"))
          //         {
          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           return(DB_COPYPUTLINEERR);
          //         }
          //         /* send copy end to TPR-X */
          //         if(db_PQendcopy(tid, DB_ERRLOG, conTP_tbl))
          //         {
          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           return(DB_ENDCOPYERR);
          //         }

          //         /***** TRANZACTION ROLLBACK *****/
          //         ret = dbTran(tid, conTP_tbl, TRANABORT);
          //         if(ret)
          //         {

          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           /***** query error *****/
          //           return(ret);
          //         }

          //         dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /* getline error */
          //         return(DB_COPYGETLINEERR);
          //       }

          //       strcat(copystring, "\n");

          //       /* 終了か */
          //       if(!strncmp(&copystring[0], "\\.", 2))
          //       {

          //         break;
          //       }

          //       /* 自ＤＢへ１行取込 */
          //       if(db_PQputline(tid, DB_ERRLOG, conTP_tbl, copystring))
          //       {

          //         free( cp_sql );

          //         /* last terminater send to TPR-X */
          //         if(db_PQputline(tid, DB_ERRLOG, conTP_tbl, "\\.\n"))
          //         {
          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           return(DB_COPYPUTLINEERR);
          //         }
          //         /* send copy end to TPR-X */
          //         if(db_PQendcopy(tid, DB_ERRLOG, conTP_tbl))
          //         {
          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           return(DB_ENDCOPYERR);
          //         }

          //         /***** TRANZACTION ROLLBACK *****/
          //         ret = dbTran(tid, conTP_tbl, TRANABORT);
          //         if(ret)
          //         {

          //           /***** Cleanup & Disconnect *****/
          //           dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //           /***** query error *****/
          //           return(ret);
          //         }

          //         dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /* putline error */
          //         return(DB_COPYPUTLINEERR);
          //       }
          //     }

          // //printf("TS STEP 4\n");

          //     /* 相手ＤＢとの同期 */
          //     if(db_PQendcopy(tid, DB_ERRLOG, conSR_tbl))
          //     {

          //       free( cp_sql );

          //       /* last terminater send to TPR-X */
          //       if(db_PQputline(tid, DB_ERRLOG, conTP_tbl, "\\.\n"))
          //       {
          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         return(DB_COPYPUTLINEERR);
          //       }
          //       /* send copy end to TPR-X */
          //       if(db_PQendcopy(tid, DB_ERRLOG, conTP_tbl))
          //       {
          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         return(DB_ENDCOPYERR);
          //       }

          //       /***** TRANZACTION ROLLBACK *****/
          //       ret = dbTran(tid, conTP_tbl, TRANABORT);
          //       if(ret)
          //       {

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /***** query error *****/
          //         return(ret);
          //       }

          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //       /***** Cleanup & Disconnect *****/
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //       /* PQendcopy error */
          //       return(DB_ENDCOPYERR);
          //     }

          // //printf("TS STEP 5\n");

          //     /* 自ＤＢに終了をセット */
          //     if(db_PQputline(tid, DB_ERRLOG, conTP_tbl, "\\.\n"))
          //     {

          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //       /***** Cleanup & Disconnect *****/
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //       free( cp_sql );
          //       /* PQputline error */
          //       return(DB_COPYPUTLINEERR);
          //     }

          // //printf("TS STEP 6\n");

          //     /* 自ＤＢとの同期 */
          //     if(db_PQendcopy(tid, DB_ERRLOG, conTP_tbl))
          //     {

          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

          //       /***** Cleanup & Disconnect *****/
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //       free( cp_sql );
          //       /* PQendcopy error */
          //       return(DB_ENDCOPYERR);
          //     }
          // #endif

          //     memset( SrTbl,  0x00, sizeof(SrTbl)  );
          //     AplLib_Get_MstName( TprTbl, SrTbl, "", PART_TYPE_NORMAL );

          // #if DEBUG_FILEREQ
          // printf("_/_/_/_/ dbCopyTable (TprTbl=%s SrTbl=%s) _/_/_/_/\n", TprTbl, SrTbl );
          // #endif

          // // <---- 2015.12.18 I.Ohno
          //     // dbLibCopyToTbl()へのオプションデータを設定
          //     memset( &cpyParam, 0x00, sizeof(cpyParam) );
          // #if ZHQ_TS_COOPERATE
          //     cpyParam.comp_cd = tmpCompCd;
          //     cpyParam.stre_cd = tmpStreCd;
          // #else
          //     cpyParam.comp_cd = cp_comp_cd;
          //     cpyParam.stre_cd = cp_stre_cd;
          // #endif
          //     cpyParam.sel_sql = SrField;
          // // 2015.12.18 I.ohno ---->

          //     if ( dbLibCopyToTbl_multiple_chk(TprTbl) )
          //     {
          //       ret = dbLibCopyToTbl_multiple( tid, conTP_tbl, conSR_tbl, TprTbl, SrTbl, &cpyParam );
          //     }
          //     else
          //     {
          //       ret = dbLibCopyToTbl( tid, conTP_tbl, conSR_tbl, TprTbl, SrTbl, &cpyParam ); // 2015.12.18 I.Ohno
          //     }
          //     if (ret == NG)
          //     {
          //       ret = dbTran(tid, conTP_tbl, TRANABORT);
          //       if(ret)
          //       {
          //         snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANABORT) error16\n", __FUNCTION__ );
          //         TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

          //         /***** Cleanup & Disconnect *****/
          //         dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //         /***** query error *****/
          //         free( cp_sql );
          //         return(ret);
          //       }

          //       dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);
          //       srres = NULL;
          //       tprres = NULL;
          //       free( cp_sql );
          //       dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

          //       return(DB_COPYPUTLINEERR);
          //     }

          // //printf("STEP 16\n");

          //   }

          /* 実績ログ[serial_no]の最大値をセット */
          if(mmSystem != 0)
          {
            if(seqName.isNotEmpty){
              /* TODO:00015 江原 コピー先テーブルのserial_noカラム最大値（0の場合は1）でシーケンスを更新
              snprintf( sql, sizeof(sql), "select max(serial_no) from %s ;", TprTbl );
        //printf("SQL[%s]\n", sql );
              if((tprres2 = db_PQexec(tid, DB_ERRLOG, conTP_tbl, sql)) == NULL){
                /***** Cleanup & Disconnect *****/
                dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres2);

                /***** Table Delete Error *****/
                return(DB_TRANENDERR);
              }

              /***** Get serial_no *****/
              serial_no = atol( db_PQgetvalue( tid, tprres2, 0, db_PQfnumber( tid, tprres2, "max" ) ));
              if( serial_no == 0 ) {
                serial_no = 1;
              }

              db_PQclear(tid, tprres2);
              tprres2 = NULL;

              snprintf( sql, sizeof(sql), "select setval('%s',%ld);", seq_name, serial_no );
        //printf("SQL[%s]\n", sql );
              if((tprres2 = db_PQexec(tid, DB_ERRLOG, conTP_tbl, sql)) == NULL){

                /***** Cleanup & Disconnect *****/
                dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres2);

                /***** Table Delete Error *****/
                return(DB_TRANENDERR);
              }
              db_PQclear(tid, tprres2);
              tprres2 = NULL;
              */
            }
          }

          /* トランザクションのクローズは明示的な指定は不要
          if(await dbUpdateChkCustPoint(tid, copyto) != 1 ) {	/* m_cust_log以外 */
            TprLibLogWrite( tid, TPRLOG_NORMAL, 0, "dbTran() END(conTP_tbl,conSR_tbl)" );
            /***** TRANZACTION COMMIT *****/
            ret = dbTran(tid, conSR_tbl, TRANEND);
            if(ret)
            {
              snprintf( erlog, sizeof(erlog), "%s(): dbTran(conSR_tbl, TRANEND) error\n", __FUNCTION__ );
              TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

              dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

              /***** Cleanup & Disconnect *****/
              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              /***** query error *****/
              return(ret);
            }

            /***** TRANZACTION COMMIT *****/
            ret = dbTran(tid, conTP_tbl, TRANEND);
            if(ret)
            {
              snprintf( erlog, sizeof(erlog), "%s(): dbTran(conTP_tbl, TRANEND) error\n", __FUNCTION__ );
              TprLibLogWrite( tid, TPRLOG_ERROR, ret, erlog );

              dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

              /***** Cleanup & Disconnect *****/
              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              /***** query error *****/
              return(ret);
            }
          }
          */

          if( tsverMrg > 0 ) {
            /* TODO:00015 江原 置き換えが必要か調査する必要あり
            /* テンポラリの内容をマスタに書き込む */
            ret = db_comlib_chg_tmp2mst( tid, TmpTbl, TprTbl, conTP_tbl, SrFieldNum, SrField, 0, NULL );
            if( ret ) {
              snprintf( erlog, sizeof(erlog), __FILE__": db_comlib_chg_tmp2mst() Error [%s] -> [%s]", TmpTbl, TprTbl );
              TprLibLogWrite( tid, TPRLOG_ERROR, -1, erlog );

              dbRollbackTable(tid, conTP_tbl, TprTbl, rollback_fname);

              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              return( ret );
            }


            /* テンポラリ削除 */
            snprintf( sql, sizeof(sql), "DROP TABLE %s;", TmpTbl );
            if((tprres = db_PQexec(tid, DB_ERRLOG, conTP_tbl, sql)) == NULL)
            {
              snprintf( erlog, sizeof(erlog), __FILE__": DROP TABLE Error[%s]", TmpTbl );
              TprLibLogWrite( tid, TPRLOG_ERROR, -1, erlog );

              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              return(DB_TBLCREATEERR);	/* teble create error */
            }
            db_PQclear(tid, tprres);
            tprres = NULL;


            snprintf( sql, sizeof(sql), "VACUUM %s;", TprTbl );
            if((tprres = db_PQexec(tid, DB_ERRLOG, conTP_tbl, sql)) == NULL) {
              snprintf( erlog, sizeof(erlog), __FILE__": VACUUM Error[%s]", TprTbl );
              TprLibLogWrite( tid, TPRLOG_ERROR, -1, erlog );

              dbCleanUp(tid, &conSR_tbl, &conTP_tbl, &srres, &tprres);

              return(DB_TRANENDERR);	/* END command error */
            }
            db_PQclear(tid, tprres);
            tprres = NULL;
            */
          }
        } catch(e,s) {
          TprLog().logAdd(tid, LogLevelDefine.error, "$e,$s");
          await txn.rollback();
        }
      });
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "dbCopyTable: $e,$s");
      return tmpRet;
    }
    if (await dbUpdateChkCustPoint(tid, copyto) == 2 ) {	/* c_cust_enq_tbl */
      if(CmCksys.cmMmType( ) == CmSys.MacM2 || CmCksys.cmMmType( ) == CmSys.MacM1){
        dbUpdateCustlogMS( tid, cpMacno );
      }
    }

    /* return success */
    return tmpRet;
  }

  /// 関連tprxソース: dbFileReq.c - dbFileReq_dtl
  static Future<int> dbFileReqDtl(
    TprMID fqtid,
    String? fqmacno,
    String? fqcomp_cd,
    String? fqstre_cd,
    String? fqtable,
    String? fqhostname,
    String? fqusername,
    String? fqpassword,
    Object conSRX,
    Object conTPRX,
    int csrv_cnct,
    int freq_ope_mode,
    String seq_name,
    int freq_csrv_cnct_skip,
    int freq_csrc_cust_real_skip,
    String freq_csrv_cnct_key,
    int freq_csrv_del_oth_stre,
    int set_tbl_typ,
    {int? fqcount}
  ) async {
    String fqsql = "";//[256];			/* query string */

    int	i;
    int counter = 0;			/* table search counter */
    int fqret = 0;		  		/* return value */
    int	schctrl_rtn;
    String log = "";//[256];
    RxCommonBuf	pCom;		/* Common Memory */
    int		ret;

  /**********************************************************************/

  if (DEBUG_FILEREQ != 0) {
    print(sprintf("_/_/_/_/ dbFileReq_dtl ([%s][%s][%s][%s][%s][%s][%s][%d][%d] )) _/_/_/_/\n", 
    [
      fqmacno
      , fqcomp_cd
      , fqstre_cd
      , fqtable
      , fqhostname
      , fqusername
      , fqpassword
      , csrv_cnct
      , freq_ope_mode]
    ));
  }
  if (FREQ_DBG != 0) {
    log = sprintf("dbFileReq( [?][%s][%s][%s][%s][%s][%s][%s][?][?][%d] )",
      [
        fqmacno
        , fqcomp_cd
        , fqstre_cd
        , fqtable
        , fqhostname
        , fqusername
        , fqpassword
        , csrv_cnct
      ]
    );
    TprLog().logAdd(fqtid, LogLevelDefine.normal, log);
  }

    tslnk_err = 0;

    /******************************/
    /* argument check			  */
    /******************************/
    if (fqmacno == null || fqmacno.isEmpty ||
      fqtable == null || fqtable.isEmpty)
    {
      log = "dbFileReq() param is ...\n";
      log += "  fqmacno:[${fqmacno ?? 'NULL'}]\n";
      log += "  fqcomp_cd:[${fqcomp_cd ?? 'NULL'}]\n";
      log += "  fqstre_cd:[${fqstre_cd ?? 'NULL'}]\n";
      log += "  fqtable:[${fqtable ?? 'NULL'}]\n";
      log += "  fqhostname:[${fqhostname ?? 'NULL'}]\n";
      log += "  fqusername:[${fqusername ?? 'NULL'}]\n";
      log += "  fqpassword:[${fqpassword ?? 'NULL'}]\n";
      log += "  csrv_cnct:[$csrv_cnct]\n";
      TprLog().logAdd(fqtid, LogLevelDefine.normal, log);



      /***** argument error *****/
      return DbError.DB_ARGERR;
    }


    // 設定テーブル種類 が 画像ファイル の場合
    if (set_tbl_typ == DbFileReqDefine.FREQ_SETTBLTYP_IMFFILE)
    {
      /* 画像取得 1:しない の場合、処理をスキップ */
      if (freq_pic_req != 0) {
        TprLog().logAdd(fqtid, LogLevelDefine.normal,"Freq : dbFileReq() TARGET[$fqtable] SKIP!!");
        return( DbError.DB_SKIP );
      }
    }

    /* センターサーバーへのリクエスト対象外 */
    if (csrv_cnct != 0) {
      if(freq_csrv_cnct_skip == 0){
        TprLog().logAdd(fqtid, LogLevelDefine.normal,"Freq : dbFileReq() TARGET[$fqtable] SKIP!!");
        return DbError.DB_SKIP;
      }
    }

    /***** initialize *****/
    fqsql = "";

    /************************************************************************/
    /* 検索で得られたテーブルのリクエストモードによって処理を分岐			*/
    /************************************************************************/
    TprLog().logAdd(fqtid, LogLevelDefine.normal,"Freq : dbFileReq() TARGET[$fqtable] mode[$freq_ope_mode]");

  if (CompileFlag.ARCS_MBR) {
    if(fqtable == "c_cust_mst" ||
      fqtable == "c_cust_enq_tbl") {
      TprLog().logAdd(fqtid, LogLevelDefine.normal,"Freq : dbFileReq() ARCS_MBR!!" );
      return DbError.DB_SKIP;
    }
  }

    /* 2009/09/25 >>> */
    if( ( await Recog().recogGet( fqtid, RecogLists.RECOG_CUSTREALSVR, RecogTypes.RECOG_GETSYS)).result != RecogValue.RECOG_NO   &&	/* 顧客リアル問合せ仕様 */
        ( await CmCksys.cmCenterServerSystem( ) != 0) ) {	/* センターサーバー接続仕様 */
      if(freq_csrc_cust_real_skip == 0){
        TprLog().logAdd(fqtid, LogLevelDefine.normal, "Freq : dbFileReq() Center Server + Cust Real Server! SKIP" );
        return DbError.DB_SKIP;
      }
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
        return DbError.DB_DATAGETERR;
    }
    pCom = xRet.object;

    /******************************/
    /* selected mode & make query */
    /******************************/
    if(freq_ope_mode == DbFileReqDefine.FQALL || freq_ope_mode == DbFileReqDefine.FQDAILYLOG)
    {

      /***** COPY RECORD DATA SR-X to TPR-X *****/
      fqret = await dbCopyTable(fqtid, fqmacno, fqtable, fqtable, csrv_cnct, fqcomp_cd, fqstre_cd,
                                      seq_name);
      if (fqret != 0) {
        return fqret;
      }

      // 取得が成功した場合, そのテーブルの履歴ログエラーファイルを削除する
      // TODO:00015 江原 AplLib_Proc_HistLog_ResultFile実装待ち
      // if ( AplLib_Proc_HistLog_ResultFile(fqtid, AplLibHistlogResultTyp.APLLIB_HISTLOG_RES_FILE_DELETE, fqtable) == 0 )
      // {
      //   TprLog().logAdd(fqtid, LogLevelDefine.normal, "Freq : dbFileReq() TARGET[$fqtable] histlog result file delete ");
      // }

      /* NEWDAYS >>> */
      if (fqtable == "c_plu_mst") {
        // TODO:00015 江原 AplLib_Proc_HistLog_ResultFile実装待ち
        // dbCopyTable_ND( fqtid, fqmacno, ND_ITEM_NAME, ND_ITEM_NAME, conSRX, conTPRX, csrv_cnct, fqcomp_cd, fqstre_cd, fqhostname, fqusername, fqpassword,
        //                                   seq_name, freq_csrv_cnct_key );
      }
      /* <<< NEWDAYS */

      if (fqtable == "c_memo_mst") {
        // TODO:00015 江原 lib_fb_memo_MemoReadFlgSet実装待ち
        // lib_fb_memo_MemoReadFlgSet( fqtid, conTPRX, pCom );	// 常駐メモ未読フラグセット
      }

      if(fqtable == "c_comp_mst") {
        // リテーラーIDを利用している対象システムかのチェック
        // ※テーブル名"c_acct_mst"はダミーでチェックさせるためで、関数内で戻り値に0以外をかえすものなら何でもよい
        if (await dbChkCompcdEqRtrid(fqtid,"c_acct_mst") != 0)
        {
          // TODO:00015 江原 rmDbFileReqDtRead実装待ち
          //   // 企業マスタを取り込んだ場合は、すぐに共有メモリに反映させる
          //   rmDbFileReqDtRead (fqtid, 1);	// 1:企業マスタの更新
        }
      }

  // #if ZHQ_TS_COOPERATE	// TS側との連携タイミングを計る為のフラグ
      if (CompileFlag.ZHQ_TS_COOPERATE) {
        // ファイルリクエストで更新したテーブルのcomp_cdが c_comp_mst.rtr_idであった場合、自店/自企業コードで書き換える
        // TODO:00015 江原 dbUpdateTable_CompcdEqRtrid実装待ち
        // dbUpdateTable_CompcdEqRtrid (fqtid, fqtable);
      }
  // #endif
      /* *_old テーブルクリア */
      // TODO:00015 江原 dboldTable_clera実装待ち
      // dboldTable_clera(fqtid, fqtable);

      if( fqret == DbError.DB_SUCCESS )
      {
        /** センターサーバー接続仕様 **/
        if (await CmCksys.cmCenterServerSystem() != 0)
        {
          if (DEBUG_FILEREQ != 0) {
            print("_/_/_/_/ dbFileReq_dtl (ROOT CHECK 004) _/_/_/_/\n" );
          }
          /* 他店データを削除 */
          if (CmCksys.cmMmSystem() != 0) {	/* M/S仕様 */
            if (DEBUG_FILEREQ != 0) {
              print("_/_/_/_/ dbFileReq_dtl (ROOT CHECK 005) _/_/_/_/\n" );
            }
            if( csrv_cnct != 0 ) {	/* センターサーバーへ */
              if(freq_csrv_del_oth_stre != 0){
                if (DEBUG_FILEREQ != 0) {
                  print("_/_/_/_/ dbFileReq_dtl (ROOT CHECK 002) _/_/_/_/\n" );
                }
                // TODO:00015 江原 dbDeleteOthStre_MS実装待ち
                // dbDeleteOthStre_MS( fqtid, fqtable, fqstre_cd );
              }
            }
          }
          else {
            if (DEBUG_FILEREQ != 0) {
              print("_/_/_/_/ dbFileReq_dtl (ROOT CHECK 006) _/_/_/_/\n" );
            }
            if(freq_csrv_del_oth_stre != 0){
              if (DEBUG_FILEREQ != 0) {
                print("_/_/_/_/ dbFileReq_dtl (ROOT CHECK 003) _/_/_/_/\n" );
              }
              // TODO:00015 江原 dbDeleteOthStre実装待ち
              // dbDeleteOthStre( fqtid, fqtable, fqstre_cd );
            }
          }
        }
      }

    }
    //else if(dbParam[counter].mode == FQFTP)
    else if(freq_ope_mode == DbFileReqDefine.FQFTP)
    {

      /***** FTP MODE *****/
      // TODO:00015 江原 dbFtpFile実装待ち
      // return(dbFtpFile(fqtid, fqmacno, fqtable, fqhostname, fqusername, fqpassword, csrv_cnct));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQMENTE)
    {

      /***** histlog_cnt MENTE MODE *****/
      // TODO:00015 江原 dbHistlogMente実装待ち
      // return(dbHistlogMente(fqtid, conSRX, conTPRX, csrv_cnct, fqcomp_cd, fqstre_cd));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQSJL)
    {
      if (CmCksys.cmMmSystem() != 0)
      {
        // TODO:00015 江原 dbFtpFile2実装待ち
        // return( dbFtpFile2( fqtid, fqmacno, fqtable, fqhostname, fqusername, fqpassword ) );
      }
    }
    else if(freq_ope_mode == DbFileReqDefine.FQSIMSLOG)
    {
      if (CmCksys.cmMmSystem() != 0)
      {
        // TODO:00015 江原 dbFtpFileSIMSLOG実装待ち
        // return( dbFtpFileSIMSLOG( fqtid, fqmacno, fqtable, fqhostname, fqusername, fqpassword ) );
      }
    }
    else if(freq_ope_mode == DbFileReqDefine.FQCOUNTER)
    {
      // TODO:00015 江原 dbFileReqCounter実装待ち
      // return( dbFileReqCounter( fqtid, conSRX, conTPRX, fqmacno, fqstre_cd ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQIMGPRESET)
    {
      // TODO:00015 江原 dbFileReqImpPreset実装待ち
      // return( dbFileReqImpPreset( fqtid, conSRX, conTPRX, fqhostname, fqusername, fqpassword, csrv_cnct ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQSPFTP)
    {
      // TODO:00015 江原 dbFileReqSPFTP実装待ち
      // return( dbFileReqSPFTP( fqtid, conSRX, conTPRX, fqhostname, fqusername, fqpassword, csrv_cnct) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQSCHCTRL)
    {
      // TODO:00015 江原 create_schctrl実装待ち
      // schctrl_rtn = create_schctrl( fqtid );
      // if( schctrl_rtn == Typ.OK ){
      //   return( DbError.DB_SUCCESS );
      // }
      // else{
      //   return( DbError.DB_MEMERR );
      // }
    }
    else if(freq_ope_mode == DbFileReqDefine.FQMAS)
    {
      if( csrv_cnct != 0 ) {
      // TODO:00015 江原 dbFtpFileLOGO_CSrv実装待ち
        // return( dbFtpFileLOGO_CSrv( fqtid, fqmacno, fqtable, fqhostname, fqusername, fqpassword ) );
      }
      else {
      // TODO:00015 江原 dbFtpFileLOGO_V15実装待ち
        // return( dbFtpFileLOGO_V15( fqtid, fqmacno, fqtable, fqhostname, fqusername, fqpassword ) );
      }
    }
    else if(freq_ope_mode == DbFileReqDefine.FQNETWLPR)
    {
      // TODO:00015 江原 dbFtpFileNETWLPR実装待ち
      // return( dbFtpFileNETWLPR( fqtid, fqmacno, fqtable, fqhostname, fqusername, fqpassword, csrv_cnct ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQBATPRCCHG)
    {

      /***** COPY RECORD DATA SR-X to TPR-X *****/
      fqret = await dbCopyTable(fqtid, fqmacno, fqtable, fqtable, csrv_cnct, fqcomp_cd, fqstre_cd,
                                      seq_name);
      if(fqret != 0){
        return(fqret);
      }

      // TODO:00015 江原 dbBatPrcChg実装待ち
      // fqret = dbBatPrcChg( fqtid );
      if(fqret != 0){
        return(fqret);
      }

    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPCD)
    {
      // TODO:00015 江原 dbFtpFileFTPCD実装待ち
      // return( dbFtpFileFTPCD( fqtid, conSRX, conTPRX, fqhostname, fqusername, fqpassword ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQSELF)
    {
      // TODO:00015 江原 dbFileReqSelf実装待ち
      // return( dbFileReqSelf( fqtid, conSRX, conTPRX, fqhostname, fqusername, fqpassword, fqtable, csrv_cnct ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQMREGBKUP)
    {
      // TODO:00015 江原 dbFtpFileMREGBKUP実装待ち
      // return( dbFtpFileMREGBKUP( fqtid, conTPRX, fqhostname, fqusername, fqpassword, fqtable ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQREPORT)
    {
      /***** COPY RECORD DATA SR-X to TPR-X *****/
      // TODO:00015 江原 dbCopyReport実装待ち
      // fqret = dbCopyReport(fqtid, fqmacno, fqtable, fqtable, conSRX, conTPRX, csrv_cnct);
      if(fqret != 0){
        return(fqret);
      }
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPTUO)
    {
      // TODO:00015 江原 dbFileReqFTPTuo実装待ち
      // return( dbFileReqFTPTuo( fqtid, conSRX, conTPRX, fqhostname, fqusername, fqpassword, fqtable ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQCHANGER)
    {
      // TODO:00015 江原 dbFileReqChanger実装待ち
      // return( dbFileReqChanger( fqtid, conSRX, conTPRX, fqhostname, fqusername, fqpassword, fqtable, csrv_cnct ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPCMLOGO)
    {
      // TODO:00015 江原 dbFtpFileCmLogo実装待ち
      // return( dbFtpFileCmLogo( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPMRDATE)
    {
      // TODO:00015 江原 dbFtpFileMstReadDate実装待ち
      // return( dbFtpFileMstReadDate( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(CompileFlag.SEGMENT && freq_ope_mode == DbFileReqDefine.FQFTPPROMLOGO)
    {
      // TODO:00015 江原 dbFtpFilePromLogo実装待ち
      // return( dbFtpFilePromLogo( fqtid ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQRESERVTBLBKUP)
    {
      // TODO:00015 江原 dbFtpFileReservTblBkup実装待ち
      // return( dbFtpFileReservTblBkup( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPPBCHGCHK)
    {
      // TODO:00015 江原 dbFtpFilePbchgCheck実装待ち
      // return( dbFtpFilePbchgCheck( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPPBCHGBKUP)
    {
      // TODO:00015 江原 dbFtpFileMPbchgLogBkup実装待ち
      // return( dbFtpFileMPbchgLogBkup( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPSPQCSRV)
    {
      // TODO:00015 江原 dbFtpFileSpQcSrvBkup実装待ち
      // return( dbFtpFileSpQcSrvBkup( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPDPS)
    {
      // TODO:00015 江原 dbFtpFileDirectPointSystem実装待ち
      // return(dbFtpFileDirectPointSystem( fqtid, fqhostname, fqusername, fqpassword, fqtable ));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTPQCINI)
    {
      // TODO:00015 江原 dbFtpFileQCashierSystem実装待ち
      // return(dbFtpFileQCashierSystem( fqtid, fqhostname, fqusername, fqpassword, csrv_cnct ) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTP_ANYINIFILE)	// 任意のiniファイル取得
    {
      // TODO:00015 江原 dbFtpAnyIniFileSystem実装待ち
      // return( dbFtpAnyIniFileSystem( fqtid, fqhostname, fqusername, fqpassword, fqtable, csrv_cnct) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTP_HOME_WEB2100)
    {
      // TODO:00015 江原 dbFtpFileHomeWeb2100実装待ち
      // return(dbFtpFileHomeWeb2100(fqtid, fqhostname, fqusername, fqpassword, fqtable) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQTAXCHG)
    {
      // TODO:00015 江原 dbFileReqTaxchg実装待ち
      // return(dbFileReqTaxchg(fqtid, fqhostname, fqusername, fqpassword, fqtable, csrv_cnct) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTP_TPOINTCOUPONBMP)
    {
      // TODO:00015 江原 dbFileReqTpointCouponBmp実装待ち
      // return(dbFileReqTpointCouponBmp(fqtid) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQCOUPONIMG)
    {
      // TODO:00015 江原 dbFileReqCouponImage実装待ち
      // return( dbFileReqCouponImage (fqtid, fqhostname, fqusername, fqpassword) );
    }
    else if(freq_ope_mode == DbFileReqDefine.FQCOLORDSPIMG)
    {
      // TODO:00015 江原 dbFileReqColordspImg実装待ち
      // return( dbFileReqColordspImg( fqtid, fqhostname, fqusername, fqpassword ) );
    }
    else if(CompileFlag.SS_CR2 && freq_ope_mode == DbFileReqDefine.FQFTP_CR2BMP)
    {
      // TODO:00015 江原 dbFileReqCr2Bmp実装待ち
      // return (dbFileReqCr2Bmp( fqtid, fqhostname, fqusername, fqpassword, fqcount ));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTP_WEBAPI)
    {
      // TODO:00015 江原 AplLib_GetWebApi実装待ち
      // return (AplLib_GetWebApi( fqtid ));
    }

    // 特定CR2レシートロゴ更新処理
    else if (CompileFlag.SS_CR2 && freq_ope_mode == DbFileReqDefine.FQRCTLOGO_UPDATE)
    {
      // TODO:00015 江原 dbFileReqCr2LogoUpdate実装待ち
      // return (dbFileReqCr2LogoUpdate( fqtid ));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTP_PASTCOMP)
    {
      // TODO:00015 江原 AplLib_PastCompFile_Freq実装待ち
      // return (AplLib_PastCompFile_Freq (fqtid));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQDPOINTCOUNTER)
    {
      // TODO:00015 江原 dbFileReqdPointCounter実装待ち
      // return( dbFileReqdPointCounter( fqtid, conSRX, conTPRX, fqmacno, fqstre_cd ) );
    }
    // クイック再セットアップ(標準仕様)対応
    else if (CompileFlag.QUICK_0_AND_4_MERGE && freq_ope_mode == DbFileReqDefine.FQFTP_SPEC_BKUP)	// クイック再セットアップ
    {
      // TODO:00015 江原 dbFileReq_SpecBackUp実装待ち
      // return (dbFileReq_SpecBackUp (fqtid));
    }
    else if(freq_ope_mode == DbFileReqDefine.FQFTP_STDPROMBMP)	// Standard Promotion Bmp
    {
      // TODO:00015 江原 dbFileReqStdPromBmp実装待ち
      // return(dbFileReqStdPromBmp(fqtid));
    }
    else
    {

      TprLog().logAdd(fqtid, LogLevelDefine.normal, "Freq : dbFileReq() TARGET[$fqtable] Unknown mode number!![$freq_ope_mode]",
        errId: DbError.DB_PARAMERR);

      /***** parameter error *****/
      return DbError.DB_PARAMERR;
    }

    /***** return success *****/
    return(fqret);
  }

  /// dbUpdate_chk_cust_point() 顧客ポイント違算のテーブルチェック
  /// 関連tprxソース: dbFileReq.c - dbUpdate_chk_cust_point
  static Future<int> dbUpdateChkCustPoint(TprMID tid, String tbl) async {
    if( tid ==  Tpraid.TPRAID_STR ) {
      return 0;
    }
    if( CmCksys.cmMmSystem() == 0 || await CmCksys.cmCenterServerSystem() != 0) {
      return 0;
    }
    if(tbl == "m_cust_log") {
      return 1;
    }
    if(tbl == "c_cust_enq_tbl") {
      return 2;
    }
    return 0;
  }

  
  /// 機能：引数で指定したテーブルが、「comp_cdが c_comp_mst.rtr_idであった場合に自店/自企業コードで書き換え」
  ///     : の対象であるかをチェックする
  /// 戻り値：0:対象外
  /// 　　　：3:comp_cdのみ、stre_cd=自店舗コードのまま
  /// 関連tprxソース: dbFileReq.c - dbUpdate_chk_cust_point
  static Future<int> dbChkCompcdEqRtrid(TprMID tid, String table_name) async {
    if (CmCksys.cmMmType() != CmSys.MacERR)		/* TS接続タイプでない */
    {
      return 0;
    }

    if (await CmCksys.cmDs2GodaiSystem() != 0)	// ゴダイ様仕様は対象外。
    {				// ゴダイ様以外では、TSのデータは企業コード分レコードをもつのではなく、
            // 企業コードにリテイラーIDをもつ1レコードのみ保持するため
      return 0;
    }
    if (await CmCksys.cmWsSystem() != 0)		// WS仕様も対象外 (ゴダイ仕様と同じデータの持ち方のため)
    {
      return 0;
    }

    if (await CmCksys.cmZHQSystem() == 0)	// 全日食様では対象外のもの
    {
      if (table_name == "c_loystre_mst")	// comp,自店舗 
      {
        return 3;
      }
    }

    if (table_name == "c_acct_mst")	// comp,stre
    {
      // comp_cd,stre_cd ありのテーブル
      return 1;
    }
    else if (table_name == "c_cpn_ctrl_mst"
      || table_name == "c_cpnbdy_mst"
      || table_name == "c_loypln_mst"
      || table_name == "c_loyplu_mst"
      || table_name == "c_loytgt_mst"
    ) {
      // comp_cd のみのテーブル
      return 2;
    }

    return 0;
  }
  /// データ吸上時の顧客ポイント違算対応
  /// 関連tprxソース: dbFileReq.c - dbUpdate_chk_cust_point
  /// TODO:00015 江原 定義のみ追加
  static int dbUpdateCustlogMS(TprMID tid, String fqmacno) {
    return 0;
  }

}

/// 関連tprxソース: dbFileReq.c - FREQ_SETTING
class FreqSetting{
	String? tablename;
	String? param;
	int mode;
  FreqSetting(this.tablename, this.param, this.mode);
}
