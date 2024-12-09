/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../inc/lib/mcd.dart';
import '../inc/rc_crdt.dart';

class Rxcrdtcom{
  ///  関連tprxソース: rxcrdtcom.c - rx_arcs_nttasp_system
  static bool rxArcsNttaspSystem(int mbrTyp, int workInType){
    if((CmCksys.cmNttaspSystem() != 0)
      && (mbrTyp == Mcd.MCD_RLSCARD)
      && ((workInType == 2) || (workInType == 1))
      || (mbrTyp == Mcd.MCD_RLSHOUSE)
      || (mbrTyp == Mcd.MCD_RLSPREPAID)){
        return true;
    }
    return false;
  }

  // クレジット操作・表示・印字の拡張機能フラグチェック関数
  // 戻値:	TRUE:拡張する  FALSE:しない
  // 拡張機能:	クレジット宣言画面で, クレジット会計キーを使用出来る実行ボタンを表示する
  //		クレジット宣言画面で, 支払方法決定後、支払方法を表示する
  //		クレジット宣言画面で, 支払方法を変更可能な戻るボタンを表示する
  //		クレジット売上レシートで店舗控えを先に印字する
  ///  関連tprxソース: rxcrdtcom.c - rxCrdtComChkUIAdvanced
  static bool rxCrdtComChkUIAdvanced() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    // クレジット利用ユーザーは標準のみ (他の設定は特定動作があるため)
    if( ((pCom.dbTrm.userCd38 & 256) != 0)
      && (pCom.dbTrm.crdtUserNo == Datas.NORMAL_CRDT) )	 {
      return	true;
    }

    return false;
  }

}