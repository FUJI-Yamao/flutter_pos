/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../cm_sys/cm_cksys.dart';

/// 関連tprxソース: if_scan.h - scan_scpu
enum ScanScpu {
  SCAN_SCPU1,
  SCAN_SCPU2,
  SCAN_SCPU3,
  SCAN_SCPU4
}

/// 関連tprxソース: if_scan.c
class IfScan {
  /// 対面セルフ仕様スキャナを有効にする
  ///  関連tprxソース: if_scan.c - if_scan_happy_2nd_scanner_enable
  static Future<void> happy2ndScannerEnable() async {
    if (await CmCksys.cmHappySelfSystem() == 0) {
      return;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "happy2ndScannerEnable(): scan_happyself_2nd get error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.iniMacInfo.scanner.scan_happyself_2nd == 0) {
      await hwEnableMacType(CmSys.TPR_TYPE_TOWER);
    } else if (pCom.iniMacInfo.scanner.scan_happyself_2nd == 2) {
      await pscEnableMacType(CmSys.TPR_TYPE_TOWER);
    }
  }

  /// 引数:[macType] 0=卓上側  1=タワー側
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_hw_enable_mactype
  static Future<int> hwEnableMacType(int macType) async {
    int	res = 0;
    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      if (macType == 0) {
        // 卓上側
        if (await CmCksys.cmWebPrimetowerSystem() != 0) {
          // Prime
          res = hwEnableUnit(ScanScpu.SCAN_SCPU3);
        } else {
          res = hwEnableUnit(ScanScpu.SCAN_SCPU1);
        }
      } else if (macType == 1) {
        // タワー側
        res = hwEnableUnit(ScanScpu.SCAN_SCPU2);
      } else {
        // 追加
        res = hwEnableUnit(ScanScpu.SCAN_SCPU4);
      }
    }

    return res;
  }

  /// 引数:[scpuKind] ScanScpuクラス
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_hw_enable_unit
  static int hwEnableUnit(ScanScpu scpuKind) {
    // TODO:10002 共有メモリ書込み
    /*
    int res = -1;
    int data = 0x00;
    int tid = getTid(scpu_kind);

    if (tid != -1) {
      res = if_scan_intr(SCAN_CMD_HW_ENABLE, &data, 1, tid);
    }

    return res
     */
    return 0;
  }

  /// 引数:[macType] 0=卓上側  1=タワー側
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_hw_disable_mactype
  static Future<int> hwDisableMacType(int macType) async {
    int	res = 0;
    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      if (macType == 0) {
        // 卓上側
        if (await CmCksys.cmWebPrimetowerSystem() != 0) {
          // Prime
          res = hwDisableUnit(ScanScpu.SCAN_SCPU3);
        } else {
          res = hwDisableUnit(ScanScpu.SCAN_SCPU1);
        }
      } else if (macType == 1) {
        // タワー側
        res = hwDisableUnit(ScanScpu.SCAN_SCPU2);
      } else {
        // 追加
        res = hwDisableUnit(ScanScpu.SCAN_SCPU4);
      }
    }

    return res;
  }

  /// 引数:[scpuKind] ScanScpuクラス
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_hw_disable_unit
  static int hwDisableUnit(ScanScpu scpuKind) {
    // TODO:10002 共有メモリ書込み
    /*
    int res = -1;
    int data = 0x00;
    int tid = getTid(scpu_kind);

	  if (tid != -1) {
		  res = if_scan_intr(SCAN_CMD_HW_DISABLE, &data, 1, tid);
    }

    return res
     */
    return 0;
  }

  /// 引数:[macType] 0=卓上側  1=タワー側
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_psc_enable_mactype
  static Future<int> pscEnableMacType(int macType) async {
    int res = 0;
    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      if (macType == 0) {
        // 卓上側
        if (await CmCksys.cmWebPrimetowerSystem() != 0) {
          // Prime
          res = pscEnableUnit(ScanScpu.SCAN_SCPU3);
        }
        else
        {
          res = pscEnableUnit(ScanScpu.SCAN_SCPU1);
        }
      } else if (macType == 1) {
        // タワー側
        res = pscEnableUnit(ScanScpu.SCAN_SCPU2);
      } else {
        // 追加
        res = pscEnableUnit(ScanScpu.SCAN_SCPU4);
      }
    }

    return res;
  }

  /// 引数:[macType] 0=卓上側  1=タワー側
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_psc_disable_mactype
  static Future<int> pscDisableMacType(int macType) async {
    int res = 0;
    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      if (macType == 0) {
        // 卓上側
        if (await CmCksys.cmWebPrimetowerSystem() != 0) {
          // Prime
          res = pscDisableUnit(ScanScpu.SCAN_SCPU3);
        }
        else
        {
          res = pscDisableUnit(ScanScpu.SCAN_SCPU1);
        }
      } else if (macType == 1) {
        // タワー側
        res = pscDisableUnit(ScanScpu.SCAN_SCPU2);
      } else {
        // 追加
        res = pscDisableUnit(ScanScpu.SCAN_SCPU4);
      }
    }

    return res;
  }

  /// 引数:[scpuKind] ScanScpuクラス
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_psc_enable_unit
  static int pscEnableUnit(ScanScpu scpuKind) {
    // TODO:10002 共有メモリ書込み
    /*
    int res = -1;
    int data = 0x45;
    int tid = getTid(scpu_kind);

    if (tid != -1) {
      res = if_scan_intr(SCAN_CMD_PSC, &data, 1, tid);
    }

    return res
     */
    return 0;
  }

  /// 引数:[scpuKind] ScanScpuクラス
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_psc_disable_unit
  static int pscDisableUnit(ScanScpu scpuKind) {
    // TODO:10002 共有メモリ書込み
    /*
    int res = -1;
    int data = 0x44;
    int tid = getTid(scpu_kind);

    if (tid != -1) {
      res = if_scan_intr(SCAN_CMD_PSC, &data, 1, tid);
    }

    return res
     */
    return 0;
  }

  /// 引数:[scpuKind] ScanScpuクラス
  /// 戻り値: 0=正常終了  -1=異常終了
  ///  関連tprxソース: if_scan.c - if_scan_get_tid
  static int getTid(ScanScpu scpuKind) {
    switch (scpuKind) {
      case ScanScpu.SCAN_SCPU1:
        return TprDidDef.TPRDIDSCANNER1;
      case ScanScpu.SCAN_SCPU2:
        return TprDidDef.TPRDIDSCANNER2;
      case ScanScpu.SCAN_SCPU3:
        return TprDidDef.TPRDIDSCANNER1;
      case ScanScpu.SCAN_SCPU4:
        return TprDidDef.TPRDIDSCANNER3;
    }
  }
}