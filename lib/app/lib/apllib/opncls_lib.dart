/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// OpnClsLibクラスで宣言される関数の戻り値を定義するクラス
class OpnClsLibRet {
  /// 関数の成否結果
  bool isSuccess = true;
  /// エラーメッセージID
  int errMsgId;
  /// 従業員名
  String name;
  /// パスワード
  String passwd;
  /// 同時オープンフラグ
  int noChkOverlap;
  /// レジユーザーレベル
  int tprLvlCd;

  OpnClsLibRet(this.isSuccess,
      [this.errMsgId=0, this.name="", this.passwd="", this.noChkOverlap=0, this.tprLvlCd=0]);
}

/// 関連tprxソース: opncls_lib.c
class OpnClsLib {
  static const OPNCLS_STATUS_CLOSE = 0;
  static const OPNCLS_STATUS_OPEN = 1;
  static const OPNCLS_STATUS_OFF = 2;

  /// 従業員マスタから従業員名、パスワードを読み込む（+無効従業員のチェック付き）
  /// 引数:[tid] タスクID
  /// 引数:[staffCd] 従業員番号
  /// 戻り値: OpnClsLibRetクラス
  /// 関連tprxソース: opncls_lib.c - cm_opncls_read_staff(), cm_opncls_check_invalid_staff()
  static Future<OpnClsLibRet> cmOpnClsReadStaff(TprMID tid, int staffCd) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error,
          "competitionIniGetRcptNo() rxMemRead error\n");
      return OpnClsLibRet(false);
    }
    RxCommonBuf pCom = xRet.object;

    int errId = 0;
    DbManipulationPs db = DbManipulationPs();
    String sql = "SELECT * FROM c_staff_mst WHERE comp_cd='${pCom.dbRegCtrl.compCd}' and staff_cd = $staffCd;";

    try {
      Result res = await db.dbCon.execute(sql);
      //「従業員が存在しない or 異常状態」かチェック
      if (res.affectedRows != 1) {
        errId = DlgConfirmMsgKind.MSG_NONEREC.dlgId;
        return OpnClsLibRet(false, errId);
      }
      // DBから各カラムパラメタを読み取り
      String name = "";
      String passwd = "";
      int status = 0;
      int nochkOverlap = 0;
      for (var result in res) {
        Map<String, dynamic> data = result.toColumnMap();
        name = data["name"] ?? "";
        passwd = data["passwd"] ?? "";
        status = data["status"];
        nochkOverlap = data["nochk_overlap"];
        break;
      }
      // 無効従業員かチェック
      if (status == 2) {
        errId = DlgConfirmMsgKind.MSG_INVALID_STAFF.dlgId;
        return OpnClsLibRet(false, errId);
      }
      return OpnClsLibRet(true, errId, name, passwd, nochkOverlap);
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(
          tid, LogLevelDefine.error, "cmOpnClsReadStaff():db_PQexec error");
      errId = DlgConfirmMsgKind.MSG_FILEACCESS.dlgId;
      return OpnClsLibRet(false, errId);
    }
  }
}
