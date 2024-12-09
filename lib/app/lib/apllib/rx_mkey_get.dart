/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/meckey35JsonFile.dart';
import '../../common/cls_conf/meckey52JsonFile.dart';
import '../../common/cls_conf/meckeyJsonFile.dart';
import '../../common/cls_conf/meckey_2800JsonFile.dart';
import '../../common/cls_conf/meckey_2800imJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';

/// MecKey Get Program
/// 関連tprxソース: rxmkeyget.c
class RxMkeyGet {
  /// 関連tprxソース: rxmkeyget.c - sysDefKeyGet
  static Future<int> sysDefKeyGet() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "sysDefKeyGet rxMemRead get Error");
      return 1;
    }
    RxCommonBuf pCom = xRet.object;

    // mkeyD  tower-------------------------
    ConfigJsonFile mkeyDJson = _getJsonFileFromKey(pCom.mkeyD, false);
    await mkeyDJson.load();
    String section = pCom.mkeyD == RxMemKey.KEYTYPE_30 ? "meckey2" : "meckey1";
    int ret = 0;
    for (int i = 0; i < ((MkeyNumTbl.MKEYNUM_MAX - 1) ~/ 2); i++) {
      String? keyword = _getMkeyDKeyword(i);
      if (keyword == null) {
        return ret;
      }
      JsonRet jsonRet = await mkeyDJson.getValueWithName(section, keyword);
      ret |= jsonRet.cause.index;
      _setCmMem(pCom, i, jsonRet, keyword);
    }
    // mkeyT  tower-------------------------
    ConfigJsonFile mkeyTJson = _getJsonFileFromKey(pCom.mkeyD, false);
    await mkeyTJson.load();
    ret = 0;
    section = "meckey2";
    for (int i = ((MkeyNumTbl.MKEYNUM_MAX - 1) ~/ 2);
        i < (MkeyNumTbl.MKEYNUM_MAX - 1);
        i++) {
      String? keyword = _getMkeyTKeyword(i);
      if (keyword == null) {
        return ret;
      }
      JsonRet jsonRet = await mkeyTJson.getValueWithName(section, keyword);
      ret |= jsonRet.cause.index;
      _setCmMem(pCom, i, jsonRet, keyword);
    }
    return ret;
  }

  static void _setCmMem(
      RxCommonBuf pCom, int i, JsonRet jsonRet, String keyword) {
    if (jsonRet.result && (jsonRet.value.toString()).isNotEmpty &&jsonRet.value[0] == '0' && jsonRet.value[1] == 'x') {
      pCom.mkeyNumTbl[i].hiKcd = ((int.tryParse(jsonRet.value[2]) ?? 0)  - 0x30).toUnsigned(4);
      pCom.mkeyNumTbl[i].hiKcd  = pCom.mkeyNumTbl[i].hiKcd << 4;
      pCom.mkeyNumTbl[i].hiKcd |= ((int.tryParse(jsonRet.value[3]) ?? 0) - 0x30).toUnsigned(4);

      pCom.mkeyNumTbl[i].loKcd = ((int.tryParse(jsonRet.value[4]) ?? 0) - 0x30).toUnsigned(4);
      pCom.mkeyNumTbl[i].loKcd = pCom.mkeyNumTbl[i].loKcd << 4;
      pCom.mkeyNumTbl[i].loKcd |= ((int.tryParse(jsonRet.value[5]) ?? 0) - 0x30).toUnsigned(4);
    }
    if (i == 12 || i == 29) {
      pCom.mkeyNumTbl[i].num = "\n";
    } else if (i == 13 || i == 30) {
      pCom.mkeyNumTbl[i].num = "C";
    } else {
      pCom.mkeyNumTbl[i].num = keyword;
    }
  }

  ///　キーから対応するjsonファイルを取得する.
  static ConfigJsonFile _getJsonFileFromKey(int key, bool isTower) {
    switch (key) {
      case RxMemKey.KEYTYPE_84:
        return Meckey_2800imJsonFile();

      case RxMemKey.KEYTYPE_68:
        return Meckey_2800JsonFile();

      case RxMemKey.KEYTYPE_56:
      case RxMemKey.KEYTYPE_56_23:
      case RxMemKey.KEYTYPE_30:
      case RxMemKey.KEYTYPE_30_23:
        return MeckeyJsonFile();

      case RxMemKey.KEYTYPE_52:
        return Meckey52JsonFile();

      case RxMemKey.KEYTYPE_35:
        return Meckey35JsonFile();
      case RxMemKey.KEYTYPE_35:
        if (isTower) {
          return Meckey_2800imJsonFile();
        }
        return Meckey35JsonFile();

      default:
        return Meckey_2800imJsonFile();
    }
  }

  /// mkeyDのキーワードを取得する
  static String? _getMkeyDKeyword(int id) {
    switch (id) {
      case 0:
        return "key0";
      case 1:
        return "key1";
      case 2:
        return "key2";
      case 3:
        return "key3";
      case 4:
        return "key4";
      case 5:
        return "key5";
      case 6:
        return "key6";
      case 7:
        return "key7";
      case 8:
        return "key8";
      case 9:
        return "key9";
      case 10:
        return "key00";
      case 11:
        return "key000";
      case 12:
        return "RET";
      case 13:
        return "CLS";
      case 14:
        return "FEED";
      case 15:
        return "PLU";
      case 16:
        return "STL";
      default:
        return null;
    }
  }

  /// mkeyTのキーワードを取得する
  static String? _getMkeyTKeyword(int id) {
    switch (id) {
      case 17:
        return "key0";
      case 18:
        return "key1";
      case 19:
        return "key2";
      case 20:
        return "key3";
      case 21:
        return "key4";
      case 22:
        return "key5";
      case 23:
        return "key6";
      case 24:
        return "key7";
      case 25:
        return "key8";
      case 26:
        return "key9";
      case 27:
        return "key00";
      case 28:
        return "key000";
      case 29:
        return "RET";
      case 30:
        return "CLS";
      case 31:
        return "FEED";
      case 32:
        return "PLU";
      case 33:
        return "STL";
      default:
        return null;
    }
  }
}
