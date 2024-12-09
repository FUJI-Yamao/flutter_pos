/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import '../apllib/cnct.dart';
import 'acx_com.dart';
import 'acx_sset.dart';
import 'ecs_opes.dart';

/// 関連tprxソース:acx_ssw.c
class AcxSsw {
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsSswSet()
  /// * 機能概要      : SSW Set
   /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsSswSet(TprTID src, int sswNo) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> setData = List.generate(6, (_) => "\x00");
    int mode;
    List<String> setDataEx = List.generate(13, (_) => ""); /* 拡張仕様でのデータ */
    List<String> modeEx = List.generate(2, (_) => ""); /* 拡張仕様でのモード */
    bool success = true;

    setData.fillRange(0, setData.length, "\x00");
    setData.fillRange(0, setData.length - 1, "\x30");

    if (sswNo == 0xf2) {
      sswNo = sswNo & 0x0F; //変換していたNo.を元に戻す
      (success, setData) = await sSWEcsGet(sswNo, setData);
      if (success == false) {
        return IfAcxDef.MSG_ACRDATAERR;
      }
      setData[0] = "\x30"; // 強制的に出金口
      setData[1] = "\x30"; // 強制的に出金口
    }
    else {
      (success, setData) = await sSWEcsGet(sswNo, setData);
      if (success == false) {
        return IfAcxDef.MSG_ACRDATAERR;
      }
    }

    mode = sswNo | 0x30;
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0) {
      /* ECS-777の場合は拡張仕様 */
      modeEx[0] = "\x30";
      modeEx[1] = latin1.decode([mode]);

      setDataEx.fillRange(0, setDataEx.length, "\x00");
      setDataEx.fillRange(0, setDataEx.length - 1, "\x30");
      setDataEx.setRange(0, setData.length -1, setData);

      errCode =
      await EcsOpes.ifEcsOpeSetExpansion(src, modeEx, setDataEx);
    }
    else {
      errCode = await EcsOpes.ifEcsOpeSet(src, mode.toString(), setData);
    }

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int sSWEcsGet()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<(bool, List<String>)> sSWEcsGet(int sswNo, List<String> sData) async {
    int i;
    List<int> data = List.generate(sData.length, (_) => 0);

    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();

    for (i = 0; i < data.length; i++) {
      data[i] = sData[i].codeUnitAt(0);
    }
    switch (sswNo) {
      case 0x02 :
      // 回収時紙幣搬送先設定 １０００円
        switch (macInfo.acx_flg.ecs_pick_positn1000) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x01;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 回収時紙幣搬送先設定 ２０００円
       switch (macInfo.acx_flg.ecs_pick_positn2000) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x04;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 回収時紙幣搬送先設定 ５０００円
        switch (macInfo.acx_flg.ecs_pick_positn5000) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x01;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // 回収時紙幣搬送先設定 １００００円
        switch (macInfo.acx_flg.ecs_pick_positn10000) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x04;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // ｺﾏﾝﾄﾞ回収後の動作設定 ※ﾓｰﾄﾞ5でのみ
        switch (macInfo.acx_flg.ecs_gp2_3_2) {
          case 0:
            data[2] |= 0x00;
            break;
          case 1:
            data[2] |= 0x04;
            break;
          case 2:
            data[2] |= 0x08;
            break;
          default:
            data[2] |= 0x00;
            break;
        }

        // 紙幣ﾊﾟﾈﾙ回収時の強制出金口搬送可否設定
        switch (macInfo.acx_flg.ecs_gp2_4_1) {
          case 0:
            data[3] |= 0x00;
            break;
          case 1:
            data[3] |= 0x01;
            break;
          default:
            data[3] |= 0x00;
            break;
        }

        // 鍵位置変更時のﾌﾞｻﾞｰ鳴動条件設定
        switch (macInfo.acx_flg.ecs_gp2_4_2) {
          case 0:
            data[3] |= 0x00;
            break;
          case 1:
            data[3] |= 0x02;
            break;
          case 2:
            data[3] |= 0x04;
            break;
          case 3:
            data[3] |= 0x06;
            break;
          case 4:
            data[3] |= 0x08;
            break;
          case 5:
            data[3] |= 0x0A;
            break;
          case 6:
            data[3] |= 0x0C;
            break;
          case 7:
            data[3] |= 0x0E;
            break;
          default:
            data[3] |= 0x00;
            break;
        }

        // ﾆｱｴﾝﾌﾟﾃｨﾌﾞｻﾞｰの鳴動条件設定
        switch (macInfo.acx_flg.ecs_gp2_5_1) {
          case 0:
            data[4] |= 0x00;
            break;
          case 1:
            data[4] |= 0x01;
            break;
          case 2:
            data[4] |= 0x02;
            break;
          case 4:
            data[4] |= 0x04;
            break;
          case 5:
            data[4] |= 0x05;
            break;
          case 6:
            data[4] |= 0x06;
            break;
          case 8:
            data[4] |= 0x08;
            break;
          case 9:
            data[4] |= 0x09;
            break;
          case 10:
            data[4] |= 0x0A;
            break;
          default:
            data[4] |= 0x00;
            break;
        }
        break;

      case 0x07 :
      // 紙幣回収時 再鑑別有無設定
        switch (macInfo.acx_flg.ecs_gp7_1_1) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x01;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 回収時の代替可否設定
        switch (macInfo.acx_flg.ecs_gp7_1_2) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x02;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 残置回収の途中停止可否設定
        switch (macInfo.acx_flg.ecs_gp7_1_3) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x04;
            break;
          case 2:
            data[0] |= 0x08;
            break;
          case 3:
            data[0] |= 0x0C;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 紙幣精査時 再鑑別有無設定
        switch (macInfo.acx_flg.ecs_gp7_2_1) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x01;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // 紙幣精査時 再鑑別有無設定
        switch (macInfo.acx_flg.ecs_gp7_2_2) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x02;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // ｺﾏﾝﾄﾞ精査時のﾘｼﾞｪｸﾄ紙幣押出設定
        switch (macInfo.acx_flg.ecs_recalc_reject) {
          case 0:
            data[1] |= 0x00;
            break;
          case 3:
            data[1] |= 0x0C;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // 紙幣出金口一時停止枚数設定 十の位 [枚]
        data[2] |= macInfo.acx_flg.ecs_gp7_3_1;

        // 紙幣出金口一時停止枚数設定 一の位 [枚]
        data[3] |= macInfo.acx_flg.ecs_gp7_4_1;

        // 紙幣出金口媒体検知ｾﾝｻ設定
        switch (macInfo.acx_flg.ecs_gp7_5_1) {
          case 0:
            data[4] |= 0x00;
            break;
          case 1:
            data[4] |= 0x01;
            break;
          case 2:
            data[4] |= 0x02;
            break;
          case 3:
            data[4] |= 0x03;
            break;
          default:
            data[4] |= 0x00;
            break;
        }

        // 紙幣回収庫媒体取り忘れ時設定
        switch (macInfo.acx_flg.ecs_gp7_5_2) {
          case 0:
            data[4] |= 0x00;
            break;
          case 1:
            data[4] |= 0x04;
            break;
          case 2:
            data[4] |= 0x08;
            break;
          case 3:
            data[4] |= 0x0C;
            break;
          default:
            data[4] |= 0x00;
            break;
        }
        break;

      case 0x0b :
      // 精査途中停止の実行可否設定
        switch (macInfo.acx_flg.ecs_gpb_1_1) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x01;
            break;
          case 2:
            data[0] |= 0x02;
            break;
          case 3:
            data[0] |= 0x03;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 精査終了時のﾘｼﾞｪｸﾄ貨幣取扱設定
        switch (macInfo.acx_flg.ecs_recalc_reject) {
          case 0:
            data[0] |= 0x00;
            break;
          case 1:
            data[0] |= 0x04;
            break;
          case 2:
            data[0] |= 0x08;
            break;
          case 3:
            data[0] |= 0x0C;
            break;
          default:
            data[0] |= 0x00;
            break;
        }

        // 省電力ﾓｰﾄﾞの移行可否設定
        switch (macInfo.acx_flg.ecs_gpb_2_1) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x01;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // 収納状況表示切替設定(在高1～9の時)
        switch (macInfo.acx_flg.ecs_gpb_2_2) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x02;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // 回収の途中停止設定
        switch (macInfo.acx_flg.ecs_gpb_2_3) {
          case 0:
            data[1] |= 0x00;
            break;
          case 1:
            data[1] |= 0x04;
            break;
          case 2:
            data[1] |= 0x08;
            break;
          case 3:
            data[1] |= 0x0C;
            break;
          default:
            data[1] |= 0x00;
            break;
        }

        // 動作完了時のﾌﾞｻﾞｰ鳴動設定
        switch (macInfo.acx_flg.ecs_gpb_3_1) {
          case 0:
            data[2] |= 0x00;
            break;
          case 1:
            data[2] |= 0x01;
            break;
          case 2:
            data[2] |= 0x02;
            break;
          case 3:
            data[2] |= 0x03;
            break;
          default:
            data[2] |= 0x00;
            break;
        }

        // ｴﾗｰ時の復旧処理自動移行設定
        switch (macInfo.acx_flg.ecs_gpb_3_2) {
          case 0:
            data[2] |= 0x00;
            break;
          case 1:
            data[2] |= 0x04;
            break;
          case 2:
            data[2] |= 0x08;
            break;
          case 3:
            data[2] |= 0x0C;
            break;
          default:
            data[2] |= 0x00;
            break;
        }

        // 硬貨・紙幣ﾕﾆｯﾄ有効/無効設定
        switch (macInfo.internal_flg.acr_cnct) {
          case 0:
            data[3] |= 0x03;
            break;
          case 1:
            data[3] |= 0x02;
            break;
          case 2:
            data[3] |= 0x00;
            break;
          default:
            data[3] |= 0x00;
            break;
        }

        // 入金ﾘｼﾞｪｸﾄ時の7ｾｸﾞ点滅設定
        switch (macInfo.acx_flg.ecs_gpb_4_2) {
          case 0:
            data[3] |= 0x00;
            break;
          case 1:
            data[3] |= 0x01;
            break;
          default:
            data[3] |= 0x00;
            break;
        }

        // ﾌｧﾝ回転停止検知設定
        switch (macInfo.acx_flg.ecs_gpb_4_3) {
          case 0:
            data[3] |= 0x00;
            break;
          case 1:
            data[3] |= 0x08;
            break;
          default:
            data[3] |= 0x00;
            break;
        }

        // 回収指示内容と回収枚数表示設定
        switch (macInfo.acx_flg.ecs_gpb_5_1) {
          case 0:
            data[4] |= 0x00;
            break;
          case 1:
            data[4] |= 0x01;
            break;
          case 2:
            data[4] |= 0x02;
            break;
          case 3:
            data[4] |= 0x03;
            break;
          default:
            data[4] |= 0x00;
            break;
        }

        // ｺﾏﾝﾄﾞ回収後の動作設定
        switch (macInfo.acx_flg.ecs_gpb_5_2) {
          case 0:
            data[4] |= 0x00;
            break;
          case 1:
            data[4] |= 0x04;
            break;
          case 2:
            data[4] |= 0x08;
            break;
          case 3:
            data[4] |= 0x0C;
            break;
          default:
            data[4] |= 0x00;
            break;
        }
        break;

      case 0x0d :
        switch (macInfo.acx_flg.ecs_gpd_1_1) {
          case 1:
            data[0] |= 0x01;
            break;
          case 2:
            data[0] |= 0x02;
            break;
          case 3:
            data[0] |= 0x03;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_1_2) {
          case 1:
            data[0] |= 0x04;
            break;
          case 2:
            data[0] |= 0x08;
            break;
          case 3:
            data[0] |= 0x12;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_2_1) {
          case 1:
            data[1] |= 0x01;
            break;
          case 2:
            data[1] |= 0x02;
            break;
          case 3:
            data[1] |= 0x03;
            break;
          case 4:
            data[1] |= 0x04;
            break;
          case 5:
            data[1] |= 0x05;
            break;
          case 6:
            data[1] |= 0x06;
            break;
          case 7:
            data[1] |= 0x07;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_2_2) {
          case 1:
            data[1] |= 0x08;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_3_1) {
          case 1:
            data[2] |= 0x01;
            break;
          case 2:
            data[2] |= 0x02;
            break;
          case 3:
            data[2] |= 0x03;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_3_2) {
          case 1:
            data[2] |= 0x04;
            break;
          case 2:
            data[2] |= 0x08;
            break;
          case 3:
            data[2] |= 0x12;
            break;
        }

        data[3] |= macInfo.acx_flg.ecs_gpd_4_1;

        switch (macInfo.acx_flg.ecs_gpd_5_1) {
          case 1:
            data[4] |= 0x01;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_5_2) {
          case 1:
            data[4] |= 0x02;
            break;
          case 2:
            data[4] |= 0x04;
            break;
          case 3:
            data[4] |= 0x06;
            break;
        }

        switch (macInfo.acx_flg.ecs_gpd_5_3) {
          case 1:
            data[4] |= 0x08;
            break;
        }
        break;
    }
    for (i = 0; i < data.length; i++) {
      sData[i] = latin1.decode([data[i]]);
    }

    return (true, sData);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifSst1SswSet()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// *              : Tint sswNo
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifSst1SswSet(TprTID src, int sswNo) async {
    int errCode;
    List<int> setData = [];

    switch (sswNo) {
      case 63:
        if ((await sSWSst1Get63(setData)) == false) {
          return IfAcxDef.MSG_ACRDATAERR;
        }
        break;
      case 54:
      case 116:
      case 117:
      case 118:
      case 119:
      case 120:
      case 121:
      case 122:
      case 123:
        if ((sSWSst1Get(sswNo, setData)) == false) {
          return IfAcxDef.MSG_ACRDATAERR;
        }
        break;
    }
    errCode = await ifSst1SswCmdSend(src, sswNo, setData);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int sSWSst1Get()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// *              : Tint sswNo
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static bool sSWSst1Get(int sswNo, List<int> setData) {
    RxCommonBuf pComBuf = RxCommonBuf();
    int getData = 0;

    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      return false;
    }
    pComBuf = cRet.object;

    switch (sswNo) {
      case 54:
        if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_ACB_DECCIN) == 0) {
          getData = 0;
        } else {
          getData = 2;
        }
        break;
      case 116:
        getData = pComBuf.dbTrm.acxS1000;
    break;
    case 117:
    getData = pComBuf.dbTrm.acxS5000;
    break;
    case 118:
    getData = pComBuf.dbTrm.acxS500;
    break;
    case 119:
    getData = pComBuf.dbTrm.acxS100;
    break;
    case 120:
    getData = pComBuf.dbTrm.acxS50;
    break;
    case 121:
    getData = pComBuf.dbTrm.acxS10;
    break;
    case 122:
    getData = pComBuf.dbTrm.acxS5;
    break;
    case 123:
    getData = pComBuf.dbTrm.acxS1;
    break;
    }

    if ((getData < 0) || (getData > 255)) {
      setData[0] = -1;
      return false;
    }
    setData[0] = getData;

    return true;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int sSWSst1Get63()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// *              : Tint sswNo
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<bool> sSWSst1Get63(List<int> setData) async {
    int sBuf;
    int getData;

    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();

    sBuf = macInfo.acx_flg.sst1_cin_retry;
    if (sBuf == 0) {
      getData = 0xFF;
    } else if ((sBuf > 0) && (sBuf <= 6)) {
      getData = sBuf;
    } else {
      getData = 0x06;
    }

    setData.add(getData);

    return true;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifSst1SswCmdSend()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// *              : Tint sswNo
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifSst1SswCmdSend(TprTID src, int sswNo,
      List<int> setData) async {
    int errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(10, (_) => "");
    int len = 0;

    if ((AcxCom.ifAcbSelect() & CoinChanger.SST1) == 0) {
      return IfAcxDef.MSG_ACRFLGERR;
    }
    sendBuf.fillRange(0, sendBuf.length, "\x30");
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_SSWSET;
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x36";
    sendBuf[len++] = latin1.decode([(0x30 + (sswNo / 1000)).toInt()]);
    sendBuf[len++] = latin1.decode([(0x30 + ((sswNo % 1000) / 100)).toInt()]);
    sendBuf[len++] = latin1.decode([(0x30 + (((sswNo % 1000) % 100) / 10)).toInt()]);
    sendBuf[len++] = latin1.decode([(0x30 + (((sswNo % 1000) % 100) % 10))]);

    sendBuf[len++] = latin1.decode([(0x30 + (setData[0] >> 4))]);
    sendBuf[len++] = latin1.decode([0x30 + (setData[0] & 0x0F)]);

    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int acrAcbSSWSet()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// *              : Tint sswNo
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<bool> acrAcbSSWSet(
      int sswNo, List<int> setData, List<int> kind) async {
    int setDataBuf;
    int sBuf;

    setDataBuf = 0x00;
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();

    switch (sswNo) {
      case 13:
        kind[0] = 1; //紙幣側
        sBuf = macInfo.acx_flg.sst1_cin_retry;
        setDataBuf |= (sBuf == 1) ? 0x01 : 0x00;

        switch (macInfo.acx_flg.acb50_ssw13_1_2) {
          case 1: setDataBuf |= 0x02; break;
          case 2: setDataBuf |= 0x04; break;
        }

        switch (macInfo.acx_flg.acb50_ssw13_3_4) {
          case 1: setDataBuf |= 0x08; break;
          case 2: setDataBuf |= 0x10; break;
        }

        sBuf = macInfo.acx_flg.acb50_ssw13_5;
        setDataBuf |= (sBuf == 1) ? 0x20 : 0x00;

        sBuf = macInfo.acx_flg.acb50_ssw13_6;
        setDataBuf |= (sBuf == 1) ? 0x40 : 0x00;
        setData.add(setDataBuf);
        break;
      case 24:
        kind[0] = 1; //紙幣側
        sBuf = macInfo.acx_flg.acb50_ssw24_0;
        setDataBuf |= (sBuf == 1) ? 0x01 : 0x00;
        setData.add(setDataBuf);
        break;
      case 50:
        kind[0] = 0; //硬貨側
        switch (macInfo.acx_flg.acb50_ssw50_0_1) {
          case 1: setDataBuf |= 0x01; break;
          case 2: setDataBuf |= 0x02; break;
        }

        sBuf = macInfo.acx_flg.acb50_ssw50_2;
        setDataBuf |= (sBuf == 1) ? 0x04 : 0x00;

        sBuf = macInfo.acx_flg.acb50_ssw50_3;
        setDataBuf |= (sBuf == 1) ? 0x08 : 0x00;

        switch (macInfo.acx_flg.acb50_ssw50_4_5) {
          case 1: setDataBuf |= 0x10; break;
          case 2: setDataBuf |= 0x20; break;
        }

        switch (macInfo.acx_flg.acb50_ssw50_6_7) {
          case 1: setDataBuf |= 0x40; break;
          case 2: setDataBuf |= 0x80; break;
        }
        setData.add(setDataBuf);
        break;
      default:
        return false;
    }

    return true;
  }
  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxSswSet()
  /// * 機能概要      : SSW Set
  /// * 引数          : TprTID src
  /// *              : Tint sswNo
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxSswSet(TprTID src, int sswNo) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;
      List<int> kind = List.generate(1, (_) => 0);
      List<int> setData = List.generate(1, (_) => 0);

      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
        case CoinChanger.ACB_20:
          errCode = IfAcxDef.MSG_ACROK;
          break;
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          if ((await acrAcbSSWSet(sswNo, setData, kind)) == false) {
            return IfAcxDef.MSG_ACRDATAERR;
          }
          errCode = await AcxSset.ifAcb20SswCmdSend(src, kind[0], sswNo, setData);
          break;
        case CoinChanger.ECS:
        case CoinChanger.ECS_777:
          errCode = await ifEcsSswSet(src, sswNo);
          break;
        case CoinChanger.SST1:
          errCode = await ifSst1SswSet(src, sswNo);
          break;
        case CoinChanger.FAL2:
          errCode = await AcxCom.ifAcxCmdSkip(src, ifAcxSswSet); //処理なし
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
