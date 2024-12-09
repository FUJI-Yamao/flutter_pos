/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_calc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/db/c_item_log.dart';
import '../../inc/db/c_itemlog_sts.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/sys/tpr_log.dart';
import 'rc_stl.dart';
import 'rcsyschk.dart';

class RcPromotion {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcpromotion.c - rcpromotion_Cpn_Output_Dialog()
  static void rcpromotionCpnOutputDialog() {
    return ;
  }

  /// One to One プロモーションバーコードのデータを会員取消する
  /// 引数:[num] アイテムログ段数
  /// 引数:[pntTyp] ポイント種別
  /// 戻り値: 1=ロモーションバーコードであり、会員取消する
  ///   0=プロモーションバーコードであるが会員取消しない
  ///   -1=プロモーションバーコードでない
  /// 関連tprxソース: rcpromotion.c - rcClr_PromBarcode_Rec
  static int rcClrPromBarcodeRec(int num, int pntTyp) {
    int ret = -1;
    if (RcStl.rcChkItmRBufPromBarcodeRec(num)) {
      ret = 0;
      RegsMem mem = SystemFunc.readRegsMem();
      if (pntTyp == POINT_TYPE.PNTTYPE_HOUSEPOINT) {    // 自社ポイント
        // 会員系のプロモーションのみ取消に
        if (((mem.tItemLog[num].t50500Sts?.allCustFlg == LoyTgtCustType.ONE)    // 指定会員
            || (mem.tItemLog[num].t50500Sts?.allCustFlg == LoyTgtCustType.MBR)    // 会員全て
            || (mem.tItemLog[num].t50500Sts?.allCustFlg == LoyTgtCustType.BCD_ONE)    // 指定会員(バーコード)
            || (mem.tItemLog[num].t50500Sts?.allCustFlg == LoyTgtCustType.BCD_MBR))    // 会員全て(バーコード)
            && (mem.tItemLog[num].t50500?.custCardKind == pntTyp)) {
          mem.tItemLog[num].t11100Sts.mCancel = 1;	// 会員取消フラグセット
          ret = 1;
        }
      } else { // 各種共通ポイント
        if (mem.tItemLog[num].t50500?.custCardKind == pntTyp) {
          mem.tItemLog[num].t11100Sts.mCancel = 1;
          ret = 1;
        }
      }
    }

    return ret;
  }

  /// One to One プロモーションの会員向けのデータのみを削除する
  /// 引数: ポイント種別
  /// 関連tprxソース: rcpromotion.c - rcClr_OnetoOne_MbrData
  static Future<void> rcClrOneToOneMbrData(int pntTyp) async {
    RcPromBackupTtl bkTtl = RcPromBackupTtl();
    RcPromBackupItm bkItm = RcPromBackupItm();
    String callFunc = "RcPromotion.rcClrOneToOneMbrData()";
    RegsMem mem = SystemFunc.readRegsMem();
    int	itemNum = 0;
    int	loyNum = 0;
    int	setNum = 0;
    int	num = 0;

    // t106000
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Deleting MBR LOY");
    setNum = 0;
    for (loyNum=0; loyNum < mem.tTtllog.t100001Sts.loyPromTtlCnt; loyNum++) {
      if ((mem.tTtllog.t106000Sts[loyNum].allCustFlg == LoyTgtCustType.ALL.index)
          || (mem.tTtllog.t106000Sts[loyNum].allCustFlg == LoyTgtCustType.BCD_ALL.index)
          || (pntTyp != mem.tTtllog.t106000[loyNum].custCardKind)) {
        bkTtl.lT106000[setNum] = mem.tTtllog.t106000[loyNum];
        bkTtl.lT106000Sts[setNum] = mem.tTtllog.t106000Sts[loyNum];
        setNum++;
      }
      else {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "$callFunc: DEL MBR LOY (${loyNum + 1}) id[${mem.tTtllog
                .t106000[loyNum].cpnId}] cust[${mem.tTtllog.t106000Sts[loyNum]
                .allCustFlg}] typ[${mem.tTtllog.t106000Sts[loyNum]
                .svsTyp}]cls[${mem.tTtllog.t106000Sts[loyNum].schTyp}] rwd[${mem
                .tTtllog.t106000Sts[loyNum].rewardVal}][${mem.tTtllog
                .t106000Sts[loyNum].mulVal.toStringAsFixed(
                2)}] condref typ[${mem.tTtllog.t106000Sts[loyNum]
                .valFlg}]cls[${mem.tTtllog.t106000Sts[loyNum].refTyp}] lim[${mem
                .tTtllog.t106000Sts[loyNum].lowLim}][${mem.tTtllog
                .t106000Sts[loyNum].uppLim}] cnt[${mem.tTtllog
                .t106000Sts[loyNum].recLimit}][${mem.tTtllog.t106000Sts[loyNum]
                .dayLimit}][${mem.tTtllog.t106000Sts[loyNum]
                .maxLimit}] use[${mem.tTtllog.t106000Sts[loyNum].tdayCnt}][${mem
                .tTtllog.t106000Sts[loyNum].totalCnt}] rwdref[${mem.tTtllog
                .t106000Sts[loyNum].rewardFlg}] bcd[${mem.tTtllog
                .t106000Sts[loyNum].loyBcd}] card[${mem.tTtllog.t106000[loyNum]
                .custCardKind}]");
      }
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Details of updated LOY");
    mem.tTtllog.t106000 = List.generate(CntList.loyPromTtlMax, (_) => T106000());
    mem.tTtllog.t106000Sts = List.generate(CntList.loyPromTtlMax, (_) => T106000Sts());
    mem.tTtllog.t100001Sts.loyPromTtlCnt = setNum;
    for (loyNum=0; loyNum < mem.tTtllog.t100001Sts.loyPromTtlCnt; loyNum++) {
      mem.tTtllog.t106000[loyNum] = bkTtl.lT106000[loyNum];
      mem.tTtllog.t106000Sts[loyNum] = bkTtl.lT106000Sts[loyNum];
      mem.tTtllog.t106000Sts[loyNum].tdayCnt = 0;
      mem.tTtllog.t106000Sts[loyNum].totalCnt = 0;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "$callFunc: LOY (${loyNum + 1}) id[${mem.tTtllog
              .t106000[loyNum].cpnId}] cust[${mem.tTtllog.t106000Sts[loyNum]
              .allCustFlg}] typ[${mem.tTtllog.t106000Sts[loyNum]
              .svsTyp}]cls[${mem.tTtllog.t106000Sts[loyNum].schTyp}] rwd[${mem
              .tTtllog.t106000Sts[loyNum].rewardVal}][${mem.tTtllog
              .t106000Sts[loyNum].mulVal.toStringAsFixed(
              2)}] condref typ[${mem.tTtllog.t106000Sts[loyNum]
              .valFlg}]cls[${mem.tTtllog.t106000Sts[loyNum].refTyp}] lim[${mem
              .tTtllog.t106000Sts[loyNum].lowLim}][${mem.tTtllog
              .t106000Sts[loyNum].uppLim}] cnt[${mem.tTtllog
              .t106000Sts[loyNum].recLimit}][${mem.tTtllog.t106000Sts[loyNum]
              .dayLimit}][${mem.tTtllog.t106000Sts[loyNum]
              .maxLimit}] rwdref[${mem.tTtllog
              .t106000Sts[loyNum].rewardFlg}] bcd[${mem.tTtllog
              .t106000Sts[loyNum].loyBcd}] card[${mem.tTtllog.t106000[loyNum]
              .custCardKind}]");
    }

    // t106501
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Deleting MBR CPN");
    setNum = 0;
    for (loyNum=0; loyNum < mem.tTtllog.t100001Sts.cpnTtlCnt; loyNum++) {
      if ((mem.tTtllog.t106501Sts[loyNum].allCustFlg == LoyTgtCustType.ALL.index)
        || (mem.tTtllog.t106501Sts[loyNum].allCustFlg == LoyTgtCustType.BCD_ALL.index)
        || (pntTyp != mem.tTtllog.t106501[loyNum].custCardKind)) {
        bkTtl.cT106501[setNum] = mem.tTtllog.t106501[loyNum];
        bkTtl.cT106501Sts[setNum] = mem.tTtllog.t106501Sts[loyNum];
        setNum++;
      }
      else {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "$callFunc: DEL MBR CPN (${loyNum + 1}) id[${mem.tTtllog
                .t106501[loyNum].cpnId}] cust[${mem.tTtllog.t106501Sts[loyNum]
                .allCustFlg}] condref typ[${mem.tTtllog.t106501Sts[loyNum]
                .valFlg}]cls[${mem.tTtllog.t106501Sts[loyNum].refTyp}] lim[${mem
                .tTtllog.t106501Sts[loyNum].prnLowLim}][${mem.tTtllog
                .t106501Sts[loyNum].prnUppLim}] cnt[${mem.tTtllog
                .t106501Sts[loyNum].prnQty}][${mem.tTtllog.t106501Sts[loyNum]
                .tranQty}][${mem.tTtllog.t106501Sts[loyNum].dayQty}][${mem
                .tTtllog.t106501Sts[loyNum].ttlQty}] use[${mem.tTtllog
                .t106501Sts[loyNum].tdayCnt}][${mem.tTtllog.t106501Sts[loyNum]
                .totalCnt}] card[${mem.tTtllog.t106501[loyNum].custCardKind}]");
      }
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "$callFunc: Details of updated CPN");
    mem.tTtllog.t106501 = List.generate(CntList.othPromMax, (_) => T106501());
    mem.tTtllog.t106501Sts = List.generate(CntList.othPromMax, (_) => T106501Sts());
    mem.tTtllog.t100001Sts.cpnTtlCnt = setNum;
    for (loyNum=0; loyNum < mem.tTtllog.t100001Sts.cpnTtlCnt; loyNum++) {
      mem.tTtllog.t106501[loyNum] = bkTtl.cT106501[loyNum];
      mem.tTtllog.t106501Sts[loyNum] = bkTtl.cT106501Sts[loyNum];
      mem.tTtllog.t106501Sts[loyNum].tdayCnt = 0;
      mem.tTtllog.t106501Sts[loyNum].totalCnt = 0;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "CPN (${loyNum + 1}) id[${mem.tTtllog.t106501[loyNum]
              .cpnId}] cust[${mem.tTtllog.t106501Sts[loyNum]
              .allCustFlg}] condref typ[${mem.tTtllog.t106501Sts[loyNum]
              .valFlg}]cls[${mem.tTtllog.t106501Sts[loyNum].refTyp}] lim[${mem
              .tTtllog.t106501Sts[loyNum].prnLowLim}][${mem.tTtllog
              .t106501Sts[loyNum].prnUppLim}] cnt[${mem.tTtllog
              .t106501Sts[loyNum].prnQty}][${mem.tTtllog.t106501Sts[loyNum]
              .tranQty}][${mem.tTtllog.t106501Sts[loyNum].dayQty}][${mem.tTtllog
              .t106501Sts[loyNum].ttlQty}] card[${mem.tTtllog.t106501[loyNum]
              .custCardKind}]");
    }

    for (itemNum=0; itemNum < mem.tTtllog.t100001Sts.itemlogCnt; itemNum++) {
      bkItm = RcPromBackupItm();
      // t11200
      setNum = 0;
      for (loyNum=0; loyNum < mem.tItemLog[itemNum].t10000Sts.loyPromItemCnt; loyNum++) {
        if ((mem.tItemLog[itemNum].t11200Sts[loyNum]?.allCustFlg == LoyTgtCustType.ALL.index)
            || (mem.tItemLog[itemNum].t11200Sts[loyNum]?.allCustFlg == LoyTgtCustType.BCD_ALL.index)
            || (pntTyp != mem.tItemLog[itemNum].t11200[loyNum]?.custCardKind)) {
          bkItm.lT11200[setNum] = mem.tItemLog[itemNum].t11200[loyNum] ?? T11200();
          bkItm.lT11200Sts[setNum] = mem.tItemLog[itemNum].t11200Sts[loyNum] ?? T11200Sts();
          setNum++;
        }
      }
      mem.tItemLog[itemNum].t11200 = List.generate(CntList.loyPromTtlMax, (_) => T11200());
      mem.tItemLog[itemNum].t11200Sts = List.generate(CntList.loyPromTtlMax, (_) => T11200Sts());
      mem.tItemLog[itemNum].t10000Sts.loyPromItemCnt = setNum;
      for (loyNum=0; loyNum < mem.tItemLog[itemNum].t10000Sts.loyPromItemCnt; loyNum++) {
        mem.tItemLog[itemNum].t11200[loyNum] = bkItm.lT11200[loyNum];
        mem.tItemLog[itemNum].t11200Sts[loyNum] = bkItm.lT11200Sts[loyNum];
      }
      // t11210
      setNum = 0;
      for (loyNum=0; loyNum < mem.tItemLog[itemNum].t10000Sts.loyCondItemCnt; loyNum++) {
        if ((mem.tItemLog[itemNum].t11210Sts[loyNum] != null)
            && (mem.tItemLog[itemNum].t11210Sts[loyNum]?.cpnId != "")) {
          for (num=0; num < mem.tTtllog.t100001Sts.loyPromTtlCnt; num++) {
            if (mem.tItemLog[itemNum].t11210Sts[loyNum]?.cpnId == mem.tTtllog.t106000[num].loyPlanCd) {
              bkItm.lT11210Sts[setNum] = mem.tItemLog[itemNum].t11210Sts[loyNum]!;
              setNum++;
              break;
            }
          }
        }
      }
      mem.tItemLog[itemNum].t11210Sts = List.generate(CntList.loyPromTtlMax, (_) => T11210Sts());
      mem.tItemLog[itemNum].t10000Sts.loyCondItemCnt = setNum;
      for (loyNum=0; loyNum < mem.tItemLog[itemNum].t10000Sts.loyCondItemCnt; loyNum++) {
        mem.tItemLog[itemNum].t11210Sts[loyNum] = bkItm.lT11210Sts[loyNum];
      }
      // t11211
      setNum = 0;
      for (loyNum = 0; loyNum < mem.tItemLog[itemNum].t10000Sts.cpnCondItemCnt; loyNum++) {
        if ((mem.tItemLog[itemNum].t11211Sts[loyNum] != null)
            && (mem.tItemLog[itemNum].t11211Sts[loyNum]?.cpnId != "")) {
          for (num=0; num < mem.tTtllog.t100001Sts.cpnTtlCnt; num++) {
            if (mem.tItemLog[itemNum].t11211Sts[loyNum]?.cpnId == mem.tTtllog.t106501[num].cpnId) {
              bkItm.cT11211Sts[setNum] = mem.tItemLog[itemNum].t11211Sts[loyNum]!;
              setNum++;
              break;
            }
          }
        }
      }
      mem.tItemLog[itemNum].t11211Sts = List.generate(CntList.othPromMax, (_) => T11211Sts());
      mem.tItemLog[itemNum].t10000Sts.cpnCondItemCnt = setNum;
      for (loyNum = 0; loyNum < mem.tItemLog[itemNum].t10000Sts.cpnCondItemCnt; loyNum++) {
        mem.tItemLog[itemNum].t11211Sts[loyNum] = bkItm.cT11211Sts[loyNum];
      }
    }
  }
}

///関連tprxソース:rcpromotion.c - rcClr_OnetoOne_MbrData() - BackupTtl
class RcPromBackupTtl {
  List<T106000> lT106000 = List.generate(CntList.loyPromTtlMax, (_) => T106000());
  List<T106000Sts> lT106000Sts = List.generate(CntList.loyPromTtlMax, (_) => T106000Sts());
  List<T106501>	cT106501 = List.generate(CntList.othPromMax, (_) => T106501());
  List<T106501Sts> cT106501Sts = List.generate(CntList.othPromMax, (_) => T106501Sts());
}

///関連tprxソース:rcpromotion.c - rcClr_OnetoOne_MbrData() - BackupItm
class RcPromBackupItm {
  List<T11200> lT11200 = List.generate(CntList.loyPromTtlMax, (_) => T11200());
  List<T11200Sts> lT11200Sts = List.generate(CntList.loyPromTtlMax, (_) => T11200Sts());
  List<T11210Sts> lT11210Sts = List.generate(CntList.loyPromTtlMax, (_) => T11210Sts());
  List<T11211Sts> cT11211Sts = List.generate(CntList.othPromMax, (_) => T11211Sts());
}