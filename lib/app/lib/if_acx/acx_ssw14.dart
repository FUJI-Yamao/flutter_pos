/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_sset.dart';

/// 関連tprxソース:acx_ssw14.c
class AcxSsw14 {
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSswSet()
  /// * 機能概要      : ssw14 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb50Ssw14Set(TprTID src) async {
    int sswNo;
    int kind;
    int sendRes;
    List<int> setData = [];

    kind = 0;
    sswNo = 14;

    if (await sSW14Set(setData) == false) {
      return IfAcxDef.MSG_ACRSENDERR;
    }

    sendRes = await AcxSset.ifAcb20SswCmdSend(src, kind, sswNo, setData);

    return sendRes;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int sSW14Set()
  /// * 機能概要      : ssw14 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<bool> sSW14Set(List<int> setData) async {
    RxCommonBuf pComBuf = RxCommonBuf();
    List<int> setDataBuf = [];

    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      return false;
    }
    pComBuf = cRet.object;

    setDataBuf[0] = 0x00;
    setDataBuf[0] |=
    (pComBuf.iniMacInfo.acx_flg.acr50_ssw14_0 == 1) ? 0x01 : 0x00;
    switch (pComBuf.iniMacInfo.acx_flg.acr50_ssw14_1_2) {
      case 1: setDataBuf[0] |= 0x02; break;
      case 2: setDataBuf[0] |= 0x04; break;
    }
    switch (pComBuf.iniMacInfo.acx_flg.acr50_ssw14_3_4) {
      case 1: setDataBuf[0] |= 0x08; break;
      case 2: setDataBuf[0] |= 0x10; break;
    }
    setDataBuf[0] |= (pComBuf.iniMacInfo.acx_flg.acr50_ssw14_5 == 1) ? 0x20 : 0x00;
    setDataBuf[0] |= (pComBuf.iniMacInfo.acx_flg.acr50_ssw14_7 == 1) ? 0x80 : 0x00;

    setData = setDataBuf;

    return true;
  }
  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbSsw14Set()
  /// * 機能概要      : info.ini の設定値をSSW14に設定する。
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbSsw14Set(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
        case CoinChanger.SST1:
        case CoinChanger.FAL2:
          errCode = await AcxCom.ifAcxCmdSkip(src, ifAcbSsw14Set); //処理なし
          break;
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = await ifAcb50Ssw14Set(src);
          break;
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    } else {
   // #else
      return (IfAcxDef.MSG_ACROK);
   // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50Ssw14_7Set()
  /// * 機能概要      : ssw14 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb50Ssw14_7Set(TprTID src, int ssw14_7) async {
    int sswNo;
    int kind;
    int sendRes;
    List<int> setData = [];

    kind = 0;
    sswNo = 14;

    if (await sSW14Set(setData) == false) {
      return IfAcxDef.MSG_ACRSENDERR;
    }

    setData[0] &= 0x7f;
    setData[0] |= (ssw14_7 == 1) ? 0x80 : 0x00;
    sendRes = await AcxSset.ifAcb20SswCmdSend(src, kind, sswNo, setData);

    return sendRes;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbSsw14_7Set()
  /// * 機能概要      : ssw14 Set
  /// *                info.ini の設定値をSSW14に設定する。
  /// *                計数開始時の空転処理のみ、引数で渡された値を設定する。
  /// * 引数          : TprTID src
  /// *                 short ssw14_7	計数開始時の空転処理 0:あり 1:なし
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbSsw14_7Set(TprTID src, int ssw14_7) async {
    // TODO: コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
        case CoinChanger.SST1:
        case CoinChanger.FAL2:
          errCode = await AcxCom.ifAcxCmdSkip(src, ifAcbSsw14_7Set); //処理なし
          break;
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = await ifAcb50Ssw14_7Set(src, ssw14_7);
          break;
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}
