/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxkoptcmncom.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import 'rc_mbr_com.dart';
import 'rc_reserv.dart';
import 'rc_stl.dart';
import 'rckydisburse.dart';
import 'rcmbrpauto.dart';
import 'rcmbrpcom.dart';
import 'rcmbrpoical.dart';
import 'rcsyschk.dart';

class RcMbrPttlSet {

  /// トータルログにポイント関連項目をセットする
  /// 関連tprxソース: rcmbrpttlset.c - rcmbr_PTtlSet
  static Future<void> rcmbrPTtlSet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    TTtlLog ttllog = mem.tTtllog;

    /* 顧客ポイント仕様かチェック */
    if ((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT == 0) {
      return;
    }
    /* 顧客が選択されているかチェック */
    if (RcMbrCom.rcmbrChkCust() == 0) {
      return;
    }
    if (CompileFlag.IWAI &&
        ((await RcSysChk.rcChkORCSystem()) ||
            (await RcSysChk.rcChkIWAIRealSystem()))) {
      ttllog.t100701.duptTtlrv = ttllog.t100200[AmtKind.amtCha4.index].amt;
    }
    if (RcMbrPcom.rcmbrGetManualRbtKeyCd() != 0) {
      await RcMbrPcom.rcmbrPTtlSetUsePoint(
          (await Rxmbrcom.rcmbrGetSvsMthd(pCom, mem)),
          RcMbrPcom.rcmbrManualRbtCashPoint(), ttllog);
    }

    /* 即時割戻の今回本日ポイント扱い区分:有効 で サービス方法:即時チケット時、自動割戻(チケット)再算出　*/
    if ((pCom.dbTrm.nwRvtPointTyp != 0) &&
        (await Rxmbrcom.rcmbrGetSvsMthd(pCom, mem) == 5)) {
      await RcMbrPAuto.rcmbrPTtlSetAutoRbt();
    } else if (CompileFlag.MC_SYSTEM) {
      // TODO:10108 コンパイルスイッチ(MC_SYSTEM)
      /*
      AtSingl atSing = SystemFunc.readAtSingl();
      if (RcSysChk.rcChkMcSystem() &&
          (ttllog.t100700.mbrInput == MbrInputType.mcardInput.index) &&
          (atSing.mcTbl.tcktFlg)) {
        await RcMbrPAuto.rcmbrPTtlSetAutoRbt( );
      }
       */
    }

    /* 本日対象額印字セット */
    setdMspurPrn(ttllog);
    /* 本日ポイント印字セット */
    setdMsPointPrn(ttllog);
    /* 累計ポイント印字セット */
    settMsPointPrn(ttllog);
    /* 可能ポイント印字セット */
    settMspPointPrn(ttllog);
    /* 即時割戻音出力をセット */
    setSerPointSound(ttllog);
    /* 累計ポイント */
    await setTpntTtlsvr(ttllog);
    /* 累計可能ポイント */
    await setTpptTtlsrv(ttllog);
    /* 次回予定割戻ポイントセット */
    await setNextTtlsrv(ttllog);
    /* 本日チケット回収情報セット */
    await setTicketCollect(ttllog);
    /* 本日ポイント割増倍率セット */
    await RcMbrPoiCal.setPoiAddPer(cMem.custData, ttllog);
    if (CompileFlag.VISMAC) {
      /* ビスマック関連のデータセット */
      if (await RcSysChk.rcChkVMCSystem()) {
        setVismacData(ttllog);
      }
    }
    if (CompileFlag.SAPPORO) {
      /* サッポロパナコードのデータセット */
      if ((await RcSysChk.rcChkSapporoPanaSystem()) ||
          (await RcSysChk.rcChkJklPanaSystem())) {
        setSapporoPanaData(ttllog);
      }
      if (await CmCksys.cmRainbowCardSystem() != 0) {
        setRainbowPanaData(ttllog);
      }
    }
    if ((await RcSysChk.rcChkNW7System()) && !(pCom.dbTrm.nw7mbrReal != 0)) {
      setNW7StreCode(ttllog);
    }
    if ((await CmCksys.cmDcmpointSystem() != 0) &&
        (ttllog.t100700.mbrInput != MbrInputType.mcp200Input.index) &&
        (ttllog.t100701.dtipTtlsrv != 0) &&
        (ttllog.t100700Sts.promCd3 == 0)) {
      setLprTicketBarTrn(ttllog);
    }
    if (RcSysChk.rcChkCustrealWebserSystem()) {
      setWebRealData(ttllog);
    }
    if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
      await setWebRealUIDData(ttllog);
    }
    if (RcSysChk.rcChkCustrealOPSystem()) {
      setWebRealOPData(ttllog);
    }

    if (await CmCksys.cmYunaitoHdSystem() != 0) {
      mem.tTtllog.t100017.lastTotalPoint = mem.tTtllog.t100700.lpntTtlsrv;
      mem.tTtllog.t100017.todayPoint = mem.tTtllog.t100700.dpntTtlsrv;
      mem.tTtllog.t100017.totalPoint = mem.tTtllog.t100700.tpntTtlsrv;
      if (await CmCksys.cmSm55TakayanagiSystem() != 0) {
        if (mem.tTtllog.t100017.totalPoint < 0) {
          mem.tTtllog.t100017.todayPoint =
              mem.tTtllog.t100017.todayPoint - mem.tTtllog.t100017.totalPoint;
          mem.tTtllog.t100700.dpntTtlsrv = mem.tTtllog.t100017.todayPoint;
          for (int i = 0; i < mem.tTtllog.t100001Sts.acntCnt; i++) {
            if (((mem.tTtllog.t107000[i].acntId ==
                AcctFixCodeList.ACCT_CODE_TODAY_PNT.value) ||
                (mem.tTtllog.t107000[i].acntId ==
                    AcctFixCodeList.ACCT_CODE_BASIC_PNT.value)) &&
                (mem.tTtllog.t107000Sts[i].acntTyp ==
                    AcctAddTypeList.ACCT_ADD_TYPE_PNT.index)) {
              mem.tTtllog.t107000[i].acntPnt = mem.tTtllog.t107000[i].acntPnt -
                  mem.tTtllog.t100017.totalPoint;
            }
          }
          mem.tTtllog.t100017.totalPoint = 0;
          mem.tTtllog.t100700.tpntTtlsrv = 0;
        }
      }
    }
  }

  /// トータルログに本日対象額印字をセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_dMspurPrn
  static void setdMspurPrn(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ttllog.t100700Sts.dMspurPrn = pCom.dbTrm.tdyTgtmnyPrint;
  }

  /// トータルログに本日ポイント印字をセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_dMspointPrn
  static void setdMsPointPrn(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ttllog.t100700Sts.dMspointPrn = pCom.dbTrm.tdyPointPrint;
  }

  /// トータルログに累計ポイント印字をセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_tMspointPrn
  static void settMsPointPrn(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ttllog.t100700Sts.tMspointPrn = pCom.dbTrm.totalPointPrint;
  }

  /// トータルログに可能ポイント印字をセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_tMsppointPrn
  static void settMspPointPrn(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tTtllog.calcData.tMsppointPrn = pCom.dbTrm.posblPointPrint.toString();
  }

  /// トータルログに即時割戻音を出力をセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_serPointSound
  static void setSerPointSound(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ttllog.t100700Sts.serPointSound = pCom.dbTrm.rvtBeep;
  }

  /// トータルログに累計ポイントをセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_TpntTtlsvr
  static Future<void> setTpntTtlsvr(TTtlLog ttllog) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    int sbsMthd = await Rxmbrcom.rcmbrGetSvsMthd(pCom, mem);
    if (CompileFlag.POINT_CARD) {
      /* ポイントカード接続時は本日ポイントが負のときは0にする */
      if ((await RcSysChk.rcChkPointCardSystem()) &&
          (ttllog.t100700.mbrInput == MbrInputType.pointCardInput.index)) {
        if (ttllog.t100700.dpntTtlsrv < 0) {
          ttllog.t100700.dpntTtlsrv =  0;
        }
      }
    }

    /*  操作モード  */
    switch(mem.tHeader.ope_mode_flg) {
      case OpeModeFlagList.OPE_MODE_REG:    /* 登録 */
      case OpeModeFlagList.OPE_MODE_TRAINING:    /* 訓練 */
        ttllog.t100700.tpntTtlsrv = ttllog.t100700.lpntTtlsrv + ttllog.t100700.dpntTtlsrv;
        if (CompileFlag.REWRITE_CARD) {
          if ((await RcSysChk.rcChkTRCSystem()) &&
              (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index)) {
            if (ttllog.t100700.tpntTtlsrv < 0) {
              if (pCom.dbTrm.kyumatsuRwProc == 0) {
                ttllog.t100700.dpntTtlsrv = 0;
                ttllog.t100700.dpntTtlsrv -= ttllog.t100700.lpntTtlsrv;
              }
              ttllog.t100700.tpntTtlsrv = 0;
            }
          }
        }
        /*  サービス方式が即時  */
        if ((sbsMthd >= 5) && (sbsMthd <= 8)) {
          ttllog.t100700.tpntTtlsrv -= ttllog.t100701.duptTtlrv;
          if (sbsMthd == 5) {
            if ((pCom.dbTrm.nwRvtPointTyp == 0) &&
                (pCom.dbTrm.pointSbsClrTyp == 0) &&
                (ttllog.t100701.dtipTtlsrv > 0) &&
                (pCom.dbTrm.nwRvtPointTyp == 1)) {
              ttllog.t100700.dcutTtlsrv += ttllog.t100700.dpntTtlsrv;
            }
          }
          ttllog.t100700.tpntTtlsrv -= ttllog.t100700.dcutTtlsrv;
        }
        if (CompileFlag.SAPPORO) {
          if (((await RcSysChk.rcChkSapporoPanaSystem()) ||
              (await RcSysChk.rcChkJklPanaSystem()) ||
              (await CmCksys.cmRainbowCardSystem() != 0) ||
              (await CmCksys.cmPanaMemberSystem() != 0) ||
              (await CmCksys.cmMoriyaMemberSystem() != 0)) &&
              (ttllog.t100700.mbrInput == MbrInputType.sapporoPanaInput.index)) {
            if (ttllog.t100700.tpntTtlsrv < 0) {
              ttllog.t100700.tpntTtlsrv = 0;
            }
          }
        }
        if (CompileFlag.MC_SYSTEM) {
          if (RcSysChk.rcChkMcSystem() &&
              (ttllog.t100700.mbrInput == MbrInputType.mcardInput.index)) {
            if (ttllog.t100700.tpntTtlsrv < 0) {
              ttllog.t100700.tpntTtlsrv = 0;
            }
          }
        }
        if ((await RcSysChk.rcChkPharmacySystem()) &&
            !(await RcSysChk.rcChkSapporoRealSystem())) {
          if (ttllog.t100700.tpntTtlsrv < 0) {
            ttllog.t100700.tpntTtlsrv = 0;
          }
        }
        if (((await RcSysChk.rcChkMcp200System()) &&
             (ttllog.t100700.mbrInput == MbrInputType.mcp200Input.index)) ||
            ((await RcSysChk.rcChkAbsV31System()) &&
                (ttllog.t100700.mbrInput == MbrInputType.absV31Input.index))) {
          if (ttllog.t100700.tpntTtlsrv < 0) {
            ttllog.t100700.tpntTtlsrv = 0;
          }
        }
        break;
      case 3:    /* 訂正 */
        ttllog.t100700.tpntTtlsrv = ttllog.t100700.lpntTtlsrv - ttllog.t100700.dpntTtlsrv;
        if (CompileFlag.REWRITE_CARD) {
          if ((await RcSysChk.rcChkTRCSystem()) &&
              (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index)) {
            if (ttllog.t100700.tpntTtlsrv < 0) {
              if (pCom.dbTrm.kyumatsuRwProc == 0) {
                ttllog.t100700.dpntTtlsrv =  0;
                ttllog.t100700.dpntTtlsrv += ttllog.t100700.lpntTtlsrv;
              }
              ttllog.t100700.tpntTtlsrv =  0;
            }
          }
        }
        /*  サービス方式が即時  */
        if ((sbsMthd >= 5) && (sbsMthd <= 8)) {
          ttllog.t100700.tpntTtlsrv += ttllog.t100701.duptTtlrv;
        }
        if (CompileFlag.SAPPORO) {
          if (((await RcSysChk.rcChkSapporoPanaSystem()) ||
              (await RcSysChk.rcChkJklPanaSystem()) ||
              (await CmCksys.cmRainbowCardSystem() != 0) ||
              (await CmCksys.cmPanaMemberSystem() != 0) ||
              (await CmCksys.cmMoriyaMemberSystem() != 0)) &&
              (ttllog.t100700.mbrInput == MbrInputType.sapporoPanaInput.index)) {
            if (ttllog.t100700.tpntTtlsrv < 0) {
              ttllog.t100700.tpntTtlsrv = 0;
            }
          }
        }
        if (CompileFlag.MC_SYSTEM) {
          if (RcSysChk.rcChkMcSystem() &&
              (ttllog.t100700.mbrInput == MbrInputType.mcardInput.index)) {
            if (ttllog.t100700.tpntTtlsrv < 0) {
              ttllog.t100700.tpntTtlsrv = 0;
            }
          }
        }
        if ((await RcSysChk.rcChkPharmacySystem()) &&
            !(await RcSysChk.rcChkSapporoRealSystem())) {
          if (ttllog.t100700.tpntTtlsrv < 0) {
            ttllog.t100700.tpntTtlsrv = 0;
          }
        }
        if (((await RcSysChk.rcChkMcp200System()) &&
            (ttllog.t100700.mbrInput == MbrInputType.mcp200Input.index)) ||
            ((await RcSysChk.rcChkAbsV31System()) &&
                (ttllog.t100700.mbrInput == MbrInputType.absV31Input.index))) {
          if (ttllog.t100700.tpntTtlsrv < 0) {
            ttllog.t100700.tpntTtlsrv = 0;
          }
        }
        break;
      default:
        break;
    }
    if (CompileFlag.RESERV_SYSTEM) {
      if (await RcReserv.rcReservNotUpdate()) {
        ttllog.t100700.tpntTtlsrv = ttllog.t100700.lpntTtlsrv;
      }
    }
    if ((await CmCksys.cmGreenstampSystem2() != 0) &&
        (pCom.dbTrm.coopYamaguchiGreenStamp != 0)) {
      /* コープやまぐち仕様 */
      ttllog.t100700.tpntTtlsrv =  0;
    }
  }

  /// トータルログに累計可能ポイントをセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_TpptTtalsrv
  static Future<void> setTpptTtlsrv(TTtlLog ttllog) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    int sbsMthd = await Rxmbrcom.rcmbrGetSvsMthd(pCom, mem);
    mem.tTtllog.calcData.tpptTtlsrv = 0;
    /*  サービス方式が即時  */
    if ((sbsMthd >= 1) && (sbsMthd <= 4)) {
      /*  前回累計可能ポイント － 本日可能利用ポイント  */
      mem.tTtllog.calcData.tpptTtlsrv = mem.tTtllog.calcData.lpptTtlsrv - mem.tTtllog.calcData.duppTtlrv;
      mem.tTtllog.calcData.tpptTtlsrv -= ttllog.t100700.dcutTtlsrv;
    }
  }

  /// トータルログに次回予定割戻ポイントをセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_NextTtlsrv
  static Future<void> setNextTtlsrv(TTtlLog ttllog) async {
    RegsMem mem = SystemFunc.readRegsMem();

    /* チケット自動割戻単位  */
    int tcktPoint = RcMbrCom.rcmbrGetAutoRbtUnit();
    mem.tTtllog.calcData.nextTtlsrv = 0;

    if (RcSysChk.rcCheckOthMbr()) {
      /* 他店会員？ Other store member ? */
      if (CompileFlag.MC_SYSTEM) {
        if (!(RcSysChk.rcChkMcSystem() &&
            (mem.tTtllog.t100700.mbrInput == MbrInputType.mcardInput.index))) {
          return;
        }
      }
      if (CompileFlag.POINT_CARD) {
        if (!((await RcSysChk.rcChkPointCardSystem()) &&
            (mem.tTtllog.t100700.mbrInput == MbrInputType.mcardInput.index))) {
          return;
        }
      }
      if (CompileFlag.REWRITE_CARD) {
        if (CompileFlag.IWAI && CompileFlag.VISMAC) {
          if ((!((await RcSysChk.rcChkTRCSystem()) ||
              (await RcSysChk.rcChkORCSystem()) &&
                  (ttllog.t100700.mbrInput ==
                      MbrInputType.rwCardInput.index))) &&
              (!((await RcSysChk.rcChkVMCSystem()) &&
                  (ttllog.t100700.mbrInput ==
                      MbrInputType.vismacCardInput.index)))) {
            return;
          }
        } else if (CompileFlag.IWAI) {
          if (!((await RcSysChk.rcChkTRCSystem()) ||
              (await RcSysChk.rcChkORCSystem()) &&
                  (ttllog.t100700.mbrInput ==
                      MbrInputType.rwCardInput.index))) {
            return;
          }
        } else if (CompileFlag.VISMAC) {
          if ((!((await RcSysChk.rcChkTRCSystem()) &&
              (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index))) &&
              (!((await RcSysChk.rcChkVMCSystem()) &&
                  (ttllog.t100700.mbrInput ==
                      MbrInputType.vismacCardInput.index)))) {
            return;
          }
        } else {
          if (!((await RcSysChk.rcChkTRCSystem()) &&
              (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index))) {
            return;
          }
        }
      }
    }

    /*  次回予定割戻ポイント算出  */
    if (ttllog.t100700.tpntTtlsrv >= tcktPoint) {
      if (tcktPoint == 0) {
        tcktPoint = 1;
      }
      mem.tTtllog.calcData.nextTtlsrv = (ttllog.t100700.tpntTtlsrv / tcktPoint).toInt() * tcktPoint;
    }
  }

  /// トータルログに本日チケット回収情報をセットする
  /// 引数: トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_TicketCollect
  static Future<void> setTicketCollect(TTtlLog ttllog) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    int count = 0;
    int point = 0;

    /* チケット回収情報取得 */
    for (int i=1; i<FuncKey.MAX_FKEY.keyId; i++) {
      if (Rxkoptcmncom.rxChkKoptChaChkTicketCollect(cBuf, i) == 1) {
        count += getChkCnt(i, ttllog);  /* 品券回数 */
        point += getChkAmt(i, ttllog);  /* 品券金額 */
      }
    }
    /* 本日チケット回収枚数 */
    setDtuqTtlsrv(count, ttllog);
    /* 本日回収ポイント */
    setDtupTtlsrv(point, ttllog);
  }

  /// トータルログに本日チケット回収枚数をセットする
  /// 引数:[count] チケット回収枚数
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_DtuqTtlsrv
  static void setDtuqTtlsrv(int count, TTtlLog ttllog) {
    ttllog.t100702.dtuqTtlsrv = count;
  }

  /// トータルログに本日チケット回収ポイントをセットする
  /// 引数:[point] チケット回収ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_DtupTtlsrv
  static void setDtupTtlsrv(int point, TTtlLog ttllog) {
    ttllog.t100702.dtupTtlsrv = point;
  }

  /// 指定された品券の回数を返す
  /// 引数:[chkNo] 品券No
  /// 引数:[ttllog] トータルログバッファ
  /// 戻り値: 品券の回数
  /// 関連tprxソース: rcmbrpttlset.c - Get_ChkCnt
  static int getChkCnt(int chkNo, TTtlLog ttllog) {
    int count = 0;

    switch (chkNo) {
      case 26:  /* FuncKey.KY_CHK1.index: 品券１ */
        count = ttllog.t100200[AmtKind.amtChk1.index].sht;
        break;
      case 27:  /* FuncKey.KY_CHK2.index: 品券２ */
        count = ttllog.t100200[AmtKind.amtChk2.index].sht;
        break;
      case 28:  /* FuncKey.KY_CHK3.index: 品券３ */
        count = ttllog.t100200[AmtKind.amtChk3.index].sht;
        break;
      case 29:  /* FuncKey.KY_CHK4.index: 品券４ */
        count = ttllog.t100200[AmtKind.amtChk4.index].sht;
        break;
      case 30:  /* FuncKey.KY_CHK5.index: 品券５ */
        count = ttllog.t100200[AmtKind.amtChk5.index].sht;
        break;
      case 15:  /* FuncKey.KY_CHA1.index: 会計1  */
        count = ttllog.t100200[AmtKind.amtCha1.index].sht;
        break;
      case 16:  /* FuncKey.KY_CHA2.index: 会計2  */
        count = ttllog.t100200[AmtKind.amtCha2.index].sht;
        break;
      case 17:  /* FuncKey.KY_CHA3.index: 会計3  */
        count = ttllog.t100200[AmtKind.amtCha3.index].sht;
        break;
      case 18:  /* FuncKey.KY_CHA4.index: 会計4  */
        count = ttllog.t100200[AmtKind.amtCha4.index].sht;
        break;
      case 19:  /* FuncKey.KY_CHA5.index: 会計5  */
        count = ttllog.t100200[AmtKind.amtCha5.index].sht;
        break;
      case 20:  /* FuncKey.KY_CHA6.index: 会計6  */
        count = ttllog.t100200[AmtKind.amtCha6.index].sht;
        break;
      case 21:  /* FuncKey.KY_CHA7.index: 会計7  */
        count = ttllog.t100200[AmtKind.amtCha7.index].sht;
        break;
      case 22:  /* FuncKey.KY_CHA8.index: 会計8  */
        count = ttllog.t100200[AmtKind.amtCha8.index].sht;
        break;
      case 23:  /* FuncKey.KY_CHA9.index: 会計9  */
        count = ttllog.t100200[AmtKind.amtCha9.index].sht;
        break;
      case 24:  /* FuncKey.KY_CHA10.index: 会計10 */
        count = ttllog.t100200[AmtKind.amtCha10.index].sht;
        break;
      case 384:  /* FuncKey.KY_CHA11.index: 会計11 */
        count = ttllog.t100200[AmtKind.amtCha11.index].sht;
        break;
      case 385:  /* FuncKey.KY_CHA12.index: 会計12 */
        count = ttllog.t100200[AmtKind.amtCha12.index].sht;
        break;
      case 386:  /* FuncKey.KY_CHA13.index: 会計13 */
        count = ttllog.t100200[AmtKind.amtCha13.index].sht;
        break;
      case 387:  /* FuncKey.KY_CHA14.index: 会計14 */
        count = ttllog.t100200[AmtKind.amtCha14.index].sht;
        break;
      case 388:  /* FuncKey.KY_CHA15.index: 会計15 */
        count = ttllog.t100200[AmtKind.amtCha15.index].sht;
        break;
      case 389:  /* FuncKey.KY_CHA16.index: 会計16 */
        count = ttllog.t100200[AmtKind.amtCha16.index].sht;
        break;
      case 390:  /* FuncKey.KY_CHA17.index: 会計17 */
        count = ttllog.t100200[AmtKind.amtCha17.index].sht;
        break;
      case 391:  /* FuncKey.KY_CHA18.index: 会計18 */
        count = ttllog.t100200[AmtKind.amtCha18.index].sht;
        break;
      case 392:  /* FuncKey.KY_CHA19.index: 会計19 */
        count = ttllog.t100200[AmtKind.amtCha19.index].sht;
        break;
      case 393:  /* FuncKey.KY_CHA20.index: 会計20 */
        count = ttllog.t100200[AmtKind.amtCha20.index].sht;
        break;
      case 394:  /* FuncKey.KY_CHA21.index: 会計21 */
        count = ttllog.t100200[AmtKind.amtCha21.index].sht;
        break;
      case 395:  /* FuncKey.KY_CHA22.index: 会計22 */
        count = ttllog.t100200[AmtKind.amtCha22.index].sht;
        break;
      case 396:  /* FuncKey.KY_CHA23.index: 会計23 */
        count = ttllog.t100200[AmtKind.amtCha23.index].sht;
        break;
      case 397:  /* FuncKey.KY_CHA24.index: 会計24 */
        count = ttllog.t100200[AmtKind.amtCha24.index].sht;
        break;
      case 398:  /* FuncKey.KY_CHA25.index: 会計25 */
        count = ttllog.t100200[AmtKind.amtCha25.index].sht;
        break;
      case 399:  /* FuncKey.KY_CHA26.index: 会計26 */
        count = ttllog.t100200[AmtKind.amtCha26.index].sht;
        break;
      case 400:  /* FuncKey.KY_CHA27.index: 会計27 */
        count = ttllog.t100200[AmtKind.amtCha27.index].sht;
        break;
      case 401:  /* FuncKey.KY_CHA28.index: 会計28 */
        count = ttllog.t100200[AmtKind.amtCha28.index].sht;
        break;
      case 402:  /* FuncKey.KY_CHA29.index: 会計29 */
        count = ttllog.t100200[AmtKind.amtCha29.index].sht;
        break;
      case 403:  /* FuncKey.KY_CHA30.index: 会計30 */
        count = ttllog.t100200[AmtKind.amtCha30.index].sht;
        break;
      default:
        break;
    }

    return count;
  }

  /// 指定された品券の金額を返す
  /// 引数:[chkNo] 品券No
  /// 引数:[ttllog] トータルログバッファ
  /// 戻り値: 品券の金額
  /// 関連tprxソース: rcmbrpttlset.c - Get_ChkAmt
  static int getChkAmt(int chkNo, TTtlLog ttllog) {
    int amt = 0;

    switch (chkNo) {
      case 26:  /* FuncKey.KY_CHK1.index: 品券１ */
        amt = ttllog.t100200[AmtKind.amtChk1.index].amt;
        break;
      case 27:  /* FuncKey.KY_CHK2.index: 品券２ */
        amt = ttllog.t100200[AmtKind.amtChk2.index].amt;
        break;
      case 28:  /* FuncKey.KY_CHK3.index: 品券３ */
        amt = ttllog.t100200[AmtKind.amtChk3.index].amt;
        break;
      case 29:  /* FuncKey.KY_CHK4.index: 品券４ */
        amt = ttllog.t100200[AmtKind.amtChk4.index].amt;
        break;
      case 30:  /* FuncKey.KY_CHK5.index: 品券５ */
        amt = ttllog.t100200[AmtKind.amtChk5.index].amt;
        break;
      case 15:  /* FuncKey.KY_CHA1.index: 会計1  */
        amt = ttllog.t100200[AmtKind.amtCha1.index].amt;
        break;
      case 16:  /* FuncKey.KY_CHA2.index: 会計2  */
        amt = ttllog.t100200[AmtKind.amtCha2.index].amt;
        break;
      case 17:  /* FuncKey.KY_CHA3.index: 会計3  */
        amt = ttllog.t100200[AmtKind.amtCha3.index].amt;
        break;
      case 18:  /* FuncKey.KY_CHA4.index: 会計4  */
        amt = ttllog.t100200[AmtKind.amtCha4.index].amt;
        break;
      case 19:  /* FuncKey.KY_CHA5.index: 会計5  */
        amt = ttllog.t100200[AmtKind.amtCha5.index].amt;
        break;
      case 20:  /* FuncKey.KY_CHA6.index: 会計6  */
        amt = ttllog.t100200[AmtKind.amtCha6.index].amt;
        break;
      case 21:  /* FuncKey.KY_CHA7.index: 会計7  */
        amt = ttllog.t100200[AmtKind.amtCha7.index].amt;
        break;
      case 22:  /* FuncKey.KY_CHA8.index: 会計8  */
        amt = ttllog.t100200[AmtKind.amtCha8.index].amt;
        break;
      case 23:  /* FuncKey.KY_CHA9.index: 会計9  */
        amt = ttllog.t100200[AmtKind.amtCha9.index].amt;
        break;
      case 24:  /* FuncKey.KY_CHA10.index: 会計10 */
        amt = ttllog.t100200[AmtKind.amtCha10.index].amt;
        break;
      case 384:  /* FuncKey.KY_CHA11.index: 会計11 */
        amt = ttllog.t100200[AmtKind.amtCha11.index].amt;
        break;
      case 385:  /* FuncKey.KY_CHA12.index: 会計12 */
        amt = ttllog.t100200[AmtKind.amtCha12.index].amt;
        break;
      case 386:  /* FuncKey.KY_CHA13.index: 会計13 */
        amt = ttllog.t100200[AmtKind.amtCha13.index].amt;
        break;
      case 387:  /* FuncKey.KY_CHA14.index: 会計14 */
        amt = ttllog.t100200[AmtKind.amtCha14.index].amt;
        break;
      case 388:  /* FuncKey.KY_CHA15.index: 会計15 */
        amt = ttllog.t100200[AmtKind.amtCha15.index].amt;
        break;
      case 389:  /* FuncKey.KY_CHA16.index: 会計16 */
        amt = ttllog.t100200[AmtKind.amtCha16.index].amt;
        break;
      case 390:  /* FuncKey.KY_CHA17.index: 会計17 */
        amt = ttllog.t100200[AmtKind.amtCha17.index].amt;
        break;
      case 391:  /* FuncKey.KY_CHA18.index: 会計18 */
        amt = ttllog.t100200[AmtKind.amtCha18.index].amt;
        break;
      case 392:  /* FuncKey.KY_CHA19.index: 会計19 */
        amt = ttllog.t100200[AmtKind.amtCha19.index].amt;
        break;
      case 393:  /* FuncKey.KY_CHA20.index: 会計20 */
        amt = ttllog.t100200[AmtKind.amtCha20.index].amt;
        break;
      case 394:  /* FuncKey.KY_CHA21.index: 会計21 */
        amt = ttllog.t100200[AmtKind.amtCha21.index].amt;
        break;
      case 395:  /* FuncKey.KY_CHA22.index: 会計22 */
        amt = ttllog.t100200[AmtKind.amtCha22.index].amt;
        break;
      case 396:  /* FuncKey.KY_CHA23.index: 会計23 */
        amt = ttllog.t100200[AmtKind.amtCha23.index].amt;
        break;
      case 397:  /* FuncKey.KY_CHA24.index: 会計24 */
        amt = ttllog.t100200[AmtKind.amtCha24.index].amt;
        break;
      case 398:  /* FuncKey.KY_CHA25.index: 会計25 */
        amt = ttllog.t100200[AmtKind.amtCha25.index].amt;
        break;
      case 399:  /* FuncKey.KY_CHA26.index: 会計26 */
        amt = ttllog.t100200[AmtKind.amtCha26.index].amt;
        break;
      case 400:  /* FuncKey.KY_CHA27.index: 会計27 */
        amt = ttllog.t100200[AmtKind.amtCha27.index].amt;
        break;
      case 401:  /* FuncKey.KY_CHA28.index: 会計28 */
        amt = ttllog.t100200[AmtKind.amtCha28.index].amt;
        break;
      case 402:  /* FuncKey.KY_CHA29.index: 会計29 */
        amt = ttllog.t100200[AmtKind.amtCha29.index].amt;
        break;
      case 403:  /* FuncKey.KY_CHA30.index: 会計30 */
        amt = ttllog.t100200[AmtKind.amtCha30.index].amt;
        break;
      default:
        break;
    }

    return amt;
  }

  /// トータルログに累計釣銭額＆累計へそくり額＆タイプをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_VismacDATA
  static void setVismacData(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    //@@@V15	ビスマックはとりあえず削除
  }

  /// トータルログにサッポロパナデータをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_SapporoPanaDATA
  static void setSapporoPanaData(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    ttllog.t100001Sts.cardStreCd = cBuf.dbRegCtrl.cardStreCd;
  }

  /// トータルログにレインボーパナデータをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_RainbowPanaDATA
  static void setRainbowPanaData(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    AtSingl atSing = SystemFunc.readAtSingl();

    if (ttllog.t100700.mbrInput == MbrInputType.mbrCodeInput.index) {
      ttllog.t100010Sts.payKind = 9;
    } else if (atSing.rainbowPanadata.cardTyp == 0) {
      ttllog.t100010Sts.payKind = 5;
    } else if (atSing.rainbowPanadata.cardTyp != 5) {
      ttllog.t100010Sts.payKind = atSing.rainbowPanadata.cardTyp;
    }
  }

  /// トータルログにロンフレ様向けデータをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_NW7_StreCode
  static void setNW7StreCode(TTtlLog ttllog){
    ttllog.t100700.realCustsrvFlg = 1;  /* ロンフレ様向け OFF Line Flag */
  }

  /// トータルログにLPRチケットデータをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_LprTicketBarTrn
  static void setLprTicketBarTrn(TTtlLog ttllog) {}

  /// 顧客リアル[Webサービス]仕様の時、本日ポイント、累計ポイントをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_WebReal_DATA
  static void setWebRealData(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xtRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if (ttllog.t100001Sts.chrgFlg == 0) {
      ttllog.t100700.dpntTtlsrv = tsBuf.custreal2.data.webser.rec.add_point;
    } else {
      ttllog.t100700.dpntTtlsrv = 0;
    }
    if (ttllog.t100001Sts.chrgFlg == 1) {
      ttllog.t100700.tpntTtlsrv = 0;
    } else if ((ttllog.t100001Sts.chrgFlg == 0) &&
        (mem.tHeader.ope_mode_flg != OpeModeFlagList.OPE_MODE_TRAINING)) {
      ttllog.t100700.tpntTtlsrv = tsBuf.custreal2.data.webser.rec.ttl_point;
    } else {
      ttllog.t100700.tpntTtlsrv =
          ttllog.t100700.dpntTtlsrv + ttllog.t100700.lpntTtlsrv -
              ttllog.t100701.duptTtlrv;
    }
  }

  /// 顧客リアル[UID]仕様の時、本日ポイント、累計ポイントをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_WebReal_UID_DATA
  static Future<void> setWebRealUIDData(TTtlLog ttllog) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tTtllog.t100010.orgReceiptNo = mem.prnrBuf.cardStopKind;
    if (mem.tTtllog.t100700.tpntTtlsrv < 0) {
      mem.tTtllog.t100700.tpntTtlsrv = 0;
    }
    if (await RckyDisBurse.rcCheckKYDisBurse()) {
      RcStl.rcClrTtlRBufMbr(ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_ALL);
    }
  }

  /// 顧客リアル[OP]仕様の時、本日ポイント、累計ポイントをセットする
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpttlset.c - Set_WebReal_OP_DATA
  static void setWebRealOPData(TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RegsMem mem = SystemFunc.readRegsMem();

    if ((ttllog.t100700.realCustsrvFlg != 0) &&
        (ttllog.t100001.stlTaxInAmt != 0)) {
      if (RcSysChk.rcVDOpeModeChk()) {
        if (mem.tTtllog.t100700.dcauMspur > -1){
          ttllog.t100011Sts.tranTyp = 3232;
        } else {
          ttllog.t100011Sts.tranTyp = 3230;
        }
      } else {
        if (ttllog.t100700.dcauMspur > -1) {
          ttllog.t100011Sts.tranTyp = 3230;
        } else {
          ttllog.t100011Sts.tranTyp = 3232;
        }
      }
    }
  }
}
