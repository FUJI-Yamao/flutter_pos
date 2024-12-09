/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_barcode_pay.dart';
import 'rc_key_pbchg.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rcfncchk.dart';
import 'rcitmchk.dart';
import 'rcky_pbchg.dart';
import 'rckyscrv.dart';
import 'rcmanualmix.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

/// 関連tprxソース:rckychgqty.h - CHGQTY_INFO
class ChgQtyInfo {
  int oldqty = 0;
  int newqty = 0;
  int maxqty = 0;
  int minqty = 0;
  int voidqty = 0;
  int ttlqty = 0;
}

/// 関連tprxソース: rckychgqty.c
class RckyChgQty{
  static ChgQtyInfo chgQtyInfo = ChgQtyInfo();

  /// 関連tprxソース: rckychgqty.c - rcChk_Ky_ChgQty
  static Future<int> rcChkKyChgQty() async {
    int errNo;
    int p;
    int checkNumber;

    errNo = await RckyScrv.rcCheckKyScrVoid();
    if (errNo != 0) {
      return (errNo);
    }

    checkNumber = ITEM28_1PAGE_MAX;

    AtSingl atSing = SystemFunc.readAtSingl();
    if (((atSing.tStlLcdItem.scrVoid < 1) ||
        (atSing.tStlLcdItem.scrVoid > checkNumber))) {
      return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }

    p = atSing.tStlLcdItem.iI;

    // プロモーションバーコードの個数変更
    if (RcStl.rcChkItmRBufPromBarcodeRec(p)) {
      return (DlgConfirmMsgKind.MSG_OPEMISS.dlgId); // プロモーションバーコードの個数変更はしない
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if (!RcStl.rcChkItmRBufScrVoid(p)) // will be ScreenVoid ?
    {
      if ((mem.tItemLog[p].t10001Sts.decPntItem != 0) ||
          (mem.tItemLog[p].t10003.recMthdFlg == 12)
          // #if CATALINA_SYSTEM
          ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.CATALINA_REC.typeCd) ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.CATALINA_STLDSC_REC.typeCd) ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.CATALINA_STLPDSC_REC.typeCd)
          // #endif
          ||
          (RcItmChk.rcCheckNoteItmRec(mem.tItemLog[p].t10003.recMthdFlg))
          // #if SALELMT_BAR
          ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.SALELMTOVER_REC.typeCd) ||
          (mem.tItemLog[p].t10003.barFormatFlg == 25) ||
          (mem.tItemLog[p].t10003.barFormatFlg == 24) ||
          (mem.tItemLog[p].t10003.barFormatFlg == 35)
          // #endif
          ||
          (mem.tItemLog[p].t10003.barFormatFlg == 33) ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.BARCODE_STLDSC_REC.typeCd) ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.BARCODE_STLPDSC_REC.typeCd) ||
          (mem.tItemLog[p].t10003.recMthdFlg ==
              REC_MTHD_FLG_LIST.BARCODE_MEMBER_STLPDSC_REC.typeCd) ||
          (await RcStlCal.rcChkAssortStmItm(p)) ||
          (mem.tItemLog[p].t10000Sts.btlRet1Flg != 0) ||
          (mem.tItemLog[p].t10003.itemKind == 1) ||
          (mem.tItemLog[p].t10003.itemKind ==
              RcRegs.ITEM_KIND_WEIGHT_ITEM2) // 重量商品
          ||
          (mem.tItemLog[p].t10003.itemKind == RcRegs.ITEM_KIND_VOLUME)) // 体積商品
      {
        errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
      }
    } else {
      errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
    }

    if (await RcManualMix.rcChkAssortMmItm(p)) {
      errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
    }

    if ((RcKyPbchg.rcPbchgRecCheck(p)) || (RckyPbchg.rcPbchgFeeRecCheck(p))) {
      errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "PLU rxMemRead error");
    }
    RxCommonBuf cBuf = xRet.object;

    if (CompileFlag.ARCS_MBR) {
      if (await CmMbrSys.cmNewARCSSystem() != 0) {
        if ((await CmCksys.cmNttdPrecaSystem() != 0) &&
            (RcSysChk.rcChkRalseCardSystem())) {
          if (mem.tItemLog[p].t10000.smlclsCd == cBuf.dbTrm.outSmlclsNum10) {
            errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
          }
        }
      }
    }
    if ((RcRegs.rcInfoMem.rcRecog.recogTrkPreca != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0)) {
      if (mem.tItemLog[p].t10000.smlclsCd ==
          Rxkoptcmncom.rxChkKoptPrecaInChargeSmlCls(cBuf)) {
        errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
      }
    }

    if ((RcRegs.rcInfoMem.rcRecog.recogCogcaSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogValuecardSystem != 0)) {
      if (mem.tItemLog[p].t10000.smlclsCd ==
          Rxkoptcmncom.rxChkKoptPrecaInChargeSmlCls(cBuf)) {
        errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
      }
    }

    if (await CmCksys.cmBarcodePayChargeSystem() != 0) {
      if (await RcBarcodePay.rcChkBarcodePayDepositSmlclsCode(
          99, mem.tItemLog[p].t10000.smlclsCd) != 0) {
        errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
      }
    }

    if ((await RcSysChk.rcChkGs1BarSystem()) &&
        (mem.tItemLog[p].t10001.wgt > 0)) {
      errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
    }

    if (CompileFlag.BDL_PER) {
      if (await rcChkSchMultMulSet(-1) == 0) {
        if ((await CmCksys.cmIchiyamaMartSystem() != 0) ||
            (await RcSysChk.rcChkSchMultiSelectSystem())) {
          errNo = DlgConfirmMsgKind.MSG_NOTCHANGEKEY.dlgId;
        }
      }
    }
    return (errNo);
  }

  /// 複数スケジュール仕様かチェック
  /// 関連tprxソース: rckychgqty.c - rcChk_SchMult_MulSet
  static Future<int> rcChkSchMultMulSet(int p) async {
    if (p >= 0) {
      RegsMem mem = SystemFunc.readRegsMem();
      if (await RcFncChk.rcChkBeforeMulKy()) //前後後か前前後の場合…（商品・×・置数・金額キーの順になる)
      {
        return ((await CmCksys.cmToySystem() != 0) &&
                    (mem.tItemLog[p].t10900.stmCd != 0) &&
                    (mem.tItemLog[p].t10901?.stmCd != 0) &&
                    (mem.tItemLog[p].t10902?.stmCd != 0) &&
                    (mem.tItemLog[p].t10903?.stmCd != 0) &&
                    (mem.tItemLog[p].t10904?.stmCd != 0) &&
                    (mem.tItemLog[p].t10905?.stmCd != 0) &&
                    (await RcSysChk.rcChkSchMultiSelectSystem())) == true ? 1 : 0;
      } else {
        return ((await CmCksys.cmToySystem() != 0) &&
                    (await RcSysChk.rcChkSchMultiSelectSystem())) == true ? 1 : 0;
      }
    } else {
      return ((await CmCksys.cmToySystem() != 0) &&
                  (await RcSysChk.rcChkSchMultiSelectSystem())) == true ? 1 : 0;
    }
  }
}
