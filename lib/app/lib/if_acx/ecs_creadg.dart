/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../drv/changer/drv_changer_isolate.dart';
import '../../if/if_drv_control.dart';
import 'acx_com.dart';
import 'acx_stcg.dart';

class changerCinReadEcsGetRet {
  int result = 0;      // 関数実行結果
  CinReadEcs cinReadEcs = CinReadEcs();
}

/// 関連tprxソース:ecs_creadg.c
class EcsCreadg{
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : changerCinReadEcsGetRet ifEcsCinReadGet()
  /// * 機能概要      : 入金枚数リードレスポンス受信データ解析ライブラリ(富士電機製釣銭釣札機)
  /// * 引数          : TprTID src 
  /// *               : TprMsgDevReq2_t rcvbuf  受信データアドレス 
  /// *               : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// *               : TprMsgDevReq2_t rcvBuf  受信データ
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        cinReadEcs   : 入金データ
  /// *--------------------------------------------------------------------------------
  static int ifEcsCinReadGet(TprTID src, CinReadEcs cinReadEcs, TprMsgDevReq2_t rcvbuf)
  {
    List<String> readbuf = List.generate(35, (_) => "");
    int i;

    int ret= AcxCom.ifAcxRcvHeadChk(src, rcvbuf);
    if(ret == IfAcxDef.MSG_ACROK ) {        /*  OK !  next    */
        ret = AcxCom.ifAcxRcvDLEChk(src, rcvbuf.data);
    }
    if(ret != IfAcxDef.MSG_ACROK ) {
        return ret;        /* NG return   !  */
    }

    /* data set                         */
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2];  }
    cinReadEcs.cindata.coin500    = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*1];  }
    cinReadEcs.cindata.coin100    = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*2];  }
    cinReadEcs.cindata.coin50     = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*3];  }
    cinReadEcs.cindata.coin10     = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*4];  }
    cinReadEcs.cindata.coin5      = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*5];  }
    cinReadEcs.cindata.coin1      = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*6];  }
    cinReadEcs.cindata.bill10000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*7];  }
    cinReadEcs.cindata.bill5000   = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*8];  }
    cinReadEcs.cindata.bill2000   = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvbuf.data[i+2+3*9];  }
    cinReadEcs.cindata.bill1000   = AcxStcg.ifAcxRepack(src, readbuf);

    String str = rcvbuf.data[35];
    cinReadEcs.reject_coin = int.parse(str);
    str = rcvbuf.data[36];
    cinReadEcs.reject_bill = int.parse(str);

    return ret;
  }
}
