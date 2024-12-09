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

class changerCinReadGetRet {
  int result = 0;      // 関数実行結果
  CinInfo cinInfo = CinInfo();
}

/// 関連tprxソース:acx_creadg.c
class AcxCreadg{
  ////*--------------------------------------------------------------------------------
  /// * 関数名         :changerCinReadGetRet ifAcb20CinReadGet()
  /// * 機能概要       : 
  /// * 引数           : TprTID src
  /// *                : List<String> rcvdata  レスポンスデータ
  /// * 戻り値 result  : 0(MSG_ACROK) 正常終了
  /// *        cinInfo : 
  ///  --------------------------------------------------------------------------------
  static int ifAcb20CinReadGet( TprTID src, CinInfo cinInfo, List<String> rcvdata ) {
    int ret = IfAcxDef.MSG_ACROK;
    List<String> readbuf = List.generate(4, (_) => "");
    int i;

    /* data set                         */
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9];  }
    cinInfo.cindata.bill10000 = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*1];  }
    cinInfo.cindata.bill5000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*2];  }
    cinInfo.cindata.bill2000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*3];  }
    cinInfo.cindata.bill1000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*4];  }
    cinInfo.cindata.coin500   = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*5];  }
    cinInfo.cindata.coin100   = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*6];  }
    cinInfo.cindata.coin50    = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*7];  }
    cinInfo.cindata.coin10    = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*8];  }
    cinInfo.cindata.coin5     = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*9];  }
    cinInfo.cindata.coin1     = AcxStcg.ifAcxRepack(src, readbuf);

    String str = rcvdata[2];
    cinInfo.cinflg.cininfo      = int.parse(str);
    str = rcvdata[3];
    cinInfo.cinflg.cinstopcom   = int.parse(str);
    str = rcvdata[4];
    cinInfo.cinflg.device_state = int.parse(str);
    str = rcvdata[5];
    cinInfo.cinflg.billinfo     = int.parse(str);
    str = rcvdata[6];
    cinInfo.cinflg.billdetail   = int.parse(str);
    str = rcvdata[7];
    cinInfo.cinflg.coininfo     = int.parse(str);
    str = rcvdata[8];
    cinInfo.cinflg.coindetail   = int.parse(str);
    str = rcvdata[39];
    cinInfo.cinflg.opeflg       = int.parse(str);

    return ret;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名         : changerCinReadGetRet ifAcb20CinReadGet()
  /// * 機能概要       : 
  /// * 引数           : TprTID src
  /// *                : List<String> rcvdata  レスポンスデータ
  /// * 戻り値 result  : 0
  /// *        cinInfo : 
  ///  --------------------------------------------------------------------------------
  static int ifAcrCinReadGet( TprTID src, CinInfo cinInfo, List<String> rcvdata ) {
    int ret = IfAcxDef.MSG_ACROK;
    List<String> readbuf = List.generate(4, (_) => "");
    int i = 0;

    /* data set                         */
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9];  }
    cinInfo.cindata.bill10000 = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*1];  }
    cinInfo.cindata.bill5000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*2];  }
    cinInfo.cindata.bill2000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*3];  }
    cinInfo.cindata.bill1000  = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*4];  }
    cinInfo.cindata.coin500   = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*5];  }
    cinInfo.cindata.coin100   = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*6];  }
    cinInfo.cindata.coin50    = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*7];  }
    cinInfo.cindata.coin10    = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*8];  }
    cinInfo.cindata.coin5     = AcxStcg.ifAcxRepack(src, readbuf);
    for (i = 0; i < 3; i++)    { readbuf[i] = rcvdata[i+9+3*9];  }
    cinInfo.cindata.coin1     = AcxStcg.ifAcxRepack(src, readbuf);

    String str = rcvdata[2];
    cinInfo.cinflg.cininfo      = int.parse(str);
    str = rcvdata[3];
    cinInfo.cinflg.cinstopcom   = int.parse(str);
    str = rcvdata[4];
    cinInfo.cinflg.device_state = int.parse(str);
    str = rcvdata[5];
    cinInfo.cinflg.billinfo     = int.parse(str);
    str = rcvdata[6];
    cinInfo.cinflg.billdetail   = int.parse(str);
    str = rcvdata[7];
    cinInfo.cinflg.coininfo     = int.parse(str);
    str = rcvdata[8];
    cinInfo.cinflg.coindetail   = int.parse(str);
    str = rcvdata[39];
    cinInfo.cinflg.opeflg       = int.parse(str);

    return ret;
}

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : changerCinReadGetRet ifAcxCalcModeGet()
  /// * 機能概要      : 
  /// * 引数          : TprTID src 
  /// *               : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// *               : TprMsgDevReq2_t rcvBuf  受信データ
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   : 
  /// *--------------------------------------------------------------------------------
  static int ifAcxCinReadGet(TprTID src, int changerFlg, CinInfo cinInfo, TprMsgDevReq2_t rcvbuf)
  {
    int ret = 0;

    ret = AcxCom.ifAcxRcvHeadChk(src, rcvbuf);
    if(ret == IfAcxDef.MSG_ACROK ) {        /*  OK !  next    */
        ret = AcxCom.ifAcxRcvDLEChk(src, rcvbuf.data);
    }
    if(ret != IfAcxDef.MSG_ACROK ) {
        return ret;  /* NG return   !  */
    }
                                /*  OK !  next    */
    if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
                ret = ifAcb20CinReadGet(src, cinInfo, rcvbuf.data);
                break;
            case CoinChanger.ECS_777:
                ret = IfAcxDef.MSG_ACROK; //Lib共通化時に追加
                break;
            default:
                ret = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
                ret = ifAcrCinReadGet(src, cinInfo, rcvbuf.data);
                break;
            case CoinChanger.ECS_777:
                ret = IfAcxDef.MSG_ACROK; //Lib共通化時に追加
                break;
            default:
                ret = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else                                 /* Changer_flg NG ! */
    {
       ret = IfAcxDef.MSG_ACRFLGERR;
    }
    return ret;
  }
}
