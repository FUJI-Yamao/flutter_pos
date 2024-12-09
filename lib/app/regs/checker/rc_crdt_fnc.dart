/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtoa.dart';
import 'package:flutter_pos/app/lib/cm_chg/sup_asc.dart';
import 'package:flutter_pos/app/lib/cm_sys/sysdate.dart';
import 'package:flutter_pos/app/lib/cm_mbr/cmmbrsys.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_gtktimer.dart';
import 'package:flutter_pos/app/regs/checker/rccrdtdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rckycrdtin.dart';
import 'package:flutter_pos/app/regs/checker/rckyworkin.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/sys/sale_com_mm/rept_ejconf.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_elog.dart';
import 'rc_ext.dart';
import 'rc_set.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rcky_qctckt.dart';
import 'rcky_stl.dart';
import 'rcsp_recal.dart';

class RcCrdtFnc {
  static CrdtVoid crdtVoid = CrdtVoid();

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_crdt_fnc.c - rcChk_Sptend_crdt_enble_flg()
  static int rcChkSptendCrdtEnbleFlg() {
    return 0;
  }

  ///関連tprxソース: rccrdtfnc.c - rcCrdt_Cancel
  static Future<void> rcCrdtCancel() async {
    AcMem cMem = SystemFunc.readAcMem();

    RcRegs.kyStR0(cMem.keyStat, FncCode.KY_ENT.keyId);
    RcRegs.kyStR0(cMem.keyStat, FncCode.KY_REG.keyId);
    RcRegs.kyStR0(
        cMem.keyStat, FuncKey.KY_CRDTIN.keyId); // Credit Subtotal Discount %
    RcRegs.kyStR4(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
    RcSet.rcClearCrdtReg();
    rcResetEntryCrdtData();
    if (!RcFncChk.rcQCCheckCrdtUseMode()) {
      RcSet.rcReMovScrMode();
    }
    // クレジット表示から取引画面表示
    RcCrdtDsp.rcCrdtReDsp();

    // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
    // #if MC_SYSTEM
    // if(Ky_St_C7(CMEM->key_stat[KY_MCALC])) {
    // Cash_Stat_Reset();
    // rcReset_KyStatus();
    // Ky_St_R7(CMEM->key_stat[KY_MCALC]);
    // }
    // if(AT_SING->mc_tbl.k_amount == KY_CRDTIN)
    // AT_SING->mc_tbl.k_amount  = 0;
    //
    // if(rcChk_Mc_Izumi_System())
    // memset(MEM->tmpbuf.mcarddata.mc_addr, 0, sizeof(MEM->tmpbuf.mcarddata.mc_addr));
    // #endif

    // TODO:00012 平野 クレジット宣言：UI
    // 拡張小計の再表示
    // rcKyExtKey_ReDisp( EXTKEY_MAKE_NO ); /* 2006/10/03 */
    RegsMem().prnrBuf.refList = RefListPrn();
    if ((await RcSysChk.rcCheckEntryCrdtMode()) ||
        (await RcSysChk.rcCheckEntryCrdtSystem())) {
      if (await RcFncChk.rcCheckStlMode()) {
        // TODO:00012 平野 クレジット宣言：UI
        // 小計画面のエントリー部分に引数の文字列を表示する
        // rcDispSubttlTendChgMsg("");
      }
    }
  }

  ///関連tprxソース: rccrdtfnc.c
  /// - rcSignChk_EveryOne_System(long crdt_amt, long tran_div, short operation)
  static Future<bool> rcSignChkEveryOneSystem(
      int crdtAmt, int tranDiv, int operation) async {
    // クレジット利用ユーザー【標準】、又はCGCみんなのシステム用

    // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
    // MC_SYSTEMが0で定義されていたので、この部分はコメントアウトしておく。
    //#if MC_SYSTEM
    //  return false;
    //#else
    //#if ARCS_MBR
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "rcSignChkEveryOneSystem() rxMemRead error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((await CmMbrSys.cmNewARCSSystem() != 0) &&
        (await CmCksys.cmCrdtSystem() != 0) &&
        (RcSysChk.rcChkCrdtUser() == Datas.NORMAL_CRDT)) {
      if (operation == 1) {
        // 各種セルフPOSのオペレーションで本関数を利用する場合の判定
        if (crdtAmt > pCom.dbTrm.crdtSignlessMaxLimit) {
          return true;
        }
      } else {
        if (crdtAmt <= pCom.dbTrm.crdtSignlessMaxLimit) {
          return true;
        }
      }
    } else
    //#endif
    if ((await CmCksys.cmNttaspSystem() != 0) ||
        (await RcSysChk.rcChkCapSCafisSystem()) ||
        (await CmCksys.cmCapsPqvicSystem() != 0) ||
        (await RcSysChk.rcChkCapsCafisStandardSystem())) {
      if (!(await CmCksys.cmDummyCrdtSystem() != 0)) {
        // クレジットダミーシステム時は動作を許可する
        return false;
      }
    }

    if (await CmCksys.cmCrdtSystem() != 0) {
      if (RcSysChk.rcChkCrdtUser() == Datas.NORMAL_CRDT) {
        if (pCom.dbTrm.crdtSignlessMaxLimit != 0) { // CGCみんなのシステム基本仕様
          if (operation == 1) {
            // 各種セルフPOSのオペレーションで本関数を利用する場合の判定
            if (crdtAmt > pCom.dbTrm.crdtSignlessMaxLimit) {
              return true;
            }
          } else {
            if (pCom.dbTrm.acoopCreditFunc != 0) { // エーコープ関東（CGCみんなのシステムではない為）
              if (crdtAmt <= pCom.dbTrm.crdtSignlessMaxLimit) {
                return true;
              }
            } else {
              if (tranDiv == 10) { // 一括払いのみ対象（CGCみんなのシステムの依頼）
                if (crdtAmt <= pCom.dbTrm.crdtSignlessMaxLimit) {
                  return true;
                }
              }
            }
          }
        } else {
          if (operation == 1) {
            // 各種セルフPOSのオペレーションで本関数を利用する場合の判定
            if (RcSysChk.rcCheckVChain()) {
              if (crdtAmt >= 30000) {
                return true;
              }
            } else if (pCom.dbTrm.connectSbsCredit3 != 0) { // イチコ仕様
              if (crdtAmt > 30000) {
                return true;
              }
            } else if (pCom.dbTrm.acoopCreditFunc != 0) { // エーコープ関東
              // if(crdt_amt > 10000) {
              if (crdtAmt > pCom.dbTrm.crdtSignlessMaxLimit) {
                return true;
              }
            }
          } else {
            if (RcSysChk.rcCheckVChain()) {
              if (crdtAmt < 30000) {
                return true;
              }
            } else if (pCom.dbTrm.connectSbsCredit3 != 0) { // イチコ仕様
              if (crdtAmt <= 30000) {
                return true;
              }
            } else if (pCom.dbTrm.acoopCreditFunc != 0) { // エーコープ関東
              // if(crdt_amt <= 10000) {
              if (crdtAmt <= pCom.dbTrm.crdtSignlessMaxLimit) {
                return true;
              }
            }
          }
        }
      } else if (await CmCksys.cmIchiyamaMartSystem() != 0) {
        if (operation == 1) {
          //各種セルフPOSのオペレーションで本関数を利用する場合の判定
          if (crdtAmt > pCom.dbTrm.crdtSignlessMaxLimit) {
            return true;
          }
        } else {
          if (crdtAmt <= pCom.dbTrm.crdtSignlessMaxLimit) {
            return true;
          }
        }
      }
    }
    return false;
  }

  /// クレジットで支払う金額を返す
  /// 関連tprxソース: rccrdtfnc.c - rcGetCrdtPayAmount()
  /// 引数：なし
  /// 戻値：クレジットで支払う金額
  static Future<int> rcGetCrdtPayAmount() async {
    AtSingl atSing = SystemFunc.readAtSingl();
    //if(( rcCheckEntryCrdtMode() == TRUE )	|| (rcCheckEntryCrdtSystem()))
    if (await RcSysChk.rcCheckEntryCrdtMode()) {
      return atSing.entryCrdtAmt;
    } else if (RcSysChk.rcsyschkSm66FrestaSystem()) {
      if ((await RcFncChk.rcCheckEESVoidMode()) //訂正モード
          || (await RcFncChk.rcCheckCrdtVoidMode()) //クレジット訂正
          || (RckyRfdopr.rcRfdOprCheckAllRefundMode())) { //返品モード（レシート返品）
        return RegsMem().tTtllog.calcData.crdtAmt1;
      } else if (await RcSysChk.rcCheckEntryCrdtSystem()) {
        return atSing.entryCrdtAmt;
      } else {
        return payPrice();
      }
    } else {
      return payPrice();
    }
  }

  /// レピカポイント支払を行ったファンクションコードを返す
  /// 関連tprxソース: rccrdtfnc.c - rcChk_Sptend_repicapnt_enble_flg()
  /// 引数：なし
  /// 戻値：レピカポイント支払を行ったファンクションコード
  static Future<int> rcChkSptendRepicapntEnbleFlg() async {
    KopttranBuff koptTran = KopttranBuff();
    int i;

    if (!RcFncChk.rcCheckRegistration()) {
      return 0;
    }

    for (i = 0; i < RegsMem().tTtllog.t100001Sts.sptendCnt; i++) {
      if (RcSysChk.rcChkKYCHA(RegsMem().tTtllog.t100100[i].sptendCd)) {
        await RcFlrda.rcReadKopttran(
            RegsMem().tTtllog.t100100[i].sptendCd, koptTran);
        if ((koptTran.crdtEnbleFlg == 0) && (koptTran.crdtTyp == 39)) {
          return (RegsMem().tTtllog.t100100[i].sptendCd);
        }
      }
    }
    return 0;
  }

  /// 置数 + クレジットでの売上, 取消, 返品電文を送信した状態かチェック
  /// 関連tprxソース: rccrdtfnc.c - rcCheckEntryCrdtInqu()
  /// 引数：なし
  /// 戻値：true: 送信した  false: まだ
  static bool rcCheckEntryCrdtInqu() {
    AtSingl atSing = SystemFunc.readAtSingl();
    if (atSing.entryCrdtInquFlag == 1) {
      return true;
    }
    return false;
  }

  // TODO:10125 通番訂正 202404実装対象外（定義のみ）
  /// 与信問い合わせ
  /// 関連tprxソース: rccrdtfnc.c - rcCrdt_InquProg()
  /// 引数：なし
  /// 戻値：エラーNo
  static int rcCrdtInquProg() {
    return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
  }

  /// 置数 + クレジットで使用する変数を初期化する
  /// 関連tprxソース: rccrdtfnc.c - rcResetEntryCrdtData
  static void rcResetEntryCrdtData() {
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.entryCrdtAmt = 0;
    atSing.entryCrdtInquFlag = 0;
    atSing.lastCommSaveOtherEntry = Uint8List(10);
  }

  /************************************************************************/
  /*                        Macro Data                                    */
  /************************************************************************/

  /// 関連tprxソース:C:rccrdt.h - PAY_PRICE
  static int payPrice() {
    RegsMem regsMem = RegsMem();
    return RxLogCalc.rxCalcStlTaxAmt(regsMem);
  }

  ///関連tprxソース: rccrdtfnc.c - rcSet_KasumiCard
  static void rcSetKasumiCard(int cardType) {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg.kasumiAeon = cardType;
  }

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_KeyInqu_End
  static void rcCAPSPQVICKeyInquEnd(){}

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_Key_Set_UseData
  static void rcCAPSPQVICKeySetUseData(){}

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_Key_Chk
  static bool rcCAPSPQVICKeyChk(){
    return true;
  }

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_KeyInquAtct
  static int rcCAPSPQVICKeyInquAtct(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_KeyInquData
  static int rcCAPSPQVICKeyInquData(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_Key_EditReqInqu
  static void rcCAPSPQVICKeyEditReqInqu(){}

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_KeyInquWtxt
  static int rcCAPSPQVICKeyInquWtxt(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rccrdtfnc.c - rcCAPS_PQVIC_KeyInquProg
  static int rcCAPSPQVICKeyInquProg(){
    return 0;
  }

  /// 対面セルフ仕様で、各種チェック後にクレジット宣言キーを動作させる
  /// 関連tprxソース: rccrdtfnc.c - rccrdtfnc_check_crdtin
  /// 引数：なし
  /// 戻値：エラーNo
  static Future<void> rccrdtfncCheckCrdtin() async {
    int errNo;
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcChkFselfMain()) {
      errNo = Typ.OK;
      if (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
        errNo = DlgConfirmMsgKind.MSG_BEFORSCNPLU.dlgId;
      }
      if ((errNo == Typ.OK) && (!await RcFncChk.rcCheckStlMode())) {
        errNo = DlgConfirmMsgKind.MSG_SUBTTLFCE.dlgId;
      }
      if (errNo == Typ.OK) {
        await RckyCrdtIn.rcKyCrdtIn();
        if (CompileFlag.COLORFIP) {
          // TODO:10166 クレジット 20241004実装対象外
          // rc_fself_tranend_create();
        }
      } else {
        RcExt.rcErr('rccrdtfncCheckCrdtin', errNo);
      }
    } else {
      await RckyCrdtIn.rcKyCrdtIn();
    }
  }

  /// 関連tprxソース: rccrdtfnc.c - rcNtt_Check_HouseStatus
  static Future<bool> rcNttCheckHouseStatus() async {
    if (await CmCksys.cmNttaspSystem() != 0) {
      if (RcSysChk.rcChkRalseCardSystem()) {
        if (RegsMem().tmpbuf.workInType == 2) {
          return true;
        }
      }
    }
    return false;
  }

  ///関連tprxソース: rccrdtfnc.c - rcChk_Crdt_Cancel
  static Future<bool> rcChkCrdtCancel() async {
    return ((RcSysChk.rcVDOpeModeChk()) ||
        (await RcFncChk.rcCheckCrdtVoidMode()) ||
        (RckyRfdopr.rcRfdOprCheckAllRefundMode()) ||
        (RckyRfdopr.rcRfdOprCheckManualRefundMode()) ||
        (RckyRfdopr.rcRfdOprCheckRcptVoidMode()));
  }

  /// レシート呼び出しクレジットキャンセル時の磁気カード処理かチェック
  ///  (TRUE:磁気カード処理  FALSE:それ以外)
  /// 関連tprxソース: rccrdtfnc.c - rcCheckCrdtVoidMcdProc
  static Future<bool> rcCheckCrdtVoidMcdProc() async {
    AcMem cMem = SystemFunc.readAcMem();

    if ((await RcFncChk.rcCheckCrdtVoidMode()) ||
        (RckyRfdopr.rcRfdOprCheckAllRefundMode()) ||
        (RckyRfdopr.rcRfdOprCheckRcptVoidMode())) {
      return true;
    }
    if ((await RcSysChk.rcChkVegaProcess()) &&
        ((await RcFncChk.rcCheckCrdtVoidIMode()) ||
            (await RcFncChk.rcCheckCrdtVoidSMode())) &&
        ((int.parse(cMem.working.crdtReg.cdno[0]) == 0x00) &&
            (int.parse(crdtVoid.crdtNo[0]) == 0x00))) {
      return true;
    }
    return false;
  }

  /// クレジット一部支払済みかチェック
  /// 関連tprxソース: rccrdtfnc.c - rcChk_Sptend_Crdt
  static int rcChkSptendCrdt() {
    KopttranBuff koptTran = KopttranBuff();
    int i;

    if (!ReptEjConf.rcCheckRegistration()) {
      return (0);
    }

    if (!(RegsMem().tTtllog.t100001Sts.sptendCnt != 0)) {
      return (0);
    }

    for (i = 0; i < RegsMem().tTtllog.t100001Sts.sptendCnt; i++) {
      if (RcSysChk.rcChkKYCHA(RegsMem().tTtllog.t100100[i].sptendCd)) {
        RcFlrda.rcReadKopttran(RegsMem().tTtllog.t100100[i].sptendCd, koptTran);
        if ((koptTran.crdtEnbleFlg == 1) && (koptTran.crdtTyp == 0)) {
          return (1);
        }
      }
    }
    return (0);
  }

  /// 関連tprxソース: rccrdtfnc.c - rcSpec_Ck_Digit
  static bool rcSpecCkDigit() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.working.refData.crdtTbl.ckdigit_chk == 1);
  }

  /// 関連tprxソース: rccrdtfnc.c - rcChk_CdNo_FromTo
  static Future<int> rcChkCdNoFromTo() async {
    // #if 0
    // long  card_no,size;
    // char  card_asc[6];
    // short err_no;
    //
    // err_no = FALSE;
    // if((CMEM->working.ref_data.crdttbl.mbr_no_from == 999999) &&
    // (CMEM->working.ref_data.crdttbl.mbr_no_to   == 999999) )
    // return(err_no);
    // size = ((sizeof(CMEM->ent.entry)) - (CMEM->working.ref_data.crdttbl.mbr_no_digit / 2));
    // cm_setup_asc(0, cm_BOA(card_asc), &CMEM->ent.entry[size+2], sizeof(card_asc));
    // #endif
    int cardNo;
    int mbrNoFrom;
    int mbrNoTo;
    String cardAsc = ''; // char  card_asc[12];
    int errNo;
    // #if DEPARTMENT_STORE
    // short stat;
    // #endif

    AcMem cMem = SystemFunc.readAcMem();

    mbrNoFrom = cMem.working.refData.crdtTbl.mbr_no_from;
    mbrNoTo = cMem.working.refData.crdtTbl.mbr_no_to;
    errNo = Typ.FALSE;
    if ((mbrNoFrom == 999999999999) && (mbrNoTo == 999999999999)) {
      return (errNo);
    }
    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // if (rcChk_Crdt_User() == NAKAGO_CRDT) {
      //   cm_bcdtoa(CMEM->working.crdt_reg.cdno, &CMEM->ent.entry[2],
      //       sizeof(CMEM->working.crdt_reg.cdno), sizeof(CMEM->ent.entry)-2);
      //   stat = rcChk_Kappu_Tran();
      //   cm_clr((char *)&CMEM->working.crdt_reg.cdno, sizeof(CMEM->working.crdt_reg.cdno));
      //   if(stat == OK) {
      //     if(CMEM->stat.Depart_Flg & 0x01)
      //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcChk_CdNo_FromTo() World Card OK !!\n");
      //     else
      //       return(err_no);
      //   }
      // }
    }

    cardAsc = Bcdtoa.cmBcdToA(cMem.ent.entry, cMem.ent.entry.length);
    cardAsc += '0';

    cardNo = int.parse(cardAsc);
    if ((cardNo < mbrNoFrom) || (cardNo > mbrNoTo)) {
      if (await CmCksys.cmSpDepartmentSystem() != 0) {
        /* 特定百貨店仕様   */
        errNo = DlgConfirmMsgKind.MSG_RECARD_IN.dlgId;
      } else {
        errNo = DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId;
      }
    }
    return (errNo);
  }

  // TODO:00012 平野 クレジット宣言：動作確認まだ
  /// 関連tprxソース: rccrdtfnc.c - rcChk_Good_Thru
  static Future<int> rcChkGoodThru() async {
    // #if 1 /*zen*/
    String validdt = ''; // uchar validdt[YYYYMM + 1];
    String sysdate = ''; // uchar sysdate[YYYYMM + 1];
    Uint8List bcddate; // uchar bcddate[3];
    int indate;
    int today;
    int errNo;
    // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
    // #if DEPARTMENT_STORE
    // char   log[128];
    // #endif

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "rcChkGoodThru() rxMemRead error\n");
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    RxCommonBuf cBuf = xRet.object;

    errNo = Typ.FALSE;
    cMem.date = SysDate().cmReadSysdate(); // cm_read_sysdate(&CMEM->date);
    sysdate = sprintf("%04i%02i", [
      cMem.date!.year,
      cMem.date!.month,
    ]);

    /* edit YYYYMM */
    // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
    // #if MC_SYSTEM
    // if(((uchar)CMEM->ent.entry[9] < (uchar)January ) || ((uchar)CMEM->ent.entry[9] > (uchar)December))
    //    return(MSG_INPUTERR);
    // if((uchar)CMEM->ent.entry[8] > (uchar)0x85)
    //    bcddate[0] = 0x19;                                 /* edit YYMM->19YYMM */
    // else
    //    bcddate[0] = 0x20;                                 /* edit YYMM->20YYMM */
    // bcddate[1] = CMEM->ent.entry[8];
    // bcddate[2] = CMEM->ent.entry[9];
    //#else
    if (await CmCksys.cmNttaspSystem() != 0) {
      if (RcSysChk.rcChkRalseCardSystem()) {
        /* 有効期限をチェックしない！ */
        if ((RcCrdt.CHK_DEVICE_MCD()) || (await rcNttCheckHouseStatus())) {
          return (errNo);
        }
      } else if (await CmCksys.cmDummyCrdtSystem() != 0) {
        /* 有効期限をチェックしない！ */
        if (RcCrdt.CHK_DEVICE_MCD()) {
          return (errNo);
        }
      }
    }

    if ((RcCrdt.CHK_DEVICE_MCD()) || (cBuf.dbTrm.goodThruDsp == 1)) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // if((rcChk_Crdt_User() == NAKAGO_CRDT) && (CMEM->stat.Depart_Flg & 0x01)) {
      //    if(CMEM->ent.entry[9] > (uchar)December) {
      //      return(MSG_INPUTERR);
      //    }
      // }
      // else {
      //    if(((uchar)CMEM->ent.entry[9] < (uchar)January ) || ((uchar)CMEM->ent.entry[9] > (uchar)December))
      //      return(MSG_INPUTERR);
      // }
      // if((uchar)CMEM->ent.entry[8] > (uchar)0x85)
      //    bcddate[0] = 0x19;                              /* edit YYMM->19YYMM */
      // else
      //    bcddate[0] = 0x20;                              /* edit YYMM->20YYMM */
      // bcddate[1] = CMEM->ent.entry[8];
      // bcddate[2] = CMEM->ent.entry[9];
      //#else
      //TODO 後回し
      if ((cMem.ent.entry[9] < Datas.January) ||
          (cMem.ent.entry[9] > Datas.December)) {
        return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
      }
      if (cMem.ent.entry[8] > 0x85) {
        bcddate = Uint8List.fromList(
            [0x19, cMem.ent.entry[8], cMem.ent.entry[9]]); // edit YYMM->19YYMM
      } else {
        bcddate = Uint8List.fromList(
            [0x20, cMem.ent.entry[8], cMem.ent.entry[9]]); // edit YYMM->20YYMM
      }
      // #endif
    } else {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // if((rcChk_Crdt_User() == NAKAGO_CRDT) && (CMEM->stat.Depart_Flg & 0x01)) {
      //    if((uchar)CMEM->ent.entry[8] > (uchar)December)
      //      return(MSG_INPUTERR);
      // }
      // else {
      //    if(((uchar)CMEM->ent.entry[8] < (uchar)January ) || ((uchar)CMEM->ent.entry[8] > (uchar)December))
      //      return(MSG_INPUTERR);
      //    }
      //    if((uchar)CMEM->ent.entry[9] > (uchar)0x85)
      //      bcddate[0] = 0x19; /* edit MMYY->19YYMM */
      //    else
      //      bcddate[0] = 0x20; /* edit MMYY->20YYMM */
      //    bcddate[1] = CMEM->ent.entry[9];
      //    bcddate[2] = CMEM->ent.entry[8];
      //#else
      if ((cMem.ent.entry[8] < Datas.January) ||
          (cMem.ent.entry[8] > Datas.December)) {
        return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
      }
      if (cMem.ent.entry[9] > 0x85) {
        bcddate = Uint8List.fromList(
            [0x19, cMem.ent.entry[9], cMem.ent.entry[8]]); // edit MMYY->19YYMM
      } else {
        bcddate = Uint8List.fromList(
            [0x20, cMem.ent.entry[9], cMem.ent.entry[8]]); // edit MMYY->20YYMM
      }
      // #endif
    }
    // #endif
    //TODO 後回し
    validdt = SupAsc.cmSetupAsc(0, bcddate, 8); // cm_setup_asc(0, &validdt[5],
    // cm_BOA(bcddate),
    // sizeof(bcddate)*2);
    today = int.parse(sysdate);
    indate = int.parse(validdt);

    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // if((rcChk_Crdt_User() == NAKAGO_CRDT) && (CMEM->stat.Depart_Flg & 0x01)) {
      //    if(CMEM->working.crdt_reg.card_kind == 1001) {     /* 外商カードは和歴なので西暦に補正 */
      //      indate = indate - 1200;                         /* 12を引く計算式は中合指定         */
      //      if(indate < 200000)
      //          indate = 200000;
      //    }
      // }
    }
    if (indate < today) {
      if (CompileFlag.DEPARTMENT_STORE) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // if((rcChk_Crdt_User() == NAKAGO_CRDT) && (CMEM->stat.Depart_Flg & 0x01)) {
        //    if(indate == 200000) {    /* 自社クレジットの場合、有効期限00/00はエラーにしない */
        //      sprintf(log,"rcChk_Good_Thru() valid_term [%ld]\n", indate);
        //      TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
        //    }
        //    else
        //      err_no = MSG_GOODTHRUERR;
        // }
        // else
        //    err_no = MSG_GOODTHRUERR;
      } else {
        errNo = DlgConfirmMsgKind.MSG_GOODTHRUERR.dlgId;
      }
    }
    return (errNo);
    // #else
    // return(FALSE);
    // #endif
  }

  ///関連tprxソース: rccrdtfnc.c - rcSpec_Bonus_Mth_Input
  static bool rcSpecBonusMthInput() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.working.refData.crdtTbl.pay_input_chk == 1);
  }

  /// レシート呼び出しクレジットキャンセル時の問い合わせ処理かチェック
  /// (TRUE:問い合わせ処理  FALSE:それ以外)
  /// 関連tprxソース: rccrdtfnc.c - rcCheckCrdtVoidInquProc
  static Future<bool> rcCheckCrdtVoidInquProc() async {
    if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
        (await RcFncChk.rcCheckCrdtVoidIMode()) ||
        (RckyRfdopr.rcRfdOprCheckAllRefundMode()) ||
        (RckyRfdopr.rcRfdOprCheckRcptVoidMode())) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース: rccrdtfnc.c - rcCrdt_StlDsc_Cancel
  //  TODO:定義のみ追加
  static void rcCrdtStlDscCancel() {}

  /// 関連tprxソース: rccrdtfnc.c - rccrdtfnc_check_jtr_cncel_end
  //  TODO:定義のみ追加
  static void rcCrdtFncCheckJtrCncelEnd(String fncName) {}

  /// 関連tprxソース: rccrdtfnc.c - rcChk_Pay_Season
  static Future<bool> rcChkPaySeason() async {
    String sysdate;
    int today;

    AcMem cMem = SystemFunc.readAcMem();

    // ボーナス一括支払月指定の場合は取扱期間を常に夏からとする
    if (!(await CmCksys.cmNttaspSystem() != 0) &&
        (SystemFunc.readAcMem().working.crdtReg.crdtTbl.bonus_lump == 1)) {
      return false;
    }

    SysDate().cmReadSysdate(); // cm_read_sysdate(&CMEM->date);
    sysdate = sprintf("%02i%02i", [
      cMem.date!.month,
      cMem.date!.day,
    ]);
    today = int.parse(sysdate);

    return (today >= cMem.working.refData.crdtTbl.winter_bonus_from) &&
        (today <= cMem.working.refData.crdtTbl.winter_bonus_to);
  }

  /// 関連tprxソース: rccrdtfnc.c - rcChk_Floor_Limt
  static Future<bool> rcChkFloorLimit() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (CompileFlag.DEPARTMENT_STORE) {
      if ((RcSysChk.rcChkDepartmentSystem()) &&
          (RckyWorkin.rcWorkinChkWorkType(RegsMem().tTtllog) ==
              WkTyp.WK_CRDITRECEIV.index)) {
        if ((RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) &&
            (cMem.stat.departFlg & 0x10 != 0)) {
          return false;
        }
      }
      if (cMem.working.refData.crdtTbl.offline_limit != 0) {
        return (await rcGetCrdtPayAmount() >
            cMem.working.refData.crdtTbl.offline_limit);
      } else {
        return false;
      }
    } else {
      if (cMem.working.refData.crdtTbl.offline_limit != 0) {
        return (await rcGetCrdtPayAmount() >
            cMem.working.refData.crdtTbl.offline_limit);
      } else {
        return true; // No Check
      }
    }
  }

  /// 関連tprxソース: rccrdtfnc.c - rcCrdt_StlDsc_Set
  static Future<void> rcCrdtStlDscSet() async {
    int sptendAmt, sptend79Amt;
    int crdtdscRestamt;
    int err = Typ.OK;

    crdtdscRestamt = 0;
    sptendAmt = RxLogCalc.rxCalcStlTaxInAmt(RegsMem()) - RxLogCalc.rxCalcStlTaxAmt(RegsMem());
    if (RegsMem().tTtllog.t100001Sts.sptendCnt == 0) RcspRecal.rcSPTendMemClear();
    if (RckyStl.rcChkOneMix()) StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);
    StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT); // 再計算（クレジット小計割引）
    await RcspRecal.rcSPTendBufEdit(1);
    if (SystemFunc.readAtSingl().btlAmtTotal != 0) { // 取引に返瓶が含まれている（返瓶実績加算しない設定時）
      if (await rcGetCrdtPayAmount() <= 0) {
        SystemFunc.readAcMem().working.crdtReg.crdtdscCancel = 1;
        if (RckyStl.rcChkOneMix()) StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);
        StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT); // 再計算（クレジット小計割引なし）
        await RcspRecal.rcSPTendBufEdit(1);
      }
    }
    if ((RegsMem().tTtllog.t100002.stlcrdtdscPer != 0) && (sptendAmt > 0)) {
      if (sptendAmt >= RxLogCalc.rxCalcStlTaxInAmt(RegsMem())) {
        SystemFunc.readAcMem().working.crdtReg.crdtdscCancel = 1;
        if (RckyStl.rcChkOneMix()) StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);
        StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT); // 再計算（クレジット小計割引なし）
        await RcspRecal.rcSPTendBufEdit(1);
      } else {
        if (RcSysChk.rcChkCrdtUser() == RcCrdt.KASUMI_CRDT) {
          // TODO:10166 クレジット決済 20241004実装対象外
          // sptend79Amt = RcSet.rcGetKasumiCha79Amt(FncCode.KY_CHA7.keyId);
          // crdtdscRestamt = RegsMem().tTtllog.calcData.stldscRestAmt - sptend79Amt;
          // if (crdtdscRestamt < 0) {
          //   SystemFunc.readAcMem().working.crdtReg.crdtdscCancel = 1;
          //   if (RckyStl.rcChkOneMix()) StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);
          //   StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT); // 再計算（クレジット小計割引なし）
          //   await RcspRecal.rcSPTendBufEdit(1);
          // }
        }
      }
    }
    if (RckyQctckt.rcCheckQcTcktLikeKey()) {
      if (((RegsMem().tTtllog.t100002.stlcrdtdscPer != 0) && (RegsMem().tTtllog.t100002.stlcrdtdscAmt == 0)) ||
          (SystemFunc.readAcMem().working.crdtReg.crdtdscCancel == 1)) {
        RckyQctckt.rcNoCrdtDscErr();
        err = DlgConfirmMsgKind.MSG_TEXT78.dlgId;
      } else {
        SystemFunc.readAcMem().working.crdtReg.crdtdscCancel = 1;
        if (RckyStl.rcChkOneMix()) StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_NORMAL);
        StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT); // 再計算（クレジット小計割引なし）
        await RcspRecal.rcSPTendBufEdit(1);
      }
    }
    if (RegsMem().tTtllog.t100001Sts.sptendCnt > 0) {
      if (RckyQctckt.rcCheckQcTcktLikeKey()) {
        int fncCode = 0;

        // QC指定動作はファンクションキーで判断するため
        if ((SystemFunc.readAcMem().stat.fncCode == FuncKey.KY_QCSELECT.keyId) ||
            (SystemFunc.readAcMem().stat.fncCode == FuncKey.KY_QCSELECT2.keyId) ||
            (SystemFunc.readAcMem().stat.fncCode == FuncKey.KY_QCSELECT3.keyId)) {
          fncCode = SystemFunc.readAcMem().stat.fncCode;
        }
        await RcspRecal.rcSPTendReCalc(); // スプリットテンダリング再計算
        if (fncCode != 0) {
          SystemFunc.readAcMem().stat.fncCode = fncCode;
        }
      } else {
        await RcspRecal.rcSPTendReCalc(); // スプリットテンダリング再計算
      }
    }
    if (err != Typ.OK) SystemFunc.readAcMem().ent.errNo = err;
  }

  /// 関連tprxソース: rccrdtfnc.c - rcCrdtDsc_WarnUp
  static Future<void> rcCrdtDscWarnUp(int errNo) async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    cMem.ent.errStat = 1;
    cMem.ent.warnNo = errNo;
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        RcEwdsp.rcWarnPopUpLcd(cMem.ent.warnNo);
        break;
      case RcRegs.KY_SINGLE:
        RcEwdsp.rcWarnPopUpLcd(cMem.ent.warnNo);
        break;
    }
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcAssistMnt.asstPcLog += tsBuf.managePc.msgLogBuf;
      RcAssistMnt.rcAssistSend(DlgConfirmMsgKind.MSG_STLCRDTDSCCNCL.dlgId);
    }
    if (RcGtkTimer.rcGtkTimerAdd(
            RcRegs.WARN_EVENT, RcCrdtFnc.rcCrdtDscWarnDown) !=
        0) {
      RcCrdtFnc.rcCrdtDscWarnDown();
    }
  }

  /// 関連tprxソース: rccrdtfnc.c - rcCrdtDsc_WarnDown
  static void rcCrdtDscWarnDown() {
    AcMem cMem = SystemFunc.readAcMem();
    RcGtkTimer.rcGtkTimerRemove();
    RcExt.rcWarnPopDownLcd('rcCrdtDsc_WarnDown');
    cMem.ent.errStat = 0;
  }

  /// 関連tprxソース: rccrdtfnc.c - rcChk_KasumiCard
  static bool rcChkKasumiCard() {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcSysChk.rcChkCrdtUser() == RcCrdt.KASUMI_CRDT) {
      if ((cMem.working.crdtReg.kasumiAeon == RcCrdt.KASUMI_AEON) ||
          (cMem.working.crdtReg.kasumiAeon == RcCrdt.AEON)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
