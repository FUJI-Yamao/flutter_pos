/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_coin.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_mente_out.c
class AcxMenteOut {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300MenteOut()
  /// * 機能概要      : Coin/Bill Changer Mentenance(Out of Sales) Change Out
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifRt300MenteOut(TprTID src, int mChange) async {
    int errCode;
    List<String> sendBuf = List.generate(9, (_) => "");
    List<String> sendBuf2 = List.generate(10, (_) => "");
    int len;
    RxCommonBuf pComBuf = RxCommonBuf();

    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      return IfAcxDef.MSG_ACRSENDERR;
    }
    pComBuf = cRet.object;

    if (pComBuf.iniMacInfo.acx_flg.acb50_ssw24_0 == 1) {
      // \999,999 up Change ?
      if (mChange > 999999) {
        return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
      }

      // Send Buffer set(Change out Command)
      sendBuf2[0] = TprDefAsc.DC1;
      sendBuf2[1] = IfAcxDef.ACR_MENTE_OUT;
      sendBuf2[2] = "\x30";
      sendBuf2[3] = "\x36";
      sendBuf2[4] = (0x30 + (mChange / 100000)).toString();
      sendBuf2[5] = (0x30 + ((mChange % 100000) / 10000)).toString();
      sendBuf2[6] = (0x30 + (((mChange % 100000) % 10000) / 1000)).toString();
      sendBuf2[7] =
          (0x30 + ((((mChange % 100000) % 10000) % 1000) / 100)).toString();
      sendBuf2[8] =
          (0x30 + (((((mChange % 100000) % 10000) % 1000) % 100) / 10))
              .toString();
      sendBuf2[9] =
          (0x30 + ((((((mChange % 100000) % 10000) % 1000) % 100) % 10)))
              .toString();
      len = 10;

      //  transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf2, len);
    } else {
      //  \9,999 up Change ?
      if (mChange > 99999) {
        return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
      }

      //  Send Buffer set(Change out Command)
      sendBuf[0] = TprDefAsc.DC1;
      sendBuf[1] = IfAcxDef.ACR_MENTE_OUT;
      sendBuf[2] = "\x30";
      sendBuf[3] = "\x35";
      sendBuf[4] = (0x30 + (mChange / 10000)).toString();
      sendBuf[5] = (0x30 + ((mChange % 10000) / 1000)).toString();
      sendBuf[6] = (0x30 + (((mChange % 10000) % 1000) / 100)).toString();
      sendBuf[7] =
          (0x30 + ((((mChange % 10000) % 1000) % 100) / 10)).toString();
      sendBuf[8] =
          (0x30 + ((((mChange % 10000) % 1000) % 100) % 10)).toString();
      len = 9;

      //  transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }

    return errCode;
  }

  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxMenteOut()
  /// * 機能概要      : Coin/Bill Changer Mentenance(Out of Sales) Change Out
  /// * 引数          : TprTID src
  /// *              : int changerFlg
  /// *              : int mChange
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxMenteOut(
      TprTID src, int changerFlg, int mChange) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal,
          "***** OUT : price[$mChange]");

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            errCode = await AcxCoin.ifAcb10ChangeOut(src, mChange);
            break;
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
          case CoinChanger.ECS_777:
            errCode = await AcxCoin.ifAcb20ChangeOut(src, mChange);
            break;
          case CoinChanger.RT_300:
            errCode = await ifRt300MenteOut(src, mChange);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await AcxCoin.ifAcb20ChangeOut(src, mChange);
            break;
          default:
            errCode = await AcxCoin.ifAcrChangeOut(src, mChange);
            break;
        }
      } else /* Changer_flg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
      // #else
    } else {
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
