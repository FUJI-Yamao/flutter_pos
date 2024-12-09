/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:get/get.dart';

import '../../ui/menu/register/m_menu.dart';
import '../../ui/page/subtotal/controller/c_payment_controller.dart';
import 'rc_atct.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rc_atctd.c
class RcAtctD {

  ///  関連tprxソース: rc_atctd.c - rcATCT_Display
  static void rcATCTDisplay(TendType eTendType){

    // TODO:10158 商品券支払い 実装対象外
    // if(rc_Check_WizAdj_Update()) {
    //   TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "ATCT Display Skip !! for WizAdj\n");
    //   return;
    // }
    //
    // #if RESERV_SYSTEM
    // if( rcCheck_ReservMode() ) {
    // if( rcreserv_PrnSkipChk() )
    // return;
    // }
    // #endif
    //
    // if( rcQC_Chk_Qcashier_System() )
    // return;

    // TODO:10158 商品券支払い 必要なTendTypeの処理のみ実装
    switch(eTendType){
      case TendType.TEND_TYPE_NO_ENTRY_DATA:
      case TendType.TEND_TYPE_TEND_AMOUNT:
      // フロントを完了画面へ
        SetMenu1.navigateToPaymentCompletePage();
        break;
      case TendType.TEND_TYPE_SPRIT_TEND:
        SetMenu1.navigateToPaymentSelectPage();
        break;
      default:
        break;
    }

  }

}