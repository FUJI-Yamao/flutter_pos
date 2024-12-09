/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_aid.dart';
import '../apllib/cnct.dart';
import '../apllib/recog.dart';

class CmMbrSys {

  /// 顧客仕様ステータスフラグ (cm_mbr_system() の戻り値)
  /// 関連tprxソース:cm_mbr.h
  static const int MBR_STAT_COMMON = 1;  /* 顧客共通仕様 */
  static const int MBR_STAT_POINT = 2;   /* 顧客ポイント仕様 */
  static const int MBR_STAT_FSP = 4;     /* 顧客FSP仕様 */

  /// 顧客仕様のフラグを返す
  /// 戻値: 0:非顧客仕様 / MBR_STAT_COMMON MBR_STAT_POINT MBR_STAT_FSP
  /// 関連tprxソース:cmmbrsys.c - cm_mbr_system()
  static Future<int> cmMbrSystem(RxCommonBuf	pCom) async {
    int ret = 0;

    /* 共有メモリポインタの取得 */
    if (pCom == null) {
      return 0;
    }

    /* 顧客仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      ret |= MBR_STAT_COMMON;
    }

    /* 顧客ポイント仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERPOINT,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      ret |= MBR_STAT_POINT;
    }

    /* 顧客FSP仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERFSP,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      ret |= MBR_STAT_FSP;
    }

    return ret;
  }

  /// 戻値: 0:ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様 "しない"   1:ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様 "する"
  /// 関連tprxソース:cmmbrsys.c - cm_custreal_nec_system()
  static Future<int> cmCustrealNecSystem(int cnctchk) async {
    int	rec = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_NEC,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      rec = 1;
    }

    return((await cmMbrSystem(pCom) != 0) &&	/* member system?   */
        (rec != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
            CnctLists.CNCT_CUSTREALSVR_CNCT) != 0 || cnctchk != 0)) ? 1 : 0;
  }

  /// 戻値: 1:新アークス様システム   0 : 旧システム
  /// 関連tprxソース:cmmbrsys.c - cm_NewARCS_system()
  static Future<int> cmNewARCSSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (CompileFlag.ARCS_MBR) {
      return ((await cmCustrealNecSystem(1) != 0) &&
          (pCom.dbTrm.ralseMagFmt != 0)) ? 1 : 0;
    } else {
      return 0;
    }
  }

// TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 顧客リアル問い合わせ仕様のフラグを返す
  /// 関連tprxソース:cmmbrsys.c - cm_custrealsvr_system()
  /// 引数: なし
  /// 戻値: true : 顧客リアル問い合わせ仕様 "する", false : 顧客リアル問い合わせ仕様 "しない"
  static Future<bool> cmCustrealsvrSystem() async {
    return true;
  }

  /// ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様のフラグを返す(netDoAリアル顧客仕様)
  /// 関連tprxソース:cmmbrsys.c - cm_custreal_netdoa_system
  /// 引数: なし
  /// 戻値: true : ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様 "する", false : ﾀﾞｲﾚｸﾄﾎﾟｲﾝﾄ顧客仕様 "しない"
  static Future<bool> cmCustrealNetdoaSystem() async {
    bool recog = false;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_NETDOA, RecogTypes.RECOG_GETMEM))
    .result == RecogValue.RECOG_YES){
      recog = true;
    }

    return((await CmMbrSys.cmMbrSystem(pCom) == 1)
        && (recog)
        && (Cnct.cnctMemGet
            (Tpraid.TPRAID_SYSTEM,CnctLists.CNCT_CUSTREALSVR_CNCT) == 1));
  }

  /// 顧客コードの桁数を返す
  /// 戻値：顧客コードの桁数
  /// 関連tprxソース:cmmbrsys.c - cm_mbrcd_len
  static int cmMbrcdLen() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return pCom.mbrcdLength;
  }

  /// 関数：cm_mbrcd_len
  /// 機能：磁気カードNoの桁数を返す
  /// 引数：なし
  /// 戻値：顧客コードの桁数を返す。
  /// 関連tprxソース:cmmbrsys.c - cm_magcd_len
  static int cmMagcdLen() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (CompileFlag.ARCS_MBR) {
      return pCom.magcdLength;
    } else {
      if (pCom.magcdLength > Mcd.ASC_MCD_CD) {
        return pCom.magcdLength;
      } else {
        return Mcd.ASC_MCD_CD;
      }
    }
  }
}