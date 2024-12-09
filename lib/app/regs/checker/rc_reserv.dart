/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemcogca.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_regs.dart';
import 'rcfncchk.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rc_reserv.h - RESERV_INFO構造体
class ReservInfo {
  int cardDspFlg = 0;
  int colorfipPopupChk = 0; //予約中フラグ
  RxMemCogcaCard keepCard = RxMemCogcaCard();	/* CoGCaカード情報一時格納 */
}

/// 関連tprxソース: rc_reserv.h
class ReservDef {
  static int RESERV_PRNSKIP = 10;
}

class RcReserv {
  static int reservPrnSkipFlg = 0;
  static ReservInfo reserv = ReservInfo();

  /// 関連tprxソース:rc_reserv.c - reserv_finish_chk()
  static int reservFinishChk(String reservCd) {
    return 0;
  }

  /// 関連tprxソース:rc_reserv.c - rcReserv_ItmAddChk()
  static bool rcReservItmAddChk() {
    return false;
  }

  /// 関連tprxソース:rc_reserv.c - rc_reserv()
  static int rcReserv(int reservFlg) {
    return 0;
  }

  /// 関連tprxソース:rc_reserv.c - rcreserv_ReceiptCall()
  static bool rcReservReceiptCall() {
    RegsMem mem = RegsMem();
    return( (mem.tmpbuf.reservMode == RcRegs.RESERV_MODE_RESERV)
        && (mem.tmpbuf.reservTyp == RcRegs.RESERV_CALL) );
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rc_reserv.c - rcReserv_ChkReservTbl()
  static bool rcReservChkReservTbl() {
    return false;
  }

  /// 関連tprxソース:rc_reserv.c - rcreserv_ReceiptAdvance
  static Future<int> rcreservReceiptAdvance() async {
    int amt = 0;
    RegsMem regsMem = RegsMem();

    if(await CmCksys.cmReservSystem() != 0){
      amt = RegsMem().tTtllog.t600000.advanceMoney;
    }else{
      if(RegsMem().tTtllog.t600000.advanceMoney < RxLogCalc.rxCalcStlTaxInAmt(regsMem)){
        amt = RegsMem().tTtllog.t600000.advanceMoney;
      }else{
        amt = RxLogCalc.rxCalcStlTaxInAmt(regsMem);
      }
    }
    return amt;
  }

  /// 関連tprxソース:rc_reserv.c - rcReserv_NotUpdate
  static Future<bool> rcReservNotUpdate() async {
    //aaaa 商品追加判定が必要
//     #if 0
//     return( (C_BUF->db_trm.reserve_prepay_postpay_actsale            ) &&
//     (cm_Reserv_system()                      ) &&
//     (!rcCheck_ReservMode()                   ) &&
//     (rcreserv_ReceiptCall()                  ) &&
//     (rcresev_cash_typ()                      ) &&
//     (MEM->tmpbuf.reserv_tax_chg_flg == 0            ) &&
//     (MEM->tTtllog.t600000.advance_money != 0          ) &&
// //aaa	        (MEM->tmpbuf.reserv.ttl != 0                    ) &&
//     (!memcmp(MEM->tmpbuf.reserv_member, MEM->tHeader.cust_no, sizeof(MEM->tmpbuf.reserv_member)-1)) &&
//     (MEM->tmpbuf.reserv_itmlog_cnt == MEM->tTtllog.t100001Sts.itemlog_cnt) &&
// //aaa	        ((MEM->tmpbuf.reserv.qty == MEM->tTtllog.t100001.qty) || (MEM->tTtllog.t100001.qty == 0)) &&
//     ((MEM->tmpbuf.reserv.ttl == rxCalc_Stl_Tax_In_Amt(MEM)) || (rxCalc_Stl_Tax_In_Amt(MEM) == 0)));
//     #endif
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    return ((pCom.dbTrm.reservePrepayPostpayActsale != 0)
        && (await CmCksys.cmReservSystem() != 0)
        && (!RcFncChk.rcCheckReservMode())
        && (rcReservReceiptCall())
        && (rcresevCashTyp())
        && (RegsMem().tmpbuf.reservTaxChgFlg == 0)
        && (RegsMem().tTtllog.t600000.advanceMoney != 0)
        && (!((RegsMem().tmpbuf.reservMember.compareTo
          (RegsMem().tHeader.cust_no!)) != 0))
        && (RegsMem().tmpbuf.reservItmlogCnt
            == RegsMem().tTtllog.t100001Sts.itemlogCnt)
        && (RegsMem().tTtllog.t600000.advanceMoney
            == RxLogCalc.rxCalcStlTaxInAmt(RegsMem())));
  }

  /// 関連tprxソース:rc_reserv.c - rcresev_cash_typ
  static bool rcresevCashTyp(){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    return ((RegsMem().tmpbuf.reservCashTyp != 0)
        && (pCom.dbTrm.cashKindSelectReserveope == 0));
  }

  /// 関連tprxソース:rc_reserv.c - rcReserv_PopUp
  // TODO:00004 小出 定義のみ追加する。
  static Future<void> rcReservPopUp(int err_no) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcReserv_PopUp");
    //rcReserv_DialogErr(err_no, 1, NULL);
  }

  /// 関連tprxソース:rc_reserv.c - rcreserv_CallUpdate
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static void rcReservCallUpdate(int upd_typ) {
    return;
  }

  /// 関連tprxソース:rc_reserv.c - rcreserv_PrnSkipChk
  static bool rcReservPrnSkipChk() {
    return(reservPrnSkipFlg == ReservDef.RESERV_PRNSKIP);
  }

  /// 関連tprxソース:rc_reserv.c - rcReservPrnEnd
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  static int rcReservPrnEnd(int err_no) {
    return 0;
  }

  /// 関連tprxソース:rc_reserv.c - rcReserv_cindsp
  /// TODO:00010 長田 定義のみ追加
  static int rcReservCindsp(int errcnclflg) {
    return 0;
  }

  /// 関連tprxソース:rc_reserv.c - rcReserv_Entry
  /// TODO:00010 長田 定義のみ追加
  static int rcReservEntry() {
    return 0;
  }

  /// 関連tprxソース:rc_reserv.c - rcreserv_ItmAdd
  /// TODO:00010 長田 定義のみ追加
  static bool rcReservItmAdd() {
    RegsMem mem = SystemFunc.readRegsMem();
    return(mem.tmpbuf.reservTyp == RcRegs.RESERV_ITEMADD);
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 入力番号を画面に表示する
  /// 引数: 入力番号
  /// 関連tprxソース:rc_reserv.c - rcReserv_NumberInput
  static void rcReservNumberInput(String number) {}

  /// 関連tprxソース:rc_reserv.c - rcReservInpClrFnc
  //実装は必要だがARKS対応では除外
  static int rcReservInpClrFnc(){
    return 0;
  }
  
}