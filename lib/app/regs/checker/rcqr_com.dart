/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_flrda.dart';
import 'rc_mbr_com.dart';
import 'rc_obr.dart';
import 'rcfncchk.dart';
import 'rcky_rrate.dart';
import 'rckychgqty.dart';
import 'rcsyschk.dart';
import 'rc_qrinf.dart';

///  関連tprxソース: rcqr_com.c
class RcqrCom {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcsg_dev.c - qr_txt_status
  static int qrTxtStatus = 0;
  /// qr_read_mac_no
  static int qrReadMacNo = 0;
  ///  関連tprxソース: rcsg_dev.c - qr_read_sptend_cnt
  static int qrReadSptendCnt = 0;
  static int custrealNonQrWriteFlg = 0;

  static int qrTxtPrintFlg = 0;
  static int qrStaffPlukyFlg = 0;
  static int qrTrminfoFlg = 0;
  static int qcWriteReptNo = 0;
  static String qrDatetime = "";
  static int qrWday = 0;
  ///  関連tprxソース: rcsg_dev.c - qr_read_rept_no
  static int qrReadReptNo = 0;
  static int qcVescaAlarmFlg = 0;
  static String qrReadMcdAcode = "";

  /// 関連tprxソース: rcqr_com.c - qrtxt_page_cnt
  static int qrtxtPageCnt = 0;

  /// 関連tprxソース: rcqr_com.c - fp
  static String fp = "";

  /// 関連tprxソース: rcqr_com.c - qr_read_cshr_no
  static int qrReadCshrNo = 0;

  /// 関連tprxソース: rcqr_com.c - qr_void_exec_flg
  static int qrVoidExecFlg = 0;

  /// 関連tprxソース: rcqr_com.c - qr_1line_sptend_flg
  static int qr1LineSptendFlg = 0;

  /// 関連tprxソース: rcqr_com.c - qr_inf_set
  static int qrInfSet = 0;

  /// 関連tprxソース: rcqr_com.c - qr_nm_stlpdsc_per
  /// 一般小計割引率
  static int qrNmStlpdscPer = 0;

  /// 関連tprxソース: rcqr_com.c - qr_mbr_stlpdsc_per
  /// 会員小計割引率
  static int qrMbrStlpdscPer = 0;

  /// 関連tprxソース: rcqr_com.c - qr_read_cshr_name
  static String qrReadCshrName = "";

  /// 関連tprxソース: rcqr_com.c - QRTxt_Info
  static QrtxtInfo qrTxtInfo = QrtxtInfo();

  /// 機能  ：退店QRコードのテキストを作成
  /// JSONデータ作成 → 暗号化処理 → BASE64変換 → TXT出力
  /// 戻り値：テキスト作成 = 0(成功) / -1(失敗)
  /// 関連tprxソース: rcqr_com.c - rc_QR_System_Leave_to_Txt
  static int rcQRSystemLeaveToTxt(){
    // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
    return 0;
  }

  /// 関連tprxソース: rcqr_com.c - rcQC_LED_ALL_OFF
  static void rcQcLeDAllOff(int typ) {
    // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcqr_com.c - rc_SaG_BasketServer_Upload()
  static int rcSaGBasketServerUpload(int cartStatus) {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcqr_com.c - rc_SaG_CR50_SNDApiFixedSalse_Set_CartID()
  static void rcSaGCR50SNDApiFixedSalseSetCartID() {
    return;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcqr_com.c - rc_SaG_CR50_SNDApiFixedSales_Get()
  static void rcSaGCR50SNDApiFixedSalesGet() {
    return;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcqr_com.c - rcQC_Led_Com
  static void rcQCLedCom(int no, int color, int disp, int onTime, int offTime, int time) {}

  /// スプリットデータかチェックを行う
  /// 引数:[sptendCnt] スプリット・テンド利用回数
  /// 引数:[fncCd] スプリット情報(クーポン名等)
  /// 引数:[sptendData] スプリット・テンダリング置数金額
  /// 戻り値：true=正常  false=異常
  /// 関連tprxソース: rcqr_com.c - rcChkSptendBeniya
  static bool rcChkSptendBeniya(int sptendCnt, int fncCd, int sptendData) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.discBarcode28d == 0) {
      return false;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    int cFncCd1 = FuncKey.KY_CHK1.keyId;
    if ((sptendCnt < 4)
        && (mem.tmpbuf.beniyaTtlamt == sptendData)
        && (fncCd == cFncCd1)) {
      return true;
    }

    return false;
  }

  /// 関連tprxソース: rc_qrinf.h　‐ rc_QR_System_Key_to_Txt
  static void rcQRSystemKeyToTxt(int fncCode) {
    rcQRSystemKeyToTxtAdd(fncCode, null);
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// 各操作内容をQRバーコード印字のためのファイルに追記する
  /// また、spChgに任意の値を与えることでスプリットの変更を行うことができる
  /// 引数:[fncCode] 通常動作における追記する操作のキーコード
  /// 引数:[spChg] スプリット変更時の構造体
  /// 関連tprxソース: rcqr_com.c　‐ rc_QR_System_Key_to_Txt_Add
  static void rcQRSystemKeyToTxtAdd(int fncCode, QR_SptendChg_Param? spChg) {}

  /// QRへの書き込み
  /// 関連tprxソース: rcqr_com.c - rc_QR_System_Oth_to_Txt
  static Future<void> rcQRSystemOthToTxt(int kyCode) async {
    if (await _rcQRSystemChkStatus()) {
      return;
    }

    String callFunc = "RcqrCom.rcQRSystemOthToTxt()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId])) {
      return;
    }
    if ((kyCode == FuncKey.KY_PLU.keyId) && (qrStaffPlukyFlg == 1)) {
      return;
    }
    if ((RcSysChk.rcChkCustrealsvrSystem() ||
        (await RcSysChk.rcChkCustrealNecSystem(0)))
        && (custrealNonQrWriteFlg != 0) ) {
      return;
    }

    /*** FILE PATH ***/
    RegsMem mem = SystemFunc.readRegsMem();
    if ( ( (mem.tTtllog.t100001Sts.itemlogCnt == 1) &&
        (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index) &&
        ((kyCode == FuncKey.KY_PLU.keyId) || (kyCode == FuncKey.KY_MG.keyId) ||
            (kyCode == FuncKey.KY_MDL.keyId)) )
        || (!RcFncChk.rcCheckRegistration() &&
            (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)) ) {
      qcWriteReptNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }
    else if ( (await RcSysChk.rcChkHt2980System())
        && (mem.tTtllog.t100001Sts.itemlogCnt == 0)
        && (kyCode == FuncKey.KY_QC_TCKT.keyId) ) {
      qcWriteReptNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }
    else if ( (await RcMbrCom.rcmbrChkStat() != 0)
        && (mem.tTtllog.t100001Sts.itemlogCnt == 0)
        && (kyCode == FuncKey.KY_MPRC.keyId) ) {
      qcWriteReptNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }
    else if ( (await RcMbrCom.rcmbrChkStat() != 0)
        && (mem.tTtllog.t100001Sts.itemlogCnt == 0)
        && (kyCode == QR_ARCS_MBR_JIS2) ) {
      qcWriteReptNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }
    else if ( (kyCode == FuncKey.KY_QC_TCKT.keyId)
        && (mem.tTtllog.t100001Sts.itemlogCnt == 0)
        && (qcWriteReptNo != await Counter.competitionGetRcptNo(await RcSysChk.getTid())) ) {
      qcWriteReptNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
    }

    String path = "${EnvironmentData.TPRX_HOME}$CHK2TEXT_TEXT_DIR$QR2TEXT_TEXT_NAME${"$qcWriteReptNo".padLeft(4, '0')}.txt";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc: rcpt[$qcWriteReptNo]");

    AtSingl atSing = SystemFunc.readAtSingl();
    String tmpBuf = "";
    String sendBuf = "";
    switch (kyCode) {
      case 49:  //FuncKey.KY_PLU.keyId
        if (int.tryParse(atSing.inputbuf.Acode) == 0)  {
          tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[PLU][PRESET] write [$tmpBuf]");
          break;
        }
        sendBuf = cMem.working.pluReg.t10000.pluCd1_1;
        if (cMem.ent.tencnt ==  QR_AI_KEY_digit_MAG) {
          sendBuf += cMem.working.pluReg.t10001.pluCd2_1;
          tmpBuf = "$QR_AI_CHK_KEY_MAG$sendBuf";
        }
        else if (cMem.repeat.repCnt > 1) {  /* Repeat */
          tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        else {
          tmpBuf = "$QR_AI_CHK_KEY_PLU${"$QR_AI_KEY_digit_PLU".padLeft(2,'0')}$sendBuf";
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[PLU] write [$tmpBuf]");
        break;
      case 50:  //FuncKey.KY_MG.keyId
        if (atSing.inputbuf.Smlcode == 0)  {
          tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        else {
          if (cMem.repeat.repCnt > 1) {		/* Repeat */
            tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
          }
          else {
            sendBuf = "${cMem.working.pluReg.t10000.smlclsCd}".padLeft(6,'0');
            tmpBuf = "$QR_AI_CHK_KEY_MG${"$QR_AI_KEY_digit_MG".padLeft(2,'0')}$sendBuf";
          }
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[MG] write [$tmpBuf]");
        break;
      case 63:  //FuncKey.KY_MUL.keyId
        sendBuf = "${cMem.working.dataReg.kMul0}".padLeft(3,'0');
        tmpBuf = "$QR_AI_CHK_KEY_MUL${"$QR_AI_KEY_digit_MUL".padLeft(2,'0')}$sendBuf";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[MUL] write [$tmpBuf]");
        break;
      case 39:  //FuncKey.KY_DSC1.keyId
      case 40:  //FuncKey.KY_DSC2.keyId
      case 41:  //FuncKey.KY_DSC3.keyId
      case 42:  //FuncKey.KY_DSC4.keyId
      case 43:  //FuncKey.KY_DSC5.keyId
        if (Rxkoptcmncom.rxChkKoptDscEntry(cBuf, cMem.stat.fncCode) != 0) {
          tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        else {
          sendBuf = "${"${cMem.working.dataReg.kDsc0}".padLeft(7,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}" ;
          tmpBuf = "$QR_AI_CHK_KEY_DSC${"$QR_AI_KEY_digit_DSC".padLeft(2,'0')}$sendBuf";
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[DSC] write [$tmpBuf]");
        break;
      case 44:  //FuncKey.KY_PM1.keyId
      case 45:  //FuncKey.KY_PM2.keyId
      case 46:  //FuncKey.KY_PM3.keyId
      case 47:  //FuncKey.KY_PM4.keyId
      case 48:  //FuncKey.KY_PM5.keyId
        if (Rxkoptcmncom.rxChkKoptPdscEntry(cBuf, cMem.stat.fncCode) != 0) {
          tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        else {
          tmpBuf = "$QR_AI_CHK_KEY_PDSC${"$QR_AI_KEY_digit_PDSC".padLeft(2,'0')}${"${(cMem.working.dataReg.kPm1_0 / 100)}".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[PDSC] write [$tmpBuf]");
        break;
      case 34:  //FuncKey.KY_CLR.keyId
        tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[CLR] write [$tmpBuf]");
        break;
      case 13:  //FuncKey.KY_STL.keyId
        tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[STL] write [$tmpBuf]");
        break;
      case 61:  //FuncKey.KY_SCRVOID.keyId
        sendBuf = "${"${atSing.tStlLcdItem.iI}".padLeft(4,'0')}${"${atSing.tStlLcdItem.scrVoid}".padLeft(2,'0')}" ;
        tmpBuf = "$QR_AI_CHK_KEY_SCRVOID${"$QR_AI_KEY_digit_SCRVOID".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}$sendBuf";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[SCRVOID] write [$tmpBuf]");
        break;
      case 14:  //FuncKey.KY_CASH.keyId
      case 15:  //FuncKey.KY_CHA1.keyId
      case 16:  //FuncKey.KY_CHA2.keyId
      case 17:  //FuncKey.KY_CHA3.keyId
      case 18:  //FuncKey.KY_CHA4.keyId
      case 19:  //FuncKey.KY_CHA5.keyId
      case 20:  //FuncKey.KY_CHA6.keyId
      case 21:  //FuncKey.KY_CHA7.keyId
      case 22:  //FuncKey.KY_CHA8.keyId
      case 23:  //FuncKey.KY_CHA9.keyId
      case 24:  //FuncKey.KY_CHA10.keyId
      case 26:  //FuncKey.KY_CHK1.keyId
      case 27:  //FuncKey.KY_CHK2.keyId
      case 28:  //FuncKey.KY_CHK3.keyId
      case 29:  //FuncKey.KY_CHK4.keyId
      case 30:  //FuncKey.KY_CHK5.keyId
      case 384:  //FuncKey.KY_CHK11.keyId
      case 385:  //FuncKey.KY_CHK12.keyId
      case 386:  //FuncKey.KY_CHK13.keyId
      case 387:  //FuncKey.KY_CHK14.keyId
      case 388:  //FuncKey.KY_CHK15.keyId
      case 389:  //FuncKey.KY_CHK16.keyId
      case 390:  //FuncKey.KY_CHK17.keyId
      case 391:  //FuncKey.KY_CHK18.keyId
      case 392:  //FuncKey.KY_CHK19.keyId
      case 393:  //FuncKey.KY_CHK20.keyId
      case 394:  //FuncKey.KY_CHK21.keyId
      case 395:  //FuncKey.KY_CHK22.keyId
      case 396:  //FuncKey.KY_CHK23.keyId
      case 397:  //FuncKey.KY_CHK24.keyId
      case 398:  //FuncKey.KY_CHK25.keyId
      case 399:  //FuncKey.KY_CHK26.keyId
      case 400:  //FuncKey.KY_CHK27.keyId
      case 401:  //FuncKey.KY_CHK28.keyId
      case 402:  //FuncKey.KY_CHK29.keyId
      case 403:  //FuncKey.KY_CHK30.keyId
        KopttranBuff kopttran = KopttranBuff();
        await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);
        if (kopttran.frcEntryFlg == 3) {
          tmpBuf = "$QR_AI_CHK_KEY${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        else if ((kopttran.crdtEnbleFlg == 1) && (kopttran.crdtTyp == 2)) {
          int sptendNum = mem.tTtllog.t100001Sts.sptendCnt - 1;
          if (sptendNum >= 0) {
            tmpBuf = "$QR_AI_CHK_EDY_CD${"$QR_AI_EDY_CD_digit".padLeft(2,'0')}${mem.tTtllog.t100100[sptendNum].edyCd}";
          }
        }
        else {
          tmpBuf = "$QR_AI_CHK_KEY_CHA_CHK${"$QR_AI_KEY_digit_CHA_CHK".padLeft(2,'0')}${"${Bcdtol.cmBcdToL(cMem.ent.entry)}".padLeft(7,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[CHACHK] write [$tmpBuf]");
        break;
      case 273:  //FuncKey.KY_CHGQTY.keyId
        sendBuf = "${"${atSing.tStlLcdItem.iI}".padLeft(4,'0')}${"${RckyChgQty.chgQtyInfo.newqty}".padLeft(3,'0')}${"${RckyChgQty.chgQtyInfo.oldqty}".padLeft(3,'0')}${"${RckyChgQty.chgQtyInfo.voidqty}".padLeft(3,'0')}" ;
        tmpBuf = "$QR_AI_CHK_KEY_CHG_QTY${"$QR_AI_KEY_digit_CHG_QTY".padLeft(2,'0')}$sendBuf";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[CHGQTY] write [$tmpBuf]");
        break;
      case 254:  //FuncKey.KY_STLDSCCNCL.keyId
        tmpBuf = "$QR_AI_CHK_KEY_STLCNCL${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[STLDSCCNCL] write [$tmpBuf]");
        break;
      case 257:  //FuncKey.KY_RBTCNCL.keyId
        tmpBuf = "$QR_AI_CHK_KEY_RBTCNCL${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[RBTCNCL] write [$tmpBuf]");
        break;
      case 258:  //FuncKey.KY_PLUSCNCL.keyId
        tmpBuf = "$QR_AI_CHK_KEY_PLUSCNCL${"$QR_AI_KEY_digit".padLeft(2,'0')}${"${cMem.stat.fncCode}".padLeft(3,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[PLUSCNC] write [$tmpBuf]");
        break;
      case 329:  //FuncKey.KY_QC_TCKT.keyId
        tmpBuf = "$QR_AI_CHK_CSHR_NO${"$QR_AI_CSHR_NO_digit".padLeft(2,'0')}${"${mem.tHeader.cshr_no}".padLeft(10,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[QC_TCKT] write [$tmpBuf]");
        qrTrminfoFlg = 0;
        break;
      case 154:  //FuncKey.KY_STLPPC.keyId
        if (RcFncChk.rcCheckRegistration()
            && ((mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index) ||
                (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput)) ) {
          return;
        }
        if (await RcSysChk.rcChkFelicaSystem()) {
          tmpBuf = "$QR_AI_CHK_CUST_READ_FELICA${"$QR_AI_CUST_READ_digit_FELICA".padLeft(2,'0')}${mem.tHeader.cust_no}${"${mem.tTtllog.t100700.mbrInput}".padLeft(2,'0')}${"${mem.tTtllog.t100700.lpntTtlsrv}".padLeft(8,'0')}${"${mem.tTtllog.t100800.lcauFsppur}".padLeft(8,'0')}${"${mem.tTtllog.t100900Sts.qcReadDcauMspur}".padLeft(8,'0')}${"${mem.tTtllog.t100900Sts.qcReadDpntTtlsrv}".padLeft(8,'0')}${"${mem.tTtllog.t100900Sts.qcReadDcauFsppur}".padLeft(8,'0')}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[STLPPC] write [$tmpBuf]");
        }
        else if (CmCksys.cmMatugenSystem() != 0) {
          tmpBuf = "$QR_AI_CHK_CUST_READ_MATGN${"$QR_AI_CUST_READ_digit_MATGN".padLeft(2,'0')}${mem.tHeader.cust_no}${"${mem.tTtllog.t100700.mbrInput}".padLeft(2,'0')}${"${atSing.mgnPanadata.type}".padLeft(2,'0')}${"${mem.tTtllog.t100700.lpntTtlsrv}".padLeft(8,'0')}${"${mem.tTtllog.calcData.lpptTtlsrv}".padLeft(8,'0')}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[STLPPC_MATGN] write [$tmpBuf]");
        }
        else if (await CmCksys.cmMoriyaMemberSystem() != 0) {
          tmpBuf = "$QR_AI_CHK_CUST_READ_MATGN${"$QR_AI_CUST_READ_digit_MATGN".padLeft(2,'0')}${mem.tHeader.cust_no}${"${mem.tTtllog.t100700.mbrInput}".padLeft(2,'0')}${"${mem.tTtllog.t100700.lpntTtlsrv}".padLeft(10,'0')}${"${mem.tTtllog.calcData.lpptTtlsrv}".padLeft(8,'0')}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[STLPPC_MATGNN] write [$tmpBuf]");
        }
        else if (await CmCksys.cmMarutoSystem != 0) {
          tmpBuf = "$QR_AI_CHK_CUST_READ_LONG${"$QR_AI_CUST_READ_digit_LONG".padLeft(2,'0')}${mem.tHeader.cust_no}${"${mem.tTtllog.t100700.mbrInput}".padLeft(2,'0')}${"${mem.tTtllog.t100700.lpntTtlsrv}".padLeft(8,'0')}${"${mem.tTtllog.calcData.lpptTtlsrv}".padLeft(8,'0')}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[KY_STLPPC] write [$tmpBuf]");
        }
        else {
          tmpBuf = "$QR_AI_CHK_CUST_READ${"$QR_AI_CUST_READ_digit".padLeft(2,'0')}${mem.tHeader.cust_no}${"${mem.tTtllog.t100700.mbrInput}".padLeft(2,'0')}${"${mem.tTtllog.t100700.lpntTtlsrv}".padLeft(8,'0')}${"${mem.tTtllog.calcData.lpptTtlsrv}".padLeft(8,'0')}";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[STLPPC] write [$tmpBuf]");
        }
        break;
      case 161:  //FuncKey.KY_RDRW.keyId
        tmpBuf = "$QR_AI_CHK_CUST_READ_HT2980${"$QR_AI_CUST_READ_digit_HT2980".padLeft(2,'0')}${mem.tHeader.cust_no}${"${mem.tTtllog.t100700.mbrInput}".padLeft(2,'0')}${"${mem.tTtllog.t100700.dcauMspur}".padLeft(8,'0')}${"${mem.tTtllog.t100901.ht2980TodayPoint}".padLeft(8,'0')}${"${mem.tTtllog.t100700.lpntTtlsrv}".padLeft(8,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[KY_RDRW] write [$tmpBuf]");
        break;
      case 142:  //FuncKey.KY_WTTARE1.keyId
      case 143:  //FuncKey.KY_WTTARE2.keyId
      case 144:  //FuncKey.KY_WTTARE3.keyId
      case 145:  //FuncKey.KY_WTTARE4.keyId
      case 146:  //FuncKey.KY_WTTARE5.keyId
      case 147:  //FuncKey.KY_WTTARE6.keyId
      case 148:  //FuncKey.KY_WTTARE7.keyId
      case 149:  //FuncKey.KY_WTTARE8.keyId
      case 150:  //FuncKey.KY_WTTARE9.keyId
      case 151:  //FuncKey.KY_WTTARE10.keyId
      case 377:  //FuncKey.KY_WEIGHT_INP.keyId
        tmpBuf = "$QR_AI_CHK_SCALE${"$QR_AI_SCALE_digit".padLeft(2,'0')}${"${cMem.working.dataReg.kWgh1}".padLeft(5,'0')}";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[KY_WTTARE] write [$tmpBuf]");
        break;
      case QR_ARCS_MBR_JIS2:
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[QR_ARCS_MBR_JIS2] before [$qrReadMcdAcode]");
        switch (atSing.mbrTyp ) {
          case Mcd.MCD_RLSCARD:
          case Mcd.MCD_RLSSTAFF:
            break;
          case Mcd.MCD_RLSCRDT:
          case Mcd.MCD_RLSVISA:
          case Mcd.MCD_RLSOTHER:
            /*　カード番号下１２桁、有効期限４桁、ＣＣＶ３桁 を"0"にする　*/
            qrReadMcdAcode = "${qrReadMcdAcode.substring(0, 15)}000000000000${qrReadMcdAcode.substring(27, 40)}0000${qrReadMcdAcode.substring(44, 65)}000${qrReadMcdAcode.substring(68)}";
            break;
          default:
            /*　カード番号下１２桁、有効期限４桁、ＣＣＶ３桁 を"0"にする　*/
            qrReadMcdAcode = "${qrReadMcdAcode.substring(0, 15)}000000000000${qrReadMcdAcode.substring(27, 65)}000${qrReadMcdAcode.substring(68)}";
            break;
        }
        tmpBuf = "$QR_AI_CHK_ARCS_MBR_JIS2${"$QR_AI_ARCS_MBR_JIS2_digit".padLeft(2,'0')}";
        if (qrReadMcdAcode.length-1 < QR_AI_ARCS_MBR_JIS2_digit) {
          tmpBuf = tmpBuf.substring(0, QR_AI_CHK_COM_DIGIT) + qrReadMcdAcode.substring(1);
        } else {
          tmpBuf = tmpBuf.substring(0, QR_AI_CHK_COM_DIGIT) + qrReadMcdAcode.substring(1, QR_AI_ARCS_MBR_JIS2_digit);
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[QR_ARCS_MBR_JIS2] write [$tmpBuf]");
        break;
      case QR_REG_STARTTIME:
        tmpBuf = "$QR_AI_CHK_REG_STARTTIME${"$QR_AI_REG_STARTTIME_digit".padLeft(2,'0')}$qrDatetime$qrWday";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[QR_REG_STARTTIME] write [$tmpBuf]");
        break;
      case 289:  //FuncKey.KY_RRATE.keyId
        int rateChk = (RckyRrate.nowRRate * 100) as int;  // 整数部が１桁か２桁か？
        if (rateChk > 999) {  // 整数部が２桁
          tmpBuf = "$QR_AI_CHK_RCPT_RATE5${"$QR_AI_RCPT_RATE_digit5".padLeft(2,'0')}${RckyRrate.nowRRate.toStringAsFixed(2).padLeft(2, '0')}";
        }
        else {  // 整数部が１桁
          tmpBuf = "$QR_AI_CHK_RCPT_RATE4${"$QR_AI_RCPT_RATE_digit4".padLeft(2,'0')}${RckyRrate.nowRRate.toStringAsFixed(2).padLeft(2, '0')}";
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc[KY_RRATE] write [$tmpBuf]");
        break;
      default:
        return;
    }

    Qr2Txt().cm_Chk_to_txt_write(tmpBuf, path);

    if (RcFncChk.rcCheckRegistration() && (qrTrminfoFlg == 0)
        && (RxLogCalc.rxCalcStlTaxInAmt(mem) > 0) ) {
      await _rcQRSystemTrmInfoToTxt();
    }
  }

  /// 関連tprxソース: rcqr_com.c - rc_QR_System_Chk_Status
  static Future<bool> _rcQRSystemChkStatus() async {
    if (await _rcQRSystemChkErrStatus() ) {
      return true;
    }

    if ( !(await RcFncChk.rcCheckItmMode())
        && !(await RcFncChk.rcCheckStlMode())
        && !(await RcSysChk.rcQCChkQcashierSystem())
        && !RcFncChk.rcCheckManualMixMode()
        && !(await RcFncChk.rcCheckChgQtyMode())
        && !(await RcFncChk.rcCheckRfmMode())
        && !(await RcFncChk.rcCheckMoneyConfMode())
        && !(await RcFncChk.rcCheckRRateMode())
        && !(await RcFncChk.rcCheckChgSelectItemsMode())
        && !(await RcFncChk.rcCheckDPtsOrgTranMode()) ) {
      return true;
    }

    if (RcSysChk.rcChkAplDlgEntryMode()	// 入力欄付きダイアログ表示中はQRテキストを書かないようにした
        || RcSysChk.rcChkAplDlgEntryPasswordMode()) {
      return true;
    }

    if (await CmCksys.cmReceiptQrSystem() == 0) {
      return true;
    }
    else {
      if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0) &&  //ユナイト様通常有人レジ
          (await RcSysChk.rcChk2Clk()) &&
          (await RcSysChk.rcsyschkNormalMode())) {
        return true;
      }
    }

    return false;
  }

  /// 関連tprxソース: rcqr_com.c - rc_QR_System_Chk_Err_Status
  static Future<bool> _rcQRSystemChkErrStatus() async {
    AcMem cMem = SystemFunc.readAcMem();

    switch (cMem.ent.errNo) {
      case 0:
      case 3073:  //DlgConfirmMsgKind.MSG_ACRLINEOFF.index
      case 3046:  //DlgConfirmMsgKind.MSG_ACRERROR.index
      case 7066:  //DlgConfirmMsgKind.MSG_TEXT36.index
      case 3019:  //DlgConfirmMsgKind.MSG_TELEGRAGHERR.index
        return false;
      default	:
        if (await RcSysChk.rcQRChkPrintSystem()) {
          if (RcObr.rcZHQErrorCodeChk(cMem.ent.errNo)) {
            return false;
          }
          else {
            return true;
          }
        }
        else {
          return true;
        }
    }
  }

  /// 関連tprxソース: rcqr_com.c - rc_QR_System_TrmInfo_to_Txt
  static Future<void> _rcQRSystemTrmInfoToTxt() async {
    if (await _rcQRSystemChkStatus()) {
      return;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PRC.keyId]) ) {
      return;
    }
    if (qrTrminfoFlg == 1) {
      return;
    }
    qrTrminfoFlg = 1;

    String callFunc = "RcqrCom._rcQRSystemTrmInfoToTxt()";
    String path = "${EnvironmentData.TPRX_HOME}$CHK2TEXT_TEXT_DIR$QR2TEXT_TEXT_NAME${"$qcWriteReptNo".padLeft(4, '0')}.txt";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc: rcpt[$qcWriteReptNo]");

    RegsMem mem = SystemFunc.readRegsMem();
    String tmpBuf = "$QR_AI_CHK_TRM_INFO${"$QR_AI_CHK_TRM_INFO_digit".padLeft(2,'0')}${"${mem.tTtllog.calcData.nmStlpdscPer}".padLeft(2,'0')}${"${mem.tTtllog.calcData.mbrStlpdscPer}".padLeft(2,'0')}";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "QCashier:$callFunc: write[$tmpBuf]");

    Qr2Txt().cm_Chk_to_txt_write(tmpBuf, path);
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// [丸正様特注対応] 会員登録時に発券した割戻ポイントをQRに書き込む
  /// 関連tprxソース: rcqr_com.c - rc_QR_System_Marusyo_dtip_to_Txt
  static void rcQRSystemMarusyoDtipToTxt() {}

  /// 関連tprxソース: rcqr_com.c - rc_QR_System_Txt_MemInit
  static void rcQRSystemTxtMemInit() {
    int i;
    RegsMem mem = RegsMem();

    qrTxtInfo.maxPage = 0;
    qrTxtInfo.nowReadPage = 0;
    qrtxtPageCnt = 0;
    fp = "";
    qrReadCshrNo = 0;
    qrVoidExecFlg = 0;
    qr1LineSptendFlg = 0;
    qrInfSet = 0;
    qrNmStlpdscPer = 0; // 一般小計割引率
    qrMbrStlpdscPer = 0; // 会員小計割引率
    qrReadCshrName = "";

    mem.prnrBuf.qctcktTtlamt = 0;

    for (i = 0; i < RcQrinfConst.QRTXT_PAGE_MAX; i++) {
      qrTxtInfo.data[i].reciptNo = 0;
      qrTxtInfo.data[i].page = 0;
      qrTxtInfo.data[i].readFlg = 0;
      qrTxtInfo.data[i].qrTxtPath = "";
    }
  }
}
