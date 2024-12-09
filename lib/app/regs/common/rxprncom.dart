/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_calc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/mcd.dart';
import '../../lib/apllib/recog.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_tpoint.dart';

/// 関連tprxソース: rxprncom.c
class RxPrnCom {

  // TODO:SWが無効になっている
  // #if FSP_CLSMULTI
  // extern long rpGet_ClassPrgPer(c_itemlog *Ilog_buf)
  // {
  // long Amt;
  //
  // if(cm_coopAIZU_system())
  // {
  // switch(Ilog_buf->t11100Sts.fsp_lvl)
  // {
  // case LEVEL_D     :
  // Amt = Ilog_buf->umul_prg_dpdsc_per;
  // break;
  // case LEVEL_C     :
  // Amt = Ilog_buf->umul_prg_cpdsc_per;
  // break;
  // case LEVEL_B     :
  // Amt = Ilog_buf->umul_prg_bpdsc_per;
  // break;
  // case LEVEL_A     :
  // Amt = Ilog_buf->umul_prg_apdsc_per;
  // break;
  // case LEVEL_S     :
  // Amt = Ilog_buf->umul_prg_spdsc_per;
  // break;
  // default          :
  // Amt = 0;
  // break;
  // }
  // }
  // else
  // {
  // switch(MEM->tTtllog.t100700.fsp_lvl)
  // {
  // case LEVEL_OTHER :
  // if (Ilog_buf->t10500.cls_dsc_flg > NORMAL_CLS_LIMIT)
  // Amt = Ilog_buf->t10500Sts.uc_mprg_pdsc_per;
  // else
  // Amt = Ilog_buf->t10500Sts.ucls_prg_pdsc_per;
  // break;
  // case LEVEL_D     :
  // Amt = Ilog_buf->umul_prg_dpdsc_per;
  // break;
  // case LEVEL_C     :
  // Amt = Ilog_buf->umul_prg_cpdsc_per;
  // break;
  // case LEVEL_B     :
  // Amt = Ilog_buf->umul_prg_bpdsc_per;
  // break;
  // case LEVEL_A     :
  // Amt = Ilog_buf->umul_prg_apdsc_per;
  // break;
  // case LEVEL_S     :
  // Amt = Ilog_buf->umul_prg_spdsc_per;
  // break;
  // default          :
  // Amt = 0;
  // break;
  // }
  // }
  // return(Amt);
  // }
  //
  // extern long rpGet_ClassPrgDsc(c_itemlog *Ilog_buf)
  // {
  // long Amt;
  //
  // if(cm_coopAIZU_system())
  // {
  // switch(Ilog_buf->t11100Sts.fsp_lvl)
  // {
  // case LEVEL_D     :
  // Amt = Ilog_buf->umul_prg_sdsc_amt;
  // break;
  // case LEVEL_C     :
  // Amt = Ilog_buf->umul_prg_cdsc_amt;
  // break;
  // case LEVEL_B     :
  // Amt = Ilog_buf->umul_prg_bdsc_amt;
  // break;
  // case LEVEL_A     :
  // Amt = Ilog_buf->umul_prg_adsc_amt;
  // break;
  // case LEVEL_S     :
  // Amt = Ilog_buf->umul_prg_sdsc_amt;
  // break;
  // default          :
  // Amt = 0;
  // break;
  // }
  // }
  // else
  // {
  // switch(MEM->tTtllog.t100700.fsp_lvl)
  // {
  // case LEVEL_OTHER :
  // if (Ilog_buf->t10500.cls_dsc_flg > NORMAL_CLS_LIMIT)
  // Amt = Ilog_buf->t10500Sts.uc_mprg_dsc_amt;
  // else
  // Amt = Ilog_buf->t10500Sts.ucls_prg_dsc_amt;
  // break;
  // case LEVEL_D     :
  // Amt = Ilog_buf->umul_prg_sdsc_amt;
  // break;
  // case LEVEL_C     :
  // Amt = Ilog_buf->umul_prg_cdsc_amt;
  // break;
  // case LEVEL_B     :
  // Amt = Ilog_buf->umul_prg_bdsc_amt;
  // break;
  // case LEVEL_A     :
  // Amt = Ilog_buf->umul_prg_adsc_amt;
  // break;
  // case LEVEL_S     :
  // Amt = Ilog_buf->umul_prg_sdsc_amt;
  // break;
  // default          :
  // Amt = 0;
  // break;
  // }
  // }
  // return(Amt);
  // }
  // #endif

  ///	機能：商品名の左に税タイプと税率, および, 売価の右に設定イメージを印字するかチェック
  /// 引数：int typ
  ///	戻値：0: 違う   1: する
  /// 関連tprxソース: rxprncom.c - rx_Chk_Print_RFM_Detail()
  bool rxChkPrintRFMDetail(int typ) {
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if (typ == 1) {
      if ((cBuf.dbTrm.issueNotePrn == 2) ||
          (cBuf.dbTrm.issueNotePrn == 3) ||
          (cBuf.dbTrm.issueNotePrn == 4)) {
        return (true);
      }
    } else {
      if ((mem.tHeader.prn_typ == PrnterControlTypeIdx.TYPE_ERCTFM.index) &&
          ((cBuf.dbTrm.issueNotePrn == 3) || (cBuf.dbTrm.issueNotePrn == 4))) {
        return (true);
      }
    }
    return (false);
  }

  ///	機能：商品名の左に税タイプと税率, および, 売価の右に設定イメージを印字するかチェック
  /// 引数：なし
  ///	戻値：0: 違う   1: する
  /// 関連tprxソース: rxprncom.c - rx_common_Chk_Name_Left_TaxType_Per()
  int rxCommonChkNameLeftTaxTypePer() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if ((cBuf.dbTrm.taxMarkPrn == 4) &&
        (cBuf.dbTrm.intaxMarkPrn == 4) &&
        (cBuf.dbTrm.notaxMarkPrn == 4)) {
      return (1);
    }
    return (0);
  }

  ///	機能：商品名の左に設定したイメージを印字するかチェック
  /// 引数：なし
  ///	戻値：0: しない   1: する
  /// 関連tprxソース: rxprncom.c - rx_common_Chk_Name_Left_Tax_Image()
  int rxCommonChkNameLeftTaxImage() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if ((cBuf.dbTrm.taxMarkPrn == 5) &&
        (cBuf.dbTrm.intaxMarkPrn == 5) &&
        (cBuf.dbTrm.notaxMarkPrn == 5)) {
      return (1);
    }
    return (0);
  }

  ///	機能：売価の右に設定したイメージを印字するかチェック
  /// 引数：なし
  ///	戻値：0: しない   1: する
  /// 関連tprxソース: rxprncom.c - rx_common_Chk_Prc_Right_Tax_Image()
  int rxCommonChkPrcRightTaxImage() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if ((cBuf.dbTrm.taxMarkPrn == 6) &&
        (cBuf.dbTrm.intaxMarkPrn == 6) &&
        (cBuf.dbTrm.notaxMarkPrn == 6)) {
      return (1);
    }
    return (0);
  }

  ///	機能：軽減税率仕様での動作かチェック
  /// 引数：なし
  ///	戻値：0: 違う   1: 軽減税率仕様
  /// 関連tprxソース: rxprncom.c - rx_common_Chk_System_ReducedTaxRate()
  int rxCommonChkSystemReducedTaxRate() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    if ((rxCommonChkNameLeftTaxTypePer() != 0) ||
        (rxCommonChkNameLeftTaxImage() != 0) ||
        (rxCommonChkPrcRightTaxImage() != 0)) {
      return (1);
    }
    return (0);
  }

  ///	機能：小計下の税コード別税情報印字するかチェック
  /// 引数：なし
  ///	戻値：0: する 1: しない
  /// 関連tprxソース: rxprncom.c - rx_common_Chk_StlTaxInfo()
  int rxCommonChkStlTaxInfo() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    return (cBuf.dbTrm.stlTaxinfoPrn);
  }
}