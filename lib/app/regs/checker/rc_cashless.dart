/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_regs.dart';

class RcCashless {

  static CashlessData clData = CashlessData();
  static CashlessData clDataSave = CashlessData();


  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rc_cashless.c - rc_cashless_key_chk
  static int rcCashlessKeyChk (int fncCd) {
    return 0;
  }
  /// 関連tprxソース:rc_cashless.c - rc_cashless_mem_init
  static Future<void> rcCashlessMemInit () async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "[CASHLESS]rc_cashless_mem_init()");
    clData = CashlessData();
    if(RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem != 0){
      RegsMem().tTtllog.t100002Sts.cashlessOffFlg = RegsMem().tTtllog.t100002Sts.cashlessOffFlg % 10;
    }

  }

  /// 関連tprxソース:rc_cashless.c - rc_cashless_all_init
  static Future<void> rcCashlessAllInit () async {
    await rcCashlessMemInit();
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "[CASHLESS]rcCashlessAllInit()");
    clDataSave = CashlessData();
  }

  /// 機能：スプリット取消時に、還元選択状態をクリアする
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース:rc_cashless.c - rc_cashless_sprit_cncl
  static Future<void> rcCashlessSpritCncl() async {
    if(rcCashlessChk() == 0 ){
      return;
    }

    int cashlessOffFlg = RegsMem().tTtllog.t100002Sts.cashlessOffFlg % 10;	// 還元なしキー状態
    String erlog = "[CASHLESS]rc_cashless_sprit_cncl() cashless_off_flg[${RegsMem().tTtllog.t100002Sts.cashlessOffFlg}]->[$cashlessOffFlg]\n";

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, erlog);

    RegsMem().tTtllog.t100002Sts.cashlessOffFlg = 0;
    RegsMem().tTtllog.t100002Sts.cashlessOffFlg = cashlessOffFlg;

    return;
  }

  /// 機能：キャッシュレス還元仕様の有効/無効判定
  /// 引数：なし
  /// 戻値：0:無効 1:有効
  /// 関連tprxソース:rc_cashless.c - rc_cashless_chk
  static int rcCashlessChk(){
    if (RcSysChk.rcsyschkVescaSystem()){
      if((RegsMem().tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_REG)
          || (RegsMem().tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID)
          || (RegsMem().tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_TRAINING)){
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if(xRet.isInvalid()){
          return 0;
        }
        RxCommonBuf pCom = xRet.object;
        return pCom.clRestFlg;
      }
    }
    return 0;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 機能：キャッシュレス還元のc_data_logへのセット
  /// 引数：なし
  /// 戻値：なし
  /// 関連tprxソース:rc_cashless.c - rc_cashless_data( short item_cnt )
  static void rcCashlessData(int itemCnt){}
}
///  関連tprxソース: rc_cashless.c - CASHLESS_DATA
class CashlessData {
  int clDlg = 0; //  キャッシュレス還元の確認メッセージ表示 0:非表示 1:表示中
  int clStep = 0; //  キャッシュレス還元の動作中処理ステップ 0:未動作 1:消費者還元 2:還元後額での会計処理
  int clSelect = 0; //  キャッシュレス還元の「還元/還元しない」 0:未選択 1:還元 2:還元しない
  int svFncCd = 0; //  キャッシュレス還元の保存した会計キー
  int clBfAmt = 0; //  キャッシュレス還元の還元前額
  int clRefAmt = 0; //  キャッシュレス還元の還元額
  int clAfAmt = 0; //  キャッシュレス還元の還元後額
  int repicaBalance = 0; //  レピカの残高
  String  saveEntry = ""; //  置数の保存
  int autoRestSus = 0; //  先入金の自動仮締め呼出 OFF:手動 ON:自動
  SptendSave saveSptend = SptendSave();

}
///  関連tprxソース: rc_cashless.c - SPTEND_SAVE
class SptendSave {
  int saveFncCd = 0;
  int sptendCnt = 0;
  T100100 t100100 = T100100();

}
