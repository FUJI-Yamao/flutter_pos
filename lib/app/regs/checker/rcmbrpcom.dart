/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import 'rc_mbr_com.dart';
import 'rcmbrpoical.dart';

class RcMbrPcom {
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 手動割戻を締め操作として使用する時の金種種別を返す。
  /// 関連tprxソース: rcmbrpcom.c - rcmbr_GetManualRbtKeyCd(void)
  /// 引数   : なし
  /// 戻り値 : 0:しない,
  ///         KY_CHA1～KY_CHA10:会計１～会計１０,
  ///         KY_CHK1～KY_CHK5 :品券１～品券５
  static int rcmbrGetManualRbtKeyCd(){
    int fncCode = 0;
    return fncCode;
  }

  /// 関連tprxソース: rcmbrpcom.c - rcmbr_GetManualRbtKeyCdForPointUse
  static int rcmbrGetManualRbtKeyCdForPointUse() {
    ///TODO:00014 日向 現計対応 定義のみ先行して追加
    return 0;
  }

  /// 現使用締め操作キーが手動割戻時の締め操作キー指定と同一かチェックする
  /// 戻り値: 指定キーの総計
  /// 関連tprxソース: rcmbrpcom.c - rcmbr_ManualRbtCashPoint
  static int rcmbrManualRbtCashPoint() {
    int ret = 0;
    int fncCd = rcmbrGetManualRbtKeyCd();
    RegsMem mem = SystemFunc.readRegsMem();
    for (int i = 0; i < mem.tTtllog.t100001Sts.sptendCnt; i++) {
      if (fncCd == mem.tTtllog.t100100[i].sptendCd) {
        ret += mem.tTtllog.t100100[i].sptendData;
      }
    }

    return ret;
  }

  /// トータルログに利用ポイントをセットする
  /// 引数:[sbsMthd] 割戻方式
  /// 引数:[usePoint] 利用ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpcom.c - rcmbr_PTtlSet_UsePoint
  static Future<void> rcmbrPTtlSetUsePoint(
      int sbsMthd, int usePoint, TTtlLog ttllog) async {
    switch (sbsMthd) {
      case 1:  /* 確定チケット */
      case 2:  /* 確定自動   */
      case 3:  /* 確定手動   */
      case 4:  /* 確定モニタ */
        setDuppTtlrv(usePoint);
        break;
      case 5:  /* 即時チケット */
      case 6:  /* 即時自動   */
      case 7:  /* 即時手動   */
      case 8:  /* 即時モニタ */
        await setDuptTtlrv(usePoint, ttllog);
        break;
      default:
        break;
    }
  }

  /// トータルログに本日可能利用ポイントをセットする
  /// 引数:[usePoint] 利用ポイント
  /// 関連tprxソース: rcmbrpcom.c - Set_DuppTtlrv
  static void setDuppTtlrv(int usePoint) {
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.calcData.duppTtlrv = usePoint;
  }

  /// トータルログに本日累計利用ポイントをセットする
  /// 引数:[usePoint] 利用ポイント
  /// 引数:[ttllog] トータルログバッファ
  /// 関連tprxソース: rcmbrpcom.c - Set_DuptTtlrv
  static Future<void> setDuptTtlrv(int usePoint, TTtlLog ttllog) async {
    RegsMem mem = SystemFunc.readRegsMem();

    ttllog.t100701.duptTtlrv = usePoint;
    if ((await CmCksys.cmDcmpointSystem() != 0) &&
        (ttllog.t100701.duptTtlrv != 0)) {
      if (ttllog.t100701.duptTtlrv >= mem.tTtllog.t100700Sts.webrealsrvExpPoint) {
        ttllog.t100900.spPoint = mem.tTtllog.t100700Sts.webrealsrvExpPoint;
      } else {
        ttllog.t100900.spPoint = ttllog.t100701.duptTtlrv;
      }
    }
    await RcMbrPoiCal.rcmbrSetUseAccountData();	// アカウント利用実績をセット
  }

  /// 顧客が選択されているかチェックする
  /// 戻り値: true=選択中  false=未選択
  /// 関連tprxソース: rcmbrpcom.c - rcmbr_PChkSelMbr
  static bool rcmbrPChkSelMbr() {
    /* 顧客コードが入っているかで選択されているかチェック */
    if (RcMbrCom.rcmbrChkCust() != 0) {
      return true;
    }
    return false;
  }

  /// サービス種別から割戻対象ポイントを返す
  /// 引数: サービス種別
  /// 戻り値: 割戻対象ポイント
  /// 関連tprxソース: rcmbrpcom.c - Get_ObjRbtPoint
  static int rcmbrGetObjRbtPoint(int sbsMthd) {
    int objRbtPoint = 0;
    RegsMem mem = SystemFunc.readRegsMem();

    switch (sbsMthd) {
      case 1:  /* 確定サービスチケット */
      case 2:  /* 確定自動 */
      case 3:  /* 確定手動 */
      case 4:  /* 確定モニタ */
        /* 可能ポイント */
        if (RcMbrCom.rcmbrChkCust() != 0) {
          objRbtPoint = mem.tTtllog.calcData.lpptTtlsrv;
        }
        break;
      case 5:  /* 即時サービスチケット */
      case 6:  /* 即時自動 */
      case 7:  /* 即時手動 */
      case 8:  /* 即時モニタ */
        /* 累計ポイント */
        if (RcMbrCom.rcmbrChkCust() != 0) {
          objRbtPoint = mem.tTtllog.t100700.lpntTtlsrv;
        }
        break;
      default:
        break;
    }
    objRbtPoint -= mem.tTtllog.t100700Sts.mulrbtPnt;

    return objRbtPoint;
  }
}