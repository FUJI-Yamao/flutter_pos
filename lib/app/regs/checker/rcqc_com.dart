/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import 'rc_atct.dart';
import 'rc_flrda.dart';
import 'rc_qc_dsp.dart';
import 'rc_reserv.dart';
import 'rccatalina.dart';
import 'rcky_qctckt.dart';
import 'rcnoteplu.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcqc_com.c
class RcQcCom {

  static const int _OK = 0;

  static int qcSlctBtnFlg = 0;    // qc_slct_btn_flg
  static int qcInqudispCtrl = 0;    // qc_inqudisp_ctrl

  static int qc_acracb_flg = 0;
  static int qc_slct_btn_flg = 0;
  static int qc_now_lang_typ = 0;
  static int qc_err_staffcall = 0;
  static int qc_err_2nderr = 0;
  static int qc_err_3nderr = 0;
  static int qc_start_sound_end = 0;
  static int qc_txt_read_err_flg = 0;
  static int qc_paturn_chg_flg = 0;
  static int qc_season_chg_flg = 0;
  static int qc_now_paturn = 0;
  static int qc_now_season = 0;
  static int qc_now_season_bak = 0;
  static int qc_com_screen = 0;
  static int qc_bak_screen = 0;
  static int qc_elmny_flg = 0;
  static int qc_force_balance= 0;
  static int qc_alarm_typ= 0;
  static int qc_alarm_flag = 0;
  static int qc_sign_ctrl = 0;
  static int qc_signp_fast_flg = 0;
  static int qc_ope_mode_flg = 0;
  static int prt_type = 0;
  static int qc_start_flg = 0;
  static int qc_charge_flg = 0;
  static int qc_charge_act_flg = 0;
  static int qc_nimoca_not_have = 0;
  static int qc_nimoca_read = 0;
  static int qc_inqudisp_ctrl = 0;
  static int qc_nimoca_change_read = 0;
  static int qc_check_sptend_tran = 0;
  static int qc_chachk_ent_data = 0;
  static int qc_chachk_receipt = 0;
  static int qc_nimoca_cashreturn_read = 0;
  static int qc_chachk_last_check = 0;
  static int qc_chachk_chg = 0;
  static int qc_charge_alarm = 0;
  static int qc_charge_endchk = 0;
  static int qc_crdt_backbtn = 0;
  static int qc_err_recover_flg = 0;
  static int qc_2nd_err_wait = 0;
  static int qc_vesca_alarm_flg = 0;
  static int qc_nimoca_suica_lack = 0;
  static int qc_only_charge = 0;
  static int qc_charge_settle = 0;
  static int qc_chachk_spcnt = 0;
  static int qc_chachk_code = 0;
  static int qc_3rd_err_dsp_flg = 0;	//rcQC_Staff_Dsp()内でダイアログを呼ぶ場合かつ3rderrを表示中のフラグ
  static int qc_preca_charge_flg = 0;	/* プリカチャージのみを実施する設定のフラグ */
  static int qc_preca_charge_limit_amt = 0;	/* 単体プリカチャージ時は-1,割込チャージ時は不足額がセットされる値。プリカチャージの実施中確認にも使用 */
//static int qc_vesca_lack_charge = 0;
  static int qc_voice_ctrl_flg = 0;
  static int qc_payrfd_msg = 0;
  static int sag_regbag_input_flg = 0;
  static int qc_vega_lack_flag = 0;
  static int qc_preca_charge_resume_err_flg = 0;		/* プリペイド 割込チャージ完了後の仮締呼出中フラグ */
  static int qc_preca_charge_resume_err_status = 0;		/* プリペイド 割込チャージ完了後の仮締呼出パラメータ */

  /// 関連tprxソース: rcqc_com.c - rcQC_Movie_Stop()
  static void rcQCMovieStop() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    int	i;
    int j;
    String log = "";

    TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, "QCashier: rcQC_Movie_Stop");

    RcQcCom.rcQCMovieGtkTimerRemove();

    for (j = 0; j < 10; j++) {
      cBuf.scrmsgFlg = RcQcDsp.QC_MOVIE_STOP;
      if ( j > 0 ) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,  "QCashier: rcQC_Movie_Stop Retry\n");
      }

      for (i = 0; i < RcQcDsp.QC_MOVIE_RETRY; i++) {
        if(cBuf.scrmsgFlg == RcQcDsp.QC_MOVIE_NON_ACT) {
          log = sprintf("QCashier : Movie Stop[%d]", [i]);
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, log);
          break;
        }
        else {
          cBuf.scrmsgFlg = RcQcDsp.QC_MOVIE_STOP;
          TprMacro.usleep(RcQcDsp.QC_MOVIE_WAIT);
        }
      }
      if(cBuf.scrmsgFlg == RcQcDsp.QC_MOVIE_NON_ACT) {
        break;
      }
    }

    if(cBuf.scrmsgFlg != RcQcDsp.QC_MOVIE_NON_ACT) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal, "QCashier: C_BUF->scrmsg_flg != QC_MOVIE_NON_ACT !!");
    }
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_Sound_Stop()
  static void rcQCSoundStop() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return;
    //
    // rcQCSnd_GtkTimerRemove();
    // if( qc_start_sound_end == 0 ) {
    //   TprLibLogWrite( GetTid(), TPRLOG_NORMAL, 1, "QCashier: rcQC_Sound_Stop qc_start_sound_end Set 1\n");
    //   qc_start_sound_end = 1;
    // }
    //
    // if (rcsyschk_happy_smile())
    // {
    //   rcSoundStop_fself(0);
    // }
    // else
    // {
    //   rcSound_Stop();
    // }
  }

  /// 関連tprxソース: rcqc_com.c - rcQCMovie_GtkTimerRemove()
  static int rcQCMovieGtkTimerRemove() {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return _OK;
  }

  /// 多言語対応仕様であるかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcqc_com.c - rcCheck_LangSlct_System()
  static Future<bool> rcCheckLangSlctSystem() async {
    int errNo;

    if (await RcSysChk.rcSysChkHappySmile()) {
      // err_no = rcChk_Ky_LangChg();
      errNo = Dummy.rckyLangchgUseCheck();
      if (errNo == _OK) {
        return true;
      }
    } else {
      if (QCashierIni().lang_chg_max > 1) {
        return true;
      }
    }
    return false;
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_Led_Com()
  /// TODO:00010 長田 定義のみ追加
  static void	rcQCLedCom(
      int no, int color, int disp, int on_time, int off_time, int time) {
    return ;
  }

  /// 関連tprxソース: rc_qcdsp.h - rcQC_LED_ALL_OFF
  static void rcQcLedAllOff(QcLedNo typ, String fncName) {
    return rcQCLedAllOFF2(typ, fncName);
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_LED_ALL_OFF2
  /// TODO:定義のみ追加
  static void rcQCLedAllOFF2(QcLedNo typ, String fncName) {}

  /// 関連tprxソース: rcqc_com.c - rcQCBz_GtkTimerRemove()
  /// TODO:00010 長田 定義のみ追加
  static int rcQCBzGtkTimerRemove() {
    return 0;
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_MovieFile_Set()
  /// TODO:00010 長田 定義のみ追加
  static void rcQCMovieFileSet(int screen) {
    return ;
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_Movie_Start()
  /// TODO:00010 長田 定義のみ追加
  static void rcQCMovieStart() {
    return ;
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_Sound()
  /// TODO:00010 長田 定義のみ追加
  static int rcQCSound(int screen, int sound_no) {
    return 0;
  }

  /// 処理概要：釣銭機エラー復旧ガイダンス制御用フラグのセット
  /// パラメータ：呼出元ファンクション
  /// 戻り値：なし
  /// 関連tprxソース: rcqc_com.c - rcqc_err_recover_set()
  static Future<void> rcQCErrRecoverSet(String funcName) async {
    if (CmCksys.cmAcxErrGuiSystem() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "$funcName : qc_err_recover_flg Set");
      qc_err_recover_flg = 1;
    }
  }

  /// スプリットデータを設定する
  /// 関連tprxソース: rcqc_com.c - rc_NotePlu_SPData_Set
  static Future<void> rcNotePluSPDataSet() async {
    if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    int autoSpTendCnt = 0;

    if (RcCatalina.cmCatalinaSystem(0)) {
      if (cBuf.dbTrm.catalineKeyCd == cBuf.dbTrm.catalinacpnKeyCd) {
        if ((mem.tmpbuf.catalinaTtlamt != 0)  || (mem.tmpbuf.catalinaTtlqty != 0)) {
          autoSpTendCnt++;
        }
      } else {
        if ((mem.tmpbuf.catalinaStore != 0) || (mem.tmpbuf.catalinaStoreqty != 0)) {
          autoSpTendCnt++;
        }
        if ((mem.tmpbuf.catalinaManufact != 0) || (mem.tmpbuf.catalinaManufactqty != 0)) {
          autoSpTendCnt++;
        }
      }
    }

    if (mem.tTtllog.t100001Sts.sptendCnt != autoSpTendCnt) {
      return;
    }
    if (mem.tmpbuf.notepluTtlamt == 0) {
      return;
    }

    int bkFncCd = cMem.stat.fncCode;
    AcMem wcMem = cMem;
    AtSingl atSing = SystemFunc.readAtSingl();
    if (mem.tmpbuf.catalinaTtlamt == 0) {
      mem.tTtllog.calcData.stlTaxAmt += mem.tmpbuf.notepluTtlamt;
    }
    cMem.working.dataReg.kMan0 = 0;
    cMem.stat.fncCode = atSing.notePluKind;

    KopttranBuff kOptTran = KopttranBuff();
    int nochgFlg = 0;
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kOptTran);
    if ((kOptTran.nochgFlg != 0) && (kOptTran.tranUpdateFlg == 0)) {
      nochgFlg = 1;
    } else {
      nochgFlg = 0;
    }

    int notepluChgFlg = 0;
    if ((mem.tmpbuf.notepluTtlamt >= (RxLogCalc.rxCalcStlTaxInAmt(mem) - mem.tmpbuf.catalinaTtlamt - (await RcReserv.rcreservReceiptAdvance()))) &&
        (nochgFlg  == 0)) {
      notepluChgFlg = 1;
    }
    RcAtct.rcNotePluSPTendSet(mem.tmpbuf.notepluTtlamt, mem.tmpbuf.notepluTtlqty);
    if ((mem.tmpbuf.notepluTtlamt == 0) && (mem.tmpbuf.notepluTtlqty != 0)) {
      RcNotePlu.rcNotePluNonPrcSalesTrans(atSing.notePluKind, mem.tmpbuf.notepluTtlqty);
    }

    if (mem.tmpbuf.notepluTtlamt >= (RxLogCalc.rxCalcStlTaxInAmt(mem) - mem.tmpbuf.catalinaTtlamt - (await RcReserv.rcreservReceiptAdvance()))) {
      if (nochgFlg  == 0) {
        mem.tTtllog.calcData.stlTaxAmt = RxLogCalc.rxCalcStlTaxInAmt(mem) - (await RcReserv.rcreservReceiptAdvance())- mem.tmpbuf.catalinaTtlamt - mem.tmpbuf.notepluTtlamt;
      } else {
        mem.tTtllog.calcData.stlTaxAmt = 0;
      }
    }
    cMem.stat.fncCode = bkFncCd;
    cMem = wcMem;

    if (notepluChgFlg != 0) {
      mem.tTtllog.t100001.chgAmt = -mem.tTtllog.calcData.stlTaxAmt;
      if (!RckyQctckt.rcCheckQcTcktLikeKey()) {
        RcAtct.qcNotepluChangeFlg = 1;
      }
      if (RckyQctckt.rcCheckQcTcktLikeKey() && !(await RcSysChk.rcsyschkAlltranUpdateQCSide())) {
        mem.tTtllog.t100001.saleAmt = 0;
        mem.tTtllog.t100001.chgAmt = 0;
        mem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt= 0;
      }
    }
  }

  /// [カタリナ仕様] スプリットデータを設定する
  /// 関連tprxソース: rcqc_com.c - rc_Catalina_SPData_Set
  static Future<void> rcCatalinaSPDataSet() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if (!(RcCatalina.cmCatalinaSystem(0) &&
        (mem.tTtllog.t100001Sts.sptendCnt == 0))) {
      return;
    }
    if (mem.tmpbuf.catalinaTtlamt == 0) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    int bkFncCd = cMem.stat.fncCode;
    AcMem wcMem = cMem;

    mem.tTtllog.calcData.stlTaxAmt +=
    (mem.tmpbuf.catalinaTtlamt + mem.tmpbuf.notepluTtlamt +
        mem.tmpbuf.beniyaTtlamt);
    cMem.working.dataReg.kMan0 = 0;
    cMem.stat.fncCode = rcCatalinaFnc(cBuf.dbTrm.catalineKeyCd);

    if (cBuf.dbTrm.catalineKeyCd == cBuf.dbTrm.catalinacpnKeyCd) {
      RcAtct.rcCatalinaSPTendSet(
          mem.tmpbuf.catalinaTtlamt, mem.tmpbuf.catalinaTtlqty);
      if ((mem.tmpbuf.catalinaTtlamt == 0) &&
          (mem.tmpbuf.catalinaTtlqty != 0)) {
        RcCatalina.rcCatalinaNonPrcSalesTrans(
            cBuf.dbTrm.catalineKeyCd, mem.tmpbuf.catalinaTtlqty);
      }
    } else {
      if ((mem.tmpbuf.catalinaStore != 0) ||
          (mem.tmpbuf.catalinaStoreqty != 0)) {
        RcAtct.rcCatalinaSPTendSet(
            mem.tmpbuf.catalinaStore, mem.tmpbuf.catalinaStoreqty);
      }
      if ((mem.tmpbuf.catalinaManufact != 0) ||
          (mem.tmpbuf.catalinaManufactqty != 0)) {
        cMem.stat.fncCode = rcCatalinaFnc(cBuf.dbTrm.catalinacpnKeyCd);
        RcAtct.rcCatalinaSPTendSet(
            mem.tmpbuf.catalinaManufact, mem.tmpbuf.catalinaManufactqty);
      }
      if ((mem.tmpbuf.catalinaStore == 0) &&
          (mem.tmpbuf.catalinaStoreqty != 0)) {
        RcCatalina.rcCatalinaNonPrcSalesTrans(
            cBuf.dbTrm.catalineKeyCd, mem.tmpbuf.catalinaStoreqty);
      }
      if ((mem.tmpbuf.catalinaManufact == 0) &&
          (mem.tmpbuf.catalinaManufactqty != 0)) {
        RcCatalina.rcCatalinaNonPrcSalesTrans(
            cBuf.dbTrm.catalinacpnKeyCd, mem.tmpbuf.catalinaManufactqty);
      }
    }
    if (mem.tmpbuf.catalinaTtlamt >= RxLogCalc.rxCalcStlTaxInAmt(mem)) {
      mem.tTtllog.calcData.stlTaxAmt = 0;
    }
    cMem.stat.fncCode = bkFncCd;
    cMem = wcMem;
  }

  /// [カタリナ仕様] ファンクションキーを設定する
  /// 引数: 指定キーインデックス
  /// 戻り値: 指摘キーインデックスに相当するファンクションキー
  /// 関連tprxソース: rcqc_com.c - rc_CatalinaFnc
  static int rcCatalinaFnc(int trmCd) {
    List<int> fncList = [
      FuncKey.KY_CASH.keyId,
      FuncKey.KY_CHA1.keyId,
      FuncKey.KY_CHA2.keyId,
      FuncKey.KY_CHA3.keyId,
      FuncKey.KY_CHA4.keyId,
      FuncKey.KY_CHA5.keyId,
      FuncKey.KY_CHA6.keyId,
      FuncKey.KY_CHA7.keyId,
      FuncKey.KY_CHA8.keyId,
      FuncKey.KY_CHA9.keyId,
      FuncKey.KY_CHA10.keyId,
      FuncKey.KY_CHK1.keyId,
      FuncKey.KY_CHK2.keyId,
      FuncKey.KY_CHK3.keyId,
      FuncKey.KY_CHK4.keyId,
      FuncKey.KY_CHK5.keyId,
      FuncKey.KY_CHA11.keyId,
      FuncKey.KY_CHA12.keyId,
      FuncKey.KY_CHA13.keyId,
      FuncKey.KY_CHA14.keyId,
      FuncKey.KY_CHA15.keyId,
      FuncKey.KY_CHA16.keyId,
      FuncKey.KY_CHA17.keyId,
      FuncKey.KY_CHA18.keyId,
      FuncKey.KY_CHA19.keyId,
      FuncKey.KY_CHA20.keyId,
      FuncKey.KY_CHA21.keyId,
      FuncKey.KY_CHA22.keyId,
      FuncKey.KY_CHA23.keyId,
      FuncKey.KY_CHA24.keyId,
      FuncKey.KY_CHA25.keyId,
      FuncKey.KY_CHA26.keyId,
      FuncKey.KY_CHA27.keyId,
      FuncKey.KY_CHA28.keyId,
      FuncKey.KY_CHA29.keyId,
      FuncKey.KY_CHA30.keyId,
      -1
    ];
    int fncCd = -1;
    int i = 0;

    for (i = 0; fncList[i] != -1; i++) {
      if (trmCd == i) {
        fncCd = fncList[trmCd];
        break;
      }
    }
    return fncCd;
  }

  /// 関連tprxソース: rcqc_com.c - rcQC_Change_ErrMsg
  static Future<void> rcQCChangeErrMsg(int msgNo) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (!await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }

    if (qc_now_lang_typ == QC_LANG.QC_LANG_JP.index) {
      tsBuf.chk.dlg_msg_chg = 0;
      tsBuf.chk.dlg_chg_msg = '';
      return;
    }

    tsBuf.chk.dlg_msg_chg = 1;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_com.c - rcQC_dPoint_Pay_Func
  static void rcQCDPointPayFunc(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcqc_com.c - rcqc_com_vesca_key_check
  static int rcqcComVescaKeyCheck(){
    return 0;
  }
}
