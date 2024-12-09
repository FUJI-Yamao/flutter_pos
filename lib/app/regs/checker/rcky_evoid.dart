/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import 'rc_flrda.dart';
import 'rcfncchk.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcky_evoid.c
class RckyEVoid {
  /// 返金方法をEdyから現金に変換する
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Edy_to_Cash_Chg()
  static void eVoidEdyToCashChg() {
    RegsMem mem = SystemFunc.readRegsMem();
    int tendCd = 0;

    for (int i=0; i<CntList.sptendMax; i++) {
      tendCd = mem.tTtllog.t100100[i].sptendCd;
      if ((tendCd >= FuncKey.KY_CHA1.keyId)
          && (tendCd <= FuncKey.KY_CHA30.keyId)) {
        if (eVoidChkEdyKeyOpt(tendCd)) {
          mem.tTtllog.t100200[AmtKind.amtCash.index].cnt += eVoidGetEdyChaCnt(tendCd);
          mem.tTtllog.t100200[AmtKind.amtCash.index].amt += eVoidGetEdyChaAmt(tendCd);
          eVoidGetEdyChaQty(tendCd);
          mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt += eVoidGetEdyChaDrw(tendCd);
          mem.tTtllog.t100100[i].sptendCd  = FuncKey.KY_CASH.index;
          mem.tTtllog.t100100[i].edyCd = " ";
          mem.tTtllog.t100200[AmtKind.amtCash.index].kyCd = FuncKey.KY_CASH.index;
        }
      }
    }
    mem.tTtllog.t100002.edyAlarmCnt = 0;
    mem.tTtllog.t100002.edyAlarmAmt = 0;

    return;
  }

  /// Edy仕様かつ掛売許可仕様かチェックする
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Chk_Edy_Key_Opt()
  static bool eVoidChkEdyKeyOpt(int sptendCd) {
    KopttranBuff kOptTran = KopttranBuff();
    RcFlrda.rcReadKopttran(sptendCd, kOptTran);

    return ((kOptTran.crdtEnbleFlg == 1)    //掛売許可？
        && ((kOptTran.crdtTyp == 2) || (kOptTran.crdtTyp == 18)));    //Edy仕様？
  }

  /// ログ定義クラス_在高のカウンタを返し、初期化する（Edy）
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 戻値: ログ定義クラス_在高のカウンタ
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Get_Edy_Cha_Cnt()
  static int eVoidGetEdyChaCnt(int sptendCd) {
    int chaCnt = 0;

    RegsMem mem = SystemFunc.readRegsMem();
    for (int i=0; Rxkoptcmncom.rxkindChaList[i] != -1; i++) {
      if (Rxkoptcmncom.rxkindChaList[i] == sptendCd) {
        chaCnt = mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].cnt;
        mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].cnt = 0;
        break;
      }
    }
    return chaCnt;
  }

  /// ログ定義クラス_在高の実在高を返し、初期化する
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 戻値: ログ定義クラス_在高の実在高
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Get_Edy_Cha_Amt()
  static int eVoidGetEdyChaAmt(int sptendCd) {
    int chaAmt = 0;

    RegsMem mem = SystemFunc.readRegsMem();
    for (int i=0; Rxkoptcmncom.rxkindChaList[i] != -1; i++) {
      if (Rxkoptcmncom.rxkindChaList[i] == sptendCd) {
        chaAmt = mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].amt;
        mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].amt = 0;
        break;
      }
    }
    return chaAmt;
  }

  /// ログ定義クラス_在高の枚数を初期化する
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Get_Edy_Cha_Qty()
  static void eVoidGetEdyChaQty(int sptendCd) {
    RegsMem mem = SystemFunc.readRegsMem();
    for (int i=0; Rxkoptcmncom.rxkindChaList[i] != -1; i++) {
      if (Rxkoptcmncom.rxkindChaList[i] == sptendCd) {
        mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].sht = 0;
        break;
      }
    }
  }

  /// ログ定義クラス_在高の理論在高を返し、初期化する
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 戻値: ログ定義クラス_在高の理論在高
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Get_Edy_Cha_Drw()
  static int eVoidGetEdyChaDrw(int sptendCd) {
    int chaDrw = 0;

    RegsMem mem = SystemFunc.readRegsMem();
    for (int i=0; Rxkoptcmncom.rxkindChaList[i] != -1; i++) {
      if (Rxkoptcmncom.rxkindChaList[i] == sptendCd) {
        chaDrw = mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].drwAmt;
        mem.tTtllog.t100200[RxLogCalc.rcCheckFuncAmtTyp(Rxkoptcmncom.rxkindChaList[i])].drwAmt = 0;
        break;
      }
    }
    return chaDrw;
  }

  /// 返金方法をYamatoから現金に変換する
  /// 引数:[fncCd] ファンクションコード
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Yamato_to_Cash_Chg()
  static Future<void> eVoidYamatoToCashChg(FuncKey fncCd) async {
    RegsMem mem = SystemFunc.readRegsMem();
    var tendCd = List<int>.generate(CntList.sptendMax, (index) => 0);

    if (RcSysChk.rcsyschkVescaSystem()) {
      for (int i=0; i<CntList.sptendMax; i++) {
        tendCd[i] = mem.tTtllog.t100100[i].sptendCd;
        if (RcSysChk.rcChkKYCHA(tendCd[i])) {
          if (await eVoidChkVescaKeyOpt(tendCd[i], fncCd)) {
            mem.tTtllog.t100200[AmtKind.amtCash.index].cnt += eVoidGetEdyChaCnt(tendCd[i]);
            mem.tTtllog.t100200[AmtKind.amtCash.index].amt += eVoidGetEdyChaAmt(tendCd[i]);
            eVoidGetEdyChaQty(tendCd[i]);
            mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt += eVoidGetEdyChaDrw(tendCd[i]);
            eVoidSetYamatoChaTendCode(i);
            mem.tTtllog.t100200[AmtKind.amtCash.index].kyCd = FuncKey.KY_CASH.index;
          }
        }
      }
    } else {
      for (int i=0; i<CntList.sptendMax; i++) {
        tendCd[i] = mem.tTtllog.t100100[i].sptendCd;
        if (RcSysChk.rcChkKYCHA(tendCd[i])) {
          if (eVoidChkYamatoKeyOpt(tendCd[i])) {
            mem.tTtllog.t100200[AmtKind.amtCash.index].cnt += eVoidGetEdyChaCnt(tendCd[i]);
            mem.tTtllog.t100200[AmtKind.amtCash.index].amt += eVoidGetEdyChaAmt(tendCd[i]);
            eVoidGetEdyChaQty(tendCd[i]);
            mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt += eVoidGetEdyChaDrw(tendCd[i]);
            eVoidSetYamatoChaTendCode(i);
            mem.tTtllog.t100200[AmtKind.amtCash.index].kyCd = FuncKey.KY_CASH.index;
          }
          if (eVoidChkSuicaKeyOpt(tendCd[i])) {
            eVoidClrNimocaTendCode(i);
          }
        }
      }
    }
    return;
  }

  /// Yamato仕様かつ掛売許可仕様かチェックする
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Chk_Yamato_Key_Opt()
  static bool eVoidChkYamatoKeyOpt(int sptendCd) {
    KopttranBuff kOptTran = KopttranBuff();
    RcFlrda.rcReadKopttran(sptendCd, kOptTran);

    return ((kOptTran.crdtEnbleFlg == 1)    //掛売許可
        && ((kOptTran.crdtTyp == 2) ||      //Edy
            (kOptTran.crdtTyp == 7) ||      //Suica
            (kOptTran.crdtTyp == 21) ||     //WAON
            (kOptTran.crdtTyp == 22) ||     //nanaco
            (kOptTran.crdtTyp == 23)));     //電子マネー
  }

  /// 指定インデックスのスプリットテンダリングコードを「預り／現計」に設定する（Yamato）
  /// 引数:[num] スプリットテンダリングコードリストのインデックス
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Set_Yamato_Cha_TendCode()
  static void eVoidSetYamatoChaTendCode(int num) {
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.t100100[num].sptendCd = FuncKey.KY_CASH.index;
  }

  /// Vesca仕様かつ掛売許可仕様かチェックする
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 引数:[fncCd] ファンクションキー
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Chk_vesca_Key_Opt()
  static Future<bool> eVoidChkVescaKeyOpt(int sptendCd, FuncKey fncCd) async {
    if (await CmCksys.cmZHQSystem() == 1) {
      return false;
    }
    bool checkFlg = false;
    KopttranBuff kOptTran = KopttranBuff();
    RcFlrda.rcReadKopttran(sptendCd, kOptTran);

    if ((kOptTran.crdtEnbleFlg == 1)    // 掛売許可
        && ((kOptTran.crdtTyp == 2)     // Edy
            || (kOptTran.crdtTyp == 5)	// iD
            || (kOptTran.crdtTyp == 6)	// プリペイド
            || (kOptTran.crdtTyp == 7)	// 交通系
            || (kOptTran.crdtTyp == 9)	// QUICPay
            || (kOptTran.crdtTyp == 10)	// PiTaPa
            || (kOptTran.crdtTyp == 21)	// WAON
            || (kOptTran.crdtTyp == 22)   // nanaco
            || (kOptTran.crdtTyp == 37)	// レピカ
            || (kOptTran.crdtTyp == SPTEND_STATUS_LISTS.SPTEND_STATUS_COCONA.typeCd))	// cocona
    ) {
      checkFlg = true;
    }

    if (RcFncChk.rcfncchkVescaEmoneyRefSystem()) {
      if (fncCd == FuncKey.KY_RCPT_VOID) {
        // 通番訂正のみ対応
        if ((kOptTran.crdtEnbleFlg ==  1)     // 掛売許可
            && ((kOptTran.crdtTyp == 5)  	    // iD
                || (kOptTran.crdtTyp == 9)	  // QUICPay
                || (kOptTran.crdtTyp == 10)))	// PiTaPa
        { // 現金返金にしない
          return false;
        }
      }
    }

    return checkFlg;
  }


  /// Suica仕様かつ掛売許可仕様かチェックする
  /// 引数:[sptendCd] スプリットテンダリングコード
  /// 戻値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Chk_Suica_Key_Opt()
  static bool eVoidChkSuicaKeyOpt(int sptendCd) {
    KopttranBuff kOptTran = KopttranBuff();
    RcFlrda.rcReadKopttran(sptendCd, kOptTran);

    return((kOptTran.crdtEnbleFlg == 1)  // 掛売許可
        && (kOptTran.crdtTyp == 7));     // Suica
  }

  /// 指定インデックスのスプリットテンダリング各種コードを初期化する（Nimoca）
  /// 引数:[num] スプリットテンダリングコードリストのインデックス
  /// 関連tprxソース:rcky_qctckt.c - EVoid_Clr_nimoca_TendCode()
  static void eVoidClrNimocaTendCode(int num) {
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.calcData.mnyTtl = 0;
    mem.tTtllog.t100100[num].cpnBarCd = " ";
    mem.tTtllog.t100100[num].edyCd = " ";
  }

  /// 関連tprxソース:rcky_qctckt.c - rcEVoid_PopUp()
  // TODO:00004 小出　定義のみ追加
  static void rcEVoidPopUp(int err_no) {
    // DialogErr(err_no, 1);
    // EVoid.Dialog = 4;
  }

}