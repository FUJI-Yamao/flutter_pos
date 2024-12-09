/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/regs/checker/rc_mbr_com.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import 'rcsyschk.dart';

class RckyTaxFreeIn {

  /// 免税処理実行チェック関数
  /// 引数：なし
  /// 戻値：0:免税処理しない 1:免税処理する
  /// 関連tprxソース: rcky_taxfreein.c - rc_TaxFree_Chk_TaxFreeIn
  static Future<int> rcTaxFreeChkTaxFreeIn() async {
    if (await RcSysChk.rcsyschkTaxfreeSystem() == 0) /* 免税仕様承認キーが無効 */ {
      return 0;
    }
    RegsMem mem = RegsMem();
    if (mem.tTtllog.t109000Sts.taxfreeFlg == 0) /* 免税宣言フラグが無効 */ {
      return 0;
    }
    return 1;
  }

  /// 免税宣言仕様設定チェック関数
  /// 引数：なし
  /// 戻値：0=上記仕様でない　 1=上記仕様
  /// 関連tprxソース: rcky_taxfreein.c - rc_TaxFree_Chk_TaxFreeIn_System
  static int rcTaxFreeChkTaxFreeInSystem() {
    // TODO:10125 通番訂正 202404実装対象外
    /*
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (RcSysChk.rcsyschkTaxfreeSystem() == 0) {
      // 免税仕様承認キーが無効
      return 0;
    }

    if (cBuf.iniMacInfo.tax_free_keyuse != 0) {
      // スペック「免税キー利用」が「する」（旧仕様を利用）
      return 0;
    }

    return 1;
     */
    return 0;
  }

  /// 免税取引確定後、登録禁止状態かチェックする
  /// 戻値: false=登録禁止でない　 true=登録禁止
  /// 関連tprxソース: rcky_taxfreein.c - TaxFree_Chg_Chk
  static Future<bool> taxFreeChgChk() async {
    if (RcFncChk.rcCheckRegistration() &&
        (await rcTaxFreeChkTaxFreeIn() != 0)) {
      return true;
    }
    return false;
  }

  /// 機能概要　：訂正・返品時の免税宣言フラグをセットする
  /// パラメータ：なし
  /// 戻り値　　：なし
  /// 関連tprxソース: rcky_taxfreein.c - rcTaxFree_Restore_TaxFreeFlg
  static void rcTaxFreeRestoreTaxFreeFlg() {
    RegsMem mem = SystemFunc.readRegsMem();
    int i;
    int csm = 0;
    int gnrl = 0;

    // 登録されている商品で、どの免税区分が免税扱いになっているか確認
    for (i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      if (rcTaxFreeChkTaxFreeNum(
          mem.tItemLog[i].t10000.taxCd, mem.tItemLog[i].t10000.taxTyp) != 0) {
        if (mem.tItemLog[i].t10000Sts.taxfreeTaxExemptionFlg == 1) {
          csm = 1;
        } else if (mem.tItemLog[i].t10000Sts.taxfreeTaxExemptionFlg == 2) {
          gnrl = 1;
        }
      }
    }

    // 各免税区分が免税扱いになっているかどうかで免税宣言フラグを決定
    if ((csm == 1) && (gnrl == 1)) {
      // どちらも免税扱い
      mem.tTtllog.t109000Sts.taxfreeFlg = 1;
    } else if ((csm == 1) && (gnrl == 0)) {
      // 消耗品のみ免税扱い
      mem.tTtllog.t109000Sts.taxfreeFlg = 2;
    } else if ((csm == 0) && (gnrl == 1)) {
      // 一般品のみ免税扱い
      mem.tTtllog.t109000Sts.taxfreeFlg = 3;
    }
    return;
  }

  /// 機能：免税用税No.比較関数
  /// 引数：int tax_cd	税No.
  ///    ：int tax_typ	税種
  /// 戻値：0:免税用税No.ではない 1:免税用税No.である
  /// 関連tprxソース: rcky_taxfreein.c - rc_TaxFree_Chk_TaxFreeNum
  static int rcTaxFreeChkTaxFreeNum(int taxCd, int taxTyp) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    if ((taxCd == pCom.dbTrm.taxfreeTaxNum) && (taxTyp == 10)) {
      return (1);
    }
    return (0);
  }

  /// 免税商品変更したかチェック
  /// 戻り値：　0:変更なし　１：変更あり*/
  ///  関連tprxソース: rcky_taxfreein.c - rc_TaxFree_GoodChg_Chk
  static Future<int> rcTaxFreeGoodChgChk() async {
    String log = "";
    int mbrFlg = 0;
    int mbrChk = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if(rcTaxFreeChkTaxFreeInSystem() == 0) {
      return (0);
    }

    mbrChk = cBuf.dbTrm.mbrTaxFree;
    if ((await RcMbrCom.rcmbrChkStat() != 0) && (mbrChk != 0))	//会員免税の設定は禁止or確認の場合会員状態チェックする
    {
      if (RcMbrCom.rcmbrChkCust())
      {
        if(mbrChk == 1)
        {
          TprLog().logAdd(0, LogLevelDefine.error, "rcTaxFreeGoodChgChk: mbr forbid return");
          return (DlgConfirmMsgKind.MSG_TAXFREE_MBR_ERR.dlgId);
        }
        mbrFlg = 1;
      }
      if(RegsMem().tTtllog.calcData.taxfreeBk!.mbrStsBk != mbrFlg)
      {
        TprLog().logAdd(0, LogLevelDefine.error, "rcTaxFreeGoodChgChk: mbr_stats[${RegsMem().tTtllog.calcData.taxfreeBk?.mbrStsBk}][${mbrFlg}]");
        return (DlgConfirmMsgKind.MSG_TAXFREE_CONF_AGAIN.dlgId);
      }
    }
    if((RegsMem().tTtllog.calcData.taxfreeBk!.qtyBk != RegsMem().tTtllog.t100001Sts.itemlogCnt)		||
       (RegsMem().tTtllog.calcData.taxfreeBk!.conAmtBk != rcTaxFreeSumTaxFreeAmtEachFlg(1))	||
       (RegsMem().tTtllog.calcData.taxfreeBk!.genAmtBk != rcTaxFreeSumTaxFreeAmtEachFlg(2)))
    {
      log = "rcTaxFreeGoodChgChk: "
            "qty[${RegsMem().tTtllog.calcData.taxfreeBk!.qtyBk}]"
               "[${RegsMem().tTtllog.t100001Sts.itemlogCnt}]"
            " con_amt[${RegsMem().tTtllog.calcData.taxfreeBk!.conAmtBk}]"
               "[${rcTaxFreeSumTaxFreeAmtEachFlg(1)}]"
            " gen_amt[${RegsMem().tTtllog.calcData.taxfreeBk!.genAmtBk}]"
               "[${rcTaxFreeSumTaxFreeAmtEachFlg(2)}]";
      TprLog().logAdd(0, LogLevelDefine.error, log);
      return (DlgConfirmMsgKind.MSG_TAXFREE_CONF_AGAIN.dlgId);
    }
    return(0);
  }

  /// TODO:定義のみ追加
  /// 関数：rc_TaxFree_Sum_TaxFreeAmt_each_flg()
  /// 機能：免税対象額算出関数
  /// 引数：short exemption_flg 合計を算出する免税フラグの種類 1:消耗品 2:一般
  /// 戻値：免税対象額
  ///  関連tprxソース: rcky_taxfreein.c - rc_TaxFree_Sum_TaxFreeAmt_each_flg
  static int rcTaxFreeSumTaxFreeAmtEachFlg(int exemption_flg)
  {
    int amt = 0;
    // for(int i=0; i < RegsMem().tTtllog.t100001Sts.itemlogCnt; i++)
    // {
    //   if((rc_TaxFree_Chk_TaxFreeNum(RegsMem().tItemLog[i].t10000.taxCd, RegsMem().tItemLog[i].t10000.taxTyp))	/* 免税商品確認 */
    //       && (! rcChk_ItmRBuf_ScrVoid(i)))	/* 画面訂正されていない場合 */
    //   {
    //     if(RegsMem().tTtllog.t100001Sts.taxfree_tax_exemption_flg == exemption_flg)	/* 指定した免税フラグと同じ */
    //     {
    //       amt += MEM->tItemlog[i].t10000.no_tabl;		/* 合計に加算 */
    //     }
    //   }
    // }
    return (amt);
  }


}