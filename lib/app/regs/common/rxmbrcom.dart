/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_calc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/mcd.dart';
import '../../lib/apllib/recog.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_tpoint.dart';

class Rxmbrcom {

  /// 機能：楽天ポイントカード読み取り済みかチェック
  /// 引数：REGSMEM *regsmem : レシートバッファ
  /// 戻値： 0:読み取りなし、1:読み取り済み
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_ChkRpointRead()
  static bool rxmbrcomChkRpointRead(RegsMem regsmem) {
    if((regsmem.tTtllog.t100790.inputTyp ?? 0 ) > 0){
      return true;
    }
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 非会員ポイント(対象額)印字チェック
  /// 関連tprxソース: rxmbrcom.c - rcmbr_NotMbr_PoiPrnChk()
  /// 引数：なし
  /// 戻値：true:印字する  false:印字しない
  static bool rcmbrNotMbrPoiPrnChk(){
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// [共通ポイント向け]指定ファンクションキーがポイント利用時ファンクションキーと同一か判断し
  /// 該当する対象ポイント種別を返す。
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_ManualRbtKey_PointKind()
  /// 引数 : int fncCode: ファンクションコード
  ///       RxCommonBuf pCom: 共有メモリ
  /// 戻値 : -1: 該当する対象ポイント種別なし, -1以外: 該当した対象ポイント種別
  static int rxmbrcomManualRbtKeyPointKind(int funcCode, RxCommonBuf pCom){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    RxCommonBuf pCom = xRet.object;

    if(funcCode == rxmbrcomChkComPointUseKey(POINT_TYPE.PNTTYPE_RPOINT, pCom)){
      return(POINT_TYPE.PNTTYPE_RPOINT);
    }else if(funcCode == rxmbrcomChkComPointUseKey(POINT_TYPE.PNTTYPE_TPOINT, pCom)){
      return(POINT_TYPE.PNTTYPE_TPOINT);
    }

    return POINT_TYPE.PNTTYPE_NON;
  }

  /// [共通ポイント向け]ポイント利用時に使用する会計キー/品券キーを返す
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_ChkComPointUseKey
  /// 引数 : int pntTyp: ポイント種別
  ///       RxCommonBuf pCom: 共有メモリ
  /// 戻値 : 0: ポイント利用時に使用する会計キー/品券キーなし,
  ///       0以外: ポイント利用時に使用する会計キー/品券キーのファンクションコード
  static int rxmbrcomChkComPointUseKey(int pntTyp, RxCommonBuf pCom){
    int fncCd = 0;
    int chkCd = 0;

    if(pntTyp == POINT_TYPE.PNTTYPE_RPOINT){
      chkCd = pCom.dbTrm.rpntUseKey;
    }else if(pntTyp == POINT_TYPE.PNTTYPE_TPOINT){
      chkCd = pCom.dbTrm.tpntUseKey;
    }else if(pntTyp == POINT_TYPE.PNTTYPE_DPOINT){
      chkCd = pCom.dbTrm.dpntUse;
    }

    if((chkCd >= 1) && (chkCd <= 10)){
      fncCd = chkCd - 1;
      fncCd += FuncKey.KY_CHA1.keyId;
    }else if((chkCd >= 11) && (chkCd <= 15)) {
      fncCd = chkCd - 11;
      fncCd += FuncKey.KY_CHK1.keyId;
    }else if((chkCd >= 16) && (chkCd <= 35)){
      fncCd = chkCd - 16;
      fncCd += FuncKey.KY_CHA11.keyId;
    }

    return fncCd;
  }

  /// 関連tprxソース: rxmbrcom.c - rcChk_MemberTyp
  static Future<bool> rcChkMemberTyp(int typ, RegsMem pRct) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    // TODO:00012 平野　pc_bufに構造体情報をリンクさせている？　不要かは要確認
    // rxMemPtr(RXMEM_COMMON, (void **)&pc_buf);

    if(pCom.dbTrm.ralseMagFmt != 0){
      switch(pRct.tTtllog.t100700Sts.mbrTyp){
        case Mcd.MCD_RLSSTAFF:
          if(pRct.tTtllog.t100700Sts.mbrTyp != typ){
            return false;
          }
          break;
        case Mcd.MCD_RLSCARD:
        case Mcd.MCD_RLSCRDT:
        case Mcd.MCD_RLSVISA:
        case Mcd.MCD_RLSHOUSE:
        case Mcd.MCD_RLSPREPAID:
          if(Mcd.MCD_RLSCRDTONLY == typ){
            if(await CmMbrSys.cmNewARCSSystem() != 0){
              if((Mcd.MCD_RLSVISA != typ) && (Mcd.MCD_RLSCRDT != typ)){
                return false;
              }else{
                if(pRct.tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSCRDT){
                  return false;
                }
              }
            }
          }else if(Mcd.MCD_RLSCRDT == typ){
            if((Mcd.MCD_RLSVISA != typ) && (Mcd.MCD_RLSCRDT != typ)){
              return false;
            }
          }else if((Mcd.MCD_RLSCARD != typ)
              && (Mcd.MCD_RLSVISA != typ)
              && (Mcd.MCD_RLSHOUSE != typ)
              && (Mcd.MCD_RLSPREPAID != typ)
              && (Mcd.MCD_RLSCRDT != typ)){
            return false;
          }
          break;
  //#if RALSE_CREDIT
        case Mcd.MCD_RLSOTHER:
          if(pRct.tTtllog.t100700Sts.mbrTyp != typ){
            return false;
          }
          break;
  //#end if
        default:
          return false;
      }
    }
    return true;
  }

  /// 機能：顧客仕様のフラグを返す
  /// 引数：RX_COMMON_BUF *pCom
  /// 戻値：0:非顧客仕様 / RCMBR_STAT_COMMON RCMBR_STAT_POINT RCMBR_STAT_FSP
  /// 関連tprxソース: rcmbrcom.c - rcmbrChkStatWithPtr()
  static Future<int> rcmbrChkStatWithPtr(RxCommonBuf? pCom) async {
    return(await rcmbrChkStatWithPtrMain(pCom, null));
  }

  /// 顧客仕様のフラグを返す（メイン）
  /// 引数:[pCom] 共有メモリ（RxCommonBufクラス）
  /// 引数:[pInfo] 共有メモリ（RcInfoMemListsクラス）
  /// 戻り値: 0:上記ではない  1:上記仕様
  /// 関連tprxソース: rxmbrcom.c - rcmbrChkStatWithPtrMain()
  static Future<int> rcmbrChkStatWithPtrMain(RxCommonBuf? pCom, RcInfoMemLists? pInfo) async {
    int ret;

    if (pCom == null) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf pCom = xRet.object;
    }

    ret = 0;
    // TODO:00002 佐野 - RcInfoMemListsクラスへの値設定が無効の為、当クラスの判定を無効化
    /*
    if (pInfo != null) {
      /* 顧客仕様判定 */
      if (pInfo.rcRecog.recogMembersystem > 0) {
        ret |= RcMbr.RCMBR_STAT_COMMON;
      }
      /* 顧客ポイント仕様判定 */
      if (pInfo.rcRecog.recogMemberpoint > 0) {
        if (await rcmbrGetSvsMthd(pCom, null) != 0) {
          ret |= RcMbr.RCMBR_STAT_POINT;
        }
      }
      /* 顧客FSP仕様判定 */
      if (pInfo.rcRecog.recogMemberfsp > 0) {
        if (pCom!.dbTrm.memAnyprcStet != 0) {
          ret |= RcMbr.RCMBR_STAT_FSP;
        }
      }
      return ret;
    }
     */

    /* 顧客仕様判定 */
    if ((await Recog().recogGet(0, RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      ret |= RcMbr.RCMBR_STAT_COMMON;
    }
    /* 顧客ポイント仕様判定 */
    if ((await Recog().recogGet(0, RecogLists.RECOG_MEMBERPOINT,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      if (await rcmbrGetSvsMthd(pCom, null) != 0) {
        ret |= RcMbr.RCMBR_STAT_POINT;
      }
    }
    /* 顧客FSP仕様判定 */
    if ((await Recog().recogGet(0, RecogLists.RECOG_MEMBERFSP,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      if (pCom!.dbTrm.memAnyprcStet != 0) {
        ret |= RcMbr.RCMBR_STAT_FSP;
      }
    }
    return ret;
  }

  /// 割戻方式の値を返す
  /// 引数:[pCom] 共有メモリ（RxCommonBufクラス）
  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: 割り当て方式
  /// 関連tprxソース: rcmbrcom.c - rcmbr_Get_SvsMthd
  static Future<int> rcmbrGetSvsMthd(RxCommonBuf? pCom, RegsMem? regsMem) async {
    int flg;
    flg = await rcmbrGetTrmPlanFlg(pCom, regsMem);

    if ((flg == TrmPlanAcctFl.TRMPLAN_ACCT_MANU.index)
        || (flg == TrmPlanAcctFl.TRMPLAN_ACCT_PORTAL_MANU.index)) {
      return 7; // 手動割戻
    }
    else if ((flg == TrmPlanAcctFl.TRMPLAN_ACCT_AUTO.index)
        || (flg == TrmPlanAcctFl.TRMPLAN_ACCT_PORTAL_AUTO.index)) {
      return 6; // 自動割戻
    }
    else if ((flg == TrmPlanAcctFl.TRMPLAN_ACCT_TCKT.index)
        || (flg == TrmPlanAcctFl.TRMPLAN_ACCT_PORTAL_TCKT.index)) {
      return 5; // チケット発行　
    }
    else {
      return 0; // しない
    }
  }

  /// 共有メモリに格納されるターミナルマスタより、割戻方式の値を返す
  /// 引数:[pCom] 共有メモリ（RxCommonBufクラス）
  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: 割り当て方式
  /// 関連tprxソース: rcmbrcom.c - rcmbr_Get_TrmPlanFlg
  static Future<int> rcmbrGetTrmPlanFlg(RxCommonBuf? pCom, RegsMem? regsMem) async {
    int trmPlanFlg = 0;

    if (pCom!.dbTrm.sbsMthd == 0) {
      return trmPlanFlg; // しない
    }

    switch (pCom.dbTrm.sbsMthd) {
      case 5:
        trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_TCKT.index;
        break;
      case 6:
        trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_AUTO.index;
        break;
      case 7:
        trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_MANU.index;
        break;
    }

    if ((pCom.dbTrm.streSvsMthdUse == 0)
        && (regsMem != null)) {
      switch (regsMem.tTtllog.t100700Sts.privatePntSvsTyp) {
        case 1:
          trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_PORTAL_TCKT.index;
          break;
        case 2:
          trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_PORTAL_AUTO.index;
          break;
        case 3:
          trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_PORTAL_MANU.index;
          break;
        default:
          break;
      }
    }
    if ((await CmCksys.cmShopAndGoSystem() != 0)
        && (await CmCksys.cmQCashierSystem() != 0)
        && (pCom.iniMacInfo.select_self.qc_mode == 1)) {
      switch (pCom.dbTrm.sagSbsMthd) // Shop&Go精算機でのターミナル方式
      {
        case 1: // 必ず即時自動割戻にする
          trmPlanFlg = TrmPlanAcctFl.TRMPLAN_ACCT_AUTO.index;
          break;
        default:
          break;
      }
    }
    return trmPlanFlg;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_PromPurchaseCond
  static int rxmbrcomPromPurchaseCond() {
    return 0;
  }

  /// 処理概要：Tポイントカード読み取り済みかチェック
  /// パラメータ：レシートバッファ　
  /// 戻り値： 結果
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_ChkTpointRead
  static int rxmbrcomChkTpointRead(RegsMem regsMem) {
    if (regsMem.tTtllog.t100715.mbrInput != TPointInputTyp.tPointInputNone.index) {
      return 1;
    }
    return 0;
  }

  /// 友の会カード読み取り済みかチェック
  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: true=読み取り済み  false=読み取りなし
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_ChkTomoRead
  static bool rxmbrcomChkTomoRead(RegsMem mem) {
    if (mem.tTtllog.t100904.flg != 0) {    // 0:未使用 1:読込済 2:利用済
      return true;
    }
    return false;
  }

  /// 会員氏名を返却する
  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: 会員氏名
  /// 関連tprxソース: rxmbrcom.c - rcmbr_Get_MbrFullName
  static String rcmbrGetMbrFullName(RegsMem mem) {
    String ret = mem.tTtllog.t100700.mbrNameKanji1;
    if ((ret.isNotEmpty) && (mem.tTtllog.t100700.mbrNameKanji2.isNotEmpty)) {
      ret += " ";  // 姓と名の間に半角スペースを入れる
    }
    ret += mem.tTtllog.t100700.mbrNameKanji2;

    return ret;
  }

  /// 会員住所を返却する
  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: 会員住所
  /// 関連tprxソース: rxmbrcom.c - rcmbr_Get_MbrAddress
  static String rcmbrGetMbrAddress(RegsMem mem) {
    return (mem.tTtllog.t100700.adrs1 + mem.tTtllog.t100700.adrs2 +
        mem.tTtllog.t100700.adrs3);
  }

  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: true=上記仕様　　false=上記仕様でない
  /// 関連tprxソース: rxmbrcom.c - rcChk_PointOneUnder_System
  static Future<bool> rcChkPointOneUnderSystem(RegsMem regsMem) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (((await rcmbrChkStatWithPtr(cBuf)) & RcMbr.RCMBR_STAT_POINT != 0) &&
        ((rcmbrGetSvsMthd(cBuf, regsMem) == 0) ||
            (rcmbrGetSvsMthd(cBuf, regsMem) == 5)) &&
        (cBuf.dbTrm.tcktIssuAmt != 0));
  }

  /// Tポイントカード読み取り済みかチェック
  /// 引数:[regsMem] 共有メモリ（RegsMemクラス）参照フラグ
  /// 戻り値: true=読取済み　　false=未読取
  /// 関連tprxソース: rxmbrcom.c - rxmbrcom_ChkTpointRead
  static bool rcChkTpointRead(RegsMem regsMem) {
    if (regsMem.tTtllog.t100715.mbrInput != TPointInputTyp.tPointInputNone.index) {
      return true;
    }
    return false;
  }
}