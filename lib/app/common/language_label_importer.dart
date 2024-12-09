/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/foundation.dart';
import '../../postgres_library/src/db_manipulation_ps.dart';
import '../inc/apl/rxmem_define.dart';
import 'cls_conf/mac_infoJsonFile.dart';
import '../inc/sys/tpr_log.dart';
import 'cmn_sysfunc.dart';

// =========================================================================
/// 多言語ラベルDB登録クラス
// =========================================================================
class LanguageLabelImporter {
  // 多言語ラベルファイルパス
  static const _languageLabelInsertFile = "assets/sql/insert/mm_languagemst_ins.out";
  static const _languageLabelDeleteFile = "assets/sql/insert/mm_languagemst_del.out";

  // -----------------------------------------------------------------------
  /// 多言語ラベル取り込み処理
  // -----------------------------------------------------------------------
  Future<bool> execute() async {
    try {
      /// 設定ファイル読み込み
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        const jsonError = "共有メモリ（RXMEM_COMMON）の読み込みに失敗しました。";
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, jsonError);
        return false;
      }
      RxCommonBuf pCom = xRet.object;

      var macJson = pCom.iniMacInfo;
      /// 値が読み込めていなければエラー
      if(macJson.system.macno == 0
          || macJson.system.shpno == 0
          || macJson.system.crpno == 0) {
        const jsonError = "設定ファイルの読み込みに失敗しました。";
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, jsonError);
        return false;
      }
      /// 承認キーデータの読み込み
      List<String> approvalKeys = [
        "COMP=${macJson.system.crpno}",
        "STRE=${macJson.system.shpno}",
        "MACNO=${macJson.system.macno}"];
      /// 多言語ラベル取り込みSQLの実行
      var dbManipulation = DbManipulationPs();
      /// 不要ラベルの削除
      String deleteError =
      await dbManipulation.execSqlFromAsset(_languageLabelDeleteFile, approvalKeys);
      /// エラー時はログ出力
      if (deleteError.isNotEmpty){
        if (kDebugMode) { print(deleteError); }
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, deleteError);
        return false;
      }
      /// 新規ラベルの追加
      String insertError =
      await dbManipulation.execSqlFromAsset(_languageLabelInsertFile, approvalKeys);
      /// エラー時はログ出力
      if (insertError.isNotEmpty){
        if (kDebugMode) { print(insertError); }
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, insertError);
        return false;
      }
      return true;
    /// 例外時はログを出力しNGを返す
    } catch(ex) {
      if (kDebugMode) { print(ex.toString()); }
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error, ex.toString());
      return false;
    }
  }
}