/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../lib/cm_sys/cm_cksys.dart';

class Rxkoptcmncom {
  static List<int> rxkindChaList = [
    // 会計1~30
    FuncKey.KY_CHA1.keyId, FuncKey.KY_CHA2.keyId, FuncKey.KY_CHA3.keyId,
    FuncKey.KY_CHA4.keyId, FuncKey.KY_CHA5.keyId, FuncKey.KY_CHA6.keyId,
    FuncKey.KY_CHA7.keyId, FuncKey.KY_CHA8.keyId, FuncKey.KY_CHA9.keyId,
    FuncKey.KY_CHA10.keyId, FuncKey.KY_CHA11.keyId, FuncKey.KY_CHA12.keyId,
    FuncKey.KY_CHA13.keyId, FuncKey.KY_CHA14.keyId, FuncKey.KY_CHA15.keyId,
    FuncKey.KY_CHA16.keyId, FuncKey.KY_CHA17.keyId, FuncKey.KY_CHA18.keyId,
    FuncKey.KY_CHA19.keyId, FuncKey.KY_CHA20.keyId, FuncKey.KY_CHA21.keyId,
    FuncKey.KY_CHA22.keyId, FuncKey.KY_CHA23.keyId, FuncKey.KY_CHA24.keyId,
    FuncKey.KY_CHA25.keyId, FuncKey.KY_CHA26.keyId, FuncKey.KY_CHA27.keyId,
    FuncKey.KY_CHA28.keyId, FuncKey.KY_CHA29.keyId, FuncKey.KY_CHA30.keyId,
    // 品券1~5
    FuncKey.KY_CHK1.keyId, FuncKey.KY_CHK2.keyId, FuncKey.KY_CHK3.keyId,
    FuncKey.KY_CHK4.keyId, FuncKey.KY_CHK5.keyId,
    -1
  ];

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 売掛タイプが売掛伝票かチェック
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_CrdtType_Slip()
  /// 戻り値: true:売掛伝票, false:違う
  static bool rxChkKoptCrdtTypeSlip(RxCommonBuf pCom, int fncCd) {
    return false;
  }

  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Cha_CrdtTyp()
  static int rxChkKoptChaCrdtTyp(RxCommonBuf pCom, int fncCd) {
    return pCom.dbKfnc[fncCd].opt.cha.crdtTyp;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 指定した掛売種類の会計、品券キーがあるかどうかをチェックする
  /// 関連tprxソース: rxkoptcmncom.c - rxChk_CHACHK_OnlyCrdtTyp
  /// 引数: crdt_typ
  /// 戻値: -1以外 :  ある　会計、品券キーコード,
  /// 　　　-1    :  ない
  static int rxChkCHACHKOnlyCrdtTyp(RxCommonBuf pCom, int crdtTyp) {
    int i;
    int result = -1;

    /* rxkind_cha_list[] = { 会計1~30, 品券1~5, -1 } */
    for (i = 0; rxkindChaList[i] != -1; i++) {
      if (rxChkKoptChaCrdtTyp(pCom, rxkindChaList[i]) == crdtTyp) {
        result = rxkindChaList[i];
        break;
      }
    }
    return result;
  }

  // 会計, 品券キーでの券面のみ時に枚数加算動作と制限動作チェック関数  FALSE: しない  TRUE: する
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmnAddTicket
  static bool rxChkKoptCmnAddTicket(RxCommonBuf pCom, int keyCode) {
    int flg = 0;
    if (pCom.dbKfnc[keyCode].fncKind == KeyKindList.KEY_KIND_CHA) {
      flg = pCom.dbKfnc[keyCode].opt.cha.chkamtAddFlg;
    }
    if (flg == 1) {
      return true;
    }
    return false;
  }

  /// 会計キーかチェック
  /// false:それ以外  true:会計キー
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKey_Kind_CHA()
  static bool rxChkKeyKindCHA(RxCommonBuf pCom, int fncCd) {
    if (pCom.dbKfnc[fncCd].fncKind == KeyKindList.KEY_KIND_CHA) {
      return true;
    }
    return false;
  }

  /// 会計: 掛売
  /// 戻値: 0=しない  1=する
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Cha_CrdtEnble()
  static int rxChkKoptChaCrdtEnble(RxCommonBuf pCom, int fncCd) {
    return pCom.dbKfnc[fncCd].opt.cha.crdtEnbleFlg;
  }

  // 金額: 金額制限
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Prc_AmtLimit()
  static int rxChkKoptPrcAmtLimit(RxCommonBuf pCom) {
    return (pCom.dbKfnc[FuncKey.KY_PRC.keyId].opt.prc.entryAmtLimit);
  }

  ///	機能:	会計/品券の扱いがポイント値引かチェックする.
  ///	戻値:	0: 通常   1: ポイント値引
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_ChaChk_PntDsc()
  static int rxChkKoptCmnChaChkPntDsc(RxCommonBuf pCom, int keyCode) {
    // 会計キー扱い
    if (pCom.dbKfnc[keyCode].fncKind == KeyKindList.KEY_KIND_CHA) {
      if (pCom.dbKfnc[keyCode].opt.cha.otherTyp == 1) {
        return 1;
      }
    }
    return 0;
  }

  /// 返品モード : 客数の加算
  /// 戻値: 0=しない  1=する
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_RefOpr_TranCustNum()
  static int rxChkKoptRefOprTranCustNum(RxCommonBuf pCom) {
    return pCom.dbKfnc[FuncKey.KY_RFDOPR.keyId].opt.refOpr.tranCustNum;
  }

  /// 機能：Verifoneチャージ時、チャージレシートの即時印字
  /// 戻値：する: 0  しない: 1
  /// 関連tprxソース: rxkoptcmncom.c - rxkoptcmncom_charge_receipt_ctrl()
  static Future<int> rxkoptcmncomChargeReceiptCtrl(RxCommonBuf pCom) async {
    int result;

    result = 0;

    // 標準の印字処理に影響を与えたくない為、承認キーをチェックしておく
    if (await CmCksys.cmVescaSystem() != 0) {
      if (pCom.dbKfnc[FuncKey.KY_CASH.keyId].opt.cash.chargeReceiptCtrl != 0) {
        result = 1;
      }
    }

    return (result);
  }

  /// 機能：領収書キーの印紙申告課税限度額判断の設定値チェック
  /// 引数：RX_COMMON_BUF *C_BUF
  /// 戻値：税抜き: 0  額面: 1
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_Rctfm_GpCheck()
  static int rxChkKoptCmnRctfmGpCheck(RxCommonBuf pCom) {
    int result;

    result = 0;
    if (pCom.dbKfnc[FuncKey.KY_RCTFM.keyId].opt.rctfm.restmpLimitFlg != 0) {
      result = 1;
    }

    return (result);
  }

  /// 標準対応 領収書印字抑止
  /// 機能：会計キー品券キー支払時領収書印字判断の設定値チェック
  /// 引数：RX_COMMON_BUF *C_BUF
  /// 戻値：する: 0  しない: 1
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_Rctfm_PrintCheck()
  static bool rxChkKoptCmnRctfmPrintCheck(RxCommonBuf cBuf, int keyCode) {
    int flg = 0;

    if (cBuf.dbKfnc[keyCode].fncKind == KeyKindList.KEY_KIND_CHA.id) {
      flg = cBuf.dbKfnc[keyCode].opt.cha.rcptkeyPrnFlg;
    }

    if (flg == 1) {
      return false;
    }
    return true;
  }

  // 釣機払出での選択出金機能フラグチェック関数	0:値数タイプ  1:金種入力タイプ
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmnChgoutSelectMoney()
  static int rxChkKoptCmnChgoutSelectMoney(RxCommonBuf cBuf) {
    return cBuf.dbKfnc[FuncKey.KY_CHGOUT.keyId].opt.chgout.frcSelectFlg;
  }

  /// 会計 or 品券: 実績の在高加算方法
  /// 機能：会計キー品券キー支払時領収書印字判断の設定値チェック
  /// 引数：RX_COMMON_BUF *C_BUF
  /// 引数：int fncCode
  /// 戻値：0:通常加算 1:現金加算
  ///  関連tprxソース: rxkoptcmncom.c - rxChkKopt_ChaChk_TranUpdate
  static int rxChkKoptChaChkTranUpdate(RxCommonBuf cBuf, int fncCode) {
    if (cBuf.dbKfnc[fncCode].fncKind.id == KeyKindList.KEY_KIND_CHA.id) {
      return cBuf.dbKfnc[fncCode].opt.cha.tranUpdateFlg;
    }
    return 0;
  }

  /// 機能：自動動作チェック
  /// 引数：RX_COMMON_BUF *C_BUF
  /// 戻値：しない: 0  する: 1
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_AutoCash_Type()
  static int rxChkKoptCmnAutoCashType(RxCommonBuf cBuf) {
    int result = 0;
    if (cBuf.dbKfnc[FuncKey.KY_CASH.keyId].opt.cash.autoProcAmtOver != 0) {
      result = 1;
    }
    return result;
  }

  /// 機能：自動動作を開始するまでの経過時間を取得する
  /// 引数：RX_COMMON_BUF *C_BUF
  /// 戻値：キーオプションマスタの設定値
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_AutoCash_Time()
  static int rxChkKoptCmnAutoCashTime(RxCommonBuf cBuf) {
    int result = 0;
    result = cBuf.dbKfnc[FuncKey.KY_CASH.keyId].opt.cash.autoProcTime;
    return result;
  }

  /// 戻値：合計金額の読み上げ 0:する 1: しない
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_StlVoice()
  static int rxChkKoptCmnStlVoice(RxCommonBuf cBuf) {
    int result = 0;
    if (cBuf.dbKfnc[FuncKey.KY_STL.keyId].opt.stl.ttlamtRead == 0) {
      result = 1;
    }
    return result;
  }

  /// 機能：おわりボタンの表示と音声を確認ボタンへ変更
  /// 引数：RX_COMMON_BUF *C_BUF
  /// 戻値：する: 0  しない: 1
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_CashBtn_NameChange()
  static int rxChkKoptCmnCashBtnNameChange(RxCommonBuf cBuf) {
    int result = 0;
    if (cBuf.dbKfnc[FuncKey.KY_CASH.keyId].opt.cash.changeConfirm != 0) {
      result = 1;
    }
    return result;
  }

  /// 会員呼出キー押下時、電話番号呼出をするかチェックする
  /// 引数: 共有クラス_RxCommonBuf
  /// 戻値: 0=する  1=しない
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Mbr_TelNo()
  static int rxChkKoptMbrTelNo(RxCommonBuf cBuf) {
    return cBuf.dbKfnc[FuncKey.KY_MBR.keyId].opt.mbr.entryTelNo;
  }

  /// チケット回収情報を取得するかチェックする
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: 0=する  1=しない
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_ChaChk_TicketCollect
  static int rxChkKoptChaChkTicketCollect(RxCommonBuf cBuf, int fncCd) {
    if (cBuf.dbKfnc[fncCd].fncKind == KeyKindList.KEY_KIND_CHA) {
      return (cBuf.dbKfnc[fncCd].opt.cha.ticketCollectFlg);
    }
    return 0;
  }

  /// 割引キーかチェック
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: true=割引キー  false=それ以外
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKey_Kind_PDSC
  static bool rxChkKeyKindPdsc(RxCommonBuf cBuf, int fncCd) {
    if (cBuf.dbKfnc[fncCd].fncKind == KeyKindList.KEY_KIND_PDSC) {
      return true;
    }
    return false;
  }

  /// 割引額を算出する
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: 割引額
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Pdsc_PdscPer
  static int rxChkKoptPdscPdscPer(RxCommonBuf cBuf, int fncCd) {
    return cBuf.dbKfnc[fncCd].opt.pdsc.pdscPer;
  }

  /// 割引: 小計に対する割引  0:有効 1:禁止
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Pdsc_StlPdsc
  static int rxChkKoptPdscStlPdsc(RxCommonBuf cBuf, int fncCd) {
    return cBuf.dbKfnc[fncCd].opt.pdsc.stldscpdscFlg;
  }

  /// 割引: 置数割引  0:有効 1:禁止
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Pdsc_Entry
  static int rxChkKoptPdscEntry(RxCommonBuf cBuf, int fncCd) {
    return cBuf.dbKfnc[fncCd].opt.pdsc.entryFlg;
  }

  /// 値引キーかチェック
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: true=割引キー  false=それ以外
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKey_Kind_DSC
  static bool rxChkKeyKindDsc(RxCommonBuf cBuf, int fncCd) {
    if (cBuf.dbKfnc[fncCd].fncKind == KeyKindList.KEY_KIND_DSC) {
      return true;
    }
    return false;
  }

  /// 値引: 値引額を算出
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: true=割引キー  false=それ以外
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Dsc_DscAmt
  static int rxChkKoptDscDscAmt(RxCommonBuf cBuf, int fncCd) {
    return cBuf.dbKfnc[fncCd].opt.dsc.dscAmt;
  }

  /// 値引: 小計に対する値引  0:有効 1:禁止
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: true=割引キー  false=それ以外
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Dsc_StlDsc
  static int rxChkKoptDscStlDsc(RxCommonBuf cBuf, int fncCd) {
    return cBuf.dbKfnc[fncCd].opt.dsc.stldscpdscFlg;
  }

  /// 値引: 置数値引  0:有効 1:禁止
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: true=割引キー  false=それ以外
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Dsc_Entry
  static int rxChkKoptDscEntry(RxCommonBuf cBuf, int fncCd) {
    return cBuf.dbKfnc[fncCd].opt.dsc.entryFlg;
  }

  /// 値引, 割引: 企画フラグを返す
  /// 引数:[cBuf] 共有クラス_RxCommonBuf
  /// 引数:[fncCd] ファンクションコード
  /// 戻値: true=有効  false=無効
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_Dsc_TrendsTyp
  static int rxChkKoptDscTrendsTyp(RxCommonBuf cBuf, int fncCd) {
    if ((fncCd == FuncKey.KY_DSC1.keyId) ||
        (fncCd == FuncKey.KY_DSC2.keyId) ||
        (fncCd == FuncKey.KY_DSC3.keyId) ||
        (fncCd == FuncKey.KY_DSC4.keyId) ||
        (fncCd == FuncKey.KY_DSC5.keyId)) {
      return (cBuf.dbKfnc[fncCd].opt.dsc.trendsTyp);
    } else if ((fncCd == FuncKey.KY_PM1.keyId) ||
        (fncCd == FuncKey.KY_PM2.keyId) ||
        (fncCd == FuncKey.KY_PM3.keyId) ||
        (fncCd == FuncKey.KY_PM4.keyId) ||
        (fncCd == FuncKey.KY_PM5.keyId)) {
      return (cBuf.dbKfnc[fncCd].opt.pdsc.trendsTyp);
    }
    return 0;
  }

  /// プリカ宣言: 加盟社コード
  /// 引数: 共有クラス_RxCommonBuf
  /// 戻値: 加盟社コード
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_PrecaIn_MemberCompanyCd
  static int rxChkKoptPrecaInMemberCompanyCd(RxCommonBuf cBuf) {
    return cBuf.dbKfnc[FuncKey.KY_PRECA_IN.keyId].opt.precaIn.memberCompanyCd;
  }

  /// 買上追加: ポイント加算入力タイプ
  /// 戻値: 0=対象額  1=ポイント
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_AddPnt_AddTyp
  static int rxChkKoptAddPntAddTyp(RxCommonBuf cBuf) {
    return cBuf.dbKfnc[FuncKey.KY_ADDPNT.keyId].opt.addPnt.addTyp;
  }

  /// 端末カード読込 利用するカードの種類を取得する
  /// 引数: 共有クラス_RxCommonBuf
  /// 戻値: 0=磁気カード  1=磁気カード+FeliCaカード
  /// 関連tprxソース: rxkoptcmncom.c - rxkoptcmncom_cat_cardread_usecard
  static int rxChkCatCardreadUsecard(RxCommonBuf cBuf) {
    return cBuf.dbKfnc[FuncKey.KY_CAT_CARDREAD.keyId].opt.catCardRead.useCard;
  }

  /// プリカ宣言: プリカ会計キー未使用時の残高情報印字
  /// 引数: 共有クラス_RxCommonBuf
  /// 戻値: 0=しない  1=する
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_PrecaIn_BalancePrintWithNoPrecaPayment
  static int rxChkKoptPrecaInBalancePrintWithNoPrecaPayment(RxCommonBuf cBuf) {
    return cBuf.dbKfnc[FuncKey.KY_PRECA_IN.keyId].opt.precaIn
        .balPrintNoPrecaPayment;
  }

  /// 釣機回収での金種別出金機能フラグチェック関数	0:しない  1:硬貨のみ
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmnChgpickKindOut
  static int rxChkKoptCmnChgPickKindOut(RxCommonBuf cBuf) {
    int flg = 0;
    flg = cBuf.dbKfnc[FuncKey.KY_CHGPICK.keyId].opt.chgpick.frcSelectOutFlg;
    return flg;
  }

  /// 機能：会計及び品券のキーオプション「差異チェック時、理論在高を自動セット」の確認
  /// 引数：C_BUF,fnc_kind
  /// 戻値：0：しない 1:する(書換可) 2:する(書換不可)
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_DrwChk_Auto_Set_Key_Opt
  static int rxChkKoptCmnDrwChkAutoSetKeyOpt(RxCommonBuf cBuf, int fncKind) {
    int result = 0;

    if (cBuf.dbKfnc[fncKind].fncKind == KeyKindList.KEY_KIND_CHA) {
      result = cBuf.dbKfnc[fncKind].opt.cha.drwchkAutoSet;
    }
    return result;
  }

  /// プリカ宣言: チャージ用部門外実績小分類番号
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKopt_PrecaIn_ChargeSmlCls
  static int rxChkKoptPrecaInChargeSmlCls(RxCommonBuf cBuf) {
    return (cBuf.dbKfnc[FuncKey.KY_PRECA_IN.keyId].opt.precaIn.chargeSmlclsCd);
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rxkoptcmncom.c - rxChkKoptCmn_VescaCharge
  static int rxChkKoptCmnVescaCharge() {
    return 0;
  }
}
