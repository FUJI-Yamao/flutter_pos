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

/// 関連tprxソース:acx_ssw15.c
class AcxSsw15 {
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50Ssw15Set()
  /// * 機能概要      : ssw15 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb50Ssw15Set(TprTID src) async {
    int sswNo;
    int kind;
    int sendRes;
    List<int> setData = [];

    kind = 0;
    sswNo = 15;

    if (await sSW15Set(setData) == false) {
      return IfAcxDef.MSG_ACRSENDERR;
    }

    sendRes = await AcxSset.ifAcb20SswCmdSend(src, kind, sswNo, setData);

    return sendRes;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int sSW15Set()
  /// * 機能概要      : ssw15 Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<bool> sSW15Set(List<int> setData) async {
    RxCommonBuf pComBuf = RxCommonBuf();
    List<int> setDataBuf = [];

    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      return false;
    }
    pComBuf = cRet.object;

    setDataBuf[0] = 0x00;
    setDataBuf[0] |=
    (pComBuf.iniMacInfo.acx_flg.acb50_ssw15_0 == 1) ? 0x01 : 0x00;
    setDataBuf[0] |=
    (pComBuf.iniMacInfo.acx_flg.acb50_ssw15_1 == 1) ? 0x02 : 0x00;
    setDataBuf[0] |=
    (pComBuf.iniMacInfo.acx_flg.acb50_ssw15_2 == 1) ? 0x04 : 0x00;
    setDataBuf[0] |=
    (pComBuf.iniMacInfo.acx_flg.acb50_ssw15_3 == 1) ? 0x08 : 0x00;

    setData = setDataBuf;

    return true;
  }

  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbSsw15Set()
  /// * 機能概要      : ssw15 Set
  /// *                info.ini の設定値をSSW15に設定する。
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcbSsw15Set(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
        case CoinChanger.SST1:
          errCode = IfAcxDef.MSG_ACROK;
          break;
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = await ifAcb50Ssw15Set(src);
          break;
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    } else {
    // #else
    return(IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}