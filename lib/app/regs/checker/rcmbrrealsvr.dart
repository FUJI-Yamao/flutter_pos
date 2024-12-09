/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/customer_table_access.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'rcsyschk.dart';

class Rcmbrrealsvr {
  static const CUSTREAL_MBRDSP_START = 1;

  static int custrealStep = 0;
  static int custrealMbrdspFlg = 0;
  static int custrealRwflg = 0;
  static int svrOfflineChkFlg = 0;

  /// 関連tprxソース:C: rcmbrrealsvr.c - CustRealSvrSetPromCd()
  // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  static void custRealSvrSetPromCd(TTtlLog ttlLog) {
  }

  /// 関連tprxソース:rcmbrrealsvr.c - CustReal_MbrDspChk
  static bool custRealMbrDspChk() {
    return (custrealMbrdspFlg == CUSTREAL_MBRDSP_START);
  }

  /// 関連tprxソース:rcmbrrealsvr.c - CustReal_memberStepSet
  static void custRealMemberStepSet(int step) {
    custrealStep = step;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客サーバー未実装）
  /// 引数:[waitFlg] 処理待ち時間
  /// 引数:[mbrCd] 顧客番号
  /// 引数:[cust] 顧客マスタ (c_cust_mst)
  /// 引数:[enq] 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  /// 戻り値: エラーコード
  /// 関連tprxソース:rcmbrrealsvr.c - CustRealSvrFlRd
  static int custRealSvrFlRd(int waitFlg, String mbrCd,
      CCustMstColumns cust, SCustTtlTbl enq) {
    return 0;
  }

  /// todo 動作未確認
  /// 関連tprxソース:rcmbrrealsvr.c - CustRealSvr_WaitChk
  static Future<bool> custRealSvrWaitChk() async
  {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return( (RcSysChk.rcChkCustrealsvrSystem() || await RcSysChk.rcChkCustrealNecSystem(0)) &&
            (custrealRwflg != 0     ) &&
            (cBuf.custOffline == 1)   );
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// オフラインダイアログを表示する
  /// 引数: 確認ボタン押下時に処理する関数
  /// 戻り値: エラーNo
  /// 関連tprxソース:rcmbrrealsvr.c - CustRealSvrOffL_Dlg
  static int custRealSvrOffLDlg(Function func1) {
    return 0;
  }
}
