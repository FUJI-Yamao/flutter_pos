/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_crdt.dart';
import '../inc/rccatalina_define.dart';
import 'rcfncchk.dart';
import 'rcsyschk.dart';

class RcCatalina {
  /// 関連tprxソース: rccatalina.c - cm_Catalina_System(short cashtypchkflg)
  static bool cmCatalinaSystem(int cashtypchkflg) {
    bool res = false;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "cmCatalinaSystem() rxMemRead error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    RcRecogLists rcRecogLists = RcRecogLists();

    if (rcRecogLists.recogCatalinasystem != 0) {
      res = true;
    }

    return ((res) &&
        ((pCom.dbTrm.catalineKeyCd != 0) ||
            (pCom.dbTrm.catalinacpnKeyCd != 0) ||
            (cashtypchkflg != 0)));
  }

  /// 関連tprxソース: rccatalina.c - Catalina_DataWrite
  static void catalinaDataWrite(int msgTyp, int kind) {
    // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  }

  /// 関連tprxソース: rccatalina.c - rcCatalinaAllSend2
  static Future<void> rcCatalinaAllSend2(int qcSendFlg) async {
    String log = "";

    if ((await RcSysChk.rcQCChkQcashierSystem() &&
            !RcSysChk.cmRealItmSendSystem() &&
            (qcSendFlg == 1)) ||
        (RcSysChk.cmRealItmSendSystem() && (qcSendFlg == 0)) ||
        (!await RcSysChk.rcQCChkQcashierSystem() && (qcSendFlg == 0))) {
      if (RcSysChk.cmRealItmSendSystem()) {
        catalinaDataWrite(
            RcCatalinaDef.CA_MSG_SINONOFF, RcCatalinaDef.CA_ACT_SINON);
      }
      catalinaDataWrite(RcCatalinaDef.CA_MSG_REGSTART, 0);
      catalinaDataWrite(RcCatalinaDef.CA_MSG_ITEM, 1);
      catalinaDataWrite(RcCatalinaDef.CA_MSG_STLTTL, 0);
      catalinaDataWrite(RcCatalinaDef.CA_MSG_SPTEND, 0);
      catalinaDataWrite(RcCatalinaDef.CA_MSG_COUPON, 0);
      if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
        catalinaDataWrite(RcCatalinaDef.CA_MSG_MBR, 0);
        catalinaDataWrite(RcCatalinaDef.CA_MSG_STLTTL, 0);
      } else if (RcFncChk.rcCheckMbrInput()) {
        catalinaDataWrite(RcCatalinaDef.CA_MSG_MBR, 0);
      }
      catalinaDataWrite(RcCatalinaDef.CA_MSG_REGEND, 0);
    } else {
      //cm_clr(log, sizeof(log));
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        log = "Qcashier Catalina Send Skip[send flg:$qcSendFlg]";
      } else {
        log = "Catalina Send Skip[send flg:$qcSendFlg]";
      }
      TprLog().logAdd(0, LogLevelDefine.normal, log);
    }
  }

  /// 関連tprxソース: rccatalina.c - rcChkSptendCatalina
  static bool rcChkSptendCatalina(int sptendCnt, int fncCd, int sptendData) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    int cFncCd1 = 0;
    int cFncCd2 = 0;
    if (cmCatalinaSystem(0)) {
      if ((cBuf.dbTrm.catalineKeyCd >= 16) &&
          (cBuf.dbTrm.catalineKeyCd <= 35) ) {
        cFncCd2 = cBuf.dbTrm.catalineKeyCd + FuncKey.KY_CHA11.keyId - 16;
      } else if ((cBuf.dbTrm.catalineKeyCd >= 11) && (cBuf.dbTrm.catalineKeyCd <= 15)) {
        cFncCd2 = cBuf.dbTrm.catalineKeyCd + FuncKey.KY_CHK1.keyId - 11;
      } else if ((cBuf.dbTrm.catalineKeyCd >= 1) && (cBuf.dbTrm.catalineKeyCd <= 10)) {
        cFncCd2 = cBuf.dbTrm.catalineKeyCd + FuncKey.KY_CHA1.keyId - 1;
      } else {
        cFncCd2 = FuncKey.KY_CASH.keyId;
      }
      if ((cBuf.dbTrm.catalinacpnKeyCd >= 16) && (cBuf.dbTrm.catalinacpnKeyCd <= 35)) {
        cFncCd1 = cBuf.dbTrm.catalinacpnKeyCd + FuncKey.KY_CHA11.keyId - 16;
      } else if ((cBuf.dbTrm.catalinacpnKeyCd >= 11) && (cBuf.dbTrm.catalinacpnKeyCd <= 15)) {
        cFncCd1 = cBuf.dbTrm.catalinacpnKeyCd + FuncKey.KY_CHK1.keyId - 11;
      } else if( (cBuf.dbTrm.catalinacpnKeyCd >= 1) && (cBuf.dbTrm.catalinacpnKeyCd <= 10)) {
        cFncCd1 = cBuf.dbTrm.catalinacpnKeyCd + FuncKey.KY_CHA1.keyId - 1;
      } else {
        cFncCd1 = FuncKey.KY_CASH.keyId;
      }
      if (cFncCd2 == cFncCd1) {
        if ((sptendCnt == 0) &&
            (mem.tmpbuf.catalinaTtlamt == sptendData) &&
            (fncCd == cFncCd1)) {
          return true;
        }
      } else {
        if ((((mem.tmpbuf.catalinaManufact == sptendData) && (fncCd == cFncCd1)) ||
            ((mem.tmpbuf.catalinaStore == sptendData) && (fncCd == cFncCd2))) &&
            (sptendCnt < 2)) {
          return true;
        }
      }
    }

    return false;
  }

  /// 関連tprxソース: rccatalina.c - rcCatalinaNonPrcSalesTrans
  static void rcCatalinaNonPrcSalesTrans(int fncNo, int qty) {
    RegsMem mem = SystemFunc.readRegsMem();
    switch (fncNo) {
      case 1:
        mem.tTtllog.t100200[AmtKind.amtCha1.index].cnt++;
        mem.tTtllog.t100200[0].sht += qty;
        break;
      case 2:
        mem.tTtllog.t100200[AmtKind.amtCha2.index].cnt++;
        mem.tTtllog.t100200[1].sht += qty;
        break;
      case 3:
        mem.tTtllog.t100200[AmtKind.amtCha3.index].cnt++;
        mem.tTtllog.t100200[2].sht += qty;
        break;
      case 4:
        mem.tTtllog.t100200[AmtKind.amtCha4.index].cnt++;
        mem.tTtllog.t100200[3].sht += qty;
        break;
      case 5:
        mem.tTtllog.t100200[AmtKind.amtCha5.index].cnt++;
        mem.tTtllog.t100200[4].sht += qty;
        break;
      case 6:
        mem.tTtllog.t100200[AmtKind.amtCha6.index].cnt++;
        mem.tTtllog.t100200[5].sht += qty;
        break;
      case 7:
        mem.tTtllog.t100200[AmtKind.amtCha7.index].cnt++;
        mem.tTtllog.t100200[6].sht += qty;
        break;
      case 8:
        mem.tTtllog.t100200[AmtKind.amtCha8.index].cnt++;
        mem.tTtllog.t100200[7].sht += qty;
        break;
      case 9:
        mem.tTtllog.t100200[AmtKind.amtCha9.index].cnt++;
        mem.tTtllog.t100200[8].sht += qty;
        break;
      case 10:
        mem.tTtllog.t100200[AmtKind.amtCha1.index].cnt++;
        mem.tTtllog.t100200[9].sht += qty;
        break;
      case 11:
        mem.tTtllog.t100200[AmtKind.amtChk1.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtChk1.index].sht += qty;
        break;
      case 12:
        mem.tTtllog.t100200[AmtKind.amtChk2.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtChk2.index].sht += qty;
        break;
      case 13:
        mem.tTtllog.t100200[AmtKind.amtChk3.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtChk3.index].sht += qty;
        break;
      case 14:
        mem.tTtllog.t100200[AmtKind.amtChk4.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtChk4.index].sht += qty;
        break;
      case 15:
        mem.tTtllog.t100200[AmtKind.amtChk5.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtChk5.index].sht += qty;
        break;
      case 16:
        mem.tTtllog.t100200[AmtKind.amtCha1.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha1.index].sht += qty;
        break;
      case 17:
        mem.tTtllog.t100200[AmtKind.amtCha2.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha2.index].sht += qty;
        break;
      case 18:
        mem.tTtllog.t100200[AmtKind.amtCha3.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha3.index].sht += qty;
        break;
      case 19:
        mem.tTtllog.t100200[AmtKind.amtCha4.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha4.index].sht += qty;
        break;
      case 20:
        mem.tTtllog.t100200[AmtKind.amtCha5.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha5.index].sht += qty;
        break;
      case 21:
        mem.tTtllog.t100200[AmtKind.amtCha6.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha6.index].sht += qty;
        break;
      case 22:
        mem.tTtllog.t100200[AmtKind.amtCha7.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha7.index].sht += qty;
        break;
      case 23:
        mem.tTtllog.t100200[AmtKind.amtCha8.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha8.index].sht += qty;
        break;
      case 24:
        mem.tTtllog.t100200[AmtKind.amtCha9.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha9.index].sht += qty;
        break;
      case 25:
        mem.tTtllog.t100200[AmtKind.amtCha10.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha10.index].sht += qty;
        break;
      case 26:
        mem.tTtllog.t100200[AmtKind.amtCha11.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha11.index].sht += qty;
        break;
      case 27:
        mem.tTtllog.t100200[AmtKind.amtCha12.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha12.index].sht += qty;
        break;
      case 28:
        mem.tTtllog.t100200[AmtKind.amtCha13.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha13.index].sht += qty;
        break;
      case 29:
        mem.tTtllog.t100200[AmtKind.amtCha14.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha14.index].sht += qty;
        break;
      case 30:
        mem.tTtllog.t100200[AmtKind.amtCha15.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha15.index].sht += qty;
        break;
      case 31:
        mem.tTtllog.t100200[AmtKind.amtCha16.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha16.index].sht += qty;
        break;
      case 32:
        mem.tTtllog.t100200[AmtKind.amtCha17.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha17.index].sht += qty;
        break;
      case 33:
        mem.tTtllog.t100200[AmtKind.amtCha18.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha18.index].sht += qty;
        break;
      case 34:
        mem.tTtllog.t100200[AmtKind.amtCha19.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha19.index].sht += qty;
        break;
      case 35:
        mem.tTtllog.t100200[AmtKind.amtCha20.index].cnt++;
        mem.tTtllog.t100200[AmtKind.amtCha20.index].sht += qty;
        break;
      default:
        break;
    }
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rccatalina.c - rcObr_Catalina
  static void rcObrCatalina(){} 
  
}
