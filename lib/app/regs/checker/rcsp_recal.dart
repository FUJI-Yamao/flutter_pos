/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_atct.dart';
import 'rc_flrda.dart';
import 'rc_qrinf.dart';
import 'rccatalina.dart';
import 'rcfncchk.dart';
import 'rcnoteplu.dart';
import 'rcqc_com.dart';
import 'rcqr_com.dart';
import 'rcsptendinfo.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

/// 関連tprxソース: rcsp_recal.c - struct RecalSaveSplt
class RecalSaveSplt {
  int spltCnt = 0;
  List<T100100> spltData = List<T100100>.generate(
      CntList.sptendMax, (index) => T100100());
  List<T100100Sts> spltStatus = List<T100100Sts>.generate(
      CntList.sptendMax, (index) => T100100Sts());
  int fgUseTtl = 0;
}

class RcspRecal {
  static int sptendSelectNo = 0;
  static int spAllCnclFlg = 0;
  static RecalSaveSplt saveSplt = RecalSaveSplt();
  static SubttlInfo Subttl = SubttlInfo();

  /// スプリット表示_メイン処理
  /// 引数: 0=スプリットデータを一時保存  1=一時保存したスプリットデータを戻す
  ///  関連tprxソース: rcsp_recal.c - rcSPTendBuf_Edit
  static Future<void> rcSPTendBufEdit(int kind) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    int num = 0;

    if (kind == 0) { // 本ソース内のメモリに一時保存
      rcSPTendMemClear();
      saveSplt.spltCnt = mem.tTtllog.t100001Sts.sptendCnt;
      for (num = 0; num < saveSplt.spltCnt; num++) {
        saveSplt.spltData[num] = mem.tTtllog.t100100[num];
        saveSplt.spltStatus[num] = mem.tTtllog.t100100Sts[num];
        RcRegs.ot.ttlsptendAmt += saveSplt.spltData[num].sptendData;
        if (await RcSysChk.rcQCChkQcashierSystem()) {
          if (CompileFlag.CATALINA_SYSTEM) {
            if (RcCatalina.rcChkSptendCatalina(
                num, saveSplt.spltData[num].sptendCd,
                saveSplt.spltData[num].sptendData)) {
              RcRegs.ot.ttlsptendAmt -= saveSplt.spltData[num].sptendData;
            }
          }
          if (RcNotePlu.rcChkSptendNotePlu(num, saveSplt.spltData[num].sptendCd,
              saveSplt.spltData[num].sptendData)) {
            RcRegs.ot.ttlsptendAmt -= saveSplt.spltData[num].sptendData;
          }
          if (cBuf.dbTrm.discBarcode28d != 0) {
            if (RcqrCom.rcChkSptendBeniya(num, saveSplt.spltData[num].sptendCd,
                saveSplt.spltData[num].sptendData)) {
              RcRegs.ot.ttlsptendAmt -= saveSplt.spltData[num].sptendData;
            }
          }
        }
      }
      if (RcSysChk.rcsyschkSm66FrestaSystem()) {
        saveSplt.fgUseTtl = mem.tTtllog.t100001Sts.fgTtlUse;
        // TODO:10155 顧客呼出_実装対象外（フレスタFG券は仕様対象外）
        /*
        for (num = 0; num < saveSplt.fgUseTtl; num++) {
          // FG券実績を詰め直す
          fgSaveSplt.FGStatus[num] = mem.tTtllog.t100906[num];
        }
         */
      }
    } else { // 保存したスプリットデータを戻す
      mem.tTtllog.t100001Sts.sptendCnt = saveSplt.spltCnt;
      for (int num = 0; num < mem.tTtllog.t100001Sts.sptendCnt; num++) {
        mem.tTtllog.t100100[num] = saveSplt.spltData[num];
        mem.tTtllog.t100100Sts[num] = saveSplt.spltStatus[num];
        // 本来戻してはいけないデータ
        mem.tTtllog.t100100[num].sptendOutAmt = 0;
        mem.tTtllog.t100100[num].sptendInAmt = 0;
        mem.tTtllog.t100100[num].sptendChgAmt = 0;
      }
      if (RcSysChk.rcsyschkSm66FrestaSystem()) {
        mem.tTtllog.t100001Sts.fgTtlUse = saveSplt.fgUseTtl;
        // TODO:10155 顧客呼出_実装対象外（フレスタFG券は仕様対象外）
        /*
        for (num = 0; num < mem.tTtllog.t100001Sts.fgTtlUse; num++ ) {
          // FG券実績を詰め直す
          mem.tTtllog.t100906[num] =fgSaveSplt.FGStatus[num];
        }
         */
      }
    }
  }

  /// スプリット表示_リセット処理
  ///  関連tprxソース: rcsp_recal.c - rcSPTendMem_Clear(
  static void rcSPTendMemClear() {
    saveSplt = RecalSaveSplt();
    RcRegs.ot.ttlsptendAmt = 0;
  }

  /// 任意のスプリットの選択状態をチェックする
  /// 戻り値: true=選択中  false=未選択
  ///  関連tprxソース: rcsp_recal.c - rcSPTendCheck_SptendSelect
  static Future<bool> rcSPTendCheckSptendSelect() async {
    if (!(await RcSysChk.rcChkSptendInfo())) {
      /* スプリット画面の設定ではない */
      return false;
    }
    if ((await RcSysChk.rcQCChkQcashierSystem() == false) &&
        (Subttl.sptendInfo.sptendinfoFixed == null) &&
        (RcqrCom.qrTxtStatus != QrTxtStatus.QR_TXT_STATUS_READ.index)) {
      /* スプリット画面が非表示 */
      return false;
    }
    // if(rcKyExtKey_Disp_Posi() == 1)
    if ((Dummy.rcKyExtKeyDispPosi() == 1) &&
        (Dummy.rcChkKyExtKeyDispType() == ExtkyType.EXTKY_STL)) {
      /* 小計拡張キーが左側表示でスプリット画面を隠している */
      return false;
    }
    if ((sptendSelectNo <= 0) || (sptendSelectNo >= CntList.sptendMax)) {
      /* スプリット選択がない */
      return false;
    }
    return true;
  }

  /// スプリットテンダリングを再計算する
  /// 戻り値: テンダリングタイプ
  ///  関連tprxソース: rcsp_recal.c - rcSPTend_ReCalc
  static Future<TendType> rcSPTendReCalc() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return TendType.TEND_TYPE_NO_ENTRY_DATA;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (cBuf.dbTrm.sptendSelectVoidChange == 1) {
      RcAtct.rcATCTProcCheckPassSet(RcRegs.PASS_CHECK_ON);	/* エラーを無視する(フラグON) */
    }

    int sptendCnt = mem.tTtllog.t100001Sts.sptendCnt;
    mem.tTtllog.t100001Sts.sptendCnt = 0;     /* スプリットを最初から作る為、カウントを０に戻す */

    KopttranBuff koptTran = KopttranBuff();
    int num = 0;
    int unitPrice = 0;
    int faceAmt = 0;
    TendType eTendType = TendType.TEND_TYPE_NO_ENTRY_DATA;
    for (num = 0; num < sptendCnt; num++) {
      cMem.stat.fncCode = mem.tTtllog.t100100[num].sptendCd;
      if ((RcNotePlu.rcChkSptendNotePlu(num, cMem.stat.fncCode, mem.tTtllog.t100100[num].sptendData)) ||
          ((CompileFlag.CATALINA_SYSTEM) && RcCatalina.rcChkSptendCatalina(num, cMem.stat.fncCode, mem.tTtllog.t100100[num].sptendData)) ||
          ((cBuf.dbTrm.discBarcode28d != 0) && RcCatalina.rcChkSptendCatalina(num, cMem.stat.fncCode, mem.tTtllog.t100100[num].sptendData))) {
        continue;
      }
      if (mem.tTtllog.t100100Sts[num].sptendFlg == 0) {
        cMem.ent.tencnt = 1;
      }
      await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran);
      if (koptTran.frcEntryFlg == 3) {
        cMem.ent.tencnt = 0;            /* エントリーカウントをリセット */
      }
      cMem.working.dataReg.kMan0 = mem.tTtllog.t100100[num].manCnt;
      cMem.working.dataReg.kMul0 = mem.tTtllog.t100100[num].sptendSht;
      if (cMem.working.dataReg.kMul0 != 0) {
        unitPrice = mem.tTtllog.t100100[num].sptendData ~/ cMem.working.dataReg.kMul0;
      } else {
        unitPrice = mem.tTtllog.t100100[num].sptendData;
      }
      String tmpEntry = Ltobcd.cmLtobcd(unitPrice, cMem.ent.entry.length);
      for (int i=0; i<tmpEntry.length-1; i++) {
        cMem.ent.entry[i] = int.parse(tmpEntry.substring(i, i+1));
      }
      faceAmt = mem.tTtllog.t100100[num].sptendFaceAmt;
      eTendType = await RcAtct.rcATCTProc();
      if (await RcSysChk.rcCheckIndividChange()) {
        if ((faceAmt != 0) &&
            ((mem.tTtllog.t100100[num].sptendCd == FuncKey.KY_CASH.keyId) ||
                ((CompileFlag.DEPARTMENT_STORE &&
                    ((mem.tTtllog.t100100[num].sptendCd ==
                        FuncKey.KY_CHK1.keyId) ||
                        (mem.tTtllog.t100100[num].sptendCd ==
                            FuncKey.KY_CHK2.keyId)))))) {
          mem.tTtllog.t100100[num].sptendFaceAmt = faceAmt;
        }
      }
      if (eTendType == TendType.TEND_TYPE_ERROR) {
        break;
      }
      if ((RcSysChk.rcChkRPointMbrReadTMCQCashier() != 0) &&
          RcFncChk.rcQCCheckRPtsMbrReadMode()) {
        /* 楽天ポイントカードを精算機で読み込んだ結果 */
        /* 適用されるロイヤリティ企画のキャンペーンタイプによって */
        /* 合計金額が変動し途中のスプリット段数で支払い額に達するおそれがあるため */
        /* 条件に該当した時、処理を中断させる */
        if (RcAtct.rcATCTChkTendType(eTendType)) {
          break;
        }
      }
      if ((await RcFncChk.rcChkQcashierMemberReadSystem()) &&
          (await RcFncChk.rcChkQcashierMemberReadEntryMode()) ) {
        /* 会員カードを精算機で読取した結果 */
        /* 適用されるロイヤリティ企画のキャンペーンタイプによって */
        /* 合計金額が変動し途中のスプリット段数で支払い額に達するおそれがあるため */
        /* 条件に該当した時、処理を中断させる */
        if (RcAtct.rcATCTChkTendType(eTendType)) {
          break;
        }
      }
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      if (CompileFlag.CATALINA_SYSTEM) {
        await RcQcCom.rcCatalinaSPDataSet();
      }
      await RcQcCom.rcNotePluSPDataSet();
    }
    if (cBuf.dbTrm.sptendSelectVoidChange == 1) {
      RcAtct.rcATCTProcCheckPassSet(RcRegs.PASS_CHECK_OFF);	/* エラーを無視する(フラグOFF) */
    }
    return (eTendType);
  }

  /// スプリット情報をクリアする
  ///  関連tprxソース: rcsp_recal.c - rcSPTend_TtllogClear
  static void rcSPTendTtllogClear() {
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.t100100 = List.generate(CntList.sptendMax, (_) => T100100());
    mem.tTtllog.t100100Sts = List.generate(CntList.sptendMax, (_) => T100100Sts());

    mem.tTtllog.t100001Sts.sptendCnt = 0;       /* Clear split tend buffer count */
    mem.tTtllog.calcData.stlTaxAmt = mem.tTtllog.t100001.stlTaxInAmt;
    if (RcSysChk.rcsyschkSm66FrestaSystem()) {
      // TODO:10155 顧客呼出_実装対象外（フレスタFG券は仕様対象外）
      /*
      memset( &MEM->tTtllog.t100906, 0x00, sizeof(MEM->tTtllog.t100906) );
       */
    }
    /* スプリットの選択状態 */
    rcSPTendClearSptendSelect();
  }

  /// 任意のスプリットの選択状態を解除して未選択にする
  ///  関連tprxソース: rcsp_recal.c - rcSPTend_ClearSptendSelect
  static void rcSPTendClearSptendSelect() {
    RcSptendInfo.rcSptendInfoSelectFrmDsp(RegsDef.subttl, sptendSelectNo, 0);
    if (FbInit.subinitMainSingleSpecialChk()) {
      RcSptendInfo.rcSptendInfoSelectFrmDsp(RegsDef.dualSubttl, sptendSelectNo, 0);
    }
    sptendSelectNo = 0;
  }



  /// クラス変数SpAllCnclFlgを返す
  ///  関連tprxソース: rcsp_recal.c - rcSpRecal_Get_SpAllCnclFlg
  static int rcSpRecalGetSpAllCnclFlg() {
    return spAllCnclFlg;
  }
}