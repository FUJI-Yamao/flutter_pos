/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';

class RcMbrpManual{
  /// 機能：割戻レコードかチェックする。
  /// 引数：int itmcnt   アイテムログの段
  /// 戻値：0:その他のレコード  1:割戻レコード
  /// 関連tprxソース:rcmbrpmanual.c - rcmbr_ChkItmRBuf_Rbt(long itmcnt)
  static bool rcmbrChkItmRBufRbt(int itmcnt) {
      return(RegsMem().tItemLog[itmcnt].t10003.recMthdFlg == REC_MTHD_FLG_LIST.MBRRBT_REC.typeCd);
  }
}