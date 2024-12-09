/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';

/// 従業員権限の取得クラス.
///  関連tprxソース: staff_auth.c
class StaffAuth {
  /// ユーザーレベル：メンテナンスユーザー
  static const USERLVL_MENTE = 9;

  /// 従業員情報をメモリにセットする.
  /// 引数:[tid] タスクID.
  /// 引数:[pCom] セットしたい共有クラス（RxCommonBuf）
  /// 引数:[num] セットしたい共有メモリ番号（cashier,checker,login）
  /// 引数:[lvl] セットする従業員権限レベル
  /// 引数:[name] セットする従業員名
  /// 引数:[staffCd] セットする従業員番号
  ///  関連tprxソース: staff_auth.c - staff_info_set()
  static void SetStaffInfo(int tid, RxCommonBuf pCom, StaffInfoIndex num,
      int lvl, String? name, int staffCd) {
    pCom.staffInfoList[num.index].authLvl = lvl;
    pCom.staffInfoList[num.index].staffCd = staffCd;
    if (name != null && name.isNotEmpty) {
      pCom.staffInfoList[num.index].name = name;
    }
  }

  /// 従業員権限レベルを取得する.
  /// 引数:[tid] タスクID.
  /// 引数:[staffCd] 権限レベルを取得したい従業員番号
  /// 戻り値:権限レベル
  ///  関連tprxソース: staff_auth.c - staffauth_get()
  static Future<int> getStaffAuth(int tid, String staffCd) async {
    try {
      int rtLevel = -1;
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(tid, LogLevelDefine.error, "rxMemRead ERROR");
        return -1;
      }
      RxCommonBuf pCom = xRet.object;
      var dbAccess = DbManipulationPs();
      String sql =
          "SELECT auth_lvl FROM c_staff_mst WHERE staff_cd = @staff AND comp_cd = @comp";
      Map<String, dynamic>? subValues = {
        "staff" : staffCd,
        "comp"  : pCom.iniMacInfoCrpNoNo
      };

      Result dataList = await dbAccess.dbCon.execute(Sql.named(sql),parameters: subValues);
      if (dataList.isNotEmpty) {
        Map<String,dynamic> data = dataList.first.toColumnMap();
        rtLevel = data["auth_lvl"] == null
            ? -1
            : data["auth_lvl"] as int;
      }
      return rtLevel;
    } catch (e, s) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, "db_PQexec return error getStaffAuth()");
      return -1;
    }
  }

  /// メニューの権限レベルの取得
  /// 引数:[tid] タスクID
  /// 引数:[grpCd] アプリグループコード
  /// 引数:[compCd] 企業コード
  /// 引数:[streCd] 店舗コード
  /// 戻り値:権限レベルチェック件数
  ///  関連tprxソース: staff_auth.c - menuauth_get()
  static Future<Result?> menuAuthGet(
      int tid, int grpCd, int compCd, int streCd) async {
    DbManipulationPs db = DbManipulationPs();
    Result? res;
    String sql = "SELECT menuauth.auth_lvl, appl_grp.menu_chk_flg "
        "FROM c_menuauth_mst menuauth, c_appl_grp_mst appl_grp "
        "WHERE menuauth.comp_cd='$compCd' AND appl_grp.comp_cd='$compCd' AND "
        "appl_grp.stre_cd='$streCd' AND menuauth.appl_grp_cd='$grpCd' AND "
        "appl_grp.appl_grp_cd='$grpCd' ORDER BY menuauth.auth_lvl;";

    try {
      res = await db.dbCon.execute(sql);
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(
          tid, LogLevelDefine.error, "menuAuthGet():db_PQexec error");
    }

    return res;
  }

  /// メインメニュー用従業員権限レベルチェック（チェックタイプ指定なし）
  /// 引数:[tid] タスクID
  /// 引数:[grpCd] アプリグループコード
  /// 引数:[staffCd] 権限チェックする従業員コード
  /// 戻り値:権限レベル（0=権限OK  1=権限NG  2=権限NG(パスワード付き)）
  ///  関連tprxソース: staff_auth.c - menuauth_chk()
  static Future<int> menuAuthChk(int tid, int grpCd, int staffCd) async {
    return await menuAuthChk2(tid, grpCd, staffCd, null);
  }

  /// メインメニュー用従業員権限レベルチェック（チェックタイプ指定なし）
  /// 引数:[tid] タスクID
  /// 引数:[grpCd] アプリグループコード
  /// 引数:[staffCd] 権限チェックする従業員コード
  /// 引数:[chkFlg] チェックタイプを戻すフラグ
  /// 戻り値:権限レベル（0=権限OK  1=権限NG  2=権限NG(パスワード付き)）
  ///  関連tprxソース: staff_auth.c - menuauth_chk2()
  static Future<int> menuAuthChk2(
      int tid, int grpCd, int staffCd, int? chkFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "menuAuthChk2(): rxMemPtr error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    Result resDb;
    Result? tmpDb = await menuAuthGet(
        tid, grpCd, pCom.iniMacInfo.system.crpno, pCom.iniMacInfo.system.shpno);
    try {
      resDb = tmpDb!;
      if (resDb.affectedRows <= 0) {
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "menuAuthChk2(): check level nothing");
        if (chkFlg != null) {
          chkFlg = 0;
        }
        return 0;
      }
    } catch (e) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "menuAuthChk2(): check level read error");
      return 0;
    }

    int pswdFlg = 0;
    int chkMax = StaffInfoIndex.STAFF_INFO_MAX.index;
    List<int> chkAuth = List.filled(StaffInfoIndex.STAFF_INFO_MAX.index, -1);
    if (staffCd == 0) {
      /* オープンもログインもしていない場合で、権限のチェックがある場合は、パスワード付きにする */
      for (int i = 0; i < StaffInfoIndex.STAFF_INFO_MAX.index; i++) {
        if (pCom.staffInfoList[i].authLvl < 0) {
          pswdFlg++;
        }
        chkAuth[i] = pCom.staffInfoList[i].authLvl;
      }
      if (pswdFlg == StaffInfoIndex.STAFF_INFO_MAX.index) {
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "menuAuthChk2(): auth check nothing -> password");
        pswdFlg = 1;
      } else {
        pswdFlg = 0;
      }
    } else {
      chkAuth[0] = await getStaffAuth(tid, staffCd.toString());
      chkMax = 1;
    }

    int tuples = resDb.affectedRows;
    int chkLvl = 0;
    int num = 1;
    int lvlOk = 0;
    int unmachFlg = 0;
    int ret = 0;
    int unmachRet = 0;
    for (var result in resDb) {
      Map<String, dynamic> data = result.toColumnMap();
      chkLvl = data["auth_lvl"];
      if (chkFlg != null) {
        chkFlg = data["menu_chk_flg"];
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, "menuAuthChk2(): [$num/$tuples] checklvl = $chkLvl appl_grp_cd[$grpCd] passwd[$pswdFlg]");
      for (int i = 0; i < chkMax; i++) {
        if ((chkLvl < 0) ||
            (pCom.staffInfoList[i].authLvl == USERLVL_MENTE)) {
          // チェックレベルがマイナスの場合は強制OKとする
          lvlOk++;
        } else {
          //従業員権限チェック
          if (chkLvl == chkAuth[i]) {
            //権限なし：そのまま抜ける
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "menuAuthChk2(): staff[$i:${staffCd.isNaN ? pCom
                    .staffInfoList[i].staffCd : staffCd}] auth[${pCom
                    .staffInfoList[i].authLvl}] unmach error!!!");
            unmachFlg = 1;
          } else if (chkAuth[i] < 0) {
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "menuAuthChk2(): staff[$i:${staffCd.isNaN ? pCom
                    .staffInfoList[i].staffCd : staffCd}] auth[${pCom
                    .staffInfoList[i].authLvl} pswd_flg[$pswdFlg] check passwrd");
          } else {
            //権限あり
            lvlOk++;
          }
        }
      }
      if (lvlOk == 0) {
        ret++;
      }
      if (unmachFlg != 0) {
        unmachRet++;
      }
    }

    // 一個でもOKな従業員があれば権限OKとする。retがレコード数分あるのでエラー
    if (ret >= tuples) {
      ret = 1;
    }
    // OKではあるが、権限チェック数分の権限エラーが存在した場合はエラー
    if ((ret == 0) && (tuples >= 2) && (unmachRet >= tuples)) {
      ret = 1;
    }
    if ((pswdFlg > 0) && (ret != 0)) {
      ret = 2;
    }
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "menuAuthChk2(): check level ret[$ret]");
    
    return ret;
  }

  /// ファンクションキー用従業員指定権限レベルチェック
  /// （登録ではオープンした従業員でチェックをするようにCMEMに展開済み）
  /// 引数:[tid] タスクID
  /// 引数:[staffCd] 権限レベルを取得したい従業員コード
  /// 引数:[fncCd] チェックしたいファンクションキー
  /// 戻り値:権限レベル（0=権限OK  1=権限NG）
  ///  関連tprxソース: staff_auth.c - keyauth_chk()
  static Future<int> keyAuthChk(int tid, int staffCd, int fncCd) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "keyAuthChk(): rxMemPtr error");
      return 1;
    }
    RxCommonBuf pCom = xRet.object;

    DbManipulationPs db = DbManipulationPs();
    String sql = "SELECT fnc_cd FROM c_keyauth_mst "
        "WHERE comp_cd='${pCom.iniMacInfo.system.crpno}' AND fnc_cd = '$fncCd' AND "
        "auth_lvl = (SELECT auth_lvl FROM c_staff_mst WHERE staff_cd ='$staffCd') "
        "ORDER BY fnc_cd;";

    try {
      Result res = await db.dbCon.execute(sql);
      if (res.affectedRows > 0) {
        return 1;
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(
          tid, LogLevelDefine.error, "keyAuthGet():db_PQexec error");
      return 1;
    }
    return 0;
  }

  /// 従業員の特定操作権限レベルチェック
  /// 引数:[tid] タスクID
  /// 引数:[staffCd] 権限レベルを取得したい従業員コード
  /// 引数:[opeCd] チェックする操作
  /// 戻り値:権限レベル（0=権限OK  1=権限NG）
  ///  関連tprxソース: staff_auth.c - operationauth_chk()
  static Future<int> operationAuthChk(int tid, int staffCd, int opeCd) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "keyAuthChk(): rxMemPtr error");
      return 1;
    }
    RxCommonBuf pCom = xRet.object;

    DbManipulationPs db = DbManipulationPs();
    String sql = "SELECT ope_cd FROM c_operationauth_mst "
        "WHERE comp_cd='${pCom.iniMacInfo.system.crpno}' AND ope_cd = '$opeCd' AND "
        "auth_lvl = (SELECT auth_lvl FROM c_staff_mst WHERE staff_cd ='$staffCd') "
        "ORDER BY ope_cd;";

    try {
      Result res = await db.dbCon.execute(sql);
      if (res.affectedRows > 0) {
        return 1;
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(
          tid, LogLevelDefine.error, "keyAuthGet():db_PQexec error");
      return 1;
    }
    return 0;
  }
}
