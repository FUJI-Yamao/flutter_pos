/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cls_conf/speezaJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/speeza_comJsonFile.dart';

import '../../inc/apl/fnc_code.dart';
import '../../inc/lib/Speezaini.dart';
import '../../inc/lib/qcConnect.dart';

class RcSpeezaCom{
  static SpeezaIniData speezaMem = SpeezaIniData();		// iniファイルデータ格納先

  /// SPEEZAに関するINIデータをメモリへセットするメインプロセス
  ///  関連tprxソース: rcky_qcselect.c  rcSpeezaReadIni
  static Future<void> rcSpeezaReadIni() async {
    await rcSetSpeezaMemory();
  }

  /// speeza.ini と speeza_com.iniを読み, メモリに格納する
  ///  関連tprxソース: rcky_qcselect.c  rcSetSpeezaMemory
  static Future<int> rcSetSpeezaMemory() async {
    Speeza_comJsonFile speezaCom = Speeza_comJsonFile();
    SpeezaJsonFile speeza = SpeezaJsonFile();
    await speezaCom.load();
    await speeza.load();

    speezaMem.com.qcSelectChangeAmountType = speezaCom.QcSelect.ChangeAmountType;
    speezaMem.com.qcSelectCautionType = speezaCom.QcSelect.CautionType;
    speezaMem.com.qcTerminalReturnTime = speezaCom.StatusTerminal.return_time;
    speezaMem.com.qCSelectRprItemPrn = speezaCom.QcSelect.QCSel_Rpr_ItemPrn;
    speezaMem.com.qcSelectStlPushedExpand = speezaCom.QcSelect.Stl_Pushed_Expand;
    speezaMem.com.chargeTranSpeezaUpdate = speezaCom.QcSelect.ChaTranSpeezaUpd;
    speezaMem.com.qcDispPrecaBalSht = speezaCom.QcSelect.Disp_Preca_Bal_Sht;

    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_MENU.id].BackColor = speezaCom.StatusMenu.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_WAIT.id].BackColor = speezaCom.StatusWait.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ACTIVE.id].BackColor = speezaCom.StatusActive.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_OPE_OVER.id].BackColor = speezaCom.StatusActive.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CALL.id].BackColor = speezaCom.StatusCall.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_OFFLINE.id].BackColor = speezaCom.StatusOffline.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ANOTHERACTIVE.id].BackColor = speezaCom.StatusAnotherActive.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ANOTHER_OVER.id].BackColor = speezaCom.StatusAnotherActive.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_MENTE.id].BackColor = speezaCom.StatusMente.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CREATE_MAX.id].BackColor = speezaCom.StatusCreateMax.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CREATE_OVER.id].BackColor = speezaCom.StatusCreateMax.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PAUSE.id].BackColor = speezaCom.StatusPause.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_COINFULL_RECOVER.id].BackColor = speezaCom.StatusCoinFullRecover.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PRECA_SHT.id].BackColor = speezaCom.StatusPrecaBalSht.BackColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PRECA_CHG.id].BackColor = speezaCom.StatusPrecaChg.BackColor;

    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_MENU.id].TextColor = speezaCom.StatusMenu.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_WAIT.id].TextColor = speezaCom.StatusWait.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ACTIVE.id].TextColor = speezaCom.StatusActive.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_OPE_OVER.id].TextColor = speezaCom.StatusActive.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CALL.id].TextColor = speezaCom.StatusCall.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_OFFLINE.id].TextColor = speezaCom.StatusOffline.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ANOTHERACTIVE.id].TextColor = speezaCom.StatusAnotherActive.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ANOTHER_OVER.id].TextColor = speezaCom.StatusAnotherActive.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_MENTE.id].TextColor = speezaCom.StatusMente.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CREATE_MAX.id].TextColor = speezaCom.StatusCreateMax.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CREATE_OVER.id].TextColor = speezaCom.StatusCreateMax.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PAUSE.id].TextColor = speezaCom.StatusPause.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_COINFULL_RECOVER.id].TextColor = speezaCom.StatusCoinFullRecover.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PRECA_SHT.id].TextColor = speezaCom.StatusPrecaBalSht.TextColor;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PRECA_CHG.id].TextColor = speezaCom.StatusPrecaChg.TextColor;

    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_MENU.id].Message = speezaCom.StatusMenu.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_WAIT.id].Message = speezaCom.StatusWait.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ACTIVE.id].Message = speezaCom.StatusActive.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_OPE_OVER.id].Message = speezaCom.StatusActive.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CALL.id].Message = speezaCom.StatusCall.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_OFFLINE.id].Message = speezaCom.StatusOffline.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ANOTHERACTIVE.id].Message = speezaCom.StatusAnotherActive.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_ANOTHER_OVER.id].Message = speezaCom.StatusAnotherActive.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_MENTE.id].Message = speezaCom.StatusMente.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CREATE_MAX.id].Message = speezaCom.StatusCreateMax.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_CREATE_OVER.id].Message = speezaCom.StatusCreateMax.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PAUSE.id].Message = speezaCom.StatusPause.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_COINFULL_RECOVER.id].Message = speezaCom.StatusCoinFullRecover.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PRECA_SHT.id].Message = speezaCom.StatusPrecaBalSht.Message;
    speezaMem.com.MsgForm[QcStatusType.QCSTATUS_PRECA_CHG.id].Message = speezaCom.StatusPrecaChg.Message;

    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_NORMAL.id].BackColor = speezaCom.CautionNormal.BackColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_NORMAL.id].TextColor = speezaCom.CautionNormal.TextColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_NORMAL.id].Message = speezaCom.CautionNormal.Message;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_PRN_END.id].BackColor = speezaCom.CautionRcptEnd.BackColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_PRN_END.id].TextColor = speezaCom.CautionRcptEnd.TextColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_PRN_END.id].Message = speezaCom.CautionRcptEnd.Message;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_END.id].BackColor = speezaCom.CautionAcxEnd.BackColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_END.id].TextColor = speezaCom.CautionAcxEnd.TextColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_END.id].Message = speezaCom.CautionAcxEnd.Message;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_FULL.id].BackColor = speezaCom.CautionAcxFull.BackColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_FULL.id].TextColor = speezaCom.CautionAcxFull.TextColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_FULL.id].Message = speezaCom.CautionAcxFull.Message;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_ERR.id].BackColor = speezaCom.CautionAcxErr.BackColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_ERR.id].TextColor = speezaCom.CautionAcxErr.TextColor;
    speezaMem.com.MsgForm[QcCautionStatus.QC_CAUTION_ACX_ERR.id].Message = speezaCom.CautionAcxErr.Message;

    speezaMem.pvt.QcSelectConMacNo1 = speeza.QcSelect.ConMacNo1;
    speezaMem.pvt.QcSelectConMacNo2 = speeza.QcSelect.ConMacNo2;
    speezaMem.pvt.QcSelectConMacNo3 = speeza.QcSelect.ConMacNo3;

    if (speeza.QcSelect.ConMacName1 == "") {
      speezaMem.pvt.qcSelectConMacName1 = speeza.QcSelect.ConMacNo1.toString();
    } else {
      speezaMem.pvt.qcSelectConMacName1 = speeza.QcSelect.ConMacName1;
    }
    if (speeza.QcSelect.ConMacName2 == "") {
      speezaMem.pvt.qcSelectConMacName2 = speeza.QcSelect.ConMacNo2.toString();
    } else {
      speezaMem.pvt.qcSelectConMacName2 = speeza.QcSelect.ConMacName2;
    }
    if (speeza.QcSelect.ConMacName3 == "") {
      speezaMem.pvt.qcSelectConMacName3 = speeza.QcSelect.ConMacNo3.toString();
    } else {
      speezaMem.pvt.qcSelectConMacName3 = speeza.QcSelect.ConMacName3;
    }
    speezaMem.pvt.QcSelectConPrint1 = speeza.QcSelect.ConPrint1;
    speezaMem.pvt.QcSelectConPrint2 = speeza.QcSelect.ConPrint2;
    speezaMem.pvt.QcSelectConPrint3 = speeza.QcSelect.ConPrint3;
    speezaMem.pvt.qcSelectConColor1 = speeza.QcSelect.ConColor1;
    speezaMem.pvt.qcSelectConColor2 = speeza.QcSelect.ConColor2;
    speezaMem.pvt.qcSelectConColor3 = speeza.QcSelect.ConColor3;
    speezaMem.pvt.qcSelectPosi1 = speeza.QcSelect.ConPosi1;
    speezaMem.pvt.qcSelectPosi2 = speeza.QcSelect.ConPosi2;
    speezaMem.pvt.qcSelectPosi3 = speeza.QcSelect.ConPosi3;

    return	0;
  }
  /// 小計額以上の会計・品券キー入力時に取引送信するか返す
  /// 関連tprxソース: rcspeeza_com.c - rcChkChaTranSpeezaUpd
  /// 引数：なし
  /// 戻値：0:する  1:しない
  static int rcChkChaTranSpeezaUpd(){
    if (speezaMem != null) {
      return speezaMem.com.chargeTranSpeezaUpdate;
    }
    return 0;
  }

  /// QC指定後の登録画面戻り時間を返す
  /// 戻値: 戻り時間（秒）
  /// 関連tprxソース: rcspeeza_com.c - rcChkQcTerminalReturnTime
  static int rcChkQcTerminalReturnTime() {
    if (speezaMem != null) {
      return speezaMem.com.qcTerminalReturnTime;
    }
    return 0;
  }

  /// QC指定時の再発行での登録商品印字チェック
  /// 戻値: 0=印字しない  1=印字する
  /// 関連tprxソース: rcspeeza_com.c - rcChkQcSelectRprItemPrn
  static int rcChkQcSelectRprItemPrn() {
    if (speezaMem != null) {
      return speezaMem.com.qCSelectRprItemPrn;
    }
    return 0;
  }

  /// 各QC指定キーに設定されたマシン番号を返す
  /// 引数: QC指定キー
  /// 戻値: マシンNo
  /// 関連tprxソース: rcspeeza_com.c - rcGetQcSelectMacNo
  static int rcGetQcSelectMacNo(int keyCode) {
    if (speezaMem != null) {
      if (keyCode == FuncKey.KY_QCSELECT.keyId) {
        return speezaMem.pvt.QcSelectConMacNo1;
      }
      else if (keyCode == FuncKey.KY_QCSELECT2.keyId) {
        return speezaMem.pvt.QcSelectConMacNo2;
      }
      else if (keyCode == FuncKey.KY_QCSELECT3.keyId) {
        return speezaMem.pvt.QcSelectConMacNo3;
      }
    }
    return -1;
  }

  /// 各QC指定キーに設定されたプリセット名称を返す
  /// 引数: QC指定キー
  /// 戻値: マシンのプリセット名称
  /// 関連tprxソース: rcspeeza_com.c - rcGetQcSelectPresetName
  static String rcGetQcSelectPresetName(int keyCode) {
    if (speezaMem != null) {
      if (keyCode == FuncKey.KY_QCSELECT.keyId) {
        return speezaMem.pvt.qcSelectConMacName1;
      }
      else if (keyCode == FuncKey.KY_QCSELECT2.keyId) {
        return speezaMem.pvt.qcSelectConMacName2;
      }
      else if (keyCode == FuncKey.KY_QCSELECT3.keyId) {
        return speezaMem.pvt.qcSelectConMacName3;
      }
    }
    return "";
  }
}