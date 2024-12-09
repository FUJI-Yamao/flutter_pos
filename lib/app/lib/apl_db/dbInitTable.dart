/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/cls_conf/add_partsJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/barcode_payJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/bm_missmachJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/cnct_sioJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/mbrrealJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/msr_chkJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/pbchgJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/quick_self_edyJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/quick_self_pasmoJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/quick_self_suicaJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/set_optionJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/staffJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/sysJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/sys_paramJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/systemCheckJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/wolJsonFile.dart';
import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/colorfip15JsonFile.dart';
import '../../common/cls_conf/csvbkupJsonFile.dart';
import '../../common/cls_conf/eat_inJsonFile.dart';
import '../../common/cls_conf/except_clsJsonFile.dart';
import '../../common/cls_conf/f_self_contentJsonFile.dart';
import '../../common/cls_conf/f_self_imgJsonFile.dart';
import '../../common/cls_conf/fjssJsonFile.dart';
import '../../common/cls_conf/hq_setJsonFile.dart';
import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cls_conf/hqftpJsonFile.dart';
import '../../common/cls_conf/hqhistJsonFile.dart';
import '../../common/cls_conf/hqprodJsonFile.dart';
import '../../common/cls_conf/imageJsonFile.dart';
import '../../common/cls_conf/lotteryJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/mm_rept_taxchgJsonFile.dart';
import '../../common/cls_conf/movie_infoJsonFile.dart';
import '../../common/cls_conf/mupdate_counterJsonFile.dart';
import '../../common/cls_conf/qc_start_dspJsonFile.dart';
import '../../common/cls_conf/qcashierJsonFile.dart';
import '../../common/cls_conf/qs_movie_start_dspJsonFile.dart';
import '../../common/cls_conf/quick_selfJsonFile.dart';
import '../../common/cls_conf/rpointJsonFile.dart';
import '../../common/cls_conf/rsv_custrealJsonFile.dart';
import '../../common/cls_conf/specificftpJsonFile.dart';
import '../../common/cls_conf/speezaJsonFile.dart';
import '../../common/cls_conf/speeza_comJsonFile.dart';
import '../../common/cls_conf/taxfreeJsonFile.dart';
import '../../common/cls_conf/taxfree_chgJsonFile.dart';
import '../../common/cls_conf/tpointJsonFile.dart';
import '../../common/cls_conf/tpoint_dummyJsonFile.dart';
import '../../common/cls_conf/update_counterJsonFile.dart';
import '../../common/cls_conf/versionJsonFile.dart';
import '../../common/cls_conf/webapi_keyJsonFile.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_taxfree.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_bkup.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/db_newdays.dart';
import '../../inc/lib/spqc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/lib/db_error.dart';
import '../../inc/lib/dbinitTable.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_sys/cm_getpath.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../apllib/aplLib_bkupLog.dart';
import '../apllib/apllib_other.dart';
import '../apllib/apllib_pastcompfile.dart';
import '../apllib/apllib_speedself.dart';
import '../apllib/apllib_std_add.dart';
import '../apllib/taxfree_comlib.dart';
import '../apllib/upd_util.dart';
import '../apllib/hist_err.dart';
import '../../lib/apllib/mobile_lib.dart';
import '../cm_bkup/bkup.dart';
import '../cm_sys/cm_cksys.dart';

/// 関連tprxソース:dbInitTable.c
class DbInitTable {

  static int  mm_system_flg = 0;		/* 0:Not MM system, 1:MM system */

  int bkupFlg= 0; 
  static int finitDiskFull = 0;
  static int oldstrecd = 0; // ファイル初期化実行前の店舗コード
  static int oldcompcd = 0; // ファイル初期化実行前の企業コード

  List<String> crdtDay = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT"
  ];

  String sysHomeDirp = EnvironmentData().sysHomeDir;

  /// 関連tprxソース:dbInitTable.c - dbInitTable
  Future<int> dbInitTable(
      TprMID tid, String tablename) async {
    DbManipulationPs con = DbManipulationPs();
    if (tablename.isEmpty) {
      // 引数エラー
      return (DbError.DB_ARGERR);
    }

    TprLog()
        .logAdd(tid, LogLevelDefine.normal, 'dbInitTable : target[$tablename]');

    switch (tablename) {
      case CRDTLOG: // CRDTLOG
        // 共有メモリ分岐、pCom設定あり、かつポインタ取得成功
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        RxCommonBuf pCom = xRet.object;
        if (xRet.isValid()) {
          
          int existStatus = 0;
          bool removeFailFlg = false;

          for (int crdtIdx = 0; crdtIdx < 7; crdtIdx++) {
            // ファイル名生成
            final crdtFile = sprintf("%s%06d%06d%s.%s", [
              CRDTLOGP,
              pCom.iniMacInfo.system.shpno,
              (await CompetitionIni.competitionIniGetMacNo(tid)).value,
              crdtDay[crdtIdx],
              CRDTLOG
            ]);

            // ファイル存在確認
            var file = TprxPlatform.getFile(crdtFile);
            FileStat crdtStatr = file.statSync();

            // 無ければカウントアップ、あれば削除
            if (crdtStatr.type == FileSystemEntityType.notFound) {
              existStatus++;
            } else {
              try {
                file.deleteSync(recursive: false);
              } catch (e) {
                // 削除失敗
                removeFailFlg = true;
              }
            }
          }

          if (existStatus == 7) {
            // クレジットログファイルが存在しない場合
            return DbError.DB_FILENOTEXISTERR;
          } else if (removeFailFlg) {
            // クレジットログファイル削除エラー
            return DbError.DB_FILEDELERR;
          }
        } else {
          return DbError.DB_FILEDELERR;
        }
        return DbError.DB_SUCCESS;

      case REGFILE1: //item_log.normal
        String path = '$sysHomeDirp$ONLINE_DIR';
        return dbRemoveFile(tid, path);

      case REGFILE2: //item_log.offline
        String path = '$sysHomeDirp$OFFLINE_DIR';
        return dbRemoveFile(tid, path);

      case REGFILE3:
      case REGFILE4:
      case REGFILE5:
      case REGFILE6:
      case REGFILE7:
      case REGFILE8:
      case REGFILE9:
      case REGFILE10:
      case REGFILE11:
      case REGFILE12:
      case REGFILE13:
      case REGFILE14:
      case REGFILE15:
      case REGFILE16:
      case REGFILE17:
      case REGFILE18:
      case REGFILE19:
      case REGFILE20:
      case REGFILE21:
      case REGFILE22:
      case REGFILE23:
      case REGFILE24:
      case REGFILE25:
      case REGFILE26:
      case REGFILE27:
      case REGFILE28:
      case REGFILE29:
      case REGFILE30:
      case REGFILE31:
      case REGFILE32:
      case REGFILE33:
      case REGFILE34:

        // fm sysHomeDirp/bmp/tablename
        var fm = '$sysHomeDirp$LOGO_FROM_DIR$tablename';
        // to sysHomeDirp/bmp/rct/tablename
        var to = '$sysHomeDirp$LOGO_TO_DIR$tablename';

        if ((await CmCksys.cmPromotionUniqueBmp() != 0) && tablename == REGFILE24) {
          // rm sysHomeDirp/bmp/rct/promtckt*.bmp
          Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$LOGO_TO_DIR');
          if (dirp.existsSync()) {
            List<FileSystemEntity> entities = dirp.listSync();
            Iterable<FileSystemEntity> files = entities.whereType<File>();
            for (FileSystemEntity file in files) {
              if (basename(file.path).startsWith("promtckt") &&
                  basename(file.path).endsWith(".bmp")) {
                file.deleteSync();
              }
            }
          }

          TprLog().logAdd(tid, LogLevelDefine.normal
                      , "rm $sysHomeDirp$LOGO_TO_DIR" "promtckt*.bmp");
        } else {

          // rm sysHomeDirp/bmp/rct/tablename
          File bmpFile = TprxPlatform.getFile(to);
          if (bmpFile.existsSync()) {
            bmpFile.deleteSync();
          }
        }

        // FROM と TO を開き、FROM から TO にコピー
        File file = TprxPlatform.getFile(fm);
        if (file.existsSync()) {
          // FROM が 0 バイトの場合、NG
          if (file.lengthSync() == 0) {
            return DbError.DB_FILECPYERR;
          }
          try {
            file.copySync(to);
          } catch (e) {
            return DbError.DB_OTHERERR;
          }
        } else {
          // FROM が無いのでOK
          return (DbError.DB_SUCCESS);
        }
        return (DbError.DB_SUCCESS);

      case MASTER_LOGO:
        // /web21ftp/bmp/ 配下の xxxxxx を含むファイルを削除
        return (dbRmFileByGrp(MASTER_LOGO_DIR, MASTER_LOGO));

      case EJOURNAL:
        var path = '$sysHomeDirp$EJOURNAL_DIR';
        var cntSuccess = 0;
        var cntFileNotExitErr = 0;

        for (int i = 0; i < EJ_NUM; i++) {
          int result = dbRmFileByExt(path, ej_tbl[i]);
          switch (result) {
            case DbError.DB_SUCCESS:
              cntSuccess++;
              break;
            case DbError.DB_FILEDELERR:
              break;
            case DbError.DB_FILENOTEXISTERR:
              cntFileNotExitErr++;
              break;
          }
        }
          //１つ以上消せていたら成功
          if (0 < cntSuccess) {
            return( DbError.DB_SUCCESS );
          } else if(EJ_NUM == cntFileNotExitErr){
            return( DbError.DB_FILENOTEXISTERR );
          }
          return( DbError.DB_FILEDELERR );

        case CUST_MST:
        case CUST_TTL_TBL:
        case CUST_CPN_TBL:
        case CUST_LOY_TBL:

		      // バックアップフラグが0の場合
		      if ( bkupFlg == 0 ){
		      	// DBからファイルにバックアップを実行
		      	await Bkup.cmBkupCust( tid, con, BkupKind.BU_INIT );
		      	// バックアップフラグをインクリメント
		      	bkupFlg++;
		      }

        case SIMS_LOG:
        // SysHomeDirp/tmp/sims 配下の simslog を削除
          String path = sprintf("%s/%s",[sysHomeDirp, SIMS_DIR]);
          // dbRmFileByExt2 はファイル名の最初の文字列が指定された拡張子と一致するファイルを削除する
          int result = dbRmFileByExt2(path, SIMSLOG );
          
          return (result);

        case TARGET_IMG_PRESET:
		      // イメージファイル、圧縮ファイルなどを削除
		      int result = dbRmFileImage( );
		      return( result );

        case INI_HQ_SET:
		      // hq_set.ini.default を hq_set.ini にコピー
          int result = dbRmHqIni(tablename);
          return (result);
          
	      // netDoA接続関連
        case HQHIST_CD_DOWN:
        case HQHIST_CD_UP:
          int result = await dbHQCounterInit(tid, tablename);
          return (result);
        
        case SPFTP_FTP_CHK:
          int result = await dbRmSpFtpIni( SPFTP_FTP );
          return (result);
          
	      // FTPBackup : 電子ジャーナル
        case TARGET_FTP_BKUP_JNL:
		      // "ej*" を削除
		      // rm -f /home/web2100/hqftp/backup/ej*
		      int result = dbRmFtpBkup( FTPBACKUP_TYPE_JNL );
          return (result);
        
	      // FTPBackup : 本部送信/テキストデータ
	      // テーブル名によって処理を分岐 ftp_bkup_txt
        case TARGET_FTP_BKUP_TXT:
		      // "ej*"以外 を削除
		      // ls /home/web2100/hqftp/backup/* | grep -v /home/web2100/hqftp/backup/ej | xargs rm -r 
		      int result = dbRmFtpBkup( FTPBACKUP_TYPE_TXT );
          return (result);

	      // テーブル名によって処理を分岐 counter2
        case COUNTER:
         // SysHomeDirp/conf/以下のiniに値を設定
		      // counter.ini
		      // mupdate_counter.ini
		      // update_counter.ini
		      // fjss.ini
		      // specificftp.ini
		      int result = await dbRmCounter();
		      return( result );
          
	      // テーブル名によって処理を分岐 readdata_ret_inf
        case READDATA_RET_INF:
		      // rm -f /home/web2100/tmp/rept_read/*
		      int result = dbRmReptRead();
		      return( result );

	      // テーブル名によって処理を分岐 netwlpr_inf
        case NETWLPR_INF:
		      // SysHomeDirp/conf/netwlpr_staff.ini に SysHomeDirp/conf/default/netwlpr_staff.ini.default をコピー
		      // SysHomeDirp/conf/netwlpr_staff_list.ini に SysHomeDirp/conf/default/netwlpr_staff_list.ini.default をコピー
		      // SysHomeDirp/conf/netwlpr_deal.ini に SysHomeDirp/conf/default/netwlpr_deal.ini.default をコピー
		      // SysHomeDirp/conf/netwlpr_deal_list.ini に SysHomeDirp/conf/default/netwlpr_deal_list.ini.default をコピー
		      int result = dbRmNetwlpr(tid);
		      return( result );

          // テーブル名によって処理を分岐 staffopen_mst
          case STAFFOPEN_MST:
            // SysHomeDirp/conf/staffopen.ini に SysHomeDirp/conf/default/staffopen.ini.default をコピー
            int result = dbRmStaffopen();
            return result;

          // テーブル名によって処理を分岐 taxchg_ret_inf
          case TAXCHG_RET_INF:
            // rm -f /home/web2100/tmp/taxchg/*
            int result = dbRmTaxchg();
            return result;

          // テーブル名によって処理を分岐 upd_err_inf
          case UPD_ERR_INF:
            // エラーログファイルを世代ファイルに移動
            // upd_err.log => Upd_errlog_マシン番号_年月日時分秒.log
            int result = await dbRmUpdErr(tid);
            return result;

          // テーブル名によって処理を分岐 mobile_file
          case MOBILE_FILE:
            // 仮締ファイルをクリアする
            // /bin/rm /home/teraoka/tmp/regs/MOBILE*
            // /bin/rm /home/teraoka/regs/MOBILE*            
            int result = await dbRmMobileFile();
            return result;

          // テーブル名によって処理を分岐 memo
          case FINIT_MEMO:
            // rm -rf SysHomeDirp/tmp/FBMemo*
            // rm -rf SysHomeDirp/tmp/TFBMemo*
            int result = dbRmMemo();
            return result;

          // テーブル名によって処理を分岐
          case VERSION_INI:
            await VersionJsonFile().delete();
            return DbError.DB_SUCCESS;
          case MAC_INFO_INI:
            await Mac_infoJsonFile().delete();
            return DbError.DB_SUCCESS;
          case CSVBKUP_INI:
            await CsvbkupJsonFile().delete();
            return DbError.DB_SUCCESS;
          case FJSS_INI:
            await FjssJsonFile().delete();
            return DbError.DB_SUCCESS;
          case SPECIFICFTP_INI:
            await SpecificftpJsonFile().delete();
            return DbError.DB_SUCCESS;
          case SYS_PARAM_INI:
            await Sys_paramJsonFile().delete();
            return DbError.DB_SUCCESS;
          case EAT_IN_INI:
            await Eat_inJsonFile().delete();
            return DbError.DB_SUCCESS;
          case HQFTP_INI:
            await HqftpJsonFile().delete();
            return DbError.DB_SUCCESS;
          case HQHIST_INI:
            await HqhistJsonFile().delete();
            return DbError.DB_SUCCESS;
          case HQPROD_INI:
            await HqprodJsonFile().delete();
            return DbError.DB_SUCCESS;
          case HQ_SET_INI:
            await Hq_setJsonFile().delete();
            return DbError.DB_SUCCESS;
          // TODO : 存在しないiniファイルのためコメントアウト
          // case FINIT_TAXCHG_RESERVE_INI:
          case 'plan.tar.gz':
            // rm -rf /web21ftp/tmp/tablename
            int result = dbRmMregbkup(tablename);
            return result;

          // テーブル名によって処理を分岐 nonact	
          case NON_ACT:
            // rm -rf SysHomeDirp/tmp/plu/*
            int result = dbRmNonact();
            return result;

          // テーブル名によって処理を分岐 mente_ng
          case MENTE_NG:
            // rm -rf SysHomeDirp/tmp/sims/MENTE_NG.*
            // rm -rf SysHomeDirp/tmp/sims/mseg/SET*
            int result = dbRmMenteNg();
            return result;

          // テーブル名によって処理を分岐 KCSRCVMK
          case TMP_KCSRCVMK:
            // rm -rf SysHomeDirp/tmp/KCSRCVMK.*
            String path = '$sysHomeDirp$TMP_PATH$tablename';
            Directory kcsrcvmkDirectory = TprxPlatform.getDirectory(path);
            if (kcsrcvmkDirectory.existsSync()) {
              kcsrcvmkDirectory.deleteSync(recursive: true);
            }
            return 0;

          // テーブル名によって処理を分岐 log/ssps
          case DIR_LOG_SSPS:
            // rm -rf SysHomeDirp/log/ssps/*
            Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$DIR_LOG_SSPS_REMOVE_DIR');
            if (dirp.existsSync()) {
              for (FileSystemEntity file in dirp.listSync()) {
                file.deleteSync();
              }
            }
    
            return 0;

            
          // テーブル名によって処理を分岐 ssps_csv_txt
          case SELF_CSV_TXT:
            // rm -rf SysHomeDirp/tmp/csv_tran_backup
            File csvTranBackupFile = TprxPlatform.getFile('$sysHomeDirp/tmp/csv_tran_backup');
            if (csvTranBackupFile.existsSync()) {
              csvTranBackupFile.deleteSync();
            }

            // rm -rf SysHomeDirp/tmp/csv_tran_backup/*
            Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/csv_tran_backup');
            if (dirp.existsSync()) {
              for (FileSystemEntity file in dirp.listSync()) {
                file.deleteSync();
              }
            }

            // rm -rf /web21ftp/file_data/ampm/*
            dirp = TprxPlatform.getDirectory('/web21ftp/file_data/ampm');
            if (dirp.existsSync()) {
              for (FileSystemEntity file in dirp.listSync()) {
                file.deleteSync();
                TprLog().logAdd(tid, LogLevelDefine.normal, 'rm -rf ${file.path}');
              }
            }

            // rm -rf /web21ftp/file_data/ampm/mst_read/*
            dirp = TprxPlatform.getDirectory('/web21ftp/file_data/ampm/mst_read');
            if (dirp.existsSync()) {
              for (FileSystemEntity file in dirp.listSync()) {
                file.deleteSync();
                TprLog().logAdd(tid, LogLevelDefine.normal, 'rm -rf ${file.path}');
              }
            }

            // rm -rf SysHomeDirp/tmp/cvs_mst_save
            dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/cvs_mst_save');
            if (dirp.existsSync()) {
              for (FileSystemEntity file in dirp.listSync()) {
                file.deleteSync();
                TprLog().logAdd(tid, LogLevelDefine.normal, 'rm -rf ${file.path}');
              }
            }

            return DbError.DB_SUCCESS;

          // テーブル名によって処理を分岐
          case SELF_MOVE_INFO_INI:
            await Movie_infoJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case SELF_QS_MOVIE_START:
            await Qs_movie_start_dspJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case QCASHIER_INI:
            await QcashierJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case SPEEZA_INI:
            await SpeezaJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case QCSTRDSP_INI:
            await Qc_start_dspJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case SPEEZA_COM_INI:
            await Speeza_comJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case F_SELF_CONTENT_INI:
            await F_self_contentJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case F_SELF_IMG_INI:
            await F_self_imgJsonFile().setDefault();
            return DbError.DB_SUCCESS;
          case WEBAPI_KEY_INI:
            await Webapi_keyJsonFile().setDefault();
            return DbError.DB_SUCCESS;
                  
          // テーブル名によって処理を分岐 c_plu_mst
          case "c_plu_mst":
            // con.exec(DROP TABLE tablename)
            await dbDropTableND(tid, DbNewdays.ND_ITEM_NAME, con);  //@20240620

          // テーブル名によって処理を分岐 cm_logo
          case TARGET_CMLOGO:
            // mkdir SysHomeDirp/bmp/cmlogo/
            // chmod 777 SysHomeDirp/bmp/cmlogo/
            // rm -f SysHomeDirp/bmp/cmlogo/*
            // rm -f /home/web2100/tmp/cmlogo.tar.gz
            // cp SysHomeDirp/bmp/cmlogo/defalut/ SysHomeDirp/bmp/cmlogo/
            return await dbRmCmLogo(tid);

          // テーブル名によって処理を分岐 rsv_custreal_ini
          case RSV_CUSTREAL_INI:
            // cp SysHomeDirp/conf/default/rsv_custreal.ini.default SysHomeDirp/conf/rsv_custreal.ini
            await Rsv_custrealJsonFile().setDefault();
            return DbError.DB_SUCCESS;

          // TODO : 存在しないiniファイルのためコメントアウト
          // // テーブル名によって処理を分岐 reserv_ini
          // case TARGET_RESERV:
          //   // rm -f SysHomeDirp/conf/reserv_prn.ini
          //   return dbRm_Reserv();

          // テーブル名によって処理を分岐 image.ini
          case SKINICON_INI:
            // cp SysHomeDirp/conf/default/image.ini.default SysHomeDirp/conf/image.ini
            await ImageJsonFile().setDefault();
            return DbError.DB_SUCCESS;

          // テーブル名によって処理を分岐 scrv_txt	
          case TARGET_CSRV_TXT:
            // rm -rf /home/web2100/cpy/
            return dbRmCenterServer();

          // テーブル名によって処理を分岐 pbchg
          case TARGET_PBCHG:
            // cp SysHomeDirp/conf/default/pbchg.ini.default SysHomeDirp/conf/pbchg.ini
            await PbchgJsonFile().setDefault();
            return DbError.DB_SUCCESS;

          // テーブル名によって処理を分岐 pbchg_check
          case TARGET_PBCHG_CHECK:
            // rm -f SysHomeDirp/tmp/pbchg_check_info_*.txt
            return dbRmPbchgCheck();

          // TODO : 存在しないiniファイルのためコメントアウト
          // // テーブル名によって処理を分岐 wiz_ini
          // case WIZ_TARGET_INI:
          //   // cp SysHomeDirp/conf/default/wiz_cnct.ini.default SysHomeDirp/conf/wiz_cnct.ini
          //   return dbINIWiz();

          // テーブル名によって処理を分岐 wiz_tran
          case WIZ_TARGET_TRAN:
            // rm -f /web21ftp/Wiz/*
            return dbRmWizTran();

          // テーブル名によって処理を分岐 spqc_txt
          case SPQC_TXT:
            // find SysHomeDirp/tmp -name 'QR*.*' -print|xargs rm

            // 以下のディレクトリを削除
            // 0 :TPRX_HOME/tmp/QRSrv/
            // 1 :TPRX_HOME/tmp/QRSrv/Make/
            // 2 :TPRX_HOME/tmp/QRSrv/Load/
            // 3 :TPRX_HOME/tmp/QRSrv/Edit/
            // 4 :TPRX_HOME/tmp/QRSrv/Tran/
            // 5 :TPRX_HOME/tmp/QRClt/
            // 6 :TPRX_HOME/tmp/QRClt/Make/
            // 7 :TPRX_HOME/tmp/QRClt/Send/
            // 8 :TPRX_HOME/tmp/QRClt/Tran/
            // 9 :TPRX_HOME/tmp/QRClt/Action/
            // 10:TPRX_HOME/tmp/QRSrv/Make
            return dbRmSpqcTxt(tid);

          // テーブル名によって処理を分岐 mbrreal.ini
          case MBRREAL_INI:
            // cp SysHomeDirp/conf/default/mbrreal.ini.default SysHomeDirp/conf/mbrreal.ini
            await MbrrealJsonFile().setDefault();
            return DbError.DB_SUCCESS;

          // テーブル名によって処理を分岐 spec_chg
          case TARGET_SPECCHG:
            // rm -f SysHomeDirp/tmp/spec_chg/*
            // rm -f SysHomeDirp/tmp/spec_chg_old/*
            return dbRmSpecChg();

          // テーブル名によって処理を分岐 TmpRegsData
          case TMP_REGS_DATA:
            // SysHomeDirp/tmp/regsb/ の全ファイル削除		
            // SysHomeDirp/tmp/regs/ の全ファイル削除
            // SysHomeDirp/tmp/regs2/ の全ファイル削除
            int  result = dbRmTmpRegsData(tid);
            return result;

          // テーブル名によって処理を分岐 drawchk_cash_log
          case FNAME_DRWCHK_CASH_LOG:
            // TPRX_HOME/tran_backupに存在する drwchk_cash_log で始まるファイルを削除
            // SysHomeDirp/tmp/loop_cnct_saveに存在する PackOnTime で始まるファイルを削除
            // SysHomeDirp/tmp/loop_cnct_saveに存在する POT_ で始まるファイルを削除
            int result = dbSanrikuTranClear(tid);
            return result;

          // テーブル名によって処理を分岐 cam_avi
          case TARGET_CAMAVI:
            // 共有メモリからクイックセットアップを取得し、クイックセットアップ時は何もしない
            // echo /ext/usbcam/*.avi /ext/usbcam/old/*.avi| xargs /bin/rm -f
            int result = dbRmCamAviData(tid);
            return result;

          // テーブル名によって処理を分岐 mseg_bkup
          case MSEG_BKUP:
            // rm -rf SysHomeDirp/tmp/mseg_trm_bkup/*
          int  result = dbRmMSegBkup();
            return result;

          // テーブル名によって処理を分岐 quick_make
          case TARGET_QUICK_MAKE:
            // rm -rf SysHomeDirp/tmp/quick_make/*
            int result = dbRmQuickMake();
            return result;

          // TODO : 存在しないiniファイルのためコメントアウト
          // // テーブル名によって処理を分岐 taxchg_reserve_ini
          // case FINIT_TAXCHG_RESERVE_INI_TARGET:
          //   // rm -rf SysHomeDirp/conf/taxchg_reserve_ini
          //   int result = dbRmTaxChg_Reserve();
          //   return result;

          // テーブル名によって処理を分岐 hq_plan_update	
          case TARGET_HQ_PLAN_UPDATE:
            // /home/web2100/planYYYYMMDD* にマッチする 拡張子(.cpy or .txt or .sql) を削除
            int result = dbRmHQPlanUpdate(tid);
            return result;

          // テーブル名によって処理を分岐 mm_rept_taxchg
          case FINIT_MM_REPT_TAXCHG:
            // cp SysHomeDirp/conf/default/mm_rept_taxchg.ini.default SysHomeDirp/conf/mm_rept_taxchg.ini
            await Mm_rept_taxchgJsonFile().setDefault();
            return DbError.DB_SUCCESS;

          // テーブル名によって処理を分岐
          case ADD_PARTS_INI:
          case SET_OPTION_INI:
          case LOTTERY_INI:    // 抽選関連
          case COLORFIP15_INI: // 15インチカラー客表関連
          case AplLib.TAXFREE_INI:    // 免税電子化設定ファイル
          case AplLib.TAXFREE_CHG_INI:    // 税制改正管理ファイル
          case EXCEPT_CLS_INI: // KPI関連-除外分類定義ﾌｧｲﾙ
          case RPOINT_INI:     // 楽天ﾎﾟｲﾝﾄ設定ﾌｧｲﾙ
          case TPOINT_INI:     // Tﾎﾟｲﾝﾄ設定ﾌｧｲﾙ
          case TPOINT_DUMMY_INI:    // Tﾎﾟｲﾝﾄﾀﾞﾐｰﾌｧｲﾙ

          // cp SysHomeDirp/conf/default/iniFile.default SysHomeDirp/conf/iniFile
          int result = dbRmIniDefault(tid, tablename);

          if (tablename == AplLib.TAXFREE_INI) //免税電子化設定ファイル
          {
            RxTaskStatBuf   tsBuf;               // タスクステータス
            // 共有メモリ
            RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
            if (xRet.isValid()) {

              tsBuf = xRet.object;

              // タスクステータスにポインタを移動
              tsBuf.taxfree.stat |= RxMemTaxfree.TAXFREE_TASK_LICENCE_REQ;

              // 商用ライセンスOKをクリア
              if ((tsBuf.taxfree.stat & RxMemTaxfree.TAXFREE_TASK_LICE_BUSI_OK) != 0) {
                tsBuf.taxfree.stat &= ~RxMemTaxfree.TAXFREE_TASK_LICE_BUSI_OK;
              }
              // デモライセンスOKをクリア
              if ((tsBuf.taxfree.stat & RxMemTaxfree.TAXFREE_TASK_LICE_DEMO_OK) != 0) {
                tsBuf.taxfree.stat &= RxMemTaxfree.TAXFREE_TASK_LICE_DEMO_OK;
              }
            }
          }
          return result;
                
        // テーブル名によって処理を分岐
        case FSELF_CONTENT:
          // rm -f SysHomeDirp/conf/image/movie/f_self_cont*
          int result = dbRmFSelfContentFile(tid);
          return result;

        // テーブル名によって処理を分岐
        case TPOINT_BMP:		//Tポイント仕様bmp削除関連
          // rm -f SysHomeDirp/bmp/tpoint/*
          int result = dbRmTpointCouponBmp(tid);
          return result;

        // テーブル名によって処理を分岐
        case FINIT_UPD_FILE:		//UPDファイル削除
          // TPRX_HOME/tmp/upd を TPRX_HOME/log 配下に圧縮
          // TPRX_HOME/tmp/upd配下をすべて削除
          await UpdUtil.updErrChkAllMv(tid, UpdErrChkNum.UPD_ERR_CHK_INIT);
          return DbError.DB_SUCCESS;

        // テーブル名によって処理を分岐
        case COLORDSPMSG_IMG:		//カラー客表メッセージ表示用画像削除
          // rm -f SysHomeDirp/conf/image/colordsp/*
          int result = dbRmColordspMsgImg(tid);
          return result;

        // テーブル名によって処理を分岐 std_prom
        case STDPROMBMP:		//標準プロモーションbmp削除関連
          // rm -f SysHomeDirp/bmp/std_prom/*
          int result = dbRmStdPromBmp(tid);
          return result;

        // テーブル名によって処理を分岐 backup.normal
        case BK_REGFILE:	//実績再集計バックアップファイル
          // rm -f /web21ftp/backup/*
          return dbRemoveFile(tid, AplLib.RECAL_TRAN_DIR);

        // テーブル名によって処理を分岐 cash_recycle_ctrl
        case REGFILE35:	//キャッシュリサイクル指示ファイル
          // rm -f SysHomeDirp/tmp/acx_info/*
          String path = "$sysHomeDirp/tmp/acx_info/";
          return dbRemoveFile(tid, path);

        // テーブル名によって処理を分岐 spec
        case REGFILE36:	// スペック関連
          return await dbSpec(tid, con);

        // テーブル名によって処理を分岐 qcjc
        case REGFILE37:	// スペック関連(QCJC)
          return dbSpecJcc(tid);

        // テーブル名によって処理を分岐 jmups_sales_report
        case REGFILE38:	//Verifone/J-Mups売上レポートファイル
          // rm -f SysHomeDirp/tmp/jmups/*
          String path = "$sysHomeDirp/tmp/jmups/";
          return dbRemoveFile(tid, path);

        // テーブル名によって処理を分岐 PASTCOMP
        case TAR_PASTCOMP:	// 過去実績圧縮ファイル関連
          // rm -f TPRX_HOME/tran_backup/bkcomp_file/*
          return await AplLibPastCompFile.aplLibPastCompFileTarFileDel(
                  tid, APLLIB_PASTCOMP_ORDER.APLLIB_PASTCOMP_FILE_INIT);
                  
        // テーブル名によって処理を分岐 overflow_mov_txt
          case TARGET_OVERFLOW_MOV:
          // mv -f SysHomeDirp/tmp/acx_overflow_mov.txt SysHomeDirp/log/acx_ofverflow_mov.txt_delHHMMSS
          return dbMvOverFlowMovTxt(tid);

        // テーブル名によって処理を分岐
          case TARGET_AFTER_VUP_FREQ_TXT:	//バージョンアップ後開設時自動ファイルリクエスト指示ファイル

          // rm -rf SysHomeDirp/tmp/after_vup_freq.txt
          return dbRmAfterVupFreqTxt(tid);

        // テーブル名によって処理を分岐
          case TAXFREE_RIREK_FILE:	//免税電子化連携ファイル
          // 削除前にファイルをバックアップ(zip)
          // find TPRX_HOME/tmp/taxfree -type f -delete
          return taxfreeDataAllMv(tid);
      default:
        break;
    }

    /******************************/
    /* table exist				  */
    /******************************/
    // select tablename from pg_tables where tablename = 'tablename'
    await con.dbCon.run((conn) async {
      var res = await conn.execute('SELECT tablename FROM pg_tables WHERE tablename = \'$tablename\';');
      if (res.isEmpty) {
        return (DbError.DB_FILENOTEXISTERR);
      }
    });

    /******************************/
    /* truncate table			  */
    /******************************/
    // TRUNCATE tablename
    await con.dbCon.run((conn) async {
      try {
        await conn.execute('TRUNCATE $tablename;');
      } catch (e) {
        return (DbError.DB_FILEDELERR);
      }
    });

    /******************************/
    /* table exist				  */
    /******************************/
    // select tablename from pg_tables where tablename = 'tablename_old'
    await con.dbCon.run((conn) async {
      var res = await conn.execute('SELECT tablename FROM pg_tables WHERE tablename = \'${tablename}_old\';');
        if (res.isNotEmpty) {
        try {
          await conn.execute('TRUNCATE ${tablename}_old;');
        } catch (e) {
          return (DbError.DB_FILEDELERR);
        }
      }
    });

    if (tablename == 'c_histlog_mst') {
      // c_histlog_mst_s0
      String sequence = '${tablename}_s0';

      // テーブルのシーケンス番号をリセット c_histlog_mst_s0
      await dbDropSequence(tid, con, sequence);
    }

    if (tablename == 'c_histlog_mst') {
      // mv TPRX_HOME/tmp/hist_notfound.list TPRX_HOME/log/hist_notfound.list_YYYYMMDDHHMMSS
      HistErr.histNotFoundDel(tid, 0);
      // mv TPRX_HOME/tmp/hist_cnotfound.list TPRX_HOME/log/hist_cnotfound.list_YYYYMMDDHHMMSS
      HistErr.histNotFoundDel(tid, 1);
    }

    // 共有メモリで判定 pCom->ini_macinfo.mm_onoff
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    if (pCom.iniMacInfo.mm_system.mm_onoff != 0) {
      // on
      if (tablename == 'c_header_log' ||
          tablename == 'c_data_log' ||
          tablename == 'c_status_log' ||
          tablename == 'c_linkage_log' ||
          tablename == 'c_ej_log') {
        await con.dbCon.run((conn) async {
          for (int i = 1; i <= 31; i++) {
            // TRUNCATE tablename_0i
            await conn.execute('TRUNCATE ${tablename}_0$i;');
          }
        });
      }
    }

    if (tablename == 'c_batprcchg_mst') {
      for (int i = 1; i < 9; i++) {

        // rm -f SysHomeDirp/tmp/batprcchg_*.txt
        File batprcchgFile = TprxPlatform.getFile('$sysHomeDirp/tmp/batprcchg_$i.txt');
        if (batprcchgFile.existsSync()) {
          batprcchgFile.deleteSync();
        }
      }
    }

    if (tablename == 'c_histlog_chg_cnt' || tablename == 'c_report_cnt') {
      // insert into c_histlog_chg_cnt たくさん
      // insert into c_report_cnt　たくさん
      return await dbInsertLogTable(tid, con, tablename);
    }

    return (DbError.DB_SUCCESS);
  }

  /// ディレクトリパスを指定し、中のファイルを削除する
  /// @param tid
  /// @param path
  /// @return DbError
  /// 関連tprxソース:dbInitTable.c - dbRemoveFile
  int dbRemoveFile(TprMID tid, String path) {
    bool isDelete = false;

    // directroy exist check
    Directory dirp = TprxPlatform.getDirectory(path);
    if (!dirp.existsSync()) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, "dbRemoveFile: opendir error [$path]");
      return DbError.DB_FILEDELERR;
    }

    // ディレクトリ内のファイルのリストを作成
    List<FileSystemEntity> entities = dirp.listSync();

    // ファイルを削除
    for (FileSystemEntity file in entities) {
      try {
        file.deleteSync(recursive: true);
        isDelete = true;
      } catch (e) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "dbRemoveFile: remove error [$file.path]");
        return DbError.DB_FILEDELERR;
      }
    }

    // 何か消せたかどうか
    if (isDelete) {
      return DbError.DB_SUCCESS;
    } else {
      return DbError.DB_FILENOTEXISTERR;
    }
  }

  /// DBに初期値を設定する
  /// c_report_cnt
  /// c_histlog_chg_cnt
  /// 関連tprxソース:dbInitTable.c - dbInsertLogTable
  Future<int> dbInsertLogTable(
      TprMID tid, DbManipulationPs con, String tablename) async {
    final List<int> rpt_cnt = [
      1,
      2,
      3,
      4,
      5,
      98,
      99,
      100,
      1000,
      1001,
      1002,
      1003,
      1004,
      1005,
      -1
    ];
    final List<int> hst_cnt = [1, 2, 3, -1];

    // 共有メモリ分岐、pCom設定あり、かつポインタ取得成功
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    if (xRet.isInvalid()) {
      return (DbError.DB_SALEDATEGETERR);
    }

    if (tablename != "c_histlog_chg_cnt" && tablename != "c_report_cnt") {
      // 引数エラー
      return (DbError.DB_ARGERR);
    }

    await con.dbCon.runTx((txn) async {
      try {
        for (int counter = 0;; counter++) {
          String query = '';

          if (tablename == "c_histlog_chg_cnt") {
            if (hst_cnt[counter] == -1) {
              break;
            }
            query =
                "insert into c_histlog_chg_cnt(counter_cd,hist_cd,ins_datetime) "
                "values('${hst_cnt[counter]}','1','0001-01-01');";
          } else if (tablename == "c_report_cnt") {
            if (rpt_cnt[counter] == -1) {
              break;
            }
            query = "insert into c_report_cnt("
                "comp_cd,stre_cd,mac_no,report_cnt_cd,"
                "settle_cnt,ins_datetime,upd_datetime,"
                "status,send_flg,upd_user,upd_system) "
                "values('${pCom.dbRegCtrl.compCd}','${pCom.dbRegCtrl.streCd}','${pCom.dbRegCtrl.macNo}',"
                "'${rpt_cnt[counter]}','0','now','now','0','0','0','2');";
          }
          try {
            await txn.execute(query);
          } catch (e) {
            TprLog().logAdd(tid, LogLevelDefine.error, "$e");
            await txn.rollback();
            return DbError.DB_QUERYERR;
          }
        }
      } catch (e, s) {
        TprLog().logAdd(tid, LogLevelDefine.error, "$e,$s");
        await txn.rollback();
        return DbError.DB_TRANENDERR;
      }
    });
    return (DbError.DB_SUCCESS);
  }

  /// SEQUENCEをリセットする
  /// @param tid
  /// @param con
  /// @param tablename
  /// @return DbError
  /// 関連tprxソース:dbInitTable.c - dbDropSequence
  Future<int> dbDropSequence(
      TprMID tid, DbManipulationPs con, String tablename) async {
    if (tablename.isEmpty) {
      // 引数エラー
      return (DbError.DB_ARGERR);
    }

    // SELECT SETVAL ('tablename', 1);
    // テーブルのシーケンス番号をリセット
    await con.dbCon.run((conn) async {
      await conn.execute('SELECT SETVAL (\'$tablename\', 1);');
    });
    return DbError.DB_SUCCESS;
  }

  /// パスで指定されたディレクトリ配下のファイルを削除する
  /// (fnameの前が9文字のグループコードの場合に限る)
  /// @param path
  /// @param fname
  /// @return DbError
  /// 関連tprxソース:dbInitTable.c - dbRmFileByGrp
  int dbRmFileByGrp(String path, String fname) {
    Directory dirp = TprxPlatform.getDirectory(path);
    if (!dirp.existsSync()) {
      return DbError.DB_FILEDELERR;
    }

    List<FileSystemEntity> entities = dirp.listSync();

    var deleteFlg = false;
    for (FileSystemEntity file in entities) {
      if (basename(file.path).indexOf(fname) != 9) {
        continue;
      }

      try {
        file.deleteSync(recursive: true);
        deleteFlg = true;
      } catch (e) {
        return DbError.DB_FILEDELERR;
      }
    }

    if (deleteFlg) {
      return DbError.DB_SUCCESS;
    } else {
      return DbError.DB_FILENOTEXISTERR;
    }
  }

  /// パスで指定されたディレクトリ配下のファイルを削除する
  /// (拡張子が一致する場合に限る)
  /// @param path
  /// @param ext
  /// 関連tprxソース:dbInitTable.c - dbRmFileByExt
  int dbRmFileByExt(String path, String ext) {
    Directory dirp = TprxPlatform.getDirectory(path);
    if (!dirp.existsSync()) {
      return DbError.DB_FILEDELERR;
    }

    List<FileSystemEntity> entities = dirp.listSync();

    var deleteFlg = false;
    for (FileSystemEntity file in entities) {
      // 拡張子が一致しない場合はスキップ
      if (basename(file.path).endsWith(ext) == false) {
        continue;
      }
      try {
        file.deleteSync(recursive: true);
        deleteFlg = true;
      } catch (e) {
        return DbError.DB_FILEDELERR;
      }
    }
    if (deleteFlg) {
      return DbError.DB_SUCCESS;
    } else {
      return DbError.DB_FILENOTEXISTERR;
    }
  }

  /// パスで指定されたディレクトリ配下のファイルを削除する
  /// (指定された文字列で開始する場合に限る)
  /// @param path
  /// @param ext
  /// @return DbError
  /// 関連tprxソース:dbInitTable.c - dbRmFileByExt2
  int dbRmFileByExt2(String path, String ext) {
    Directory dirp = TprxPlatform.getDirectory(path);
    if (!dirp.existsSync()) {
      return DbError.DB_FILEDELERR;
    }

    List<FileSystemEntity> entities = dirp.listSync();

    var deleteFlg = false;
    for (FileSystemEntity file in entities) {
      if (basename(file.path).startsWith(ext)) {
        try {
          file.deleteSync(recursive: true);
          deleteFlg = true;
        } catch (e) {
          return DbError.DB_FILEDELERR;
        }
      }
    }

    if (deleteFlg) {
      return DbError.DB_SUCCESS;
    } else {
      return DbError.DB_FILENOTEXISTERR;
    }
  }

  /// パスで指定されたディレクトリ配下のファイルを削除する
  /// 関連tprxソース:dbInitTable.c - dbRmFileImage
  int dbRmFileImage() {
    Directory dirp = TprxPlatform.getDirectory(IMG_PATH);
    // ディレクトリ存在チェック
    if (dirp.existsSync() == false) {
      return DbError.DB_FILEDELERR;
    }

    // rm -rf /web2100/xpm/presetu*.jpg
    List<FileSystemEntity> entities = dirp.listSync();
    Iterable<FileSystemEntity> files = entities.whereType<File>();
    for (FileSystemEntity file in files) {
      if (basename(file.path).startsWith(CMD_DELETE_USER_PRE) &&
          basename(file.path).endsWith(CMD_DELETE_USER_EXT)) {
        try {
          file.deleteSync();
        } catch (e) {
          return DbError.DB_FILEDELERR;
        }
      }
    }
    // rm -rf /home/web2100/preset_img.tar.gz
    File cmdDeletePackFile = TprxPlatform.getFile(CMD_DELTE_PACK);
    if (cmdDeletePackFile.existsSync()) {
      cmdDeletePackFile.deleteSync();
    }
    // rm -rf /home/web2100/preset_img_xpm.tar.gz
    File cmdDeletePackXFile = TprxPlatform.getFile(CMD_DELTE_PACK_X);
    if (cmdDeletePackXFile.existsSync()) {
      cmdDeletePackXFile.deleteSync();
    }

    /* netDoA転送用ファイルの削除											*/
    // rm -f /web21ftp/xpm/??????_??????????_preset_img_netDoA.tar.gz
    dirp = TprxPlatform.getDirectory(CMD_DELETE_IMG_FTP_FILE_DIR);
    if (dirp.existsSync()) {
      entities = dirp.listSync();
      files = entities.whereType<File>();
      for (FileSystemEntity file in files) {
        if (RegExp(CMD_DELETE_IMG_FTP_FILE_PTN)
            .hasMatch(basename(file.path))) {
          try {
            file.deleteSync();
          } catch (e) {
            return DbError.DB_FILEDELERR;
          }
        }
      }
    }


    /* netDoA転送用ファイル格納ディレクトリの削除							*/
    // rmdir /web21ftp/xpm/
    Directory cmdDeleteImgFtpDir = TprxPlatform.getDirectory(CMD_DELETE_IMG_FTP_DIR);
    if (cmdDeleteImgFtpDir.existsSync()) {
      cmdDeleteImgFtpDir.deleteSync();
    }

    return DbError.DB_SUCCESS;
  }

  /// hp_set.ini.default を hp_set.ini にコピー
  /// 関連tprxソース:dbInitTable.c - dbRmHqIni
  int dbRmHqIni(String ext) {
    if (ext.isEmpty) {
      return DbError.DB_ARGERR;
    }

    Hq_setJsonFile hqSet = Hq_setJsonFile();
    hqSet.setDefault();
    
    return DbError.DB_SUCCESS;
  }

  /// iniに初期値を設定
  /// 関連tprxソース:dbInitTable.c - dbHQCounterInit
  Future<int> dbHQCounterInit(TprMID tid, String ext) async {
    if (ext.isEmpty) {
      return DbError.DB_ARGERR;
    }

    Hq_setJsonFile hq_set = Hq_setJsonFile();
    await hq_set.load();

    try {
      switch (ext) {
        case HQHIST_CD_UP:
          hq_set.netDoA_counter.hqhist_cd_up = 0;
          hq_set.netDoA_counter.hqhist_date_up = '0000-00-00 00:00:00';
          break;
        case HQHIST_CD_DOWN:
          hq_set.netDoA_counter.hqhist_cd_down = 0;
          hq_set.netDoA_counter.hqhist_date_down = '0000-00-00 00:00:00';
          break;
      }

      await hq_set.save();
    } catch (e) {
      return DbError.DB_FILENOTEXISTERR;
    }

    return DbError.DB_SUCCESS;
  }

  /// hq_set.ini.default を hq_set.ini にコピー
  /// 関連tprxソース:dbInitTable.c - dbRmSpFtpIni
  Future<int> dbRmSpFtpIni(String ext) async {
    if (ext.isEmpty) {
      return DbError.DB_ARGERR;
    }

    await Hq_setJsonFile().setDefault();

    // var buf = sysHomeDirp +
    //     HQ_PATH +
    //     HQ_PATH_DF +
    //     ext +
    //     HQ_INI +
    //     HQ_INI_DF;

    // if (!TprxPlatform.getFile(buf).existsSync()) {
    //   return DbError.DB_FILENOTEXISTERR;
    // }

    // // hq_set.ini.default を hq_set.ini にコピー
    // var fm =
    //     '$sysHomeDirp$HQ_PATH$HQ_PATH_DF$ext$HQ_INI$HQ_INI_DF';
    // var to = '$sysHomeDirp$HQ_PATH$ext$HQ_INI';

    // try {
    //   TprxPlatform.getFile(fm).copySync(to);
    // } catch (e) {
    //   return DbError.DB_FILENOTEXISTERR;
    // }

    return DbError.DB_SUCCESS;
  }

  /// typeによってsysHomeDirp/hqftp/backup/のファイルを削除する
  /// 関連tprxソース:dbInitTable.c - dbRmFtpBkup
  int dbRmFtpBkup(int type) {
    // SysHomeDirp/hqftp/backup/ が存在するかチェック
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$FTP_BKUP_PATH');
    // ディレクトリ存在チェック
    if (dirp.existsSync() == false) {
      return DbError.DB_FILENOTEXISTERR;
    }

    switch (type) {
      case FTPBACKUP_TYPE_JNL:
        // "ej*" を削除
        // rm -f /home/web2100/hqftp/backup/ej*
        List<FileSystemEntity> entities = dirp.listSync();
        for (FileSystemEntity file in entities) {
          if (basename(file.path).startsWith("ej")) {
            try {
              file.deleteSync(recursive: true);
            } catch (e) {
              return DbError.DB_FILEDELERR;
            }
          }
        }
        break;

      case FTPBACKUP_TYPE_TXT:
        // "ej*"以外 を削除
        // ls /home/web2100/hqftp/backup/* | grep -v /home/web2100/hqftp/backup/ej | xargs rm -r
        List<FileSystemEntity> entities = dirp.listSync();
        for (FileSystemEntity file in entities) {
          if (!basename(file.path).startsWith("ej")) {
            try {
              file.deleteSync(recursive: true);
            } catch (e) {
              return DbError.DB_FILEDELERR;
            }
          }
        }
        break;

      default:
        break;
    }

    return DbError.DB_SUCCESS;
  }

  /// tmp/rept_read配下のファイルを削除する
  /// 関連tprxソース:dbInitTable.c - dbRmRept_Read
  int dbRmReptRead() {
    // sysHomeDirp/tmp/rept_read/ が存在するかチェック
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$REPT_READ_PATH');
    if (dirp.existsSync() == false) {
      return DbError.DB_FILENOTEXISTERR;
    }

    // rm -f /home/web2100/tmp/rept_read/*
    List<FileSystemEntity> entities = dirp.listSync();
    for (FileSystemEntity file in entities) {
      try {
        file.deleteSync(recursive: true);
      } catch (e) {
        return DbError.DB_FILEDELERR;
      }
    }

    return DbError.DB_SUCCESS;
  }


  /// スタッフ設定ファイルをデフォルト値に更新
  /// 関連tprxソース:dbInitTable.c - dbRmNetwlpr
  int dbRmNetwlpr(TprMID tid) {
    // netwlpr_staff.ini はそのまま扱う
    // sysHomeDirp/conf/netwlpr_staff.ini に sysHomeDirp/conf/default/netwlpr_staff.ini.default をコピー
    var fm =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_DEFAULT_PATH$NETWLPR_STAFF_FILE$NETWLPR_INI$NETWLPR_INI_DEDAULT';
    var to =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_STAFF_FILE$NETWLPR_INI';
    File netwlprStaffFile = TprxPlatform.getFile(fm);
    try {
      if (netwlprStaffFile.existsSync()) {
        netwlprStaffFile.copySync(to);
      }
    } catch(e) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Error moving file from $fm to $to");
    }

    // netwlpr_staff_list.ini はそのまま扱う
    // sysHomeDirp/conf/netwlpr_staff_list.ini に sysHomeDirp/conf/default/netwlpr_staff_list.ini.default をコピー
    fm =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_DEFAULT_PATH$NETWLPR_STAFF_LIST_FILE$NETWLPR_INI$NETWLPR_INI_DEDAULT';
    to =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_STAFF_LIST_FILE$NETWLPR_INI';
    File netwlprStaffListFile = TprxPlatform.getFile(fm);
    try {
      if (netwlprStaffListFile.existsSync()) {
        netwlprStaffListFile.copySync(to);
      }
    } catch(e) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Error moving file from $fm to $to");
    }

    // netwlpr_deal.ini はそのまま扱う
    // sysHomeDirp/conf/netwlpr_deal.ini に sysHomeDirp/conf/default/netwlpr_deal.ini.default をコピー
    fm =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_DEFAULT_PATH$NETWLPR_DEAL_FILE$NETWLPR_INI$NETWLPR_INI_DEDAULT';
    to =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_DEAL_FILE$NETWLPR_INI';
    File netwlprDealFile = TprxPlatform.getFile(fm);
    try {
      if (netwlprDealFile.existsSync()) {
        netwlprDealFile.copySync(to);
      }
    } catch(e) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Error moving file from $fm to $to");
    }

    // netwlpr_deal_list.ini はそのまま扱う
    // sysHomeDirp/conf/netwlpr_deal_list.ini に sysHomeDirp/conf/default/netwlpr_deal_list.ini.default をコピー
    fm =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_DEFAULT_PATH$NETWLPR_DEAL_LIST_FILE$NETWLPR_INI$NETWLPR_INI_DEDAULT';
    to =
        '$sysHomeDirp$NETWLPR_CONF_PATH$NETWLPR_DEAL_LIST_FILE$NETWLPR_INI';
    File netwlprDealListFile = TprxPlatform.getFile(fm);
    try {
      if (netwlprDealListFile.existsSync()) {
        netwlprDealListFile.copySync(to);
      }
    } catch(e) {
      TprLog().logAdd(tid, LogLevelDefine.error, "Error moving file from $fm to $to");
    }

    return DbError.DB_SUCCESS;
  }

  /// defalut.ini を ini　に上書き
  /// 関連tprxソース:dbInitTable.c - dbRmStaffopen
  int dbRmStaffopen() {
    // sysHomeDirp/conf/staff.ini に sysHomeDirp/conf/default/staff.ini.default をコピー
    StaffJsonFile().setDefault();

    return DbError.DB_SUCCESS;
  }

  /// tmp/taxchg配下のファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRmTaxchg
  int dbRmTaxchg() {
    // sysHomeDirp/tmp/taxchg/ が存在するかチェック
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$TAXCHG_READ_PATH');
    if (dirp.existsSync() == false) {
      return DbError.DB_FILENOTEXISTERR;
    }

    // rm -f /home/web2100/tmp/taxchg/*
    List<FileSystemEntity> entities = dirp.listSync();
    for (FileSystemEntity file in entities) {
      file.deleteSync(recursive: true);
    }

    return DbError.DB_SUCCESS;
  }

  /// log配下のエラーログファイルをリネームする
  /// 関連tprxソース:dbInitTable.c - dbRmUpdErr
  Future<int> dbRmUpdErr(TprMID tid) async {
    // エラーログファイルを世代ファイルに変更
    // upd_err.log => Upd_errlog_マシン番号_年月日時分秒.log
    switch (await UpdUtil.updErlogMv(tid)) {
      case 0: // not found
        return DbError.DB_FILENOTEXISTERR;
      case 1: // ok
        return DbError.DB_SUCCESS;
      default: // ng
        return DbError.DB_TABLENOTFOUND;
    }
  }

  /// 仮締めファイルをクリアする
  /// 関連tprxソース:dbInitTable.c - dbRmMobileFile
  Future<int> dbRmMobileFile() async {
    //C:\work\tera\c_src\pj\tprx\src\lib\apllib\mobile_lib.c
    if ((await MobileLib.rcMblSusDelete(null)) != 0) {
      return DbError.DB_FILEDELERR;
    } else {
      return DbError.DB_SUCCESS;
    }
  }

  /// 設定ファイルのカウンターを更新
  /// 関連tprxソース:dbInitTable.c - dbRmCounter
  Future<int> dbRmCounter() async {
    //counter.ini
    CounterJsonFile counterJson = CounterJsonFile();
    await counterJson.load();
    counterJson.tran.ttllog_all_cnt = 0;
    counterJson.tran.ttllog_m_cnt = 0;
    counterJson.tran.ttllog_bs_cnt = 0;
    await counterJson.save();

    //mupdate_counter.ini
    Mupdate_counterJsonFile mupdateCounterJson = Mupdate_counterJsonFile();
    mupdateCounterJson.tran.ttllog_all_cnt = 0;
    mupdateCounterJson.tran.ttllog_m_cnt = 0; 
    await mupdateCounterJson.save();

    //update_counter.ini
    Update_counterJsonFile updateCounterJson = Update_counterJsonFile();
    updateCounterJson.tran.ttllog_all_cnt = 0;
    await updateCounterJson.save();

    //fjss.ini
    FjssJsonFile fjssJsonFile = FjssJsonFile();
    fjssJsonFile.fjss_system.senditemcnt = 0;
    await fjssJsonFile.save();

    //specificftp.ini
    SpecificftpJsonFile specificftpJson = SpecificftpJsonFile();
    specificftpJson.ja_system.senditemcnt = 0;
    await specificftpJson.save();

    return DbError.DB_SUCCESS;
  }

  /// tmp配下のFBMemo始まりのファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRmMemo
  int dbRmMemo() {

    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/');
    // rm -rf sysHomeDirp/tmp/FBMemo*
    // rm -rf sysHomeDirp/tmp/TFBMemo*
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        if (basename(file.path).startsWith('FBMemo') || basename(file.path).startsWith('TFBMemo')) {
          file.deleteSync(recursive: true);
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// /web21ftp/tmp/tablename配下のファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRmMregbkup
  int dbRmMregbkup(String tablename) {
    Directory dirp = TprxPlatform.getDirectory('/web21ftp/tmp/$tablename');
    if (dirp.existsSync() == false) {
      return DbError.DB_FILENOTEXISTERR;
    }

    // rm -rf /web21ftp/tmp/$tablename/*
    List<FileSystemEntity> entities = dirp.listSync();
    for (FileSystemEntity file in entities) {
      file.deleteSync(recursive: true);
    }
    return DbError.DB_SUCCESS;
  }

  /// tmp/plu配下のファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRmNonact
  int dbRmNonact() {
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/plu/');
    if (dirp.existsSync()) {
      // rm -rf SysHomeDirp/tmp/plu/*
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }

    return DbError.DB_SUCCESS;
  }

  /// tmp/sims配下のMENTE_NG始まりのファイルを全て削除
  /// tmp/sims/mseg配下のSET始まりのファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRmMente_Ng
  int dbRmMenteNg() {
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/sims/');
    if (dirp.existsSync()) {
      // rm -rf SysHomeDirp/tmp/sims/MENTE_NG.*
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        if (basename(file.path).startsWith('MENTE_NG')) {
          file.deleteSync(recursive: true);
        }
      }
    }
    
    Directory dirpmseg = TprxPlatform.getDirectory('$sysHomeDirp/tmp/sims/mseg/');
    if (dirpmseg.existsSync()) {
      // rm -rf SysHomeDirp/tmp/sims/mseg/SET*
      List<FileSystemEntity> entities = dirpmseg.listSync();
      for (FileSystemEntity file in entities) {
        if (basename(file.path).startsWith('SET')) {
          file.deleteSync(recursive: true);
        }
      }
    }

    return DbError.DB_SUCCESS;
  }

  /// 関連tprxソース:dbInitTable.c - dbDropTable_ND
  Future<void> dbDropTableND(
      TprMID tid, String tablename, DbManipulationPs con) async {

    TprLog().logAdd(
        tid, LogLevelDefine.normal, 'dbInitTable.c:dbDropTable_ND\n');

    await con.dbCon.run((conn) async {
      await conn.execute('DROP TABLE IF EXISTS $tablename;');
    });

    return;
  }

  /// bmp/cmlogo配下のファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRm_CmLogo
  Future<int> dbRmCmLogo(TprMID tid) async {

    // SysHomeDirp/bmp/cmlogo/ が存在するかチェック
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$CMLOGO_PATH');
    if (dirp.existsSync() == false) {
      // 無ければ作成
      try {
        dirp.createSync(recursive: true);
        if (Platform.isLinux) {
          await Process.run('chmod', ['777', dirp.path]);
        }
      } catch (e) {
        TprLog().logAdd(tid, LogLevelDefine.error, 'dbInitTable: Error create ${dirp.path}.');
      }
    }

    // rm -f SysHomeDirp/bmp/cmlogo/*
    List<FileSystemEntity> entities = dirp.listSync();
    for (FileSystemEntity file in entities) {
      file.deleteSync(recursive: true);
    }

    // rm -f /home/web2100/tmp/cmlogo.tar.gz
    File cmlogoTarNameFile = TprxPlatform.getFile('$HOME_WEB2100_PATH$CMLOGO_TAR_NAME');
    if (cmlogoTarNameFile.existsSync()) {
      cmlogoTarNameFile.deleteSync();
    }

    // cp SysHomeDirp/bmp/cmlogo/defalut/ SysHomeDirp/bmp/cmlogo/
    Directory defaultDir = TprxPlatform.getDirectory('$sysHomeDirp$CMLOGO_PATH$CMLOGO_DEFAULT_PATH');
    Directory targetDir = TprxPlatform.getDirectory('$sysHomeDirp$CMLOGO_PATH');
    if (defaultDir.existsSync()) {
      if (!targetDir.existsSync()) {
        targetDir.createSync(recursive: true);
      }
      List<FileSystemEntity> entities = defaultDir.listSync(recursive: true);
      for (FileSystemEntity entity in entities) {
        String newPath = entity.path.replaceAll(defaultDir.path, targetDir.path);
        if (entity is Directory) {
          Directory newDir = TprxPlatform.getDirectory(newPath);
          newDir.createSync(recursive: true);
        } else if (entity is File) {
          File newFile = TprxPlatform.getFile(newPath);
          newFile.writeAsBytesSync(entity.readAsBytesSync());
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// /home/web2100/cpy/配下のファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRm_CenterServer
	int dbRmCenterServer() {

    // rm -rf /home/web2100/cpy/
    Directory dirp = TprxPlatform.getDirectory('/home/web2100/cpy/');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }

    return DbError.DB_SUCCESS;
  }

  /// tmp配下のpbchg_check_info_始まりのファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRm_PbchgCheck
	int dbRmPbchgCheck() {
    // rm -f SysHomeDirp/tmp/pbchg_check_info_*.txt
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$PBCHG_TMP_PATH');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      Iterable<FileSystemEntity> files = entities.whereType<File>();
      for (FileSystemEntity file in files) {
        if (basename(file.path).startsWith(PBCHG_CHK_INF_PRE) &&
            basename(file.path).endsWith(  PBCHG_CHK_INF_EXT)) {
          file.deleteSync();
        }
      }
    }

    return DbError.DB_SUCCESS;
  }

  // int dbINIWiz() {
  //   // cp SysHomeDirp/conf/default/wiz_cnct.ini.default SysHomeDirp/conf/wiz_cnct.ini
  //   Wiz_cnctJsonFile().setDefault();

  //   return DbError.DB_SUCCESS;
  // }

  /// /web21ftp/Wiz配下のファイルを全て削除
  /// 関連tprxソース:dbInitTable.c - dbRm_WizTran
  int dbRmWizTran() {

    // rm -f /web21ftp/Wiz/*
    Directory dirp = TprxPlatform.getDirectory(WIZ_TRAN_PATH);
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }

    return DbError.DB_SUCCESS;
  }

  /// tmp配下のQR始まりのファイル、スピードセルフ用ディレクトリ内のファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRm_SpqcTxt
  int dbRmSpqcTxt(TprMID tid) {

    var ret = DbError.DB_SUCCESS;
    /* 一時ファイル */
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$TMP_PATH');
    if (dirp.existsSync()) {
      // find SysHomeDirp/tmp -name 'QR*.*' -print|xargs rm
      List<FileSystemEntity> entities = dirp.listSync();
      Iterable<FileSystemEntity> files = entities.whereType<File>();
      for (FileSystemEntity file in files) {
        if (basename(file.path).startsWith('QR') &&
            basename(file.path).contains('.')) {
          file.deleteSync();
        }
      }
      TprLog().logAdd(
          tid, LogLevelDefine.normal, "find SysHomeDirp/tmp -name 'QR*.*' -print|xargs rm");
    } else {
      ret = DbError.DB_FILENOTEXISTERR;
    }

    // スピードセルフ用ディレクトリ内のファイル全て削除
    SpSelfDirProcParam dirParam = SpSelfDirProcParam();
    dirParam.Type = SPSELF_DIR_PROC_TYPE.SPSELF_PROC_INITDIR;
    AplLibSpeedSelf.aplLibSpeedSelfDirProc(tid, dirParam);

    return ret;
  }

  /// tmp/spec_chg配下のファイルを削除
  /// 関連tprxソース:dbInitTable.c - 
  int dbRmSpecChg() {

    Directory dirp = TprxPlatform.getDirectory(SPECCHG_SRV_PATH);

    /* Ｍ，ＳＴの場合、今回のスペック変更を持っているので、削除する */
    if (dirp.existsSync()) {
      // rm -f SysHomeDirp/tmp/spec_chg/*
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }

    /* 前回のスペック変更を削除 */
    // rm -f SysHomeDirp/tmp/spec_chg_old/*
    dirp = TprxPlatform.getDirectory('$sysHomeDirp$SPECCHG_OLD_PATH');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }

    return DbError.DB_SUCCESS;
  }

  /// 登録で使用する仮締データ、タブデータを削除 (2011/09/22)
  /// 関連tprxソース:dbInitTable.c - dbRmTmpRegsData
  int	dbRmTmpRegsData(TprMID tid) {	
    // SysHomeDirp/tmp/regs/ が存在するかチェック
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/regs/');
    // ディレクトリ存在チェック
    if (dirp.existsSync() == false) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbRmTmpRegsData:opendir error[${dirp.path}]');
    } else {
      // SysHomeDirp/tmp/regs/ にあるファイルを削除
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }

    // SysHomeDirp/tmp/regsb/ が存在するかチェック
    dirp = TprxPlatform.getDirectory('$sysHomeDirp/tmp/regsb/');
    if (dirp.existsSync() == false) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbRmTmpRegsData:opendir error[${dirp.path}]');
    } else {
      // SysHomeDirp/tmp/regs/ にあるファイルを削除
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        file.deleteSync(recursive: true);
      }
    }
    
    return DbError.DB_SUCCESS;
  }

  /// 動画ファイル削除 
  /// 関連tprxソース:dbInitTable.c - dbRmCamAviData
  int dbRmCamAviData(TprMID tid) {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    if (xRet.isValid()) {
      /* クイックセットアップ時はUSBカメラ動画削除を行わない */
      // pComのquick_flgが0以上の場合
      if (pCom.quickFlg.no > QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE.no) {

        TprLog().logAdd(
            tid, LogLevelDefine.error, 'dbRmCamAviData delete_skip for quick_setup\n');
        return DbError.DB_SUCCESS;
        
      }
      
    } else {
        TprLog().logAdd(
            tid, LogLevelDefine.error, 'dbRmCamAviData rxMemPtr Error\n');
    }

    Directory dirp = TprxPlatform.getDirectory(AplLib.USBCAM_DIR);
    // ディレクトリ存在チェック
    if (dirp.existsSync() == false) {
      return DbError.DB_FILENOTEXISTERR;
    }

    // rm /ext/usbcam/*.avi
    List<FileSystemEntity> entities = dirp.listSync();
    Iterable<FileSystemEntity> files = entities.whereType<File>();
    for (FileSystemEntity file in files) {
      if (basename(file.path).endsWith('.avi')) {
        file.deleteSync();
      }
    }

    // rm /ext/usbcam/old/*.avi
    dirp = TprxPlatform.getDirectory('${AplLib.USBCAM_DIR}old/');
    if (dirp.existsSync()) {
      entities = dirp.listSync();
      files = entities.whereType<File>();
      for (FileSystemEntity file in files) {
        if (basename(file.path).endsWith('.avi')) {
          file.deleteSync();
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// tmp/mseg_trm_bkup配下のファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRmMSeg_Bkup
  int dbRmMSegBkup() {

    // rm -rf SysHomeDirp/tmp/mseg_trm_bkup/*
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/$MSEG_BKUP_PATH/');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
          file.deleteSync(recursive: true);
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// tmp/quick_make配下のファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRmQuickMake
	int dbRmQuickMake() {
    // rm -rf SysHomeDirp/tmp/quick_make/*
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/$QUICK_MAKE_PATH/');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
          file.deleteSync(recursive: true);
      }
    }
    return DbError.DB_SUCCESS;
  }

  // 存在しないiniファイルのためコメントアウト
  // int dbRmTaxChg_Reserve() {
  //   // rm -rf SysHomeDirp/conf/taxchg_reserve.ini
  //   TprxPlatform.getFile('$sysHomeDirp/conf/$FINIT_TAXCHG_RESERVE_INI').deleteSync();

  //   return DbError.DB_SUCCESS;
  // }

  /// 関連tprxソース:dbInitTable.c - dbRmExecHQPlanUpdate
  SCAN_DIR_RESULT dbRmExecHQPlanUpdate(TprMID tid, String fileName, String path, String? scanDirArg) {
    // planから始まるファイル名で、拡張子がtxt, sql, cpyの場合
    if (fileName.startsWith('plan') && fileName.length >= 16 &&
        (fileName.endsWith('txt') || fileName.endsWith('sql') || fileName.endsWith('cpy'))) {
      String date = fileName.substring(4, 12);

      // planYYYYMMDD が日付として正しいかチェック
      if (double.tryParse(date) != null) {
        // 日付として正しいかチェック
        if (DateTime.tryParse(date) != null) {
          AplLibStdAdd.aplLibRemove(tid, path);
        }
      }

      return SCAN_DIR_RESULT.SCAN_DIR_OK;
    }
    return SCAN_DIR_RESULT.SCAN_DIR_CONTINUE;
  }

  /// 上位接続で受信, 作成したマスタ予約変更ファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRmHQPlanUpdate
  int dbRmHQPlanUpdate(TprMID tid) {
    AplLibStdAdd.aplLibProcScanDirBeta(tid, '/home/web2100/', null, dbRmExecHQPlanUpdate);

    return DbError.DB_SUCCESS;
  }

  /// INIファイル初期化共通関数
  /// 引数の[INIファイル]を[同名のINIファイル + .default]で置き換える
  /// 引数にINIファイル名称をセット出来るタイプなら使用可能
  /// 関連tprxソース:dbInitTable.c - dbRm_Ini_Default
  int dbRmIniDefault(TprMID tid, String iniFile) {
    try {
      switch(iniFile) {

        case ADD_PARTS_INI:
          Add_partsJsonFile().setDefault();
          break;

        case SET_OPTION_INI:
          Set_optionJsonFile().setDefault();
          break;

        case LOTTERY_INI:    // 抽選関連
          LotteryJsonFile().setDefault();
          break;

        case COLORFIP15_INI: // 15インチカラー客表関連
          Colorfip15JsonFile().setDefault();
          break;

        case AplLib.TAXFREE_INI:    // 免税電子化設定ファイル
          TaxfreeJsonFile().setDefault();
          break;

        case AplLib.TAXFREE_CHG_INI:    // 税制改正管理ファイル
          Taxfree_chgJsonFile().setDefault();
          break;

        case EXCEPT_CLS_INI: // KPI関連-除外分類定義ﾌｧｲﾙ
          Except_clsJsonFile().setDefault();
          break;

        case RPOINT_INI:     // 楽天ﾎﾟｲﾝﾄ設定ﾌｧｲﾙ
          RpointJsonFile().setDefault();
          break;

        case TPOINT_INI:     // Tﾎﾟｲﾝﾄ設定ﾌｧｲﾙ
          TpointJsonFile().setDefault();
          break;

        case TPOINT_DUMMY_INI:    // Tﾎﾟｲﾝﾄﾀﾞﾐｰﾌｧｲﾙ
          Tpoint_dummyJsonFile().setDefault();
          break;
      }
    } catch (e) {
      return DbError.DB_FILENOTEXISTERR;
    }

    return DbError.DB_SUCCESS;
  }

  /// conf/image/movie配下のファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRm_f_self_content_file
  int dbRmFSelfContentFile(TprMID tid) {

    // rm -f SysHomeDirp/conf/image/movie/f_self_cont*
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/conf/image/movie/');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        if (basename(file.path).startsWith('f_self_cont')) {
          file.deleteSync(recursive: true);
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// 三陸スーパー向け特注実績を削除
  /// PackOnTime系ファイルの削除
  /// 関連tprxソース:dbInitTable.c - dbSanrikuTranClear
  int dbSanrikuTranClear(TprMID tid) {

    // dirに TPRX_HOME/tran_backup をセット
    var dir = CmGetpath.cmGetdirTranBackup();

    // TPRX_HOME/tran_backupに存在する drwchk_cash_log で始まるファイルを削除
    AplLibOther.dirFileAction(tid, dir, FNAME_DRWCHK_CASH_LOG, "", "", 0
          , APL_MATCH_PROC_TYPE.PROCESS_MATCH, APL_ACTION_TYPE.APL_ACTION_REMOVE, "");

    // PackOnTime系ファイルの削除
    // dirに SysHomeDirp/tmp/loop_cnct_save をセット
    // C:\work\tera\c_src\pj\tprx\src\inc\apl\rxmbratachk.h
    dir = '$sysHomeDirp${RxMbrAtaChk.DIR_LOOP_CNCT}';
    // SysHomeDirp/tmp/loop_cnct_saveに存在する PackOnTime で始まるファイルを削除
    AplLibOther.dirFileAction(tid, dir, RxMbrAtaChk.PREFIX_PACK_ON_TIME, "", "", 0
          , APL_MATCH_PROC_TYPE.PROCESS_MATCH, APL_ACTION_TYPE.APL_ACTION_REMOVE, "");

    // SysHomeDirp/tmp/loop_cnct_saveに存在する POT_ で始まるファイルを削除
    AplLibOther.dirFileAction(tid, dir, RxMbrAtaChk.PREFIX_SEND_PACK_ON_TIME, "", "", 0
          , APL_MATCH_PROC_TYPE.PROCESS_MATCH, APL_ACTION_TYPE.APL_ACTION_REMOVE, "");


    return DbError.DB_SUCCESS;
  }

  /// 機能：Tポイント仕様・POSの/pj/tprx/bmp/tpoin内にあるbmpファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRm_TpointCoupon_Bmp
  int dbRmTpointCouponBmp(TprMID tid) {

    // rm -f SysHomeDirp/bmp/tpoint/*
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/bmp/tpoint/');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        try {
          file.deleteSync(recursive: true);
        } catch (e) {
          return DbError.DB_OTHERERR;
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// 機能：カラー客表メッセージ表示用の/pj/tprx/conf/image/colordsp内にある画像ファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRm_ColordspMsg_Img
  int dbRmColordspMsgImg(TprMID tid) {

    // rm -f SysHomeDirp/*
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp/conf/image/colordsp/');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      for (FileSystemEntity file in entities) {
        try {
          file.deleteSync(recursive: true);
        } catch (e) {
          return DbError.DB_OTHERERR;
        }
      }
    }
    return DbError.DB_SUCCESS;

  }

  /// 機能：ｵｰﾊﾞｰﾌﾛｰ庫移動履歴ﾌｧｲﾙの削除(/pj/tprx/tmp/から/pj/tprx/log/の下へリネームして移動)
  /// 関連tprxソース:dbInitTable.c - dbMv_OverFlow_Mov_Txt
  int dbMvOverFlowMovTxt(TprMID tid) {

    // SysHomeDirp/tmp/acx_overflow_mov.txt
    DateTime now  = DateTime.now();
    var hh = now.hour.toString().padLeft(2, '0');
    var mm = now.minute.toString().padLeft(2, '0');
    var ss = now.second.toString().padLeft(2, '0');

    String defaultPath = '$sysHomeDirp$OVERFLOW_ORG_PATH$ACX_OVERFLOW_MOV_FILE';
    String targetPath =  '${EnvironmentData.TPRX_HOME}/log/${ACX_OVERFLOW_MOV_FILE}_del$hh$mm$ss';

    if (TprxPlatform.getFile(defaultPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: $defaultPath is a directory\n');
      return DbError.DB_FILEDELERR;
    }

    try {
      TprxPlatform.getFile(defaultPath).renameSync(targetPath);
    } catch (e) {
      TprLog().logAdd(
        tid, LogLevelDefine.error, 'dbInitTable: Error moving file from $defaultPath to $targetPath\n');
      return DbError.DB_FILENOTEXISTERR;
    }

    return DbError.DB_SUCCESS;
  }

  /// バージョンアップ後開設時自動ファイルリクエスト指示ファイルの削除
  /// 関連tprxソース:dbInitTable.c - dbRm_After_Vup_Freq_Txt
  int	dbRmAfterVupFreqTxt(TprMID tid) {
    // rm -rf SysHomeDirp/tmp/after_vup_freq.txt
    File afterVupFreqFile = TprxPlatform.getFile(AplLib.AFTER_VUP_FREQ_FILE);
    if (afterVupFreqFile.existsSync()) {
      afterVupFreqFile.deleteSync();
    }

    return DbError.DB_SUCCESS;
  }

  /// 機能：特定CR2接続仕様・POSの /pj/tprx/bmp/cr40 内にあるbmpファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRm_CR2_Bmp
  int dbRmCR2Bmp(TprMID tid) {

    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$CR2BMP_INIT_PATH');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      Iterable<FileSystemEntity> files = entities.whereType<File>();
      for (FileSystemEntity file in files) {
        try {
          file.deleteSync(recursive: true);
        } catch (e) {
          TprLog().logAdd(
              tid, LogLevelDefine.error, 'dbRmCR2Bmp: Error. ret = [${e.toString()}], cmd = [rm -f ${dirp.path}]');
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// 機能：標準プロモーション・POSの/pj/tprx/bmp/std_prom内にあるbmpファイルを削除
  /// 関連tprxソース:dbInitTable.c - dbRm_StdProm_Bmp
  int dbRmStdPromBmp(TprMID tid) {

    TprLog().logAdd(
        tid, LogLevelDefine.normal, 'dbRm_StdProm_Bmp() : Start!!');

    // rm -f SysHomeDirp/bmp/std_prom/*
    Directory dirp = TprxPlatform.getDirectory('$sysHomeDirp$STDPROMBMP_LCL_PATH');
    if (dirp.existsSync()) {
      List<FileSystemEntity> entities = dirp.listSync();
      Iterable<FileSystemEntity> files = entities.whereType<File>();
      for (FileSystemEntity file in files) {
        try {
          file.deleteSync(recursive: true);
        } catch (e) {
          TprLog().logAdd(
              tid, LogLevelDefine.error, 'dbRm_StdProm_Bmp: Error. ret = [${e.toString()}], cmd = [rm -f ${dirp.path}]');
        }
      }
    }
    return DbError.DB_SUCCESS;
  }

  /// 機能概要     : ファイル初期設定(スペック関連)処理
  /// 関連tprxソース:dbInitTable.c - dbSpec
  Future<int> dbSpec (TprMID tid, DbManipulationPs con) async {

    TprLog().logAdd(
          tid, LogLevelDefine.other1, 'dbInitTable: Specification file initialize function executed!\n');

    try {
      await SysJsonFile().setDefault();
    } catch (e) {
      TprLog().logAdd(
        tid, LogLevelDefine.error, 'dbInitTable: Error SysJsonFile setDefault\n');
    }
    
    int macRet = 1;
    try {
      Mac_infoJsonFile().setDefault();
      macRet = 0;
    } catch (e) {
      TprLog().logAdd(
        tid, LogLevelDefine.error, 'dbInitTable: Error Mac_infoJsonFile setDefault\n');
      macRet = -1;
    }
    
    int type = await CmCksys.cmWebType();

    if (type == CmSys.WEBTYPE_WEB2800 || type == CmSys.WEBTYPE_WEB2500) {
      try {
        Msr_chkJsonFile().setDefault();
        macRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error Msr_chkJsonFile setDefault\n');
        macRet = -1;
      }
    }

    try {
      WolJsonFile().setDefault();
    } catch (e) {
      TprLog().logAdd(
        tid, LogLevelDefine.error, 'dbInitTable: Error WolJsonFile setDefault\n');
    }

    if( macRet == 0 )
    {
      if( await dbLiloRet(tid, 1) != 0 ) {
        TprLog().logAdd(
            tid, LogLevelDefine.error, 'dbInitTable: An error from db_Lilo_Ret function');
      }


      try {
        CounterJsonFile().setDefault();
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error CounterJsonFile setDefault\n');
      }

      try {
        Mupdate_counterJsonFile().setDefault();
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error Mupdate_counterJsonFile setDefault\n');
      }
    
      try {
        Update_counterJsonFile().setDefault();
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error Update_counterJsonFile setDefault\n');
      }

    }

    var ethRet = 1;
    String ethDefaultPath = '$sysHomeDirp$ETH_SRC';
    String ethTargetPath =  ETH_DES;
    
    if (TprxPlatform.getFile(ethDefaultPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: ifcfg_enp1s0.default is a directory\n');
      ethRet = -1;
    } else {
      try {
        // cp sysHomeDirp/eth_src/ifcfg_enp1s0.default /etc/sysconfig/network-scripts/ifcfg-eth0
        TprxPlatform.getFile(ethDefaultPath).copySync(ethTargetPath);
        ethRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error moving file from $ethDefaultPath to $ethTargetPath\n');
        ethRet = -2;
      }
    }

    var hostsRet = 1;
    String hostsDefaultPath = '$sysHomeDirp$HOSTS_SRC';
    String hostsTargetPath =  HOSTS_DES;
    
    if (TprxPlatform.getFile(hostsDefaultPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: ifcfg_enp1s0.default is a directory\n');
      hostsRet = -1;
    } else {
      try {
        // cp sysHomeDirp/hosts_src/hosts.default /etc/hosts
        TprxPlatform.getFile(hostsDefaultPath).copySync(hostsTargetPath);
        hostsRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error moving file from $hostsDefaultPath to $hostsTargetPath\n');
        hostsRet = -2;
      }
    }

    var printcapRet = 1;
    String printcapDefaultPath = '$sysHomeDirp$PRINTCAP_SRC';
    String printcapTargetPath =  PRINTCAP_DES;
    
    if (TprxPlatform.getFile(printcapDefaultPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: ifcfg_enp1s0.default is a directory\n');
      printcapRet = -1;
    } else {
      try {
        // cp sysHomeDirp/printcap_src/printcap.default /etc/printcap
        TprxPlatform.getFile(printcapDefaultPath).copySync(printcapTargetPath);
        printcapRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error moving file from $printcapDefaultPath to $printcapTargetPath\n');
        printcapRet = -2;
      }
    }

    var networkRet = 1;
    String networkDefaultPath = '$sysHomeDirp$NETWORK_SRC';
    String networkTargetPath =  NETWORK_DES;
    
    if (TprxPlatform.getFile(networkDefaultPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: ifcfg_enp1s0.default is a directory\n');
      networkRet = -1;
    } else {
      try {
        // cp sysHomeDirp/network_src/network.default /etc/sysconfig/network
        TprxPlatform.getFile(networkDefaultPath).copySync(networkTargetPath);
        networkRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error moving file from $networkDefaultPath to $networkTargetPath\n');
        networkRet = -2;
      }
    }

    var routeethRet = 1;
    String routeTargetPath =  ROUTEETH_DES;
    
    if (TprxPlatform.getFile(routeTargetPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: ifcfg_enp1s0.default is a directory\n');
      routeethRet = -1;
    } else {
      try {
        // rm /etc/sysconfig/network-scripts/route-eth0
        TprxPlatform.getFile(routeTargetPath).deleteSync();
        routeethRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: route-eth0 file doesn\'t exist\n');
        routeethRet = -2;
      }
    }

    var servicesRet = 1;
    String serviceDefaultPath = '$sysHomeDirp$SERVICES_SRC';
    String serviceTargetPath =  SERVICES_DES;
    
    if (TprxPlatform.getFile(serviceDefaultPath) is Directory) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: ifcfg_enp1s0.default is a directory\n');
      servicesRet = -1;
    } else {
      try {
        // cp sysHomeDirp/services_src/services.default /etc/services
        TprxPlatform.getFile(serviceDefaultPath).copySync(serviceTargetPath);
        servicesRet = 0;
      } catch (e) {
        TprLog().logAdd(
          tid, LogLevelDefine.error, 'dbInitTable: Error moving file from $serviceDefaultPath to $serviceTargetPath\n');
        servicesRet = -2;
      }
    }

    /*** check return value for copying hosts ***/
    var ret = DbError.DB_SUCCESS;
    if( ( ethRet == 0 ) && ( hostsRet == 0 ) && ( printcapRet == 0 ) && ( networkRet == 0 ) && ( routeethRet == 0 ) && ( servicesRet == 0 ) ){
    }
    else{
      if( (ethRet == -2) || (hostsRet == -2) || (printcapRet == -2) || (networkRet == -2) || ( routeethRet == -2 ) || ( servicesRet == -2 ) ){
        ret = DbError.DB_FILEDELERR;
      }
      else if( (ethRet == -1) || (hostsRet == -1) || (printcapRet == -1) || (networkRet == -1) || ( routeethRet == -1 ) || ( servicesRet == -1 ) ){
        ret = DbError.DB_FILECPYERR;
      }
      else{
        ret = DbError.DB_OTHERERR;
      }
    }
    // cp /conf/default/bm_missmach.txt.default /web21ftp/tmp/bm_missmach.txt
    Bm_missmachJsonFile().setDefault();

    // cp /conf/default/quick_self.ini.default /conf/quick_self.ini
    Quick_selfJsonFile().setDefault();


    // openvpn.confはそのまま扱う
    if( (await CmCksys.cmVPNenvSystem()) == 1 ) {
      // cp /conf/default/openvpn.conf.default /etc/openvpn/openvpn.conf
      File openvpnFile = TprxPlatform.getFile('$sysHomeDirp$OPENVPN_DEF');
      if (openvpnFile.existsSync()) {
        try {
          openvpnFile.copySync(OPENVPN_SRC);
          TprLog().logAdd(
                        tid, LogLevelDefine.normal, 'cp $sysHomeDirp$OPENVPN_DEF $OPENVPN_SRC');
        } catch (e) {
          TprLog().logAdd(
                        tid, LogLevelDefine.error, 'Error moving file from $sysHomeDirp$OPENVPN_DEF to $OPENVPN_SRC');
        }
      }
    }

    // snmpd.confはそのまま扱う
    if( (await CmCksys.cmSyschkSystem()) == 1 ) {
      // cp /conf/default/snmpd.conf.default /etc/snmp/snmpd.conf
      File snmpdFile = TprxPlatform.getFile('$sysHomeDirp$SNMP_DEF');
      if (snmpdFile.existsSync()) {
        try {
          snmpdFile.copySync(SNMP_SRC);
        TprLog().logAdd(
                      tid, LogLevelDefine.normal, 'cp $sysHomeDirp$SNMP_DEF $SNMP_SRC');
        } catch (e) {
          TprLog().logAdd(
                        tid, LogLevelDefine.error, 'Error moving file from $sysHomeDirp$SNMP_DEF to $SNMP_SRC');
        }
      }

      // cp /conf/default/SystemCheck.ini.default /conf/SystemCheck.ini
      SystemCheckJsonFile().setDefault();

      if( mm_system_flg == 1 ) {
        await con.dbCon.run((conn) async {
          try {
            await conn.execute("update c_comp_mst set name ='';");
          } catch (e) {
            TprLog().logAdd(
                tid, LogLevelDefine.error, 'dbInitTable: SystemCheck c_comp_mst error \n');
          }
        });
        await con.dbCon.run((conn) async {
          try {
            await conn.execute("update c_stre_mst set name ='' where stre_cd=$oldstrecd;");
          } catch (e) {
            TprLog().logAdd(
                tid, LogLevelDefine.error, 'dbInitTable: SystemCheck c_stre_mst error \n');
          }
        });
      }
    }

    // cp /conf/default/quick_self.ini.edy.default /conf/quick_self.ini.edy
    Quick_self_edyJsonFile().setDefault();

    // cp /conf/default/quick_self.ini.suica.default /conf/quick_self.ini.suica
    Quick_self_suicaJsonFile().setDefault();

    // cp /conf/default/quick_self.ini.pasmo.default /conf/quick_self.ini.pasmo
    Quick_self_pasmoJsonFile().setDefault();

    // cp /conf/default/barcode_pay.ini.default /conf/barcode_pay.ini
    Barcode_payJsonFile().setDefault();

    // rm -f /etc/rc.d/rc5.d/S95httpd
    Directory dirp = TprxPlatform.getDirectory(CMD_RM_HTTPD_DIR);
    if (dirp.existsSync()) {
      dirp.deleteSync(recursive: true);
    }

    // rm -rf /pj/tprx/tmp/rmstcls_stat.ini
    File rmstclsStatFile = TprxPlatform.getFile("/pj/tprx/tmp/rmstcls_stat.ini");
    if (rmstclsStatFile.existsSync()) {
      rmstclsStatFile.deleteSync();
    }
    TprLog().logAdd(
          tid, LogLevelDefine.normal, 'rm -rf /pj/tprx/tmp/rmstcls_stat.ini\n');

    //delete /web21ftp/tmp/recogkey_*.txt
    dirp = TprxPlatform.getDirectory(CMD_RM_RECOGKEY_DIR);
    if (dirp.existsSync()) {
      // rm -rf /web2100/xpm/presetu*.jpg
      for (FileSystemEntity file in dirp.listSync()) {
        if (basename(file.path).startsWith(CMD_RM_RECOGKEY_PRE) &&
            basename(file.path).endsWith(CMD_RM_RECOGKEY_EXT)) {
          file.deleteSync();
        }
      }
    }
    
    //delete /web21ftp/tmp/macadd_*.txt
    dirp = TprxPlatform.getDirectory(CMD_RM_MACADD_DIR);
    if (dirp.existsSync()) {
      for (FileSystemEntity file in dirp.listSync()) {
        if (basename(file.path).startsWith(CMD_RM_MACADD_PRE) &&
            basename(file.path).endsWith(CMD_RM_MACADD_EXT)) {
          file.deleteSync();
        }
      }
    }
    
    //link delete /etc/rc.d/rc5.d/S60lpd
    dirp = TprxPlatform.getDirectory(CMD_RM_S60LPD_DIR);
    if (dirp.existsSync()) {
      dirp.deleteSync(recursive: true);
    }

    return (ret);
  }

  /// 機能概要     : ファイル初期設定(スペック関連)処理
  /// 関連tprxソース:dbInitTable.c - dbSpec_jcc
  int dbSpecJcc(TprMID tid) {

    // TODO : 移行しないiniファイルのためコメントアウト
    // SysHomeDirp/conf/default/mac_info_JC_C.ini.default
    // defaultPath = TprxPlatform.getFile('$sysHomeDirp$MAC_JCC_SRC');
    // TODO : 移行しないiniファイルのためコメントアウト
    // sysHomeDirp/conf/default/counter_JC_C.ini.default
    // defaultPath = TprxPlatform.getFile('$sysHomeDirp$CNT_JCC_SRC');
    
    // cp /conf/default/cnct_sio.ini.default /conf/cnct_sio.ini
    Cnct_sioJsonFile().setDefault();
    TprLog().logAdd(
                  tid, LogLevelDefine.normal, 'Cnct_sioJsonFile setDefault\n');

    return DbError.DB_SUCCESS;
  }

  /// 関連tprxソース:dbInitTable.c - db_Lilo_Ret
  Future<int> dbLiloRet(TprMID tid, int type) async {

    TprLog().logAdd(
        tid, LogLevelDefine.normal, 'db_Lilo_Ret : Enter');

    int type = await CmCksys.cmWebType();

    if (type == CmSys.WEBTYPE_WEB2100) {

      // /etc/rc.d/init.d/ntpd
      // /etc/rc.d/rc5.d/S99ntpd
      try {
        await Process.run('ln', ['-s', SPEC_MMTYPE_TIPE_FROM_S, SPEC_MMTYPE_TIPE_TO_S]);
      } catch (e) {
        TprLog().logAdd(
            tid, LogLevelDefine.error, 'db_Lilo_Ret : symlink error. name from($SPEC_MMTYPE_TIPE_FROM_S) name to($SPEC_MMTYPE_TIPE_TO_S) \n');
        return -1;
      }

    } else {

      // /etc/rc.d/rc5.d/S99ntpd stop
      // rm -rf /etc/rc.d/rc5.d/S99ntpd
      try {
        await Process.run(SPEC_MMTYPE_TIPE_M, [SPEC_MMTYPE_TIPE_M_STOP]);
        TprxPlatform.getFile(SPEC_MMTYPE_TIPE_M).deleteSync();
      } catch (e) {
        TprLog().logAdd(
            tid, LogLevelDefine.error, 'db_Lilo_Ret : remove error. filename($SPEC_MMTYPE_TIPE_M)\n');
        return -1;
      }
    }

    return 0;
  }

  /// 機能：免税電子化連携ファイル削除
  /// 引数：TPRMID tid
  /// 戻値：DB_SUCCESS:正常
  /// 関連tprxソース:dbInitTable.c - taxfree_data_AllMv
  int taxfreeDataAllMv(TprMID tid) {

    TprLog().logAdd(tid, LogLevelDefine.normal, 'taxfreeDataAllMv START');


    //削除する前にlogの下に退避
    // SysHomeDirp/tmp/taxfree/
    var dir = '$sysHomeDirp${AplLib.TAXFREE_DIR}';
    var zipName = TaxfreeComlibFileName();

    // ファイル名の生成(iniファイルより作成)
    if (TaxfreeComlib.taxfreeBkupZipName(tid, zipName, 0) == 0) {

      // SysHomeDirp/log/zip_name
      var workFile = '$sysHomeDirp/log/${zipName.name}';

      // zipに圧縮
      AplLibBkupLog.aplLibBkupLogTaxFreeMakeZip(tid, workFile, dir, AplLib.TAXFREE_BKUP_PASSWORD);
    }

    // サブdirまで全部削除
    Directory taxFreeDir = TprxPlatform.getDirectory(dir);
    if (taxFreeDir.existsSync()) {
      for (FileSystemEntity file in taxFreeDir.listSync()) {
        try {
          file.deleteSync();
        } catch (e) {
          return DbError.DB_FILEDELERR;
        }
      }
    }

    return DbError.DB_SUCCESS;
  }
}
