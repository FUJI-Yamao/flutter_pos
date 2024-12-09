/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: AplLib_TrmSysCheck.c
class AplLibTrmSysCheck {

  ///	機能:	参照用のデータを作成する関数. グループの概念を持つテーブルにのみ使用可能. 
  ///		ターミナルは初期値と異なるもののみを表示する機能があるため, 作成している.
  ///		ファイルリクエスト, バージョンアップ時に実行する.
  ///	引数:	tid: タスクID
  ///		  : compCd: 企業コード
  ///		  : streCd: 店舗コード
  ///		  : grpCdName: 作成するマスタのグループコードのカラム名
  ///	戻値:	0: OK  -1: NG 
/// 関連tprxソース: AplLib_TrmSysCheck.c - AplLib_Set_ReferenceData
  static Future<int> setReferenceData( TprMID tid, int compCd, int streCd, String grpCdName ) async {
    String cmd = "";
    int	ret;
    cmd = "${EnvironmentData.TPRX_HOME}/apl/db/./create_mm_separate";
    try {
      ProcessResult procResult = await Process.run(cmd, ["$compCd,$streCd,0,GRP,$grpCdName"]);
      ret = procResult.exitCode;
    } catch(e,s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "setReferenceData(): error ($cmd) $e,$s", errId: -1);
      ret = -1;
    }
    return ret;
  }

}