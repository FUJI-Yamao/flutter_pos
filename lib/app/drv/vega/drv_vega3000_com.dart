/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/if_vega3000/vega3000_com.dart';
import '../../regs/checker/rc_vega3000.dart';
import '../../regs/inc/rc_crdt.dart';
import '../../regs/inc/rc_mem.dart';
import 'drv_vega.dart';

class DrvVega3000Com {
  // 各種格納用パラメタ
  PosMsParam msParam = PosMsParam();
  RxCommonBuf cBuf = RxCommonBuf();
  RxTaskStatBuf tsBuf = RxTaskStatBuf();

  /// VEGA3000との通信を開始するかチェックする
  /// 引数:共有クラス（RxTaskStatBuf）
  /// 戻り値: true=開始する  false=開始しない
  /// 関連tprxソース: rc_vega3000_com.c - vega_event_chk
  bool vegaChkEvent(RxTaskStatBuf tsBuf) {
    if (CompileFlag.CENTOS) {
      if (tsBuf.vega.vegaOrder == VegaOrder.VEGA_COGCA_TX.cd) {
        return true;
      }
      else if (tsBuf.vega.vegaOrder == VegaOrder.VEGA_MS_TX.cd) {
        return true;
      }
    }
    return false;
  }

  /// 磁気カード読込メイン処理
  /// 引数:[inCmnBuf] 共有クラス（RxCommonBuf）
  /// 引数:[inStatBuf] 共有クラス（RxTaskStatBuf）
  /// 引数:[inParam] 磁気カード情報
  /// 関連tprxソース: rc_vega3000_com.c - vega_ms_main
  Future<void> vegaMsMain(RxCommonBuf inCmnBuf, RxTaskStatBuf inStatBuf,
      PosMsParam inParam) async {
    int ret = 0;
    String callFunc = "DrvVega3000Com.vegaMsMain()";
    TprLog().logAdd(
        Tpraid.TPRAID_VEGA3000, LogLevelDefine.normal, "$callFunc: start");
    cBuf = inCmnBuf;
    tsBuf = inStatBuf;
    msParam = inParam;

    // VEGAデバイス読み取り準備
    ret = _vegaMsReadStart(msParam);

    // VEGAデバイス読み取り開始
    if (ret != 0) {
      ret = _vegaMsReadProcess(msParam);
    }

    // VEGAデバイス読み取り終了
    if (ret != 0) {
      ret = vegaMsReadStop(msParam);
    }
    else {
      vegaMsReadStop(msParam); /* 前処理のエラー状態を更新してしまわないように */
    }

    // 通信エラー判定（エラーコードの頭が'D'の場合、エラー）
    if (tsBuf.vega.vegaData.errCode[0] == 'D') {
      ret = 0;
    }

    // 読み取り結果を格納する
    if (ret != 0) {
      // 正常終了
      TprLog().logAdd(Tpraid.TPRAID_VEGA3000, LogLevelDefine.normal,
          "$callFunc: vega MS response Return");
      _vegaMsDataSet(msParam);
      tsBuf.vega.vegaOrder = VegaOrder.VEGA_MS_RX.cd;
    }
    else {
      // エラー
      if ((cBuf.vega3000Conf.vega3000CancelFlg == 1)
          && (tsBuf.vega.vegaData.errCode.join() == "D52")) {
        TprLog().logAdd(Tpraid.TPRAID_VEGA3000, LogLevelDefine.error,
            "$callFunc: vega MS Cancel End");
      }
      else {
        TprLog().logAdd(Tpraid.TPRAID_VEGA3000, LogLevelDefine.error,
            "$callFunc: vega MS Error Return");
      }
      tsBuf.vega.vegaOrder = VegaOrder.VEGA_ERR_END.cd;
    }
    TprLog().logAdd(
        Tpraid.TPRAID_VEGA3000, LogLevelDefine.normal, "$callFunc: end");
  }

  /// 磁気カード読込開始
  /// 引数: 磁気カード情報
  /// 戻り値: ドライバ関数の結果（1=正常終了  0=異常終了）
  /// 関連tprxソース: rc_vega3000_com.c - vega_ms_readstart
  int _vegaMsReadStart(PosMsParam inParam) {
    int ret = 0;

    debugPrint("********** DrvVega3000Com._vegaMsReadStart(): start");
    if (CompileFlag.CENTOS) {
      // VEGA端末_磁気カード読取準備
      ret = RcVega3000.ifVega3000.ifVega3000StartPlusPosMsRead(inParam, cBuf.vega3000Conf);
      if (ret != 0) {
        // コールバック関数をドライバへ登録する
        ret = vegaMsReadCancel(cBuf);
      }
    }
    debugPrint("********** DrvVega3000Com._vegaMsReadStart(): ret = $ret");

    return ret;
  }

  /// 磁気カード読込処理
  /// 引数: 磁気カード情報
  /// 戻り値: ドライバ関数の結果（1=正常終了  0=異常終了）
  /// 関連tprxソース: rc_vega3000_com.c - vega_ms_readprocess
  int _vegaMsReadProcess(PosMsParam inParam) {
    int ret = 0;

    debugPrint("********** DrvVega3000Com._vegaMsReadProcess(): start");
    if (CompileFlag.CENTOS) {
      msParam = _rcSetToReadPosMsParam(inParam);
      DrvVega.msParam = msParam;
      ret = RcVega3000.ifVega3000.ifVega3000PlusPosMsRead(inParam, cBuf.vega3000Conf);
    }
    debugPrint("********** DrvVega3000Com._vegaMsReadProcess(): ret = $ret");

    return ret;
  }

  /// 磁気カード読込終了処理
  /// 引数: 磁気カード情報
  /// 戻り値: ドライバ関数の結果（1=正常終了  0=異常終了）
  /// 関連tprxソース: rc_vega3000_com.c - vega_ms_readstop
  int vegaMsReadStop(PosMsParam inParam) {
    int ret = 0;

    debugPrint("********** DrvVega3000Com.vegaMsReadStop(): start");
    if (CompileFlag.CENTOS) {
      ret = RcVega3000.ifVega3000.ifVega3000EndPlusPosMsRead(inParam, cBuf.vega3000Conf);
    }
    debugPrint("********** DrvVega3000Com.vegaMsReadStop(): ret = $ret");

    return ret;
  }

  /// 磁気カード取得データセット
  /// 引数: 磁気カード情報
  /// 関連tprxソース: rc_vega3000_com.c - vega_ms_dataset
  void _vegaMsDataSet(PosMsParam inParam) {
    String callFunc = "RcVega3000Com.vegaMsDataSet()";
    tsBuf.vega.vegaData = RxMemVegaCard();

    tsBuf.vega.vegaData.cardType = MCD.D_MCD2;
    tsBuf.vega.vegaData.type = inParam.card.type;
    List<int> tmpErr = inParam.header.errorCode.map((n) => int.tryParse(n, radix: 16) ?? 0).toList();
    List<int> tmpCode1 = inParam.card.cardData1.map((n) => int.tryParse(n, radix: 16) ?? 0).toList();
    List<int> tmpCode2 = inParam.card.cardData2.map((n) => int.tryParse(n, radix: 16) ?? 0).toList();
    List<int> tmpMsg1 = inParam.header.message1.map((n) => int.tryParse(n, radix: 16) ?? 0).toList();
    List<int> tmpMsg2 = inParam.header.message2.map((n) => int.tryParse(n, radix: 16) ?? 0).toList();
    tsBuf.vega.vegaData.errCode = tmpErr.map((n) => String.fromCharCode(n)).toList();
    tsBuf.vega.vegaData.cardData1 = tmpCode1.map((n) => String.fromCharCode(n)).toList();
    tsBuf.vega.vegaData.cardData2 = tmpCode2.map((n) => String.fromCharCode(n)).toList();
    tsBuf.vega.vegaData.msg1 = tmpMsg1.map((n) => String.fromCharCode(n)).toList();
    tsBuf.vega.vegaData.msg2 = tmpMsg2.map((n) => String.fromCharCode(n)).toList();
    debugPrint("********** $callFunc: errorCode = ${inParam.header.errorCode}");
    debugPrint("********** $callFunc: message1 = ${inParam.header.message1}");
    debugPrint("********** $callFunc: message2 = ${inParam.header.message2}");
    debugPrint("********** $callFunc: cardData1 = ${inParam.card.cardData1}");
    debugPrint("********** $callFunc: cardData2 = ${inParam.card.cardData2}");
  }

  /// VEGA端末ドライバ読み取り用の初期値をセットする
  /// 引数: 磁気カード情報（読取設定前）
  /// 戻り値: 磁気カード情報（読取設定後）
  PosMsParam _rcSetToReadPosMsParam(PosMsParam inParam) {
    PosMsParam retParam = inParam;

    retParam.header.businessCode = "CGC".split("");
    retParam.header.businessSubCode = 1;
    retParam.header.processDate = "240905".split("");
    retParam.header.processTime = "165813".split("");
    retParam.header.terminalID = '\0\0\0\0\0\0\0\0\0\0\0\0\0\0'.split("");
    retParam.header.slipNumber = "\0\0\0\0\0".split("");
    retParam.header.terminalType = 0; // 端末識別区分
    retParam.header.extraA0 = "\0\0\0\0\0\0\0\0\0".split("");
    retParam.header.operatorCode = "\0\0\0\0\0".split("");
    retParam.header.memo1 = "\0\0\0\0\0\0\0\0\0\0".split("");
    retParam.header.memo2 = "\0\0\0\0\0\0\0\0\0\0".split("");
    retParam.header.testModeFlag = 48; // TESTモードフラグ
    retParam.header.extraA1 = "\0\0\0\0\0\0\0\0\0\0".split("");
    retParam.header.processingResult = 0; // 処理結果
    retParam.header.errorCode = "\0\0\0".split("");
    retParam.header.message1 =
        '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'.split("");
    retParam.header.message2 =
        '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'.split("");
    retParam.header.responseCode = "\0\0\0\0".split("");
    retParam.header.dllFlag = 0; // ＤＬＬフラグ
    retParam.header.extraA2 = "\0\0\0\0\0\0\0\0\0\0\0".split("");

    return retParam;
  }

  /// VEGA端末キャンセル処理
  /// 引数: 共有クラス（RxCommonBuf）
  /// 戻り値: ドライバ関数の結果（1=正常終了  0=異常終了）
  int vegaMsReadCancel(RxCommonBuf inBuf) {
    int ret = 0;

    debugPrint("********** DrvVega3000Com.vegaMsReadCancel() start: vega3000CancelFlg = ${inBuf.vega3000Conf.vega3000CancelFlg}");
    if (CompileFlag.CENTOS) {
      ret = RcVega3000.ifVega3000.ifVega3000PlusPosRegisterCancelCallback(
          _vegaCallback, inBuf.vega3000Conf);
    }
    debugPrint("********** DrvVega3000Com.vegaMsReadCancel(): ret = $ret");

    return ret;
  }

  /// コールバック処理
  /// 戻り値: true=コールバック実施  false=コールバック未実施
  /// 関連tprxソース: rc_vega3000_com.c - vega_callback
  bool _vegaCallback() {
    if (cBuf.vega3000Conf.vega3000CancelFlg == 1) {
      TprLog().logAdd(Tpraid.TPRAID_VEGA3000, LogLevelDefine.normal,
          "DrvVega3000Com.vegaCallback(): Get CallBackFlg");
      return true;
    }
    return false;
  }

  // TODO:10155 顧客呼出 - 宣言のみ（仕様対象外）
  /// VEGA3000端末CoGCa処理
  /// 関連tprxソース: rc_vega3000_com.c - vega_cogca_main
  void vegaCogcaMain() {}
}
