/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/trm_list.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import 'rc_mbr_com.dart';
import 'rc_reserv.dart';
import 'rc_suica_com.dart';
import 'rcfncchk.dart';
import 'rcmbrflrd.dart';
import 'rcsyschk.dart';

class RcMbrPoiCal {
  static const WIZRDCD = "999999";

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 本日対象ポイントを算出する。
  /// 関連tprxソース:C:rcmbrpoical.c - rcmbr_TodayPoint()
  /// 引数   : なし
  /// 戻り値 : 0:しない,
  static void rcmbrTodayPoint(int caltyp){
    return;
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 不要なアカウント実績やプロモーション実績を除去する(利用した実績のみにする)
  /// また, アカウントポイントの案分を行う(アイテム情報に振り分ける)
  /// また, 残権利数印字のための情報を作成する(実績除去前に作成)
  /// 関連tprxソース:C:rcmbrpoical.c - rcmbr_Tran_OneToOnePromotion
  static void rcmbrTranOneToOnePromotion(){}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 不要なスタンプカード実績を除去する
  /// 関連tprxソース:C:rcmbrpoical.c - rcmbr_Tran_StpCard
  static void rcmbrTranStpCard(){}

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcmbrpoical.c - rcmbr_PTtlSet()
  static void rcmbrPTtlSet() {
    return ;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcmbrpoical.c - rcmbr_ws_saleamtZERO_PReSet()
  static void rcmbrWsSaleAmtZEROPReSet(TTtlLog tTtlLog) {
    return ;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース:C:rcmbrpoical.c - rcStlMbrSrvDsp
  static void rcStlMbrSrvDsp() {}


  /// アカウント別の利用実績をセット
  /// 関連tprxソース: :rcmbrpoical.c - rcmbr_Set_UseAccountData
  static Future<void> rcmbrSetUseAccountData() async {
    if (!(await RcSysChk.rcChkOneToOnePromSystem())) {
      return;
    }

    // 固定アカウントへのセット
    RegsMem mem = SystemFunc.readRegsMem();
    for (int i = 0; i < mem.tTtllog.t100001Sts.acntCnt; i++) {
      mem.tTtllog.t107000[i].duttlAcntPnt = 0;
      if (mem.tTtllog.t107000[i].acntId ==
          AcctFixCodeList.ACCT_CODE_TODAY_PNT.value) {
        mem.tTtllog.t107000[i].duttlAcntPnt =
            mem.tTtllog.t100701.duptTtlrv; // 本日利用ポイント(割戻+チケット)
      }
    }
  }

  /// トータルログに本日ポイント割増倍率をセットする
  /// 引数:[cust] 顧客情報バッファ
  /// 引数:[ttllog] トータルログバッファ
  /// 戻り値: 割増倍率
  /// 関連tprxソース:rcmbrpoical.c - Set_poiaddper()
  static Future<double> setPoiAddPer(CustData cust, TTtlLog ttllog) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    double per = 0;
    if ((await RcFncChk.rcCheckESVoidSMode()) ||
        (await RcFncChk.rcCheckESVoidIMode())) {
      per = ttllog.t100700Sts.pointAddPer;
      if (await CmCksys.cmZHQSystem() != 0) {
        if (per == 0) {
          per = 1;
        }
      } else {
        // 倍率0のままとする
        // if (per == 0) per = 1;
      }
      return per;
    }
    if (CompileFlag.RESERV_SYSTEM) {
      if (await RcReserv.rcReservNotUpdate()) {
        per = ttllog.t100700Sts.pointAddPer;
        if (await CmCksys.cmZHQSystem() != 0) {
          if (per == 0) {
            per = 1;
          }
        } else {
          // 倍率0のままとする
        }
        return per;
      }
      if (await RcSysChk.rcChkBdlStmPrgRdSystem()) {
        per = ttllog.t100700Sts.pointAddPer;
        if (await CmCksys.cmZHQSystem() != 0) {
          if (per == 0) {
            per = 1;
          }
        } else {
          // 倍率0のままとする
        }
        return per;
      }
    }

    double wizPer = 0;
    if (await CmCksys.cmZHQSystem() == 0) {
      wizPer = -1;
    }
    if ((cBuf.dbTrm.useBiggerRecommendPoint == 0) &&
        (ttllog.t100001.mobilePosNo == WIZRDCD)) {
      wizPer = cBuf.dbTrm.rwtSpRbtPer;
    }

    int tmpInt = 0;
    PPromschMst svsPmbr = PPromschMst();
    /* 顧客ターミナル／サービス分類マスタ／顧客マスタのうち、最大値の倍率を算出 */
    if (cust.cust.cust_no!.isNotEmpty) {
      if (CompileFlag.FSP_POINTPER) {
        // TODO:10153 コンパイルスイッチ（FSP_POINTPER）
        /*
        if (await RcSysChk.rcChkMbrMultiPointPer(RcMbrFsp.POINT_CALC)) { /* Fsp Point Percent Add */
          per = rcmbr_Get_FspAddPer(ttllog.t100700.fspLvl, cBuf.dbTrm);
          if (per == -1) {
            per = cBuf.dbTrm.anyprcTermAddMagn;
          }
          if (await CmCksys.cmDcmpointSystem() != 0) {
            per = Set_dcm_poiaddper();
          }
        } else { /* Normal Point */
          if (await CmCksys.cmDcmpointSystem() != 0){
            per = Set_dcm_poiaddper();
          } else {
            per = rcmbr_Get_PointAddMagn(TRMNO_BUY_POINT_ADD_MAGN);
          }
        }
         */
      } else {
        per = RcMbrCom.rcmbrGetPointAddMagn(TrmCdList.TRMNO_BUY_POINT_ADD_MAGN.trmCd);
      }
      if ((await CmCksys.cmPanaMemberSystem() != 0) &&
          (ttllog.t100700.otherStoreMbr == 1)) {
        /* パナコード顧客ポイント仕様 && 他店会員 */
        (tmpInt, svsPmbr) = await RcMbrFlrd.rcmbrReadCustSvsCustNo(cust.cust.cust_no);
        if (tmpInt != 0) {
          svsPmbr.point_add_magn = 1;
        }
        if (per < svsPmbr.point_add_magn!) {
          per = svsPmbr.point_add_magn!;
        }
      } else {
        if (await CmCksys.cmZHQSystem() != 0) {
          if (per < cust.svsCls.point_add_magn!) {
            per = cust.svsCls.point_add_magn!;
          }
        } else {
          if (ttllog.t102501.svsClsSchCd != 0) {
            if (per < cust.svsCls.point_add_magn!) {
              per = cust.svsCls.point_add_magn!;
            }
          }
        }
      }
      if (CompileFlag.MC_SYSTEM) {
        // TODO:10108 コンパイルスイッチ(MC_SYSTEM)
        /*
        if (cBuf.dbTrm.userCd9 & 64 != 0) {
          if ((ttllog.t100700.mbrInput == MbrInputType.mcardInput.index) &&
              (per < atSing.mcTbl.pntRate)) {
            per = (double)(atSing.mcTbl.pntRate);
          }
          if ((RcSysChk.rcChkMcIzumiSystem()) &&
              ((ttllog.t100700.mbrInput == MbrInputType.magcardInput.index) ||
                  (ttllog.t100700.mbrInput == MbrInputType.cardKeyInput.index)) &&
              (per < cBuf.dbMcSpec.cardCashTimes)) {
            per = (double)(cBuf.dbMcSpec.cardCashTimes);
          }
        } else {
          if ((ttllog.t100700.mbrInput == MbrInputType.magcardInput.index) &&
            (atSing.mcTbl.pntRate > 0)) {
            per = (double)(atSing.mcTbl.pntRate);
          }
          if ((RcSysChk.rcChkMcIzumiSystem()) &&
              ((ttllog.t100700.mbrInput == MbrInputType.magcardInput.index) ||
                  (ttllog.t100700.mbrInput == MbrInputType.cardKeyInput.index)) &&
              (cBuf.dbMcSpec.cardCashTimes > 0)) {
            per = (double)(cBuf.dbMcSpec.cardCashTimes);
          }
        }
         */
      }
      if (wizPer > per) {
        per = wizPer;
      }
      if (await CmCksys.cmZHQSystem() != 0) {
        if (per == 0) {
          per = 1;
        }
      } else {
        if (per < 0) {
          per = 1;
        }
      }
      ttllog.t100700Sts.pointAddPer = per;
    } else if ((cBuf.dbTrm.nonMbrPntPrn == 1) ||
        (CompileFlag.ARCS_MBR && RcSysChk.rcChkRalseCardSystem()) ||
        (await RcSuicaCom.rcNimocaPointData()) ||
        (cBuf.dbTrm.rcprateSel == 1)) {
      if (CompileFlag.FSP_POINTPER) {
        // TODO:10153 コンパイルスイッチ（FSP_POINTPER）
        /*
        if (await RcSysChk.rcChkMbrMultiPointPer(RcMbrFsp.POINT_CALC)) {
          /* Fsp Point Percent Add */
          per = rcmbr_Get_FspAddPer(ttllog.t100700.fspLvl, cBuf.dbTrm);
          if (per == -1) {
            per = cBuf.dbTrm.anyprcTermAddMagn;
          }
          if (await CmCksys.cmDcmpointSystem() != 0) {
            per = Set_dcm_poiaddper();
          }
        } else {
          /* Normal Point */
          if (await CmCksys.cmDcmpointSystem() != 0) {
            per = Set_dcm_poiaddper();
          } else {
            per = await RcMbrCom.rcmbrGetPointAddMagn(TrmCdList.TRMNO_BUY_POINT_ADD_MAGN.trmCd);
          }
        }
         */
      } else {
        per = await RcMbrCom.rcmbrGetPointAddMagn(TrmCdList.TRMNO_BUY_POINT_ADD_MAGN.trmCd);
      }
      if ((per < ttllog.t100700Sts.pointAddPer) ||
          ((cBuf.dbTrm.rcprateSel == 1) &&
              (per != ttllog.t100700Sts.pointAddPer) &&
              (cMem.stat.fncCode == FuncKey.KY_RPR.keyId))) {
        per = ttllog.t100700Sts.pointAddPer;
      }
      if ((await CmCksys.cmPanaMemberSystem() != 0) &&
          (ttllog.t100700.otherStoreMbr == 1)) {
        /* パナコード顧客ポイント仕様 && 他店会員 */
        (tmpInt, svsPmbr) = await RcMbrFlrd.rcmbrReadCustSvsCustNo(cust.cust.cust_no);
        if (tmpInt != 0) {
          svsPmbr.point_add_magn = 1;
        }
        if (per < svsPmbr.point_add_magn!) {
          per = svsPmbr.point_add_magn!;
        }
      } else {
        if (await CmCksys.cmZHQSystem() != 0) {
          if (per < cust.svsCls.point_add_magn!) {
            per = cust.svsCls.point_add_magn!;
          }
        } else {
          if (ttllog.t102501.svsClsSchCd != 0) {
            if (per < cust.svsCls.point_add_magn!) {
              per = cust.svsCls.point_add_magn!;
            }
          }
        }
      }
      if (CompileFlag.MC_SYSTEM) {
        // TODO:10108 コンパイルスイッチ(MC_SYSTEM)
        /*
        if ((cBuf.dbTrm.userCd9 & 64) != 0) {
          if ((ttllog.t100700.mbrInput == MbrInputType.mcardInput.index) &&
              (per < atSing.mcTbl.pntRate)) {
            per = (double)(atSing.mcTbl.pntRate);
          }
          if ((RcSysChk.rcChkMcIzumiSystem()) &&
              ((ttllog.t100700.mbrInput == MbrInputType.magcardInput.index) ||
                  (ttllog.t100700.mbrInput == MbrInputType.cardKeyInput.index)) &&
              (per < cBuf.dbMcSpec.cardCashTimes)) {
            per = (double)(cBuf.dbMcSpec.cardCashTimes);
          }
        } else {
          if ((ttllog.t100700.mbrInput == MbrInputType.magcardInput.index) &&
              (atSing.mcTbl.pntRate > 0)) {
            per = (double)(atSing.mcTbl.pntRate);
          }
          if ((RcSysChk.rcChkMcIzumiSystem()) &&
              ((ttllog.t100700.mbrInput == MbrInputType.magcardInput.index) ||
                  (ttllog.t100700.mbrInput == MbrInputType.cardKeyInput.index)) &&
              (cBuf.dbMcSpec.cardCashTimes > 0)) {
            per = (double)(cBuf.dbMcSpec.cardCashTimes);
          }
        }
         */
      }
      if (wizPer > per) {
        per = wizPer;
      }
      if (await CmCksys.cmZHQSystem() != 0) {
        if (per == 0) {
          per = 1;
        }
      } else {
        // 倍率0のままとする
      }
      ttllog.t100700Sts.pointAddPer = per;
    } else {
      per = ttllog.t100700Sts.pointAddPer;
      if (wizPer > per) {
        per = wizPer;
      }
      if (await CmCksys.cmZHQSystem() != 0) {
        if (per == 0) {
          per = 1;
        }
      } else {
        // 倍率0のままとする
      }
    }

    return per;
  }
}
