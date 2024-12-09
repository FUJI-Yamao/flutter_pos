/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'rm_db_read.dart';
import 'rm_ini_read.dart';

/// プリセットデータ構造体(抜粋)
/// 関連tprxソース: rmcommon.h
class RmComPre {
  int kyCd = 0;
  String kyPluCd = '';
  int kySmlclsCd = 0;
}

/// 関連tprxソース: rmcommon.c
class RmCommon {
  late List<RmComPre> rmPreLcd57Tbl =
      List.generate(RxMem.PRESET_LCD57_MAX, (_) => RmComPre()); //  5.7インチLCD
  late List<RmComPre> rmPreMkey1Tbl =
      List.generate(RxMem.PRESET_MKEY1_MAX, (_) => RmComPre()); //  メカキー１(本体キー)
  late List<RmComPre> rmPreMkey2Tbl =
      List.generate(RxMem.PRESET_MKEY2_MAX, (_) => RmComPre()); //  メカキー２(タワーキー)
  late List<RmComPre> rmPreMkey3Tbl = List.generate(
      RxMem.PRESET_MKEY2_MAX, (_) => RmComPre()); //  メカキー３(Prime本体キー)
  late List<RmComPre> rmPreMkey28iTbl = List.generate(
      RxMem.PRESET_MKEY28i_MAX, (_) => RmComPre()); //  メカキー(Web2800i本体キー)
  late List<RmComPre> rmPreMkey28iMTbl = List.generate(
      RxMem.PRESET_MKEY28iM_MAX, (_) => RmComPre()); //  メカキー(Web2800iM本体キー)
  late List<RmComPre> rmPreMkey28TTbl = List.generate(
      RxMem.PRESET_MKEY28i_MAX, (_) => RmComPre()); //  メカキー6(Web2800タワーキー)
  late List<RmComPre> rmPreMkey52DTbl = List.generate(
      RxMem.PRESET_MKEY52_MAX, (_) => RmComPre()); //  メカキー7(Web2800 本体側52キー)
  late List<RmComPre> rmPreMkey52TTbl = List.generate(
      RxMem.PRESET_MKEY52_MAX, (_) => RmComPre()); //  メカキー8(Web2800 タワー側52キー)
  late List<RmComPre> rmPreMkey35DTbl = List.generate(
      RxMem.PRESET_MKEY35_MAX, (_) => RmComPre()); //  メカキー(Web3800 本体35キー)
  // シングルトンインスタンス.
  static final RmCommon _instance = RmCommon._internal();
  factory RmCommon() {
    return _instance;
  }
  RmCommon._internal();

  List<RmComPre>? getPreListKeyTypeD(int keyType) {
    switch (keyType) {
      case RxMemKey.KEYTYPE_84:
        return rmPreMkey28iMTbl;
      case RxMemKey.KEYTYPE_68:
        return rmPreMkey28iTbl;
      case RxMemKey.KEYTYPE_56:
      case RxMemKey.KEYTYPE_56_23:
        return rmPreMkey1Tbl;
      case RxMemKey.KEYTYPE_30:
      case RxMemKey.KEYTYPE_30_23:
        return rmPreMkey3Tbl;
      case RxMemKey.KEYTYPE_52:
        return rmPreMkey52DTbl;
      case RxMemKey.KEYTYPE_35:
        return rmPreMkey35DTbl;
      default:
        return null;
    }
  }

  List<RmComPre>? getPreListKeyTypeT(int keyType) {
    switch (keyType) {
      case RxMemKey.KEYTYPE_84:
        return rmPreMkey28iMTbl;
      case RxMemKey.KEYTYPE_68:
        return rmPreMkey28TTbl;
      case RxMemKey.KEYTYPE_56:
      case RxMemKey.KEYTYPE_56_23:
        return rmPreMkey1Tbl;
      case RxMemKey.KEYTYPE_30:
      case RxMemKey.KEYTYPE_30_23:
        return rmPreMkey2Tbl;
      case RxMemKey.KEYTYPE_52:
        return rmPreMkey52TTbl;
      default:
        return null;
    }
  }

// メカキー１(本体キー)
  static const List<int> MKey1Tbl = [
    0x1001, 0x1004, 0x1010, 0x1040,
    0x1101, 0x1104, 0x1110, 0x1140,
    0x1201, 0x1204, 0x1210, 0x1240,
    0x1301, 0x1304, 0x1310, 0x1340,
    0x1401, 0x1404, 0x1410, 0x1440,
    0x1501, 0x1504, 0x1510, 0x1540,
    0x1601, 0x1604, 0x1610, 0x1640,
    0x1002, 0x1008, 0x1020, 0x1080,
    0x1102, 0x1108, 0x1120, 0x1180,
    0x1202, 0x1208, 0x1220, 0x1280,
    0x1302, 0x1308, 0x1320, 0x1380,
    0x1402, 0x1408, 0x1420, 0x1480,
    0x1502, 0x1508, 0x1520, 0x1580,
    0x1602, 0x1608, 0x1620, 0x1680,
    -1 // Stopper
  ];
//  メカキー２(タワーキー)
  static const List<int> MKey2Tbl = [
    0x1080, 0x1040, 0x1020, 0x1001, 0x1002, 0x1004,
    0x1180, 0x1140, 0x1120, 0x1101, 0x1102, 0x1104,
    0x1280, 0x1240, 0x1220, 0x1201, 0x1202, 0x1204,
    0x1380, 0x1340, 0x1320, 0x1301, 0x1302, 0x1304,
    0x1110, 0x1210, 0x1310, 0x1308, 0x1208, 0x1108,
    -1 //  Stopper
  ];

//  メカキー３(Prime本体キー)
  static const List<int> MKey3Tbl = [
    0x1080, 0x1040, 0x1020, 0x1001, 0x1002, 0x1004,
    0x1180, 0x1140, 0x1120, 0x1101, 0x1102, 0x1104,
    0x1280, 0x1240, 0x1220, 0x1201, 0x1202, 0x1204,
    0x1380, 0x1340, 0x1320, 0x1301, 0x1302, 0x1304,
    0x1110, 0x1210, 0x1310, 0x1308, 0x1208, 0x1108,
    -1 //  Stopper
  ];

//  メカキー4(Web2800i 本体キー)
  static const List<int> MKey28iTbl = [
    //  Left Top   		   Left Bottom
    0x0101, 0x0102, 0x0103, 0x0104,
    0x0201, 0x0202, 0x0203, 0x0204,
    0x0301, 0x0302, 0x0303, 0x0304,
    0x0401, 0x0402, 0x0403, 0x0404,
    0x0501, 0x0502, 0x0503, 0x0504,
    0x0601, 0x0602, 0x0603, 0x0604,
    0x0701, 0x0702, 0x0703, 0x0704,
    0x0801, 0x0802, 0x0803, 0x0804,
    0x0901, 0x0902, 0x0903, 0x0904,
    0x1001, 0x1002, 0x1003, 0x1004,
    0x1101, 0x1102, 0x1103, 0x1104,
    0x1201, 0x1202, 0x1203, 0x1204,
    0x1301, 0x1302, 0x1303, 0x1304,
    0x1401, 0x1402, 0x1403, 0x1404,
    0x1501, 0x1502, 0x1503, 0x1504,
    0x1601, 0x1602, 0x1603, 0x1604,
    0x1701, 0x1702, 0x1703, 0x1704,
    //  Right Top   		   Right Bottom
    -1 //  Stopper
  ];

//  メカキー4(Web2800iM 本体キー)
  static const List<int> MKey28iMTbl = [
    //  Left Top   				   Left Bottom
    0x0101, 0x0102, 0x0103, 0x0104, 0x0105, 0x0106, 0x0107,
    0x0201, 0x0202, 0x0203, 0x0204, 0x0205, 0x0206, 0x0207,
    0x0301, 0x0302, 0x0303, 0x0304, 0x0305, 0x0306, 0x0307,
    0x0401, 0x0402, 0x0403, 0x0404, 0x0405, 0x0406, 0x0407,
    0x0501, 0x0502, 0x0503, 0x0504, 0x0505, 0x0506, 0x0507,
    0x0601, 0x0602, 0x0603, 0x0604, 0x0605, 0x0606, 0x0607,
    0x0701, 0x0702, 0x0703, 0x0704, 0x0705, 0x0706, 0x0707,
    0x0801, 0x0802, 0x0803, 0x0804, 0x0805, 0x0806, 0x0807,
    0x0901, 0x0902, 0x0903, 0x0904, 0x0905, 0x0906, 0x0907,
    0x1001, 0x1002, 0x1003, 0x1004, 0x1005, 0x1006, 0x1007,
    0x1101, 0x1102, 0x1103, 0x1104, 0x1105, 0x1106, 0x1107,
    0x1201, 0x1202, 0x1203, 0x1204, 0x1205, 0x1206, 0x1207,
    //  Right Top   				   Right Bottom
    -1 //  Stopper
  ];

//  メカキー5(Web2800 52キー)
  static const List<int> MKey52Tbl = [
    //  Left Top   										   Left Bottom
    0x0101, 0x0102, 0x0103, 0x0104, 0x0105, 0x0106, 0x0107, 0x0108, 0x0109,
    0x0110, 0x0111, 0x0112, 0x0113,
    0x0201, 0x0202, 0x0203, 0x0204, 0x0205, 0x0206, 0x0207, 0x0208, 0x0209,
    0x0210, 0x0211, 0x0212, 0x0213,
    0x0301, 0x0302, 0x0303, 0x0304, 0x0305, 0x0306, 0x0307, 0x0308, 0x0309,
    0x0310, 0x0311, 0x0312, 0x0313,
    0x0401, 0x0402, 0x0403, 0x0404, 0x0405, 0x0406, 0x0407, 0x0408, 0x0409,
    0x0410, 0x0411, 0x0412, 0x0413,
    //  Right Top   										   Right Bottom
    -1 //  Stopper
  ];

//  メカキー6(Web3800a 35キー)
  static const List<int> MKey35Tbl = [
    //  Left Top   				   Left Bottom
    0x0101, 0x0102, 0x0103, 0x0104, 0x0105, 0x0106, 0x0107,
    0x0201, 0x0202, 0x0203, 0x0204, 0x0205, 0x0206, 0x0207,
    0x0301, 0x0302, 0x0303, 0x0304, 0x0305, 0x0306, 0x0307,
    0x0401, 0x0402, 0x0403, 0x0404, 0x0405, 0x0406, 0x0407,
    0x0501, 0x0502, 0x0503, 0x0504, 0x0505, 0x0506, 0x0507,
    //  Right Top   				   Right Bottom
    -1 //  Stopper
  ];

  /// 関連tprxソース:rmcommon.c
  ///    関数：int rmCharDataToInt(char *data)
  ///    機能：charデータからintに変換([0x01][0x23] -> 0x0123)
  ///    引数：char *data 変換するデータポインタ
  ///    戻値：int 変換したキーコード
  static int rmCharDataToInt(String data) {
    int ret = data.codeUnitAt(0);
    ret = ret << 8;
    ret += data.codeUnitAt(1);

    return ret;
  }

  static List<int>? _getMkeyTable(int tid) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return null;
    }
    RxCommonBuf pCom = xRet.object;
    int mkeyD = pCom.mkeyD;
    int mkeyT = pCom.mkeyT;
    switch (tid) {
      case TprDidDef.TPRDIDMECKEY1:
        switch (mkeyD) {
          case RxMemKey.KEYTYPE_84:
            return MKey28iMTbl;
          case RxMemKey.KEYTYPE_68:
            return MKey28iTbl;
          case RxMemKey.KEYTYPE_56:
            return MKey1Tbl;
          case RxMemKey.KEYTYPE_30:
            return MKey3Tbl;
          case RxMemKey.KEYTYPE_56_23:
            return MKey1Tbl;
          case RxMemKey.KEYTYPE_30_23:
            return MKey3Tbl;
          case RxMemKey.KEYTYPE_52:
            return MKey52Tbl;
          case RxMemKey.KEYTYPE_35:
            return MKey35Tbl;
          default:
            return MKey28iMTbl;
        }
      case TprDidDef.TPRDIDMECKEY2:
        switch (mkeyT) {
          case RxMemKey.KEYTYPE_84:
            return MKey28iMTbl;
          case RxMemKey.KEYTYPE_68:
            return MKey28iTbl;
          case RxMemKey.KEYTYPE_56:
            return MKey1Tbl;
          case RxMemKey.KEYTYPE_30:
            return MKey2Tbl;
          case RxMemKey.KEYTYPE_56_23:
            return MKey1Tbl;
          case RxMemKey.KEYTYPE_30_23:
            return MKey2Tbl;
          case RxMemKey.KEYTYPE_52:
            return MKey52Tbl;
          default:
            return MKey28iTbl;
        }
      default:
        return null;
    }
  }

  int rmMecDataToFncCode(TprMsgDevNotify_t notify) {
    List<int>? table = _getMkeyTable(notify.tid);
    if (table == null) {
      return 0;
    }
    // keytype_set pCom->mkey_t
    int presetPos = _mechaCodeToPresetPos(notify.data[1], table);

    return presetToFncCode(notify.tid, presetPos);
  }

  /// 関連tprxソース:rmcommon.c
  ///    関数：int MchaCodeToPresetPos(char *data, int table[])
  //     機能：メカキー→プリセット位置変換
  //     引数：char *data 受け取りデータのポインタ(実データ)
  //         ：int table[] 変換テーブルの先頭
  //     戻値：int 正:プリセット位置  / 0以下:エラー
  /// MechaCodeToPresetPos
  static int _mechaCodeToPresetPos(String data, List<int> table) {
    int keyCode = rmCharDataToInt(data);
    if (keyCode <= 0) {
      return 0;
    }
    for (int idx = 0; idx < table.length; idx++) {
      if (table[idx] == keyCode) {
        return idx + 1;
      }
    }
    return 0;
  }

  /// 関連tprxソース:rmcommon.c
  ///    関数：int PresetToFuncCode(TPRDID tid, int PresetPos)
  //     機能：プリセット位置→ファンクションコード変換
  //     引数：TPRDID tid    デバイスID
  //         ：int PresetPos プリセット番号
  //     戻値：int 正:ファンクションコード(fnc_code.h)  / 0以下:エラー
  int presetToFncCode(TprDID tid, int presetPos) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int mkeyD = pCom.mkeyD;
    int mkeyT = pCom.mkeyT;
    switch (tid) {
      case TprDidDef.TPRDIDMECKEY1:
        switch(mkeyD) {
          case RxMemKey.KEYTYPE_84:    return rmPreMkey28iMTbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_68:    return rmPreMkey28iTbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_56:    return rmPreMkey1Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_30:    return rmPreMkey3Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_56_23: return rmPreMkey1Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_30_23: return rmPreMkey3Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_52:    return rmPreMkey52DTbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_35:    return rmPreMkey35DTbl[(presetPos - 1)].kyCd;
          default:                     return rmPreMkey28iMTbl[(presetPos - 1)].kyCd;
        }
        break;
      case TprDidDef.TPRDIDMECKEY2:
        switch(mkeyT) {
          case RxMemKey.KEYTYPE_84:    return rmPreMkey28iMTbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_68:    return rmPreMkey28TTbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_56:    return rmPreMkey1Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_30:    return rmPreMkey2Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_56_23: return rmPreMkey1Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_30_23: return rmPreMkey2Tbl[(presetPos - 1)].kyCd;
          case RxMemKey.KEYTYPE_52:    return rmPreMkey52TTbl[(presetPos - 1)].kyCd;
          default:                     return rmPreMkey28TTbl[(presetPos - 1)].kyCd;
        }
        break;
      default:
        break;
    }
    return 0;
  }

  ///  機能：システムタスク起動時の登録初期処理
  ///  関連tprxソース: rmcommon.c - rmMainInit()（設定ファイル）
  static Future<void> rmMainInit() async {
    // TODO: システムタスク起動時の登録初期処理
    SystemFunc.rxMemGetAll();
    // rxQueueGetAll();
    RmIniRead iniRead = RmIniRead();
    await iniRead.rmIniReadMain();
  }

  ///  機能：システムタスク起動時の登録初期処理
  ///  関連tprxソース: rmcommon.c - rmMainInit()（データベース）
  static Future<void> rmMainInit_DB() async {
    // TODO: システムタスク起動時の登録初期処理
    RmDBRead dbRead = RmDBRead();
    await dbRead.rmDbReadMain();
    // rmDbStropnclsRead();
  }

  ///  機能：システムタスク起動時の登録初期処理
  ///  関連tprxソース: rmcommon.c - rmMainExit()
  static void rmMainExit() {
    // TODO: システムタスク起動時の登録初期処理.
    // rxMemDelAll();
    // rxQueueDelAll();
  }
}
