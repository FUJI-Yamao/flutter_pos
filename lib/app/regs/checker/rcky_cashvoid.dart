/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../../clxos/calc_api_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../drv/ffi/library.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../lib/if_acx/acx_coin.dart';
import 'rc_elog.dart';
import 'rcky_rfdopr.dart';
import 'rckycrdtvoid.dart';

class RckyCashVoid {
  static bool isDebugWin = isWithoutDevice();

  ///  関連tprxソース: rcky_cashvoid.c - rcCheck_CashVoid_Dsp
  static bool rcCheckCashVoidDsp(){
    EsVoid esVoid = EsVoid();
    return (esVoid.cashvoidDspTyp != CashvoidDsp.CASHVOID_NON_DSP.cd);
  }

  ///  関連tprxソース: rcky_cashvoid.c - rcCashVoid_AllCncl
  /// TODO:00010 長田 定義のみ追加
  static void rcCashVoidAllCncl(int cncl_flg) {
  //   short i;
  //
  //   if( cncl_flg )
  //     cm_clr( (char *)&CashVoid.sp_in[0], sizeof(CashVoid.sp_in) );
  //   else
  //     memcpy( &CashVoid.sp_in[0], &CashVoid.sp_org[0], sizeof(CASHVOIDSPTEND) * SPTEND_MAX );
  // for(i = 0; i < SPTEND_MAX; i++) {
  // if( CashVoid.sp_org[i].fnc_cd != 0 )
  // CashVoid.sp_in[i].cncl_flg = cncl_flg;
  // }
  //   if( rcKy_Self() == KY_SINGLE) {
  // if((subinit_Main_single_Special_Chk() == TRUE) &&
  // (CMEM->stat.DualT_Single == 1))
  // rcCashVoid_SptendInfo_Set(&Dual_Subttl, SPTEND_MAX);
  // else
  // rcCashVoid_SptendInfo_Set(&Subttl, SPTEND_MAX);
  // }
  //   else
  //   rcCashVoid_SptendInfo_Set(&Subttl, SPTEND_MAX);

    return;
  }

  // TODO:00002 佐野 - 2024/7向けデモ対応（暫定）
  /// 訂正画面で[実行]ボタン押下後の処理（訂正金額の返却＆DBへのレコード登録）
  /// 戻り値: true=正常終了  false=異常終了
  static Future<bool> rcKeyVoidDemo() async {
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "RckyCashVoid.rcKeyVoidDemo(): rxMemRead(RXMEM_COMMON) error");
      mem.tTtllog.t100001Sts.itemlogCnt = 0;
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if (RegsMem().lastRequestData == null) {
      // uuidを取得.
      var uuidC = const Uuid();
      String uuid = uuidC.v4();
      RegsMem().lastRequestData = CalcRequestParaItem(
          compCd: pCom.dbRegCtrl.compCd,
          streCd: pCom.dbRegCtrl.streCd,
          uuid: uuid);
    }

    int changerRet = 0;
    if (RcKyCrdtVoid.crdtVoid.amt > 0) {
      if (!isDebugWin) {
        // お釣り返す
        await Future.delayed(const Duration(milliseconds: 500));
        debugPrint("***** call ifAcxChangeOut");
        changerRet = await AcxCoin.ifAcxChangeOut(
            TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL,
            RcKyCrdtVoid.crdtVoid.amt);
        debugPrint("***** call ifAcxChangeOut = $changerRet");
      }
    }

    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "RckyCashVoid.rcKeyVoidDemo(): rxMemRead(RXMEM_STAT) error");
      mem.tTtllog.t100001Sts.itemlogCnt = 0;
      return false;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    String voidDate = RcKyCrdtVoid.crdtVoid.date.replaceAll('-','');
    debugPrint('***** callSerialNumberCorrectionAPI');
    await RckyRfdopr.callSerialNumberCorrectionAPI();
    // 通番手製終了時にitemlogCntをリセットする。
    mem.tTtllog.t100001Sts.itemlogCnt = 0;
    return true;
  }
}