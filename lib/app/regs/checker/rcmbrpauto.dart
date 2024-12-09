/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mbr.dart';
import 'rc_mbr_com.dart';
import 'rc_reserv.dart';
import 'rcmbrkymbr.dart';
import 'rcmbrpcom.dart';
import 'rcmbrpoical.dart';
import 'rcsyschk.dart';

class RcMbrPAuto {
  /// 顧客販売時に自動的に発生する割戻をトータルログにセットする
  /// 戻り値: 小計割戻額
  /// 関連tprxソース: rxmbrpauto.c - rcmbr_PTtlSet_AutoRbt
  static Future<int> rcmbrPTtlSetAutoRbt() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    TTtlLog ttllog = mem.tTtllog;
    int usePoint = 0;

    if (CompileFlag.RESERV_SYSTEM) {
      if (await RcReserv.rcReservNotUpdate() ) {
        if (mem.tTtllog.t100701.rebateFlg == TtlBufRebateList.TTLBUF_REBATE_AUTO_DSC.index) {
          usePoint = mem.tTtllog.t100701.dmpTtlsrv;
        }
        return usePoint;
      }
    }
    if (RcSysChk.rcCheckMobilePos()) {
      return usePoint;
    }
    /*  顧客ポイント仕様かチェック */
    if (((await RcMbrCom.rcmbrChkStat()) & RcMbr.RCMBR_STAT_POINT) == 0) {
      return usePoint;
    }
    /* 顧客が選択されいるかチェック */
    if (!RcMbrPcom.rcmbrPChkSelMbr()) {
      return usePoint;
    }
    /* 訂正モードかチェック */
    if (RcSysChk.rcVDOpeModeChk()) {
      return usePoint;
    }

    if ((RcSysChk.rcChkCustrealUIDSystem() != 0) &&
        (ttllog.t100700.mbrInput != 0)) {
      if ((tsBuf.custreal2.data.uid.rec.parent_card_no.isNotEmpty) ||
          (mem.prnrBuf.cardStopKind != 0) || (tsBuf.custreal2.stat != 0) ||
          (ttllog.t100700.realCustsrvFlg != 0)) {
        return usePoint;
      }
    }

    bool flg = false;
    if (RcSysChk.rcChkCustrealPointartistSystem() != 0) {
      if (mem.tTtllog.t100700.realCustsrvFlg != 0) {
        flg = true;
      }
      if (mem.tTtllog.t100001Sts.itemlogCnt > 0) {
        for (int i=0; i<mem.tTtllog.t100001Sts.itemlogCnt; i++) {
          if (mem.tItemLog[i].t10000Sts.refundFlg != 0) {
            flg = true;
            break;
          }
        }
      }
      if (flg) {
        mem.tTtllog.t100701.dtiqTtlsrv = 0;
        mem.tTtllog.t100701.dtipTtlsrv = 0;
        mem.tTtllog.t100701.duptTtlrv = 0;
        return usePoint;
      }
    }

    if ((CmCksys.cmMatugenSystem() != 0) && (mem.tTtllog.t100003.voidFlg == 1)) {
      if (mem.tTtllog.t100701.dtiqTtlsrv != 0) {
        mem.tTtllog.t100700.tpntTtlsrv = mem.tTtllog.t100700.dpntTtlsrv;
        mem.tTtllog.t100701.dtiqTtlsrv = 0;
        mem.tTtllog.t100701.dtipTtlsrv = 0;
        mem.tTtllog.t100701.duptTtlrv = 0;
      }
      return usePoint;
    }

    /* サービス種別 */
    int sbsMthd = await Rxmbrcom.rcmbrGetSvsMthd(cBuf, mem);

    /* 割戻減算方法 */
    int rbtsubst = cBuf.dbTrm.rvtSubstMthd;
    int objRbtPoint = 0;
    int cutPoint = 0;

    switch (sbsMthd) {
      case 1:/* 確定チケット */
      case 2:/* 確定自動 */
      case 5:/* 即時チケット */
      case 6:/* 即時自動 */
        /* 割戻対象ポイントの取得 */
        objRbtPoint = RcMbrPcom.rcmbrGetObjRbtPoint(sbsMthd);
        /* 即時割戻の今回ポイント扱い区分 有効 時 本日ポイント加算 */
        if (sbsMthd == 5) {
          if (cBuf.dbTrm.nwRvtPointTyp != 0) {
            /* オフラインチェック */
            if (CompileFlag.CUSTREALSVR) {
              if (((cBuf.custOffline != 2) &&
                  (RcSysChk.rcChkCustrealsvrSystem() ||
                      (await RcSysChk.rcChkCustrealNecSystem(0)))) ||
                  (RcSysChk.rcChkCustrealPointartistSystem() != 0) ||
                  ((cBuf.custOffline == 0) &&
                      !(RcSysChk.rcChkCustrealsvrSystem() ||
                          (await RcSysChk.rcChkCustrealNecSystem(0))))) {
                if (CompileFlag.RALSE_MBRSYSTEM &&
                    RcSysChk.rcChkRalseCardSystem()) {
                  RcMbrPoiCal.rcmbrTodayPoint(1);
                } else {
                  RcMbrPoiCal.rcmbrTodayPoint(0);
                  objRbtPoint += ttllog.t100700.dpntTtlsrv;
                }
              } else if (cBuf.dbTrm.memUseTyp != 0) {
                if (CompileFlag.SAPPORO) {
                  if ((((await RcSysChk.rcChkSapporoPanaSystem()) ||
                      (await RcSysChk.rcChkJklPanaSystem()) ||
                      (await CmCksys.cmRainbowCardSystem() != 0) ||
                      (await CmCksys.cmPanaMemberSystem() != 0) ||
                      (await CmCksys.cmMoriyaMemberSystem() != 0)) &&
                      (ttllog.t100700.mbrInput ==
                          MbrInputType.sapporoPanaInput.index)) ||
                      ((RcSysChk.rcChkCustrealUIDSystem() != 0) &&
                          (ttllog.t100700.mbrInput != 0))) {
                    RcMbrPoiCal.rcmbrTodayPoint(0);
                    objRbtPoint += ttllog.t100700.dpntTtlsrv;
                  }
                }
                if (((await RcSysChk.rcChkMcp200System()) &&
                    (ttllog.t100700.mbrInput ==
                        MbrInputType.mcp200Input.index)) ||
                    ((await RcSysChk.rcChkAbsV31System()) &&
                        (ttllog.t100700.mbrInput ==
                            MbrInputType.absV31Input.index))) {
                  RcMbrPoiCal.rcmbrTodayPoint(0);
                  objRbtPoint += ttllog.t100700.dpntTtlsrv;
                }
              }
            } else {
              if (cBuf.offline != 0) {
                if (CompileFlag.RALSE_MBRSYSTEM &&
                    RcSysChk.rcChkRalseCardSystem()) {
                  RcMbrPoiCal.rcmbrTodayPoint(1);
                } else {
                  RcMbrPoiCal.rcmbrTodayPoint(0);
                  objRbtPoint += ttllog.t100700.dpntTtlsrv;
                }
              } else if (cBuf.dbTrm.memUseTyp != 0) {
                if (CompileFlag.SAPPORO) {
                  if ((((await RcSysChk.rcChkSapporoPanaSystem()) ||
                      (await RcSysChk.rcChkJklPanaSystem()) ||
                      (await CmCksys.cmRainbowCardSystem() != 0) ||
                      (await CmCksys.cmPanaMemberSystem() != 0) ||
                      (await CmCksys.cmMoriyaMemberSystem() != 0)) &&
                      (ttllog.t100700.mbrInput ==
                          MbrInputType.sapporoPanaInput.index)) ||
                      ((RcSysChk.rcChkCustrealUIDSystem() != 0) &&
                          (ttllog.t100700.mbrInput != 0))) {
                    RcMbrPoiCal.rcmbrTodayPoint(0);
                    objRbtPoint += ttllog.t100700.dpntTtlsrv;
                  }
                }
                if (((await RcSysChk.rcChkMcp200System()) &&
                    (ttllog.t100700.mbrInput ==
                        MbrInputType.mcp200Input.index)) ||
                    ((await RcSysChk.rcChkAbsV31System()) &&
                        (ttllog.t100700.mbrInput ==
                            MbrInputType.absV31Input.index))) {
                  RcMbrPoiCal.rcmbrTodayPoint(0);
                  objRbtPoint += ttllog.t100700.dpntTtlsrv;
                }
              }
            }
          }
        }
        /* 割戻処理 */
        if (!RcSysChk.rcCheckOthMbr() || (await RcSysChk.rcChkNW7System())) {
          if ((sbsMthd % 2) != 0) {
            usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
          } else {
            usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
          }
        } else if (CompileFlag.REWRITE_CARD) {
          if (CompileFlag.IWAI && CompileFlag.VISMAC) {
            if ((((await RcSysChk.rcChkTRCSystem()) || (await RcSysChk.rcChkORCSystem())) &&
                 (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index)) ||
                ((await RcSysChk.rcChkVMCSystem()) && (ttllog.t100700.mbrInput == MbrInputType.vismacCardInput.index))) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          } else if (CompileFlag.IWAI) {
            if (((await RcSysChk.rcChkTRCSystem()) || (await RcSysChk.rcChkORCSystem())) &&
                (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index)) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          } else if (CompileFlag.VISMAC) {
            if (((await RcSysChk.rcChkTRCSystem()) && (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index)) ||
                ((await RcSysChk.rcChkVMCSystem()) && (ttllog.t100700.mbrInput == MbrInputType.vismacCardInput.index))) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          } else {
            if ((await RcSysChk.rcChkTRCSystem()) && (ttllog.t100700.mbrInput == MbrInputType.rwCardInput.index)) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          }
          if (CompileFlag.POINT_CARD) {
            if ((await RcSysChk.rcChkPointCardSystem()) && (ttllog.t100700.mbrInput == MbrInputType.pointCardInput.index)) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          }
          if (CompileFlag.MC_SYSTEM) {
            if (RcSysChk.rcChkMcSystem() && (ttllog.t100700.mbrInput == MbrInputType.mcardInput.index)) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          }
          if (CompileFlag.SAPPORO) {
            if ((((await RcSysChk.rcChkSapporoPanaSystem()) ||
                  (await RcSysChk.rcChkJklPanaSystem()) ||
                  (await CmCksys.cmRainbowCardSystem() != 0) ||
                  (await CmCksys.cmPanaMemberSystem() != 0) ||
                  (await CmCksys.cmMoriyaMemberSystem() != 0)) &&
                 (ttllog.t100700.mbrInput == MbrInputType.sapporoPanaInput.index)) ||
                ((RcSysChk.rcChkCustrealUIDSystem() != 0) &&
                 (ttllog.t100700.mbrInput != 0))) {
              if ((sbsMthd % 2) != 0) {
                usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
              } else {
                usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
              }
            }
          }
          if (ttllog.t100700.mbrInput == MbrInputType.felicaInput.index) {
            if ((sbsMthd % 2) != 0) {
              usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
            } else {
              usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
            }
          }
        }
        if (((await RcSysChk.rcChkMcp200System()) &&
                (ttllog.t100700.mbrInput == MbrInputType.mcp200Input.index)) ||
            ((await CmCksys.cmDcmpointSystem() != 0) &&
                (ttllog.t100700.mbrInput != MbrInputType.nonInput.index)) ||
            ((await RcSysChk.rcChkAbsV31System()) &&
                (ttllog.t100700.mbrInput == MbrInputType.absV31Input.index))) {
          if ((sbsMthd % 2) != 0) {
            usePoint = await setTicket(rbtsubst, objRbtPoint, ttllog);
          } else {
            usePoint = await setAuto(rbtsubst, objRbtPoint, ttllog);
          }
        }
        /* 割戻が発生していない */
        if (usePoint == 0) {
          /* 本日利用ポイントセット */
          await RcMbrPcom.rcmbrPTtlSetUsePoint(sbsMthd, 0, ttllog);
          /* 本日割戻切捨てポイントセット */
          setDcutTtlsrv(0, ttllog);
          break;
        }
        /* 本日利用ポイントセット */
        await RcMbrPcom.rcmbrPTtlSetUsePoint(sbsMthd, usePoint, ttllog);
        if (cBuf.dbTrm.pointSbsClrTyp == 0) {
          /* 本日割戻切捨てポイント算出 */
          cutPoint = objRbtPoint - usePoint;
          /* 本日割戻切捨てポイントセット */
          setDcutTtlsrv(cutPoint, ttllog);
        }
        /* 割戻減算方法が会員ポイント減算のみ時発生ポイントクリア */
        if (rbtsubst != 0 || ((sbsMthd % 2) != 0)) {
          usePoint = 0;
        }
        break;
      default:
        break;
    }

    return usePoint;
  }

  /// トータルログにチケット発行点数／チケット発行枚数をセットする
  /// 引数:[rbtSubSt] 割戻減算方法
  /// 引数:[basPoint] 基準ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 戻り値:利用ポイント
  /// 関連tprxソース: rxmbrpauto.c - Set_Ticket
  static Future<int> setTicket(int rbtSubSt, int basPoint, TTtlLog ttllog) async {
    /* チケット発行点数算出 */
    int lprPoint = await calRbtPoint(basPoint);

    /* チケット発券中止処理 */
    if (CompileFlag.MC_SYSTEM) {
      // TODO:10108 コンパイルスイッチ(MC_SYSTEM)
      /*
      AtSingl atSing = SystemFunc.readAtSingl();
      if ((RcSysChk.rcChkMcSystem()) &&
          (ttllog.t100700.mbrInput == MbrInputType.mcardInput.index) &&
          (atSing.mc_tbl.tckt_flg)) {
        lprPoint = 0;
      }
       */
    }
    /* チケット発券中止処理 */
    if ((await RcSysChk.rcChkSapporoRealSystem()) &&
      ((ttllog.t100700.mbrInput == MbrInputType.pcardmngKeyInput.index) ||
          (ttllog.t100700.mbrInput == MbrInputType.pcarduseKeyInput.index))) {
      lprPoint = 0;
    }

    if (RcSysChk.rcsyschkAyahaSystem()) {
      if (!(await rcmbrSetTicketAyahaCheck(ttllog.t100700.mbrInput))) {
        lprPoint = 0;
      }
    }

    /* チケット発行枚数算出 */
    int lprCnt = calTicetCnt(lprPoint);
    RegsMem mem = SystemFunc.readRegsMem();

    lprPoint += mem.tTtllog.t100700Sts.mulrbtPnt;

    /* チケット発行情報セット */
    if (lprPoint > 0) {
      setLprTicket(lprCnt, lprPoint, ttllog);
    } else {
      setLprTicket(0, 0, ttllog);
    }

    return lprPoint;
  }

  /// 自動割戻ポイントを算出し、トータルログにセットし、小計額から算出結果を引く
  /// 引数:[rbtSubSt] 割戻減算方法
  /// 引数:[basPoint] 基準ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 戻り値:利用ポイント
  /// 関連tprxソース: rxmbrpauto.c - Set_Auto
  static Future<int> setAuto(int rbtSubSt, int basPoint, TTtlLog ttllog) async {
    /* 自動割戻ポイント算出 */
    int wAutoRbt = await calRbtPoint(basPoint);
    int autoRbt = await calRbtPoint(basPoint);

    /* 割戻減算方法 小計 + 会員ポイント減算 */
    int restAmt = 0;
    if (rbtSubSt == 0) {
      RegsMem mem = SystemFunc.readRegsMem();
      /* 小計額から割戻ポイント算出 */
      restAmt = mem.tTtllog.calcData.stlrbtdscRestAmt;
      autoRbt = await calRbtPoint(restAmt);
      if (autoRbt > basPoint) {
        autoRbt = wAutoRbt;
      }
      mem.tTtllog.t100001Sts.stldscRbtBfrAmt = restAmt;	// 割戻対象金額
    }

    /* 割戻ポイントなし */
    if (autoRbt <= 0) {
      /* 自動割戻情報セット */
      setAutoRebate(rbtSubSt, 0, ttllog);
      return 0;
    }

    /* 自動割戻情報セット */
    setAutoRebate(rbtSubSt, autoRbt, ttllog);

    return autoRbt;
  }

  /// トータルログに本日自動割戻をセットする
  /// 引数:[rbtSubSt] 割戻減算方法
  /// 引数:[autoRbt] 自動割戻ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 戻り値:利用ポイント
  /// 関連tprxソース: rxmbrpauto.c - Set_AutoRebate
  static void setAutoRebate(int rbtSubSt, int autoRbt, TTtlLog ttllog) {
    /* 割戻減算方法（0=小計値引+会員ポイント減算  1=会員ポイント減算） */
    if (rbtSubSt == 0) {
      setAutoRebateSubTtlCut(autoRbt, ttllog);
    } else {
      setAutoRebateCustCut(autoRbt, ttllog);
    }
  }

  /// トータルログに本日自動割戻（小計値引 + 会員ポイント減算）をセットする
  /// 引数:[autoRbt] 自動割戻ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_AutoRebate_SubTtlCut
  static void setAutoRebateSubTtlCut(int autoRbt, TTtlLog ttllog) {
    /* 自動割戻回数算出 */
    int cnt = 0;
    if (autoRbt > 0) {
      cnt = 1;
    }
    /* 本日自動割戻回数(小計値引 + 会員ポイント減算)セット */
    setDaq1Ttlsrv(cnt, ttllog);
    /* 本日自動割戻ポイント(小計値引 + 会員ポイント減算)セット */
    setDap1Ttlsrv(autoRbt, ttllog);
  }

  /// トータルログに本日自動割戻回数をセットする
  /// 引数:[cnt] 本日割戻回数
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c -  Set_Daq1Ttlsrv
  static void setDaq1Ttlsrv(int cnt, TTtlLog ttllog) {
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.t100701.dmqTtlsrv = cnt;
    if (ttllog.t100701.dmqTtlsrv != 0) {
      ttllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_AUTO_DSC.index;
    } else {
      ttllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_NOT.index;
    }
  }

  /// トータルログに本日自動割戻ポイントをセットする
  /// 引数:[autoRbt] 自動割戻ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c -  Set_Dap1Ttlsrv
  static void setDap1Ttlsrv(int autoRbt, TTtlLog ttllog) {
    ttllog.t100701.dmpTtlsrv = autoRbt;
  }

  /// トータルログに本日自動割戻(会員ポイント減算)をセットする
  /// 引数:[autoRbt] 自動割戻ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_AutoRebate_CustCut
  static void setAutoRebateCustCut(int autoRbt, TTtlLog ttllog) {
    /* 自動割戻回数算出 */
    int cnt = 0;
    if (autoRbt > 0) {
      cnt = 1;
    }
    /* 本日自動割戻回数セット */
    setDaq2Ttlsrv(cnt, ttllog);
    /* 本日自動割戻ポイントセット */
    setDap2Ttlsrv(autoRbt, ttllog);
  }

  /// トータルログに本日自動割戻回数をセットする
  /// 引数:[cnt] 本日割戻回数
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_Daq2Ttlsrv
  static void setDaq2Ttlsrv(int cnt, TTtlLog ttllog) {
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tTtllog.t100701.dmqTtlsrv = cnt;
    if (ttllog.t100701.dmqTtlsrv != 0) {
      ttllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_AUTO.index;
    } else {
      ttllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_NOT.index;
    }
  }

  /// トータルログに本日自動割戻ポイントをセットする
  /// 引数:[autoRbt] 自動割戻ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_Dap2Ttlsrv
  static void setDap2Ttlsrv(int autoRbt, TTtlLog ttllog) {
    ttllog.t100701.dmpTtlsrv = autoRbt;
  }

  /// 自動割戻ポイントを算出する
  /// 引数: 対象ポイント
  /// 戻り値: 割戻ポイント
  /// 関連tprxソース: rxmbrpauto.c - Cal_RbtPoint
  static Future<int> calRbtPoint(int basPoint) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    TTtlLog ttllog = mem.tTtllog;

    /* チケット自動割戻単位 */
    int autoUnit = RcMbrCom.rcmbrGetAutoRbtUnit();
    int autoUnit2 = 0;

    if ((await RcSysChk.rcChkPharmacySystem()) ||
        (await RcSysChk.rcChkSapporoRealSystem()) ||
        (await Rxmbrcom.rcChkPointOneUnderSystem(mem))) {
      autoUnit2 = cBuf.dbTrm.tcktIssuAmt;
    }

    int AutoCalPoint = 0;
    // 会員登録時割戻しチケット印字が有効であるならば、会員呼出時に割戻チケットを印字するため、会員登録時のチケット発行点数を代入する
    if (Rcmbrkymbr.rcmbrChkMarusyoSystem() &&
        (mem.prnrBuf.mbrCallSvctk.mbrcallSvctkFlg == 1)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrPAuto.calRbtPoint(): old[$basPoint] -> new[${mem.prnrBuf.mbrCallSvctk.dtipTtlsrv}]");
      basPoint = mem.prnrBuf.mbrCallSvctk.dtipTtlsrv;
    }
    if ((autoUnit > 0) && (basPoint > 0)) {
      if (cBuf.dbTrm.svstcktOneSheet != 0) {	// 1枚だけ
        if (basPoint >= autoUnit) {
          AutoCalPoint = autoUnit;
          basPoint = autoUnit;
        }
      } else {
        if ((RcMbrCom.rcGetPntUseLimit() != 0)	&& 	// ポイント利用上限
            ((await Rxmbrcom.rcmbrGetSvsMthd(cBuf, mem) == 5) ||  // チケット割戻
             (await Rxmbrcom.rcmbrGetSvsMthd(cBuf, mem) == 6)))	{  // 自動割戻
          if (basPoint > RcMbrCom.rcGetPntUseLimit()) {
            basPoint = RcMbrCom.rcGetPntUseLimit();
          }
        }
        AutoCalPoint = ((basPoint / autoUnit) * autoUnit).toInt();
      }
    } else if(autoUnit > 0) {
      // BasPointが0以下である時(買上追加で累計ポイントを0にした場合)にも計算を行う。
      // 会員登録時割戻しチケット印字が有効であるならば、会員呼出時に割戻チケットを印字するため、
      // 会員登録時のチケット発行点数を代入する
      if (Rcmbrkymbr.rcmbrChkMarusyoSystem() &&
          (mem.prnrBuf.mbrCallSvctk.mbrcallSvctkFlg == 1) ) {
        AutoCalPoint = ((basPoint / autoUnit) * autoUnit).toInt();
      }
    }

    int tckTissAmt = 0;
    if ((await RcSysChk.rcChkPharmacySystem()) ||
        (await RcSysChk.rcChkSapporoRealSystem())) {
      if ((autoUnit > 0) && (autoUnit2 > 0) && (basPoint > 0)) {
        mem.tTtllog.t100701.dmqTtlsrv = ((basPoint / autoUnit) * autoUnit2).toInt();
        if (mem.tTtllog.t100701.dmqTtlsrv != 0) {
          mem.tTtllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_MANU.index;
        }
      }
    } else if (await Rxmbrcom.rcChkPointOneUnderSystem(mem)) {
      if ((autoUnit > 0) && (autoUnit2 > 0) && (basPoint > 0)) {
        tckTissAmt = ((basPoint / autoUnit) * autoUnit2).toInt();
        tckTissAmt += mem.tTtllog.t100700Sts.mulrbtPrnAmt;
        /* チケット発行金額セット */
        setTcktIssAmt(tckTissAmt, ttllog);
      }
    }

    return AutoCalPoint;
  }

  /// チケット発行枚数を算出する
  /// 引数: 印字ポイント総数
  /// 戻り値: チケット発行枚数
  /// 関連tprxソース: rxmbrpauto.c - Cal_TicetCnt
  static int calTicetCnt(int lprPoint) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    int autoUnit = RcMbrCom.rcmbrGetAutoRbtUnit();
    int ticetCnt = 0;

    if (autoUnit > 0) {
      /* チケット分割印字チェック */
      if (cBuf.dbTrm.sbsTcktDvidPrint == 1) {
        ticetCnt = (lprPoint / autoUnit).toInt();
      } else {
        if (lprPoint > 0) {
          ticetCnt = 1;
        }
      }
    }

    return ticetCnt;
  }

  /// トータルログに本日チケット発行情報をセットする
  /// 引数:[lprCnt] 割戻計算時のチケット枚数
  /// 引数:[lprPoint] 割戻計算時のチケットポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_LprTicket
  static void setLprTicket(int lprCnt, int lprPoint, TTtlLog ttllog) {
    /* チケット発行枚数セット */
    setDtiqTtlsrv(lprCnt, ttllog);
    /* チケット発行点数セット */
    setDtipTtlsrv(lprPoint, ttllog);
  }

  /// トータルログに本日チケット発行ポイントをセットする
  /// 引数:[lprPoint] 割戻計算時のチケットポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_DtipTtlsrv
  static void setDtipTtlsrv(int lprPoint, TTtlLog ttllog) {
    ttllog.t100701.dtipTtlsrv = lprPoint;
  }

  /// トータルログに本日チケット発行枚数をセットする
  /// 引数:[lprCnt] 割戻計算時のチケット枚数
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_DtiqTtlsrv
  static void setDtiqTtlsrv(int lprCnt, TTtlLog ttllog) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    int tmpCnt = lprCnt;
    if ((cBuf.dbTrm.nwRvtPointTyp != 0) &&
        (mem.tTtllog.t100800Sts.fspLvlTicket != 0)) {
      tmpCnt++;
    }
    if (mem.tTtllog.t100700Sts.mulrbtPnt != 0) {
      tmpCnt++;
    }
    ttllog.t100701.dtiqTtlsrv = tmpCnt;

    if (ttllog.t100701.dtiqTtlsrv != 0) {
      ttllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_TCKT.index;
      ttllog.t100701.tcktIssueCust = 1;
    } else {
      ttllog.t100701.rebateFlg = TtlBufRebateList.TTLBUF_REBATE_NOT.index;
      ttllog.t100701.tcktIssueCust = 0;
    }
  }

  /// トータルログに本日チケット発行金額をセットする
  /// 引数:[lprPoint] 割戻計算時のチケットポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_TcktIssAmt
  static void setTcktIssAmt(int lprPoint, TTtlLog ttllog) {
    ttllog.t100701.tcktIssueAmt = lprPoint;
  }

  /// トータルログに本日割戻切捨てポイントをセットする
  /// 引数:[dCutTtl] 切捨てポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rxmbrpauto.c - Set_DcutTtlsrv
  static void setDcutTtlsrv(int dcutttl, TTtlLog ttllog) {
    ttllog.t100700.dcutTtlsrv = dcutttl;
  }

  /// アヤハディオ様用チケット発行チェック
  /// 引数:[mbrInput] 顧客入力方法
  /// 戻り値: true=発行する  false=発行しない
  /// 関連tprxソース: rxmbrpauto.c - rcmbr_Set_Ticket_Ayaha_check
  static Future<bool> rcmbrSetTicketAyahaCheck(int mbrInput) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((cBuf.dbTrm.ayahaTicketFunc == 0) &&
        (mem.tmpbuf.ayaha.joinStreNo != mem.tHeader.stre_cd)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "Stop Ticket join_stre_no=[${mem.tmpbuf.ayaha.joinStreNo}]");
      return false;
    }
    if (mbrInput != 2) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "Stop Ticket mbr_input != 2");
      return false;
    }
    return true;
  }
}
