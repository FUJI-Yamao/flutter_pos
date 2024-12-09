/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_verr.c
class EcsVerr {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsVersionRead()
  /// * 機能概要      : バージョンリードコマンド送信ライブラリ  (富士電機製釣銭釣札機(ECS77)
  /// * 引数          : TprTID src
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifEcsVersionRead(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(28, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1; /* DC1 = 11H */
      sendBuf[len++] = IfAcxDef.ECS_VERREAD; // ECS_VERREAD = 5AH
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x30";

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsVersionReadGet()
  /// * 機能概要      : バージョンリードコマンド返答取得ライブラリ
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t	*rcvBuf
  /// *                 uchar *ecsFwVer
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifEcsVersionReadGet(
      TprTID src, TprMsgDevReq2_t rcvBuf, List<String> ecsFwVer) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int i;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      // 正常レスポンス時
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode;
      }

      // ecsFwVer[0]〜[4]   : コントローラ部
      // ecsFwVer[5]〜[9]   : 硬貨部_1
      // ecsFwVer[10]〜[14] : 硬貨部_1
      // ecsFwVer[15]〜[19] : 硬貨部_ブート
      // ecsFwVer[20]〜[24] : 紙幣部_1
      // ecsFwVer[25]〜[29] : 紙幣部_2
      // ecsFwVer[30]〜[34] : 紙幣部_3
      // ecsFwVer[35]〜[39] : 紙幣部_ブート
      // ecsFwVer[40]〜[44] : 棒金収納庫
      for (i = 0; i < 45; i++) {
        ecsFwVer[i] = rcvBuf.data[2 + i];
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSettingRead()
  /// * 機能概要      : バージョンリードコマンド送信ライブラリ  (富士電機製釣銭釣札機(ECS77)
  /// * 引数          : TprTID src
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifEcsSettingRead(TprTID src, int mode) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(28, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x00");
      sendBuf[len++] = TprDefAsc.DC1; // DC1 = 11H
      sendBuf[len++] = IfAcxDef.ECS_SETTINGREAD; // ECS_SETTINGREAD = 57H
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x31";

      if (mode < 0x30 || mode > 0x3f) {
        TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
            "if_ecs_SettingRead() mode error [$mode]");
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf[len++] = latin1.decode([mode]);

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSettingReadGet()
  /// * 機能概要      : 動作条件設定リードコマンド返答取得ライブラリ
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t *rcvBuf
  /// *                 int *ecsSet
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifEcsSettingReadGet(
      TprTID src, TprMsgDevReq2_t rcvBuf, List<String> ecsSet) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int i;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; // NG return
      }

      for (i = 0; i < 5; i++) {
        ecsSet[i] = rcvBuf.data[2 + i];
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSettingReadExpansion()
  /// * 機能概要      : 動作条件設定リードコマンド(拡張仕様)送信ライブラリ(富士電機製釣銭釣札機 ECS-777)
  /// * 引数          : TprTID src
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifEcsSettingReadExpansion(
      TprTID src, List<int> mode) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(28, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x00");
      sendBuf[len++] = TprDefAsc.DC1; // 11H
      sendBuf[len++] = IfAcxDef.ECS_SETTINGREAD; // 57H
      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x32"; // 拡張仕様

      // Mode
      if ((mode[0] < 0x30 || mode[0] > 0x33) ||
          (mode[1] < 0x30 || mode[1] > 0x3f)) {
        TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
            "if_ecs_SettingRead_Expansion() mode error [${mode[0]}][${mode[1]}]");
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      sendBuf[len++] = latin1.decode([mode[0]]);
      sendBuf[len++] = latin1.decode([mode[1]]);

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSettingReadGetExpansion()
  /// * 機能概要      : 動作条件設定リードコマンド(拡張仕様)返答取得ライブラリ(富士電機製釣銭釣札機 ECS-777)
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t *rcvBuf
  /// *                 uchar *ecsSet
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifEcsSettingReadGetExpansion(
      TprTID src, TprMsgDevReq2_t rcvBuf, List<String> ecsSet) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int i;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; // NG return
      }

      for (i = 0; i < 12; i++) {
        // 拡張仕様は12桁
        ecsSet[i] = rcvBuf.data[2 + i];
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
