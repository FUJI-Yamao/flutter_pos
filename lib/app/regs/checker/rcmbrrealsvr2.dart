/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_regs.dart';
import '../inc/rc_mem.dart';
import 'rcsyschk.dart';

import '../../inc/apl/rxregmem_define.dart';

class Rcmbrrealsvr2{
  /// 関連tprxソース:C: rcmbrrealsvr2.c - rcwebreal_dsp()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static void rcwebrealDsp(){
    return;
  }

  /// 関連tprxソース:C: rcmbrrealsvr2.c - CustReal2SvrAdd()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static int CustReal2SvrAdd(int sub){
    int ret = DlgConfirmMsgKind.MSG_SYSERR as int;
    /*中身の実装は後程*/
    return ret;
  }

  /// 関連tprxソース:C: rcmbrrealsvr2.c - rcwebreal_DialogErr()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static int rcwebrealDialogErr(int erCode, int userCode){
    return 0;
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C: rcmbrrealsvr2.c - CustReal_PointArtist_FlRd()
  static int custRealPointArtistFlRd(
      int waitFlg, String mbrCd,
      CCustMst cust, SCustTtlTbl enq, int cardExecFlg) {
    return 0;
  }

  /// 関連tprxソース:C: rcmbrrealsvr2.c - rcCustRealOP_Update()
  // TODO:00014 日向 現計対応のため、定義のみ追加
  static void rcCustRealOPUpdate(int funcCd) {
    return;
  }

  /// 関連tprxソース:C: rcmbrrealsvr2.c - rcrealsvr2_Tpoint_Use()
  //実装は必要だがARKS対応では除外
  static int rcRealsvr2TpointUse(int kbn, TTtlLog ttllog) {
    return 0;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcrealsvr2_Tpoint_Err_SpCncl()
  //実装は必要だがARKS対応では除外
  static void rcrealsvr2TpointErrSpCncl() {
    return;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcrealsvr2_Tpoint_BatCpnUse()
  // TODO:00014 日向 現計対応のため、定義のみ追加
  static void rcrealsvr2TpointBatCpnUse() {
    return;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcrealsvr2_Tpoint_CouponIssue()
  //実装は必要だがARKS対応では除外
  static int rcrealsvr2TpointCouponIssue(int flg) {
    return 0;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcrealsvr2_Tpoint_CpnMsg()
  //実装は必要だがARKS対応では除外
  static void rcrealsvr2TpointCpnMsg() {
    return;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rc_pointartist_socket_err()
  // TODO:00014 日向 現計対応のため、定義のみ追加
  static void rcPointartistSocketErr(int funcCd, int errNo) {
    return;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcCustReal2_PTactix_ProcChk()
  // TODO:00014 日向 現計対応のため、定義のみ追加
  static int rcCustReal2PTactixProcChk(int type) {
    return 0;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcCustReal2_PTactix_Update()
  // TODO:00014 日向 現計対応のため、定義のみ追加
  static int rcCustReal2PTactixUpdate(RegsMem mem, int comTyp, int voidFlg) {
    return 0;
  }
  // 関連tprxソース:C: rcmbrrealsvr2.c - rcCustReal2_PTactix_DispErrPopup()
  // TODO:00014 日向 現計対応のため、定義のみ追加
  static void rcCustReal2PTactixDispErrPopup(String callFunc, int errNo) {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcmbrrealsvr2.c - rcCustReal2_PTactix_ErrorCode()
  static void rcCustReal2PTactixErrorCode() {
    return ;
  }

  /// Tポイントサーバーとのエラー通信結果を返す
  /// 引数: リターンコード
  /// 戻り値: 通信結果によるエラーコード
  /// 関連tprxソース:C: rcmbrrealsvr2.c - rcrealsvr2_Tpoint_ReturnCd_Get()
  static int rcrealsvr2TpointReturnCdGet(int retcd) {
    int errNo;

    switch (retcd) {
      case 0:
        errNo = Typ.OK;
        break;
      case 10:
        errNo = DlgConfirmMsgKind.MSG_TMBR_NOTREG.dlgId; /* このＴ会員番号は会員登録されていません */
        break;
      case 11:
        errNo = DlgConfirmMsgKind.MSG_TMBR_INVALID.dlgId; /* このＴ会員番号は無効です */
        break;
      case 12:
        errNo = DlgConfirmMsgKind.MSG_DOB_NOTREG.dlgId; /* 生年月日が未登録です */
        break;
      case 13:
        errNo = DlgConfirmMsgKind.MSG_DOB_INCORRECT.dlgId; /* 入力された生年月日に誤りがあります */
        break;
      case 14:
        errNo = DlgConfirmMsgKind.MSG_TMBR_NOTUPD.dlgId; /* このＴ会員番号は会員情報が未反映です */
        break;
      case 80:
        errNo = DlgConfirmMsgKind.MSG_NOTUSEPNT_TIME.dlgId; /* ポイントがご利用になれない時間帯です */
        break;
      case 5:
      case 15:
      case 16:
      case 18:
      case 53:
      case 90:
      case 99:
        errNo = DlgConfirmMsgKind.MSG_CTR_ERR_CALL.dlgId; /* センターでエラーが発生しました。コールセンターにお問合せ下さい */
        break;
      case 4:
        errNo = DlgConfirmMsgKind.MSG_COM_ERR_CALL.dlgId; /* 通信エラーが発生しました。コールセンターにお問合わせ下さい */
        break;
      case 17:
        errNo = DlgConfirmMsgKind.MSG_PNTSHORT.dlgId; /* ポイントが足りません */
        break;
      default:
        errNo = DlgConfirmMsgKind.MSG_COM_ERR_CALL.dlgId; /* 通信エラーが発生しました。コールセンターにお問合わせ下さい */
        break;
    }
    return errNo;
  }
}
