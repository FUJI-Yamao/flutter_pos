/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/regs/checker/rc_qc_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_qc_dsp.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

///  関連tprxソース: rc28stlinfo.c
class Rc28StlInfo {
  ///  関連tprxソース: rc28stlinfo.c - ColorFipWindowModeLine
  static void colorFipWindowDestroy() {
    // TODO:00008 宮家 中身の実装予定　
    return;
  }

  ///  関連tprxソース: rc28stlinfo.c - ColorFipChk
  static int colorFipChk() {
    // TODO:00005 田中 rcATCT_Print実装のため、定義のみ追加
    return 0;
  }

  ///  関連tprxソース: rc28stlinfo.c - rc_fself_subttl_redisp
  static Future<void> rcFselfSubttlRedisp() async {
    if (await RcSysChk.rcSysChkHappySmile()) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcFselfSubttlRedisp : no action!!<call from chkr>\n");
        return;
      }
    }

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcFselfSubttlRedisp\n");

    // MEMO :画面遷移の都合上チェック処理はコメントアウト
    // if(await RcSysChk.rcChkFselfSystem()){
      // 小計画面まで戻る
      RcQcDsp.rcQCBackBtnFunc();
    // }
  }

  ///  関連tprxソース: rc28stinfo.c - rc_ColorFip_Destroy_HalfMsg
  static void rcColorFipDestroyHalfMsg() {
    // TODO:00004 小出 Err2実装のため、定義のみ追加
    // TODO:      ただ、flutter ではモーダレス画面が無いので意味がない関数になるかも。
    // if(tColorFipItemInfo.halfcolor_window != NULL) {
    //   gtk_widget_destroy(tColorFipItemInfo.halfcolor_window);
    //   tColorFipItemInfo.halfcolor_window = NULL;
    // }
  }

  // TODO:00016 佐藤 定義のみ追加
  /// 関連tprxソース: rc28stinfo.c - ColorFipWindowCreate
  static void colorFipWindowCreate(SubttlInfo? subTtl, int ttlDraw) {
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_SusReg
  static void rc28StlLcdSusReg(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_OMC
  static void rc28StlLcdOMC(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_Carry
  static void rc28StlLcdCarry(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_MMReg
  static void rc28StlLcdMMReg(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_HomeDlv
  static void rc28StlLcdHomeDlv(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_SuicaTrans
  static void rc28StlLcdSuicaTrans(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rcStlLcd_28Total
  static void rcStlLcd28Total(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_ESVoid_DscChange
  static void rc28StlLcdESVoidDscChange(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  ///  関連tprxソース: rc28stlinfo.c - rc28StlLcd_Quantity
  static void rc28StlLcdQuantity(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// LCD Mark Buffer Set and Subttl Display Process
  ///  関連tprxソース: rc28stlinfo.c - rcDspMbrmk_28StlLCD
  static void rcDspMbrMk28StlLCD(SubttlInfo pSubttl) {}

  // TODO: 定義のみ追加
  /// 機能概要　：カラー客表のポップアップを消去する
  /// 関連tprxソース: rc28stlinfo.c - ColorFipPopdown
  static void ColorFipPopdown() {}

  /// Display Status Set for WEB2800
  /// 引数: 画面を構成するアイテムのインデックス
  /// 戻り値: 0=設定不要  1=設定完了
  ///  関連tprxソース: rc28stlinfo.c - rcStlLcd_28SetDispStatus
  static Future<int> rcStlLcd28SetDispStatus(int pNum) async {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
      return 0;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    if (pNum == atSing.tStlLcdItem.itemMax) {
      // 登録、小計画面移行時など
      if (atSing.tStlLcdItem.currNum > atSing.tStlLcdItem.itemMax) {
        atSing.tStlLcdItem.currNum = 0;
        atSing.tStlLcdItem.stlCurrNum = 0;
      }
      atSing.tStlLcdItem.currMax = atSing.tStlLcdItem.itemMax;
      atSing.tStlLcdItem.stlCurrMax = atSing.tStlLcdItem.itemMax;
    }
    else if (FbInit.subinitMainSingleSpecialChk()) {
      // タワータイプ 1人制の時の処理
      if ((pNum < atSing.tStlLcdItem.currNum) ||
          (pNum < atSing.tStlLcdItem.stlCurrNum)) {
        // page up ( ex 2 -> 1 )
        if (pNum < 0) {
          return 0;
        }
        atSing.tStlLcdItem.currMax = pNum;
        atSing.tStlLcdItem.stlCurrMax = pNum;
        if (!(await RegistInitData.presetItemChk()) || (cBuf.devId == 1)) {
          atSing.tStlLcdItem.currNum = atSing.tStlLcdItem.stlItemCurr;
          atSing.tStlLcdItem.itemCurr = atSing.tStlLcdItem.stlItemCurr;
        } else {
          atSing.tStlLcdItem.stlCurrNum = atSing.tStlLcdItem.itemCurr;
          atSing.tStlLcdItem.stlItemCurr = atSing.tStlLcdItem.itemCurr;
        }
      } else if ((pNum > atSing.tStlLcdItem.currMax) ||
          (pNum > atSing.tStlLcdItem.stlCurrMax)) {
        // page down ( ex 2-> 3 )
        if (pNum > atSing.tStlLcdItem.itemMax) {
          return 0;
        }
        atSing.tStlLcdItem.currNum = pNum;
        atSing.tStlLcdItem.stlCurrNum = pNum;
        if (!(await RegistInitData.presetItemChk())) {
          atSing.tStlLcdItem.currNum = 0;
        }
      }
    } else if (pNum < atSing.tStlLcdItem.currNum) {
      // page up ( ex 2 -> 1 )
      if (pNum < 0) {
        return 0;
      }
      atSing.tStlLcdItem.currMax = pNum;
    } else if (pNum > atSing.tStlLcdItem.currMax) {
      // page down ( ex 2-> 3 )
      if (pNum > atSing.tStlLcdItem.itemMax){
        return 0;
      }
      atSing.tStlLcdItem.currNum = pNum;
    }

    return 1;
  }
}
