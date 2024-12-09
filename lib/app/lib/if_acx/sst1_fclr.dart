/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース: sst1_fclr.c
class Sst1FClr{
  /// Usage    : short if_sst1_FlgClear( TPRTID src, uchar bill_coin )
  ///
  /// Argument : TPRTID src
  ///            uchar  bill_coin   クリアするフラグ
  /// 		                        0:紙幣部／1:硬貨部
  /// Functions: 在高状態フラグクリアコマンド送信ライブラリ(ＮＥＣ製釣銭釣札機)
  /// 関連tprxソース: sst1_fclr.c - if_sst1_FlgClear
  static Future<int> ifSst1FlgClear(TprTID src, int billCoin) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(8, (_) => "");
    int len = 0;

    if ((AcxCom.ifAcbSelect() & CoinChanger.SST1) == 0) {
      return IfAcxDef.MSG_ACRFLGERR;
    }

    sendBuf = List.generate(8, (_) => "");
    sendBuf.fillRange(0, sendBuf.length, "\x30");
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.SST1_FLGCLEAR;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x34";
    sendBuf[len++] = "\x30";

    Sst1FlgClr flg = Sst1FlgClr.getDefine(billCoin);
    switch (flg) {
      case Sst1FlgClr.SST1_FCLR_BILL:
        sendBuf[len++] = "\x30";
        break;
      case Sst1FlgClr.SST1_FCLR_COIN:
        sendBuf[len++] = "\x31";
        break;
      default:
        return IfAcxDef.MSG_ACRFLGERR;
    }
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";

    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
    // #else
    // return MSG_ACROK;
    // #endif
  }
}