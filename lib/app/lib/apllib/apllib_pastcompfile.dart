/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/lib/apllib/qr2txt.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:sprintf/sprintf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/db_error.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'apllib_std_add.dart';

/// 過去実績保持期間変更仕様 過去実績圧縮ファイル取得と削除処理
/// 関連tprxソース: AplLib_PastCompFile.c
class AplLibPastCompFile {
  static PastCompDropTableInfo pastCompDropTableInfo = PastCompDropTableInfo();

  static const PASTCOMPFILE_DEL_CHK = "PAST_";				// 削除対象ファイル接頭辞
  static const PASTCOMPFILE_LOCAL_DIR = "/tmp/get_bkcompfile/";		// 取引検索時に取得した圧縮ファイルの一時保存先
  static const PASTCOMPFILE_TIMEOUT = 60;				// 圧縮ファイル取得時のタイムアウト値

  /// 過去実績参照用に作成したテーブルを削除する処理
  /// 引数:[tid] タスクID
  /// 戻値: OK=削除処理成功  NG=いずれかのテーブル削除処理で失敗
  /// 関連tprxソース: AplLib_PastCompFile.c - AplLib_PastCompFile_DropTable()
  static Future<int> pastCompFileDropTable(TprMID tid) async {
    if (CmCksys.cmMmSystem() != 1) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "pastCompFileDropTable(): mm system status NG");
      return NG;
    }

    // 参照テーブル作成時のコール元のファンクションコードをチェック
    if ((pastCompDropTableInfo.backFuncCd != FuncKey.KY_RCPT_VOID.keyId)
        && (pastCompDropTableInfo.backFuncCd != FuncKey.KY_RFDOPR.keyId)
        && (pastCompDropTableInfo.backFuncCd != FuncKey.KY_ERCTFM.keyId)
        && (pastCompDropTableInfo.backFuncCd != FuncKey.KY_EJCONF.keyId))	{
      TprLog().logAdd(tid, LogLevelDefine.error,
          "pastCompFileDropTable(): Not target func_cd[${pastCompDropTableInfo.backFuncCd}]!!");
      return NG;
    }

    int stidex = 0;			// ループカウンタ開始位置セット用変数
    int endidex = 0;		// ループカウンタ終了位置セット用変数

    // コール元の操作に合わせてテーブルを削除する
    if (pastCompDropTableInfo.backFuncCd != FuncKey.KY_EJCONF.keyId) {
      // 記録確認以外の操作時は、c_ej_log_マシン番号以外のテーブルを作成させる
      stidex = PastCompTempTable.PASTCOMP_TEMP_TABLE_HEADERLOG.index;
      endidex = PastCompTempTable.PASTCOMP_TEMP_TABLE_EJLOG.index;
    } else {
      // 記録確認操作時は、c_ej_log_マシン番号のテーブルのみ作成させる
      stidex = PastCompTempTable.PASTCOMP_TEMP_TABLE_EJLOG.index;
      endidex = PastCompTempTable.PASTCOMP_TEMP_TABLE_MAX.index;
    }

    String dropTableName = "";
    for (int idex = stidex; idex < endidex; idex++) {
      dropTableName = "";
      switch (idex)	{  // idex毎に削除するテーブル名をセット
        case 0:	// c_header_log_マシン番号のテーブルを削除する場合
          dropTableName = pastCompDropTableInfo.cHeaderLogTableName;
          break;
        case 1:	// c_data_log_マシン番号のテーブルを削除する場合
          dropTableName = pastCompDropTableInfo.cDataLogTableName;
          break;
        case 2:	// c_status_log_マシン番号のテーブルを削除する場合
          dropTableName = pastCompDropTableInfo.cStatusLogTableName;
          break;
        case 3:	// c_ej_log_マシン番号のテーブルを削除する場合
          dropTableName = pastCompDropTableInfo.cEjLogTableName;
          break;
        default:
          break;
      }

      if (dropTableName.isEmpty) {  // 参照先テーブル名がセットされていないかチェック
        continue;	// 参照先テーブル名が未セットのため次の削除テーブを検索
      }

      // 参照先テーブルが存在するかチェック
      String sql = "SELECT tablename FROM pg_tables WHERE tablename='$dropTableName';";
      DbManipulationPs db = DbManipulationPs();
      Result localRes = await db.dbCon.execute(sql);

      if (localRes.isEmpty) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "pastCompFileDropTable(): read error[pg_tables]:$sql");
        pastCompDropTableInfo = PastCompDropTableInfo();  // テーブル削除処理用の構造体変数をクリア
        return NG;
      }

      if (localRes.affectedRows == 0) {
        // 参照先テーブルが存在しないため次の削除テーブルを検索
        continue;
      } else {
        // 対象の参照先テーブルが存在したため削除処理
        sql = "DROP TABLE $dropTableName;";
        localRes = await db.dbCon.execute(sql);
        if (localRes.isEmpty) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "pastCompFileDropTable(): Err DROP TABLE[$sql]");
          pastCompDropTableInfo = PastCompDropTableInfo();  // テーブル削除処理用の構造体変数をクリア
          return NG;
        }
      }
      TprLog().logAdd(tid, LogLevelDefine.normal,
          "pastCompFileDropTable(): DROP TABLE[$dropTableName] OK");
    }

    // テーブル削除処理用の構造体変数をクリア
    pastCompDropTableInfo = PastCompDropTableInfo();
    return OK;
  }

  /// 機能    ：開設時またはファイル初期化での圧縮ファイルを削除する処理
  /// 引数    ：TPRMID tid
  ///           type   ファイル初期化または開設時のファイル削除処理
  /// 関連tprxソース: AplLib_PastCompFile.c - AplLib_PastCompFile_TarFileDel
  static Future<int> aplLibPastCompFileTarFileDel(TprMID tid, APLLIB_PASTCOMP_ORDER type) async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "aplLibPastCompFileTarFileDel: rxMemPtr(pCom) Error!!");
      return (DbError.DB_ARGERR);
    }

    // MS仕様:する以外またはM,BS,STレジ以外は実行しない
    if (CmCksys.cmMmType() == CmSys.MacS || CmCksys.cmMmType() == CmSys.MacERR) {
      TprLog().logAdd(tid, LogLevelDefine.normal, "$tid: Regs-Type is Not Target");
      return DbError.DB_SUCCESS; // 正常終了
    }

    var tprxHome = EnvironmentData().env['TPRX_HOME'];

    // 圧縮ファイル保存フォルダを指定　%s/tran_backup/bkcomp_file/
    var localPath = sprintf(RxMbrAtaChk.PASTCOMP_FILE_BKDIR, [tprxHome]);
    Directory dirp = Directory(localPath);

    // 圧縮ファイル保存フォルダにアクセス可能かチェック
    if (dirp.existsSync() == false) {
      // 対象ディレクトリが存在しない場合は処理しない
      TprLog().logAdd(tid, LogLevelDefine.error, "$tid: taget local_path access NG");
      return DbError.DB_ARGERR;
    }

    // 削除するファイルを指定
    var fcnt = 0;
    switch (type) {

      case APLLIB_PASTCOMP_ORDER.APLLIB_PASTCOMP_FILE_INIT: // ファイル初期化の場合
        /* 存在した圧縮ファイル数をカウント */
        for (FileSystemEntity file in dirp.listSync()) {
          try {
            file.deleteSync();
          } catch (e) {
            TprLog().logAdd(tid, LogLevelDefine.error, "$tid: file delete error[${file.path}]");
          }
          fcnt++; /* カウント数を加算 */
        }

        if (fcnt <= 0) {
          TprLog().logAdd(tid, LogLevelDefine.error, "$tid: Target File nothing");
          return DbError.DB_FILENOTEXISTERR; // ファイル無し
        }
        break;

      case APLLIB_PASTCOMP_ORDER.APLLIB_PASTCOMP_FILE_DEL: // 開設時の対象ファイル削除の場合

        var saleDate = await DateUtil.dateTimeChange(
            null, DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE
          , DateTimeFormatKind.FT_YYYYMMDD, DateTimeFormatWay.DATE_TIME_FORMAT_ZERO); // 現在営業日の取得
        if (saleDate.$1 != 0) {
          TprLog().logAdd(tid, LogLevelDefine.error, "aplLibPastCompFileTarFileDel : datetime_change Error[${saleDate.$1}]");
          return (-1);
        }
        
        var getSaveDate = pCom.dbTrm.pastcompfileKeepDate; // 圧縮ファイル保持期間を取得
        var saveDate = 0;
        if (getSaveDate <= 0) {
          // 取得結果が0以下かチェック
          saveDate = -7; // 初期値をセット
        } else {
          saveDate -= getSaveDate;
        }

        var ret1 = DateUtil.datetimeDatecalc(saleDate.$2, saveDate); // 圧縮ファイル保持可能な年月日を取得
        if (ret1.$1 != 0) {
          TprLog().logAdd(tid, LogLevelDefine.error, "aplLibPastCompFileTarFileDel : keepdate get error ret[${ret1.$1}]");
          return (-1);
        }

        var ret2 = AplLibStdAdd.aplLibProcScanDirBeta(tid, localPath, ret1.$2, aplLibPastCompFileDelChkFile);
        if (ret2 > 0) {
          // ファイルが1つでも削除できていればログを残す
          TprLog().logAdd(tid, LogLevelDefine.normal, "$tid: Target File[$localPath] delete OK");
        }
        break;
      default:
        break;
    }

    return DbError.DB_SUCCESS;
  }

  /// 機能    ：保持期間規定日数超過の圧縮ファイルを削除する処理
  /// 関連tprxソース: AplLib_PastCompFile.c - AplLib_PastCompFile_Del_ChkFile
  static SCAN_DIR_RESULT aplLibPastCompFileDelChkFile(TprMID tid, String fileName, String path, String? scanDirArg) {

    if(scanDirArg == null) {
      return SCAN_DIR_RESULT.SCAN_DIR_CONTINUE;
    }

    if (fileName.contains(PASTCOMPFILE_DEL_CHK)) {
      var dateTime = fileName.substring(PASTCOMPFILE_DEL_CHK.length); // ファイル名から日付を取得
      if (DateUtil.datetimeDaysCalc(scanDirArg, dateTime) < 0) {
        // 保持期間の規定日付以前のファイルかチェック
        // 保持期間日数を超過した圧縮ファイルを削除
        var tprxHome = EnvironmentData().env['TPRX_HOME'];
        var path = sprintf(RxMbrAtaChk.PASTCOMP_FILE_BKDIR, [tprxHome]); // /pj/tprx/tran_backup/bkcomp_file/

        try {
          Directory('$path$fileName').deleteSync();
        } catch (e) {
          TprLog().logAdd(tid, LogLevelDefine.error, "aplLibPastCompFileDelChkFile: file delete error[$fileName]");
          return SCAN_DIR_RESULT.SCAN_DIR_CONTINUE;
        }

        TprLog().logAdd(tid, LogLevelDefine.normal, "aplLibPastCompFileDelChkFile: file delete OK[$fileName]");

        return SCAN_DIR_RESULT.SCAN_DIR_OK; // 次のファイルを探す
      }
    }
    return SCAN_DIR_RESULT.SCAN_DIR_CONTINUE; // 次のファイルを探す
  }
}

/// 過去実績保持クラス
/// 関連tprxソース: AplLib_PastCompFile.c - PASTCOMP_DROP_TABLEINFO
class PastCompDropTableInfo {
  /// コール元のファンクションコード
  int backFuncCd = 0;
  /// 削除対象テーブル c_header_log のマシン番号名
  String cHeaderLogTableName = "";
  /// 削除対象テーブル c_data_log のマシン番号名
  String cDataLogTableName = "";
  /// 削除対象テーブル c_status_log のマシン番号名
  String cStatusLogTableName = "";
  /// 削除対象テーブル c_ej_log のマシン番号名
  String cEjLogTableName = "";
  /// 削除対象テーブル c_linkage_log のマシン番号名
  String cLinkageLogTableName = "";
}

/// 過去実績圧縮ファイル関連
/// 関連tprxソース: AplLib_PastCompFile.h - PASTCOMP_TEMP_TABLE
enum PastCompTempTable {
  /// c_header_log
  PASTCOMP_TEMP_TABLE_HEADERLOG,
  /// c_data_log
  PASTCOMP_TEMP_TABLE_DATALOG,
  /// c_status_log
  PASTCOMP_TEMP_TABLE_STATUSLOG,
  /// c_ej_log
  PASTCOMP_TEMP_TABLE_EJLOG,
  /// c_linkage_log
  PASTCOMP_TEMP_TABLE_LINKAGELOG,
  /// all table
  PASTCOMP_TEMP_TABLE_MAX,
}