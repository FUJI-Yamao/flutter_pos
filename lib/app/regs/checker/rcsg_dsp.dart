/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../lib/cm_sys/cm_cksys.dart';

///  関連tprxソース: rcsg_dsp.c
///  関連tprxソース: rcsg_dsp.c
class RcsgDsp {
  static SgMntDsp mntDsp = SgMntDsp();
  static SgDualDsp dualDsp = SgDualDsp();

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcsg_dsp.c - rcSG_EndDisp_BackBtn
  static void rcSGEndDispBackBtn() {
    return ;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcsg_dsp.c - rcSG_ThankYouSound_Proc
  static int rcSGThankYouSoundProc() {
    return 0;
  }

  ///  関連tprxソース: rcsg_dsp.c - rcSG_Check_Pana_Card
  static Future<bool> rcSGCheckPanaCard() async {
    if (await RcSysChk.rcSGChkSelfGateSystem() &&
        await RcSysChk.rcNewSGChkNewSelfGateSystem() &&
        (await CmCksys.cmRainbowCardSystem() != 0)) {
      return true;
    } else {
      return false;
    }
  }
  
  ///  関連tprxソース: rcsg_dsp.c - rcSG_Chk_GetEdy()
  //実装は必要だがARKS対応では除外
  static void rcSGChkGetEdy(){
    return;
  }

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rcsg_dsp.c - rcSG_Disp_dPointMemberCheckWindow()
  static void rcSGDispDPointMemberCheckWindow(){
    return;
  }

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rcsg_dsp.c - rcSG_Nimoca_Poi_Ck_Fnc
  static void rcSGNimocaPoiCkFnc(){}

}