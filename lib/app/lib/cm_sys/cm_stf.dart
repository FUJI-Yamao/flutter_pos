/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../common/cls_conf/staffJsonFile.dart';
import '../../inc/apl/rxmem_define.dart';
import '../cm_ean/mk_cdig.dart';
import '../cm_jan/set_zero.dart';
import '/app/inc/sys/tpr_type.dart';
import '/app/inc/sys/tpr_log.dart';
import 'cm_cksys.dart';

class CmStf {

  String SIMPLESTF_SECTION  = "simple_2staff";
  String SIMPLESTF_PERSON   = "person";
  String SIMPLESTF_ISSUE    = "issue";

  /// ２人制簡易従業員の設定を取得する。
  ///  関連tprxソース:cm_stf.c - cm_person_chk()
  ///  引数：なし
  ///  戻値：1:１人制 2:２人制 -1 : ERROR
  static Future<int> cmPersonChk() async {
    StaffJsonFile staff = StaffJsonFile();
    await staff.load();
    return staff.simple_2staff.person;
  }

  /// ２人制簡易従業員の設定を設定する。
  ///  関連tprxソース:cm_stf.c - cm_person_set()
  ///  引数：[person] 1:１人制 2:２人制
  ///  戻値：0:エラー 1:成功
  Future<int> cmPersonSet(int person) async {

    if ((person != 1) && (person != 2)) {
      return 0;
    }
    StaffJsonFile staff = StaffJsonFile();
    await staff.load();
    staff.simple_2staff.person = person;
    await staff.save();

    // 従業員人制状態確認ログ
    String log = "cmPersonSet: SET ${person} person\n";
    TprLog().logAdd(0, LogLevelDefine.normal, log);	/* TIDを取得できないので0番ログ */
    await staff.load();
    return staff.simple_2staff.person;
  }

  /**********************************************************************
      int cm_issue_chk(void)
      return  0 : issue / 1 : stop / -1 : ERROR
   ***********************************************************************/
  int cmIssueChk() {
    int   issue = 0;
    // char ini_path[TPRMAXPATHLEN];
    // char buf[10];
    //
    // sprintf(ini_path, "%s%s",getenv("TPRX_HOME") , STAFF_INI_PATH);
    // memset(buf, '\0', sizeof(buf));
    // if(TprLibGetIni(ini_path, SIMPLESTF_SECTION, SIMPLESTF_ISSUE, buf) != 0)
    // return -1;
    //
    // issue = (int)atol(buf);
    //
    return issue;
  }

  /**********************************************************************
      int cm_issue_set(int issue)
      argumente   0 : issue / 1 : stop
      return      0 : NG / 1 : OK
   ***********************************************************************/
  int cmIssueSet(int issue) {
    // char ini_path[TPRMAXPATHLEN];
    // char buf[10];
    //
    // if((issue != 0) && (issue != 1))
    // return 0;
    //
    // sprintf(buf, "%d", issue);
    // sprintf(ini_path, "%s%s", getenv("TPRX_HOME"), STAFF_INI_PATH);
    // if(TprLibSetIni(ini_path, SIMPLESTF_SECTION, SIMPLESTF_ISSUE, buf) != 0)
    // return 0;

    return 1;
  }


  /// 従業員入力桁数取得
  /// 引数:[typ] 0=従業員手入力  １=パスワード  2=従業員スキャン
  ///  関連tprxソース: cm_stf.c - apllib_StaffCD_Input_Limit()
  static Future<int> apllibStaffCDInputLimit(int typ) async {
    int	limit = 0;
    switch (typ) {
      case 1:
        limit = 8;
        break;
      case 2:
        if (await CmCksys.cmZHQSystem() != 0) {
          limit = 10;
        } else {
          limit = 9;
        }
        break;
      default:
        if (await CmCksys.cmZHQSystem() != 0) {
          limit = 3;
        } else if (await CmCksys.cmTb1System() != 0) {
          limit = 8;
        } else {
          limit = 9;
        }
        break;
    }
    return limit;
  }

  /*
 * 関数名     : apllib_staffcd_edit()
 * 機能概要   : 従業員コードを編集
 * 呼出方法   :
 * パラメータ : tid          タスクID
 *              typ          編集タイプ
 *              staff_cd     編集したい従業員番号
 *              staff_cd_len 編集後の従業員文字列
 *              digit        C/D用の0を付加しないorすr
 * 戻り値     : 編集後の従業員コード
 */
  int apllibStaffcdEdit(TprMID tid, int typ, String edit_staff_cd, int staff_cd, int staff_cd_len, int digit ) {
    int	staff_cd_ret = staff_cd;
  //   char	staff_cd_buf[staff_cd_len+1];
  //   char	Edit_Cd_Buf[16];
  //   RX_COMMON_BUF		*pCom;
  // /*----------------------------------------------------------------*/
  //
  //   memset (staff_cd_buf, 0x0, sizeof(staff_cd_buf));
  //   memset (Edit_Cd_Buf, 0x0, sizeof(Edit_Cd_Buf));
  //
  //   rxMemPtr(RXMEM_COMMON, (void **)&pCom);
  //
  //   switch (typ) {
  //     case 0:
  //       /* 手入力用 1 -> ster_cd7+001 or 000000001 */
  //       if (cm_ZHQ_system()) {
  //         snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%07ld%%0%dlld", apllibStaffCDInputLimit(0));
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, pCom->ini_macinfo.shpno % 10000000L, staff_cd % 1000LL);
  //       } else {
  //         snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%0%dlld", apllibStaffCDInputLimit(0));
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd);
  //       }
  //       if ((digit) && (atoll(staff_cd_buf) > 999999L)) {
  //         staff_cd_buf[strlen(staff_cd_buf)] = '0';
  //       }
  //       break;
  //     case 1:
  //       /*  表示用ゼロパティング 123456 -> 456 or 000123456 */
  //       snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%0%dlld", apllibStaffCDInputLimit(0));
  //       if (cm_ZHQ_system()) {
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd % 1000LL);
  //       } else {
  //       snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd); /* @@@ V15 表示を広げる */
  //       }
  //       break;
  //     case 2:
  //       /* cm_set_jan_inf()用 0付加でC/Dエラー回避  */
  //       snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%0%dlld", apllibStaffCDInputLimit(2));
  //     //			if (cm_ZHQ_system())
  //     //			{
  //       snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd);
  //       if ((digit)  && (atoll(staff_cd_buf) > 999999L)) {
  //         staff_cd_buf[strlen(staff_cd_buf)] = '0';
  //         if (digit == 2) {
  //           cm_mk_cdigit_variable(staff_cd_buf, strlen(staff_cd_buf));
  //           cm_plu_set_zero( staff_cd_buf );
  //         }
  //       }
  //     //			}
  //     //			else
  //     //			{
  //     //				snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd); /* @@@ V15 表示を広げる */
  //     //			}
  //       break;
  //     case 3:
  //       /* その他 123456 -> 000123456 */
  //       snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%0%dlld", apllibStaffCDInputLimit(2));
  //     //			if (cm_ZHQ_system())
  //     //			{
  //     //				snprintf (staff_cd_buf, sizeof(staff_cd_buf), "%010lld", staff_cd);
  //     //			}
  //     //			else
  //       {
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd); /* @@@ V15 表示を広げる */
  //       }
  //       break;
  //     case 4:
  //       /*  表示用ゼロパティングしないで左詰め 000123456 -> 456 or 123456  */
  //       snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%lld");
  //       if (cm_ZHQ_system()) {
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd % 1000LL);
  //       } else {
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd); /* @@@ V15 表示を広げる */
  //       }
  //       break;
  //     case 5:
  //       /* 手入力用ゼロパティングしないで左詰め 1 -> stre_cd7桁+001 or 1  */
  //       if (cm_ZHQ_system()) {
  //         snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%ld%%0%dlld", apllibStaffCDInputLimit(0));
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, pCom->ini_macinfo.shpno % 10000000L, staff_cd % 1000LL);
  //       } else {
  //         snprintf (Edit_Cd_Buf, sizeof(Edit_Cd_Buf), "%%lld");
  //         snprintf (staff_cd_buf, sizeof(staff_cd_buf), Edit_Cd_Buf, staff_cd);
  //       }
  //       if ((digit) && (atoll(staff_cd_buf) > 999999L)) {
  //         staff_cd_buf[strlen(staff_cd_buf)] = '0';
  //       }
  //       break;
  //  }
  //   strncpy (edit_staff_cd, staff_cd_buf, staff_cd_len);
  //
  //   staff_cd_ret = atoll(staff_cd_buf);
    return staff_cd_ret;
  }

  /// 従業員コードを編集
  /// 引数:[tid] タスクID
  /// 引数:[typ] 編集タイプ
  /// 引数:[staffCd] 従業員番号
  /// 引数:[digit] チェックディジット（0=なし  0以外=あり）
  /// 戻り値:[String] 編集後従業員番号の出力指定子
  /// 戻り値:[int] 編集後従業員番号
  ///  関連tprxソース: cm_stf.c - apllib_staffcd_edit()
  static Future<(String, int)> apllibStaffCdEdit(
      TprMID tid, int typ, int staffCd, int digit) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    int retNum = 0;
    String staffCdBuf = "";

    switch (typ) {
      case 0:  //手入力用 1 -> ster_cd7+001 or 000000001
        if (await CmCksys.cmZHQSystem() != 0) {
          staffCdBuf = "${"${pCom.iniMacInfo.system.shpno % 10000000}".padLeft(
              7, "0")}${"${staffCd % 1000}".padLeft(
              await apllibStaffCDInputLimit(0), "0")}";
        } else {
          staffCdBuf =
          "${"$staffCd".padLeft(await apllibStaffCDInputLimit(0), "0")}";
        }
        if ((digit != 0) && (int.parse(staffCdBuf) > 999999)) {
          staffCdBuf += "0";
        }
        break;
      case 1:  //表示用ゼロパティング 123456 -> 456 or 000123456
        if (await CmCksys.cmZHQSystem() != 0) {
          staffCdBuf = "${staffCd % 1000}".padLeft(
              await apllibStaffCDInputLimit(0), "0");
        } else {
          staffCdBuf =
          "$staffCd".padLeft(await apllibStaffCDInputLimit(0), "0");
        }
        break;
      case 2:  //cm_set_jan_inf()用 0付加でC/Dエラー回避
        staffCdBuf = "$staffCd".padLeft(await apllibStaffCDInputLimit(2), "0");
        if ((digit != 0)  && (int.parse(staffCdBuf) > 999999)) {
          staffCdBuf += "0";
          if (digit == 2) {
            staffCdBuf =
                MkCdig.cmMkCdigitVariable(staffCdBuf, staffCdBuf.length);
            staffCdBuf = SetZero.cmPluSetZero(staffCdBuf);
          }
        }
        break;
      case 3:  //その他 123456 -> 000123456
        staffCdBuf = "$staffCd".padLeft(await apllibStaffCDInputLimit(2), "0");
        break;
      case 4:  //表示用ゼロパティングしないで左詰め 000123456 -> 456 or 123456
        if (await CmCksys.cmZHQSystem() != 0) {
          staffCdBuf = "${staffCd % 1000}";
        } else {
          staffCdBuf = "$staffCd";
        }
        break;
      case 5:  //手入力用ゼロパティングしないで左詰め 1 -> stre_cd7桁+001 or 1
        if (await CmCksys.cmZHQSystem() != 0) {
          staffCdBuf =
          "${pCom.iniMacInfo.system.shpno % 10000000}${"${staffCd % 1000}"
              .padLeft(await apllibStaffCDInputLimit(0), "0")}";
        } else {
          staffCdBuf = "$staffCd";
        }
        if ((digit != 0) && (int.parse(staffCdBuf) > 999999)) {
          staffCdBuf += "0";
        }
        break;
      default:
        break;
    }
    retNum = int.parse(staffCdBuf);

    return (staffCdBuf, retNum);
  }
}
