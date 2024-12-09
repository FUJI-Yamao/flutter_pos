/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_ej/cm_ejlib.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_mbr_com.dart';
import 'rc_recno.dart';
import 'rc_setdate.dart';
import 'rc_stl.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcky_mbrprn.c
class RckyMbrPrn {
  /// デバッグ用ログ（false=なし  true=あり）
  static bool RC_MBRPRN_DBG_LOG = true;
  /// 訂正モード（false=ではない  true=である）
  static bool voidMode = false;
  /// 会員名印字
  static int saveMemNamePrint = 0;
  /// 会員住所印字
  static int saveCustAddrPrn = 0;
  /// 会員電話番号印字
  static int saveCustTelPrn = 0;
  /// 会員の印字項目変更フラグ
  static int prnChgFlg = 0;
  /// 会員の印字項目変更フラグ_前回値
  static int savePrnChgFlg = 0;
  ///
  static int prnCorrFlg = 0;

  ///  関連tprxソース: rcky_mbrprn.c - rcKyMbrPrn_StartSave_CustTrm
  static Future<void> rcKyMbrPrnStartSaveCustTrm() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    if ((await RcMbrCom.rcmbrChkStat() == 0) || voidMode) {
      return;
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcKyMbrPrnStartSaveCustTrm()");
    voidMode = true;
    saveMemNamePrint = cBuf.dbTrm.memNamePrint;
    saveCustAddrPrn = cBuf.dbTrm.custAddrPrn;
    saveCustTelPrn = cBuf.custTelPrn;
    savePrnChgFlg = prnChgFlg;
    cBuf.custTelPrn = 0;

    if (prnChgFlg != 0) {
      // 電話を「しない」
      prnChgFlg = 1;
      prnCorrFlg = 1;
      rcKyMbrPrnEjWrite(cBuf, 1);
    } else {
      // 初期状態にする
      prnChgFlg = 0;
    }
  }

  /// 電子ジャーナル書込
  /// 引数:[cBuf] 共有クラス""RxCommonBuf"
  /// 引数:[flg] 会員印字変更フラグ
  ///  関連tprxソース: rcky_mbrprn.c - rcKyMbrPrn_EjWrite
  static Future<void> rcKyMbrPrnEjWrite(RxCommonBuf cBuf, int flg) async {
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    RegsMem memSave = mem;
    CustData custDataSave = cMem.custData!;
    AtSingl atSingSave = atSing;
    int ret = 0;

    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);
    switch (cMem.stat.opeMode) {
      case RcRegs.RG:
        mem.tHeader.ope_mode_flg = 1;
        break;
      case RcRegs.VD:
        mem.tHeader.ope_mode_flg = 3;
        break;
      case RcRegs.TR:
        mem.tHeader.ope_mode_flg = 2;
        break;
      case RcRegs.SR:
        mem.tHeader.ope_mode_flg = 4;
        break;
      default:
        break;
    }
    mem.tHeader.cshr_no = int.parse(cBuf.dbStaffopen.cshr_cd!) ?? 0;
    mem.tHeader.chkr_no = cBuf.dbStaffopen.chkr_cd!;
    mem.tTtllog.t1000.cshrName = cBuf.dbStaffopen.cshr_name!;
    mem.tTtllog.t1000.chkrName =  cBuf.dbStaffopen.chkr_name!;
    mem.tTtllog.t100001.peopleCnt = 0;
    mem.tTtllog.t100700Sts.mbrPrnFlg = flg;
    mem.tTtllog.t100700Sts.mbrPrnName = cBuf.dbTrm.memNamePrint;
    mem.tTtllog.t100700Sts.mbrPrnAddr = cBuf.dbTrm.custAddrPrn;
    mem.tTtllog.t100700Sts.mbrPrnTel  = cBuf.custTelPrn;

    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();

    mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_MBRPRN.index;
    await EjLib.cmEjRemove();
    // TODO:10126 QUICPay、iD クラウドPOSへ置き換え
    /*
    ret = rc_Send_Update();
     */
    if (RC_MBRPRN_DBG_LOG) {
      int printNo = await Counter.competitionGetPrintNo(await RcSysChk.getTid());
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcKyMbrPrnEjWrite() : rc_Send_Update[$ret] print_no[$printNo]");
    }

    // TODO:10126 QUICPay、iD クラウドPOSへ置き換え
    /*
     rc_Inc_RctJnlNo(0);
     */
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);
    atSing = atSingSave;
    cMem.custData = custDataSave;
    mem = memSave;

    mem.tTtllog.t100700Sts.mbrPrnFlg = prnChgFlg;
    mem.tTtllog.t100700Sts.mbrPrnName = cBuf.dbTrm.memNamePrint;
    mem.tTtllog.t100700Sts.mbrPrnAddr = cBuf.dbTrm.custAddrPrn;
    mem.tTtllog.t100700Sts.mbrPrnTel = cBuf.custTelPrn;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rcky_mbrprn.c - rcKyMbrPrn_Copy_CustTrm2PrnrBuf
  static void rcKyMbrPrnCopyCustTrm2PrnrBuf() {
    return;
  }
}