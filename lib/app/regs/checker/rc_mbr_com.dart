/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/cm_ean/mk_cdig.dart';
import '../../lib/cm_jan/set_jinf.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_28dsp.dart';
import 'rc_flrda.dart';
import 'rc_itm_dsp.dart';
import 'rc_multi.dart';
import 'rc28itmdsp.dart';
import 'rcfncchk.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';


class RcMbrCom {
  /// 顧客仕様のフラグを返す
  /// 戻り値: 0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:rcmbrcom.c - rcmbrChkStat
  static Future<int> rcmbrChkStat() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (await Rxmbrcom.rcmbrChkStatWithPtrMain(pCom, RcRegs.rcInfoMem));
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcmbrcom.c - rc_MbrPrc_Set
  static int	rcMbrPrcSet(int fncCode, int dlgShow) {
    return 0;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_CrdtReceipt(short chk_flg)
  static Future<bool> rcChkCrdtReceipt(int chkFlg) async {
    int tendcd;
    KopttranBuff koptTran = KopttranBuff();
    RegsMem mem = SystemFunc.readRegsMem();

    if((!RcSysChk.rcChkSmartplusSystem()) && (!await RcSysChk.rcChkFSCaAutoPoint())){
      //#if ARCS_MBR
      if(!(await CmMbrSys.cmNewARCSSystem() != 0)){
        //#endif
        if(!RcSysChk.rcChkRalseCardSystem()) return false;
        if(!RcSysChk.rcChkJETBProcess()) return false;
        //#if ARCS_MBR
      }
      //#endif
    }

    for(int i=0; i<mem.tTtllog.t100001Sts.sptendCnt; i++){
      tendcd = mem.tTtllog.t100100[i].sptendCd;
      if(RcSysChk.rcChkKYCHA(tendcd)){
        await RcFlrda.rcReadKopttran(tendcd, koptTran);
        //#if SMARTPLUS
        if(((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 4))
            && (koptTran.crdtEnbleFlg == 1)){
          //#else
          //       if( (KOPTTRAN.crdt_typ       == 0) &&
          //           (KOPTTRAN.crdt_enble_flg == 1) )
          //#endif
          if(chkFlg != 0){
            int compareResult = RegsMem().tTtllog.t100100[tendcd].edyCd[0].compareTo("                ",);
            if(compareResult == 0) return true;
          }else{
            return true;
          }
          break;
        }
      }
    }
    return false;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_SuicaReceipt
  static Future<int> rcChkSuicaReceipt() async {
    int i;
    int tendcd;
    KopttranBuff koptTran = KopttranBuff();
    RegsMem mem = SystemFunc.readRegsMem();

    for(i=0; i<mem.tTtllog.t100001Sts.sptendCnt; i++){
      tendcd = mem.tTtllog.t100100[i].sptendCd;
      if(RcSysChk.rcChkKYCHA(tendcd)){
        await RcFlrda.rcReadKopttran(tendcd, koptTran);
        if((await RcSysChk.rcChkMultiSuicaSystem()) == MultiSuicaTerminal.SUICA_VEGA_USE.index){
          if((koptTran.crdtTyp == 26) && (koptTran.crdtEnbleFlg == 1)){
            return tendcd;
          }
        }else{
          if((koptTran.crdtTyp == 7) && (koptTran.crdtEnbleFlg == 1)){
            return tendcd;
          }
        }
      }
    }
    return -1;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcmbrcom.c - rcChk_CatCrdtReceipt
  static bool rcChkCatCrdtReceipt(int opeType){
    // int i;
    // int tendcd;
    // KopttranBuff koptTran = KopttranBuff();
    // TTtlLog ttlLog = TTtlLog();
    // int edyFlg = 0;
    // int edyCnt = 0;
    //
    // AtSingl? atSingl;
    // atSingl?.vescaEdyMaxErr = 0;
    //
    // bool gmoVegaSystemResult = await RcSysChk.rcsyschkGMOVEGASystem();
    //
    // if(RcSysChk.rcChkJETAStandardProcess()){
    //   for(i=0; i<ttlLog.t100001Sts.sptendCnt; i++){
    //     tendcd = ttlLog.t100100[i]!.sptendCd;
    //     if(RcSysChk.rcChkKYCHA(tendcd)){
    //       await RcFlrda.rcReadKopttran(tendcd, koptTran);
    //       if((((koptTran.crdtTyp == 0))
    //           || ((koptTran.crdtTyp == 2) && (CmCksys.cmCctConnectSystem() != 0))
    //           || ((koptTran.crdtTyp == 5) && (CmCksys.cmIDSystem() != 0))
    //           /* 交通系IC（Suica) CCT基本連動仕様 CCT電子マネー決済仕様 */
    //           || ((koptTran.crdtTyp == 7)
    //               && (CmCksys.cmCctConnectSystem() != 0)
    //               && (CmCksys.cmCctEmoneySystem() != 0))
    //           || ((koptTran.crdtTyp == 9) && (CmCksys.cmQUICPaySystem() != 0))
    //           || ((koptTran.crdtTyp == 22) && (cm_nanaco_system() != 0)))
    //           && (koptTran.crdtEnbleFlg == 1)){
    //         return true;
    //       }
    //     }
    //   }
    // }else if(RcSysChk.rcChkYtrmProcess()){
    //   for(i=0; i<ttlLog.t100001Sts.sptendCnt; i++){
    //     tendcd = ttlLog.t100100[i]!.sptendCd;
    //     if(RcSysChk.rcChkKYCHA(tendcd)){
    //       await RcFlrda.rcReadKopttran(tendcd, koptTran);
    //       if(((koptTran.crdtTyp == 0) || (koptTran.crdtTyp == 6))
    //           && (koptTran.crdtEnbleFlg == 1)){
    //         return true;
    //       }
    //       if((tendcd == FuncKey.KY_CASH) && (ttlLog.t100900?.vmcChgCnt != 0)){
    //         return true;
    //       }
    //     }
    //   }
    // }else if((RcSysChk.rcsyschkShopcraidProcess())
    //     || (gmoVegaSystemResult)){
    //   for(i=0; i<ttlLog.t100001Sts.sptendCnt; i++){
    //     tendcd = ttlLog.t100100[i]!.sptendCd;
    //     if(RcSysChk.rcChkKYCHA(tendcd)){
    //       await RcFlrda.rcReadKopttran(tendcd, koptTran);
    //       if((koptTran.crdtTyp == 0) && (koptTran.crdtEnbleFlg == 1)){
    //         return true;
    //       }
    //       if((tendcd == FuncKey.KY_CASH) && (ttlLog.t100900?.vmcChgCnt != 0)){
    //         return true;
    //       }
    //     }
    //   }
    // }else if(RcSysChk.rcsyschkVescaSystem()){
    //   if(cm_Vesca_MulPayUser_chk() != 0){
    //     CmAry.cmClr(koptTran.toString(), size);
    //   }
    // }else{
    //
    // }
    return false;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_Cha9Receipt
  static int rcChkCha9Receipt(){
    int i;
    int tendcd;

    if(!RcSysChk.rcChkRalseCardSystem()){
      return -1;
    }

    for(i=0; i < RegsMem().tTtllog.t100001Sts.sptendCnt; i++){
      tendcd = RegsMem().tTtllog.t100100[i].sptendCd;
      if(tendcd == FuncKey.KY_CHA9.keyId){
        return tendcd;
      }
    }
    return -1;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_iDReceipt
  static Future<int> rcChkIDReceipt() async {
    int i;
    int tendcd;
    KopttranBuff koptTran = KopttranBuff();

    if(!(await CmMbrSys.cmNewARCSSystem() != 0)){
      return -1;
    }

    for(i=0; i < RegsMem().tTtllog.t100001Sts.sptendCnt; i++){
      tendcd = RegsMem().tTtllog.t100100[i].sptendCd;
      if(RcSysChk.rcChkKYCHA(tendcd)){
        await RcFlrda.rcReadKopttran(tendcd, koptTran);
        if((koptTran.crdtTyp == 20) && (koptTran.crdtEnbleFlg == 1)){
          return tendcd;
        }
      }
    }
    return -1;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_PrepaidReceipt
  static Future<int> rcChkPrepaidReceipt() async {
    int i;
    int tendcd;
    KopttranBuff koptTran = KopttranBuff();
    RegsMem mem = SystemFunc.readRegsMem();

    if(!(await CmMbrSys.cmNewARCSSystem() != 0)){
      return -1;
    }

    for(i=0; i < mem.tTtllog.t100001Sts.sptendCnt; i++){
      tendcd = mem.tTtllog.t100100[i].sptendCd;
      if(RcSysChk.rcChkKYCHA(tendcd)){
        await RcFlrda.rcReadKopttran(tendcd, koptTran);
        if(((koptTran.crdtTyp == 6)
            || (koptTran.crdtTyp == 37)
            || (koptTran.crdtTyp == SPTEND_STATUS_LISTS.SPTEND_STATUS_COCONA.typeCd))
            && (koptTran.crdtEnbleFlg == 1)){
          return tendcd;
        }
      }
    }
    return -1;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_QUICPayReceipt
  static Future<int> rcChkQUICPayReceipt() async {
    int i;
    int tendcd;
    KopttranBuff koptTran = KopttranBuff();
    RegsMem mem = SystemFunc.readRegsMem();

    if(!(await CmMbrSys.cmNewARCSSystem() != 0)){
      if(!RcSysChk.rcChkRalseCardSystem()){
        return -1;
      }
      if(!RcSysChk.rcChkJETBProcess()){
        return -1;
      }
    }

    for(i=0; i < mem.tTtllog.t100001Sts.sptendCnt; i++){
      tendcd = mem.tTtllog.t100100[i].sptendCd;
      if(RcSysChk.rcChkKYCHA(tendcd)){
        await RcFlrda.rcReadKopttran(tendcd, koptTran);
        if(await CmMbrSys.cmNewARCSSystem() != 0){
          if((koptTran.crdtTyp == 19) && (koptTran.crdtEnbleFlg == 1)){
            return tendcd;
          }
        }else{
          if((koptTran.crdtTyp == 9) && (koptTran.crdtEnbleFlg == 1)){
            return tendcd;
          }
        }
      }
    }
    return -1;
  }

  // TODO:00012 平野 cmcksys関数　後で消す
  static int cm_nanaco_system(){
    return 0;
  }

  // TODO:00012 平野 cmcksys関数　後で消す
  static int cm_Vesca_MulPayUser_chk(){
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcmbrcom.c - rcProm_Alert_Msg
  static void rcPromAlertMsg(int funcCd) {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcmbrcom.c - rcmbr_Get_TrmPlanFlg
  static void rcmbrClearCustMem() {
    return;
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース: rcmbrcom.c - rcmbrClearModeStlDisp
  static void rcmbrClearModeStlDisp() {
    return;
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 顧客モード（会員販売）表示のクリア
  /// 関連tprxソース: rcmbrcom.c - rcmbrClearModeDisp
  static void rcmbrClearModeDisp() {
  }

  /// 磁気カードがOTHER_CO1かチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcmbrcom.c - rcChk_other_co1
  static bool rcChkOtherCo1() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO1);
  }

  /// 会員情報表示部のクリアーチェック
  /// 戻り値: true=クリアする  false=クリアしない
  /// 関連tprxソース: rcmbrcom.c - rcmbrcomChkClearModeStl
  static Future<bool> rcmbrcomChkClearModeStl() async {
    if (CompileFlag.ARCS_MBR) {
      if ((await RcFncChk.rcCheckStlMode()) ||
          (await RcFncChk.rcCheckESVoidSMode())) {
        return true;
      }
      return false;
    }
    if (await CmCksys.cmMarutoSystem() != 0) {
      if ((await RcFncChk.rcCheckStlMode()) ||
          (await RcFncChk.rcCheckESVoidSMode())) {
        return true;
      }
      return false;
    }
    return true;  // 通常仕様はクリアする
  }

  /// 自動割戻(チケット, 割戻小計値引, 置数無し手動割戻)の単位を返す関数
  /// （通常はターミナル設定値を返すが, 顧客ごとに設定されている場合はそちらの値を返す）
  /// 戻り値: 自動割戻の単位
  /// 関連tprxソース: rcmbrcom.c - rcmbr_Get_AutoRbtUnit
  static int rcmbrGetAutoRbtUnit() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    if ((cBuf.dbTrm.streSvsMthdUse == 0) &&
        (mem.tTtllog.t100700Sts.privatePntSvsTyp != 0) &&
        (mem.tTtllog.t100700Sts.privatePntSvsLimit > 0)) {
      return mem.tTtllog.t100700Sts.privatePntSvsLimit;	 // 顧客別の割戻単位(顧客問合せ時に取得した値)
    }
    return cBuf.dbTrm.tcktAutoRvtUnit;  // ターミナル設定値
  }

  /// ポイント利用数の上限値を返す
  /// 戻り値: ポイント利用数の上限値
  /// 関連tprxソース: rcmbrcom.c - rcGet_PntUseLimit
  static int rcGetPntUseLimit() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    return cBuf.dbTrm.pntUseLimit;
  }

  /// 割増倍率の値を返す
  /// (通常はターミナル設定値を返すが, スケジュールで設定されている値がある場合はそちらの値を返す)
  /// 戻り値: 割増倍率
  /// 関連tprxソース: rcmbrcom.c - rcmbr_Get_PointAddMagn
  static double	rcmbrGetPointAddMagn(int trmCd) {
    RegsMem mem = SystemFunc.readRegsMem();

    for (int num = 0; num < mem.tTtllog.t100001Sts.reflectCnt; num++) {
      if (mem.tTtllog.t102500Sts[num].reflectCd == trmCd) {
        return mem.tTtllog.t102500Sts[num].reflectVal;
      }
    }
    return (-1.00);
  }

  /// 会員番号かチェックする
  ///  注) 値数データを参照する
  /// 戻り値: true=会員コード / false=会員コードではない
  /// 関連tprxソース: rcmbrcom.c - rcmbrChkMbrCode
  static Future<bool> rcmbrChkMbrCode() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingl = SystemFunc.readAtSingl();

    if (await CmCksys.cmDs2GodaiSystem()!= 0) {
      if (Dummy.rcmbrCkDigitDs2(cMem.working.janInf.code) == Typ.OK) {
        return true;
      } else {
        return false;
      }
    }

    if (await RcSysChk.rcChkZHQsystem() && (await RcMbrCom.rcmbrChkStat()) != 0) {
      if (atSingl.inputbuf.Acode[0] == 'K' &&
          (atSingl.inputbuf.barcd_len - 1) == CmMbrSys.cmMbrcdLen()) {
        return true;
      } else if (cMem.ent.tencnt == CmMbrSys.cmMbrcdLen()) {
        return true;
      }
      return false;
    }

    // TODO:00002 佐野 - 顧客呼出 暫定処理（手入力での番号入力を通すため、固定値を設定する）
    cMem.working.janInf.type = JANInfConsts.JANtypeMbr13;  //暫定処理
    //SetJinf.cmSetJanInf(cMem.working.janInf, 1, RcRegs.CHKDGT_CALC);  //既存処理
    switch (cMem.working.janInf.type) {
      case JANInfConsts.JANtypeMbr8:
      case JANInfConsts.JANtypeMbr82:
      case JANInfConsts.JANtypeMbr13:
      case JANInfConsts.JANtypeMbr19Ikea:
      case JANInfConsts.JANtypeMbrNw7L:
      case JANInfConsts.JANtypeMbrNw713:
        return true;
      default:
        break;
    }

    return false;
  }

  /// 顧客バーコード入力のチェック
  /// 引数:[data] 入力データ
  /// 引数:[flag] 顧客バーコードフラグ
  /// 引数:[bcdTyp] 会員バーコードタイプ(顧客ターミナル)
  /// 戻り値: 1=顧客バーコード / 0=顧客バーコード以外 / 負数=顧客バーコードが不正
  /// 関連tprxソース: rcmbrcom.c - ChkMbrBarcd
  static int chkMbrBarcd(String data, int flag, int bcdTyp) {
    List<int> flgbuf = [];
    int stat = 0;

    if (flag <= 0) {
      return 0;
    }

    if (Dummy.chkMbrCdTenCntLimit()) {
      return -1;
    }

    flgbuf = flag.toString().codeUnits;

    /* 顧客バーコード入力？ */
    if (bcdTyp == 1) {
      if (data.substring(5) == flgbuf.toString()) {
        stat = 1;
        if (barcdLen(data) != 8 && bcdTyp == 1) {
          stat = -1;
        }
      }
    } else {
      if (data.substring(0, 2) == flgbuf.toString()) {
        stat = 1;
        if (barcdLen(data) != CmMbrSys.cmMbrcdLen() && bcdTyp == 0) {
          stat = -1;
        }
      }
    }

    return stat;
  }

  /// 顧客呼出番号入力の桁数チェック
  /// 戻り値: 0=入力桁数OK / 0以外=入力桁数NG
  /// 関連tprxソース: rcmbrcom.c - ChkMbrNo_TenCnt_Limit
  static bool chkMbrNoTenCntLimit() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((CmMbrSys.cmMbrcdLen() - 2 - 1) < cMem.ent.tencnt) || (0 == cMem.ent.tencnt);
  }

  /// レシートバッファに顧客データがあるかを返す
  /// 戻り値: true=顧客データあり / false=顧客データなし
  /// 関連tprxソース: rcmbrcom.c - rcmbrChkCust
  static bool rcmbrChkCust() {
    RegsMem regsMem = SystemFunc.readRegsMem();
    return Dummy.rcmbrChkCustWithPtr(regsMem);
  }

  /// チェックディジットをチェックする
  /// 引数: JANコード
  /// 戻り値: エラーメッセージ（0=エラーなし）
  /// 関連tprxソース: rcmbrcom.c - rcChk_magcd_digit
  static int rcChkMagcdDigit(String magno) {
    int wErrMsg; /* Error Message Number */
    String ckdigitWait = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    int magLen = (cBuf.dbTrm.othcmpMagEfctNo - 1) > 0
        ? cBuf.dbTrm.othcmpMagEfctNo
        : 8;
    ckdigitWait = "21212121212121212121".substring(0, magLen - 1);

    if (('${Dummy.cmW2Modulas10(
                magno + (CmMbrSys.cmMbrcdLen() - 1).toString(),
                ckdigitWait,
                magLen)}0') == magno.substring(CmMbrSys.cmMbrcdLen() - 1)) {
      wErrMsg = 0;
    } else {
      wErrMsg = DlgConfirmMsgKind.MSG_CDERR.dlgId;
    }
    return wErrMsg;
  }

  /// 顧客バーコード入力のチェック
  /// 引数:[data] 入力データ
  /// 引数:[flag] 掛売バーコードフラグ
  /// 戻り値: 1=掛売バーコード / 0=掛売バーコード以外 / 負数=掛売バーコードが不正
  /// 関連tprxソース: rcmbrcom.c - rc_Chk_Receiv_Barcd
  static int rcChkReceivBarcd(String data, int flag) {
    List<int> flgbuf = [];
    int stat = 0;

    if (flag <= 0) {
      return 0;
    }

    if (Dummy.chkMbrCdTenCntLimit()) {
      return -1;
    }

    flgbuf = flag.toString().codeUnits;

    /* 掛売バーコード入力？ */
    if (data.substring(0, 2) == flgbuf.toString()) {
      stat = 1;
      if (barcdLen(data) != CmMbrSys.cmMbrcdLen()) {
        stat = -1;
      }
    }

    return stat;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChkMember_RCpdsc
  static bool rcChkMemberRCpdsc(String custNo) {
    String wk = '';
    bool ret = false;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    wk = custNo.substring(5);
    if (cBuf.dbTrm.rcdscCardNo == int.parse(wk) &&
        custNo.substring(2, 5) == '999') {
      ret = true;
    }

    return ret;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChkMember_Staffpdsc
  static bool rcChkMemberStaffpdsc(String custNo) {
    String wk = '';
    bool ret = false;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;

    wk = custNo.substring(5);
    if (cBuf.dbTrm.staffdscCardNo == int.parse(wk) &&
        custNo.substring(2, 5) == '999') {
      ret = true;
    }
    return ret;
  }

  /// 会員番号の作成
  /// 引数:[src] 元会員コード
  ///  注) 同一アドレスの指定は可能
  /// 戻り値:[int] エラーメッセージ（0=正常終了)
  /// 戻り値:[String] 作成した会員番号のバッファ
  /// 関連tprxソース: rcmbrcom.c - rcmbrMakeMbrCode
  static Future<(int, String)> rcmbrMakeMbrCode(String src) async {
    // TODO:10155 顧客呼出 - 疑似サーバー対応の為、会員番号は入力値のまま返す
    String ret = src;  //暫定対応
    /*
    String ret = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (0, ret);
    }
    RxCommonBuf cBuf = xRet.object;

    int mbrcdLen = CmMbrSys.cmMbrcdLen();
    if (cBuf.dbTrm.loasonNw7mbr != 0) {
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if (await CmCksys.cmDcmpointSystem() != 0) {
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if (await RcSysChk.rcChkHt2980System()) {
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if (await RcSysChk.rcChkZHQsystem()) {
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if (await CmCksys.cmDs2GodaiSystem() != 0) {	/* ゴダイ様特注 */
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if ((await RcSysChk.rcChkChargeSlipSystem()) &&
        (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3)) {
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if (await CmCksys.cmSm36SanprazaSystem() != 0) {
      ret = src.padRight(mbrcdLen, "0");
      return (0, ret);
    }
    if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
      int errNo = rcChkTRUMbrCardCD(src);
      if (errNo != 0) {
        return (errNo, ret);
      } else {
        ret = src.padRight(mbrcdLen, "0");
        return (0, ret);
      }
    }

    /* 元データのコピー */
    String buf = src;
    int bcdTyp = cBuf.dbTrm.memBcdTyp;
    int mbrFlg = rcmbrGetMbrBarFlg();
    int formatNo = 0;   /* format number */
    for (int idx = 0; idx < RxMem.DB_INSTRE_MAX; idx++) {
      if (cBuf.dbInstre[idx].format_typ == 3) { /* バーコードタイプが顧客 */
        formatNo = cBuf.dbInstre[idx].format_no;
        break;
      }
    }

    int bcdStat = chkMbrBarcd(src, mbrFlg, bcdTyp);
    if (RcSysChk.rcsyschkYunaitoHdSystem() != 0) {
      if (bcdStat != 1) {
        //入力したバーコードが会員ではない場合、掛売バーコードかどうかを判定する
        mbrFlg = rcmbrGetReceivBarFlg();
        bcdStat = rcChkReceivBarcd(src, mbrFlg);
      }
    }

    String pBuf = "";
    String flgBuf = "";
    if (bcdStat < 0) {
      /* バーコードタイプが不正 */
      return (DlgConfirmMsgKind.MSG_INPUTERR.dlgId, ret);
    } else if (bcdStat != 0) { 		/* 顧客バーコード？ */
      ret = src.padLeft(mbrcdLen, "0");
    } else {
      if (chkMbrNoTenCntLimit()) {
        return (DlgConfirmMsgKind.MSG_INPUTERR.dlgId, ret);
      }
      /* 顧客バーコードを作る */
      int length = barcdLen(buf);
      if (bcdTyp == 1) {			/* 顧客バーコード８桁 */
        if (formatNo == 10) {
          if (length > 5) {
            return (DlgConfirmMsgKind.MSG_INPUTERR.dlgId, ret);
          }
          pBuf = buf.substring(5);
        } else if (formatNo == 11) {
          if (length  > 6) {
            return (DlgConfirmMsgKind.MSG_INPUTERR.dlgId, ret);
          }
          pBuf = buf.substring(4);
        }
      } else {					/* 顧客バーコード１３桁 */
        if (length > mbrcdLen - 2 - 1) {
          return (DlgConfirmMsgKind.MSG_INPUTERR.dlgId, ret);
        }
        pBuf = buf;
      }
      flgBuf = "$mbrFlg".padLeft(2, "0");
      pBuf = flgBuf;

      String tmpBuf = "";
      for (int idx = 0; idx < mbrcdLen; idx++) {
        if ((idx >= buf.length) || (int.tryParse(buf[idx]) == null)) {
          tmpBuf += "0";  /* ゼロパティング */
        } else {
          tmpBuf += buf[idx];
        }
      }
      buf = MkCdig().cmMkCdigitVariable(tmpBuf, CmMbrSys.cmMbrcdLen());
      ret = buf.padRight(mbrcdLen, "0");
    }
     */
    return (0, ret);
  }

  /// データの文字数を返す(頭の'0'は文字数に含めない)
  /// 引数:文字列
  /// 戻り値: データの文字数
  /// 関連tprxソース: rcmbrcom.c - barcdlen
  static int barcdLen(String data) {
    int maxLen = data.length;
    int cnt = 0;

    for (cnt=0; cnt<maxLen; cnt++) {
      if (data.indexOf("0", cnt) != 0) {
        break;
      }
    }
    return (maxLen - cnt);
  }

  /// 顧客バーコードフラグを返す
  /// 戻り値: 0=掛売バーコード入力 / 0以上=掛売バーコードフラグ / 負数=入力エラー
  /// 関連tprxソース: rcmbrcom.c - rcmbrGetMbrBarFlg
  static int rcmbrGetMbrBarFlg() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    int ret = 0;
    for (int idx = 0; idx < RxMem.DB_INSTRE_MAX; idx++) {
      if (cBuf.dbInstre[idx].format_typ == 3) { /* バーコードタイプが顧客 */
        ret = int.parse(cBuf.dbInstre[idx].instre_flg);
        break;
      }
    }
    return ret;
  }

  /// 掛売バーコードフラグを返す
  /// 戻り値: 0=掛売バーコード入力 / 0以上=掛売バーコードフラグ / 負数=入力エラー
  /// 関連tprxソース: rcmbrcom.c - rcmbrGetReceivBarFlg
  static int rcmbrGetReceivBarFlg() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    int ret = 0;
    for (int idx = 0; idx < RxMem.DB_INSTRE_MAX; idx++) {
      if (cBuf.dbInstre[idx].format_no == JANformat_CHARGE_SLIP) { /* バーコードタイプが顧客 */
        ret = int.parse(cBuf.dbInstre[idx].instre_flg);
        break;
      }
    }
    return ret;
  }

  /// 顧客ステータスフラグ別にアイテムログステータス（分類値下）を設定する
  /// 関連tprxソース: rcmbrcom.c - rcMbr_MemberClsPDscSet
  static void rcMbrMemberClsPDscSet() {
    RegsMem mem = SystemFunc.readRegsMem();

    for (int i = 0; i < mem.tTtllog.t100001Sts.itemlogCnt; i++) {
      switch (mem.tTtllog.t100700Sts.mbrTyp) {
        case 1:
        case 5:
          mem.tItemLog[i].t10500Sts.uclsPrgDscAmt = 0;
          mem.tItemLog[i].t10500Sts.uclsPrgPdscPer = 0;
          mem.tItemLog[i].t10003.uclsPrc = 0;
          mem.tItemLog[i].t10500Sts.ucMprgDscAmt = 0;
          mem.tItemLog[i].t10500Sts.ucMprgPdscPer = 0;
          mem.tItemLog[i].t10003.ucMprc = 0;
          mem.tItemLog[i].t10500.clsDscFlg = mem.tmpbuf.rcClspdsc[i].staffClsTyp;
          mem.tItemLog[i].t10500.clsPlanCd = mem.tmpbuf.rcClspdsc[i].staffClsPlanCd;
          switch (mem.tItemLog[i].t10500.clsDscFlg) {
            case 2:  //MbrClsDscFlg.NORMAL_CLS_DSC.value
              mem.tItemLog[i].t10500Sts.ucMprgDscAmt  = mem.tmpbuf.rcClspdsc[i].staffDsc;
              break;
            case 3:  //MbrClsDscFlg.NORMAL_CLS_PDSC.value
              mem.tItemLog[i].t10500Sts.ucMprgPdscPer  = mem.tmpbuf.rcClspdsc[i].staffPdsc as double;
              break;
            case 1:  //MbrClsDscFlg.NORMAL_CLS_PRC.value
              mem.tItemLog[i].t10003.ucMprc  = mem.tmpbuf.rcClspdsc[i].staffPrc;
              break;
            default:
              break;
          }
          break;
        case 2:
        case 6:
          mem.tItemLog[i].t10500Sts.uclsPrgDscAmt = 0;
          mem.tItemLog[i].t10500Sts.uclsPrgPdscPer = 0;
          mem.tItemLog[i].t10003.uclsPrc = 0;
          mem.tItemLog[i].t10500Sts.ucMprgDscAmt = 0;
          mem.tItemLog[i].t10500Sts.ucMprgPdscPer = 0;
          mem.tItemLog[i].t10003.ucMprc = 0;
          mem.tItemLog[i].t10500.clsDscFlg = mem.tmpbuf.rcClspdsc[i].rcClsTyp;
          mem.tItemLog[i].t10500.clsPlanCd = mem.tmpbuf.rcClspdsc[i].rcClsPlanCd;
          switch (mem.tItemLog[i].t10500.clsDscFlg) {
            case 2:  //MbrClsDscFlg.NORMAL_CLS_DSC.value
              mem.tItemLog[i].t10500Sts.ucMprgDscAmt  = mem.tmpbuf.rcClspdsc[i].rcDsc;
              break;
            case 3:  //MbrClsDscFlg.NORMAL_CLS_PDSC.value
              mem.tItemLog[i].t10500Sts.ucMprgPdscPer  = mem.tmpbuf.rcClspdsc[i].rcPdsc as double;
              break;
            case 1:  //MbrClsDscFlg.NORMAL_CLS_PRC.value
              mem.tItemLog[i].t10003.ucMprc  = mem.tmpbuf.rcClspdsc[i].rcPrc;
              break;
            default:
              break;
          }
          break;
        default:
          mem.tItemLog[i].t10500Sts.uclsPrgDscAmt = 0;
          mem.tItemLog[i].t10500Sts.uclsPrgPdscPer = 0;
          mem.tItemLog[i].t10003.uclsPrc = 0;
          mem.tItemLog[i].t10500Sts.ucMprgDscAmt = 0;
          mem.tItemLog[i].t10500Sts.ucMprgPdscPer = 0;
          mem.tItemLog[i].t10003.ucMprc = 0;
          mem.tItemLog[i].t10500.clsDscFlg = mem.tmpbuf.rcClspdsc[i].mbrClsTyp;
          mem.tItemLog[i].t10500.clsPlanCd = mem.tmpbuf.rcClspdsc[i].mbrClsPlanCd;
          switch(mem.tItemLog[i].t10500.clsDscFlg) {
            case 2:  //MbrClsDscFlg.NORMAL_CLS_DSC.value
              mem.tItemLog[i].t10500Sts.uclsPrgDscAmt = mem.tmpbuf.rcClspdsc[i].dsc;
              mem.tItemLog[i].t10500Sts.ucMprgDscAmt  = mem.tmpbuf.rcClspdsc[i].mbrDsc;
              break;
            case 3:  //MbrClsDscFlg.NORMAL_CLS_PDSC.value
              mem.tItemLog[i].t10500Sts.uclsPrgPdscPer = mem.tmpbuf.rcClspdsc[i].pdsc as double;
              mem.tItemLog[i].t10500Sts.ucMprgPdscPer  = mem.tmpbuf.rcClspdsc[i].mbrPdsc as double;
              break;
            case 1:  //MbrClsDscFlg.NORMAL_CLS_PRC.value
              mem.tItemLog[i].t10003.uclsPrc = mem.tmpbuf.rcClspdsc[i].prc;
              mem.tItemLog[i].t10003.ucMprc  = mem.tmpbuf.rcClspdsc[i].mbrPrc;
              break;
            default:
              break;
          }
          break;
      }
    }
  }

  /// アヤハディオ仕様のアイテムがあるかチェックする
  /// 戻り値: true=あり  false=なし
  /// 関連tprxソース: rcmbrcom.c - rcChk_AyahaItmSch
  static bool rcChkAyahaItmSch() {
    if (!RcSysChk.rcsyschkAyahaSystem()) {
      return false;;
    }
    if (RcSysChk.rcVDOpeModeChk()) {
      return false;;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    if (RcFncChk.rcCheckRegistration() &&
        (RxLogCalc.rxCalcStlTaxInAmt(mem) < 0)) {
      return false;;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_REF.keyId])) {
      return false;;
    }

    if ((mem.tmpbuf.ayaha.brgnschPromNo1 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo2 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo3 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo4 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo5 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo6 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo7 != 0) ||
        (mem.tmpbuf.ayaha.brgnschPromNo8 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo1 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo2 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo3 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo4 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo5 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo6 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo7 != 0) ||
        (mem.tmpbuf.ayaha.pluschPromNo8 != 0)) {
      return true;
    }

    return false;;
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// TRUメンバーカードの有効期限をチェックする
  /// 引数: 会員コード
  /// 戻り値: エラーコード
  /// 関連tprxソース: rcmbrcom.c - rcChk_TRU_MbrCard_CD
  static int rcChkTRUMbrCardCD(String mbrNo) {
    return Typ.OK;
  }

  /// 登録の画面モードを取得する
  /// 戻値: RG：登録 / VD：訂正 / TR：訓練 / SR：廃棄
  /// 関連tprxソース: rcmbrcom.c - rcmbrGetOpeMode
  static int rcmbrGetOpeMode() {
    AcMem cMem = SystemFunc.readAcMem();
    return cMem.stat.opeMode;
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// 記念日該当のフラグを返す
  ///   注)トータルログの日付データ比較
  /// 戻り値: 0=該当なし / RCMBR_ANVKIND_1 ～ RCMBR_ANVKIND_5 の論理和
  /// 関連tprxソース: rcmbrcom.c - rcmbrChkAnvKind
  static int rcmbrChkAnvKind() {
    return 0;
  }

  /// 関連tprxソース: rcmbrcom.c - rcChk_Watari_HouseCard
  static bool rcChkWatariHouseCard(int stat) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();

    String compCd = "${(cBuf.dbRegCtrl.cardCompCd % 10000)}".padLeft(4, "0");
    if (stat == 1) {
      if (mem.tTtllog.t100010.invoiceNo.substring(4, 8) == compCd.substring(0, 4)) {
        return true;
      } else {
        return false;
      }
    } else {
      if (mem.tmpbuf.rcarddata.jis2.substring(10, 14) == compCd.substring(0, 4)) {
        return true;
      } else {
        return false;
      }
    }
  }

    //実装は必要だがARKS対応では除外
    /// 関連tprxソース:rcmbrcom.c - rcChkMember_ChargeSlipCard
    static int rcChkMemberChargeSlipCard() {
      return 0;
    }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcmbrcom.c rcChk_Vesca_Receipt
  static int rcChkVescaReceipt(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcmbrcom.c -rcChkMember_ChargeSlipCard2
  static bool rcChkMemberChargeSlipCard2(){
    return true;
  }
}