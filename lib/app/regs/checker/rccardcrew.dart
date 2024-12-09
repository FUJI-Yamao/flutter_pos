/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

import 'package:flutter_pos/app/inc/apl/fnc_code.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/cm_bcd/chk_z0.dart';
import 'package:flutter_pos/app/lib/cm_chg/asctobcd.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtoa.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtol.dart';
import 'package:flutter_pos/app/lib/cm_sys/sysdate.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import 'package:flutter_pos/app/regs/checker/rc_elog.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rckycrdtin.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../inc/L_rccrdt.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_crdt_fnc.dart';
import 'rc_ext.dart';
import 'rc_flrd.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_mcd.dart';
import 'rc_qc_dsp.dart';
import 'rc_set.dart';
import 'rc_sgdsp.dart';
import 'rccrdtdsp.dart';
import 'rcky_cha.dart';
import 'rcky_clr.dart';
import 'rcky_rfdopr.dart';
import 'rckycrdtvoid.dart';
import 'rcpana_inq.dart';
import 'rcqc_com.dart';
import 'rcsyschk.dart';

class RcCardCrew {
/*----------------------------------------------------------------------*
 *                        Define Data
 *----------------------------------------------------------------------*/
/* クレジットカードの有効期限を無視したい場合は０にする事 */
  static int CHECK_GOOD_THRU = 1;

  static int RCV_WAIT = 300;
  static int MAX_WAIT = 999;

  static int WaitCnt = 0;
/*----------------------------------------------------------------------*
 *                        Management Program
 *----------------------------------------------------------------------*/

  /// 端末IDを生成し、CardCrewReqComクラスに設定する
  ///  関連tprxソース: rccardcrew.c - rcCardCrew_MakeTermID
  static Future<void> rcCardCrewMakeTermID() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
    int crdtUser = 0;
    int compIdSize = 5;
    String shpNo = "";
    String macNo = "";

    if ((pCom.dbRegCtrl.crdtTrmCd.isNotEmpty) &&
        (int.tryParse(pCom.dbRegCtrl.crdtTrmCd) != null)) {
      RcCrdt.cReq.macId =
          pCom.dbRegCtrl.crdtTrmCd.substring(compIdSize, compIdSize + 8);
    } else {
      crdtUser = RcSysChk.rcChkCrdtUser();
      if (crdtUser == Datas.KASUMI_CRDT) {
        shpNo = "${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0");
        RcCrdt.cReq.macId = "0900${shpNo.substring(2)}";
      } else if (crdtUser == Datas.KANSUP_CRDT) {
        if (CmCksys.cmMatugenSystem() == 1) {
          shpNo =
              ("${pCom.iniMacInfo.system.shpno}".padLeft(6, "0")).substring(2);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(2);
        } else {
          shpNo =
              ("${pCom.iniMacInfo.system.shpno}".padLeft(6, "0")).substring(3);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(1);
        }
        RcCrdt.cReq.macId = "$shpNo$macNo";
      } else if (crdtUser == Datas.SAPDRA_CRDT) {
        shpNo = ("${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0")).substring(2);
        macNo =
            ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                    .padLeft(6, "0"))
                .substring(3);
        RcCrdt.cReq.macId = "0$shpNo$macNo";
      } else if (CompileFlag.DEPARTMENT_STORE &&
          (crdtUser == Datas.NAKAGO_CRDT)) {
        shpNo = ("${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0")).substring(3);
        macNo =
            ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                    .padLeft(6, "0"))
                .substring(3);
        RcCrdt.cReq.macId = "${shpNo.substring(0, 2)}00${shpNo[2]}$macNo";
      } else {
        if (await CmCksys.cmRainbowCardSystem() == 1) {
          shpNo = ("${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0")).substring(3);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(3);
          RcCrdt.cReq.macId = "${shpNo}10$macNo";
        } else if ((await CmCksys.cmPanaMemberSystem() == 1) &&
            (pCom.dbTrm.nalsePanacode > 0)) {
          shpNo = ("${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0")).substring(3);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(1);
          RcCrdt.cReq.macId = "$shpNo$macNo";
        } else if (RcSysChk.rcCheckFreshRoaster()) {
          shpNo =
              ("${pCom.iniMacInfo.system.shpno}".padLeft(6, "0")).substring(3);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(1);
          RcCrdt.cReq.macId = "$shpNo$macNo";
        } else if (pCom.dbTrm.acoopCreditFunc > 0) {
          //エーコープ関東
          shpNo = ("${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0")).substring(2);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(2);
          RcCrdt.cReq.macId = "$shpNo$macNo";
        } else if (await CmCksys.cmHc2KuroganeyaSystem(
                await RcSysChk.getTid()) ==
            1) {
          shpNo =
              ("${pCom.iniMacInfo.system.shpno}".padLeft(6, "0")).substring(2);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(2);
          RcCrdt.cReq.macId = "$shpNo$macNo";
        } else {
          //標準仕様を今治デパート仕様にする（運喜様もこれを利用）
          shpNo = ("${pCom.dbRegCtrl.cardStreCd}".padLeft(6, "0")).substring(3);
          macNo =
              ("${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
                      .padLeft(6, "0"))
                  .substring(1);
          RcCrdt.cReq.macId = "$shpNo$macNo";
        }
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_CounterIni
  static Future<void> rcCardCrewCounterIni() async {
    if (RcSysChk.rcTROpeModeChk()) {
      return;
    }

    int creditNoMax = 99999;
    if (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT) {
      /* 関西スーパークレジットの場合、伝票番号は１～８９９９９とする */
      creditNoMax = 89999;
    }
    CompetitionIniRet compIniRet = await CompetitionIni.competitionIniGet(await RcSysChk.getTid(), CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO, CompetitionIniType.COMPETITION_INI_GETMEM);
    int nttaspCreditNo = compIniRet.value;
    if (nttaspCreditNo >= creditNoMax) {
      nttaspCreditNo = 1;
    }
    else {
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        /* カスミクレジットの場合、伝票番号の採番は１０単位とする */
        nttaspCreditNo += 10;
        if (nttaspCreditNo >= creditNoMax) {
          nttaspCreditNo = 1;
        }
      }
      else {
        nttaspCreditNo++;
      }
    }
    await CompetitionIni.competitionIniSet(await RcSysChk.getTid(), CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO, CompetitionIniType.COMPETITION_INI_SETMEM, "$nttaspCreditNo");
    await CompetitionIni.competitionIniSet(await RcSysChk.getTid(), CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO, CompetitionIniType.COMPETITION_INI_SETSYS, "$nttaspCreditNo");
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_InquWtxt
  static Future<int> rcCardCrewInquWtxt(int req) async {
    int errNo;

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet ret;

    if (req == RcCrdt.CARD_REQ) {
      // todo クレ宣言　暫定対応5 クレジット実行体が実装されたらコメント解除する
      // rcCardCrewCardTxt();
    } else if (req == RcCrdt.CRDT_REQ) {
      rcCardCrewCrdtTxt();
    } else if (req == RcCrdt.CRDT_CNCL) {
      if (await RcSysChk.rcChkVegaProcess()) {
        rcCardCrewVegaCnclTxt();
      } else {
        return (DlgConfirmMsgKind.MSG_CHKSETTING.dlgId);
      }
    }
    cMem.working.crdtReg.crdtReq.order = RcCrdt.ORDER_REQRES; /* 3WAY */
    if ((await RcSysChk.rcChkVegaProcess()) &&
        (await RcCrdtFnc.rcCheckCrdtVoidInquProc())) {
      cMem.working.crdtReg.crdtReq.corrCd = RegsMem().tCrdtLog[0].t400000.mbrCd;
    }

    ret = await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CREDIT_SOCKET,
        cMem.working.crdtReg.crdtReq, RxMemAttn.MASTER);
    if (ret.result == RxMem.RXMEM_OK) {
      await rcCardCrewCounterIni();
      // rxQueueWrite(RXQUEUE_CREDIT_TSOCKET);
      errNo = Typ.OK;
    } else {
      errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    return (errNo);
  }

  // TODO:00012 平野 クレジット宣言：動作確認まだ
  ///  関連tprxソース: rccardcrew.c - rcCardCrew_CardTxt
  static Future<void> rcCardCrewCardTxt() async {
    String code =
        '3070200'; // ['3','0','7','0','2','0','0'];     /* カード問い合わせ */
    String buf = '';
    int nttaspCreditNo;
    Uint8List salePrice = Uint8List(4); // char sale_price[4];
    int rpno = 0;
    String voidDate = ''; // char void_date[8];

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCardCrewCardTxt() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    cMem.working.crdtReg.crdtReq = RxSocket();
    cMem.working.crdtReg.crdtRcv = RxSocket();

    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);

    RcCrdt.cReq.dataType = "\x01\x00"; /* 電送区分               */
    RcCrdt.cReq.dataLen = "\x5A\x01"; /* 電文長                 */
    RcCrdt.cReq.businessCode = code; /* 業務コード             */

    if (!await RcSysChk.rcChkVegaProcess()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcCardCrew_Set_CompID();
    }
    RcCrdt.cReq.correspondId = 'S'; /* 通信ID                 */
    RcCrdt.cReq.reserve = "\x00\x00\x00\x00\x00\x00"; /* リザーブ               */
    RcCrdt.cReq.returnCode = "\x00\x00"; /* リターンコード         */
    RcCrdt.cReq.continueFlg = "\x00\x00"; /* 続行フラグ             */
    if (!await RcSysChk.rcChkVegaProcess()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcCardCrew_MakeTermID();    /* 端末ID                 */
    }
    nttaspCreditNo = 0;
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    nttaspCreditNo = ret.value;
    RcCrdt.cReq.regCreditNumber =
        sprintf("%05ld", [nttaspCreditNo]); /* 端末処理通番   */
    if (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT) {
      RcCrdt.cReq.businessKind = '6'; /* 業務区分 */
    } else {
      RcCrdt.cReq.businessKind = '0'; /* 業務区分  */
    }
    RcCrdt.cReq.voidKind = ''.padLeft(1, '0'); /* 取消指令区分           */
    rcCardCrewMakeDay(); /* 売上日付               */
    RcCrdt.cReq.salePrice = ''.padLeft(8, '0'); /* 売上金額               */
    RcCrdt.cReq.taxPrice = ''.padLeft(7, '0'); /* 税送料                 */
    RcCrdt.cReq.orgCreditNumber = ''.padLeft(5, ' '); /* 元伝票番号             */
    RcCrdt.cReq.payKind = ''.padLeft(2, ' '); /* 支払区分               */
    RcCrdt.cReq.payDetail = ''.padLeft(84, ' '); /* 支払内容明細           */
    rcCardCrewSetItemcd();
    RcCrdt.cReq.admitKind = ''.padLeft(1, '0'); /* 承認区分               */
    RcCrdt.cReq.admitNumber = ''.padLeft(7, ' '); /* 事後承認番号           */

    if (!await RcSysChk.rcChkVegaProcess()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcCardCrew_MakeJIS(CARD_REQ);   /* カード区分＆内容       */
    }
    RcCrdt.cReq.cardNumber = ''.padLeft(4, ' '); /* 暗証番号               */
    RcCrdt.cReq.cycleNumber = ''.padLeft(3, '0'); /* サイクル通番           */
    buf = sprintf("%06i",
        [cBuf.dbStaffopen.cshr_cd]); /* @@@v15  従業員9桁対応:電文長が変わってしまうため修正なし */
    RcCrdt.cReq.staffNumber = buf.substring(1); /* 担当者コード           */
    RcCrdt.cReq.justPoint = ''.padLeft(8, '0'); /* 今回ポイント           */
    RcCrdt.cReq.memo1 = ''.padLeft(10, ' '); /* メモ１                 */
    RcCrdt.cReq.memo2 = ''.padLeft(10, ' '); /* メモ２                 */
    RcCrdt.cReq.saleQtyCounter = ''.padLeft(3, '0'); /* カウンタ売上件数       */
    RcCrdt.cReq.salePrcCounter = ''.padLeft(8, '0'); /* カウンタ売上金額       */
    RcCrdt.cReq.voidQtyCounter = ''.padLeft(3, '0'); /* カウンタ取消件数       */
    RcCrdt.cReq.voidPrcCounter = ''.padLeft(8, '0'); /* カウンタ取消金額       */
    RcCrdt.cReq.key1 =
        "\x00\x00\x00\x00\x00\x00\x00\x00"; /* KEY管理１              */
    RcCrdt.cReq.key2 =
        "\x00\x00\x00\x00\x00\x00\x00\x00"; /* KEY管理２              */
    RcCrdt.cReq.telNumber = ''.padLeft(15, '0'); /* チェック用電話番号     */
    RcCrdt.cReq.clearFlg = ''.padLeft(1, '0'); /* クリアフラグ           */
    RcCrdt.cReq.cardcompJudge = ''.padLeft(15, ' '); /* 端末判定カード会社識別 */

    // #if 0
    // /* creditタスク折返し */
    // if((recog_get(TPRAID_SYSTEM, RECOG_DUMMY_SUICA, RECOG_GETMEM) != RECOG_NO) && rcTR_OpeModeChk())
    // {
    // RcCrdt.cReq.data_type[0] = 'T';
    // }
    // #endif

    if ((await RcSysChk.rcChkVegaProcess()) && (RcSysChk.rcTROpeModeChk())) {
      /* VEGA3000接続の場合、ユーザーコード42-2は見ない*/
      RcCrdt.cReq.dataType = 'T';
    }

    if (await RcSysChk.rcChkVegaProcess()) {
      RcCrdt.cReqVEGA.reqCom =
          RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
      RcCrdt.cReqVEGA.reqAdd =
          RcCrdt.getCardCrewReqAdd(cMem.working.crdtReg.crdtReq.data);
      if (await RcCrdtFnc.rcChkCrdtCancel() ||
          await RcFncChk.rcCheckCrdtVoidSMode()) /* クレジット訂正小計画面 */ {
        /* 訂正の場合、処理区分と元伝票番号を上書きする */
        if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
          RcCrdt.cReq.orgCreditNumber = sprintf("%05i", [
            RegsMem().tCrdtLog[0].t400000.posReceiptNo
          ]); /* 元伝票番号             */

          RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime =
              sprintf("%i", [RegsMem().tCrdtLog[0].t400000Sts.saleYyMmDd]);
        } else {
          rpno = Bcdtol.cmBcdToL(cMem.working.crdtReg.rpno);
          RcCrdt.cReq.orgCreditNumber = sprintf("%05i", [rpno]);

          if ((cMem.working.crdtReg.stat & 0x0080) != 0) /* 当日解約分 */ {
            RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime =
                RcCrdt.cReqVEGA.reqCom.saleDate;
          } else {
            voidDate = Bcdtoa.cmBcdToA(cMem.working.crdtReg.voidDate,
                cMem.working.crdtReg.voidDate.length);
            RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime = voidDate.substring(2);
          }
        }

        if ((cMem.working.crdtReg.stat & 0x0080 != 0)) {
          /* 当日分解約？ */
          RcCrdt.cReq.businessKind = '1';
        } else {
          RcCrdt.cReq.businessKind = '2';
        }
      } else {
        RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime = ''.padLeft(6, ' ');
      }
      salePrice = RckyCrdtIn.cmLtobcd(await RcCrdtFnc.rcGetCrdtPayAmount(), 4);
      /* 売上金額               */
      RcCrdt.cReqVEGA.reqCom.salePrice =
          Bcdtoa.cmBcdToA(salePrice, salePrice.length);
      RcCrdt.cReqVEGA.reqAdd.buseBcnt =
          ''.padLeft(1, ' '); /* vega接続 ボーナス併用時ボーナス回数 */
    }
  }

  // TODO:00012 平野 クレジット宣言：動作確認まだ
  ///  関連tprxソース: rccardcrew.c - rcCardCrew_CrdtTxt
  static Future<void> rcCardCrewCrdtTxt() async {
    String code1 = '3070000'; // {'3','0','7','0','0','0','0'} /* クレジット */
    String code2 = '3070003'; // {'3','0','7','0','0','0','3'} /* クレジットオーソリー */
    String code3 = '3970008'; // {'3','9','7','0','0','0','8'} /* サーバー折返し */
    String code4 = '3070008'; // {'3','0','7','0','0','0','8'} /* サーバー折返し（松源） */
    String buf;
    String sRecNo = ''; // char recno[7+1];
    Uint8List salePrice = Uint8List(4); // char sale_price[4];
    int rpno;
    int iRecNo;
    // #if DEPARTMENT_STORE
    // long dummy_counter;
    // #endif
    int nttaspCreditNo;
    String voidDate; // char void_date[8];

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCardCrewCardTxt() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    cMem.working.crdtReg.crdtReq = RxSocket();
    cMem.working.crdtReg.crdtRcv = RxSocket();

    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);

    RcCrdt.cReq.dataType = "\x01\x00"; /* 電送区分               */
    RcCrdt.cReq.dataLen = "\x5A\x01"; /* 電文長                 */
    if (RcSysChk.rcTROpeModeChk()) {
      if (await rcChkCardCrewPlus()) {
        RcCrdt.cReq.businessCode = code4; /* 業務コード             */
      } else {
        RcCrdt.cReq.businessCode = code3; /* 業務コード             */
      }
    } else {
      if (cBuf.dbTrm.tranId == 0) {
        RcCrdt.cReq.businessCode = code1;
      } else {
        RcCrdt.cReq.businessCode = code2;
      }
    }
    if (!await RcSysChk.rcChkVegaProcess()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcCardCrew_Set_CompID();
    }
    RcCrdt.cReq.correspondId = 'S'; /* 通信ID                 */
    RcCrdt.cReq.reserve = "\x00\x00\x00\x00\x00\x00"; /* リザーブ               */
    RcCrdt.cReq.returnCode = "\x00\x00"; /* リターンコード         */
    RcCrdt.cReq.continueFlg = "\x00\x00"; /* 続行フラグ             */
    if (!await RcSysChk.rcChkVegaProcess()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcCardCrew_MakeTermID();                                                            /* 端末ID                 */
    }
    nttaspCreditNo = 0;
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_NTTASP_CREDIT_NO,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    nttaspCreditNo = ret.value;

    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // if(rcChk_Crdt_User() == NAKAGO_CRDT) {
      // if(MEM->tTtllog.calcData.suspend_flg == 1)
      // sprintf(RcCrdt.cReq.regcredit_number, "%05ld", MEM->tHeader.receipt_no);
      // else
      // sprintf(RcCrdt.cReq.regcredit_number, "%05ld", competition_get_rcptno(GetTid()));
      // }
      // else
      // sprintf(RcCrdt.cReq.regcredit_number, "%05ld", nttasp_credit_no);
    } else {
      RcCrdt.cReq.regCreditNumber =
          sprintf("%05i", [nttaspCreditNo]); /* 端末処理通番           */
    }
    if (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT) {
      if (await RcCrdtFnc.rcChkCrdtCancel()) {
        if ((cMem.working.crdtReg.stat & 0x0080) != 0) {
          /* 当日分解約？ */
          RcCrdt.cReq.businessKind = '7'; /* 業務区分               */
        } else {
          RcCrdt.cReq.businessKind = '8';
        }
      } else {
        RcCrdt.cReq.businessKind = '6';
      }
    } else {
      if (await RcCrdtFnc.rcChkCrdtCancel()) {
        if ((cMem.working.crdtReg.stat & 0x0080) != 0) {
          /* 当日分解約？ */
          RcCrdt.cReq.businessKind = '1'; /* 業務区分               */
        } else {
          RcCrdt.cReq.businessKind = '2';
        }
      } else {
        RcCrdt.cReq.businessKind = '0';
      }
    }
    RcCrdt.cReq.voidKind = ''.padLeft(1, '0'); /* 取消指令区分           */
    rcCardCrewMakeDay(); /* 売上日付               */
    salePrice = RckyCrdtIn.cmLtobcd(
        await RcCrdtFnc.rcGetCrdtPayAmount(), salePrice.length);
    RcCrdt.cReq.salePrice =
        Bcdtoa.cmBcdToA(salePrice, salePrice.length); /* 売上金額               */
    RcCrdt.cReq.taxPrice = ''.padLeft(7, '0'); /* 税送料                 */
    if (await RcCrdtFnc.rcChkCrdtCancel()) {
      if (CompileFlag.DEPARTMENT_STORE) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // if(rcChk_Crdt_User() == NAKAGO_CRDT) {
        // if( rcCheckCrdtVoidInquProc() == TRUE ) {
        // sprintf(cReq.orgcredit_number, "%05ld", MEM->tTtllog.t100900.vmc_chgtckt_cnt);
        // MEM->tTtllog.t100900.vmc_chgtckt_cnt = 0L;     /* 実績として必要ないので、リセットする */
        // }
        // else {
        // if(MEM->tTtllog.t100900.vmc_chgtckt_cnt != 0)
        // sprintf(cReq.orgcredit_number, "%05ld", MEM->tTtllog.t100900.vmc_chgtckt_cnt);
        // else {
        // if(MEM->tTtllog.calcData.suspend_flg == 1)
        // dummy_counter = MEM->tHeader.receipt_no + 10000;
        // else
        // dummy_counter = competition_get_rcptno(GetTid()) + 10000;
        // sprintf(cReq.orgcredit_number, "%05ld", dummy_counter);
        // }
        // }
        // }
        // else {
        // if( rcCheckCrdtVoidInquProc() == TRUE )
        // sprintf(cReq.orgcredit_number, "%05ld", MEM->tCrdtlog[0].t400000.pos_receipt_no);
        // else {
        // rpno = cm_bcdtol(CMEM->working.crdt_reg.rpno, sizeof(CMEM->working.crdt_reg.rpno));
        // sprintf(cReq.orgcredit_number, "%05ld", rpno);
        // }
        // }
      } else {
        if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
          RcCrdt.cReq.orgCreditNumber = sprintf("%05i", [
            RegsMem().tCrdtLog[0].t400000.posReceiptNo
          ]); /* 元伝票番号             */
          if ((RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT) &&
              (await CmCksys.cmSPVTSystem() != 0)) {
            RcKyCrdtVoid.crdtVoid.tranType = RcElog.CRDTVOID_SPVT;
          }
        } else {
          rpno = Bcdtol.cmBcdToL(cMem.working.crdtReg.rpno);
          RcCrdt.cReq.orgCreditNumber = sprintf("%05li", rpno);
        }
      }
    } else {
      RcCrdt.cReq.orgCreditNumber = ''.padLeft(5, ' ');
    }

    if (await RcSysChk.rcChkVegaProcess()) {
      RcCrdt.cReqVEGA.reqCom =
          RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
      RcCrdt.cReqVEGA.reqAdd =
          RcCrdt.getCardCrewReqAdd(cMem.working.crdtReg.crdtReq.data);

      if (await RcCrdtFnc.rcChkCrdtCancel() ||
          await RcFncChk.rcCheckCrdtVoidSMode()) /* クレジット訂正小計画面 */ {
        if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
          RcCrdt.cReq.orgCreditNumber = sprintf("%05i", [
            RegsMem().tCrdtLog[0].t400000.posReceiptNo
          ]); /* 元伝票番号             */

          RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime =
              sprintf("%i", [RegsMem().tCrdtLog[0].t400000Sts.saleYyMmDd]);
        } else {
          rpno = Bcdtol.cmBcdToL(cMem.working.crdtReg.rpno);
          RcCrdt.cReq.orgCreditNumber = sprintf("%05i", [rpno]);
          if ((cMem.working.crdtReg.stat & 0x0080) != 0) /* 当日解約分 */ {
            RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime =
                RcCrdt.cReqVEGA.reqCom.saleDate;
          } else {
            voidDate = Bcdtoa.cmBcdToA(cMem.working.crdtReg.voidDate,
                cMem.working.crdtReg.voidDate.length);
            RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime = voidDate.substring(2);
          }
        }
      } else {
        RcCrdt.cReqVEGA.reqAdd.orgcreditDatetime = ''.padLeft(6, ' ');
      }
    }

    rcCardCrewPayDetail(); /* 支払区分＆支払内容明細 */
    rcCardCrewSetItemcd();
    if (!rcCardCrewChkErrG30()) {
      RcCrdt.cReq.admitKind = ''.padLeft(1, '0'); /* 承認区分               */
      RcCrdt.cReq.admitNumber = ''.padLeft(7, ' '); /* 事後承認番号           */
    } else {
      RcCrdt.cReq.admitKind = ''.padLeft(1, '0');
      sRecNo = Bcdtoa.cmBcdToA(
          cMem.working.crdtReg.reno, cMem.working.crdtReg.reno.length);
      iRecNo = int.parse(sRecNo);
      RcCrdt.cReq.admitNumber = sprintf("%07ld", [iRecNo]);
    }
    if (!await RcSysChk.rcChkVegaProcess()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // rcCardCrew_MakeJIS(CRDT_REQ);                                                            /* カード区分＆内容       */
    }
    RcCrdt.cReq.cardNumber = ''.padLeft(4, ' '); /* 暗証番号               */
    RcCrdt.cReq.cycleNumber = ''.padLeft(3, '0'); /* サイクル通番           */
    buf = sprintf("%06i",
        cBuf.dbStaffopen.cshr_cd); /* @@@v15  従業員9桁対応:電文長が変わってしまうため修正なし */
    RcCrdt.cReq.staffNumber = buf.substring(1); /* 担当者コード           */
    RcCrdt.cReq.justPoint = ''.padLeft(8, '0'); /* 今回ポイント           */
    await rcCardCrewSetRegNo();
    RcCrdt.cReq.memo2 = ''.padRight(10, ' '); // メモ２
    RcCrdt.cReq.saleQtyCounter = ''.padLeft(3, '0'); // カウンタ売上件数
    RcCrdt.cReq.salePrcCounter = ''.padLeft(8, '0'); // カウンタ売上金額
    RcCrdt.cReq.voidQtyCounter = ''.padLeft(3, '0'); // カウンタ取消件数
    RcCrdt.cReq.voidPrcCounter = ''.padLeft(8, '0'); // カウンタ取消金額
    RcCrdt.cReq.key1 = '\x00\x00\x00\x00\x00\x00\x00\x00'; // KEY管理１
    RcCrdt.cReq.key2 = '\x00\x00\x00\x00\x00\x00\x00\x00'; // KEY管理２
    if (await CmCksys.cmSPVTSystem() != 0) {
      RcCrdt.cReq.telNumber = ''.padRight(15, ' '); // チェック用電話番号
      if (cMem.working.crdtReg.cardDiv == '9') {
        RcCrdt.cReq.telNumber = '5';
      } else {
        RcCrdt.cReq.telNumber = '1';
      }
    } else {
      RcCrdt.cReq.telNumber = ''.padLeft(15, '0');
    }
    RcCrdt.cReq.clearFlg = '0'; // クリアフラグ
    RcCrdt.cReq.cardcompJudge = ''.padRight(15, ' '); // 端末判定カード会社識別

    // #if 0
    // /* creditタスク折返し */
    // if((recog_get(TPRAID_SYSTEM, RECOG_DUMMY_SUICA, RECOG_GETMEM) != RECOG_NO) && rcTR_OpeModeChk())
    // {
    // cReq.data_type[0] = 'T';
    // }
    // #endif

    if ((await RcSysChk.rcChkVegaProcess()) && (RcSysChk.rcTROpeModeChk())) {
      /* VEGA3000接続の場合、ユーザーコード42-2は見ない*/
      RcCrdt.cReq.dataType = 'T';
    }
  }

  /// VEGA3000端末用の処理中断コードの作成
  /// 関連tprxソース: rccardcrew.c - rcCardCrew_VegaCnclTxt
  static void rcCardCrewVegaCnclTxt() {
    String code = '9999999'; /* 中断 */
    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);

    cMem.working.crdtReg.crdtReq = RxSocket();
    cMem.working.crdtReg.crdtRcv = RxSocket();

    /* creditタスクに送信するのはbusiness_codeのみ */
    RcCrdt.cReq.businessCode = code;
    return;
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_InquCard
  static Future<int> rcCardCrewInquCard() async {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();
    // todo クレ宣言　暫定対応5 クレジット実行体が実装されたら以下は削除する
    cMem.working.crdtReg.crdtRcv.order = RcCrdt.ORDER_RECEIVE;

    if (!CompileFlag.MC_SYSTEM) {
      RcGtkTimer.rcGtkTimerRemove();
      // TODO: rxQueueRead未実装のため、true部分のみ実装
      // if(rxQueueRead(RXQUEUE_CREDIT_RSOCKET, RXQUEUE_NOWAIT) == RXQUEUE_OK) {
      // if (rxMemRead(RXMEM_CREDIT_SOCKET, &CMEM->working.crdt_reg.crdtrcv) == RXMEM_OK) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CREDIT_SOCKET);
      if (xRet.isValid()) {
        if (cMem.working.crdtReg.crdtRcv.order == RcCrdt.ORDER_RECEIVE) {
          RckyClr.rcClearPopDisplay();
          await RcIfEvent.rxChkTimerAdd();
          await RcExt.rcClearErrStat("rcCardCrewInquCard");
          // todo クレ宣言　暫定対応5 クレジット実行体が実装されたらコメント解除する
          // errNo = await rcCardCrewCardErr();
          if (errNo == 0) {
            // todo クレ宣言　暫定対応5 クレジット実行体が実装されたらコメント解除する
            // await rcCardCrewSetName();
            if (!await RcCrdtFnc.rcCheckCrdtVoidMcdProc()) {
              cMem.working.crdtReg.step = (KyCrdtInStep.GOOD_THRU.cd - 1);
              await RckyCrdtIn.rcKyCrdtIn();
              // todo クレ宣言　暫定対応5 クレジット実行体が実装されたらコメント解除する
              // rcCardCrewSetTerm();
              // rcCardCrewPayWay();
              // await rcCardCrewPayTime();
              // rcCardCrewBonusTerm();
              // await rcCardCrewBonusMonth();　//コメント解除対象ここまで
              // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
              // #if DEPARTMENT_STORE
              //     rcCardCrew_CardCompCd();
              //     if((rcChk_Crdt_User() == NAKAGO_CRDT) && (CMEM->stat.Depart_Flg & 0x10))
              //     {
              //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCardCrew_InquCard() DspEnd\n");
              //       rcCardCrew_CashIn_Prg();
              //       return(OK);
              //     }
              //     else
              //     {
              //       CMEM->working.crdt_reg.step = (RECEIT_NO - 1);
              //       rcKyCrdtIn();
              //     }
              //   #else
              cMem.working.crdtReg.step = (KyCrdtInStep.RECEIT_NO.cd - 1);
              await RckyCrdtIn.rcKyCrdtIn();
              // #endif
            } else {
              await rcCardCrewSetName();
            }
          }
          if (await RcSysChk.rcChkVegaProcess()) {
            // if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
            //   err_no = rcCrdtVoid_CrdtVegaRead_End(err_no);
            // }
          }
        } else {
          // err_no = cMem.working.crdtReg.crdtRcv.errNo;
          // if (err_no == DlgConfirmMsgKind.MSG_TIMEOVER.dlgId) {
          //   if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
          //       (await RcFncChk.rcCheckCrdtVoidIMode())) {
          //     await RcKyCrdtVoid.crdtVoidClear();
          //   } else {
          //     RckyClr.rcClearPopDisplay();
          //   }
          //   await RcExt.rcClearErrStat("rcCardCrewInquCard");
          // }
        }
      } else {
        // err_no = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        // if (rxMemPtr(RXMEM_CREDIT_SOCKET, (void **) & RX_SOCT) == RXMEM_OK) {
        //   RX_SOCT->order = RcCrdt.ORDER_RESET;
        // }
      }
      WaitCnt = 0;
      // }
      // else {
      //   if(await RcSysChk.rcChkVegaProcess()) {
      //   /* VEGA3000接続の場合、無制限に端末からの応答を待つ */
      //     err_no = RcGtkTimer.rcGtkTimerAdd(RCV_WAIT, rcCardCrewInquCard);
      //   }
      //   else {
      // if(WaitCnt > MAX_WAIT) {
      //   rxMemClr(RXMEM_CREDIT_SOCKET); /* この状態に陥る事は稀だが、陥った時の救済としてクリアを呼ぶ */
      //   err_no = DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId;
      //   WaitCnt = 0;
      // }
      // else {
      //   WaitCnt++;
      //   err_no = RcGtkTimer.rcGtkTimerAdd(RCV_WAIT, rcCardCrewInquCard);
      // }
      //   }
      // }
      // if ((await RcSysChk.rcChk2800System()) &&
      //   (await RcSysChk.rcNewSGChkNewSelfGateSystem())) {	/* Speeza-J */
      //   if (RcFncChk.rcCheckMasrSystem()) {
      //     RcMasr.rcMasrActCtrl(MasrOrderCk.CNCL_START);
      //   }
      // }
      if (errNo != 0) {
        // todo クレ宣言　暫定対応5 クレジット実行体が実装されたらコメント解除する
        // await rcCardCrewInquEnd(errNo);
      }
    }
    return errNo;
  }

  /// VEGA3000端末用の処理中断結果取得処理
  ///  関連tprxソース: rccardcrew.c - rcCardCrew_InquVegaCnclRcv
  static Future<int> rcCardCrewInquVegaCnclRcv() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();
    // todo クレ宣言　暫定対応5 クレジット実行体が実装されたら以下は削除する
    cMem.working.crdtReg.crdtRcv.order = RcCrdt.ORDER_RECEIVE;

    RcGtkTimer.rcGtkTimerRemove();

    // TODO: rxQueueRead未実装のため、true部分のみ実装
    // if(rxQueueRead(RXQUEUE_CREDIT_RSOCKET, RXQUEUE_NOWAIT) == RXQUEUE_OK)
    // {
    //   if(rxMemRead(RXMEM_CREDIT_SOCKET, &CMEM->working.crdt_reg.crdtrcv) == RXMEM_OK)
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CREDIT_SOCKET);
    if (xRet.isValid()) {
      if (cMem.working.crdtReg.crdtRcv.order == RcCrdt.ORDER_RECEIVE) {
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          RcQcDsp.rcQCBackBtnFunc();
        } else {
          // クレジット宣言状態をクリアする
          await RcMcd.rcCardCrewVegaError(0);
        }
      }
      WaitCnt = 0;
    } else {
      if (WaitCnt > MAX_WAIT) {
        // rxMemClr(RXMEM_CREDIT_SOCKET); 共有メモリの初期化処理 // この状態に陥る事は稀だが、陥った時の救済としてクリアを呼ぶ
        errNo = DlgConfirmMsgKind.MSG_MI_TIMEOUT_ERROR.dlgId;
        WaitCnt = 0;
      } else {
        WaitCnt++;
        // todo クレ宣言　暫定対応6 rcGtkTimerAddが実装されていないため
        // errNo = RcGtkTimer.rcGtkTimerAdd(RCV_WAIT, rcCardCrewInquVegaCnclRcv);
        errNo = await rcCardCrewInquVegaCnclRcv();
      }

      // エラー時にもクレジット宣言状態はクリアする
      if (errNo != Typ.OK) {
        await RcMcd.rcCardCrewVegaError(errNo);
      }
    }

    return errNo;
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_CardErr
  static Future<int> rcCardCrewCardErr() async {
    int err_no = 0;
    String yy;
    String mm;
    String buf;
    String log;
    int tm_year, tm_mon, year, month;
    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);

    if (RcCrdt.CRCV.err_code[0] != ' ') {
      buf = RcCrdt.CRCV.err_code;
      log = "rcCardCrew_CardErr() err_cd [$buf]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        // TODO:10166 クレジット決済 20241004実装対象外
        // if((memcmp(CRCV.err_code, "S02", 3)) == 0)
        // return(OK);
        // if((memcmp(CRCV.err_code, "S12", 3)) == 0) {
        // if(rcSG_Chk_SelfGate_System() || rcQC_Chk_Qcashier_System())
        // CMEM->working.crdt_reg.kasumi_offcrdt = 1;
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT158);
        // return(MSG_OFFCRDT_NG);
        // }
        // if((memcmp(CRCV.err_code, "S14", 3)) == 0) {
        // if(rcChk_Floor_Limt() == FALSE)     /* フロアリミットを超えていない場合 */
        // return(MSG_OFFCRDT_OK);
        // else if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT158);
        // else
        // return(MSG_OFFCRDT_NG);
        // }
        // if(memcmp(CRCV.err_code, "S00", 3) != 0) {
        // rcSet_CreditErr_Code(buf);
        // if((memcmp(CRCV.err_code, "G12", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G22", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G30", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G54", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G55", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G95", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G96", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G97", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G98", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G99", 3) == 0)) {
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT155);
        // return(MSG_TEXT51);
        // }
        // else if((memcmp(CRCV.err_code, "S13", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S20", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S26", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S27", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S28", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S30", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S31", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S40", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S41", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S42", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S43", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S44", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S51", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S54", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S55", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S57", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S58", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S59", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S63", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S64", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S65", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S66", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S77", 3) == 0)) {
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT155);
        // return(MSG_TEXT68);
        // }
        // else if((memcmp(CRCV.err_code, "G56", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G60", 3) == 0) ||
        // (memcmp(CRCV.err_code, "G61", 3) == 0)) {
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT155);
        // return(MSG_TEXT53);
        // }
        // else if((memcmp(CRCV.err_code, "S04", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S11", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S29", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S53", 3) == 0)) {
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT155);
        // return(MSG_TEXT67);
        // }
        // else if((memcmp(CRCV.err_code, "G83", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S56", 3) == 0)) {
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_TEXT156);
        // return(MSG_TEXT66);
        // }
        // else if(memcmp(CRCV.err_code, "G42", 3) == 0)
        // return(MSG_TEXT52);
        // else if(memcmp(CRCV.err_code, "G70", 3) == 0)
        // return(MSG_TEXT54);
        // else if(memcmp(CRCV.err_code, "G71", 3) == 0)
        // return(MSG_TEXT55);
        // else if(memcmp(CRCV.err_code, "G72", 3) == 0)
        // return(MSG_TEXT56);
        // else if(memcmp(CRCV.err_code, "G73", 3) == 0)
        // return(MSG_TEXT57);
        // else if(memcmp(CRCV.err_code, "G74", 3) == 0)
        // return(MSG_TEXT58);
        // else if(memcmp(CRCV.err_code, "G75", 3) == 0)
        // return(MSG_TEXT59);
        // else if(memcmp(CRCV.err_code, "G76", 3) == 0)
        // return(MSG_TEXT60);
        // else if(memcmp(CRCV.err_code, "G77", 3) == 0)
        // return(MSG_TEXT61);
        // else if(memcmp(CRCV.err_code, "G78", 3) == 0)
        // return(MSG_TEXT62);
        // else if(memcmp(CRCV.err_code, "G79", 3) == 0)
        // return(MSG_TEXT63);
        // else if(memcmp(CRCV.err_code, "G80", 3) == 0)
        // return(MSG_TEXT64);
        // else if(memcmp(CRCV.err_code, "G81", 3) == 0)
        // return(MSG_TEXT65);
        // else if(memcmp(CRCV.err_code, "G71", 3) == 0)
        // return(MSG_TEXT70);
        // else if(memcmp(CRCV.err_code, "G72", 3) == 0)
        // return(MSG_TEXT71);
        // else if(memcmp(CRCV.err_code, "G73", 3) == 0)
        // return(MSG_TEXT72);
        // else if(memcmp(CRCV.err_code, "G74", 3) == 0)
        // return(MSG_TEXT69);
        // else if(memcmp(CRCV.err_code, "G94", 3) == 0)
        // return(MSG_TEXT73);
        // else{
        // if(rcQC_Chk_Qcashier_System())
        // return(MSG_CARD_NOTUSE3);
        // return(MSG_CRDTDEMANDERR);
        // }
        // }
      } else {
        // TODO:10166 クレジット決済 20241004実装対象外
        // #if DEPARTMENT_STORE
        // if(RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) {
        // if((memcmp(CRCV.err_code, "S11", 3)) == 0) {   /* ネガチェックエラー */
        // if(CMEM->stat.Depart_Flg & 0x10)             /* 売掛入金の場合はネガチェックしない */
        // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcCardCrew_CardErr() Credit_CashIn\n");
        // else {
        // rcSet_CreditErr_Code(buf);
        // return(MSG_TEXT67);                       /* クレジット支払無効お取扱いできません */
        // }
        // }
        // else {
        // if(memcmp(CRCV.err_code, "S00", 3) != 0) {
        // if(memcmp(CRCV.err_code, "G", 1) == 0) {
        // rcSet_CreditErr_Code(buf);
        // return(MSG_TEXT67);
        // }
        // else if((memcmp(CRCV.err_code, "S53", 3) == 0) ||
        // (memcmp(CRCV.err_code, "S56", 3) == 0)) {
        // rcSet_CreditErr_Code(buf);
        // return(MSG_CRDTDEMANDERR);
        // }
        // else                                      /* 中合要望によりエラーチェックしない   */
        // return(MSG_OFFCRDT_OK);
        // }
        // }
        // }
        // #endif
        if (RcCrdt.CRCV.err_code.substring(0, 3) != "S00") {
          RcSet.rcSetCreditErrCode(buf);
          if (RcCrdt.CRCV.err_code.substring(0, 3) == "S56") {
            // return(MSG_GOODTHRUERR);
          } else if (await RcSysChk.rcChkVegaProcess()) {
            if (RcCrdt.CRCV.err_code[0] == 'D') {
              if (RcCrdt.CRCV.err_code.substring(0, 3) == "D01") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D01;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D02") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D02;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D05") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D05;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D06") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D06_D07;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D07") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D06_D07;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D10") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D10_D11;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D11") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D10_D11;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D20") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D20;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D21") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D21;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D90") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D90;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D41") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D41;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D42") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D42;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D43") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D43;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D52") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D52;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D53") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D53;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D54") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D54;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D55") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D55;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D91") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D91;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D97") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D97;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D98") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D98;
              } else if (RcCrdt.CRCV.err_code.substring(0, 3) == "D99") {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_D99;
              } else {
                cMem.ent.addMsgBuf = LRccrdt.VEGA_ERROR_DXX;
              }
              return (DlgConfirmMsgKind.MSG_CRDT_VEGA_ERROR.dlgId);
            } else {
              if ((cMem.working.crdtReg.crdtRcv.errNo ==
                      DlgConfirmMsgKind.MSG_TRAN_CARD_NOTSAME.dlgId) &&
                  (await RcCrdtFnc.rcCheckCrdtVoidInquProc() == true)) {
                return (DlgConfirmMsgKind.MSG_TRAN_CARD_NOTSAME.dlgId);
              } else {
                return (DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId);
              }
            }
          } else {
            return (DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId);
          }
        }
      }
    }
    // TODO:10166 クレジット決済 20241004実装対象外
    // #if DEPARTMENT_STORE
    // if(RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) {
    // if(CMEM->stat.Depart_Flg & 0x01)
    // {
    // if(memcmp(CRCV->valid_term, "0000", 4) == 0) {    /* 自社クレジットの場合、有効期限00/00はエラーにしない */
    // memset(buf, 0x0, sizeof(buf));
    // snprintf(buf, sizeof(CRCV->valid_term)+1, "%s", CRCV->valid_term);
    // sprintf(log,"rcCardCrew_CardErr() valid_term [%s]\n", buf);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    // return(OK);
    // }
    // }
    // else if(rcCheck_CrdtVoid_Mode())
    // {
    // switch(CMEM->working.crdt_reg.company_cd)
    // {
    // case 1111  :
    // case 51080 :
    // case 51081 : if(memcmp(CRCV->valid_term, "0000", 4) == 0) {
    // memset(buf, 0x0, sizeof(buf));
    // snprintf(buf, sizeof(CRCV->valid_term)+1, "%s", CRCV->valid_term);
    // sprintf(log,"rcCardCrew_CardErr() valid_term [%s]\n", buf);
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
    // return(OK);
    // }
    // break;
    // default    : break;
    // }
    // }
    // }
    // #endif
    /* 有効期限チェック */
    cMem.date = SysDate().cmReadSysdate(); // cm_read_sysdate(&CMEM->date);
    tm_year = cMem.date!.year + 1900;
    tm_mon = cMem.date!.month + 1;
    if ((RcCrdt.CRCV.valid_term.substring(0, 4) == "    ") ||
        (await RcSysChk.rcChkVegaProcess())) {
      cMem.working.crdtReg.chkGoodThru = 1;
    } else {
      cMem.working.crdtReg.chkGoodThru = 0;
      yy = RcCrdt.CRCV.valid_term.substring(0, 2);
      mm = RcCrdt.CRCV.valid_term.substring(2, 4);
      year = int.parse(yy);
      // TODO:10166 クレジット決済 20241004実装対象外
      // #if DEPARTMENT_STORE
      // if(RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT)
      // {
      // if(memcmp(CRCV->cardcomp_code, "1001", 4) == 0) {     /* 外商カードは和歴なので西暦に補正 */
      // year = year - 12;                                  /* 12を引く計算式は中合指定         */
      // if(year < 0) {
      // year = 0;
      // return(OK);
      // }
      // }
      // }
      // #endif
      if (year > 85) {
        year = year + 1900;
      } else {
        year = year + 2000;
      }
      month = int.parse(mm); /* 有効期限セット */
    }
    if (RcCardCrew.CHECK_GOOD_THRU != 0) { //#if CHECK_GOOD_THRU
      if (cMem.working.crdtReg.chkGoodThru == 1) {
        log = "rcCardCrewCardErr good_thru no check !\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      } else {
        // TODO:10166 クレジット決済 20241004実装対象外
        // if(tm_year > year) {
        // err_no = MSG_GOODTHRUERR;
      }
      // else if((tm_year == year) && (tm_mon > month)) {
      // err_no = MSG_GOODTHRUERR;
      // }
      // else if((month == 0) || (month > 12)) {
      // err_no = MSG_GOODTHRUERR;
      // }
      // }
    } //#endif
    return err_no;
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_InquEnd
  static Future<void> rcCardCrewInquEnd(int err_no) async {
    AcMem cMem = SystemFunc.readAcMem();
    SgMem selfMem = SgMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    RcGtkTimer.rcGtkTimerRemove();
    if ((await RcFncChk.rcCheckCrdtVoidSMode()) ||
        (await RcFncChk.rcCheckCrdtVoidIMode())) {
      await RcKyCrdtVoid.crdtVoidClear();
    } else {
      RckyClr.rcClearPopDisplay();
    }
    RcExt.rcClearErrStat("rcCardCrewInquEnd");
    if ((((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
                (RcCrdtFnc.rcChkKasumiCard())) ||
            (RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT)) &&
        (err_no != DlgConfirmMsgKind.MSG_GOODTHRUERR.dlgId)) {
      if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
        RcSet.rcClearCrdtReg();
        cMem.working.crdtReg.stat |= 0x0200;
      } else {
        if ((err_no == DlgConfirmMsgKind.MSG_SOCKET_CONNECTNG.dlgId) ||
            (err_no == DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId) ||
            (err_no == DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId) ||
            (err_no == DlgConfirmMsgKind.MSG_TEXT158.dlgId) ||
            (err_no == DlgConfirmMsgKind.MSG_TEXT157.dlgId)) {
          cMem.working.crdtReg.stat |= 0x1000; /* 通信PCオフライン */
          if (await RcSysChk.rcSGChkSelfGateSystem() ||
              await RcSysChk.rcQCChkQcashierSystem()) {
            cMem.working.crdtReg.stat |= 0x0200;
            if (err_no == DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId) {
              await rcCardCrewCaution(err_no, RcCrdt.CARD_REQ);
              return;
            } else if ((err_no == DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId) ||
                (err_no == DlgConfirmMsgKind.MSG_TEXT158.dlgId)) {
              if (await RcSysChk.rcSGChkSelfGateSystem()) {
                selfMem.sg_password_flg = 1;
              }
            } else {
              if (await RcCrdtFnc.rcChkFloorLimit() == false) {
                /* フロアリミットを超えていない場合 */
                await rcCardCrewCaution(
                    DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId, RcCrdt.CARD_REQ);
                return;
              } else {
                err_no = DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId;
                if ((await RcSysChk.rcQCChkQcashierSystem()) &&
                    (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT)) {
                  err_no = DlgConfirmMsgKind.MSG_TEXT158.dlgId;
                }

                if (await RcSysChk.rcSGChkSelfGateSystem()) {
                  selfMem.sg_password_flg = 1;
                }
              }
            }
          } else {
            if ((err_no == DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId) ||
                (err_no == DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId)) {
              await rcCardCrewCaution(err_no, RcCrdt.CARD_REQ);
            } else {
              if (await RcCrdtFnc.rcChkFloorLimit() == false) {
                /* フロアリミットを超えていない場合 */
                await rcCardCrewCaution(
                    DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId, RcCrdt.CARD_REQ);
              } else {
                await rcCardCrewCaution(
                    DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId, RcCrdt.CARD_REQ);
              }
            }
            return;
          }
        } else {
          RcSet.rcClearCrdtReg();
          cMem.working.crdtReg.stat |= 0x0200;
        }
      }
    } else {
      RcSet.rcClearCrdtReg();
      cMem.working.crdtReg.stat |= 0x0200;
      if (RcSysChk.rcChkCrdtUser() == Datas.KANSUP_CRDT) {
        if (await RcSysChk.rcSGChkSelfGateSystem() ||
            await RcSysChk.rcQCChkQcashierSystem()) {
          if (err_no == DlgConfirmMsgKind.MSG_SOCKET_CONNECTNG.dlgId) {
            cMem.working.crdtReg.stat |= 0x1000; /* 通信PCオフライン */
            if (await RcSysChk.rcSGChkSelfGateSystem()) {
              selfMem.sg_password_flg = 1;
            }
          }
        }
      }
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          if (err_no == DlgConfirmMsgKind.MSG_SOCKET_CONNECTNG.dlgId) {
            err_no = DlgConfirmMsgKind.MSG_TEXT157.dlgId;
          } else if (err_no == DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId) {
            err_no = DlgConfirmMsgKind.MSG_TEXT158.dlgId;
          }
        }
      }
    }
    if (await RcFncChk.rcCheckCrdtVoidMode()) {
      await RcKyCrdtVoid.rcCrdtVoidDialogErr(err_no, 1, '');
    } else {
      if (await RcSysChk.rcChkVegaProcess()) {
        if (ifSave.count != 0) {
          // イベント抑止中にイベントが保持されている
          SystemFunc.ifSave = IfWaitSave();
        }
        if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
          if (await RcFncChk.rcCheckCrdtVoidSMode() ||
              await RcFncChk.rcCheckCrdtVoidIMode()) {
            /* クレジット訂正状態を取消す */
            // TODO:10166 クレジット決済 20241004実装対象外
            // rcCrdtVoid_CnclEnd(1);
          }
        } else if (!(await RcSysChk.rcQCChkQcashierSystem())) {
          /* クレジット宣言状態をクリアする */
          await RcMcd.rcCardCrewVegaError(0);
        }

        if (((cBuf.vega3000Conf.vega3000CancelFlg == 1) ||
                (await RcSysChk.rcQCChkQcashierSystem())) &&
            (cMem.ent.addMsgBuf.isNotEmpty) &&
            (cMem.ent.addMsgBuf == LRccrdt.VEGA_ERROR_D52)) {
          /* レジでキャンセル操作をした場合、エラーダイアログ表示しない */
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcCardCrewInquEnd : rcErr() Skip !");
          RcSet.rcClearCreditErrCode();
          err_no = Typ.OK;

          if ((RckyRfdopr.rcRfdOprCheckAllRefundMode() == true) ||
              (RckyRfdopr.rcRfdOprCheckRcptVoidMode() == true)) {
            /* 通番訂正で中止ボタン押下した場合、このタイミングで登録画面に戻す */
            // TODO:10166 クレジット決済 20241004実装対象外
            // rcRfdOpr_CrdtVegaCncl_End();
          }

          if ((await RcSysChk.rcQCChkQcashierSystem()) &&
              (RcFncChk.rcQCCheckCrdtDspMode())) {
            //画面の「戻る」か、端末のキャンセルボタンを押された場合、支払選択画面に戻る
            if (atSing.psenErrFlg == 1) {
              await RcQcDsp.rcQCPSenErr(1, 'A');
              atSing.psenErrFlg = 0;
            } else {
              RcQcDsp.rcQCBackBtnFunc();
            }
          }
        }

        if (err_no != Typ.OK) {
          cMem.ent.errNo = err_no;
          await RcExt.rcErr("rcCardCrewInquEnd", cMem.ent.errNo);
        }
      } else {
        cMem.ent.errNo = err_no;
        await RcExt.rcErr("rcCardCrewInquEnd", cMem.ent.errNo);
      }
    }
    await RcIfEvent.rxChkTimerAdd();
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_SetName
  static Future<void> rcCardCrewSetName() async {
    String utf_name = "";
    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);

    if ((RcCrdt.CRCV.err_code[0] == ' ') ||
        (RcCrdt.CRCV.err_code.substring(0, 3) == "S00") ||
        ((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
            (RcCrdt.CRCV.err_code.substring(0, 3) == "S02"))) {
      if (!await RcCrdtFnc.rcCheckCrdtVoidMcdProc()) {
        utf_name = await RcPanaInq.rcPanaIncRcvdataCnv(RcCrdt.CRCV.cardcomp_name);
        cMem.working.refData.crdtTbl.card_company_name = utf_name;
        if (await RcSysChk.rcChkVegaProcess()) {
          /* VEGA3000接続の場合、応答電文の値を参照しカード番号をセットする */
          if (RcCrdt.CRCV.member_code.isNotEmpty) {
            cMem.working.crdtReg.cdno = RcCrdt.CRCV.member_code;
          }
        }
        // TODO:10166 クレジット決済 20241004実装対象外
        // else
        // {
        // cm_asctobcd(buf, CRCV->member_code, sizeof(buf), sizeof(CRCV->member_code));
        // cm_mov(cMem.ent.entry, buf, sizeof(buf));
        // }
      } else {
        // TODO:10166 クレジット決済 20241004実装対象外
        // if(rcChk_VEGA_Process())
        // {
        // /* VEGA3000接続の場合、応答電文の値を参照しカード番号をセットする */
        // memset(CrdtVoid.crdtno, 0x0, sizeof(CrdtVoid.crdtno));
        // cm_mov(CrdtVoid.crdtno, CRCV->member_code, sizeof(CRCV->member_code));
        // }
        // else
        // {
        // cm_asctobcd(buf, CRCV->member_code, sizeof(buf), sizeof(CRCV->member_code));
        // cm_mov(cMem.ent.entry, buf, sizeof(buf));
        // memset(CrdtVoid.crdtno, 0x0, sizeof(CrdtVoid.crdtno));
        // cm_bcdtoa(CrdtVoid.crdtno, &cMem.ent.entry[2], sizeof(CrdtVoid.crdtno), sizeof(cMem.ent.entry)-2);
        // }
        // CrdtVoid.digit = 1;
        // rcCrdtVoidDsp_Entry(1);
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_SetTerm
  static void rcCardCrewSetTerm() {
    AcMem cMem = SystemFunc.readAcMem();
    // char buf[sizeof(CMEM->working.crdt_reg.date)];
    Uint8List buf = Uint8List(cMem.working.crdtReg.date.length);
    String tmp = "";
    String mmyy = "";
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((RcCrdt.CRCV.err_code[0] == ' ') ||
        (RcCrdt.CRCV.err_code.substring(0, 3) == "S00") ||
        ((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
            (RcCrdt.CRCV.err_code.substring(0, 3) == "S02"))) {
      if (cMem.working.crdtReg.chkGoodThru == 1) {
        cMem.ent.tencnt = 4;
      } else {
        if ((RcCrdt.CHK_DEVICE_MCD()) || (cBuf.dbTrm.goodThruDsp == 1)) {
          /* YYMM */
          // cm_asctobcd(buf, CRCV.valid_term, sizeof(buf), sizeof(CRCV.valid_term));
          buf = AscToBcd.cmAscTobcd(RcCrdt.CRCV.valid_term);
          // cm_mov(&cMem.ent.entry[8], buf, sizeof(buf));
          if (buf.isNotEmpty) {
            cMem.ent.entry[8] = buf[0];
            cMem.ent.entry[9] = buf[1];
          }
        } else {
          // yymm → mmyyに変更する
          tmp = RcCrdt.CRCV.valid_term.substring(2);
          mmyy += tmp;
          tmp = RcCrdt.CRCV.valid_term.substring(0, 2);
          mmyy += tmp;
          buf = AscToBcd.cmAscTobcd(mmyy);
          // cm_mov(&cMem.ent.entry[8], buf, sizeof(buf));
          if (buf.isNotEmpty) {
            cMem.ent.entry[8] = buf[0];
            cMem.ent.entry[9] = buf[1];
          }
        }
        cMem.ent.tencnt = ChkZ0.cmChkZero0(cMem.ent.entry);
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Caution
  static Future<void> rcCardCrewCaution(int msg, int req) async {
    AcMem cMem = SystemFunc.readAcMem();

    RcQcCom.rcQCChangeErrMsg(0);
    if ((msg == DlgConfirmMsgKind.MSG_OFFCRDT_NG.dlgId) ||
        (msg == DlgConfirmMsgKind.MSG_TEXT158.dlgId)) {
      await rcCardCrewConf(msg, 1, rcCardCrewEnd, LTprDlg.BTN_CONF, '');
    } else if (msg == DlgConfirmMsgKind.MSG_TEXT78.dlgId) {
      await rcCardCrewConf(
          msg, 1, rcCardCrewCautionClear, LTprDlg.BTN_CONF, '');
    } else {
      if (CompileFlag.DEPARTMENT_STORE) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // if (req == CRDT_REQ) {
        //   if (msg == DlgConfirmMsgKind.MSG_TELL_AUTHORI.dlgId) {
        //     await rcCardCrewConf(msg, 1, rcCardCrewRecogn, LTprDlg.BTN_CONF, '');
        //   } else {
        //     await rcCardCrewConf(msg, 1, rcCardCrewCha, LTprDlg.BTN_CONF, '');
        //   }
        // } else {
        //   await rcCardCrewConf(msg, 1, rcCardCrewYes, LTprDlg.BTN_CONF, '');
        // }
      } else {
        if (req == RcCrdt.CRDT_REQ) {
          if (msg == DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId) {
            cMem.working.crdtReg.stat |= 0x1000; // 通信PCオフライン
          }
          if ((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
              (await RcSysChk.rcQCChkQcashierSystem()) &&
              (msg == DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId)) {
            rcCardCrewCha();
          } else {
            await rcCardCrewConf(msg, 1, rcCardCrewCha, LTprDlg.BTN_CONF, '');
          }
        } else {
          if ((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
              (await RcSysChk.rcQCChkQcashierSystem()) &&
              (msg == DlgConfirmMsgKind.MSG_OFFCRDT_OK.dlgId)) {
            rcCardCrewYes();
          } else {
            await rcCardCrewConf(msg, 1, rcCardCrewYes, LTprDlg.BTN_CONF, '');
          }
        }
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Cha
  static Future<void> rcCardCrewCha() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCardCrewCha() Push\n");
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();

    await rcCardCrewCautionClear();
    cMem.ent.errNo = await RcFncChk.rcChkRPrinter();
    if (cMem.ent.errNo != Typ.OK) {
      await RcIfEvent.rcWaitSave();
      if (ifSave.count > 0) {
        ifSave = IfWaitSave();
      }
      await RcExt.rcErr('rcCardCrewCha', cMem.ent.errNo);
      return;
    }
    if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // await RcKyCrdtVoid.rcCrdtVoidExecFnc(null, 0);
      return;
    }
    await RcSet.rcClearKyItem();
    RcSet.rcClearEntry();
    await RcSet.rcClearDataReg();
    RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
    cMem.stat.fncCode = cMem.working.crdtReg.crdtKey;
    // #if SELF_GATE
    if (!await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
      // #endif
      // #if DEPARTMENT_STORE
      // if ((await RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) && (cMem.stat.departFlg & 0x01)) {
      //   cMem.working.crdtReg.multiFlg |= 0x02; /* 自社クレジット取引完了 */
      // }
      // #endif
      if (!RcFncChk.rcQCCheckCrdtUseMode()) {
        RcSet.rcReMovScrMode();
      }
      RcCrdtDsp.rcCrdtReDsp();
      // #if SELF_GATE
    }
    // #endif
    await RcIfEvent.rcWaitSave();
    if (ifSave.count > 0) {
      ifSave = IfWaitSave();
    }
    RcIfEvent.rxChkTimerRemove();
    await RckyCha.rcChargeAmount1();
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Yes
  static Future<void> rcCardCrewYes() async {
    int errNo;
    AcMem cMem = SystemFunc.readAcMem();
    List<int> tmpBuf = List<int>.filled(cMem.ent.entry.length, 0);
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();

    errNo = Typ.OK;
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "rcCardCrewYes() Push");
    await rcCardCrewCautionClear();
    if (await RcFncChk.rcCheckCrdtVoidMode()) {
      cMem.working.crdtReg.companyCd = 0;
      // rcD_Mcd();
    } else {
      if (cMem.working.crdtReg.step == KyCrdtInStep.CARD_KIND.cd) {
        cMem.working.crdtReg.companyCd = 0;
        // rcD_Mcd();
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // #if DEPARTMENT_STORE
        // if ((await RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) && (cMem.stat.departFlg & 0x10)) {
        //   if (!cMem.ent.errNo) {
        //     TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcCardCrewYes() DspEnd\n");
        //     await rcCardCrewCashInPrg();
        //   }
        // }
        // #endif
      } else {
        errNo = await RcFlrd.rcReadCrdttblFL(
            RcCrdt.MANUAL_INPUT, RcCrdt.CARDCREW_OFF);
        if (errNo != Typ.OK) {
          cMem.ent.errNo = errNo;
          await RcExt.rcErr('rcCardCrewYes', cMem.ent.errNo);
        } else {
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          // if ((await RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT) && (cMem.stat.departFlg & 0x10)) {
          //   TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcCardCrewYes() DspEnd\n");
          //   await rcCardCrewCashInPrg();
          // } else {
          // #endif
          if (await RcSysChk.rcChkCrdtDscSystem()) {
            // スプリットの再計算が発生すると、エントリーが編集されてしまうので退避させる
            tmpBuf.setRange(0, cMem.ent.entry.length, cMem.ent.entry);
            RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
            RcCrdtFnc.rcCrdtStlDscSet();
            cMem.ent.entry.fillRange(0, cMem.ent.entry.length, 0);
            cMem.ent.entry.setRange(0, tmpBuf.length, tmpBuf);
          }
          await RckyCrdtIn.rcKyCrdtIn();
          // #if DEPARTMENT_STORE
          // }
          // #endif
        }
      }
    }
    await RcIfEvent.rxChkTimerAdd();
    await RcIfEvent.rcWaitSave();
    if (ifSave.count > 0) {
      ifSave = IfWaitSave();
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Pay_Way
  static void rcCardCrewPayWay() {
    int i;
    AcMem cMem = SystemFunc.readAcMem();
    String buf = "";
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);

    if (RcCrdt.CRCV.err_code[0] != ' ') {
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        if (!(RcCrdt.CRCV.err_code.substring(0, 3) == "S00") &&
            !(RcCrdt.CRCV.err_code.substring(0, 3) == "S02")) {
          return;
        }
      } else {
        if (!(RcCrdt.CRCV.err_code.substring(0, 3) == "S00")) {
          return;
        }
      }
    }
    if (RcCrdt.CRCV.pay_way[0] == ' ') {
      return;
    }
    for (i = 0; i < RcCrdt.CRCV.pay_way.length - 2; i = i + 2) {
      buf = RcCrdt.CRCV.pay_way.substring(i, i + 2);
      if (buf[0] == ' ') {
        break;
      } else if ((buf[0] == '1') && (buf[1] == '0')) {
        cMem.working.refData.crdtTbl.lump = 1; /* 一括         */
      } else if (((buf[0] == '2') && (buf[1] == '1')) ||
          ((buf[0] == '2') && (buf[1] == '3'))) {
        cMem.working.refData.crdtTbl.bonus_lump = 1; /* ボーナス一括 */
      } else if (((buf[0] == '2') && (buf[1] == '2')) ||
          ((buf[0] == '2') && (buf[1] == '4'))) {
        cMem.working.refData.crdtTbl.bonus_twice = 1; /* ボーナス分割 */
      } else if (((buf[0] == '3') && (buf[1] == '1')) ||
          ((buf[0] == '3') && (buf[1] == '2')) ||
          ((buf[0] == '3') && (buf[1] == '3')) ||
          ((buf[0] == '3') && (buf[1] == '4'))) {
        cMem.working.refData.crdtTbl.bonus_use = 1; /* ボーナス併用 */
      } else if ((buf[0] == '6') && (buf[1] == '1')) {
        cMem.working.refData.crdtTbl.divide = 1; /* 分割         */
      } else if ((buf[0] == '8') && (buf[1] == '0')) {
        cMem.working.refData.crdtTbl.ribo = 1; /* リボ         */
      }
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // else if ((buf[0] == '8') && (buf[1] == '9' )) CMEM->working.ref_data.crdttbl.skip = 1;          /* スキップ     */
      // #endif
    }
    // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
    // #if DEPARTMENT_STORE
    // CMEM->working.ref_data.crdttbl.fil2 = 0;     /* カード問い合わせがOKの場合、個別割賦での支払は出来ない */
    // #endif
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_PayTime
  static Future<void> rcCardCrewPayTime() async {
    int i;
    AcMem cMem = SystemFunc.readAcMem();
    String buf = "";
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);

    if (RcCrdt.CRCV.err_code[0] != ' ') {
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        if (!(RcCrdt.CRCV.err_code.substring(0, 3) == "S00") &&
            !(RcCrdt.CRCV.err_code.substring(0, 3) == "S02")) {
          return;
        }
      } else {
        if (!(RcCrdt.CRCV.err_code.substring(0, 3) == "S00")) {
          return;
        }
      }
    }
    if (RcCrdt.CRCV.pay_time[0] == ' ') {
      return;
    }
    for (i = 0; i < (RcCrdt.CRCV.pay_time.length) - 2; i = i + 2) {
      buf = RcCrdt.CRCV.pay_time.substring(i, i + 2);
      if (buf[0] == ' ') {
        break;
      } else if ((buf[0] == '0') && (buf[1] == '2')) {
        if (await RcSysChk.rcChkVegaProcess()) {
          if (cMem.working.refData.crdtTbl.divide == 1) {
            /* VEGA3000接続の場合、支払方法[61:分割]を受信している時のみ2回払可能 */
            cMem.working.refData.crdtTbl.twice = 1; /*   ２回払 */
          }
        } else {
          cMem.working.refData.crdtTbl.twice = 1; /*   ２回払 */
        }
      } else if ((buf[0] == '0') && (buf[1] == '3')) {
        cMem.working.refData.crdtTbl.divide3 = 1; /*   ３回払 */
        cMem.working.refData.crdtTbl.bonus_use3 = 1;
      } else if ((buf[0] == '0') && (buf[1] == '5')) {
        cMem.working.refData.crdtTbl.divide5 = 1; /*   ５回払 */
        cMem.working.refData.crdtTbl.bonus_use5 = 1;
      } else if ((buf[0] == '0') && (buf[1] == '6')) {
        cMem.working.refData.crdtTbl.divide6 = 1; /*   ６回払 */
        cMem.working.refData.crdtTbl.bonus_use6 = 1;
      } else if ((buf[0] == '1') && (buf[1] == '0')) {
        cMem.working.refData.crdtTbl.divide10 = 1; /* １０回払 */
        cMem.working.refData.crdtTbl.bonus_use10 = 1;
      } else if ((buf[0] == '1') && (buf[1] == '2')) {
        cMem.working.refData.crdtTbl.divide12 = 1; /* １２回払 */
        cMem.working.refData.crdtTbl.bonus_use12 = 1;
      } else if ((buf[0] == '1') && (buf[1] == '5')) {
        cMem.working.refData.crdtTbl.divide15 = 1; /* １５回払 */
        cMem.working.refData.crdtTbl.bonus_use15 = 1;
      } else if ((buf[0] == '1') && (buf[1] == '8')) {
        cMem.working.refData.crdtTbl.divide18 = 1; /* １８回払 */
        cMem.working.refData.crdtTbl.bonus_use18 = 1;
      } else if ((buf[0] == '2') && (buf[1] == '0')) {
        cMem.working.refData.crdtTbl.divide20 = 1; /* ２０回払 */
        cMem.working.refData.crdtTbl.bonus_use20 = 1;
      } else if ((buf[0] == '2') && (buf[1] == '4')) {
        cMem.working.refData.crdtTbl.divide24 = 1; /* ２４回払 */
        cMem.working.refData.crdtTbl.bonus_use24 = 1;
      } else if ((buf[0] == '3') && (buf[1] == '0')) {
        cMem.working.refData.crdtTbl.divide30 = 1; /* ３０回払 */
        cMem.working.refData.crdtTbl.bonus_use30 = 1;
      } else if ((buf[0] == '3') && (buf[1] == '6')) {
        cMem.working.refData.crdtTbl.divide36 = 1; /* ３６回払 */
        cMem.working.refData.crdtTbl.bonus_use36 = 1;
      }
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // else if((buf[0] == '0') && (buf[1] == '8')) {
      // /*   ８回払 */
      // CMEM->working.ref_data.crdttbl.divide8     = 1;
      // CMEM->working.ref_data.crdttbl.bonus_use8  = 1;
      // }
      // else if((buf[0] == '0') && (buf[1] == '4')) {
      // CMEM->working.ref_data.crdttbl.divide4     = 1;   /*   ４回払 */
      // CMEM->working.ref_data.crdttbl.bonus_use4  = 1;
      // }
      // else if((buf[0] == '2') && (buf[1] == '5')) {
      // CMEM->working.ref_data.crdttbl.divide25    = 1;   /* ２５回払 */
      // CMEM->working.ref_data.crdttbl.bonus_use25 = 1;
      // }
      // else if((buf[0] == '3') && (buf[1] == '5')) {
      // CMEM->working.ref_data.crdttbl.divide35    = 1;   /* ３５回払 */
      // CMEM->working.ref_data.crdttbl.bonus_use35 = 1;
      // }
      // #endif
    }
    if (cMem.working.refData.crdtTbl.divide == 1) {
      if ((cMem.working.refData.crdtTbl.divide3 == 0) && /*   ３回払 */
          (cMem.working.refData.crdtTbl.divide5 == 0) && /*   ５回払 */
          (cMem.working.refData.crdtTbl.divide6 == 0) && /*   ６回払 */
          (cMem.working.refData.crdtTbl.divide10 == 0) && /* １０回払 */
          (cMem.working.refData.crdtTbl.divide12 == 0) && /* １２回払 */
          (cMem.working.refData.crdtTbl.divide15 == 0) && /* １５回払 */
          (cMem.working.refData.crdtTbl.divide18 == 0) && /* １８回払 */
          (cMem.working.refData.crdtTbl.divide20 == 0) && /* ２０回払 */
          (cMem.working.refData.crdtTbl.divide24 == 0) && /* ２４回払 */
          (cMem.working.refData.crdtTbl.divide30 == 0) && /* ３０回払 */
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          // (CMEM->working.ref_data.crdttbl.divide8  == 0) &&     /*   ８回払 */
          // (CMEM->working.ref_data.crdttbl.divide4  == 0) &&     /*   ４回払 */
          // (CMEM->working.ref_data.crdttbl.divide25 == 0) &&     /* ２５回払 */
          // (CMEM->working.ref_data.crdttbl.divide35 == 0) &&     /* ３５回払 */
          // #endif
          (cMem.working.refData.crdtTbl.divide36 == 0)) /* ３６回払 */ {
        cMem.working.refData.crdtTbl.divide = 0;
        /* ３回払以上の分割回数が設定されていない場合、分割払のボタンを表示しない */
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Bonus_Term
  static void rcCardCrewBonusTerm() {
    String buf1 = "";
    String buf2 = "";
    String tmp = "";
    String month = "";
    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);

    if (RcCrdt.CRCV.err_code[0] != ' ') {
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        if (!(RcCrdt.CRCV.err_code.substring(0, 3) == "S00") &&
            !(RcCrdt.CRCV.err_code.substring(0, 3) == "S02")) {
          return;
        }
      } else {
        if (!(RcCrdt.CRCV.err_code.substring(0, 3) == "S00")) {
          return;
        }
      }
    }
    if (RcCrdt.CRCV.bonus_term[0] == ' ') {
      return;
    }
    buf1 = RcCrdt.CRCV.bonus_term;

    tmp = buf1.substring(0, 2);
    month = tmp;
    tmp = buf1.substring(2, 4);
    buf2 = month;
    buf2 += tmp;
    cMem.working.refData.crdtTbl.summer_bonus_from = int.parse(buf2);

    tmp = buf1.substring(4, 6);
    month = tmp;
    tmp = buf1.substring(6, 8);
    buf2 = month;
    buf2 += tmp;
    cMem.working.refData.crdtTbl.summer_bonus_to = int.parse(buf2);

    tmp = buf1.substring(8, 10);
    month = tmp;
    tmp = buf1.substring(10, 12);
    buf2 = month;
    buf2 += tmp;
    cMem.working.refData.crdtTbl.winter_bonus_from = int.parse(buf2);

    tmp = buf1.substring(12, 14);
    month = tmp;
    tmp = buf1.substring(14, 16);
    buf2 = month;
    buf2 += tmp;
    cMem.working.refData.crdtTbl.winter_bonus_to = int.parse(buf2);
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_BonusMonth
  static Future<void> rcCardCrewBonusMonth() async {
    int i;
    String buf1 = "";
    String buf2 = "";
    int month;
    String month_tmp = "";
    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.CRCV =
        RcCrdt.getCardCrewRcvCard(cMem.working.crdtReg.crdtRcv.data);

    if (RcCrdt.CRCV.err_code[0] != ' ') {
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        if ((RcCrdt.CRCV.err_code.substring(0, 3) != "S00") &&
            (RcCrdt.CRCV.err_code.substring(0, 3) != "S02")) {
          return;
        }
      } else {
        if (RcCrdt.CRCV.err_code.substring(0, 3) != "S00") {
          return;
        }
      }
    }
    if (RcCrdt.CRCV.bonus_month[0] == ' ') {
      return;
    }
    cMem.working.refData.crdtTbl.pay_input_chk = 1; /* 支払月入力をさせる為 */
    buf1 = RcCrdt.CRCV.bonus_month.substring(0, 20);
    if (await RcSysChk.rcChkVegaProcess()) {
      for (i = 0; i < 6; i++) {
        month = 0;
        month_tmp = buf1.substring(i * 2, (i * 2) + 2);
        if (month_tmp[0] == ' ') {
          continue;
        }
        month = int.parse(month_tmp);
        switch (i) {
          case 0:
            cMem.working.refData.crdtTbl.summer_bonus_pay1 = month;
            break;
          case 1:
            cMem.working.refData.crdtTbl.summer_bonus_pay2 = month;
            break;
          case 2:
            cMem.working.refData.crdtTbl.summer_bonus_pay3 = month;
            break;
          case 3:
            cMem.working.refData.crdtTbl.winter_bonus_pay1 = month;
            break;
          case 4:
            cMem.working.refData.crdtTbl.winter_bonus_pay2 = month;
            break;
          case 5:
            cMem.working.refData.crdtTbl.winter_bonus_pay3 = month;
            break;
          default:
            break;
        }
      }
    } else {
      for (i = 0; i < buf1.length; i = i + 2) {
        buf2 = buf1.substring(i, i + 2);
        if (buf2[0] == ' ') {
          break;
        } else if ((buf2[0] == '0') && (buf2[1] == '6')) {
          cMem.working.refData.crdtTbl.summer_bonus_pay1 = 6;
        } else if ((buf2[0] == '0') && (buf2[1] == '7')) {
          cMem.working.refData.crdtTbl.summer_bonus_pay2 = 7;
        } else if ((buf2[0] == '0') && (buf2[1] == '8')) {
          cMem.working.refData.crdtTbl.summer_bonus_pay3 = 8;
        } else if ((buf2[0] == '0') && (buf2[1] == '9')) {
          /* 今治専門店会カード対応 */
          if (cMem.working.refData.crdtTbl.summer_bonus_pay2 != 0) {
            cMem.working.refData.crdtTbl.summer_bonus_pay1 =
                cMem.working.refData.crdtTbl.summer_bonus_pay2;
          }
          if (cMem.working.refData.crdtTbl.summer_bonus_pay3 != 0) {
            cMem.working.refData.crdtTbl.summer_bonus_pay2 =
                cMem.working.refData.crdtTbl.summer_bonus_pay3;
          }
          cMem.working.refData.crdtTbl.summer_bonus_pay3 = 9;
        } else if ((buf2[0] == '1') && (buf2[1] == '2')) {
          cMem.working.refData.crdtTbl.winter_bonus_pay1 = 12;
        } else if ((buf2[0] == '0') && (buf2[1] == '1')) {
          cMem.working.refData.crdtTbl.winter_bonus_pay2 = 1;
        } else if ((buf2[0] == '0') && (buf2[1] == '2')) {
          cMem.working.refData.crdtTbl.winter_bonus_pay3 = 2;
        }
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // #if DEPARTMENT_STORE
        // else if((buf2[0] == '0') && (buf2[1] == '3')) {           /* 棒二森屋共済会カード対応 */
        // if(CMEM->stat.Depart_Flg & 0x01)                       /* 自社クレジット宣言中？   */
        // {
        // if((CMEM->working.ref_data.crdttbl.winter_bonus_pay2 == 0) && (CMEM->working.ref_data.crdttbl.winter_bonus_pay3 == 0))
        // CMEM->working.ref_data.crdttbl.winter_bonus_pay2 = 3;
        // else if(CMEM->working.ref_data.crdttbl.winter_bonus_pay3 == 0)
        // CMEM->working.ref_data.crdttbl.winter_bonus_pay3 = 3;
        // }
        // }
        // #endif
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_MakeDay
  static Future<void> rcCardCrewMakeDay() async {
    String buf = '';
    String yymmdd = ''; // char yymmdd[6+1];
    int tmYear, tmMon, tmDay;
    String saleDate = ''; // char sale_date[RX_COUNTER_DATE_SIZE+1];'
    AcMem cMem = SystemFunc.readAcMem();

    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
    RcCrdt.cReqVEGA.reqCom =
        RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
    RcCrdt.cReqVEGA.reqAdd =
        RcCrdt.getCardCrewReqAdd(cMem.working.crdtReg.crdtReq.data);

    cMem.date = SysDate().cmReadSysdate(); // cm_read_sysdate(&CMEM->date);
    tmYear = cMem.date!.year; // YY
    tmMon = cMem.date!.month; // MM
    tmDay = cMem.date!.day; // DD
    buf = tmYear.toString().padLeft(4, '0');
    yymmdd = buf.substring(2, 4);

    buf = '';
    buf = tmMon.toString().padLeft(2, '0');
    yymmdd += buf;

    buf = '';
    buf = tmDay.toString().padLeft(2, '0');
    yymmdd += buf;
    RcCrdt.cReq.saleDate = yymmdd; // 売上日付

    if (await RcSysChk.rcChkVegaProcess()) {
      // vega3000接続
      // 取引日を取得
      CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
          await RcSysChk.getTid(),
          CompetitionIniLists.COMPETITION_INI_SALE_DATE,
          CompetitionIniType.COMPETITION_INI_GETMEM);
      saleDate = ret.value;
      RcCrdt.cReqVEGA.reqAdd.businessDate = saleDate.substring(2, 4) +
          saleDate.substring(5, 7) +
          saleDate.substring(8, 10);
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Set_Itemcd
  static Future<void> rcCardCrewSetItemcd() async {
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCardCrewSetItemcd() rxMemRead error\n");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
    RcCrdt.cReq.itemCode = ''.padRight(7, ' '); // 商品コード
    if (cBuf.dbTrm.itemCode != 0) {
      RcCrdt.cReq.itemCode = "${cBuf.dbTrm.itemCode}".padLeft(7, ' ');
    }
  }

  /// 松源、エーコープ関東、サッポロドラッグは CardCrewPlus
  /// 関連tprxソース: rccardcrew.c - rcChk_CardCrewPlus
  static Future<bool> rcChkCardCrewPlus() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcChkCardCrewPlus() rxMemRead error\n");
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if ((CmCksys.cmMatugenSystem() != 0) ||
        (cBuf.dbTrm.acoopCreditFunc != 0) ||
        (cBuf.dbTrm.chgBusinessCode != 0) ||
        (RcSysChk.rcChkCrdtUser() == Datas.SAPDRA_CRDT)) {
      return true;
    } else {
      return false;
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_ChkErr_G30
  static bool rcCardCrewChkErrG30() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.working.crdtReg.stat & 0x0010) != 0); /* 承認番号入力？ */
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Set_Reg_No
  static Future<void> rcCardCrewSetRegNo() async {
    String buf = ''.padRight(7, ' '); // char buf[6+1];
    String macNo = ''.padRight(11, ' '); // char mac_no[10+1];

    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);

    if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
      buf =
          "${(await CompetitionIni.competitionIniGetMacNo(await RcSysChk.getTid())).value}"
              .padLeft(6, '0');
      macNo = buf.substring(2, 6) + ' ' * 6;
      RcCrdt.cReq.memo1 = macNo; // メモ１
    } else {
      RcCrdt.cReq.memo1 = ' ' * 10; // メモ１
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Chk_Bonus_Month
  static bool rcCardCrewChkBonusMonth() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0 ||
        cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0 ||
        cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0 ||
        cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0 ||
        cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0 ||
        cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
      return true;
    } else {
      return false;
    }
  }

  // TODO:00012 平野 クレジット宣言：動作確認まだ
  /// 関連tprxソース: rccardcrew.c - rcCardCrew_Pay_Detail
  static Future<void> rcCardCrewPayDetail() async {
    String buf = ''.padRight(3, ' '); // char  buf[3];
    String tmp = ''.padRight(6, ' '); // char  tmp[6];
    int rpno; // long  rpno;
    int kind = 0; // long  kind = 0;

    AcMem cMem = SystemFunc.readAcMem();
    RcCrdt.cReq = RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
    RcCrdt.cReqVEGA.reqCom =
        RcCrdt.getCardCrewReqCom(cMem.working.crdtReg.crdtReq.data);
    RcCrdt.cReqVEGA.reqAdd =
        RcCrdt.getCardCrewReqAdd(cMem.working.crdtReg.crdtReq.data);

    RcCrdt.cReq.payKind = ''.padRight(2, ' '); /* 支払区分 */
    RcCrdt.cReq.payDetail = ''.padRight(84, ' '); /* 支払内容明細 */
    if (await RcCrdtFnc.rcCheckCrdtVoidInquProc()) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
// #if DEPARTMENT_STORE
//       if(CMEM->working.crdt_reg.pay_div == 89)     /* スキップ払いは一括払いとして処理する */
//          CMEM->working.crdt_reg.pay_div = 10;
// #endif
      buf = "${cMem.working.crdtReg.payDiv}";
      RcCrdt.cReq.payKind = "${cMem.working.crdtReg.payDiv}";
      RcCrdt.cReq.payDetail =
          RegsMem().tCrdtLog[0].t400000.posReceiptNo.toString().padLeft(5, '0');
      if ((cMem.working.crdtReg.stat & 0x0080) != 0) {
        /* 当日分解約？ */
        RcCrdt.cReq.payDetail =
            '${RcCrdt.cReq.payDetail.substring(0, 5)}11$buf@';
      } else {
        RcCrdt.cReq.payDetail =
            '${RcCrdt.cReq.payDetail.substring(0, 5)}21$buf@';
      }
      if (await RcSysChk.rcChkVegaProcess()) {
        RcCrdt.cReqVEGA.reqAdd.crdtvoidFlg = '1';
        // 元取引の支払明細をセットする
        // sizeof(MEM->crdtlog.pay_a_way)の方が小さいため、MEM->crdtlog.pay_a_wayのサイズ分
        RcCrdt.cReqVEGA.reqAdd.voidDetail = ''.padRight(84, ' ');
        RcCrdt.cReqVEGA.reqAdd.voidDetail =
            RegsMem().tCrdtLog[0].t400000.payAWay;

        // ボーナス分割回数のセット
        if (cMem.working.crdtReg.payDiv == 33 ||
            cMem.working.crdtReg.payDiv == 34) {
          RcCrdt.cReqVEGA.reqAdd.buseBcnt =
              RcCrdt.cReqVEGA.reqAdd.voidDetail[10];
        }
      }
      return;
    }
/************************************************************************************************/
    if (cMem.working.crdtReg.crdtTbl.lump == 1) {
      kind = 10; // 一括払い選択
      RcCrdt.cReq.payKind = "$kind";
      RcCrdt.cReq.payDetail = '10@';
      cMem.working.crdtReg.diviCnt = 1;
    }
/************************************************************************************************/
    else if (cMem.working.crdtReg.crdtTbl.twice == 1) {
      kind = 61; // 二回払い選択
      RcCrdt.cReq.payKind = "$kind";
      RcCrdt.cReq.payDetail = '61A00C02@';
      cMem.working.crdtReg.diviCnt = 2;
    }
/************************************************************************************************/
    else if (cMem.working.crdtReg.crdtTbl.divide == 1) {
      kind = 61; // 分割払い選択
      RcCrdt.cReq.payKind = "$kind";
      RcCrdt.cReq.payDetail = '61A00C';
      if (cMem.working.crdtReg.crdtTbl.divide3 == 1) {
        RcCrdt.cReq.payDetail += '03';
        cMem.working.crdtReg.diviCnt = 3;
      } else if (cMem.working.crdtReg.crdtTbl.divide5 == 1) {
        RcCrdt.cReq.payDetail += '05';
        cMem.working.crdtReg.diviCnt = 5;
      } else if (cMem.working.crdtReg.crdtTbl.divide6 == 1) {
        RcCrdt.cReq.payDetail += '06';
        cMem.working.crdtReg.diviCnt = 6;
      } else if (cMem.working.crdtReg.crdtTbl.divide10 == 1) {
        RcCrdt.cReq.payDetail += '10';
        cMem.working.crdtReg.diviCnt = 10;
      } else if (cMem.working.crdtReg.crdtTbl.divide12 == 1) {
        RcCrdt.cReq.payDetail += '12';
        cMem.working.crdtReg.diviCnt = 12;
      } else if (cMem.working.crdtReg.crdtTbl.divide15 == 1) {
        RcCrdt.cReq.payDetail += '15';
        cMem.working.crdtReg.diviCnt = 15;
      } else if (cMem.working.crdtReg.crdtTbl.divide18 == 1) {
        RcCrdt.cReq.payDetail += '18';
        cMem.working.crdtReg.diviCnt = 18;
      } else if (cMem.working.crdtReg.crdtTbl.divide20 == 1) {
        RcCrdt.cReq.payDetail += '20';
        cMem.working.crdtReg.diviCnt = 20;
      } else if (cMem.working.crdtReg.crdtTbl.divide24 == 1) {
        RcCrdt.cReq.payDetail += '24';
        cMem.working.crdtReg.diviCnt = 24;
      } else if (cMem.working.crdtReg.crdtTbl.divide30 == 1) {
        RcCrdt.cReq.payDetail += '30';
        cMem.working.crdtReg.diviCnt = 30;
      } else if (cMem.working.crdtReg.crdtTbl.divide36 == 1) {
        RcCrdt.cReq.payDetail += '36';
        cMem.working.crdtReg.diviCnt = 36;
      }
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // else if (cMem.working.crdtReg.crdtTbl.divide8 == 1) {
      //   RcCrdt.cReq.payDetail += '08';
      //   cMem.working.crdtReg.diviCnt = 8;
      // } else if (cMem.working.crdtReg.crdtTbl.divide4 == 1) {
      //   RcCrdt.cReq.payDetail += '04';
      //   cMem.working.crdtReg.diviCnt = 4;
      // } else if (cMem.working.crdtReg.crdtTbl.divide25 == 1) {
      //   RcCrdt.cReq.payDetail += '25';
      //   cMem.working.crdtReg.diviCnt = 25;
      // } else if (cMem.working.crdtReg.crdtTbl.divide35 == 1) {
      //   RcCrdt.cReq.payDetail += '35';
      //   cMem.working.crdtReg.diviCnt = 35;
      // }
      // #endif
      RcCrdt.cReq.payDetail += '@';
/************************************************************************************************/
    } else if (cMem.working.crdtReg.crdtTbl.bonus_lump == 1) {
      if (rcCardCrewChkBonusMonth() && RcCrdtFnc.rcSpecBonusMthInput()) {
        buf = ''.padRight(3, ' ');
        kind = 23; // ボーナス一括月指定払い選択
        RcCrdt.cReq.payKind = "$kind";
        RcCrdt.cReq.payDetail = '23F';
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
          buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
              .padLeft(2, '0');
          RcCrdt.cReq.payDetail += buf;
          cMem.working.crdtReg.bonsMm1 =
              cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
        } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
          buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
              .padLeft(2, '0');
          RcCrdt.cReq.payDetail += buf;
          cMem.working.crdtReg.bonsMm1 =
              cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
        } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
          buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
              .padLeft(2, '0');
          RcCrdt.cReq.payDetail += buf;
          cMem.working.crdtReg.bonsMm1 =
              cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
        } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
          buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
              .padLeft(2, '0');
          RcCrdt.cReq.payDetail += buf;
          cMem.working.crdtReg.bonsMm1 =
              cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
        } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
          buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
              .padLeft(2, '0');
          RcCrdt.cReq.payDetail += buf;
          cMem.working.crdtReg.bonsMm1 =
              cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
        } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
          buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
              .padLeft(2, '0');
          RcCrdt.cReq.payDetail += buf;
          cMem.working.crdtReg.bonsMm1 =
              cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
        }
        RcCrdt.cReq.payDetail += '@';
        cMem.working.crdtReg.diviCnt = 1;
/************************************************************************************************/
      } else {
        kind = 21; // ボーナス一括払い選択
        RcCrdt.cReq.payKind = "$kind";
        RcCrdt.cReq.payDetail = '21@';
        cMem.working.crdtReg.diviCnt = 1;
      }
/************************************************************************************************/
    } else if (cMem.working.crdtReg.crdtTbl.bonus_twice == 1) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
//       #if DEPARTMENT_STORE
//       if((rcCardCrew_Chk_Bonus2_Month()) && ((rcSpec_Bonus_Mth_Input()) || (rcChk_Unique_Pay()))) {
//       #else
      if (rcCardCrewChkBonus2Month() && RcCrdtFnc.rcSpecBonusMthInput()) {
        // #endif
        buf = ''.padRight(3, ' ');
        kind = 24; // ボーナス二回月指定払い選択
        RcCrdt.cReq.payKind = "$kind";
        RcCrdt.cReq.payDetail = '24E02F';
        cMem.working.crdtReg.diviCnt = 2;
/************************************************************************************************/
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
//     #if DEPARTMENT_STORE
// /* 中合では夏冬両方のボーナス支払月が選択可能な期間がある為 */
//     if(rcChk_All_Season() == OK) {
//     if(CMEM->working.crdt_reg.b_season) { /* Summer Season */
//     if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[6], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[6], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[6], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3;
//     }
//     CREQ->pay_detail[8] = 'F';
//     if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[9], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[9], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[9], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3;
//     }
//     CREQ->pay_detail[11] = '@';
//     }
//     else {
//     if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[6], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[6], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[6], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3;
//     }
//     CREQ->pay_detail[8] = 'F';
//     if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[9], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[9], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[9], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3;
//     }
//     CREQ->pay_detail[11] = '@';
//     }

//     if(rcChk_Crdt_Cancel()) { /* 訂正モード？ */
//     memset(CREQ->pay_detail, ' ', sizeof(CREQ->pay_detail)); /* 支払内容明細リセット */
//     memset(buf, 0x0, sizeof(buf));
//     sprintf(buf, "%ld", kind);
//     rpno = cm_bcdtol(CMEM->working.crdt_reg.rpno, sizeof(CMEM->working.crdt_reg.rpno));
//     sprintf(CREQ->pay_detail, "%05ld", rpno);
//     if(CMEM->working.crdt_reg.stat & 0x0080) { /* 当日分解約？ */
//     CREQ->pay_detail[5] = '1';
//     CREQ->pay_detail[6] = '1';
//     cm_mov(&CREQ->pay_detail[7], buf, sizeof(buf));
//     CREQ->pay_detail[9] = '@';
//     }
//     else {
//     CREQ->pay_detail[5] = '2';
//     CREQ->pay_detail[6] = '1';
//     cm_mov(&CREQ->pay_detail[7], buf, sizeof(buf));
//     CREQ->pay_detail[9] = '@';
//     }
//     }
//     return;
//     }
//     #endif
/************************************************************************************************/
        if (await RcCrdtFnc.rcChkPaySeason()) {
          if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm1 =
                cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
          } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm1 =
                cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
          } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm1 =
                cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
          }
          RcCrdt.cReq.payDetail += 'F';
          if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm2 =
                cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
          } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm2 =
                cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
          } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm2 =
                cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
          }
          RcCrdt.cReq.payDetail += '@';
        } else {
          if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm1 =
                cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
          } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm1 =
                cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
          } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm1 =
                cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
          }
          RcCrdt.cReq.payDetail += 'F';
          if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm2 =
                cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
          } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm2 =
                cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
          } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
            buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                .padLeft(2, '0');
            RcCrdt.cReq.payDetail += buf;
            cMem.working.crdtReg.bonsMm2 =
                cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
          }
          RcCrdt.cReq.payDetail = '${RcCrdt.cReq.payDetail.substring(0, 11)}@';
        }
/************************************************************************************************/
      } else {
        kind = 22; // ボーナス二回払い選択
        RcCrdt.cReq.payKind = "$kind";
        RcCrdt.cReq.payDetail = '22E02@';
        cMem.working.crdtReg.diviCnt = 2;
      }
/************************************************************************************************/
    } else if (cMem.working.crdtReg.crdtTbl.bonus_use == 1) {
      if (rcCardCrewChkBonusMonth() && RcCrdtFnc.rcSpecBonusMthInput()) {
        if (RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT ||
            ((RcSysChk.rcChkCrdtUser() == Datas.NORMAL_CRDT)) &&
                (await CmCksys.cmRainbowCardSystem() != 0)) {
          buf = "";
          kind = 34; // ボーナス併用ボーナス月指定払い選択
          RcCrdt.cReq.payKind = "$kind";
          RcCrdt.cReq.payDetail = '34A00C';
          if (cMem.working.crdtReg.crdtTbl.bonus_use3 == 1) {
            RcCrdt.cReq.payDetail += '03';
            cMem.working.crdtReg.diviCnt = 3;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use5 == 1) {
            RcCrdt.cReq.payDetail += '05';
            cMem.working.crdtReg.diviCnt = 5;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use6 == 1) {
            RcCrdt.cReq.payDetail += '06';
            cMem.working.crdtReg.diviCnt = 6;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use10 == 1) {
            RcCrdt.cReq.payDetail += '10';
            cMem.working.crdtReg.diviCnt = 10;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use12 == 1) {
            RcCrdt.cReq.payDetail += '12';
            cMem.working.crdtReg.diviCnt = 12;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use15 == 1) {
            RcCrdt.cReq.payDetail += '15';
            cMem.working.crdtReg.diviCnt = 15;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use18 == 1) {
            RcCrdt.cReq.payDetail += '18';
            cMem.working.crdtReg.diviCnt = 18;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use20 == 1) {
            RcCrdt.cReq.payDetail += '20';
            cMem.working.crdtReg.diviCnt = 20;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use24 == 1) {
            RcCrdt.cReq.payDetail += '24';
            cMem.working.crdtReg.diviCnt = 24;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use30 == 1) {
            RcCrdt.cReq.payDetail += '30';
            cMem.working.crdtReg.diviCnt = 30;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use36 == 1) {
            RcCrdt.cReq.payDetail += '36';
            cMem.working.crdtReg.diviCnt = 36;
          }
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use8 == 1) {
          // CREQ->pay_detail[6] = '0';
          // CREQ->pay_detail[7] = '8';
          // CMEM->working.crdt_reg.divi_cnt = 8;
          // }
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use4 == 1) {
          // CREQ->pay_detail[6] = '0';
          // CREQ->pay_detail[7] = '4';
          // CMEM->working.crdt_reg.divi_cnt = 4;
          // }
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use25 == 1) {
          // CREQ->pay_detail[6] = '2';
          // CREQ->pay_detail[7] = '5';
          // CMEM->working.crdt_reg.divi_cnt = 25;
          // }
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use35 == 1) {
          // CREQ->pay_detail[6] = '3';
          // CREQ->pay_detail[7] = '5';
          // CMEM->working.crdt_reg.divi_cnt = 35;
          // }
          // #endif

          RcCrdt.cReq.payDetail += 'E0';
          buf = "${cMem.working.crdtReg.buseBcnt}";
          RcCrdt.cReq.payDetail += buf.padLeft(1, '0');
          RcCrdt.cReq.payDetail += 'F';
          buf = "";

          if (await RcSysChk.rcChkVegaProcess()) {
            /* vega接続 */
            RcCrdt.cReqVEGA.reqAdd.buseBcnt =
                '0${cMem.working.crdtReg.buseBcnt}';
          }

/************************************************************************************************/
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
//     #if DEPARTMENT_STORE
// /* 中合では夏冬両方のボーナス支払月が選択可能な期間がある為 */
//     if((rcChk_All_Season() == OK) && (CMEM->working.crdt_reg.buse_bcnt != 1)) {
//     if(CMEM->working.crdt_reg.b_season) { /* Summer Season */
//     if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1) { /* 夏→冬 */
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3;
//     }
//     CREQ->pay_detail[14] = 'G';
//     CREQ->pay_detail[15] = '0';
//     CREQ->pay_detail[16] = '0';
//     CREQ->pay_detail[17] = '0';
//     CREQ->pay_detail[18] = '0';
//     CREQ->pay_detail[19] = '0';
//     CREQ->pay_detail[20] = '0';
//     CREQ->pay_detail[21] = '0';
//     CREQ->pay_detail[22] = '0';
//     CREQ->pay_detail[23] = 'F';
//     memset(buf, 0x0, sizeof(buf));
//     if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3;
//     }
//     CREQ->pay_detail[26] = 'G';
//     CREQ->pay_detail[27] = '0';
//     CREQ->pay_detail[28] = '0';
//     CREQ->pay_detail[29] = '0';
//     CREQ->pay_detail[30] = '0';
//     CREQ->pay_detail[31] = '0';
//     CREQ->pay_detail[32] = '0';
//     CREQ->pay_detail[33] = '0';
//     CREQ->pay_detail[34] = '0';
//     CREQ->pay_detail[35] = '@';
//     }
//     else {
//     if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1) { /* 冬→夏 */
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3;
//     }
//     CREQ->pay_detail[14] = 'G';
//     CREQ->pay_detail[15] = '0';
//     CREQ->pay_detail[16] = '0';
//     CREQ->pay_detail[17] = '0';
//     CREQ->pay_detail[18] = '0';
//     CREQ->pay_detail[19] = '0';
//     CREQ->pay_detail[20] = '0';
//     CREQ->pay_detail[21] = '0';
//     CREQ->pay_detail[22] = '0';
//     CREQ->pay_detail[23] = 'F';
//     memset(buf, 0x0, sizeof(buf));
//     if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3;
//     }
//     CREQ->pay_detail[26] = 'G';
//     CREQ->pay_detail[27] = '0';
//     CREQ->pay_detail[28] = '0';
//     CREQ->pay_detail[29] = '0';
//     CREQ->pay_detail[30] = '0';
//     CREQ->pay_detail[31] = '0';
//     CREQ->pay_detail[32] = '0';
//     CREQ->pay_detail[33] = '0';
//     CREQ->pay_detail[34] = '0';
//     CREQ->pay_detail[35] = '@';
//     }

//     if(rcChk_Crdt_Cancel()) { /* 訂正モード？ */
//     memset(CREQ->pay_detail, ' ', sizeof(CREQ->pay_detail)); /* 支払内容明細リセット */
//     memset(buf, 0x0, sizeof(buf));
//     sprintf(buf, "%ld", kind);
//     rpno = cm_bcdtol(CMEM->working.crdt_reg.rpno, sizeof(CMEM->working.crdt_reg.rpno));
//     sprintf(CREQ->pay_detail, "%05ld", rpno);
//     if(CMEM->working.crdt_reg.stat & 0x0080) { /* 当日分解約？ */
//     CREQ->pay_detail[5] = '1';
//     CREQ->pay_detail[6] = '1';
//     cm_mov(&CREQ->pay_detail[7], buf, sizeof(buf));
//     CREQ->pay_detail[9] = '@';
//     }
//     else {
//     CREQ->pay_detail[5] = '2';
//     CREQ->pay_detail[6] = '1';
//     cm_mov(&CREQ->pay_detail[7], buf, sizeof(buf));
//     CREQ->pay_detail[9] = '@';
//     }
//     }
//     return;
//     }
//     #endif
/************************************************************************************************/

          if (await RcCrdtFnc.rcChkPaySeason()) {
            if (cMem.working.crdtReg.buseBcnt == 1) {
              /* ボーナス併用ボーナス回数１回 */
              if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += 'G00000000@';
            } else {
              if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                /* 冬→夏 */
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += 'G00000000F';
              buf = "";
              if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += 'G00000000@';
            }
          } else {
            if (cMem.working.crdtReg.buseBcnt == 1) {
              /* ボーナス併用ボーナス回数１回 */
              if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += 'G00000000@';
            } else {
              if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                /* 夏→冬 */
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += 'G00000000F';
              buf = "";
              if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += 'G00000000@';
            }
          }
        }
/************************************************************************************************/
        else {
          buf = "";
          kind = 33; // ボーナス併用ボーナス月指定払い選択
          RcCrdt.cReq.payKind = "$kind";
          RcCrdt.cReq.payDetail = "33A00C";
          if (cMem.working.crdtReg.crdtTbl.bonus_use3 == 1) {
            RcCrdt.cReq.payDetail += "03";
            cMem.working.crdtReg.diviCnt = 3;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use5 == 1) {
            RcCrdt.cReq.payDetail += "05";
            cMem.working.crdtReg.diviCnt = 5;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use6 == 1) {
            RcCrdt.cReq.payDetail += "06";
            cMem.working.crdtReg.diviCnt = 6;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use10 == 1) {
            RcCrdt.cReq.payDetail += "10";
            cMem.working.crdtReg.diviCnt = 10;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use12 == 1) {
            RcCrdt.cReq.payDetail += "12";
            cMem.working.crdtReg.diviCnt = 12;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use15 == 1) {
            RcCrdt.cReq.payDetail += "15";
            cMem.working.crdtReg.diviCnt = 15;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use18 == 1) {
            RcCrdt.cReq.payDetail += "18";
            cMem.working.crdtReg.diviCnt = 18;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use20 == 1) {
            RcCrdt.cReq.payDetail += "20";
            cMem.working.crdtReg.diviCnt = 20;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use24 == 1) {
            RcCrdt.cReq.payDetail += "24";
            cMem.working.crdtReg.diviCnt = 24;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use30 == 1) {
            RcCrdt.cReq.payDetail += "30";
            cMem.working.crdtReg.diviCnt = 30;
          } else if (cMem.working.crdtReg.crdtTbl.bonus_use36 == 1) {
            RcCrdt.cReq.payDetail += "36";
            cMem.working.crdtReg.diviCnt = 36;
          }
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use8 == 1) {
          // CREQ->pay_detail[6] = '0';
          // CREQ->pay_detail[7] = '8';
          // CMEM->working.crdt_reg.divi_cnt = 8;
          // }
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use4 == 1) {
          // CREQ->pay_detail[6] = '0';
          // CREQ->pay_detail[7] = '4';
          // CMEM->working.crdt_reg.divi_cnt = 4;
          // }
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use25 == 1) {
          // CREQ->pay_detail[6] = '2';
          // CREQ->pay_detail[7] = '5';
          // CMEM->working.crdt_reg.divi_cnt = 25;
          // }
          // else if(CMEM->working.crdt_reg.crdttbl.bonus_use35 == 1) {
          // CREQ->pay_detail[6] = '3';
          // CREQ->pay_detail[7] = '5';
          // CMEM->working.crdt_reg.divi_cnt = 35;
          // }
          // #endif

          RcCrdt.cReq.payDetail += "E0";
          buf = "${cMem.working.crdtReg.buseBcnt}";
          RcCrdt.cReq.payDetail += buf;
          RcCrdt.cReq.payDetail += "F";
          buf = "";

          if (await RcSysChk.rcChkVegaProcess()) {
            /* vega接続 */
            RcCrdt.cReqVEGA.reqAdd.buseBcnt =
                "0${cMem.working.crdtReg.buseBcnt}";
          }

/************************************************************************************************/
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
//     #if DEPARTMENT_STORE
// /* 中合では夏冬両方のボーナス支払月が選択可能な期間がある為 */
//     if((rcChk_All_Season() == OK) && (CMEM->working.crdt_reg.buse_bcnt != 1)) {
//     if(CMEM->working.crdt_reg.b_season) { /* Summer Season */
//     if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1) { /* 夏→冬 */
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3;
//     }
//     CREQ->pay_detail[14] = 'F';
//     memset(buf, 0x0, sizeof(buf));
//     if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[15], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[15], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[15], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3;
//     }
//     if(CMEM->working.crdt_reg.buse_bcnt == 2)
//     CREQ->pay_detail[17] = '@';
//     else {
//     memset(tmp, 0x0, sizeof(tmp));
//     cm_mov((char *)tmp, (char *)&CREQ->pay_detail[12], 5);
//     CREQ->pay_detail[17] = 'F';
//     if(CMEM->working.crdt_reg.buse_bcnt == 3) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 2);
//     CREQ->pay_detail[20] = '@';
//     }
//     else if(CMEM->working.crdt_reg.buse_bcnt == 4) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 5);
//     CREQ->pay_detail[23] = '@';
//     }
//     else if(CMEM->working.crdt_reg.buse_bcnt == 5) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 5);
//     CREQ->pay_detail[23] = 'F';
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)tmp, 2);
//     CREQ->pay_detail[26] = '@';
//     }
//     else if(CMEM->working.crdt_reg.buse_bcnt == 6) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 5);
//     CREQ->pay_detail[23] = 'F';
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)tmp, 5);
//     CREQ->pay_detail[29] = '@';
//     }
//     }
//     }
//     else {
//     if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1) { /* 冬→夏 */
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[12], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm1 = CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3;
//     }
//     CREQ->pay_detail[14] = 'F';
//     memset(buf, 0x0, sizeof(buf));
//     if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1);
//     cm_mov((char *)&CREQ->pay_detail[15], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2);
//     cm_mov((char *)&CREQ->pay_detail[15], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2;
//     }
//     else if(CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3) {
//     sprintf(buf, "%02ld", CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3);
//     cm_mov((char *)&CREQ->pay_detail[15], (char *)buf, 2);
//     CMEM->working.crdt_reg.bons_mm2 = CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3;
//     }
//     if(CMEM->working.crdt_reg.buse_bcnt == 2)
//     CREQ->pay_detail[17] = '@';
//     else {
//     memset(tmp, 0x0, sizeof(tmp));
//     cm_mov((char *)tmp, (char *)&CREQ->pay_detail[12], 5);
//     CREQ->pay_detail[17] = 'F';
//     if(CMEM->working.crdt_reg.buse_bcnt == 3) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 2);
//     CREQ->pay_detail[20] = '@';
//     }
//     else if(CMEM->working.crdt_reg.buse_bcnt == 4) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 5);
//     CREQ->pay_detail[23] = '@';
//     }
//     else if(CMEM->working.crdt_reg.buse_bcnt == 5) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 5);
//     CREQ->pay_detail[23] = 'F';
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)tmp, 2);
//     CREQ->pay_detail[26] = '@';
//     }
//     else if(CMEM->working.crdt_reg.buse_bcnt == 6) {
//     cm_mov((char *)&CREQ->pay_detail[18], (char *)tmp, 5);
//     CREQ->pay_detail[23] = 'F';
//     cm_mov((char *)&CREQ->pay_detail[24], (char *)tmp, 5);
//     CREQ->pay_detail[29] = '@';
//     }
//     }
//     }

//     if(rcChk_Crdt_Cancel()) { /* 訂正モード？ */
//     memset(CREQ->pay_detail, ' ', sizeof(CREQ->pay_detail)); /* 支払内容明細リセット */
//     memset(buf, 0x0, sizeof(buf));
//     sprintf(buf, "%ld", kind);
//     rpno = cm_bcdtol(CMEM->working.crdt_reg.rpno, sizeof(CMEM->working.crdt_reg.rpno));
//     sprintf(CREQ->pay_detail, "%05ld", rpno);
//     if(CMEM->working.crdt_reg.stat & 0x0080) { /* 当日分解約？ */
//     CREQ->pay_detail[5] = '1';
//     CREQ->pay_detail[6] = '1';
//     cm_mov(&CREQ->pay_detail[7], buf, sizeof(buf));
//     CREQ->pay_detail[9] = '@';
//     }
//     else {
//     CREQ->pay_detail[5] = '2';
//     CREQ->pay_detail[6] = '1';
//     cm_mov(&CREQ->pay_detail[7], buf, sizeof(buf));
//     CREQ->pay_detail[9] = '@';
//     }
//     }
//     return;
//     }
//     #endif
/************************************************************************************************/
          if (await RcCrdtFnc.rcChkPaySeason()) {
            if (cMem.working.crdtReg.buseBcnt == 1) {
              // ボーナス併用ボーナス回数１回
              if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += "@";
            } else {
              if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                // 冬→夏
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += "F";
              buf = "";
              if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              }
              if (cMem.working.crdtReg.buseBcnt == 2) {
                RcCrdt.cReq.payDetail += "@";
              } else {
                tmp = "";
                tmp = RcCrdt.cReq.payDetail.substring(12, 17);
                RcCrdt.cReq.payDetail += "F";
                if (cMem.working.crdtReg.buseBcnt == 3) {
                  RcCrdt.cReq.payDetail += tmp.substring(0, 2);
                  RcCrdt.cReq.payDetail += "@";
                } else if (cMem.working.crdtReg.buseBcnt == 4) {
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "@";
                } else if (cMem.working.crdtReg.buseBcnt == 5) {
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "F";
                  RcCrdt.cReq.payDetail += tmp.substring(0, 2);
                  RcCrdt.cReq.payDetail += "@";
                } else if (cMem.working.crdtReg.buseBcnt == 6) {
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "F";
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "@";
                }
              }
            }
          } else {
            if (cMem.working.crdtReg.buseBcnt == 1) {
              // ボーナス併用ボーナス回数１回
              if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += "@";
            } else {
              if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
                // 夏→冬
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.summer_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm1 =
                    cMem.working.crdtReg.crdtTbl.summer_bonus_pay3;
              }
              RcCrdt.cReq.payDetail += "F";
              buf = "";
              if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay1}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay1;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay2}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay2;
              } else if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
                buf = "${cMem.working.crdtReg.crdtTbl.winter_bonus_pay3}"
                    .padLeft(2, '0');
                RcCrdt.cReq.payDetail += buf;
                cMem.working.crdtReg.bonsMm2 =
                    cMem.working.crdtReg.crdtTbl.winter_bonus_pay3;
              }
              if (cMem.working.crdtReg.buseBcnt == 2) {
                RcCrdt.cReq.payDetail += "@";
              } else {
                tmp = "";
                tmp = RcCrdt.cReq.payDetail.substring(12, 17);
                RcCrdt.cReq.payDetail += "F";
                if (cMem.working.crdtReg.buseBcnt == 3) {
                  RcCrdt.cReq.payDetail += tmp.substring(0, 2);
                  RcCrdt.cReq.payDetail += "@";
                } else if (cMem.working.crdtReg.buseBcnt == 4) {
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "@";
                } else if (cMem.working.crdtReg.buseBcnt == 5) {
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "F";
                  RcCrdt.cReq.payDetail += tmp.substring(0, 2);
                  RcCrdt.cReq.payDetail += "@";
                } else if (cMem.working.crdtReg.buseBcnt == 6) {
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "F";
                  RcCrdt.cReq.payDetail += tmp;
                  RcCrdt.cReq.payDetail += "@";
                }
              }
            }
          }
        }
/************************************************************************************************/
      } else {
        kind = 31; // ボーナス併用選択
        RcCrdt.cReq.payKind = "$kind";
        RcCrdt.cReq.payDetail = "31A00C";
        if (cMem.working.crdtReg.crdtTbl.bonus_use3 == 1) {
          RcCrdt.cReq.payDetail += "03";
          cMem.working.crdtReg.diviCnt = 3;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use5 == 1) {
          RcCrdt.cReq.payDetail += "05";
          cMem.working.crdtReg.diviCnt = 5;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use6 == 1) {
          RcCrdt.cReq.payDetail += "06";
          cMem.working.crdtReg.diviCnt = 6;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use10 == 1) {
          RcCrdt.cReq.payDetail += "10";
          cMem.working.crdtReg.diviCnt = 10;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use12 == 1) {
          RcCrdt.cReq.payDetail += "12";
          cMem.working.crdtReg.diviCnt = 12;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use15 == 1) {
          RcCrdt.cReq.payDetail += "15";
          cMem.working.crdtReg.diviCnt = 15;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use18 == 1) {
          RcCrdt.cReq.payDetail += "18";
          cMem.working.crdtReg.diviCnt = 18;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use20 == 1) {
          RcCrdt.cReq.payDetail += "20";
          cMem.working.crdtReg.diviCnt = 20;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use24 == 1) {
          RcCrdt.cReq.payDetail += "24";
          cMem.working.crdtReg.diviCnt = 24;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use30 == 1) {
          RcCrdt.cReq.payDetail += "30";
          cMem.working.crdtReg.diviCnt = 30;
        } else if (cMem.working.crdtReg.crdtTbl.bonus_use36 == 1) {
          RcCrdt.cReq.payDetail += "36";
          cMem.working.crdtReg.diviCnt = 36;
        }
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // #if DEPARTMENT_STORE
        // else if (cMem.working.crdtReg.crdtTbl.bonus_use8 == 1) {
        //   RcCrdt.cReq.payDetail += "08";
        //   cMem.working.crdtReg.diviCnt = 8;
        // } else if (cMem.working.crdtReg.crdtTbl.bonus_use4 == 1) {
        //   RcCrdt.cReq.payDetail += "04";
        //   cMem.working.crdtReg.diviCnt = 4;
        // } else if (cMem.working.crdtReg.crdtTbl.bonus_use25 == 1) {
        //   RcCrdt.cReq.payDetail += "25";
        //   cMem.working.crdtReg.diviCnt = 25;
        // } else if (cMem.working.crdtReg.crdtTbl.bonus_use35 == 1) {
        //   RcCrdt.cReq.payDetail += "35";
        //   cMem.working.crdtReg.diviCnt = 35;
        // }
        // #endif
        RcCrdt.cReq.payDetail += "@";
      }
    }
/************************************************************************************************/
    else if (cMem.working.crdtReg.crdtTbl.ribo == 1) {
      kind = 80; // リボ払い選択
      RcCrdt.cReq.payKind = "$kind";
      RcCrdt.cReq.payDetail = "80@";
    }
/************************************************************************************************/
    // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
    // #if DEPARTMENT_STORE
    // else if(CMEM->working.crdt_reg.crdttbl.skip == 1) {
    // kind = 10; /* スキップ払い選択 */
    // sprintf(CREQ->pay_kind, "%ld", kind);
    // CREQ->pay_detail[0] = '1';
    // CREQ->pay_detail[1] = '0';
    // CREQ->pay_detail[2] = '@';
    // CMEM->working.crdt_reg.divi_cnt = 1;
    // CMEM->working.crdt_reg.multi_flg |= 0x04;
    // }
    // else if(CMEM->working.crdt_reg.crdttbl.fil2 == 1) {
    // kind = 99; /* 個別割賦払い選択 */
    // sprintf(CREQ->pay_kind, "%ld", kind);
    // CREQ->pay_detail[0] = '9';
    // CREQ->pay_detail[1] = '9';
    // CREQ->pay_detail[2] = '@';
    // }
    // #endif
/************************************************************************************************/
    if (await RcCrdtFnc.rcChkCrdtCancel()) {
      // 訂正モード？
      if (await RcSysChk.rcChkVegaProcess()) {
        RcCrdt.cReqVEGA.reqAdd.crdtvoidFlg = '1';
        // 元取引の支払明細をセットする
        RcCrdt.cReqVEGA.reqAdd.voidDetail = ''.padLeft(84, ' ');
        RcCrdt.cReqVEGA.reqAdd.voidDetail = RcCrdt.cReq.payDetail;
      }
      RcCrdt.cReq.payDetail = ''.padLeft(84, ' '); // 支払内容明細リセット
      buf = "";
      buf = "$kind";
      rpno = Bcdtol.cmBcdToL(cMem.working.crdtReg.rpno);
      RcCrdt.cReq.payDetail = rpno.toString().padLeft(5, '0');
      if (cMem.working.crdtReg.stat & 0x0080 != 0) {
        // 当日分解約？
        RcCrdt.cReq.payDetail =
            '${RcCrdt.cReq.payDetail.substring(0, 5)}11$buf@';
      } else {
        RcCrdt.cReq.payDetail =
            '${RcCrdt.cReq.payDetail.substring(0, 5)}21$buf@';
      }
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Chk_Bonus2_Month
  static bool rcCardCrewChkBonus2Month() {
    AcMem cMem = SystemFunc.readAcMem();
    if ((cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0 ||
            cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0 ||
            cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) &&
        (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0 ||
            cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0 ||
            cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0)) {
      return true;
    } else {
      return false;
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Conf
  static Future<void> rcCardCrewConf(int erCode, int UserCode, Function func1,
      String msg1, String dspMsg) async {
    // tprDlgParam_t param;
    String msgBuf = ''; // char MsgBuf[31];

    RcIfEvent.rxChkTimerRemove();

    // param.er_code    = er_code;
    // param.dialog_ptn = TPRDLG_PT1;
    // param.func1      = (void *)func1;
    // param.msg1       = msg1;
    if (erCode == DlgConfirmMsgKind.MSG_TEXT78.dlgId) {
      // param.title   = "";
    } else {
      // param.title   = ER_MSG_OFFLINE;
    }
    // param.user_code  = user_code;
    if (dspMsg.isNotEmpty) {
      // param.user_code = 0;
      msgBuf = dspMsg;
    }
    // param.user_code_2 = MsgBuf;
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        // TprLibDlg(&param);
        MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.info,
            dialogId: erCode,
            btnFnc: () async {
              func1;
              Get.back();
            }));
        break;
      case RcRegs.KY_SINGLE:
        if (await RcSysChk.rcSGChkSelfGateSystem()) {
          // #if SELF_GATE
          if (!await RcSysChk.rcNewSGChkNewSelfGateSystem()) {
            // param.dual_dsp = 2;
          }
          // #endif

          // TprLibDlg(&param);
        } else {
          // TprLibDlg(&param);
          // param.dual_dsp = 3;
          // TprLibDlg(&param);
          MsgDialog.show(MsgDialog.singleButtonDlgId(
              type: MsgDialogType.info,
              dialogId: erCode,
              btnFnc: () async {
                func1;
                // Get.back();
              }));
        }
        break;
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_End
  static Future<void> rcCardCrewEnd() async {
    int errNo;
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave? ifSave;

    errNo = Typ.OK;
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCardCrewEnd() Push\n");
    await rcCardCrewCautionClear();
    cMem.working.crdtReg.kasumiOffcrdt = 1;
    if (cMem.working.crdtReg.step == KyCrdtInStep.CARD_KIND.cd) {
      cMem.working.crdtReg.companyCd = 0;
      // rcD_Mcd();
    } else if ((cMem.working.crdtReg.step ==
            KyCrdtInStep.RECEIT_NO.cd) || // 手入力？
        ((RcSysChk.rcVDOpeModeChk()) &&
            (cMem.working.crdtReg.step == KyCrdtInStep.GOOD_THRU.cd))) {
      if (await RcSysChk.rcChkCrdtDscSystem()) {
        RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
        RcCrdtFnc.rcCrdtStlDscSet();
      }
      if (await RcCrdtFnc.rcChkFloorLimit() != false) {
        // 割引発生後、フロアリミットを超えている？
        cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd;
        await RcCrdtDsp.rcCrdtStepDisp();
        if ((await RcSysChk.rcChkCrdtDscSystem()) &&
            (RegsMem().tTtllog.t100002.stlcrdtdscAmt != 0)) {
          RcCrdtFnc.rcCrdtDscWarnUp(DlgConfirmMsgKind.MSG_STLCRDTDSC.dlgId);
        }
      } else {
        errNo = await RcFlrd.rcReadCrdttblFL(
            RcCrdt.MANUAL_INPUT, RcCrdt.CARDCREW_OFF);
        if (errNo != Typ.OK) {
          cMem.ent.errNo = errNo;
          await RcExt.rcErr('rcCardCrewEnd', cMem.ent.errNo);
        } else {
          cMem.working.crdtReg.kasumiOffcrdt = 0;
          await RckyCrdtIn.rcKyCrdtIn();
        }
      }
    } else if (cMem.working.crdtReg.step == KyCrdtInStep.INPUT_END.cd) {
      cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd;
      await RcCrdtDsp.rcCrdtStepDisp();
    }
    await RcIfEvent.rxChkTimerAdd();
    await RcIfEvent.rcWaitSave();
    if (ifSave!.count != 0) {
      ifSave = IfWaitSave();
    }
  }

  ///  関連tprxソース: rccardcrew.c - rcCardCrew_Caution_Clear
  static Future<void> rcCardCrewCautionClear() async {
    await RcIfEvent.rxChkTimerAdd();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        Get.back();
        break;
      case RcRegs.KY_SINGLE:
        Get.back();
        break;
    }
  }
}

