/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';
import 'package:flutter_pos/app/lib/apllib/sio_chk.dart';

import '../../../app/inc/apl/compflag.dart';
import '../../../app/inc/apl/fnc_code.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/pbchgJsonFile.dart';
import '../../common/cls_conf/repicaJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/cnct.dart';
import '../../lib/apllib/recog.dart';
import '../../regs/checker/rcsyschk.dart';
import '../../sys/syst/sys_bkupd.dart';
import '../apllib/competition_ini.dart';
import '../cm_mbr/cmmbrsys.dart';
import '../if_acx/acx_com.dart';
import './cm_cktwr.dart';

/// 設定ファイルから機種を判定する
///  関連tprxソース:\lib\cm_sys\cm_cksys.c
class CmCksys {
  /// 定数（端末側設定ファイルパス）
  static const PATH_AAEON = "/etc/aaeon_smhd.json";
  static const PATH_G3SYS = "/etc/XX5_smhd.json";
  static const PATH_PRIME3 = "/etc/prime3_smhd.json";
  static const PATH_SPEEZA = "/etc/speeza_smhd.json";
  static const PATH_VIANANO = "/etc/vianano_smhd.json";
  static const PATH_WEBPLUS2 = "/etc/aaeon_atom_smhd.json";
  static const PATH_WEB2500 = "/etc/2500_smhd.json";
  static const PATH_WEB2350 = "/etc/2350_smhd.json";
  static const PATH_WEB2800 = "/etc/2800_smhd.json";
  static const PATH_WEB2300 = "/etc/2300_smhd.json";
  static const PATH_WEBPLUS = "/etc/plus_smhd.json";
  static const PATH_WEB2200 = "/etc/5612_smhd.json";
  static const USBCAM_DIR = "/ext/usbcam/";
  static const PATH_RM5900 = "/etc/rm5900_smhd.json";
  static const ICCARD_DEV_FILE = "/dev/iccard0";
  static const CPUBOX_FLAG = "/pj/tprx/tmp/cpubox_flag";

  Recog recog = Recog();

  /// クレジット仕様のフラグを返す
  /// 戻り値：0:非クレジット仕様 / 1:クレジット仕様
  /// 関連tprxソース:cm_cksys.c - cm_crdt_system()
  static Future<int> cmCrdtSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    // クレジット仕様判定
    if (await CmCksys.cmDummyCrdtSystem() != 0) {
      return 1;
    } else {
      // sys.jsonのcreditsystemをメモリから取得
      if ((await Recog().recogGet(
          Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_CREDITSYSTEM,
          RecogTypes.RECOG_GETMEM)
      ).result != RecogValue.RECOG_NO) {
        return 1;
      }
    }
    return 0;
  }

  /// MMシステム仕様のフラグを返す
  /// 戻り値：0:TS2100接続仕様(標準)  1:MMシステム
  /// 関連tprxソース:cm_cksys.c - cm_mm_system()
  static int cmMmSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return pCom.iniMacInfo.mm_system.mm_onoff;
  }

  /// MMシステム仕様の場合に、そのマシンのタイプを返す
  /// 戻り値：-1:MMシステムではない  0:S  1:M2  2:M1  3:M1 only
  /// 関連tprxソース:cm_cksys.c - cm_mm_type()
  static int cmMmType() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxCommonBuf pCom = xRet.object;
    if (cmMmSystem() != 0) {
      return pCom.iniMacInfo.mm_system.mm_type;
    }
    return -1;
  }

  /// 24時間仕様のフラグを返す
  /// 戻値：0:２４時間仕様ではない  1:２４時間仕様
  /// 関連tprxソース:cm_cksys.c - cm_24hour_system()
  static Future<int> cm24hourSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ２４時間仕様判定 15ver:共通コントロールは確認しない */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SYS_24HOUR,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// mac_info.iniより、MMシステム仕様のマシンタイプを返す
  /// 戻り値：-1:MMシステムではない  0:S  1:BS  2:M  3:ｽﾀﾝﾄﾞｱﾛﾝ only
  /// 関連tprxソース:cm_cksys.c - cm_mm_ini_type()
  static Future<int> cmMmIniType() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;

    if (macInfo.mm_system.mm_onoff == 0) {
      return -1;
    }
    return macInfo.mm_system.mm_type;
  }

  /// Loginしている番号を返す
  /// 戻値：Login番号
  /// 関連tprxソース:cm_cksys.c - cm_login_no()
  static int cmLoginNo() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return int.tryParse(pCom.dbStaffopen.cshr_cd ?? "") ?? 0;
  }

  /// セルフシステムのフラグを返す
  /// 戻値：0:セルフシステム仕様ではない  1:セルフシステム仕様
  /// 関連tprxソース:cm_cksys.c - cm_self_system(), cm_self_system2()
  static Future<int> cmSelfSystem() async {
    return (await cmSelfSystem2(RecogTypes.RECOG_GETSYS));
  }

  static Future<int> cmSelfSystem2(RecogTypes get_typ) async {
    int res = 0;
    RecogValue ret;

    ret = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SELF_GATE, get_typ)).result;
    if (ret != RecogValue.RECOG_NO) {
      res = 1;
    }
    if (res != 1) {
      ret = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_QUICK_SELF, get_typ)).result;
      if (ret != RecogValue.RECOG_NO) {
        res = 1;
      }
    }
    if (res != 1) {
      if (await cmSqrcTicketSystem() != 0) {
        res = 1;
      }
    }
    if (CompileFlag.SMART_SELF) {
      if (res != 1) {
        ret = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_HAPPYSELF_SYSTEM, get_typ)).result; /* HappySelf仕様 */
        if (ret != RecogValue.RECOG_NO) {
          res = 1;
        }
      }
    }
    return res;
  }

  /// クイックセルフのフラグを返す
  /// 戻値：0:クイックセルフ仕様ではない  1:クイックセルフ仕様
  /// 関連tprxソース:cm_cksys.c - cm_quick_self_system()
  static Future<int> cmQuickSelfSystem() async {
    int res = 0;

    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_QUICK_SELF,
        RecogTypes.RECOG_GETSYS)).result != RecogValue.RECOG_NO ) {
      res = 1;
    }
    return res;
  }

  /// クイックセルフ切替のフラグを返す
  /// 戻値：0:クイックセルフ切替仕様ではない  1:クイックセルフ切替仕様
  /// 関連tprxソース:cm_cksys.c - cm_quick_chg_system(), cm_quick_chg_system2()
  static Future<int> cmQuickChgSystem() async {
    return (await cmQickChgSystem2(RecogTypes.RECOG_GETSYS));
  }

  static Future<int> cmQickChgSystem2(RecogTypes get_typ) async {
    int res = 0;

    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_QUICK_SELF_CHG,
        get_typ)).result != RecogValue.RECOG_NO ) {
      res = 1;
    }
    return res;
  }

  /// レジメンテナンスモード状態セット
  /// 戻値：なし
  /// 関連tprxソース:cm_cksys.c - cm_ment_mode_on()
  static void cmMentModeOn() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      pCom.nowMentMode = 1; /* メンテナンス状態 */
    }
  }

  /// レジメンテナンスモード状態リセット
  /// 戻値：なし
  /// 関連tprxソース:cm_cksys.c - cm_ment_mode_off()
  static void cmMentModeOff() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      pCom.nowMentMode = 0; /* メンテナンス状態解除 */
    }
  }

  /// レジメンテナンスモードチェック
  /// 戻値：0:メンテナンスモード解除／1:メンテナンスモード状態
  /// 関連tprxソース:cm_cksys.c - cm_ment_mode_chk()
  static int cmMentModeChk() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* メンテナンスモード判定 */
    return (pCom.nowMentMode!);
  }

  /// sys.iniより、WEBの機種タイプ（Type付き）を取得する
  /// 関連tprxソース:cm_cksys.c - cm_WebTypeGet()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  /// 戻り値：CmSysにて定義される文字列（BOOT_*）
  static String cmWebTypeGet(SysJsonFile sysIni) {
    if (sysIni.type.webplus2 == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_WEBPLUS2_TOWER;
      } else {
        return CmSys.BOOT_WEBPLUS2_DESKTOP;
      }
    } else if (sysIni.type.webplus == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_WEBPLUS_TOWER;
      } else {
        return CmSys.BOOT_WEBPLUS_DESKTOP;
      }
    } else if (sysIni.type.web2300 == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_WEB2300_TOWER;
      } else {
        return CmSys.BOOT_WEB2300_DESKTOP;
      }
    } else if (sysIni.type.web2800 == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_WEB2800_TOWER;
      } else {
        return CmSys.BOOT_WEB2800_DESKTOP;
      }
    } else if (sysIni.type.web2350 == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_WEB2350_TOWER;
      } else {
        return CmSys.BOOT_WEB2350_DESKTOP;
      }
    } else if (sysIni.type.web2500 == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_WEB2500_TOWER;
      } else {
        return CmSys.BOOT_WEB2500_DESKTOP;
      }
    } else if (sysIni.type.webjr == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_JR_TOWER;
      } else {
        return CmSys.BOOT_JR;
      }
    } else if (sysIni.type.dual == "yes") {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_DUAL_TOWER;
      } else {
        return CmSys.BOOT_DUAL_DESKTOP;
      }
    } else {
      if (sysIni.type.tower == "yes") {
        return CmSys.BOOT_TOWER;
      } else {
        return CmSys.BOOT_DESKTOP;
      }
    }
  }

  /// sys.iniより、WEB2800の機種タイプを取得する
  /// 関連tprxソース:cm_cksys.c - cm_Web2800Type()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  /// 戻り値：CmSysにて定義される値（WEB28TYPE_*）
  static int cmWeb2800Type(SysJsonFile sysIni) {
    bool flgSpeeza = TprxPlatform.getFile(PATH_SPEEZA).existsSync();
    bool flgAaeon = TprxPlatform.getFile(PATH_AAEON).existsSync();
    bool flgVianano = TprxPlatform.getFile(PATH_VIANANO).existsSync();

    if (sysIni.type.web2800 == "no") {
      return -1;
    }

    if (TprxPlatform.getFile(PATH_PRIME3).existsSync()) {
      return CmSys.WEB28TYPE_PR3;
    }
    if (TprxPlatform.getFile(PATH_G3SYS).existsSync()) {
      return CmSys.WEB28TYPE_G3;
    }
    if (!flgVianano) {
      if (!(flgSpeeza || flgAaeon)) {
        return CmSys.WEB28TYPE_I;
      } else if (flgSpeeza && !flgAaeon) {
        return CmSys.WEB28TYPE_SP;
      } else if (!flgSpeeza && flgAaeon) {
        if (TprxPlatform.getFile("/etc/tprtss_smhd.json").existsSync()) {
          return CmSys.WEB28TYPE_IP;
        }
        if (TprxPlatform.getFile("/etc/tprtim_smhd.json").existsSync()) {
          return CmSys.WEB28TYPE_IM;
        }
      } else {
        return CmSys.WEB28TYPE_SPP;
      }
    } else {
      if (!flgAaeon) {
        if (TprxPlatform.getFile("/etc/tprtss_smhd.json").existsSync()) {
          if (flgSpeeza) {
            return CmSys.WEB28TYPE_SP3;
          } else {
            return CmSys.WEB28TYPE_I3;
          }
        }
        if (TprxPlatform.getFile("/etc/tprtim_smhd.json").existsSync()) {
          return CmSys.WEB28TYPE_A3;
        }
      }
    }

    return (-1);
  }

  /// Wizマスタ管理のフラグを返す
  /// 戻り値：0:Wizマスタ管理ではない  1:Wizマスタ管理
  /// 関連tprxソース:cm_cksys.c - cm_wiz_cnct_system()
  static Future<int> cmWizCnctSystem() async {
    int res = 0;
    int mmType;

    mmType = cmMmType();
    if((mmType == CmSys.MacM1) || (mmType == CmSys.MacMOnly)) {	/* ＳＴ以外 */
      /* 共有メモリポインタの取得 */
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      /* 特定百貨店仕様チェック */
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_WIZ_CNCT,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        res = 1;
      }
    }
    return res;
  }

  /// SHMDファイルパスより、WEB機種タイプを取得する
  ///  関連tprxソース:cm_cksys.c - cm_WebType()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  /// 戻り値：CmSysにて定義される値（WEBTYPE_*）
  static Future<int> cmWebType() async {
    if (TprxPlatform.getFile(PATH_WEBPLUS2).existsSync()) {
      return CmSys.WEBTYPE_WEBPLUS2;
    } else if (TprxPlatform.getFile(PATH_WEBPLUS).existsSync()) {
      return CmSys.WEBTYPE_WEBPLUS;
    } else if (TprxPlatform.getFile(PATH_WEB2800).existsSync()) {
      return CmSys.WEBTYPE_WEB2800;
    } else if (TprxPlatform.getFile(PATH_WEB2500).existsSync()) {
      return CmSys.WEBTYPE_WEB2500;
    } else if (TprxPlatform.getFile(PATH_WEB2350).existsSync()) {
      return CmSys.WEBTYPE_WEB2350;
    } else if (TprxPlatform.getFile(PATH_WEB2300).existsSync()) {
      return CmSys.WEBTYPE_WEB2300;
    } else if (TprxPlatform.getFile(PATH_WEB2200).existsSync()) {
      return CmSys.WEBTYPE_WEB2200;
    } else if (await cmWebJrSystem() != 0) {
      return CmSys.WEBTYPE_WEBPRIME;
    } else {
      return CmSys.WEBTYPE_WEB2100;
    }
  }

  /// WEB2100 Primeのタイプのフラグを返す
  /// 戻値：0:WEB2100 Prime タイプではない  1:WEB2100 Prime タイプ  2:WEB2100 Prime Tower タイプ
  /// 関連tprxソース:cm_cksys.c - cm_web_primetower_system()
  static Future<int> cmWebPrimetowerSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmWebJrSystem() != 0) {
      res = 1;
      if (pCom.iniSys.type.tower == "yes") {
        res = 2;
      }
    }
    return res;
  }

  /// sys.iniより、WEB2100Jr.タイプのフラグを返す
  /// 関連tprxソース:cm_cksys.c - cm_webjr_system()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  /// 戻り値：0:WEB2100 Jr.タイプではない  1:WEB2100 Jr.タイプ
  static Future<int> cmWebJrSystem() async {
    /// 設定ファイルを読み取る
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysIni = pCom.iniSys;

    if ((sysIni.type.webjr == "yes") ||
        (sysIni.type.webjr == "ok0893") ||
        (sysIni.type.webplus == "yes") ||
        (sysIni.type.webplus == "ok0893")) {
      return 1;
    }
    return 0;
  }

  /// sys.iniより、WEB2100 Jr.タイプのデバッグフラグを返す
  /// 関連tprxソース:cm_cksys.c - cm_webjr_debug_system()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  /// 戻値：0:webjr=yes/no   1:webjr=ok0893
  static int cmWebJrDebugSystem(SysJsonFile sysIni) {
    if ((sysIni.type.webjr == "ok0893") ||
        (sysIni.type.webplus == "ok0893")) {
      return 1;
    }
    return 0;
  }

  /// HQASP仕様のフラグを返す
  /// 戻値：0:非HQASP仕様 / 1:HQASP仕様
  /// 関連tprxソース:cm_cksys.c - cm_netDoA_system()
  static Future<int> cmNetDoASystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* HQASP仕様判定 */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HQ_ASP,
        RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// CSS店舗間通信仕様のフラグを返す
  /// 戻値：0:hq_other=yes/no    1:hq_other=ok0893
  /// 関連tprxソース:cm_cksys.c - cm_CSS_system()
  static Future<int> cmCSSSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HQ_OTHER,
        RecogTypes.RECOG_GETSYS)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// ＦＴＰ使用中セット
  /// 戻値：なし
  /// 関連tprxソース:cm_cksys.c - cm_Set_ftp_use()
  static void cmSetFtpUse() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      pCom.nowFtpUse = 1;
    }
  }

  /// ＦＴＰ未使用セット
  /// 戻値：なし
  /// 関連tprxソース:cm_cksys.c - cm_Reset_ftp_use()
  static void cmResetFtpUse() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      pCom.nowFtpUse = 0;
    }
  }

  /// ＦＴＰ使用中かチェック
  /// 戻値：0:未使用/1:使用中
  /// 関連tprxソース:cm_cksys.c - cm_Chk_ftp_use()
  static int cmChkFtpUse() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.nowFtpUse!);
  }

  /// 特定FTP送信仕様のフラグを返す
  /// 戻値：0:非特定FTP送信仕様 / 1:特定FTP送信仕様
  /// 関連tprxソース:cm_cksys.c - cm_jasaitama_system()
  static Future<int> cmJasaitamaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定FTP送信仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_JASAITAMA_SYS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// sys.iniより、WEB機種タイプがWeb2300系統かチェックする
  /// 関連tprxソース:cm_cksys.c - cm_Check_AfterWeb2300()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  /// 戻り値：1:WEB2300系統以降 / 0:WEB2300系統以外
  static Future<int> cmCheckAfterWeb2300() async {
    int webType = await cmWebType();

    if ((webType == CmSys.WEBTYPE_WEB2100) ||
        (webType == CmSys.WEBTYPE_WEBPRIME) ||
        (webType == CmSys.WEBTYPE_WEB2200)) {
      return 0;
    }
    return 1;
  }

  /// リライト接続時の検索訂正が有効かを返す
  /// 戻り値：0:検索訂正有効  1:検索訂正有効
  /// 関連tprxソース:cm_cksys.c - cm_Chk_Rwc_UseEsvoid()
  static Future<int> cmChkRwcUseEsvoid() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 現在はグリーンスタンプ接続のみ検索訂正対応のため、こちらのプログラム使用 */
    return(((pCom.dbTrm.coopYamaguchiGreenStamp != 0)
      && (await cmGreenstampSystem2() != 0) ) || /* コープやまぐち仕様 */
        ((pCom.dbTrm.rwPossibleEsvoid != 0) &&
            ((await cmGreenstampSystem() != 0) &&
            (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 3))) ||
        ((await cmHitachiBluechipSystem() != 0) &&
          (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 9)) ||
      (cmMatugenSystem() != 0))? 1 : 0;
  }

  /// Visa Touch[INFOX]仕様のフラグを返す
  /// 戻り値：0:Visa Touch[INFOX]仕様ではない  1:Visa Touch[INFOX]仕様
  /// 関連tprxソース:cm_cksys.c - cm_VisaTouch_system()
  static Future<int> cmVisaTouchSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Visa Touch[INFOX]仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_VISATOUCH_INFOX,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    /* 電子マネー決済仕様チェック */
    else if (await cmCctEmoneySystem() != 0) {
      res = 1;
    }
    return ((res != 0) &&
      ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 4) ||     /* INFOX */
        ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
          (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 4))))? 1 : 0;
  }

  /// オートアップデート仕様のフラグを返す
  /// 引数:なし
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_auto_update_system()
  static int cmAutoUpdateSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.dbTrm.autoUpdate > 0) {
      return 1;
    }
    return 0;
  }

  /// ＱＣａｓｈｉｅｒ仕様のフラグを返す
  ///  関連tprxソース:cm_cksys.c - cm_QCashier_system() cm_QCashier_system2()
  ///  引数：なし
  ///  戻値：0:QCashier仕様でない  1:QCashier仕様
  static Future<int> cmQCashierSystem() async {
    return (await cmQCashierSystem2(RecogTypes.RECOG_GETSYS));
  }

  static Future<int> cmQCashierSystem2(RecogTypes get_typ) async {
    int res = 0;
    RecogValue status = (await Recog().recogGet(
        Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_QCASHIER_SYSTEM, get_typ))
        .result;
    if (status != RecogValue.RECOG_NO) {
      return (1);
    }
    /* QCashier仕様チェック */
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_QCASHIER_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status1 != RecogValue.RECOG_NO) {
      res = 1;
    }
    if (CompileFlag.SMART_SELF) {
      if (await cmHappySelfAllSystem() == 1) {
        res = 1;
      }
    }
    return (res);
  }

  /// /etc/openvpn ディレクトリの有無をチェック（VPN接続仕様）
  /// 関連tprxソース:cm_cksys.c - cm_openvpn_dirchk
  /// 引数：なし
  /// 戻値：0:なし  1:あり
  static Future<int> cmOpenvpnDirchk() async {
    return TprxPlatform.getFile("/etc/openvpn").existsSync() ? 1 : 0;
  }

  /// 全日食様仕様のフラグを返す
  /// 戻値：0:上記仕様ではない  1:上記仕様である
  /// 関連tprxソース:cm_cksys.c - cm_ZHQ_system()
  static Future<int> cmZHQSystem() async {
    RecogValue status;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_ZHQ_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
        return 1;
      }
      return 0;
    }

    status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ZHQ_SYSTEM, RecogTypes.RECOG_GETSYS)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// MST端末 電子マネー決済仕様のフラグを返す
  /// 戻値：0:電子マネー決済仕様でない 1:電子マネー決済仕様
  /// 関連tprxソース:cm_cksys.c - cm_mst_connect_system()
  static Future<int> cmMstConnectSystem() async {
    int res = 0;
    if (await cmZHQSystem() != 0) {
      res = 1;
    }
    return ((res != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 9))? 1 : 0;
  }

  /// 一般特売、会員特売のそれぞれの最安仕様のチェックを返す (トヨダ仕様)
  /// 戻値：0:それ以外  1:一般特売・会員特売のそれぞれの最安価格スケジュールを読み込む
  /// 関連tprxソース:cm_cksys.c - cm_Inexpensive_SalePrc_system()
  static Future<int> cmInexpensiveSalePrcSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmForceInexpensiveAllPrcSystem() != 0) {
      return 0;
    }
    else if((pCom.dbTrm.brgnPrcFlg == 0)	//特売スケジュール優先度「価格」
        &&  (pCom.dbTrm.lowPrice1 != 0))	{	//一般特売、会員特売のそれぞれの最安を利用する
      return 1;
    }
    return 0;
  }

  /// 一般特売、会員特売のそれぞれの最安仕様のチェックを返す
  ///   cm_Inexpensive_SalePrc_system()でのNON-PLU時の一般特売の動作を除外
  /// 戻値：0:それ以外  1:一般特売・会員特売のそれぞれの最安価格スケジュールを読み込む
  /// 関連tprxソース:cm_cksys.c - cm_Force_Inexpensive_AllPrc_system()
  static Future<int> cmForceInexpensiveAllPrcSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmZHQSystem() != 0) {
      return 1;
    }
    else if((pCom.dbTrm.brgnPrcFlg == 0)	   //特売スケジュール優先度「価格」
        &&  (pCom.dbTrm.useLowPrice != 0)) { //一般特売、会員特売のそれぞれの最安を利用する
      return 1;
    }
    return 0;
  }

  /// 全日食様 お得券＆レシート プリンタ共用の場合にプリンタのAIDを判断する
  /// 戻値：TPRDIDRECEIPT3/TPRDIDRECEIPT4/TPRDIDRECEIPT5(/TPRDIDRECEIPT6)
  /// 関連tprxソース:cm_cksys.c - cm_Check_ZHQCouponReciept_Share()
  static Future<int> cmCheckZHQCouponRecieptShare(int tid) async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmQCJCCPrintAid(Tpraid.TPRAID_PRN) != Tpraid.TPRAID_KITCHEN1_PRN) {
      return cmPrintCheck();
    }
    if ((await CompetitionIni.competitionIniGetShort(tid,
        CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
        CompetitionIniType.COMPETITION_INI_GETMEM_JC_J)) == 1 ) {
      return TprDidDef.TPRDIDRECEIPT3;
    }
    if ((await CompetitionIni.competitionIniGetShort(tid,
        CompetitionIniLists.COMPETITION_INI_ZHQ_CPNRCT_SHARE,
        CompetitionIniType.COMPETITION_INI_GETMEM_JC_C)) == 1 ) {
      return TprDidDef.TPRDIDRECEIPT4;
    }
    return cmPrintCheck();
  }

  /// 関連tprxソース:cm_cksys.c - cm_RP_PrinterChk()
  static Future<int> cmRPPrinterChk() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.qcjc_c_print == pid) {
      if (await CmCksys.cm2ndPrinterType() == CmSys.TPRTIM) {
        if (TprxPlatform.getFile("/etc/tprtrpd2_smhd.json").existsSync()) {
          return 1;
        }
      }
    } else {
      if ((pCom.kitchen_prn1 != pid) || (pCom.kitchen_prn2 != pid)) {
        if ((await CmCksys.cmPrinterType() == CmSys.TPRTIM) || (await CmCksys.cmPrinterType() == CmSys.TPRTHP)) {
          if (TprxPlatform.getFile("/etc/tprtrpd_smhd.json").existsSync()) {
            return 1;
          }
        }
      }
    }
    return 0;
  }

  /// 特定WS仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定WS仕様ではない 1:特定WS印字仕様
  /// 関連tprxソース:cm_cksys.c - cm_ws_system()
  static Future<int> cmWsSystem() async {
    /* 特定ws仕様チェック */
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_WS_SYSTEM, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_YES) ||
        (status.result == RecogValue.RECOG_OK0893)) {
      return (1);
    }
    return (0);
  }

  /// CAPS(CAFIS)接続仕様かどうか
  /// 戻値：0:CAPS[CAFIS]接続仕様ではない / 1:CAPS[CAFIS]接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_CAPS_CAFIS_system()
  static Future<int> cmCapsCafisSystem() async {
    int res1 = 0;
    int res2 = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* CAPS[CAFIS]接続仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CAPS_CAFIS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CREDITSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 == 1) && (res2 == 1)) ? 1 : 0;
  }

  /// NTTASP仕様かどうか
  /// 戻値：0:非NTTASP仕様 / 1:NTTASP仕様
  /// 関連tprxソース:cm_cksys.c - cm_nttasp_system()
  static Future<int> cmNttaspSystem() async {
    //共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }

    //NTTASP仕様判定
    if (await CmCksys.cmDummyCrdtSystem() != 0) {
      return 1;
    } else {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_NTT_ASP, RecogTypes.RECOG_GETMEM))
          .result != RecogValue.RECOG_NO) {
        return 1;
      }
    }
    return 0;
  }

  /// WebRiseのフラグを返す
  /// 戻値： -1:WebRise対応のHDDではない (/etc/rise_smhd.iniが存在しない)
  ///       0:WebRiseではない
  ///       1:WebRiseである
  /// 関連tprxソース:cm_cksys.c - cm_webrise_system()
  static Future<int> cmWebriseSystem() async {
    int res = 0;

    if (TprxPlatform.getFile('/etc/rise_smhd.json').existsSync()) {
      JsonRet riseIni = await getJsonValue('/etc/rise_smhd.json', 'type', 'rise');
      if (riseIni.result) {
        if ((riseIni.value == "yes") ||
            (riseIni.value == "ok0893") ||
            (riseIni.value == "cf")) {
          res = 1;
        }
      }
    } else {
      res = -1;
    }
    return res;
  }

  /// レジ折り返しクレジット仕様かどうか
  /// 戻値：0:レジ折り返しクレジット仕様ではない 1:レジ折り返しクレジット仕様
  /// 関連tprxソース:cm_cksys.c - cm_dummy_crdt_system()
  static Future<int> cmDummyCrdtSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DUMMY_CRDT, RecogTypes.RECOG_GETMEM))
        .result !=
        RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// ストレージがSSDであるかチェックする
  /// 戻値：0: SSDでない   1: SSDである
  /// 関連tprxソース:cm_cksys.c - cm_SSDSmhdChk()
  static Future<int> cmSSDSmhdChk() async {
    if (TprxPlatform.getFile('/etc/ssd_smhd.json').existsSync()) {
      return 1;
    } else {
      return 0;
    }
  }

  /// ＨＣ(くろがねや)仕様のフラグを返す
  /// 引数：TPRMID tid  (device message ID)
  /// 戻値：0:ＨＣ(くろがねや)仕様でない  1:ＨＣ(くろがねや)仕様
  /// 関連tprxソース:cm_cksys.c - cm_hc2_Kuroganeya_system()
  static Future<int> cmHc2KuroganeyaSystem(int tid) async {
    RecogRetData status = await Recog().recogGet(tid,
        RecogLists.RECOG_HC2_SYSTEM, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 釣銭釣札機接続状態を返す
  /// 戻値：0:未接続 1:釣銭機接続 2:釣銭釣札機接続
  /// 関連tprxソース:cm_cksys.c - cm_acx_cnct()
  static Future<int> cmAcxCnct() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_ACR_ONOFF) == 0) {
      return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_ACR_CNCT));
    } else {
      return 0;
    }
  }

  /// 音声合成(ソフト対応)仕様のフラグを返す
  /// 引数：TPRMID tid  (device message ID)
  /// 戻値：0:仕様でない  1:仕様
  /// 関連tprxソース:cm_cksys.c - cm_PriceSound_system()
  static Future<int> cmPriceSoundSystem(int tid) async {
    RecogRetData status = await Recog().recogGet(tid,
        RecogLists.RECOG_PRICE_SOUND, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    if (CompileFlag.SMART_SELF) {
      if (await cmHappySelfSystem() != 0) /* HappySelf仕様 */ {
        return 1;
      }
    }
    return 0;
  }

  /// レジ折り返しプリカ仕様のフラグを返す【動作するのはNTT Pastel Port仕様】
  /// 引数：TPRMID tid  (device message ID)
  /// 戻値：0:レジ折り返しプリカ仕様ではない 1:レジ折り返しプリカ仕様
  /// 関連tprxソース:cm_cksys.c - cm_dummy_preca_system()
  static Future<int> cmDummyPrecaSystem(int tid) async {
    RecogRetData status = await Recog().recogGet(tid,
        RecogLists.RECOG_DUMMY_PRECA, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 精算監視仕様のフラグを返す
  /// 引数：TPRMID tid  (device message ID)
  /// 戻値：0:精算監視仕様ではない 1:精算監視仕様仕様
  /// 関連tprxソース:cm_cksys.c - cm_paystat_monitored_system()
  static Future<int> cmPaystatMonitoredSystem(int tid) async {
    RecogRetData status = await Recog().recogGet(tid,
        RecogLists.RECOG_MONITORED_SYSTEM, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// CAPS(P-QVIC)接続仕様かどうか
  /// 戻値：0:CAPS[P-QVIC]接続仕様ではない  1:CAPS[P-QVIC]接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_CAPS_PQVIC_system()
  static Future<int> cmCapsPqvicSystem() async {
    int res1 = 0;
    int res2 = 0;
    //CAPS[P-QVIC]接続仕様チェック
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CAPS_PQVIC, RecogTypes.RECOG_GETMEM))
        .result !=
        RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CREDITSYSTEM, RecogTypes.RECOG_GETMEM))
        .result !=
        RecogValue.RECOG_NO) {
      res2 = 1;
    }
    if (res1 == 1 && res2 == 1) {
      return 1;
    }
    return 0;
  }

  /// RedHat7.3でsambaが更新されているか判断
  /// 戻値：0:sambaが更新されていない (/etc/.newsambaが存在しない)  1:sambaが更新されている
  /// 関連tprxソース:cm_cksys.c - cm_newsamba_system()
  static int cmNewsambaSystem() {
    if (TprxPlatform.getFile('/etc/.newsamba').existsSync()) {
      return 1;
    }
    return 0;
  }

  /// 書籍を集計するに設定されているか判断
  /// 戻値：0:するに設定されていない  1:するに設定されている
  /// 関連tprxソース:cm_cksys.c - cm_bookbar_collect_system()
  static Future<int> cmBookbarCollectSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 集計する設定チェック */
    return ((pCom.dbTrm.bookSumPluTyp == 1) ||
        (pCom.dbTrm.bookSumPluTyp == 2) ||
        (pCom.dbTrm.bookSumPluTyp == 3))? 1 : 0;
  }

  /// 書籍をジャンル別で集計に設定されているか判断
  /// 戻値：0:ジャンル別に設定されていない  1:ジャンル別に設定されている
  /// 関連tprxソース:cm_cksys.c - cm_bookbar_genre_system()
  static Future<int> cmBookbarGenreSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* ジャンル別集計設定チェック */
    return ((pCom.dbTrm.bookSumPluTyp == 6) ||
        (pCom.dbTrm.bookSumPluTyp == 7) ||
        (pCom.dbTrm.bookSumPluTyp == 8))? 1 : 0;
  }

  /// 雑誌を集計するに設定されているか判断
  /// 戻値：0:するに設定されていない  1:するに設定されている
  /// 関連tprxソース:cm_cksys.c - cm_magazine_collect_system()
  static Future<int> cmMagazineCollectSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 集計する設定チェック */
    return ((pCom.dbTrm.bookSumPluTyp == 1) ||
        (pCom.dbTrm.bookSumPluTyp == 4) ||
        (pCom.dbTrm.bookSumPluTyp == 7))? 1 : 0;
  }

  /// 雑誌をジャンル別で集計に設定されているか判断
  /// 戻値：0:ジャンル別集計に設定されていない  1:ジャンル別集計に設定されている
  /// 関連tprxソース:cm_cksys.c - cm_magazine_genre_system()
  static Future<int> cmMagazineGenreSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* ジャンル別集計設定チェック */
    return ((pCom.dbTrm.bookSumPluTyp == 2) ||
        (pCom.dbTrm.bookSumPluTyp == 5) ||
        (pCom.dbTrm.bookSumPluTyp == 8))? 1 : 0;
  }

  /// 収納代行仕様かどうか
  /// 戻値：0:収納代行仕様でない  1:収納代行仕様
  /// 関連tprxソース:cm_cksys.c - cm_pbchg_system()
  static Future<int> cmPbchgSystem() async {
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PBCHG_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// TS接続の収納業務が有効かどうか
  /// 戻値：0:TS接続の収納業務が有効でない  1:TS接続の収納業務が有効
  /// 関連tprxソース:cm_cksys.c - cm_pbchg_ts_system()
  static Future<int> cmPbchgTsSystem() async {
    String sTmpBuf = '';
    if ((await CmCksys.cmPbchgSystem() == 1) && (cmMmType() == -1)) {
      PbchgJsonFile pbchgInfo = PbchgJsonFile();
      sTmpBuf = pbchgInfo.util.exec as String;
      if (sTmpBuf == '1') {
        return 1;
      }
    }
    return 0;
  }

  /// CASIOリアル顧客のフラグを返す
  /// 戻値：0:CASIOリアル顧客仕様ではない  1:CASIOリアル顧客仕様
  /// 関連tprxソース:cm_cksys.c - cm_casioreal_system()
  static Future<int> cmCasiorealSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ダイキ顧客仕様チェック */
    if ((await cmDcmpointSystem() != 0) || (await cmHc1KomeriSystem() != 0)) {
      return 1;
    }
    return 0;
  }

  /// コメリ仕様&顧客リアルのフラグを返す
  /// 戻値：0:ダイキ顧客仕様ではない  1:ダイキ顧客仕様
  /// 関連tprxソース:cm_cksys.c - cm_komeripoint_system()
  static Future<int> cmKomeripointSystem() async {
    int res1 = 0;
    int res2 = 0;
    int res3 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ダイキ顧客仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_HC1_SYSTEM,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_CUSTREALSVR,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO){
      res2 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERSYSTEM,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO){
      res3 = 1;
    }
    return ((res1 == 1) && (res2 == 1) && (res3 == 1)) ? 1 : 0;
  }

  /// WebSpeeza対応のフラグを返す
  /// 戻値：0:WebSpeezaではない (/etc/speeza_smhd.iniが存在しない) 1:WebSpeezaである
  /// 関連tprxソース:cm_cksys.c - cm_webspeeza_system()
  static Future<int> cmWebspeezaSystem() async {
    return TprxPlatform.getFile("/etc/speeza_smhd.json").existsSync() ? 1 : 0;
  }

  /// ＴＳバージョン管理を返す
  /// 戻値：-1: エラー  0:レジと同一  1:バージョン11
  /// 関連tprxソース:cm_cksys.c - cm_chk_tsver_mrg()
  static Future<int> cmChkTsverMrg() async {
    int result;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;

    result = macInfo.system.ts_ver_mrg;
    if (result >= 0) {
      return result;
    }
    return -1;
  }

  /// メインボードがAAEON EMB-9458T (945GM/GME)であるかチェックする
  /// 戻値：0:AAEON EMB-9458T(945GM/GME)でない  1:AAEON EMB-9458T(945GM/GME)である
  /// 関連tprxソース:cm_cksys.c - cm_AaeonSmhdChk()
  static Future<int> cmAaeonSmhdChk() async {
    return TprxPlatform.getFile("/etc/aaeon_smhd.json").existsSync() ? 1 : 0;
  }

  /// メインボードがAAEON EMB-9459T (945GS)であるかチェックする
  /// 戻値：0:AAEON EMB-9459T(945GS)でない  1:AAEON EMB-9459T(945GS)である
  /// 関連tprxソース:cm_cksys.c - cm_AaeonAtomSmhdChk()
  static Future<int> cmAaeonAtomSmhdChk() async {
    return TprxPlatform.getFile("/etc/aaeon_atom_smhd.json").existsSync() ? 1: 0;
  }

  /// 顧客リアル[Pアーティスト]仕様かどうか
  /// 戻値：0:顧客リアル[Pアーティスト]仕様ではない  1:顧客リアル[Pアーティスト]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_pointartist_system()
  static Future<int> cmCustrealPointartistSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return 0;
    }
    status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_POINTARTIST, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return 1;
    }
    return 0;
  }

  /// Edy仕様かどうか
  /// 戻値：0:非Ｅｄｙ仕様 / 1:Ｅｄｙ仕様
  /// 関連tprxソース:cm_cksys.c - cm_Edy_system()
  static Future<int> cmEdySystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_EDYSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// Edyカード仕様かどうか
  /// 戻値：0:非Ｅｄｙカード仕様 / 1:Ｅｄｙカード仕様
  /// 関連tprxソース:cm_cksys.c - cm_EdyCard_system()
  static Future<int> cmEdyCardSystem() async {
    int res = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Ｅｄｙカード仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_EDYSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res == 1) &&
        ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 5) ||
            (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 7)) ) ? 1: 0;
  }

  /// 生鮮ＩＤ仕様のフラグを返す
  /// 戻値：0:生鮮ＩＤ仕様ではない  1:生鮮ＩＤ仕様
  /// 関連tprxソース:cm_cksys.c - cm_fresh_system()
  static Future<int> cmFreshSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 生鮮ＩＤ仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FRESH_BARCODE,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// スギ薬局仕様のフラグを返す
  /// 戻値：0:スギ薬局仕様ではない  1:スギ薬局仕様
  /// 関連tprxソース:cm_cksys.c - cm_sugi_system()
  static Future<int> cmSugiSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* スギ薬局仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SUGI_SYS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 客側表示機のチェック
  /// 戻値：0:フルドット表示機  1:セグメント表示機  2:LCD表示機
  /// 関連tprxソース:cm_cksys.c - cm_segment_chk()
  static Future<int> cmSegmentChk() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if ((await cmWebJrSystem() == 1) &&
        (pCom.iniMacInfo.prime_fip.prime_fip == 0)) {
      return 1;
    }
    else if((await cmWebJrSystem() == 1) &&
        (pCom.iniMacInfo.prime_fip.prime_fip == 2)) {
      return 2;
    } else {
      return 0;
    }
  }

  /// グリーンスタンプ仕様のフラグを返す
  /// 戻値：0:グリーンスタンプ仕様ではない  1:グリーンスタンプ仕様
  /// 関連tprxソース:cm_cksys.c - cm_greenstamp_system()
  static Future<int> cmGreenstampSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* グリーンスタンプ仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_GREENSTAMP_SYS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// グリーンスタンプ(新フォーマット)仕様のフラグを返す
  /// 戻値：0:グリーンスタンプ(新フォーマット)仕様ではない  1:グリーンスタンプ(新フォーマット)仕様
  /// 関連tprxソース:cm_cksys.c - cm_greenstamp_system2()
  static Future<int> cmGreenstampSystem2() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* グリーンスタンプ仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_GREENSTAMP_SYS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    if ((res != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 3)) {
      return 1;
    }
    return 0;
  }

  /// ビスマック特定処理仕様のフラグを返す
  /// 戻値：0:ビスマック特定処理仕様ではない  1:ビスマック特定処理仕様
  /// 関連tprxソース:cm_cksys.c - cm_coop_system()
  static Future<int> cmCoopSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ビスマック特定処理仕様判定 */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_COOPSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 内税商品の実績を内税込み扱いフラグを返す
  /// 戻値：0:する/ 1:しない
  /// 関連tprxソース:cm_cksys.c - cm_NotInTaxSale_system()
  static int cmNotInTaxSaleSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 内税商品の実績を内税込み扱い判定 */
    if (CompileFlag.TAX_CALC) {
      return ((pCom.dbTrm.catdnoStartNo == 0) ||
          (pCom.dbTrm.catdnoStartNo == 3)) ? 1: 0;
    } else {
      return (pCom.dbTrm.catdnoStartNo == 0) ? 1 : 0;
    }
  }

  /// Ｅｄｙ番号顧客仕様のフラグを返す。
  /// 戻値：0:非Ｅｄｙ番号顧客仕様 / 1:Ｅｄｙ番号顧客仕様
  /// 関連tprxソース:cm_cksys.c - cm_EdyNoMbr_system()
  static Future<int> cmEdyNoMbrSystem() async {
    int res1 = 0;
    int res2 = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_EDYNO_MBR,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return((res1 != 0) && (res2 != 0) &&
        (await cmEdyCardSystem() != 0) && (cmMmSystem() == 0)) ? 1: 0; /* TS */
  }

  /// ＦＣＦカード顧客仕様のフラグを返す
  /// 戻値：0:非ＦＣＦカード顧客仕様 / 1:ＦＣＦカード顧客仕様
  /// 関連tprxソース:cm_cksys.c - cm_FcfMbr_system()
  static Future<int> cmFcfMbrSystem() async {
    int res1 = 0;
    int res2 = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FCF_CARD,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO){
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO){
      res2 = 1;
    }
    return((res1 != 0) && (res2 != 0) &&
        (await cmEdyCardSystem() != 0))? 1: 0;
  }

  /// ﾊﾟﾅｺｰﾄﾞ顧客ﾎﾟｲﾝﾄ仕様のフラグを返す
  /// 戻値：0:ﾊﾟﾅｺｰﾄﾞ顧客ﾎﾟｲﾝﾄ仕様ではない  1:ﾊﾟﾅｺｰﾄﾞ顧客ﾎﾟｲﾝﾄ仕様
  /// 関連tprxソース:cm_cksys.c - cm_PanaMember_system()
  static Future<int> cmPanaMemberSystem() async {
    int res1 = 0;
    int res2 = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* Rainbow Card仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO){
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PANAMEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO){
      res2 = 1;
    }
    return((res1 != 0) && (res2 != 0) &&
        (pCom.dbTrm.rwtInfo == 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 5 ))? 1: 0;
  }

  /// 百貨店仕様のフラグを返す
  /// 戻値：0:百貨店仕様ではない  1:百貨店仕様
  /// 関連tprxソース:cm_cksys.c - cm_DepartmentStore_system()
  static Future<int> cmDepartmentStoreSystem() async {
    int res = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 百貨店仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DEPARTMENT_STORE,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  /// 承認キーとターミナルの百貨店仕様を参照する
  /// 戻値：0:百貨店仕様ではない  1:百貨店仕様
  /// 関連tprxソース:cm_cksys.c - cm_Check_DepartmentStore()
  static Future<int> cmCheckDepartmentStore() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return ((await cmDepartmentStoreSystem() != 0) &&
        (pCom.dbTrm.selfVisatouchKeyCd != 0))? 1: 0;
  }

  /// Tag Read仕様のフラグを返す
  /// 戻値：0:Tag Read仕様でない 1:Tag Read仕様
  /// 関連tprxソース:cm_cksys.c - cm_TagRead_system()
  static Future<int> cmTagReadSystem() async {
    int res = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Tag Read仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TAGRDWT,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RFID_CNCT) != 0))? 1: 0;
  }

  /// Mcp200仕様&顧客リアルのフラグを返す。
  /// 戻値：0:ダイキ顧客仕様ではない / 1:ダイキ顧客仕様
  /// 関連tprxソース:cm_cksys.c - cm_dcmpoint_system()
  static Future<int> cmDcmpointSystem() async {
    int res1 = 0;
    int res2 = 0;
    int res3 = 0;
    int res4 = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ダイキ顧客仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MCP200SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREALSVR,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res3 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SUGI_SYS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res4 = 1;
    }
    return ((res1 == 1) && (res2 == 1) && (res3 == 1) && (res4 == 0)) ? 1 : 0;
  }

  /// iD(FCL)仕様のフラグを返す
  /// 戻値：0:iD(FCL)仕様ではない  1:iD(FCL)仕様
  /// 関連tprxソース:cm_cksys.c - cm_Fcl_iD_system()
  static Future<int> cmFclIDSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* iD(FCL)仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FCLIDSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res == 1) &&
      ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == 2) ||
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == -2))) ? 1 : 0;
  }

  /// Web2800 レジの流し方向を返す
  /// 戻値：0:左流し 1:右流し 2:対面
  /// 関連tprxソース:cm_cksys.c - cm_web2800_reg_cruising()
  static Future<int> cmWeb2800RegCruising() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
      return 0;
    }
    /* Web2800 レジの流し方向チェック */
    return (pCom.iniMacInfo.system.reg_cruising);
  }

  /// レジの流し方向を返す
  /// 戻値：0:左流し 1:右流し 2:対面
  /// 関連tprxソース:cm_cksys.c - cm_rm5900_reg_cruising()
  static Future<int> cmRm5900RegCruising() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (cmRm5900System() != 1) {
      return 0;
    }
    /* レジの流し方向チェック */
    return (pCom.iniMacInfo.system.reg_cruising);
  }

  /// ポイントチケット発券仕様のフラグを返す
  /// 戻値：0:ポイントチケット発券仕様ではない  1:ポイントチケット発券仕様
  /// 関連tprxソース:cm_cksys.c - cm_PTckt_issue_system()
  static Future<int> cmPTcktIssueSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ポイントチケット発券仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PTCKTISSUSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0)) ? 1 : 0;
  }

  /// センターサーバー接続仕様のフラグを返す
  /// 戻値：0:センターサーバー接続仕様でない 1:センターサーバー接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_CenterServer_system()
  static Future<int> cmCenterServerSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* センターサーバー接続仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CENTER_SERVER,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// センターサーバー接続仕様のフラグを返す
  /// 戻値：0:センターサーバー接続仕様でない 1:センターサーバー接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_CenterServer_ini_system()
  static Future<int> cmCenterServerIniSystem() async {
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CENTER_SERVER,
        RecogTypes.RECOG_GETSYS)).result != RecogValue.RECOG_NO){
      return 1;
    }
    return 0;
  }

  /// ABS-S31Kプリペイド仕様のフラグを返す
  /// 戻値：0:ABS-S31Kプリペイド仕様ではない  1:ABS-S31Kプリペイド仕様仕様
  /// 関連tprxソース:cm_cksys.c - cm_Abs_Prepaid_system()
  static Future<int> cmAbsPrepaidSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ABS-S31Kプリペイド仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ABS_PREPAID,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res == 1) &&
      (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 6)) ? 1 : 0;
  }

  /// 生産者商品自動ﾒﾝﾃﾅﾝｽ仕様のフラグを返す
  /// 戻値：0:生産者商品自動ﾒﾝﾃﾅﾝｽ仕様ではない  1:生産者商品自動ﾒﾝﾃﾅﾝｽ仕様
  /// 関連tprxソース:cm_cksys.c - cm_Prod_Item_Auto_system()
  static Future<int> cmProdItemAutoSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ABS-S31Kプリペイド仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PROD_ITEM_AUTOSET,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// レポート粗利項目印字のフラグを返す
  /// 戻値：0:粗利項目印字する  1:粗利項目印字しない
  /// 関連tprxソース:cm_cksys.c - cm_prfamt_print_system()
  static Future<int> cmPrfamtPrintSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbTrm.prfAmt);
  }

  /// 生産者ITFﾊﾞｰｺｰﾄﾞ仕様のフラグを返す
  /// 戻値：0:生産者ITFﾊﾞｰｺｰﾄﾞ仕様でない  1:生産者ITFﾊﾞｰｺｰﾄﾞ仕様
  /// 関連tprxソース:cm_cksys.c - cm_prod_itf14_barcode_system()
  static Future<int> cmProdItf14BarcodeSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (await cmSelfSystem() == 1) {
      return 0;
    }
    /* 生産者ITFﾊﾞｰｺｰﾄﾞ仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PROD_ITF14_BARCODE,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 特殊ｸｰﾎﾟﾝ券仕様のフラグを返す
  /// 戻値：0:特殊ｸｰﾎﾟﾝ券仕様でない  1:特殊ｸｰﾎﾟﾝ券仕様
  /// 関連tprxソース:cm_cksys.c - cm_special_coupon_system()
  static Future<int> cmSpecialCouponSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特殊ｸｰﾎﾟﾝ券仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SPECIAL_COUPON,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// ﾌﾞﾙｰﾁｯﾌﾟｻｰﾊﾞｰ接続仕様のフラグを返す
  /// 戻値：0:ﾌﾞﾙｰﾁｯﾌﾟｻｰﾊﾞｰ接続仕様でない  1:ﾌﾞﾙｰﾁｯﾌﾟｻｰﾊﾞｰ接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_bluechip_server_system()
  static Future<int> cmBluechipServerSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ﾌﾞﾙｰﾁｯﾌﾟｻｰﾊﾞｰ接続仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_BLUECHIP_SERVER,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// バックアップデータ再生中フラグを返す
  /// 戻値：0:バックアップデータ再生中ではない 1:バックアップデータ再生中 2:実績再集計中
  /// 関連tprxソース:cm_cksys.c - cm_bkupd_play_mode_get()
  static Future<int> cmBkupdPlayModeGet() async {
    int res = 0;
    String filePath = SysBkupd.SYS_BKUPD_INI;
    String path = "${EnvironmentData().sysHomeDir}/$filePath";

    if (TprxPlatform.getFile(path).existsSync()) {
      JsonRet ret = await getJsonValue(path, "backupd", "start");
      if (await cmChkDocCnct() == 2) {
        if (ret.result) {
          res = ret.value;
        }
      }
    }
    return res;
  }

  /// CSS[ｶﾝﾃﾎﾞｰﾚ]通信仕様のフラグを返す
  /// 戻値：0:CSS[ｶﾝﾃﾎﾞｰﾚ]通信仕様でない  1:CSS[ｶﾝﾃﾎﾞｰﾚ]通信仕様
  /// 関連tprxソース:cm_cksys.c - cm_hq_other_cantevole_system()
  static Future<int> cmHqOtherCantevoleSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* CSS[ｶﾝﾃﾎﾞｰﾚ]通信仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HQ_OTHER_CANTEVOLE,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 日立ﾌﾞﾙｰﾁｯﾌﾟ接続仕様のフラグを返す
  /// 戻値：0:日立ﾌﾞﾙｰﾁｯﾌﾟ接続仕様でない  1:日立ﾌﾞﾙｰﾁｯﾌﾟ接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_hitachi_bluechip_system()
  static Future<int> cmHitachiBluechipSystem() async {
    int res = 0;

    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ﾌﾞﾙｰﾁｯﾌﾟｻｰﾊﾞｰ接続仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HITACHI_BLUECHIP,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return (res == 1) ? 1 : 0;
  }

  /// ＨＣ(コメリ)仕様のフラグを返す
  /// 戻値：0:ＨＣ(コメリ)仕様でない  1:ＨＣ(コメリ)仕様
  /// 関連tprxソース:cm_cksys.c - cm_hc1_komeri_system()
  static Future<int> cmHc1KomeriSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ＨＣ(コメリ)仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HC1_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 顧客リアル[Webサービス]仕様のフラグを返す。
  /// 戻値：0:顧客リアル[Webサービス]仕様ではない 1:顧客リアル[Webサービス]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_webser_system()
  static Future<int> cmCustrealWebserSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 顧客リアル[Webサービス]仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_WEBSER,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0)) ? 1 : 0;
  }

  /// Wiz精算仕様のフラグを返す
  /// 戻値：0:Wiz精算仕様でない 1:Wiz精算仕様
  /// 関連tprxソース:cm_cksys.c - cm_wiz_abj_system()
  static Future<int> cmWizAbjSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_WIZ_ABJ,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  /// 顧客リアル[UID]仕様のフラグを返す
  /// 戻値：0:顧客リアル[UID]仕様ではない 1:顧客リアル[UID]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_uid_system()
  static Future<int> cmCustrealUidSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 顧客リアル[UID]仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_UID,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0)) ? 1 : 0;
  }

  /// 棒金ドロア接続仕様のフラグを返す
  /// 戻値：0:棒金ドロア接続仕様ではない 1:棒金ドロア接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_acx_chgdrw_cnct()
  static Future<int> cmAcxChgdrwCnct() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 棒金ドロア接続仕様チェック */
    return((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_ACR_CNCT) == 2) &&
        ((((AcxCom.ifAcbSelect() != 0) & (CoinChanger.ACB_50_X != 0)) &&
            (pCom.iniMacInfo.acx_flg.acb50_ssw13_0 == 1)) ||
            (((AcxCom.ifAcbSelect() != 0) & (CoinChanger.ECS_X != 0)) &&
                (pCom.iniMacInfo.acx_flg.ecs_gpd_2_2 == 1 ))))? 1 : 0;
  }

  /// 棒金ドロア拡張設定仕様のフラグを返す
  /// 戻値：0:棒金ドロア拡張設定仕様ではない 1:棒金ドロア拡張設定仕様
  /// 関連tprxソース:cm_cksys.c - cm_acx_chgdrw_system()
  static Future<int> cmAcxChgdrwSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 棒金ドロア接続仕様チェック && 棒金ドロア拡張設定仕様チェック */
    return ((await cmAcxChgdrwCnct() != 0) &&
        ((((AcxCom.ifAcbSelect() != 0) & (CoinChanger.ACB_50_X != 0)) &&
            (pCom.iniMacInfo.acx_flg.acb50_ssw13_3_4 == 0)) ||
            (((AcxCom.ifAcbSelect() != 0) & (CoinChanger.ECS_X != 0)) &&
                (pCom.iniMacInfo.acx_flg.ecs_gpd_3_1 == 0))))? 1 : 0;
  }

  /// 松源様仕様のフラグを返す
  /// 戻値：0:松源様仕様ではない 1:松源様仕様
  /// 関連tprxソース:cm_cksys.c - cm_matugen_system()
  static int cmMatugenSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbTrm.matsugenMagcard);
  }

  /// IKEA仕様のタイプを返す。
  /// 戻値：0:IKEA仕様ではない  1:IKEA仕様
  /// 関連tprxソース:cm_cksys.c - cm_IKEA_system()
  static int cmIKEASystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.ikeaOpe != 0) {
      return 1;
    }
    return 0;
  }

  /// Jet-S A手順(標準) 仕様のフラグを返す
  /// 戻値：0:Jet-S A手順(標準)仕様ではない  1:Jet-S A手順(標準)仕様
  /// 関連tprxソース:cm_cksys.c - cm_JetAStandard_system()
  static int cmJetAStandardSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* Jet-S A手順(標準)仕様チェック */
    return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 10)? 1 : 0;
  }

  /// システム監視の可否判断
  /// 戻値：0:システム監視不可 (/etc/.syschkが存在しない)  1:システム監視可
  /// 関連tprxソース:cm_cksys.c - cm_syschk_system()
  static Future<int> cmSyschkSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (TprxPlatform.getFile('/etc/.syschk').existsSync()) {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_REMOTESERVER,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        res = 1;
      }
      return res;
    }
    return 0;
  }

  /// メインボード状態取得(lm_sensors)の可否判断
  /// 戻値：0:メインボード状態取得不可 (/etc/.hwmonitorが存在しない)  1:メインボード状態取得可
  /// 関連tprxソース:cm_cksys.c - cm_mbchk_system()
  static int cmMbchkSystem() {
    if (cmG3System() != 0) {
      return 1;
    }
    if (TprxPlatform.getFile('/etc/.hwmonitor').existsSync()) {
      return 1;
    }
    return 0;
  }

  /// HDD領域の拡張判断
  /// 戻値：0:HDD領域が拡張されていない (/etc/.extensionが存在しない)  1:HDD領域が拡張されている
  /// 関連tprxソース:cm_cksys.c - cm_hddext_system()
  static int cmHddextSystem() {
    if (TprxPlatform.getFile('/etc/.extension').existsSync()) {
      return 1;
    }
    return 0;
  }

  /// 顧客リアル[OP]仕様のフラグを返す
  /// 戻値：0:顧客リアル[OP]仕様ではない 1:顧客リアル[OP]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_op_system()
  static Future<int> cmCustrealOpSystem() async {
    int res1 = 0;
    int res2 = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_WEBSER,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    /* 顧客リアル[OP]仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_OP,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0)) ? 1 : 0;
  }

  /// 北欧トーキョー様仕様のフラグを返す
  /// 戻値：0:北欧トーキョー様仕様ではない 1:北欧トーキョー様仕様
  /// 関連tprxソース:cm_cksys.c - cm_hokuo_system()
  static Future<int> cmHokuoSystem() async {
    return (await cmCustrealOpSystem());
  }

  /// 内税商品の実績を内税込み扱いフラグを返す
  /// 戻値：0:する/ 1:しない
  /// 関連tprxソース:cm_cksys.c - cm_JA_Iwate_system()
  static int cmJAIwateSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbTrm.magCardTyp == 95) ? 1 : 0;
  }

  /// 生産者商品ｾﾞﾛﾌﾗｸﾞ仕様のフラグを返す
  /// 戻値：0:生産者商品ｾﾞﾛﾌﾗｸﾞ仕様しない 1:生産者商品ｾﾞﾛﾌﾗｸﾞ仕様する
  /// 関連tprxソース:cm_cksys.c - cm_prod_instore_zero_flg()
  static Future<int> cmProdInstoreZeroFlg() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PROD_INSTORE_ZERO_FLG, RecogTypes.RECOG_GETMEM)).result;
    if((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 現金管理機モードを返す
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_acx_control_mode()
  static Future<int> cmAcxControlMode() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if ((pCom.iniMacInfo.internal_flg.acb_deccin != 0) && //入金確定or自動確定
        (pCom.iniMacInfo.acx_flg.acb_control_mode != 0)) { //現金管理機モード
      return 1;
    }
    return 0;
  }

  /// 対面セルフシステムのフラグを返す
  /// 戻値：0:対面セルフシステムではない  1:対面セルフシステム
  /// 関連tprxソース:cm_cksys.c - cm_front_self_system()
  static Future<int> cmFrontSelfSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FRONT_SELF_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result;
    if((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }

    if (CompileFlag.SMART_SELF) {
      /* HappySelf仕様 || HappySelf仕様(SmileSelf用) */
      if (await cmHappySelfSystem() != 0) {
        return 1;
      }
    }
    return 0;
  }

  /// 対面セルフシステムのフラグを返す(iniファイルの方)
  /// 戻値：0:対面セルフシステムではない  1:対面セルフシステム
  /// 関連tprxソース:cm_cksys.c - cm_front_self_ini_system()
  static Future<int> cmFrontSelfIniSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FRONT_SELF_SYSTEM, RecogTypes.RECOG_GETSYS)).result;
    if((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }

    if (CompileFlag.SMART_SELF) {
      /* HappySelf仕様 || HappySelf仕様(SmileSelf用) */
      if (await cmHappySelfSystemMain(1) != 0) {
        return 1;
      }
    }
    return 0;
  }

  /// 客側会計スイッチ接続のフラグを返す
  /// 引数：chkTyp  0:表示ﾁｪｯｸ　1:設定ﾁｪｯｸ
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_custsw_cnct_system()
  static Future<int> cmCustswCnctSystem(int chkTyp) async {
    RecogTypes typ = RecogTypes.RECOG_GETMEM;
    if (chkTyp == 0) {
      typ = RecogTypes.RECOG_GETSYS;
    }
    if ((await cmSelfSystem2(typ) != 0) ||
        (await cmQCashierSystem2(typ) != 0) ||
        (await cmQickChgSystem2(typ) != 0) ||
        (CmCktWr.cm_chk_tower() != CmCktWr.TPR_TYPE_DESK)) {
      return 0;
    }
    if (chkTyp != 0) {
      /* 共有メモリポインタの取得 */
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf pCom = xRet.object;
      return (pCom.iniMacInfo.system.custsw_cnct);
    }
    return 1;
  }

  /// いちやまマート様仕様のフラグを返す。
  /// 戻値：0:いちやまマート様仕様ではない 1:いちやまマート様仕様
  /// 関連tprxソース:cm_cksys.c - cm_ichiyama_mart_system()
  static Future<int> cmIchiyamaMartSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmCheckMP1Print() != 0) {	/* MP1と共通フィールドの為、設定チェック */
      return 0;
    }
    return (pCom.dbTrm.magCardTyp == Mcd.OTHER_CO5) ? 1 : 0;
  }

  /// Teraoka プリカ仕様のフラグを返す
  /// 戻値：0:Teraoka プリカ仕様ではない  1:Teraoka プリカ仕様
  /// 関連tprxソース:cm_cksys.c - cm_trk_preca_system()
  static Future<int> cmTrkPrecaSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TRK_PRECA, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// Tポイント仕様のフラグを返す。
  /// 戻値：0:Tポイント仕様ではない  1:Tポイント仕様
  /// ※　V1のオリジナルコードも0固定返却となっている。
  /// 関連tprxソース:cm_cksys.c - cm_custreal_Tpoint_system()
  static int cmCustrealTpointSystem() {
    return 0;
  }

  /// Tポイント仕様のフラグを返す（12ver用）
  /// 戻値：0:Tポイント仕様ではない  1:Tポイント仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_Tpoint_system()
  static Future<int> cmCustrealTpointSystem12Ver() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmCheckMP1Print() != 0) {	/* MP1と共通フィールドの為、設定チェック */
      return 0;
    }

    /* Tポイント仕様チェック */
    bool res1 = false;
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_TPOINT, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES)
        || (status == RecogValue.RECOG_OK0893)) {
      res1 = true;
    }
    bool res2 = false;
    status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES)
        || (status == RecogValue.RECOG_OK0893)) {
      res2 = true;
    }

    if (res1 && res2) {
      return 1;
    }
    return 0;
  }

  /// 特定SM1仕様のフラグを返す
  /// 戻値：0:特定SM1仕様ではない  1:特定SM1仕様
  /// 関連tprxソース:cm_cksys.c - cm_mammy_mart_system()
  static Future<int> cmMammyMartSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定SM1仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MAMMY_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// 抽選券仕様がどうかのチェック
  /// 戻値：0:抽選券の仕様ではない　1:抽選券の仕様である
  /// 関連tprxソース:cm_cksys.c - cm_lottery_system()
  static Future<int> cmLotterySystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.lotteryOpeFlg != 0) {
      return 1;
    }
    return 0;
  }

  /// ゆめｶｰﾄﾞﾚｼﾞ直仕様のフラグを返す
  /// 戻値：0:ゆめｶｰﾄﾞﾚｼﾞ直仕様ではない  1:ゆめｶｰﾄﾞﾚｼﾞ直仕様
  /// 関連tprxソース:cm_cksys.c - cm_yumeca_pol_system()
  static Future<int> cmYumecaPolSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_YUMECA_POL_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// 顧客リアル[HPS]仕様のフラグを返す
  /// 戻値：0:顧客リアル[HPS]仕様ではない  1:顧客リアル[HPS]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_hps_system()
  static Future<int> cmCustrealHpsSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_HPS, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// 特定SM2仕様(マルト様)のフラグを返す。
  /// 戻値：0:特定SM2仕様ではない  1:特定SM2仕様
  /// 関連tprxソース:cm_cksys.c - cm_maruto_system()
  static Future<int> cmMarutoSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MARUTO_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// ＨＣ(アヤハディオ) のフラグを返す
  /// 戻り値: 0:ＨＣ(アヤハディオ)仕様ではない   1:ＨＣ(アヤハディオ)仕様である
  /// 関連tprxソース:cm_cksys.c - cm_hc3_ayaha_system()
  static Future<int> cmHc3AyahaSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_HC3_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 明細送信商品区分のフラグを返す
  /// 戻り値: 0:明細送信商品区分ではない  1:明細送信商品区分
  /// 関連tprxソース:cm_cksys.c - cm_itemtyp_send_system()
  static Future<int> cmItemtypSendSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 明細送信商品区分仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ITEMTYP_SEND, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 特定SM3仕様(マルイ様)のフラグを返す
  /// 戻り値: 0:特定SM3仕様ではない  1:特定SM3仕様
  /// 関連tprxソース:cm_cksys.c - cm_sm3_marui_system()
  static Future<int> cmSm3MaruiSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SM3_MARUI_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// キッチンプリンタ接続仕様のフラグを返す
  /// 戻り値: 0:キッチンプリンタ接続仕様ではない  1:キッチンプリンタ接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_Kitchen_print_system()
  static Future<int> cmKitchenPrintSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SUB_TICKET, RecogTypes.RECOG_GETMEM)).result;
    if ((status1 == RecogValue.RECOG_OK0893) || (status1 == RecogValue.RECOG_YES)) {
      return 0;
    }
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_KITCHEN_PRINT, RecogTypes.RECOG_GETMEM)).result;
    if ((status2 == RecogValue.RECOG_OK0893) || (status2 == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// USB IC-Card Reader接続かどうかを返す
  /// 戻り値: 0:対応していない   1:対応している
  /// 関連tprxソース:cm_cksys.c - cm_USBICCard_exist()
  static Future<int> cmUSBICCardExist() async {
    if (TprxPlatform.getDirectory(ICCARD_DEV_FILE).existsSync()) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_USBICCardChk()
  static Future<int> cmUSBICCardChk() async {
    if (!TprxPlatform.getDirectory(ICCARD_DEV_FILE).existsSync()) {
      return 0;
    }
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.iccardDevStat != 1) {
      return 0;
    }
    return 1;
  }

  /// 顧客リアル[Ｐアーティスト]接続方式を返す エラー時は、ＳＯＲＰを返す
  /// 戻り値: 0:ＳＯＲＰ  1:ＳＯＣＫＥＴ
  /// 関連tprxソース:cm_cksys.c - cm_pointartist_conect()
  static Future<int> cmPointartistConect() async {
    int conect = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (conect);
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmCustrealPointartistSystem() != 0) {
      conect = pCom.iniSysParam.paConectTyp;
      if (conect != 1) {
        conect = 0;
      }
    }
    return (conect);
  }

  /// CGCグループプリカ　CoGCa仕様のフラグを返す
  /// 戻り値: 0:CoGCa仕様ではない  1:CoGCa仕様
  /// 関連tprxソース:cm_cksys.c - cm_cogca_system()
  static Future<int> cmCogcaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_COGCA_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// パルコープおおさかカード忘れクーポン仕様チェックを返す
  /// 戻り値: 0:カード忘れクーポン仕様ではない  1:カード忘れクーポン仕様
  /// 関連tprxソース:cm_cksys.c - cm_palcoop_card_forgot_check()
  static Future<int> cmPalcoopCardForgotCheck() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* 特殊ｸｰﾎﾟﾝ券仕様チェック */
    if (await cmSpecialCouponSystem() == 0) {
      return 0;
    }
    /* ユーザーコードチェック */
    if (pCom.dbTrm.delShopbagVoiceSsps != 0) {
      return 1;
    }
    return 0;
  }

  /// 特定sm36仕様[サンプラザ]のフラグを返す
  /// 戻値：0:特定sm36仕様ではない  1:特定sm36仕様
  /// 関連tprxソース:cm_cksys.c - cm_sm36_sanpraza_system()
  static Future<int> cmSm36SanprazaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定sm36仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SM36_SANPRAZA_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// Verifone Edy複数支払ユーザーか判定する
  /// 戻値：0
  /// 関連tprxソース:cm_cksys.c - cm_Vesca_MulPayUser_chk()
  static Future<int> cmVescaMulPayUserChk() async {
    /* 金秀様(承認キーなしのため、チェック追加なし) */
    return (0);
  }

  /// 顧客リアル[PT]仕様のフラグを返す
  /// 戻値：0:顧客リアル[PT]仕様ではない  1:顧客リアル[PT]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_ptactix_system()
  static Future<int> cmCustrealPtactixSystem() async {
    int res1 = 0;
    int res2 = 0;
    RecogValue status;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 顧客リアル[PT]仕様チェック */
    status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_PTACTIX, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      res1 = 1;
    }
    status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0)) ? 1 : 0;
  }

  /// CCTコード払い決済仕様のフラグを返す
  /// 戻値：0:CCTコード払い決済仕様でない 1:CCTコード払い決済仕様
  /// 関連tprxソース:cm_cksys.c - cm_cct_codepay_system()
  static Future<int> cmCctCodepaySystem() async {
    if (await cmOnepaySystem() != 0)	{	 //Onepay仕様との併用不可
      return 0;
    }
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CCT_CODEPAY_SYSTEM, RecogTypes.RECOG_GETMEM )).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// 特定SM66仕様(フレスタ様)のフラグを返す
  /// 戻値：0:特定SM66仕様ではない 1:特定SM66仕様
  /// 関連tprxソース:cm_cksys.c - cm_sm66_fresta_system()
  static Future<int> cmSm66FrestaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定SM64仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SM66_FRESTA_SYSTEM, RecogTypes.RECOG_GETMEM )).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// プリペイド複数枚利用が有効か判断する
  /// 戻値：0:有効でない 1:有効
  /// 関連tprxソース:cm_cksys.c - cm_precacard_multi_use()
  static Future<int> cmPrecacardMultiUse() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    // 複数枚カード利用
    if (pCom.dbKfnc[FuncKey.KY_PRECA_IN.keyId].opt.precaIn.repicaMultiUseFlg == 0) {
      /* 複数枚カード利用：しない */
      return 0;
    }
    if (await cmAjsEmoneySystem() == 0) {  /* 電子マネーFIP仕様 */
      return 0;
    }
    return 1;
  }

  /// ＱＣａｓｈｉｅｒ仕様プリセット画面表示フラグを返す。
  /// 戻値：0:表示しない  1:表示する
  /// 関連tprxソース:cm_cksys.c - cm_PresetMkey_Show()
  static Future<int> cmPresetMkeyShow() async {
    if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
      return 0;
    }
    if ((await cmQCashierSystem2(RecogTypes.RECOG_GETMEM) != 0) ||
        (await cmSelfSystem2(RecogTypes.RECOG_GETMEM) != 0)) {
      return 1;
    }
    if (await cmFrontSelfSystem() != 0) {
      return 1;
    }
    return 0;
  }

  /// ＱＣａｓｈｉｅｒモードを返す
  /// 戻値：0:通常モード  1:QCashierモード
  /// 関連tprxソース:cm_cksys.c - cm_QCashier_Mode()
  static Future<int> cmQCashierMode() async {
    int mode;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    if (await cmQCashierSystem() == 0) {
      return 0;
    }
    /* 共有メモリポインタの取得 */
    if (xRet.isInvalid()) {
      Mac_infoJsonFile macInfo = pCom.iniMacInfo;
      await macInfo.load();
      mode = macInfo.select_self.qc_mode;
    } else {
      mode = pCom.iniMacInfo.select_self.qc_mode;
    }
    return mode;
  }

  /// 関連tprxソース:cm_cksys.c - cm_fbMovie_RegNoStart_Chk()
  static Future<int> cmFbMovieRegNoStartChk() async {
    if ((await cmQuickSelfSystem() == 0) &&
        (await cmQCashierMode() == 0) &&
        (await cmFrontSelfSystem() == 0) &&
        (await cmColorfip15Chk() == 0)) {
      return 1;
    }
    return 0;
  }

  /// セルフシステム仕様ではないかつセルフモードでないことを確認
  /// 戻値：0:セルフ仕様ではない  1:セルフ仕様
  /// 関連tprxソース:cm_cksys.c - cm_fbSelfMovie_RegNoStart_Chk()
  static Future<int> cmFbSelfMovieRegNoStartChk() async {
    int mode = 0;
    if (await cmQCashierSystem() == 0) {
      return 0;
    }
    /* 共有メモリポインタの取得 */
    late Mac_infoJsonFile macInfo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      macInfo = Mac_infoJsonFile();
      await macInfo.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      macInfo = pCom.iniMacInfo;
    }
    mode = macInfo.select_self.self_mode;

    if ((await cmSelfSystem() == 0) || (mode == 0)) {
      return 1;
    }
    return 0;
  }

  /// QCashierJC仕様のフラグを返す。
  /// 戻値：0:QCashierJC仕様ではない  1:QCashierJC仕様
  /// 関連tprxソース:cm_cksys.c - cm_QCashierJC_system()
  static int cmQCashierJCSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if ((pCom.iniSys.type.qcashier_system == RecogValue.RECOG_NO.iniStr) ||
        (pCom.iniSys.type.receipt_qr_system == RecogValue.RECOG_NO.iniStr)) {
      return 0;
    }
    if (CompileFlag.SMART_SELF) {
      if (pCom.iniSys.type.desktop_cashier_system != RecogValue.RECOG_NO.iniStr) {
        return 0;
      }
    }
    return (pCom.qcjcStat) ? 1 : 0;
  }

  /// QCashierJC仕様のフラグを返す
  /// 戻値：0:QCashierJC仕様ではない  1:QCashierJC仕様
  /// 関連tprxソース:cm_cksys.c - cm_QCashierJC_system_Recog_Only()
  static Future<int> cmQCashierJCSystemRecogOnly() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_QCASHIER_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO ) ||
        ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_RECEIPT_QR_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)) {
      return 0;
    }
    if (CompileFlag.SMART_SELF) {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        return 0;
      }
    }
    return 1;
  }

  /// Brain仕様のフラグを返す
  /// 戻値：0:Brain仕様ではない  1:Brain仕様
  /// 関連tprxソース:cm_cksys.c - cm_Brain_system()
  static Future<int> cmBrainSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_BRAIN_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      if (TprxPlatform.getDirectory('/home/digi').existsSync()) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  /// 関連tprxソース:cm_cksys.c - cm_QCJC_C_print_aid()
  static Future<int> cmQCJCCPrintAid(int tid) async {
    if (await cmDummyPrintMyself() != 0) {
      return Tpraid.TPRAID_DUMMY_PRN;
    }
    if (tid != Tpraid.TPRAID_PRN) {
      return tid;
    }
    switch (cmPrintCheck()) {
      case TprDidDef.TPRDIDRECEIPT4: return Tpraid.TPRAID_QCJC_C_PRN;
      case TprDidDef.TPRDIDRECEIPT5: return Tpraid.TPRAID_KITCHEN1_PRN;
      case TprDidDef.TPRDIDRECEIPT6: return Tpraid.TPRAID_KITCHEN2_PRN;
      default: return Tpraid.TPRAID_PRN;
    }
  }

  /// 関連tprxソース:cm_cksys.c - cm_QCJC_regs_check()
  static int cmQCJCRegsCheck() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (cmQCashierJCSystem() == 0) {
      return 0;
    }
    return pCom.qcjc_c; /* 0:登録モード以外 */
  }

  /// 2ndDriveの存在チェック フラグを返す
  /// 戻値：-1:2ndDriveが存在するがブロックデバイスでない
  ///      0:2ndDriveが存在しない
  ///      1:2ndDriveが存在する
  /// 関連tprxソース:cm_cksys.c - f()
  /// TODO 長田
  static int cm2ndDriveSystem() {
    // struct stat st; /* stat */ statは正常実行時0を戻す。異常の場合-1またはエラーコード
    //
    // memset(buf, 0x00, sizeof(buf));
    // snprintf(buf, sizeof(buf), "/dev/SecDrive");
    //
    // memset(&st, 0, sizeof(st));
    // if ( lstat( buf, &st ) != 0 ) { ファイルの状態を取得 st=ファイル状態の情報が格納される
    //   return 0;
    // } else {                    S_ISLNK:シンボリック・リンクに対してゼロ以外
    //   if(S_ISLNK(st.st_mode)) { st_mode:ファイルの種類とアクセス保護モード
    //   /* symbolic link */
    //     memset( tmpbuf, 0x00, sizeof(tmpbuf));
    //     if (readlink(buf, tmpbuf, sizeof(tmpbuf)) == -1) { 正常時戻り値0,エラーの場合-1
    //       return -1;
    //     } else {
    //       memset( tmpbuf2, 0x00, sizeof(tmpbuf2));
    //       snprintf(tmpbuf2, sizeof(tmpbuf2), "/dev/%s",tmpbuf);
    //
    //       memset( &st, 0, sizeof(st));
    //       if ( stat( tmpbuf2, &st ) != 0 ) {
    //         return -1;
    //       } else {
    //         if(S_ISBLK(st.st_mode)) {
    //           return 1;
    //         } else {
    //           return -1;
    //         }
    //       }
    //     }
    //   }
    //   return -1;
    // }
    return -1;
  }

  /// 2ndSSDの存在チェック フラグを返す
  /// 戻値：-1:2ndSSDが存在するがブロックデバイスでない
  ///      0:2ndSSDが存在しない
  ///      1:2ndSSDが存在する
  /// 関連tprxソース:cm_cksys.c - cm_2ndSSD_system()
  /// TODO 長田
  static int cm2ndSSDSystem() {
    return 0;
  }

  /// お会計券未精算画面の表示印字を変更する
  /// 戻値：0:変更しない  1:変更する
  /// 関連tprxソース:cm_cksys.c - cm_QCServer_ChaChk_Draw()
  static int cmQCServerChaChkDraw() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.ticketManegeSrvFunc != 0) {
      return 1;
    }
    return 0;
  }

  /// キャッシュリサイクル充当方法のタイプを返す
  /// 戻値：0:店内分散仕様  1:事務所一括仕様
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_calc_type()
  static int cmCashRecycleCalcType() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.allotMethod);
  }

  /// キャッシュマネジメント指示レシートのタイプを返す（戻値0固定）
  /// 戻値：0:入出金指示１枚  1:入金・出金指示毎複数枚
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_rcpt_type()
  static int cmCashRecycleRcptType() {
    return 0;
  }

  /// キャッシュマネジメント入出金指示印字内容を返す
  /// 戻値：0:レジ番号のみ  1:レジ番号+金額  2:レジ番号+金額+枚数
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_detail_print()
  static int cmCashRecycleDetailPrint() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.rcpPrn);
  }

  /// キャッシュマネジメント自動精算時、入金・回収連続処理内容を返す
  /// 戻値：0:する  1:しない
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_inout_sequence()
  static int cmCashRecycleInoutSequence() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbTrm.cashmgmtCinpickProc);
  }

  /// 残置回収方法
  /// 戻値：0:通常残置  1:硬貨優先残置  2:硬貨全残置（紙幣回収）
  ///     3:万券以外残置（万券回収）  4:全残置（カセット回収）  5:金種指定残置
  /// 関連tprxソース:cm_cksys.c - cm_acx_cpick_resv_method()
  static int cmAcxCpickResvMethod() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbTrm.behindPickTyp);
  }

  /// PiTaPa(PFM)仕様のフラグを返す
  /// 戻値：0:PiTaPa(PFM)仕様ではない 1:PiTaPa(PFM)仕様
  /// 関連tprxソース:cm_cksys.c - cm_PFM_PiTaPa_system()
  static Future<int> cmPFMPiTaPaSystem() async {
    if (CompileFlag.CENTOS) {
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_PFMPITAPASYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
        return(Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
            CnctLists.CNCT_MULTI_CNCT) == 4)? 1 : 0;
      }
    }
    return 0;
  }

  /// Web2200対応かどうか
  /// 戻値：0:Web2200ではない (/etc/5612_smhd.iniが存在しない) / 1:Web2200である
  /// 関連tprxソース:cm_cksys.c - cm_web2200_system()
  static int cmWeb2200System() {
    return TprxPlatform.getFile("/etc/5612_smhd.json").existsSync() ? 1 : 0;
  }

  /// Web2300対応かどうか
  /// 戻値：0:Web2300ではない (/etc/2300_smhd.iniが存在しない) / 1:Web2300である
  /// 関連tprxソース:cm_cksys.c - cm_web2300_system()
  static int cmWeb2300System() {
    return TprxPlatform.getFile("/etc/2300_smhd.json").existsSync() ? 1 : 0;
  }

  /// WebPlus対応かどうか
  /// 戻値：0:WebPlusではない (/etc/plus_smhd.iniが存在しない) / 1:WebPlusである
  /// 関連tprxソース:cm_cksys.c - cm_webplus_system()
  static int cmWebplusSystem() {
    return TprxPlatform.getFile("/etc/plus_smhd.json").existsSync() ? 1 : 0;
  }

  /// Web2300 CentOS対応かどうか
  /// 戻値：0:Web2300CentOSではない (/etc/2300_SentOS_smhd.iniが存在しない)
  ///      1:Web2300CentOSである
  /// 関連tprxソース:cm_cksys.c - cm_web2300_CentOS_system()
  static int cmWeb2300CentOSSystem() {
    return TprxPlatform.getFile("/etc/2300_CentOS_smhd.json").existsSync() ? 1: 0;
  }

  /// Web2800対応かどうか
  /// 戻値：0:Web2800ではない (/etc/2800_smhd.iniが存在しない) / 1:Web2800である
  /// 関連tprxソース:cm_cksys.c - cm_web2800_system()
  static int cmWeb2800System() {
    return TprxPlatform.getFile("/etc/2800_smhd.json").existsSync() ? 1 : 0;
  }

  /// Web2350対応(H/W:Web2300 OS:CentOS)かどうか
  /// 戻値：0:Web2350ではない (/etc/2350_smhd.iniが存在しない) / 1:Web2350である
  /// 関連tprxソース:cm_cksys.c - cm_web2350_system()
  static int cmWeb2350System() {
    return TprxPlatform.getFile("/etc/2350_smhd.json").existsSync() ? 1 : 0;
  }

  /// Web2500対応かどうか
  /// 戻値：0:Web2500ではない (/etc/2500_smhd.iniが存在しない) / 1:Web2500である
  /// 関連tprxソース:cm_cksys.c - cm_web2500_system()
  static int cmWeb2500System() {
    return TprxPlatform.getFile("/etc/2500_smhd.json").existsSync() ? 1 : 0;
  }

  /// WebPrimePlus2対応かどうか
  /// 戻値：0:WebPrimePlus2ではない (/etc/aaeon_atom_smhd.iniが存在しない)
  ///      1:WebPrimePlus2である
  /// 関連tprxソース:cm_cksys.c - cm_webplus2_system()
  static int cmWebplus2System() {
    return TprxPlatform.getFile("/etc/aaeon_atom_smhd.json").existsSync() ? 1: 0;
  }

  /// メインボードがVIA TRK-01 であるか
  /// 関連tprxソース:cm_cksys.c - cm_ViananoSmhdChk()
  /// 戻値：0: VIA TRK-01 でない  1: VIA TRK-01 である
  static int cmViananoSmhdChk() {
    return TprxPlatform.getFile("/etc/vianano_smhd.ini").existsSync() ? 1 : 0;
  }

  /// WebPrime3対応かどうか
  /// 戻値：0:WebPrime3ではない (/etc/prime3_smhd.iniが存在しない) / 1:WebPrime3である
  /// 関連tprxソース:cm_cksys.c - cm_webprime3_system()
  static int cmWebprime3System() {
    return TprxPlatform.getFile("/etc/prime3_smhd.json").existsSync() ? 1 : 0;
  }

  /// Web3800対応かどうか
  /// 戻値：0:Web3800ではない (/etc/3800_smhd.iniが存在しない) / 1:Web3800である
  /// 関連tprxソース:cm_cksys.c - cm_web3800_system()
  static int cmWeb3800System() {
    return TprxPlatform.getFile("/etc/3800_smhd.json").existsSync() ? 1 : 0;
  }

  /// G3対応かどうか
  /// 引数:なし
  /// 戻り値：1: G3対応である、 0: G3対応でない
  /// 関連tprxソース:cm_cksys.c - cm_G3_system()
  static int cmG3System() {
    return TprxPlatform.getFile("/etc/XX5_smhd.json").existsSync() ? 1 : 0;
  }

  /// TRK05対応かどうか
  /// 引数:なし
  /// 戻り値：1: TRK05対応である、 0: TRK05対応でない
  /// 関連tprxソース:cm_cksys.c - cm_TRK05_system()
  static int cmTRK05System() {
    return TprxPlatform.getFile("/etc/TRK05_smhd.json").existsSync() ? 1 : 0;
  }

  /// TRK04対応かどうか
  /// 引数:なし
  /// 戻り値：1: TRK04対応である、 0: TRK04対応でない
  /// 関連tprxソース:cm_cksys.c - cm_TRK04_system()
  static int cmTRK04System() {
    return TprxPlatform.getFile("/etc/TRK04_smhd.json").existsSync() ? 1 : 0;
  }

  ///  関数： cmChkVerticalFHDSystem(void)
  ///  機能： 縦型21.5インチPOS対応のフラグを返す
  ///  引数： なし
  ///  戻値： 0:縦型21.5インチPOSではない / 1:縦型21.5インチPOSである
  /// 関連tprxソース:cm_cksys.c - cm_chk_vertical_FHD_system()
  static int cmChkVerticalFHDSystem() {
    return (cmChkVerticalFHDSystemMain(false));
  }

  /// 縦型21.5インチPOS対応かどうか
  /// 戻値：0:縦型21.5インチPOSではない / 1:縦型21.5インチPOSである
  /// 関連tprxソース:cm_cksys.c - cm_chk_vertical_FHD_system_main()
  static int cmChkVerticalFHDSystemMain(bool isSetMem) {
    // 共有メモリの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (isSetMem) {
      if (cmWeb2800System() != 0 &&
          TprxPlatform.getFile("/etc/vFHD_smhd.json").existsSync()) {
        pCom.vtclFhdFlg = true;
        return 1;
      }
    } else {
      return pCom.vtclFhdFlg ? 1 : 0;
    }
    return 0;
  }

  /// 縦型15.6インチ対面POS対応かどうか
  /// 戻値：0:縦型15.6インチ対面POSではない / 1:縦型15.6インチ対面POSである
  /// 関連tprxソース:cm_cksys.c - cm_chk_vtcl_FHD_fself_system()
  static int cmChkVtclFHDFselfSystem() {
    return (cmChkVtclFHDFselfSystemMain(false));
  }

  /// 縦型15.6インチ対面POS対応かどうか
  /// 戻値：0:縦型15.6インチ対面POSではない / 1:縦型15.6インチ対面POSである
  /// 関連tprxソース:cm_cksys.c - cm_chk_vtcl_FHD_fself_system_main()
  static int cmChkVtclFHDFselfSystemMain(bool isSetMem) {
    // 共有メモリの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (isSetMem) {
      // 縦型15.6インチ対面機種判断用のファイルがアクセス可能かチェック
      if (cmWeb2800System() != 0 &&
          TprxPlatform.getFile("/etc/vFHD_fself_smhd.json").existsSync()) {
        pCom.vtclFhdFselfFlg = true;
        return 1;
      }
    } else {
      return pCom.vtclFhdFselfFlg ? 1 : 0;
    }
    return 0;
  }

  /// CT-3100ポイント仕様のフラグを返す
  /// 戻値：0:CT-3100ポイント仕様ではない  1:CT-3100ポイント仕様
  /// 関連tprxソース:cm_cksys.c - cm_CT3100_Point_system()
  static Future<int> cmCT3100PointSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* CT-3100ポイント仕様チェック */
    if ((await cmCATpointSystem() != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 7)) {
      return 1;
    }
    return 0;
  }

  /// GS1バーコード仕様のフラグを返す
  /// 戻値：0:GS1バーコード仕様ではない  1:GS1バーコード仕様
  /// 関連tprxソース:cm_cksys.c - cm_GS1_Barcode_system()
  static Future<int> cmGS1BarcodeSystem() async {
    int res = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* GS1バーコード仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_GS1_BARCODE,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  /// 詰合仕様のフラグを返す
  /// 戻値：0:詰合仕様ではない  1:詰合仕様
  /// 関連tprxソース:cm_cksys.c - cm_Assort_system()
  static Future<int> cmAssortSystem() async {
    int res = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 詰合仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ASSORTSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  /// 縦旅券読取内蔵免税仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:旅券読取内蔵免税仕様でない 1:旅券読取内蔵免税仕様
  /// 関連tprxソース:cm_cksys.c - cm_taxfree_passportinfo_system()
  static Future<int> cmTaxfreePassportinfoSystem() async {
    /* WEB2800系のみ有効 */
    if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result;

    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// RM-5900対応かどうか
  /// 戻値：0:RM-5900ではない 1:RM-5900
  /// 関連tprxソース:cm_cksys.c - cm_rm5900_system()
  static int cmRm5900System() {
    return TprxPlatform.getFile(PATH_RM5900).existsSync() ? 1 : 0;
  }

  /// RM-5900対応かどうか
  /// 戻値：0:RM-5900ではない 1:RM-5900
  /// 関連tprxソース:cm_cksys.c - cm_chk_vertical_rm5900_system_main()
  static int cmChkVerticalRm5900SystemMain(bool isSetMem) {
    // 共有メモリの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      if (cmRm5900System() != 0) {
        return 1;
      }
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (isSetMem) {
      // 設定ファイルを確認して、共有メモリに保存する.
      bool isRm5900 = cmRm5900System() > 0 ? true : false;
      pCom.vtclRm5900Flg = isRm5900;
      return isRm5900 ? 1 : 0;
    }
    // 共有メモリから取得する.
    return pCom.vtclFhdFselfFlg ? 1 : 0;
  }

  /// WEB2100 Daul-Display のタイプのフラグを返す
  /// 引数：なし
  /// 戻値：0:WEB2100 Dual ではない  1:WEB2100 Dual タイプ  2:WEB2100 Dual Tower タイプ
  /// 関連tprxソース:cm_cksys.c - cm_fb_dual_system()
  static int cmFbDualSystem() {
    if (CompileFlag.FB2GTK == true) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf pCom = xRet.object;
      if ((pCom != null) && (pCom.dual != null)) {
        return (pCom.dual!);
      }
    }
    return 0;
  }

  /// PastelPort プリカ仕様のフラグを返す
  /// 戻値：0:PastelPort プリカ仕様ではない  1:PastelPort プリカ仕様
  /// 関連tprxソース:cm_cksys.c - cm_nttd_preca_system()
  static Future<int> cmNttdPrecaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* PastelPort プリカ仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_NTTD_PRECA,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 関数：cmUsbCamSystem(void)
  /// 機能：USBカメラ接続かどうかを返す
  /// 引数：なし
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_UsbCam_system(), cm_Usbcam_Cnct()
  static Future<int> cmUsbCamSystem() async {
    int res = 0;

    if (!Directory(USBCAM_DIR).existsSync()) {
      return 0;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      if (RecogValue.RECOG_NO !=
          (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
              RecogLists.RECOG_USBCAM_CNCT, RecogTypes.RECOG_GETMEM)).result) {
        res = 1;
      }
      return (res);
    }

    if (RecogValue.RECOG_NO !=
        (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_USBCAM_CNCT, RecogTypes.RECOG_GETSYS)).result) {
      res = 1;
    }
    return (res);
  }

  static Future<int> cmUsbcamCnct() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if ((await cmUsbCamSystem() == 1) &&
        (pCom.iniMacInfo.internal_flg.usbcam_cnct == 1)) {
      // cnct_mem_get(TPRAID_SYSTEM, CNCT_USBCAM_CNCT)
      return 1;
    }
    return 0;
  }

  /// 特定ドラッグストア(コスモス薬局様)仕様かどうかを返す
  /// 戻値：0:特定ドラッグストア仕様ではない  1:特定ドラッグストア仕様
  /// 関連tprxソース:cm_cksys.c - cm_DrugStore_system()
  static Future<int> cmDrugStoreSystem() async {
    int res = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_DRUGSTORE,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        res = 1;
      }
      return (res);
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DRUGSTORE,
        RecogTypes.RECOG_GETSYS)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 関数：cmPluralQRSystem(void)
  /// 機能：複数ＱＲコードリード仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:複数ＱＲコードリード仕様ではない  1:複数ＱＲコードリード仕様
  /// 関連tprxソース:cm_cksys.c - cm_plural_QR_system()
  static Future<int> cmPluralQRSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PLURALQR_SYSTEM, RecogTypes.RECOG_GETMEM);
    if (status.result != RecogValue.RECOG_NO) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmChk2PersonSystem(void)
  /// 機能：簡易従業員又は、カスミの２人制キー可能かを返す
  /// 引数：なし
  /// 戻値：0:簡易従業員でない 1:簡易従業員１人制 2:簡易従業員２人制
  /// 関連tprxソース:cm_cksys.c - cm_Chk_2Person_system()
  static Future<int> cmChk2PersonSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.frcClkFlg == 0) {
      if (await cmChkKasumi2Person() != 0) {
        /* カスミの２人制キー可能か？ */
        return 2; /* 簡易従業員２人制とする */
      }
    }
    return (pCom.dbTrm.frcClkFlg);
  }

  ///関数：cmChkKasumi2Person(void)
  ///機能：カスミの２人制キーが可能かを返す
  ///引数：なし
  ///戻値：0:２人制キー可能でない 1:２人制可能
  /// 関連tprxソース:cm_cksys.c - cm_Chk_kasumi_2Person()
  static Future<int> cmChkKasumi2Person() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* カスミ様:オープン／クローズ画面の登録、訂正、訓練、廃棄、（発注、棚卸、生産）ボタンの間隔をあける。*/
    if (pCom.dbTrm.frcClkFlg == 0) {
      if (pCom.dbTrm.chgButtonAreaOpenclose != 0) {
        if ((await cmSqrcTicketSystem() == 1) &&
            (pCom.iniMacInfo.select_self.self_mode == 1)) {
          /* SQRC System */
          return 0;
        }
        if (CompileFlag.SMART_SELF == true) {
          if (await cmHappySelfSystem() != 0) {
            /* HappySelf System */
            return 0;
          }
        }
        RecogRetData status1 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_SELF_GATE, RecogTypes.RECOG_GETMEM);
        RecogRetData status2 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_SELF_GATE, RecogTypes.RECOG_GETMEM);

        if ((status1.result ==
            RecogValue.RECOG_NO) || /* セルフが未承認 */ /* 2010/11/25 */
            ((status2.result != RecogValue.RECOG_NO) &&
                (pCom.iniMacInfo.select_self.self_mode == 0))) {
          /* セルフ仕様でも、通常状態 */ /* 2010/11/25 */
          return 1; /* ２人制キー可能とする */
        }
      }
    }
    return 0;
  }

  /// 機能：ｎｅｔＤｏＡ予約仕様かを返す
  /// 戻値：0:ｎｅｔＤｏＡ予約仕様でない  1:ｎｅｔＤｏＡ予約仕様
  /// 関連tprxソース:cm_cksys.c - cm_netDoAreserv_system()
  static Future<int> cmNetDoAreservSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_NETDOARESERV,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 機能：個別精算仕様かを返す
  /// 戻値：0:個別精算仕様でない 1:個別精算仕様
  /// 関連tprxソース:cm_cksys.c - cm_selpluadj_system()
  static Future<int> cmSelpluadjSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SELPLUADJ,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 機能：アイユー様仕様のフラグを返す
  /// 戻値：0:アイユー仕様ではない  1:アイユー仕様
  /// 関連tprxソース:cm_cksys.c - cm_MoriyaMember_system()
  static Future<int> cmMoriyaMemberSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* アイユー仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MRYCARDSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0)) ? 1 : 0;
  }

  /// 関数：cmSqrcTicketSystem(void)
  /// 機能：SQRCﾁｹｯﾄ発券ｼｽﾃﾑのフラグを返す
  /// 引数：なし
  /// 戻値：0:SQRCﾁｹｯﾄ発券ｼｽﾃﾑ仕様でない 1:SQRCﾁｹｯﾄ発券ｼｽﾃﾑ仕様
  /// 関連tprxソース:cm_cksys.c - cm_sqrc_ticket_system()
  static Future<int> cmSqrcTicketSystem() async {
    int web_type = await CmCksys.cmWebType();
    if (web_type != CmSys.WEBTYPE_WEB2800) {
      return 0;
    }
    // cnct_mem_get：共有メモリ更新
    // if(!(cnct_mem_get(TPRAID_SYSTEM, CNCT_SQRC_CNCT))) {
    //   return 0; // SQRCチケット発券サーバー接続 しない
    // }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SQRC_TICKET_SYSTEM, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// CCT端末連動仕様のフラグを返す
  /// 戻値：0:CCT端末連動仕様でない 1:CCT端末連動仕様
  /// 関連tprxソース:cm_cksys.c - cm_cct_connect_system()
  static Future<int> cmCctConnectSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CCT_CONNECT_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 機能：CCT端末 電子マネー決済仕様のフラグを返す
  /// 戻値：0:電子マネー決済仕様でない 1:電子決済マネー仕様
  /// 関連tprxソース:cm_cksys.c - cm_cct_emoney_system()
  static Future<int> cmCctEmoneySystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CCT_EMONEY_SYSTEM, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// TEC製 INFOX/JET-S端末接続仕様のフラグを返す
  /// 戻値：0:TEC製 INFOX/JET-S端末接続仕様でない 1:TEC製 INFOX/JET-S端末接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_tec_infox_jet_s_system()
  static Future<int> cmTecInfoxJetSSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TEC_INFOX_JET_S_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// キャッシュマネジメント常時入出金指示レシート発行を返す
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_oftenshow()
  static Future<int> cmCashRecycleOftenshow() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if(Cnct.cnctMemGet(0, CnctLists.CNCT_ACR_CNCT) == 0) {  /* 釣機接続*/
      return 0;
    }
    return (pCom.dbCashrecycle.btnOftenShow);
  }

  /// 関数：cmPaymentMngSystem(void)
  /// 機能：支払機ﾏﾈｰｼﾞｬ接続仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:支払機ﾏﾈｰｼﾞｬ接続仕様ではない  1:支払機ﾏﾈｰｼﾞｬ接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_payment_mng_system()
  static Future<int> cmPaymentMngSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PAYMENT_MNG, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// QCashierにEdyの承認キーが有効化のチェック
  /// Sppeza側にEdy端末が接続されている場合のQCashier（現在SIPとFAPとVEGA3000のみ対応）
  /// 戻値：0:QCashierにEdyの承認キーが有効ではない  1:QCashierにEdyの承認キーが有効
  /// 関連tprxソース:cm_cksys.c - cm_QC_SpEdy_system()
  static Future<int> cmQCSpEdySystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await cmQCashierSystem() == 0) && (await cmReceiptQrSystem() == 0)) {
      return 0;
    }
    /* Edy(SIP)仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_EDYSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    /* Edy(FCL)仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FCLEDYSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    /* Edy(VEGA3000電子マネー)仕様チェック */
    if (await cmMultiVegaRecog() != 0) {
      return 1;
    }
    return 0;
  }

  /// 関数：cmRepicaSystem(void)
  /// 機能：レピカ社 point+plus仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:レピカ仕様ではない  1:レピカ仕様
  /// 関連tprxソース:cm_cksys.c - cm_repica_system()
  static Future<int> cmRepicaSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_REPICA_SYSTEM, RecogTypes.RECOG_GETMEM);
    if ((status.result == RecogValue.RECOG_OK0893) ||
        (status.result == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 関数：cmRepicaStdCodeSystem(void)
  /// 機能：レピカ仕様標準のバーコードとQRコードの利用が有効か判断する
  /// 引数：なし
  /// 戻値：0:有効でない 1:有効
  /// 関連tprxソース:cm_cksys.c - cm_repica_std_code_system()
  static Future<int> cmRepicaStdCodeSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbKfnc[FuncKey.KY_PRECA_IN.keyId].opt.precaIn.cardReadKind != 6) {
      /* レピカ標準バーコードではない */
      return (0);
    }
    if (await cmRepicaSystem() == 0) {
      /* レピカ仕様 */
      return (0);
    }
    return (1);
  }

  /// レピカ仕様で自家型プリペイドrabbica可能か
  /// 戻値：0:不可  1:可能
  /// 関連tprxソース:cm_cksys.c - cm_rabbica_system()
  static Future<int> cmRabbicaSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_REPICA_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      RepicaJsonFile repicaJson = RepicaJsonFile();
      await repicaJson.load();
      if (repicaJson.normal.validFlg == 1) {
        return 1;
      }
    }
    return 0;
  }

  /// レピカ仕様で第三者型プリペイドcocona可能か
  /// 戻値：0:不可  1:可能
  /// 関連tprxソース:cm_cksys.c - cm_cocona_system()
  static Future<int> cmCoconaSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_REPICA_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      RepicaJsonFile repicaJson = RepicaJsonFile();
      await repicaJson.load();
      if (repicaJson.cocona.validFlg_cocona == 1) {
        return 1;
      }
    }
    return 0;
  }

  /// 関数：cmHappySelfSystem(void)
  /// 機能：HappySelf仕様か否かを返す
  /// 承認キー:HappySelf仕様 又は HappySelf[Smile用]のどちらかが立っているか
  /// 引数：なし
  /// 戻値：0:HappySelf仕様ではない  1:HappySelf仕様である
  /// 関連tprxソース:cm_cksys.c - cm_happySelf_system()
  static Future<int> cmHappySelfSystem() async {
    return (await cmHappySelfSystemMain(0));
  }

  static Future<int> cmHappySelfSystemMain(int sys) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (sys == 0) {
      if (pCom == null) {
        return 0;
      }
      /* WEB2800系のみ有効 */
      if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
        return 0;
      }
      /* DESKTOPタイプ機器 */
      if (CmCktWr.cm_chk_tower() != CmCktWr.TPR_TYPE_DESK) {
        return 0;
      }
      /* DUALではないこと */
      if (cmFbDualSystem() != 0) {
        return 0;
      }
      // /* HappySelf仕様 || HappySelf仕様(SmileSelf用) */
      RecogRetData rret1 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETMEM);
      RecogRetData rret2 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM, RecogTypes.RECOG_GETMEM);
      if ((rret1.result != RecogValue.RECOG_NO) ||
          (rret2.result != RecogValue.RECOG_NO)) {
        return 1;
      } else {
        /* WEB2800系のみ有効 */
        if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
          return 0;
        }

        if (pCom.iniSys.type.tower == "no") {
          return 0;
        }

        /* HappySelf仕様 || HappySelf仕様(SmileSelf用) */
        RecogRetData rret3 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETSYS);
        RecogRetData rret4 = await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM, RecogTypes.RECOG_GETSYS);

        if ((rret3.result != RecogValue.RECOG_NO) ||
            (rret4.result != RecogValue.RECOG_NO)) {
          return 1;
        }
      }
    }
    return 0;
  }

  /// 関数：cmHappySelfAllSystem(void)
  /// 機能：HappySelf仕様か否かを返す
  /// 承認キー:HappySelf仕様(スマイル/フル/セミの全てのセルフが使用可)が立ってるか
  /// 引数：なし
  /// 戻値：0:HappySelf仕様ではない  1:HappySelf仕様である
  /// 関連tprxソース:cm_cksys.c - cm_happySelf_all_system()
  static Future<int> cmHappySelfAllSystem() async {
    return (await cmHappySelfAllSystemMain(0));
  }

  static Future<int> cmHappySelfAllSystemMain(int sys) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (sys == 0) {
      /* 共有メモリポインタの取得 */
      if (pCom == null) {
        return 0;
      }
      /* WEB2800系のみ有効 */
      if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
        return 0;
      }
      /* DESKTOPタイプ機器 */
      if (CmCktWr.cm_chk_tower() != CmCktWr.TPR_TYPE_DESK) {
        return 0;
      }
      /* DUALではないこと */
      if (cmFbDualSystem() != 0) {
        return 0;
      }
      /* HappySelf仕様 */
      if (RecogValue.RECOG_NO !=
          (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
              RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETMEM))
              .result) {
        return 1;
      }
    } else {
      /* WEB2800系のみ有効 */
      if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
        return 0;
      }
      if (pCom.iniSys.type.tower == "no") {
        return 0;
      }
      /* HappySelf仕様 */
      if (RecogValue.RECOG_NO !=
          (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
              RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETSYS))
              .result) {
        return 1;
      }
    }
    return 0;
  }

  /// 関数：cmHappySelfSmileSystem(void)
  /// 機能：HappySelf仕様[SmileSelf用]か否かを返す
  /// 承認キー:HappySelf仕様[Smile用](15インチLCDのスマイルセルフのみ使用可)が立ってるか
  /// 引数：なし
  /// 戻値：0:HappySelf仕様ではない  1:HappySelf仕様である
  /// 関連tprxソース:cm_cksys.c - cm_happySelf_smile_system()
  /// 関連tprxソース:cm_cksys.c - cm_happySelf_smile_system_main()
  static Future<int> cmHappySelfSmileSystem() async {
    return (await cmHappySelfSmileSystemMain(0));
  }

  static Future<int> cmHappySelfSmileSystemMain(int sys) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (sys == 0) {
      /* 共有メモリポインタの取得 */
      if (pCom == null) {
        return 0;
      }
      /* WEB2800系のみ有効 */
      if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
        return 0;
      }
      /* DESKTOPタイプ機器 */
      if (CmCktWr.cm_chk_tower() != CmCktWr.TPR_TYPE_DESK) {
        return 0;
      }
      /* DUALではないこと */
      if (cmFbDualSystem() != 0) {
        return 0;
      }
      /* HappySelf仕様[SmileSelf用] */
      if (RecogValue.RECOG_YES ==
          (await Recog().recogGet(
              Tpraid.TPRAID_SYSTEM,
              RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM,
              RecogTypes.RECOG_GETMEM))
              .result) {
        return 1;
      }
    } else {
      /* WEB2800系のみ有効 */
      if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
        return 0;
      }
      if (pCom.iniSys.type.tower == "no") {
        return 0;
      }
      /* HappySelf仕様[SmileSelf用] */
      if (RecogValue.RECOG_NO !=
          (await Recog().recogGet(
              Tpraid.TPRAID_SYSTEM,
              RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM,
              RecogTypes.RECOG_GETSYS))
              .result) {
        return 1;
      }
    }
    return 0;
  }

  /// 15インチカラー客表接続仕様のフラグを返す
  /// 戻値：0:15インチカラー客表接続仕様ではない 1:15インチカラー客表接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_colorfip15_chk()
  /// 関連tprxソース:cm_cksys.c - cm_colorfip15_chk_main()
  static Future<int> cmColorfip15Chk() async {
    return (await cmColorfip15ChkMain(0));
  }

  static Future<int> cmColorfip15ChkMain(int sys) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (sys == 0) {
      /* 共有メモリポインタの取得 */
      if (pCom == null) {
        return 0;
      }
      if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_COLORDSP_CNCT) != 1) {
        return 0;
      }

      if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_COLORDSP_SIZE) != 1) {
        return 0;
      }
      if (CompileFlag.SMART_SELF) {
        if (await cmHappySelfSystem() != 0) {
          return 0;
        }
      }
      return 1;
    } else { // sys!=0
      /* WEB2800系のみ有効 */
      if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
        return 0;
      }

      SysJsonFile sysIni = pCom.iniSys;
      String text = sysIni.type.tower;
      if (text.compareTo("no") != 0) {
        return 0;
      }
      var (bool ret1, int typ1) = await Cnct.cnctSysGet(Tpraid.TPRAID_SYSTEM,
          CnctLists.CNCT_COLORDSP_CNCT);
      if (!ret1) {
        return 0;
      }
      if (typ1 != 1) {
        return 0;
      }
      var (bool ret2, int typ2) = await Cnct.cnctSysGet(Tpraid.TPRAID_SYSTEM,
          CnctLists.CNCT_COLORDSP_SIZE);
      if (!ret2) {
        return 0;
      }
      if (typ2 != 1) {
        return 0;
      }
      if (CompileFlag.SMART_SELF) {
        if (await cmHappySelfSystemMain(1) != 0) {
          return 0;
        }
      }
      return 1;
    }
  }

  /// 関数：cmAiboxAlignmentSystem(void)
  /// 機能：
  /// 引数：なし
  /// 戻値：0:使用しない 1:使用する
  /// 関連tprxソース:cm_cksys.c - cm_aibox_alignment_system()

  /// EE社のAIBOX(空振り検知AI連携) 仕様のフラグを返す
  /// 関連tprxソース:cm_cksys.c - cmAiboxAlignmentSystem()
  // 引数：なし
  // 戻値：0:使用しない 1:使用する
  static Future<int> cmAiboxAlignmentSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_AIBOX_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// AIBOX関連設定値チェック
  /// 関連tprxソース:cm_cksys.c - cmAiboxSystem()
  /// 戻値：0:使用しない 1:使用する -1:AIBOX通信異常
  static Future<int> cmAiboxSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    /* AIBOX連携仕様が有効か? */
    if (await cmAiboxAlignmentSystem() == 0) {
      // 未使用
      return (0);
    }

    /* HappySelfの承認キーが立っている時対象 */
    if (await cmHappySelfSystem() == 1) {
      /* USBカメラ接続か否か */
      if (await cmUsbCamSystem() == 1) {
        /* AIBOXの状態 */
        if (tsBuf.aibox.state == 0) {
          if (cmAiboxMode() == -1) {
            /* エラー */
            return (-1);
          }
          /* AIBOX学習モード(情報送信を行う) */
          else if ((cmAiboxMode() == 2) || (cmAiboxMode() == 3)) {
            return (1);
          }
          /* AIBOX通信しない */
          else {
            return (0);
          }
        } else if (tsBuf.aibox.state == 1) {
          return (1);
        } else if (tsBuf.aibox.state == -1) {
          return (-1);
        }
      }
    }
    return (0);
  }

  /// AIBOX動作モードチェック
  /// 関連tprxソース:cm_cksys.c - cm_aibox_system()
  static int cmAiboxMode() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return pCom.iniMacInfo.select_self.aibox_select_mode;
  }

  /// 関数：cmMultiOnepaySystem(void)
  /// 機能：Onepay複数ブランド仕様を返す
  /// 引数：なし
  /// 戻値：0:Onepay複数ブランド仕様ではない 1:Onepay複数ブランド仕様
  /// 関連tprxソース:cm_cksys.c - cm_multi_onepay_system()
  static Future<int> cmMultiOnepaySystem() async {
    if ((await cmBarcodePay1System() != 0) ||
        (await cmCanalPaymentServiceSystem() != 0) ||
        (await cmFujitsuFipCodepaySystem() != 0)) {
      return (0);
    }
    /* Onepay複数ブランド仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MULTI_ONEPAYSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmShopAndGoSystem(void)
  /// 機能：Sho&Go仕様が有効かのチェック
  /// 引数：なし
  /// 戻値：0:無効 1:有効
  /// 間連tprxソース:cm_cksys.c - cm_Shop_and_Go_system()
  static Future<int> cmShopAndGoSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SHOP_AND_GO_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmSp1QrReadSystem(void)
  /// 機能：特定QR読込1仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:特定QR読込1仕様ではない  1:特定QR読込1仕様
  /// 関連tprxソース:cm_cksys.c - cm_sp1_qr_read_system()
  static Future<int> cmSp1QrReadSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SP1_QR_READ_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmOnepaySystem(void)
  /// 機能：Onepay仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Alipay仕様しない 1:Alipay仕様する
  /// 関連tprxソース:cm_cksys.c - cm_onepay_system()
  static Future<int> cmOnepaySystem() async {
    //return 1;
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ONEPAYSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    if (await cmMultiOnepaySystem() != 0) {
      return (2);
    }
    return (0);
  }

  /// 関数：cmCanalPaymentServiceSystem(void)
  /// 機能：ｺｰﾄﾞ決済[CANALPay]仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:ｺｰﾄﾞ決済[CANALPay]仕様ではない 1:ｺｰﾄﾞ決済[CANALPay]仕様
  /// 関連tprxソース:cm_cksys.c - cm_canal_payment_service_system()
  static Future<int> cmCanalPaymentServiceSystem() async {
    if (await cmBarcodePay1System() == 1) {
      // JPQRバーコード決済仕様との併用不可
      return (0);
    }
    RecogValue status = (await Recog().recogGet(
        Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CANAL_PAYMENT_SERVICE_SYSTEM,
        RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmLinePaySystem(void)
  /// 機能：LINE Pay仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:LINE Pay仕様ではない  1:LINE Pay仕様
  /// 関連tprxソース:cm_cksys.c - cm_LinePay_system()
  static Future<int> cmLinePaySystem() async {
    /* LINE Pay仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_LINEPAY_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmBarcodePaysystem(void)
  /// 機能：バーコード決済仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:バーコード決済仕様ではない  1:バーコード決済仕様
  /// 関連tprxソース:cm_cksys.c - cm_Barcode_Pay_system()
  static Future<int> cmBarcodePaysystem() async {
    /* Onepay仕様チェック */
    if (await cmOnepaySystem() != 0) {
      return (1);
    }
    /* LINE Pay仕様チェック */
    if (await cmLinePaySystem() != 0) {
      return (1);
    }
    /* Barcode決済(JPQR) 仕様チェック */
    if (await cmBarcodePay1System() != 0) {
      return (1);
    }
    /* ｺｰﾄﾞ決済[CANALPay]仕様チェック */
    if (await cmCanalPaymentServiceSystem() != 0) {
      return (1);
    }
    /* ｺｰﾄﾞ決済[Netstars]仕様チェック */
    if (await cmNetstarsCodepaySystem() != 0) {
      return (1);
    }
    /* ｺｰﾄﾞ決済[FIP]仕様チェック */
    if (await cmFujitsuFipCodepaySystem() != 0) {
      return (2);
    }
    return (0);
  }

  /// 関数：cmBarcodePay1System(void)
  /// 機能：JPQRバーコード決済仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:バーコード決済仕様でない 1:バーコード決済仕様
  /// 関連tprxソース:cm_cksys.c - cm_barcode_pay1_system()
  static Future<int> cmBarcodePay1System() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_BARCODE_PAY1_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 関数：cm_fujitsy_fip_codepay_system(void)
  /// 機能：ｺｰﾄﾞ決済[FIP]仕様を返す
  /// 引数：なし
  /// 戻値：0:ｺｰﾄﾞ決済[FIP]仕様ではない 1:ｺｰﾄﾞ決済[FIP]仕様
  /// 関連tprxソース:cm_cksys.c - cm_fujitsu_fip_codepay_system()
  static Future<int> cmFujitsuFipCodepaySystem() async {
    if ((await cmBarcodePay1System() == 1) || (await cmCanalPaymentServiceSystem() == 1)) {
      return (0);
    }
    /* ｺｰﾄﾞ決済[FIP]仕様チェック */
    RecogValue status1 = (await Recog().recogGet(
        Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM,
        RecogTypes.RECOG_GETMEM))
        .result;
    RecogValue status2 = (await Recog().recogGet(
        Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FUJITSU_FIP_CODEPAY_SYSTEM,
        RecogTypes.RECOG_GETMEM))
        .result;

    if (((status1 == RecogValue.RECOG_OK0893) ||
        (status1 == RecogValue.RECOG_YES)) ||
        ((status2 == RecogValue.RECOG_OK0893) ||
            (status2 == RecogValue.RECOG_YES))) {
      return (1);
    }
    return (0);
  }

  /// 関数：cmDesktopCashierSystem(void)
  /// 機能：卓上レジ２人制仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:卓上レジ２人制仕様ではない  1:卓上レジ２人制仕様
  /// 関連tprxソース:cm_cksys.c - cm_desktop_cashier_system()
  static Future<int> cmDesktopCashierSystem() async {
    if (CmCktWr.cm_chk_tower() != CmCktWr.TPR_TYPE_DESK) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    if (CompileFlag.SMART_SELF) {
      /* HappySelf仕様 || HappySelf仕様(SmileSelf用) */
      if (await cmHappySelfSystem() == 1) {
        return 1;
      }
    }
    return 0;
  }

  /// 関数：cmNetstarsCodepaySystem(void)
  /// 機能：ｺｰﾄﾞ決済[Netstars]仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:ｺｰﾄﾞ決済[Netstars]仕様ではない 1:ｺｰﾄﾞ決済[Netstars]仕様
  /// 関連tprxソース:cm_cksys.c - cm_netstars_codepay_system()
  static Future<int> cmNetstarsCodepaySystem() async {
    if ((await cmBarcodePay1System() == 1) // JPQRバーコード決済仕様との併用不可
        ||
        (await cmCanalPaymentServiceSystem() == 1) ||
        (await cmFujitsuFipCodepaySystem() == 1) ||
        (await cmMultiOnepaySystem() == 1)) {
      return (0);
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_NETSTARS_CODEPAY_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 特定DS2仕様(ゴダイ仕様)が有効かのチェック
  /// 関連tprxソース:cm_cksys.c - cm_ds2_godai_system()
  /// 引数：なし
  /// 戻値：0:無効 1:有効
  static Future<int> cmDs2GodaiSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DS2_GODAI_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_YES) ||
        (status == RecogValue.RECOG_OK0893)) {
      return (1);
    }
    return (0);
  }

  /// 電子マネー[FIP]仕様のフラグを返す。
  /// 関連tprxソース:cm_cksys.c - cm_ajs_emoney_system()
  /// 引数：なし
  /// 戻値：0:電子マネー[FIP]仕様ではない  1:電子マネー[FIP]仕様
  static Future<int> cmAjsEmoneySystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_AJS_EMONEY_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_YES) ||
        (status == RecogValue.RECOG_OK0893)) {
      return (1);
    }
    return (0);
  }

  /// 富士通FIP仕様の会員バーコード読込が利用できるかチェック
  /// 関連tprxソース:cm_cksys.c - cm_fip_member_barcode_system()
  /// 引数：なし
  /// 戻値：0:利用できない 1:利用できる
  static Future<int> cmFipMemberBarcodeSystem() async {
    int res1 = 0;

    // if (((cm_ajs_point_system() == 1) && (cmAjsEmoneySystem() == 1) {
    //   if (cm_sm32_maruai_system()) {
    //     return(1);
    //   }
    // }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_YES) ||
        (status == RecogValue.RECOG_OK0893)) {
      res1 = 1;
    }
    if ((await cmAjsEmoneySystem() == 1) && (res1 == 1)) {
      if (await cmDs2GodaiSystem() == 1) {
        return (1);
      }
    }
    return (0);
  }

  /// 実績にセットするためのレジのタイプを返す(KPI用)
  /// 関連tprxソース:cm_cksys.c - cm_kpi_reg_type()
  /// 引数：なし
  /// 戻値：0:エラーまたは対象外 1:通常、2:登録機、3:精算機、4:対面、5:フルセルフ、6:S&G精算機
  static Future<int> cmKpiRegType(int tid) async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      String erLog = "cm_kpi_reg_type() rxMemPtr ERROR !!\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return 0;
    }
    if (await cmHappySelfSystem() != 0)	{ // HappySelf
      RxCommonBuf pCom = xRet.object;
      Mac_infoJsonFile macInfo = pCom.iniMacInfo;
      int mode = macInfo.select_self.kpi_hs_mode;
      if (mode == 0) {
        return (4); // 対面
      }
      if (mode == 1) {
        return (5); // フルセルフ
      }
      if (await cmShopAndGoSystem() != 0) {	// Shop&Go
        return (6); // S&G精算機
      } else {
        return (3); // 精算機
      }
    }
    if ((await cmFrontSelfSystem() != 0) &&
        (await cmDesktopCashierSystem() != 0)) { // スマイルセルフ
      return (4); // 対面
    }
    if ((await cmSelfSystem() == 1) &&
        (CmCktWr.cm_chk_tower() == CmCktWr.TPR_TYPE_DESK)) { // SpeezaJ
      return (5); // フルセルフ
    }
    if ((await cmQCashierSystem() == 1) &&
        (CmCktWr.cm_chk_tower() == CmCktWr.TPR_TYPE_DESK)) { // QCashier
      if (await cmShopAndGoSystem() != 0)	{ // Shop&Go
        return (6); // S&G精算機
      } else {
        return (3); // 精算機
      }
    }
    if ((cmQCashierJCSystem() == 1) &&
        (CmCktWr.cm_chk_tower() == CmCktWr.TPR_TYPE_TOWER)) {	// QCJCはKPIの対象外とする
      return (0); // 対象外
    }
    if (await cmReceiptQrSystem() != 0) { // レシートQRコード印字仕様
      return (2); // 登録機
    }
    return (1); // 通常
  }

  /// 関数：cm_public_barcode_pay2_system(void)
  /// 機能：特定公共料金2仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定公共料金2仕様ではない 1:特定公共料金2仕様
  /// 関連tprxソース:cm_cksys.c - cm_public_barcode_pay2_system()
  static Future<int> cmPublicBarcodePay2System() async {
    /* 特定公共料金2仕様チェック */
    RecogValue status = (await Recog().recogGet(
        Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PUBLIC_BARCODE_PAY2_SYSTEM,
        RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return (1);
    }
    return (0);
  }

  /// 免税電子化仕様のフラグを返す
  /// 戻値：0:免税電子化仕様でない 1:免税電子化仕様
  /// 関連tprxソース:cm_cksys.c - cm_taxfree_server_system(), cm_taxfree_server_system2()
  static Future<int> cmTaxfreeServerSystem() async {
    return (await cmTaxfreeServerSystem2(1));
  }

  static Future<int> cmTaxfreeServerSystem2(int chkFlg) async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* WEB2800系のみ有効 */
    if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TAXFREE_SERVER_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      if ((chkFlg != 0) && (pCom.dbTrm.serverExc == 0)) {
        var (int error, String saleDate) = await DateUtil.dateTimeChange(null,
            DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM,
            DateTimeFormatKind.FT_YYYYMMDD_HYPHEN,
            DateTimeFormatWay.DATE_TIME_FORMAT_ZERO); //操作日時
        String date = saleDate;
        if ((date.compareTo("2021-10-01")) >= 0) {
          pCom.dbTrm.serverExc = 1;
        } else {
          return 0;
        }
      }
      return 1;
    }
    return 0;
  }

  /// M&C仕様のフラグを返す
  /// 戻値：0:M&C仕様ではない  1:M&C仕様
  /// 関連tprxソース:cm_cksys.c - cm_mc_system()
  static Future<int> cmMcSystem() async {
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MCSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status1 != RecogValue.RECOG_NO) && (status2 != RecogValue.RECOG_NO)) {
      return 1;
    }
    return 0;
  }

  /// ヤマト電子マネー決済端末仕様のフラグを返す
  /// 戻値：0:ﾔﾏﾄ電子ﾏﾈｰ決済端末仕様でない 1:ﾔﾏﾄ電子ﾏﾈｰ決済端末仕様
  /// 関連tprxソース:cm_cksys.c - cm_yamato_system()
  static Future<int> cmYamatoSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_YAMATO_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 2800シリーズプリンターか判断
  /// 戻値：0: No  1: Yes
  /// 関連tprxソース:cm_cksys.c - cm_2800Printer()
  /// TODO 長田
  static Future<int> cm2800Printer() async {
    int prtTyp = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    prtTyp = await CmCksys.cmPrinterType();
    // cm_sys.dartにcmPrinterType追加する必要あり
    if ((pCom.dbTrm.chgReceiptCutMode != 0) &&
        (( prtTyp == CmSys.TPRTSS ) || (prtTyp == CmSys.TPRTIM) || (prtTyp == CmSys.TPRTHP) )) {
      return 1;
    }
    return 0;
  }

  /// マルチ決済端末仕様[J-Mups]のフラグを返す
  /// 戻値：0:マルチ決済端末仕様[J-Mups]仕様でない 1:マルチ決済端末仕様[J-Mups]仕様
  /// 関連tprxソース:cm_cksys.c - cm_jmups_system()
  static Future<int> cmJmupsSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_JMUPS_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// QUICPay(UT1)仕様のフラグを返す
  /// 戻値：0:QUICPay(UT1)仕様ではない  1:QUICPay(UT1)仕様
  /// 関連tprxソース:cm_cksys.c - cm_Ut1_QUICPay_system()
  static Future<int> cmUt1QUICPaySystem() async {
    if (CompileFlag.ARCS_MBR) {
      return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
          CnctLists.CNCT_MULTI_CNCT) == 3)? 1 : 0;
    } else {
      /* QUICPay(UT1)仕様チェック */
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_UT1QPSYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_YES) ||
          (status == RecogValue.RECOG_OK0893)) {
        return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
            CnctLists.CNCT_MULTI_CNCT) == 3)? 1 : 0;
      }
      return 0;
    }
  }

  /// iD(UT1)仕様のフラグを返す
  /// 戻値：0:iD(UT1)仕様ではない  1:iD(UT1)仕様
  /// 関連tprxソース:cm_cksys.c - cm_Ut1_iD_system()
  static Future<int> cmUt1IDSystem() async {
    if (CompileFlag.ARCS_MBR) {
      return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
          CnctLists.CNCT_MULTI_CNCT) == 3)? 1 : 0;
    } else {
      /* iD(UT1)仕様チェック */
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_UT1IDSYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_YES) ||
          (status == RecogValue.RECOG_OK0893)) {
        return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
            CnctLists.CNCT_MULTI_CNCT) == 3)? 1 : 0;
      }
      return 0;
    }
  }

  /// Vesca決済端末仕様のフラグを返す
  /// 戻値：0:Vesca決済端末仕様しない 1:Vesca決済端末仕様する
  /// 関連tprxソース:cm_cksys.c - cm_vesca_system()
  static Future<int> cmVescaSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_VESCA_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// nanaco仕様のフラグを返す
  /// 戻値：0:nanaco仕様ではない 1:nanaco仕様
  /// 関連tprxソース:cm_cksys.c - cm_nanaco_system()
  static Future<int> cmNanacoSystem() async {
    int sRet = 0;
    /* 電子マネー決済仕様チェック */
    if (await cmCctEmoneySystem() != 0) {
      sRet = 1;
    }
    int iRet = Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT);
    return (sRet == 1 && iRet == 10) ? 1 : 0; /* JET-A手順(標準) */
  }

  /// NSCクレジット仕様のフラグを返す。
  /// 戻値：0:非NSCクレジット仕様 / 1:NSCクレジット仕様
  /// 関連tprxソース:cm_cksys.c - cm_NSC_system()
  static Future<int> cmNSCSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* NSCクレジット仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_NSC_CREDIT, RecogTypes.RECOG_GETMEM)).result;
    if ((status != RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 6)) {
      return 1;
    }
    return 0;
  }

  /// FeliCa仕様のフラグを返す。
  /// 戻値：0:FeliCa仕様ではない  1:FeliCa仕様
  /// 関連tprxソース:cm_cksys.c - cm_FeliCa_system()
  static Future<int> cmFeliCaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* FeliCa仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FELICASYSTEM, RecogTypes.RECOG_GETMEM)).result;
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status != RecogValue.RECOG_NO) && (status2 != RecogValue.RECOG_NO)) {
      return 1;
    }
    return 0;
  }

  /// PSP-70仕様のフラグを返す
  /// 戻値：0:PSP-70仕様ではない  1:PSP-70仕様
  /// 関連tprxソース:cm_cksys.c - cm_PSP_system()
  static Future<int> cmPspSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PSP70SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if ((status != RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 7)) {
      return 1;
    }
    return 0;
  }

  /// ５×７客側表示機のチェック
  /// 戻値：0:５×７客側表示機ではない  1:５×７客側表示機
  /// 関連tprxソース:cm_cksys.c - cm_57vfd_chk()
  static Future<int> cm57vfdChk() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;
    if (macInfo.prime_fip.prime_fip == 0) {
      if ((await cmWebJrSystem() == 1) &&
          (pCom.iniMacInfo.prime_fip.prime_fip == 2)) {
        return 1;
      }
    }
    return 0;
  }

  /// WebPrime FB対応のフラグを返す
  /// 戻値：0:WebPrimeFB対応ではない (/etc/fb_smhd.iniが存在しない)
  ///      1:WebPrimeFB対応である
  /// 関連tprxソース:cm_cksys.c - cm_primefb_system()
  static int cmPrimefbSystem() {
    if (TprxPlatform.getFile("/etc/fb_smhd.json").existsSync()) {
      return 1;
    } else {
      return 0;
    }
  }

  /// ＩＴＦバーコード仕様のフラグを返す
  /// 戻値：0:ＩＴＦバーコード仕様ではない  1:ＩＴＦバーコード仕様
  /// 関連tprxソース:cm_cksys.c - cm_ItfBarcode_system()
  static Future<int> cmItfBarcodeSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ＩＴＦバーコード仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ITF_BARCODE, RecogTypes.RECOG_GETMEM)).result;
    if (status != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// Smartplus仕様のフラグを返す
  /// 戻値：0:Smartplus仕様ではない  1:Smartplus仕様
  /// 関連tprxソース:cm_cksys.c - cm_Smartplus_system()
  static Future<int> cmSmartplusSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ＩＴＦバーコード仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SMARTPLUSSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if (status != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// JREM製マルチ端末仕様のフラグを返す
  /// 戻値：0:JREM製マルチ端末仕様ではない  1:JREM製マルチ端末仕様
  /// 関連tprxソース:cm_cksys.c - cm_JREM_Multisystem()
  static Future<int> cmJremMultiSystem() async {
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_JREM_MULTISYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ICCARDSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;

    if ((status1 != RecogValue.RECOG_NO) &&
        (status2 == RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_JREM_CNCT) == 1)) {
      return 1;
    }
    return 0;
  }

  /// Pharmacy仕様のフラグを返す
  /// 戻値：0:Pharmacy仕様ではない  1:Pharmacy仕様
  /// 関連tprxソース:cm_cksys.c - cm_Pharmacy_system()
  static Future<int> cmPharmacySystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Pharmacy仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_POINTCARDSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status != RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 0)) {
      return 1;
    }
    return 0;
  }

  /// SapporoPana仕様のフラグを返す
  /// 戻値：0:SapporoPana仕様ではない  1:SapporoPana仕様
  /// 関連tprxソース:cm_cksys.c - cm_Sapporo_Pana_system()
  static Future<int> cmSapporoPanaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* SapporoPana仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_POINTCARDSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status != RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 0)) {
      return 1;
    }
    return 0;
  }

  /// SapporoReal仕様のフラグを返す
  /// 戻値：0:SapporoReal仕様ではない  1:SapporoReal仕様
  /// 関連tprxソース:cm_cksys.c - cm_Sapporo_Real_system()
  static Future<int> cmSapporoRealSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* SapporoPana仕様チェック */
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_POINTCARDSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREALSVR, RecogTypes.RECOG_GETMEM)).result;
    if ((status1 != RecogValue.RECOG_NO) &&
        (status2 != RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CUSTREALSVR_CNCT) != 0)) {
      return 1;
    }
    return 0;
  }

  /// メディア情報仕様のフラグを返す
  /// 戻値：0:メディア情報仕様ではない  1:メディア情報仕様
  /// 関連tprxソース:cm_cksys.c - cm_Media_Info_system()
  static Future<int> cmMediaInfoSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* メディア情報仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEDIA_INFO,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// ABS-V31リライトカード仕様のフラグを返す
  /// 戻値：0:ABS-V31リライトカード仕様ではない  1:ABS-V31リライトカード仕様
  /// 関連tprxソース:cm_cksys.c - cm_AbsV31_Rwt_system()
  static Future<int> cmAbsV31RwtSystem() async {
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ABSV31_RWT, RecogTypes.RECOG_GETMEM))
        .result;

    if ((status1 != RecogValue.RECOG_NO) &&
        (status2 != RecogValue.RECOG_NO) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 10)) {
      return 1;
    }
    return 0;
  }

  /// リライト接続による顧客仕様かを返す
  /// 戻値：0:リライト接続による顧客仕様でない  1:リライト接続による顧客仕様
  /// 関連tprxソース:cm_cksys.c - cm_Chk_Rwc_Cust()
  static Future<int> cmChkRwcCust() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* リライト接続でもABS-S31Kプリペイド仕様のみ利用の場合はリライト接続による顧客仕様でない */
    if((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 6)	/* PW410接続 */
        && ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_PW410SYSTEM, RecogTypes.RECOG_GETMEM))
            .result == RecogValue.RECOG_NO)	/* PW410接続仕様でない */
        && ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_ABS_PREPAID, RecogTypes.RECOG_GETMEM))
            .result != RecogValue.RECOG_NO)) {  /* ABS-S31Kプリペイド仕様 */
      return 0;
    }
    if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) != 0) {
      return 1;
    }
    return 0;
  }

  /// CCT決済端末のドライバが利用可能かどうかを返す
  /// 戻値：0:利用不可能  1:利用可能
  /// 関連tprxソース:cm_cksys.c - cm_cct_cnct_ckeck()
  static int cmCctCnctCkeck() {
    int status =
    Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT);

    switch (status) {
      case 0:
        if ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) ==
            3) ||
            (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) ==
                4)) {
          return 1;
        } else {
          return 0;
        }
      case 3:
      case 4:
      case 10:
      case 12:
      case 13:
      case 14:
      case 20:
      case 21:
      case 24:
        return 1;
      default:
        return 0;
    }
  }

  /// 自走式磁気カードリーダー接続かどうかを返す
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_MASR_system()
  static int cmMasrSystem() {
    if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MASR_CNCT) != 0) {
      return 1;
    }
    return 0;
  }

  /// 標準CAPS[CAFIS]仕様のフラグを返す
  /// 戻値：0:標準CAPS[CAFIS]仕様ではない  1:標準CAPS[CAFIS]仕様
  /// 関連tprxソース:cm_cksys.c - cm_CAPS_CAFIS_standard_system()
  static Future<int> cmCAPSCAFISStandardSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* CAPS[CAFIS]接続仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CAPS_CAFIS_STANDARD,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    else if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CAPS_CARDNET_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }

    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CREDITSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 == 1) && (res2 == 1)) ? 1 : 0;
  }

  /// カード決済機/J-Mups併用のフラグを返す
  /// 戻値：0:併用ではない  1:併用
  /// 関連tprxソース:cm_cksys.c - cm_cat_jmups_twin_connection()
  static Future<int> cmCatJmupsTwinConnection() async {
    if (await cmJmupsSystem() != 0) {
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_CAT_JNUPS_SYSTEM, RecogTypes.RECOG_GETMEM))
          .result;
      if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
        return 1;
      }
    }
    return 0;
  }

  /// 富士通FIP電子マネー仕様(標準)のチェック
  ///  関連tprxソース:cm_cksys.c - cm_fip_emoney_standard_system()
  ///  引数：なし
  ///  戻値：0:富士通FIP電子マネー仕様(標準)でない 1:富士通FIP電子マネー仕様(標準)
  static Future<int> cmFipEmoneyStandardSystem() async {
    // 特注ユーザーが1Ver.に移行してきた場合はコメント解除する
    // RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
    //     RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
    //     .result;
    // bool mbr_system = ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES));

    if (await cmAjsEmoneySystem() == 1) {
      // 特注ユーザーが1Ver.に移行してきた場合はコメント解除する
      // if (cm_sm13_chuoichiba_system()
      //     || cm_sm15_beniya_system()
      //     || cm_sm32_maruai_system()
      //     || (cm_sm21_hashidrug_system() && mbr_system && cm_custreal_netdoa_system())) {
      //   // 特定ユーザー承認キーが有効の場合は標準仕様対象外
      //   return(0);
      // }
      return (1);
    }
    return (0);
  }

  /// タカヤナギ様仕様のフラグを返す。
  ///  関連tprxソース:cm_cksys.c - cm_sm55_takayanagi_system()
  ///  引数：なし
  ///  戻値：0:タカヤナギ様ではない  1:タカヤナギ様仕様
  static Future<int> cmSm55TakayanagiSystem() async {
    /* タカヤナギ様仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SM55_TAKAYANAGI_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return (1);
    }
    return (0);
  }

  /// 特定SM5(伊徳様)仕様のフラグを返す
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_sm5_itoku_system()
  static Future<int> cmSm5ItokuSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定SM5仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SM5_ITOKU_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// ユナイトホールディングス様仕様のフラグを返す
  /// 戻値：0:上記仕様ではない  1:上記仕様である
  /// 関連tprxソース:cm_cksys.c - cm_yunaito_hd_system()
  static Future<int> cmYunaitoHdSystem() async {
    return ((await cmSm55TakayanagiSystem() != 0) ||
        (await cmSm5ItokuSystem() != 0))? 1 : 0;
  }

  /// パレッテ仕様のチェック
  ///  関連tprxソース:cm_cksys.c - cm_sm52_palette_system()
  ///  引数：なし
  ///  戻値：0:有効でない 1:有効
  static Future<int> cmSm52PaletteSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SM52_PALETTE_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return (1);
    }
    return (0);
  }

  /// dポイント仕様のフラグを返す
  ///  関連tprxソース:cm_cksys.c - cm_dpoint_system()
  ///  引数：なし
  ///  戻値：0:dポイント仕様でない 1:dポイント仕様
  static Future<int> cmDpointSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DPOINT_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return (1);
    }
    return (0);
  }

  /// Tポイント仕様のフラグを返す
  ///  関連tprxソース:cm_cksys.c - cm_tpoint_system()
  ///  引数：なし
  ///  戻値：0:Tポイント仕様ではない  1:Tポイント仕様
  static Future<int> cmTpointSystem() async {
    int res1 = 0;
    int res2 = 0;
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_TPOINT, RecogTypes.RECOG_GETMEM))
        .result;
    if (status1 == RecogValue.RECOG_OK0893 || status1 == RecogValue.RECOG_YES) {
      res1 = 1;
    }
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status2 == RecogValue.RECOG_OK0893 || status2 == RecogValue.RECOG_YES) {
      res2 = 1;
    }
    if ((res1 == 1) && (res2 == 1)) {
      return (1);
    }
    return (0);
  }

  /// NW-7バーコードの5桁を従業員バーコードとして扱うフラグを返す
  ///  関連tprxソース:cm_cksys.c - cm_NW7_Staff_system()
  ///  引数：なし
  ///  戻値：0:NW-7従業員対応しない  1:NW-7従業員対応する
  static Future<int> cmNW7StaffSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      return (pCom.dbTrm.nw7StaffFlg);
    }
    // // #if 0
    // if ((cmIchiyamaMartSystem() != 0) || (cmHc3AyahaSystem() != 0)) {
    //   return (1);
    // }
    // // #endif
    return (0);
  }

  /// 懸賞企画仕様のフラグを返す
  /// 戻値：0:懸賞企画仕様しない 1:懸賞企画仕様する
  /// 関連tprxソース:cm_cksys.c - cm_p11_prize_system()
  static Future<int> cmP11PrizeSystem() async {
    if (await cmHc3AyahaSystem() != 0) {
      return 1;
    }
    return 0;
  }

  /// 販売期限バーコード26桁仕様のフラグを返す
  /// 戻値：0:販売期限バーコード26桁仕様ではない  1:販売期限バーコード26桁仕様
  /// 関連tprxソース:cm_cksys.c - cm_sall_lmtbar26_system()
  static Future<int> cmSallLmtbar26System() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SALL_LMTBAR26, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// ﾐｯｸｽﾏｯﾁ複数選択仕様のフラグを返す
  /// 戻値：0:ﾐｯｸｽﾏｯﾁ複数選択仕様ではない  1:ﾐｯｸｽﾏｯﾁ複数選択仕様
  /// 関連tprxソース:cm_cksys.c - cm_bdl_multi_select_system()
  static Future<int> cmBdlMultiSelectSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* ﾐｯｸｽﾏｯﾁ複数選択仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_BDL_MULTI_SELECT_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// パルコープおおさかクーポンバーコード仕様のチェックを返す
  /// 戻値：0:クーポンバーコード仕様ではない  1:クーポンバーコード仕様
  /// 関連tprxソース:cm_cksys.c - cm_palcoop_function_barcode_system()
  static Future<int> cmPalcoopFunctionBarcodeSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    /* ユーザーコードチェック */
    if (pCom.dbTrm.delShopbagVoiceSsps != 0) {
      return 1;
    }
    return 0;
  }

  /// 特定売上チケット発券のフラグを返す
  /// 戻値：0:特定売上チケット発券ではない  1:特定売上チケット発券
  /// 関連tprxソース:cm_cksys.c - cm_purchase_ticket_system()
  static Future<int> cmPurchaseTicketSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定売上チケット発券仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PURCHASE_TICKET_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 周辺装置にパナコードを設定せずに、リライトカードから
  ///     顧客リアルのカードへポイント移行（顧客コード取得）を行うフラグを返す
  /// 戻値：0:上記仕様ではない  1:上記仕様である
  /// 関連tprxソース:cm_cksys.c - cm_nopana_pointomove_system()
  static Future<int> cmNopanaPointomoveSystem() async {    
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (( pCom.dbTrm.rwDisableUsePanaPointMove != 0 )
    && ( SioChk.sioCnctCheck(Sio.SIO_PANA) != 0 )
    && ( Cnct.cnctMemGet(Tpraid.TPRAID_PROCINST, CnctLists.CNCT_RWT_CNCT) == 0 )
    && ( pCom.dbTrm.jackleDispMbrnum16d != 0)
    && ( cmMatugenSystem() == 0 ))
    {
      return (1);
    }
    return 0;
  }

  /// UT接続仕様のフラグを返す。
  ///  関連tprxソース:cm_cksys.c - cm_UT_cnct_system()
  ///  引数：なし
  ///  戻値：0:UT接続仕様ではない 1:UT接続仕様
  static Future<int> cmUTCnctSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.mulSmlDscUsetyp != 0) {
      return 0;
    }
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status1 == RecogValue.RECOG_YES) {
      return 0;
    }
    /* UT接続仕様仕様チェック */
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_UT_CNCT, RecogTypes.RECOG_GETMEM))
        .result;
    if (status2 == RecogValue.RECOG_YES) {
      res = 1;
    }
    return (res);
  }

  /// 楽天ポイント仕様の有効性判定処理。
  ///  関連tprxソース:cm_cksys.c - cm_rpoint_system()
  ///  引数：なし
  ///  戻り値　：0:無効、1:有効
  static Future<int> cmRpointSystem() async {
    int res1 = 0;
    int res2 = 0;
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_RPOINT_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status1 == RecogValue.RECOG_OK0893 || status1 == RecogValue.RECOG_YES) {
      res1 = 1;
    }
    // 顧客ﾎﾟｲﾝﾄ仕様も必要
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status2 == RecogValue.RECOG_OK0893 || status2 == RecogValue.RECOG_YES) {
      res2 = 1;
    }
    if ((res1 == 1) && (res2 == 1)) {
      return (1);
    }
    return (0);
  }

  /// CSS 愛媛電算仕様
  ///  関連tprxソース:cm_cksys.c - cm_css_ehimedensan_system()
  ///  引数：なし
  ///  戻値：0:通常 1：愛媛電算仕様
  static Future<int> cmCssEhimedensanSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.cssUserProc == 1) {
      return (1); // 愛媛電算仕様
    }
    return (0);
  }

  /// ｺｰﾄﾞ決済[QUIZ]仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:ｺｰﾄﾞ決済[QUIZ]仕様ではない 1:ｺｰﾄﾞ決済[QUIZ]仕様
  /// 関連tprxソース:cm_cksys.c - cm_quiz_payment_system()
  static Future<int> cmQuizPaymentSystem() async {
    /* 他のバーコード決済仕様との併用不可 */
    if ((await cmBarcodePay1System() != 0) ||
        (await cmCanalPaymentServiceSystem() != 0) ||
        (await cmFujitsuFipCodepaySystem() != 0) ||
        (await cmMultiOnepaySystem() != 0) ||
        (await cmNetstarsCodepaySystem() != 0)) {
      return (0);
    }
    /* ｺｰﾄﾞ決済[QUIZ]仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_QUIZ_PAYMENT_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return (1);
    }
    return (0);
  }

  /// staffid1_ymss仕様のフラグを返す
  /// 戻値：0:特定社員証1仕様ではない  1:特定社員証1仕様
  /// 関連tprxソース:cm_cksys.c - cm_staffid1_ymss_system()
  static Future<int> cmStaffid1YmssSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定社員証1仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_STAFFID1_YMSS_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// VEGA3000電子ﾏﾈｰ仕様の承認キーが有効かを判定する
  /// 引数：なし
  /// 戻値：0:無効  1:有効
  /// 関連tprxソース:cm_cksys.c - cm_multi_vega_recog()
  static Future<int> cmMultiVegaRecog() async {
    if (CompileFlag.CENTOS) {
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MULTI_VEGA_SYSTEM, RecogTypes.RECOG_GETMEM))
          .result;
      if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
        return 1;
      }
    }
    return 0;
  }

  /// VEGA端末が付いていて、VEGA3000電子ﾏﾈｰ仕様の承認キーが有効かを判定する
  /// 戻値：0:端末が付いていない、または、承認キー無効
  ///      1:端末が付いていて、承認キーも有効
  /// 関連tprxソース:cm_cksys.c - cm_multi_vega_system()
  static Future<int> cmMultiVegaSystem() async {
    if (CompileFlag.CENTOS) {
      /* VEGA3000電子ﾏﾈｰ仕様チェック */
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MULTI_VEGA_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
        if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == 6) {
          return 1;
        }
      }
    }
    return 0;
  }

  /// VEGA3000が対応する電子マネーブランドが有効であるか判定
  /// FCL_SERVICE brand : ブランド指定

  ///  関連tprxソース:cm_cksys.c - cm_rf1_hs_System()
  static Future<int> cmRf1HsSystem() async {
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    /* 共有メモリポインタの取得 */
    if (pCom == null) {
      ret = 0;
    } else {
      // 特定総菜仕様(DB V1以降)[ＲＦ仕様]チェック
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_RF1_HS_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((RecogValue.RECOG_YES == status)
          || (RecogValue.RECOG_OK0893 == status)) {
        // RM-5900
        if (pCom.vtclRm5900Flg) {
          ret = 1;
        }
      }
    }
    return ret;
  }

  ///  関連tprxソース:cm_cksys.c - cm_nimoca_point_system()
  static Future<int> cmNimocaPointSystem() async {
    RecogValue status1 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result;
    if(! ((status1 == RecogValue.RECOG_OK0893) || (status1 == RecogValue.RECOG_YES))) {
      return 0;
    }
    RecogValue status2 = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_NIMOCA_POINT_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result;
    if((status2 == RecogValue.RECOG_OK0893) || (status2 == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 引換券印字仕様のフラグを返す
  /// 戻値：0:引換券印字仕様ではない  1:引換券印字仕様
  /// 関連tprxソース:cm_cksys.c - cm_SubTckt_system()
  static Future<int> cmSubTcktSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 引換券印字仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SUB_TICKET,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  /// Rainbow Card仕様のフラグを返す
  /// 戻値：0:Rainbow Card仕様ではない  1:Rainbow Card仕様
  /// 関連tprxソース:cm_cksys.c - cm_RainbowCard_system()
  static Future<int> cmRainbowCardSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Rainbow Card仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_RAINBOWCARD,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 5))? 1: 0;
  }

  /// 値付けプリンタ接続仕様のフラグを返す
  /// 0:値付けプリンタ接続仕様ではない  1:値付けプリンタ接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_MP1Print_system()
  static Future<int> cmMP1PrintSystem() async {
    if (CompileFlag.MP1_PRINT) {
      /* 共有メモリポインタの取得 */
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      /* 値付けプリンタ接続仕様チェック */
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MP1_PRINT,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        return 1;
      }
    }
    return 0;
  }

  /// 値付けプリンタ接続仕様が有効かを返す
  /// 戻値：0:値付けプリンタ接続仕様が有効  1:値付けプリンタ接続仕様が無効
  /// 関連tprxソース:cm_cksys.c - cm_Check_MP1Print()
  static Future<int> cmCheckMP1Print() async {
    if ((await cmSubTcktSystem() == 0) && /* 引換券印字仕様が無効      */
        (await cmMP1PrintSystem() != 0)) { /* 値付けﾌﾟﾘﾝﾀ接続仕様が有効 */
      return 1;
    }
    return 0;
  }

  /// CAT Point仕様のフラグを返す
  /// 戻値：0:CAT Point仕様ではない  1:CAT Point仕様
  /// 関連tprxソース:cm_cksys.c - cm_CATpoint_system()
  static Future<int> cmCATpointSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* CAT Point仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CAT_POINT,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  ///  関連tprxソース:cm_cksys.c - cm_coopAIZU_system()
  static int cmCoopAIZUSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.coopaizuFunc1 != 0) {
      return 1;
    } else {
      return 0;
    }
  }

  ///  関連tprxソース:cm_cksys.c - cm_Reserv_system()
  static Future<int> cmReservSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 詰合仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_RESERVSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    /* ゴダイ様特注：締めキー「予約(見積り)」のみ予約承認キー無しで動かす */
    else if (await cmDs2GodaiSystem() != 0) {
      res = CmSys.GODAI_RESERV;
    }
    return res;
  }

  /// 銀聯仕様のフラグを返す
  /// 戻値：0:銀聯仕様ではない  1:銀聯仕様
  /// 関連tprxソース:cm_cksys.c - cm_GinCard_system()
  static Future<int> cmGinCardSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 銀聯仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_GINCARDSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res != 0) &&
        ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 4) ||
            (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 3) ||
            ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
                (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 4)))) ? 1 : 0;
  }

  /// バックアップメモリ接続の有効状態を返す
  /// 戻値：0:有効 1:無効 2:有効(バックアップデータ含む)
  /// 関連tprxソース:cm_cksys.c - cm_chk_doc_cnct()
  static Future<int> cmChkDocCnct() async {
    int mmType = cmMmType();
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 1;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.iniMacInfo.mm_system.sgt_cf_wt == 1) {	/* 接続：しない */
      return 1;
    }
    if (mmType != CmSys.MacMOnly) {	/* ＳＴ以外 */
      return 1;
    }
    if (await cmCheckAfterWeb2300() == 0) {
      return 0; /* 接続：する、接続：する（全て）、共に、「接続：する」に変更 */
    } else {
      return (pCom.iniMacInfo.mm_system.sgt_cf_wt);
    }
  }

  /// バックアップメモリ接続の有効状態を返す
  /// 戻値：0:有効 1:無効 2:有効(バックアップデータ含む)
  /// 関連tprxソース:cm_cksys.c - cm_chk_doc_cnct_ini()
  static Future<int> cmChkDocCnctIni(int tid) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;
    int mmType = await cmMmIniType();
    int sgtCfWt = 0;
    try {
      sgtCfWt = macInfo.mm_system.sgt_cf_wt;
    } catch (e) {
      String erlog = "cmChkDocCnctIni getJsonValue error[Mac_infoJson][mm_system][sgt_cf_wt]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erlog);
    }

    if (mmType != CmSys.MacMOnly) {	/* ＳＴ以外 */
      return 1;
    }

    if (await cmCheckAfterWeb2300() == 0) {
      return 0; /* 接続：する、接続：する（全て）、共に、「接続：する」に変更 */
    } else {
      return (sgtCfWt);
    }
  }

  /// QUICPay(FCL)仕様のフラグを返す
  /// 戻値：0:QUICPay(FCL)仕様ではない  1:QUICPay(FCL)仕様
  /// 関連tprxソース:cm_cksys.c - cm_Fcl_QUICPay_system()
  static Future<int> cmFclQUICPaySystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* QUICPay(FCL)仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FCLQPSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res == 1) &&
        ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == 2 )||
            (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == -2 ))) ? 1 : 0;
  }

  /// Edy(FCL)仕様のフラグを返す
  /// 戻値：0:Edy(FCL)仕様ではない  1:Edy(FCL)仕様
  /// 関連tprxソース:cm_cksys.c - cm_Fcl_Edy_system()
  static Future<int> cmFclEdySystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Edy(FCL)仕様チェック */
    if
    ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FCLEDYSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res == 1) &&
        ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == 2 )||
            (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == -2 ))) ? 1 : 0;
  }

  /// Web2800 FIP接続状態を返す
  /// 戻値：0: 1個（メインFIPのみ） 1: 2個  2: 3個
  /// 関連tprxソース:cm_cksys.c - cm_web2800_subfip_cnct()
  static Future<int> cmWeb2800SubfipCnct() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (await cmWebType() != CmSys.WEBTYPE_WEB2800) {
      return 0;
    }
    if (CmCktWr.cm_chk_tower() != CmSys.TPR_TYPE_DESK) {
      return 0;
    }
    /* Web2800 FIP接続状態チェック */
    return (pCom.iniMacInfo.system.fip_connect);
  }

  /// バーコード決済でチャージを行う仕様のフラグを返す
  /// 戻値：0:バーコード決済のチャージ仕様ではない  1:バーコード決済のチャージする仕様
  /// 関連tprxソース:cm_cksys.c - cm_Barcode_Pay_Charge_system()
  static Future<int> cmBarcodePayChargeSystem() async {
    /* LINE Pay仕様チェック */
    if (await cmLinePaySystem() != 0) {
      return 1;
    }
    return 0;
  }

  ///  関連tprxソース:cm_cksys.c - cm_PFM_JR_IC_Charge_system()
  static Future<int> cmPfmJrIcChargeSystem() async {
    if (CompileFlag.CENTOS) {
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_PFMJRICCHARGESYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
        return (cmPFMJRICSystem());
      }
      return 0;
    } else {
      return 0;
    }
  }

  ///  関連tprxソース:cm_cksys.c - cm_PFM_JR_IC_system()
  static Future<int> cmPFMJRICSystem() async {
    if (CompileFlag.CENTOS) {
      if (await cmSuicaSystem() != 0) {
        return 0;
      }
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_PFMJRICSYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
        return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM,
            CnctLists.CNCT_MULTI_CNCT) == 4) ? 1 : 0;
      }
      return 0;
    } else {
      return 0;
    }
  }

  /// カーネルのバージョンを返す
  /// 戻値：0:エラー 0以外:カーネルバージョン（2.6.32の時、132640を返す）
  /// 関連tprxソース:cm_cksys.c - cm_get_kernel_version()
  /// TODO 長田
  static Future<int> cmGetKernelVersion(int tid) async {
    // struct	utsname	uname_buff;
    // int	a, b, c;
    //
    // if(uname(&uname_buff) == 0) { //uname:OS名(sysname),ホスト名(nodename),OSリリース番号(release),OSバージョン(version),コンピュータの種類
    //   sscanf(uname_buff.release, "%d.%d.%d", &a, &b, &c);
    //   return ( KERNEL_VERSION(a, b, c) ); //((a)*65536+(b)*256+(c))
    // } else {
    //   String erlog = "cm_get_kernel_version() ERR !\n";
    //   TprLog().logAdd(tid, LogLevelDefine.error, erlog);
    //   return  0;
    // }
    return 0;
  }

  /// 大分類実績上げ仕様かを返す
  /// 戻値：0:大分類実績上げ仕様ではない  1:大分類実績上げ仕様
  /// 関連tprxソース:cm_cksys.c - cm_LageClsSum_System()
  static Future<int> cmLageClsSumSystem() async {
    int res = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return res;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;
    if (cmMmSystem() == 1) {	 /* MS */
      try {
        if (macInfo.mm_system.reg_lrg_sum == 1) {
          res = 1;
        }
      } catch (e) {}
    }
    return res;
  }

  /// 画像認識商品情報出力
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_BrainFl_system()
  static Future<int> cmBrainFlSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (await cmBrainSystem() != 0) {
      return (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_BRAINFL_CNCT));
    }
    return 0;
  }

  /// 履歴ログの取得方法を変更するかどうかを判定する
  /// 戻値：0:変更しない  1:変更する  2:特定ユーザー（セイブ）向け
  /// 関連tprxソース:cm_cksys.c - cm_histlog_get_change()
  static Future<int> cmHistlogGetChange() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int result = 0;
    int mmType = cmMmType();
    if ((cmMmSystem() == 0) ||
        ((await cmCenterServerSystem() != 0) &&
            ((mmType == CmSys.MacM1) || (mmType == CmSys.MacMOnly)))) {   /* TS、TSD、SHP 接続時有効 */
      if (pCom.iniMacInfo.histlog_get.histlog_get_change == 1) {
        result = 1;
      }
    }
    // 特定1 + TSD時 有効
    if ((mmType == CmSys.MacERR)
        && (await cmCenterServerSystem() != 0)
        && (pCom.iniMacInfo.histlog_get.histlog_get_change == 2)) {
      result = 2;
    }
    return (result);
  }

  /// 売掛伝票印字仕様のフラグを返す
  /// 戻値：0:売掛伝票印字仕様ではない 1:売掛伝票印字仕様
  /// 関連tprxソース:cm_cksys.c - cm_ChargeSlip_system()
  static Future<int> cmChargeSlipSystem() async {
    RecogValue status;
    RecogValue res;
    status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CHARGESLIP_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      res = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_CATALINASYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if ((res == RecogValue.RECOG_OK0893) || (res == RecogValue.RECOG_YES)) {
        return 0;
      }
      res = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_REALITMSEND, RecogTypes.RECOG_GETMEM)).result;
      if ((res == RecogValue.RECOG_OK0893) || (res == RecogValue.RECOG_YES)) {
        return 0;
      }
      res = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_BDLITMSEND, RecogTypes.RECOG_GETMEM)).result;
      if ((res == RecogValue.RECOG_OK0893) || (res == RecogValue.RECOG_YES)) {
        return 0;
      }
      return 1;
    }
    return 0;
  }

  /// キャッシュマネジメント事務所一括時棒出金単位指定内容を返す
  /// 戻値：0:しない　1：0/50  2:10/50
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_roll_inout()
  static Future<int> cmCashRecycleRollInout() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.rollUnitInout);
  }

  /// 棒金ドロアの５００円棒金の種類を返す
  /// 戻値：0:50枚巻き  1:20枚巻き
  /// 関連tprxソース:cm_cksys.c - cm_chgdrw_brick_typ()
  static Future<int> cmChgdrwBrickTyp() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.iniMacInfo.acx_flg.acb50_ssw13_5);
  }

  /// Printer Continue Function Check
  /// 戻値：1:する  0:しない
  /// 関連tprxソース:cm_cksys.c - cm_PrinterContinue_system()
  /// TODO 長田
  static Future<int> cmPrinterContinueSystem() async {
    // /* 共有メモリポインタの取得 */
    // RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    // if (xRet.isInvalid()) {
    //   return 0;
    // }
    // RxCommonBuf pCom = xRet.object;
    // if (pCom.dbTrm.printRestartContinue == 0) {
    //   return 0;
    // }
    // if (cm_PrinterType() == SUBCPU_PRINTER) {
    //   return 0;
    // }
    // return 1;
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - rcChk_ChgStlDscPriorty_System()
  static Future<int> rcChkChgStlDscPriortySystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return((await cmCrdtSystem() != 0) &&
        (pCom.dbTrm.crdtUserNo == 1))? 1: 0;
  }

  /// 関連tprxソース:cm_cksys.c - rcChk_CatalinaStlDsc_System()
  static Future<int> rcChkCatalinaStlDscSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CATALINASYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      /* 共有メモリポインタの取得 */
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return 0;
      }
      RxCommonBuf pCom = xRet.object;
      return((await cmCrdtSystem() != 0) &&
          (pCom.dbTrm.crdtUserNo == 1))? 1: 0;
    }
    return 0;
  }

  /// プロモーションレシートの任意ビットマップ対応チェック
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_Promotion_Unique_Bmp()
  static Future<int> cmPromotionUniqueBmp() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int result = 0;
    int mmType = cmMmType();
    if((mmType == CmSys.MacERR) || (await cmHc3AyahaSystem() != 0)) {	/* MS仕様では動作しない */
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_PROMSYSTEM, RecogTypes.RECOG_GETMEM)).result;
      if((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
        if (pCom.dbTrm.promArbitraryBitmap != 0) {
          result = 1;
        }
      }
    }
    return (result);
  }

  /// キャッシュリサイクル入出金時の従業員入力
  /// 戻値：0:しない  1:する
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_staff_input()
  static Future<int> cmCashRecycleStaffInput() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.staffInput);
  }

  /// キャッシュリサイクル計算基準
  /// 戻値：0:設定値　2:補充基準値
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_cal_basis()
  static Future<int> cmCashRecycleCalBasis() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.allotRef);
  }

  /// 単品値下げクーポン券仕様のフラグを返す
  /// 戻値：0:仕様ではない  1:仕様
  /// 関連tprxソース:cm_cksys.c - cm_ItemPrc_Reduction_Coupon_System()
  static Future<int> cmItemPrcReductionCouponSystem() async {
    int result = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DISC_BARCODE,  RecogTypes.RECOG_GETMEM)).result;
    if (status == RecogValue.RECOG_NO) {
      return 0;
    }
    if (CompileFlag.ARCS_MBR) {
      result = 1;
    } else {
      RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_ITEMPRC_REDUCTION_COUPON, RecogTypes.RECOG_GETMEM)).result;
      if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
        result = 1;
      }
    }
    return (result);
  }

  /// キャッシュリサイクル充当レジボタン枚数表示
  /// 戻値：0:充当可能枚数　1:有高　2:しない
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_maisu_show()
  static Future<int> cmCashRecycleMaisuShow() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.btnShtShow);
  }

  /// キャッシュリサイクル事務所一括時の両替
  /// 戻値：0:しない　1:釣機両替
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_drwchg()
  static Future<int> cmCashRecycleDrwchg() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.cchg);
  }

  /// キャッシュリサイクル万券入出金
  /// 戻値：0:しない　1:する
  /// 関連tprxソース:cm_cksys.c - cm_cash_recycle_enter()
  static Future<int> cmCashRecycleEnter() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    return (pCom.dbCashrecycle.manInout);
  }

  /// SUICAﾁｬｰｼﾞ仕様のフラグを返す
  /// 戻値：0:SUICAﾁｬｰｼﾞ仕様ではない  1:SUICAﾁｬｰｼﾞ仕様
  /// 関連tprxソース:cm_cksys.c - cm_Suica_Charge_system()
  static Future<int> cmSuicaChargeSystem() async {
    if (await cmSuicaSystem() == 0) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SUICA_CHARGE_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 三陸スーパー仕様のフラグを返す
  /// 戻値：0:三陸スーパー仕様ではない  1:三陸スーパー仕様
  /// 関連tprxソース:cm_cksys.c - cm_sanriku_system()
  static Future<int> cmSanrikuSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if (pCom.dbTrm.sanrikuFunc != 0) {
      return 1;
    }
    return 0;
  }

  /// 業務モード仕様のフラグを返す
  /// 戻値：0:業務モード仕様ではない  1:業務モード仕様
  /// 関連tprxソース:cm_cksys.c - cm_BusinessMode_system()
  static Future<int> cmBusinessModeSystem() async {
    int res = 0;

    if (CompileFlag.BUSINESS_MODE) {
      RecogValue ret = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_BUSINESS_MODE, RecogTypes.RECOG_GETSYS)).result;
      if (ret != RecogValue.RECOG_NO) {
        res = 1;
      }
      // TS2100接続仕様
      if (cmMmSystem() == 0) {
        res = 0;
      }
      return((res != 0) && (await cmWebType() != CmSys.WEBTYPE_WEB2100 )) ? 1: 0;
    } else {
      return 0;
    }
  }

  /// setmatch仕様のタイプを返す
  /// 戻値：0:setmatch仕様  1:setmatch2仕様
  /// 関連tprxソース:cm_cksys.c - cm_stm_system()
  static int cmStmSystem() {
    return 1;
  }

  /// VPN接続仕様が動作する環境かどうかチェックする
  /// 戻値：0:動作しない  1:動作する
  /// 関連tprxソース:cm_cksys.c - cm_VPNenv_system()
  static Future<int> cmVPNenvSystem() async {
    int res = 0;
    int chk = 0;
    int type;
    int idx;
    String ver;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }

    type = await cmWebType();
    if (type == CmSys.WEBTYPE_WEB2300) {
      ver = "v4.005";
    }
    else if (type == CmSys.WEBTYPE_WEBPLUS) {
      ver = "v5.003";
    }
    else if ((type == CmSys.WEBTYPE_WEB2800 ) ||
        (type == CmSys.WEBTYPE_WEB2500) ||
        (type == CmSys.WEBTYPE_WEB2350)) {
      res = 1;
      return res;
    }
    else {
      return res;
    }

    if (TprxPlatform.getFile('/etc/version_smhd.json').existsSync()) {
      JsonRet versionIni = await getJsonValue('/etc/version_smhd.json', 'submasterhd', 'ver');
      var list1 = versionIni.value.toString().split('');
      var list2 = ver.split('');
      // jsonファイルのバージョンが大きい場合、1を返す
      for (idx = 0; idx < list1.length && idx < list2.length; idx++) {
        if (list1[idx].codeUnits[0] > list2[idx].codeUnits[0]) {
          res = 1;
          break;
        }
        else if(list1[idx].codeUnits[0] < list2[idx].codeUnits[0]) {
          chk = 1;
          break;
        }
      }
      // jsonファイルのバージョンが同じまたは
      // 比較した値がすべて同じかつ桁数が比較対象より大きい場合、1を返す
      if (res == 0 && chk == 0 && list1.length >= list2.length) {
        res = 1;
      }
    }
    return res;
  }

  /// Mcp200仕様のフラグを返す
  /// 戻値：0:Mcp200仕様ではない  1:Mcp200仕様
  /// 関連tprxソース:cm_cksys.c - cm_Mcp200_system()
  static Future<int> cmMcp200System() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Mcp200仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MCP200SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_RWT_CNCT) == 8)) ? 1 : 0;
  }

  /// SP/VT仕様のフラグを返す
  /// 戻値：0:SP/VT仕様ではない  1:SP/VT仕様
  // pvtsystem : 承認キー　0：承認キーなし　1：SP/VT仕様
  // multi_cnct: スペック→周辺装置→マルチ端末機接続
  // 　                    0：しない　1：FCL-C100本番機　-1：FCL-C100開発機　2：FAP-10本番機　-2：FAP-10開発機
  /// 関連tprxソース:cm_cksys.c - cm_SPVT_system()
  static Future<int> cmSPVTSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* SP/VT仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SPVTSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res == 1) &&
       ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == 1 ) ||
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == -1 ) ||
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == 2 ) ||
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_MULTI_CNCT) == -2 ))) ? 1 : 0;
  }

  ///  関連tprxソース:cm_cksys.c - cm_OrderMode_system()
  static Future<int> cmOrderModeSystem() async {
    int res = 0;

    if (CompileFlag.BUSINESS_MODE) {
      RecogValue ret = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_ORDER_MODE, RecogTypes.RECOG_GETSYS)).result;
      if (ret != RecogValue.RECOG_NO) {
        res = 1;
      }
      // TS2100接続仕様
      if (cmMmSystem() == 0) {
        res = 0;
      }
      return ((res != 0) && (await cmWebType() != CmSys.WEBTYPE_WEB2100)) ? 1: 0;
    } else {
      return 0;
    }
  }

  /// 特定交通系1仕様のフラグを返す
  /// 戻値：0:特定交通系1仕様ではない  1:特定交通系1仕様
  /// 関連tprxソース:cm_cksys.c - cm_tb1_system()
  static Future<int> cmTb1System() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TB1_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 免税仕様のフラグを返す
  /// 戻値：0:免税仕様ではない  1:免税仕様
  /// 関連tprxソース:cm_cksys.c - cm_tax_free_system()
  static Future<int> cmTaxFreeSystem() async {
    if (await cmTaxfreeServerSystem() != 0) { //免税電子化の場合は有効とみなす
      return 1;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TAX_FREE_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// 標準CAPS[CARDNET]仕様のフラグを返す
  /// 戻値：0:標準CAPS[CARDNET]仕様ではない  1:標準CAPS[CARDNET]仕様
  /// 関連tprxソース:cm_cksys.c - cm_caps_cardnet_system()
  static Future<int> cmCapsCardnetSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* CAPS[CARDNET]接続仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CAPS_CARDNET_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CREDITSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 == 1) && (res2 == 1)) ? 1 : 0;
  }

  /// ゆめｶｰﾄﾞ決済機接続仕様のフラグを返す
  /// 戻値：0:ゆめｶｰﾄﾞ決済機接続仕様ではない  1:ゆめｶｰﾄﾞ決済機接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_yumeca_system()
  static Future<int> cmYumecaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_YUMECA_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES) || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// 交通系ICﾀﾞﾐｰｼｽﾃﾑ仕様のフラグを返す
  /// 戻値：0:ダミー仕様ではない  1:ダミー仕様
  /// 関連tprxソース:cm_cksys.c - cm_dummy_suica_system()
  static Future<int> cmDummySuicaSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (await cmSuicaSystem() == 0) {
      return 0;
    }
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DUMMY_SUICA, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) || (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    return 0;
  }

  /// Suica仕様のフラグを返す
  /// 戻値：0:Suica仕様ではない  1:Suica仕様
  /// 関連tprxソース:cm_cksys.c - cm_Suica_system()
  static Future<int> cmSuicaSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Suica仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_ICCARDSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_JREM_MULTISYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    return ((res1 != 0) && (res2 == 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_SUICA_CNCT) != 0))? 1: 0;
  }

  /// QUICPay仕様のフラグを返す
  /// 戻値：0:QUICPay仕様ではない  1:QUICPay仕様
  /// 関連tprxソース:cm_cksys.c - cm_QUICPay_system()
  static Future<int> cmQUICPaySystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* QUICPay仕様チェック */
    if (CompileFlag.ARCS_MBR) {
      if (await CmMbrSys.cmNewARCSSystem() != 0) {
        if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
            RecogLists.RECOG_QUICPAYSYSTEM,
            RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
          res = 1;
        }
        return ((res != 0) &&
            ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 3) || /* JET-B手順 */
                (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 10) || /* JET-A手順(標準) */
                ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
                    (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 3)))) ? 1 : 0;
      } else {
        return ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 3) ||
            ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
                (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 3))) ? 1 : 0;
      }
    } else {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_QUICPAYSYSTEM,
          RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        res = 1;
      }
      /* 電子マネー決済仕様チェック */
      else if (await cmCctEmoneySystem() != 0) {
        res = 1;
      }
      return ((res != 0) &&
          ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 3) || /* JET-B手順 */
              (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 10) || /* JET-A手順(標準) */
              ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
                  (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 3)))) ? 1 : 0;
    }
  }

  /// iD仕様のフラグを返す
  /// 戻値：0:iD仕様ではない  1:iD仕様
  /// 関連tprxソース:cm_cksys.c - cm_iD_system()
  static Future<int> cmIDSystem() async {
    int rec = 0;
    int infox = 0;
    int jet_s = 0;

    /* iD仕様チェック */
    if((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_IDSYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      rec = 1;
    }
    /* 電子マネー決済仕様チェック */
    if ((await cmCctEmoneySystem() != 0) || (rec != 0)) {
      if ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 4) ||
          ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
              (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 4)))
      {
        infox = 1;
      }
      if ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 3) ||
          (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 10))
      {
        jet_s = 1;
      }
    }
    return (infox == 1 || jet_s == 1) ? 1 : 0;
  }

  ///  関連tprxソース:cm_cksys.c - cm_Receipt_QR_system()
  static Future<int> cmReceiptQrSystem() async {
    int res1 = 0;
    int res2 = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* QCashier仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_RECEIPT_QR_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_QCASHIER_SYSTEM,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res2 = 1;
    }
    if (cmQCashierJCSystem() != 0) {
      return res1 == 1 ? 1 : 0;
    }

    if (CompileFlag.SMART_SELF) {
      if (await cmDesktopCashierSystem() != 0) {
        if (res1 == 1) {
          return 1;
        }
      }
    }
    return ((res1 == 1) && (res2 == 0)) ? 1 : 0;
  }

  ///  関連tprxソース:cm_cksys.c - cm_sp_department_system()
  static Future<int> cmSpDepartmentSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 特定百貨店仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SP_DEPARTMENT,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      res = 1;
    }
    return res;
  }

  ///  関連tprxソース:cm_cksys.c - cm_AcxErrGui_system()
  static int cmAcxErrGuiSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int acbSelect = AcxCom.ifAcbSelect();
    return ((pCom.dbTrm.acxErrGuiFlg != 0) &&
        (((acbSelect & CoinChanger.ECS_X) != 0) || ((acbSelect & CoinChanger.SST1)) != 0)) ? 1: 0;
  }

  /// 皿勘定仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:皿勘定仕様ではない  1:皿勘定仕様
  /// 関連tprxソース:cm_cksys.c - cm_DishCalc_system()
  static Future<int> cmDishCalcsystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_DISHCALCSYSTEM,
        RecogTypes.RECOG_GETMEM)).result !=RecogValue.RECOG_NO) {
      res = 1;
    }
    return ((res != 0) &&
        (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_DISH_CNCT) != 0)) ? 1: 0;
  }

  /// PiTaPa仕様のフラグを返す
  /// 戻値：0:PiTaPa仕様ではない  1:PiTaPa仕様
  /// 関連tprxソース:cm_cksys.c - cm_PiTaPa_system()
  static Future<int> cmPiTaPaSystem() async {
    int res = 0;
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* PiTaPa仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_PITAPASYSTEM,
        RecogTypes.RECOG_GETMEM)).result !=RecogValue.RECOG_NO) {
      res = 1;
    }
    /* 電子マネー決済仕様チェック */
    else if (await cmCctEmoneySystem() != 0) {
      res = 1;
    }
    return ((res != 0) &&
        ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 4) ||     /* INFOX */
            ((Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 0) &&
                (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_CARD_CNCT) == 4))))? 1: 0;
  }

  /// Tuo仕様のフラグを返す
  /// 戻値：0:Tuo仕様ではない  1:Tuo仕様
  /// 関連tprxソース:cm_cksys.c - cm_Tuo_system()
  static Future<int> cmTuoSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* Tuo仕様チェック */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_TUOCARDSYSTEM,
        RecogTypes.RECOG_GETMEM)).result !=RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// 音声合成装置接続の設定値を返す
  /// 戻値：0:なし、1:HD AIVoice、2:AR-STTS-01
  /// 関連tprxソース:cm_cksys.c - cm_voice_device()
  static Future<int> cmVoiceDevice() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 音声合成装置接続の設定値を返す */
    return Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_AIVOICE_CNCT);
  }

  /// 販売管理バーコード仕様のフラグを返す
  /// 戻値：0:販売管理バーコード仕様ではない  1:販売管理バーコード仕様
  /// 関連tprxソース:cm_cksys.c - cm_SalLmtBar_System()
  static Future<int> cmSalLmtBarSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    /* 販売管理バーコード仕様の設定値を返す */
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_SALLMTBAR,
        RecogTypes.RECOG_GETMEM)).result !=RecogValue.RECOG_NO) {
      return 1;
    }
    return 0;
  }

  /// ＵＳＢディスプレイ(カラー客側表示)に対応しているかチェックする
  /// 0: 対応していない  1: 対応している
  ///  関連tprxソース:cm_cksys.c - cm_USBDispChk()
  static const String PROC_MODULES = "/proc/modules";
  static const String UDLFB = "udlfb";

  static int cmUsbDispChk() {
    int ret = 0;
    if (Platform.isLinux) {
      File file = File(PROC_MODULES);
      try {
        if (file.existsSync()) {
          for (String line in file.readAsLinesSync()) {
            if (line.substring(0, UDLFB.length) == UDLFB) {
              ret = 1;
              break;
            }
          }
        }
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "cmUsbDispChk() $e $s");
      }
    } else if (Platform.isWindows) {
      // TODO:WindowsでＵＳＢディスプレイ対応判定をどのようにするか
      ret = 1;
    } else if (Platform.isAndroid) {
      // TODO:AndroidでＵＳＢディスプレイ対応判定をどのようにするか
      ret = 0;
    }
    return ret;
  }

  /// プリンタタイプ(tprtrpd)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtrpdFileChk() {
    return TprxPlatform.getFile(CmSys.TPRTRP_FILE).existsSync();
  }

  /// プリンタタイプ(tprtrpd2)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtrpd2FileChk() {
    return TprxPlatform.getFile(CmSys.TPRTRP2_FILE).existsSync();
  }

  /// プリンタタイプ(tprtim)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtimFileChk() {
    return TprxPlatform.getFile(CmSys.TPRTIM_FILE).existsSync();
  }

  /// プリンタタイプ(tprtim2)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtim2FileChk() {
    return TprxPlatform.getFile(CmSys.TPRTIM2_FILE).existsSync();
  }

  /// プリンタタイプ(tprtss)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtssFileChk() {
    return TprxPlatform.getFile(CmSys.TPRTSS_FILE).existsSync();
  }

  /// プリンタタイプ(tprtss2)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtss2FileChk() {
    return TprxPlatform.getFile(CmSys.TPRTSS2_FILE).existsSync();
  }

  /// プリンタタイプ(tprthp)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprthpFileChk() {
    return TprxPlatform.getFile(CmSys.TPRTHP_FILE).existsSync();
  }

  /// プリンタタイプ(tprts)の確認のため設定ファイルの存在確認
  /// 関連tprxソース:なし
  static bool cmTprtsFileChk() {
    return TprxPlatform.getFile(CmSys.TPRTS_FILE).existsSync();
  }

  /// 関連tprxソース:cm_cksys.c - cm_QCJC_C_print_check()
  static int cmQCJCCPrintCheck() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
      RxCommonBuf pCom = xRet.object;
      if (pCom.auto_stropncls_run != 0) {
        //自動開閉設で実行中
        return 0; //本体側で印字したい
      }
    }

    if (cmQCJCCSystem() == 1 ||
        cmQCJCCPrintSystem() == 1 ||
        cmQCJCCMntprnSystem() == 1) {
      return 1;
    }
    if (cmQCJCCMainSystem() == 1) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_Kitchen1_print_check()
  static int cmKitchen1PrintCheck() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.kitchen_prn1_run == 0) {
      return 0;
    }
    /* TODO:getpid()から置き換えた要確認 */
    if (pCom.kitchen_prn1 == pid) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_Kitchen2_print_check()
  static int cmKitchen2PrintCheck() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.kitchen_prn2_run == 0) {
      return 0;
    }
    /* TODO:getpid()から置き換えた要確認 */
    if (pCom.kitchen_prn2 == pid) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_print_check()
  static int cmPrintCheck() {
    if (cmQCJCCPrintCheck() == 1) {
      return TprDidDef.TPRDIDRECEIPT4;
    }
    if (cmKitchen1PrintCheck() == 1) {
      return TprDidDef.TPRDIDRECEIPT5;
    }
    if (cmKitchen2PrintCheck() == 1) {
      return TprDidDef.TPRDIDRECEIPT6;
    }
    return TprDidDef.TPRDIDRECEIPT3;
  }

  ///機能：プリンターの種別を返す
  ///引数：なし
  ///戻値： -1    : None
  ///      TPRTSS: SII Web2800i
  ///      TPRTIM: SII Web2800iM
  /// 関連tprxソース:cm_cksys.c - cm_2ndPrinterType()
  static Future<int> cm2ndPrinterType() async {
    int webType;

    webType = await cmWebType();
    if (webType != CmSys.WEBTYPE_WEB2800) {
      return -1;
    }

    if (cmTprtss2FileChk()) {
      /* found 2nd IFD */
      return CmSys.TPRTSS;
    }
    if (cmTprtim2FileChk()) {
      /* found 2nd IFM */
      return CmSys.TPRTIM;
    }
    return -1;
  }

  /// 機能：QCashierJC_C仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:QCashierJC_C仕様ではない  1:QCashierJC_C仕様
  /// 関連tprxソース:cm_cksys.c - cm_QCJC_C_system()
  static int cmQCJCCSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (cmQCashierJCSystem() == 0) {
      return 0;
    }
    if (pCom.qcjc_c == pid) {
      return 1;
    }
    return 0;
  }

  /// 機能：QCashierJC_C仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:QCashierJC_C仕様ではない  1:QCashierJC_C仕様
  /// 関連tprxソース:cm_cksys.c - cm_QCJC_C_print_system()
  static int cmQCJCCPrintSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (cmQCashierJCSystem() == 0) {
      return 0;
    }
    if (pCom.qcjc_c_print == pid) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_QCJC_C_mntprn_system()
  static int cmQCJCCMntprnSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (cmQCashierJCSystem() == 0) {
      return 0;
    }
    if (pCom.qcjc_c_mntprn == pid) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_PushSide()
  static int cmPushSide() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.qcjc_c_except != 0) {
      return 0;
    }
    if (pCom.side_flag == 2) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_QCJC_C_main_system()
  static int cmQCJCCMainSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (cmQCashierJCSystem() == 0) {
      return 0;
    }
    if (pCom.qcjc_c != 0) {
      return 0;
    }
    if (cmPushSide() == 1) {
      return 1;
    }
    return 0;
  }

  /// 機能：プリンターの種別を返す
  /// 引数：なし
  /// 戻値： 0:Web2100 or WebPrime/Rise or Web2200
  ///       1:TPRTS SII Web2300/Web2350/Web2500/WebSpeeza
  ///       2:TPRTF Fujitu WebPlus
  ///       3:TPRTSS SII Web2800i
  ///       4:TPRTIM SII Web2800iM
  ///  関連tprxソース:cm_cksys.c - cm_PrinterType(), cm_PrinterTypeMain()
  static Future<int> cmPrinterType() async {
    return (await cmPrinterTypeMain(0));
  }

  static Future<int> cmPrinterTypeMain(int spec) async {
    int res = 0;
    int webType = 0;

    webType = await cmWebType();

    switch (webType) {
      case CmSys.WEBTYPE_WEB2100:
      case CmSys.WEBTYPE_WEBPRIME:
      case CmSys.WEBTYPE_WEB2200:
        res = CmSys.SUBCPU_PRINTER;
        break;
      case CmSys.WEBTYPE_WEBPLUS:
        res = CmSys.TPRTF;
        break;
      case CmSys.WEBTYPE_WEB2300:
      case CmSys.WEBTYPE_WEB2350:
      case CmSys.WEBTYPE_WEB2500:
        if (((await cmZHQSystem() == 1) && (cmPrintCheck() == TprDidDef.TPRDIDRECEIPT5)) ||
            (cmRm5900System() == 1)) {
          res = CmSys.TPRTIM;
        } else {
          res = CmSys.TPRTS;
        }
        break;
      case CmSys.WEBTYPE_WEB2800:
      case CmSys.WEBTYPE_WEBPLUS2:
        if (cmQCJCCPrintCheck() == 1 && (spec == 0)) {
          if (cmTprtim2FileChk()) {
            res = CmSys.TPRTIM;
          } else if (cmTprtss2FileChk()) {
            res = CmSys.TPRTSS;
          }
        } else {
          if (cmTprtimFileChk()) {
            res = CmSys.TPRTIM;
          } else if (cmTprtssFileChk()) {
            res = CmSys.TPRTSS;
          } else if (cmTprtsFileChk()) {
            if ((await cmZHQSystem() == 1) &&
                (cmPrintCheck() == TprDidDef.TPRDIDRECEIPT5)) {
              res = CmSys.TPRTIM;
            } else {
              res = CmSys.TPRTS;
            }
          } else if (cmTprthpFileChk()) {
            res = CmSys.TPRTHP;
          }
        }
        break;
      default:
        res = CmSys.SUBCPU_PRINTER;
        break;
    }
    return (res);
  }

  /// 機能：RP-D10/RP-E11/その他を判断
  /// 引数：卓上側/タワー側
  /// 戻値：0: その他
  ///      1: RP-D10
  ///      2: RP-E11
  ///      3: RP-F10
  ///  関連tprxソース:cm_cksys.c - cm_RPType()
  Future<int> cmRPType(int side) async {
    if (side == CmSys.TPRTRP_TOWER) {
      // QCJC C Printer
      if (await cm2ndPrinterType() == CmSys.TPRTIM) {
        if (cmTprtrpd2FileChk()) {
          JsonRet type2Json = await getJsonValue(CmSys.TPRTRP2_FILE, 'type', 'type');
          if (type2Json.result) {
            if (type2Json.value == "RP-D") {
              return 1;
            }
            if (type2Json.value == "RP-E") {
              return 2;
            }
            if (type2Json.value == "PT06") {
              return 3;
            }
            if (type2Json.value == "SLP720RT") {
              return 4;
            }
          }
        }
      }
    }
    if (side == CmSys.TPRTRP_DESK) {
      // Desktop Printer
      if (await cmPrinterType() == CmSys.TPRTIM) {
        if (cmTprtrpdFileChk()) {
          JsonRet typeJson = await getJsonValue(CmSys.TPRTRP_FILE, 'type', 'type');
          if (typeJson.result) {
            if (typeJson.value == "RP-D") {
              return 1;
            }
            if (typeJson.value == "RP-E") {
              return 2;
            }
            if (typeJson.value == "PT06") {
              return 3;
            }
            if (typeJson.value == "SLP720RT") {
              return 4;
            }
          }
        }
      }
    }
    return 0;
  }

  /// 機能：電子レシート仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:電子レシート仕様でない
  ///      1:電子レシート仕様
  ///  関連tprxソース:cm_cksys.c - cm_net_receipt_system()
  static Future<int> cmNetReceiptSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_NET_RECEIPT_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return (1);
    }
    return (0);
  }

  /// 機能：メール送信機能の設定有無確認
  /// 引数：なし
  /// 戻値：0:未設定
  ///      1:設定済み
  ///  関連tprxソース:cm_cksys.c - cm_mail_send_system()
  static Future<int> cmMailSendSystem() async {
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MAIL_SEND_SYSTEM, RecogTypes.RECOG_GETMEM))
        .result;
    if (status == RecogValue.RECOG_OK0893 || status == RecogValue.RECOG_YES) {
      return (1);
    }
    return (0);
  }

  /// 機能：メール送信機能（ダミー印刷処理）判定処理
  /// 引数：なし
  /// 戻値：1:ダミー印刷処理
  ///      0:左記以外
  ///  関連tprxソース:cm_cksys.c - cm_dummy_print_myself()
  static Future<int> cmDummyPrintMyself() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if ((await cmMailSendSystem() != 0) || (await cmNetReceiptSystem() != 0)) {
      ; // NOP
    } else {
      return 0;
    }
    if ((pCom.dummy_prn != 0) && (pCom.dummy_prn == pid)) {
      return 1;
    }
    return 0;
  }

  /// 機能：フローティング仕様のマシン番号がセットされているか
  /// 戻値：0:フローティング仕様ではない 0以外:フローティング仕様のマシン番号
  /// 関連tprxソース:cm_cksys.c - cm_chk_rm5900_floating_system()
  static int cmChkRm5900FloatingSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    // RM-3800のフローティング仕様
    if (pCom.vtclRm5900Flg) {
      return pCom.dbTrm.scalermFroatingMacNo;
    } else {
      return 0;
    }
  }

  /// 機能：退店端末用のQR印字フラグを返す
  /// 引数：なし
  /// 戻値：0:退店用QR印字仕様ではない 1:退店用QR印字仕様(ローカル) 2:退店用QR印字仕様(AWS)
  /// 関連tprxソース:cm_cksys.c - cm_leave_qr_system()
  static Future<int> cmLeaveQrSystem(int tid) async {
    /* セルフ関連 - 11.マシン環境 - 退店端末用 QRコード印字 しない/する */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;

    /* 印字する(1) or (2) */
    try {
      if (macInfo.select_self.leave_qr_mode == 1) {
        return (1);
      } else if (macInfo.select_self.leave_qr_mode == 2) {
        return (2);
      }
    } catch (e) {
      /* ini取得失敗 */
      TprLog().logAdd(tid, LogLevelDefine.error, "Ini Get Failed (leave_qr_mode)");
    }
    return (0);
  }

  /// 機能：自動開閉設仕様のタイプを返す。
  /// 引数：なし
  /// 戻値：0:自動開閉設仕様ではない  1:自動開閉設仕様
  /// 関連tprxソース:cm_cksys.c - cm_auto_stropncls_system()
  static int cmAutoStropnclsSystem() {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    if ((pCom.dbTrm.userCd36 & 16 != 0) ||
        (pCom.forceStreClsFlg & 0x01 != 0)) {
      return (1);
    } else {
      return (0);
    }
  }

  /// 機能：顧客リアル[ﾕﾆｼｽ]仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_uni_system()
  static Future<int> cmCustrealUniSystem() async {
    /* 共有メモリポインタの取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }

    /* 顧客リアル[ﾕﾆｼｽ]仕様チェック */
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CUSTREAL_UNI_SYSTEM, RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_YES)
        || (status == RecogValue.RECOG_OK0893)) {
      return 1;
    }
    return 0;
  }

  /// 機能：Ponta仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Ponta仕様ではない  1:Ponta仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_Ponta_system()
  static Future<int> cmCustrealPontaSystem() async {
    int res1 = 0;
    int res2 = 0;
    // TODO:10125 通番訂正 202404実装対象外
    // RECOG_CUSTREAL_PONTAの実装場所を要確認
    // RecogValue status;
    // /* 共有メモリポインタの取得 */
    // RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    // if (xRet.isInvalid()) {
    //   return 0;
    // }
    //
    // /* Ponta仕様チェック */
    // status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
    //     RecogLists.RECOG_CUSTREAL_PONTA, RecogTypes.RECOG_GETMEM)).result;
    // if ((status == RecogValue.RECOG_YES   )
    //     || (status == RecogValue.RECOG_OK0893)) {
    //   res1 = 1;
    // }
    // status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
    //     RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result;
    // if ((status == RecogValue.RECOG_YES)
    //     || (status == RecogValue.RECOG_OK0893)) {
    //   res2 = 1;
    // }
    //
    // return ((res1 != 0) && (res2 != 0))? 1 : 0;
    return 0;
  }

  /// 機能：Rポイント仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Rポイント仕様ではない  1:Rポイント仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_Rpoint_system()
  static int cmCustrealRPointSystem() {
    //TODO:10125 通番訂正 202404実装対象外（0のみ返す）
    return 0;
  }

  /// 機能：J-Brain仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_jbrain_system()
  static int cmJbrainSystem() {
    //TODO:10125 通番訂正 202404実装対象外（0のみ返す）
    return 0;
  }

  /// 機能：VEGA3000が対応する電子マネーブランドが有効であるか判定
  /// 引数：FCL_SERVICE bland : ブランド指定
  /// 戻値：FCL_UNIQ(0) : 指定されたブランドは無効
  ///    ：FCL_SUIC(5) : 交通系ICが有効
  ///    ：FCL_EDY(1)  : Edyが有効
  ///    ：FCL_QP(2)   : QPが有効
  ///    ：FCL_ID(3)   : iDが有効
  /// 関連tprxソース:cm_cksys.c - cm_multi_vega_Tid()
  static Future<int> cmMultiVegaTid(TprMID tid, FclService bland) async {
    int ret = FclService.FCL_UNIQ.value;
    bool isSuccess;
    String dataValue;
    List<String> data = await tccUtsRead();

    if (await cmMultiVegaSystem() == 0) {
      /* VEGA3000電子ﾏﾈｰ仕様以外 */
      return ret;
    }

    switch (bland) {
      case FclService.FCL_QP:
        (isSuccess, dataValue) = getTccUtsTermId(data, "TEM100");
        if (isSuccess) {
          if (int.parse(dataValue) != 0) {
            ret = FclService.FCL_QP.value;
          }
        }
        break;
      case FclService.FCL_ID:
        (isSuccess, dataValue) = getTccUtsTermId(data, "TEM200");
        if (isSuccess) {
          if (int.parse(dataValue) != 0) {
            ret = FclService.FCL_ID.value;
          }
        }
        break;
      case FclService.FCL_SUIC:
        (isSuccess, dataValue) = getTccUtsTermId(data, "TEM300");
        if (isSuccess) {
          if (int.parse(dataValue) != 0) {
            ret = FclService.FCL_SUIC.value;
          }
        }
        break;
      case FclService.FCL_EDY:
        (isSuccess, dataValue) = getTccUtsTermId(data, "TEM600");
        if (isSuccess) {
          if (int.parse(dataValue) != 0) {
            ret = FclService.FCL_EDY.value;
          }
        }
        break;
      default:
        break;
    }
    return ret;
  }

  /// multi_tmn/TccUts.json読み込み
  static Future<List<String>> tccUtsRead() async {
    String filePath =
        "${EnvironmentData().sysHomeDir}/conf/multi_tmn/TccUts.ini";
    File tccUts = TprxPlatform.getFile(filePath);
    List<String> data = [];
    if (Platform.isLinux) {
      List<int> byteList = tccUts.existsSync()
          ? tccUts.readAsBytesSync()
          : [];
      if (byteList.isEmpty) {
        return data;
      }

      // 文字コードがEUC.
      String decode = await CharsetConverter.decode(
          'euc-jp', Uint8List.fromList(byteList));
      data = decode.split("\n");
    }
    return data;
  }

  /// TccUts.iniの指定のセクションのTermIdを取得する.
  static (bool isSuccess, String dataValue) getTccUtsTermId(List<String> data, String section) {
    bool targetSection = false;
    for (var line in data) {
      if (line.contains("[$section]")) {
        targetSection = true;
      } else if (line.contains("[")) {
        targetSection = false;
      }
      if (targetSection) {
        if (line.contains("TermId")) {
          List<String> termId = line.split("=");
          if (termId.length < 2) {
            // 設定なし.
            return (false, "");
          }
          // 左右のスペースは削除.
          return (true, termId[1].trim());
        }
      }
    }
    return (false, "");
  }

  /// 関数：cm_unmanned_shop(void)
  /// 機能：無人店舗仕様を返す
  /// 引数：なし
  /// 戻値：0:無人店舗仕様でない 1:無人店舗仕様である
  /// 関連tprxソース:cm_cksys.c - cm_unmanned_shop()
  static int cmUnmannedShop() {
    // #if 0
    //   RX_COMMON_BUF	*pCom;

    //   /* 共有メモリポインタの取得 */
    //   if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) == RXMEM_OK)
    //   {
    //     return(pCom->ini_macinfo.unmanned_shop);
    //   }
    // #endif

    return 0;
  }

  /// 機能：PCT端末接続かどうか確認する
  /// 引数：なし
  /// 戻値：0:PCT接続していない 1:PCT接続している
  /// 関連tprxソース:cm_cksys.c - cm_pct_connect_system
  static Future<int> cmPctConnectSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if ( (SioChk.sioCheck(Sio.SIO_PCT) == Typ.YES)
          && (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 23)) {
      return 1;
    }
    return 0;
  }

  /// 機能：Tポイント仕様の機能追加仕様フラグを返す
  /// 引数：[typ]機能の種類
  /// 戻値：0:機能追加仕様ではない  1:機能追加仕様
  /// 関連tprxソース:cm_cksys.c - cm_tpoint_advanced_system
  static Future<int> cmTpointAdvancedSystem(int typ) async {
    if (!(await cmTpointSystem() != 0)) {
      return 0;
    }

    switch (typ) {
      case 1: // ポイント利用キー押下時に還元通信を行う仕様
        break;
      case 2: // ポイント利用画面を表示する仕様
        break;
      default:
        break;
    }
    return 0;
  }

  /// 機能：フローティング仕様のマシン番号を取得
  /// 引数：なし
  /// 戻値：0:フローティング仕様ではない 0以外:フローティング仕様のマシン番号
  /// 関連tprxソース:cm_cksys.c - cm_chk_rm5900_floating_mac_no
  static Future<int> cmChkRm5900FloatingMacNo() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    // RM-3800のフローティング仕様
    return pCom.dbTrm.scalermFroatingMacNo;
  }

  /// 機能：友の会 利用可能なレジか
  /// 引数：なし
  /// 戻値：0:無効 1：有効
  /// 関連tprxソース:cm_cksys.c - cm_QC_tomoIF_system
  static Future<int> cmQCTomoIFSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }

    // 友の会承認キーなし
    if (!(await cmTomoIFSystem() != 0)) {
      return 0;
    }
    return 1;
  }

  /// 機能：RM-3800 ハイタッチ接続仕様
  /// 引数：なし
  /// 戻値：0:ハイタッチ接続ではない 1：ハイタッチ接続
  /// 関連tprxソース:cm_cksys.c - cm_chk_rm5900_hitouch_system
  static Future<int> cmChkRm5900HiTouchSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    // // RM-3800のハイタッチ接続
    if (pCom.vtclRm5900Flg) {
      return pCom.iniMacInfo.internal_flg.hitouch_cnct;
    }
    else {
      return 0;
    }
  }

  /// 機能：RM-3800 ハイタッチ接続仕様
  /// 引数：なし
  /// 戻値：0:ハイタッチ接続ではない 1：ハイタッチ接続
  /// 関連tprxソース:cm_cksys.c - cm_chk_rm5900_hitouch_mac_no
  static Future<int> cmChkRm5900HiTouchMacNo() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    // // RM-3800のハイタッチ接続
    if (pCom.vtclRm5900Flg) {
      return pCom.dbTrm.hiTouchMacNo;
    }
    else {
      return 0;
    }
  }

  /// 機能：インボイス仕様フラグを返す
  /// 引数：なし
  /// 戻値：0:インボイス仕様ではない　1：インボイス仕様
  /// 関連tprxソース:cm_cksys.c - cm_invoice_system
  static Future<int> cmInvoiceSystem() async {
    if (CompileFlag.INVOICE_SYSTEM) {
      return 1;
    }
    return 0;
  }

  /// 機能：顧客リアル[SM66]仕様(フレスタ様)のフラグを返す。
  /// 引数：なし
  /// 戻値：0:顧客リアル[SM66]仕様ではない  1:顧客リアル[SM66]仕様
  /// 関連tprxソース:cm_cksys.c - cm_custreal_fresta_system
  static Future<int> cmCustrealFrestaSystem() async {
    if (await cmSm66FrestaSystem() != 0) {
      return 1;
    }
    return 0;
  }

  /// 機能：Pack on Time系(POS単品実績送信を含む)の仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Pack on Time系の仕様でない 1:Pack On Time系の仕様
  /// 関連tprxソース:cm_cksys.c - cm_pot_group_system
  static Future<int> cmPotGroupSystem() async {
    if ( (await cmPackOnTimeSystem() != 0)
        || await cmPackOnTimeTgateSystem() != 0) {
      return 1;
    }
    return 0;
  }

  /// 機能：旧楽天ポイント仕様の判定関数を追加
  /// 引数：なし
  /// 戻値：0:無効、1:有効
  /// 関連tprxソース:cm_cksys.c - cm_rpoint_old_system
  static Future<int> cmRpointOldSystem() async {
    if (!(await cmRpointSystem() != 0)) {
      return 0;
    }
    if (await cmSm66FrestaSystem() != 0) {
      return 1;
    }
    return 0;
  }

  /// 機能：周辺装置接続状況
  /// 引数：なし
  /// 戻値：
  /// 関連tprxソース:cm_cksys.c - cm_Cnct_Info_Chk
  static Future<int> cmCnctInfoChk() async {
    int cnct = 0;
    if (await cmAcxCnct() != 0) {
      cnct |= CmSys.CNCT_INFO_ACX;
    }
    return cnct;
  }

  /// 機能：対面セルフ会員カード読込が有効か判断する(ライブラリレイヤ用)
  /// 引数：なし
  /// 戻値：0:対面セルフ会員カード読込が有効 1:対面セルフ会員カード読込が無効
  /// 関連tprxソース:cm_cksys.c - cm_fself_mbrscan_2nd_scanner_use
  static Future<int> cmFSelfMbrScan2ndScannerUse() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (!(cmChkVtclFHDFselfSystem() != 0)) {
      // 縦型フルHD対面対応ではない
      return 0;
    }
    if (!(await cmHappySelfSystem() != 0)) {
      // HappySelfではない
      return 0;
    }
    if (await cmQuickSelfSystem() != 0) {
      // QuickSelfは対象外
      return 0;
    }
    if (await cmShopAndGoSystem() != 0) {
      // Shop&Goは対象外
      return 0;
    }
    if (pCom.iniMacInfo.select_self.self_mode == 1) {
      // フルセルフモード
      return 0;
    }
    if (pCom.iniMacInfo.select_self.qc_mode == 1) {
      // 精算機モード
      return 0;
    }
    return pCom.dbTrm.frontSelfMbrscanFlg;
  }

  /// 機能：置数プリペイド対応のプリカ仕様が有効か判定する
  /// 引数：なし
  /// 戻値：0:無効 1:有効
  /// 関連tprxソース:cm_cksys.c - cm_entrypreca_system
  static Future<int> cmEntryPrecaSystem() async {
    if (   (await cmCogcaSystem() != 0)
        || (await cmRepicaSystem() != 0)
        || (await cmValueCardSystem() != 0)
        || (await cmAjsEmoneySystem() != 0) ) {
      return 1;
    }
    return 0;
  }

  /// 機能：セミセルフ対応の後通信仕様[置数○○仕様]が有効か判定する
  /// 引数：なし
  /// 戻値：0:無効 1:有効
  /// 関連tprxソース:cm_cksys.c - cm_SSlastcomm_system()
  static Future<int> cmSSlastcommSystem() async {
    if (await cmEntryPrecaSystem() != 0) {
      return 1;
    }
    return 0;
  }

  /// 機能：顧客ﾘｱﾙ[CP]仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:顧客ﾘｱﾙ[CP]仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_custreal_crosspoint()
  static Future<int> cmCustrealCrossPoint() async {
    int res1 = 0;
    int res2 = 0;

    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_CUSTREAL_CROSSPOINT, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      res1 = 1;
    }
    status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      res2 = 1;
    }
    return (res1 != 0 && res2 != 0 ? 1 : 0);
  }

  /// 機能：特定SM59仕様[タカラ・エムシー様仕様]の有効性判定処理
  /// 引数：なし
  /// 戻値：0:無効、1:有効
  /// /// 関連tprxソース:cm_cksys.c - cm_sm59_takaramc_system()
  static Future<int> cmSm59TakaraMCSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM59_TAKARAMC_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：分類別明細非印字仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:類明細非印字仕様[ファルマ]
  /// /// 関連tprxソース:cm_cksys.c - cm_detail_noprn_system()
  static Future<int> cmDetailNoprnSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_DETAIL_NOPRN_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定SM61仕様[富士フィルムシステム(ゲオリテール)様]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定SM61仕様[富士フィルムシステム(ゲオリテール)様]
  /// /// 関連tprxソース:cm_cksys.c - cm_sm61_fujifilm_system()
  static Future<int> cmSm61FujifilmSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM61_FUJIFILM_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定百貨店2仕様[さくら野百貨店様]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定百貨店2仕様[さくら野百貨店様]
  /// /// 関連tprxソース:cm_cksys.c - cm_department2_system()
  static Future<int> cmDepartment2System() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_DEPARTMENT2_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定HC12仕様[ジョイフル本田]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定HC12仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_hc12_joyful_honda_system()
  static Future<int> cmHC12JoyfulHondaSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_HC12_JOYFUL_HONDA_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：stera terminal仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:stera terminal仕様しない 1:stera terminal仕様する
  /// /// 関連tprxソース:cm_cksys.c - cm_stera_terminal_system()
  static Future<int> cmSteraTerminalSystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_STERA_TERMINAL_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：顧客リアル仕様[ダミーシステム]のフラグを返す
  /// 引数：なし
  /// 戻値：0:顧客リアル仕様[ダミーシステム]ではない  1:顧客リアル仕様[ダミーシステム]
  /// /// 関連tprxソース:cm_cksys.c - cm_custreal_dummy_system()
  static Future<int> cmCustrealDummySystem() async {
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_CUSTREAL_DUMMY_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定SM56仕様[神戸物産]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定SM56仕様[神戸物産]
  /// /// 関連tprxソース:cm_cksys.c - cm_sm56_kobebussan_system()
  static Future<int> cmSm56KobeBussanSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM56_KOBEBUSSAN_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定HYS1仕様[セリア]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定HYS1仕様[セリア]
  /// /// 関連tprxソース:cm_cksys.c - cm_hys1_seria_system()
  static Future<int> cmHys1SeriaSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_HYS1_SERIA_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：酒税免税仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:酒税免税仕様でない 1:酒税免税仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_liqr_taxfree_system()
  static Future<int> cmLiqrTaxfreeSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    if (!(await cmTaxFreeSystem() != 0)) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_TAX_FREE_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：顧客リアル[SM56]仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:顧客リアル[SM56]仕様ではない  1:顧客リアル[SM56]仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_custreal_gyomuca_system()
  static Future<int> cmCustrealGyomucaSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_CUSTREAL_GYOMUCA_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定SM62仕様(マルイチ様)のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定SM62仕様ではない 1:特定SM62仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_sm62_maruichi_system()
  static Future<int> cmSm62MaruichiSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM62_MARUICHI_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定SM65仕様(リウボウ様)のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定SM65仕様ではない 1:特定SM65仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_sm65_ryubo_system()
  static Future<int> cmSm65RyuboSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM65_RYUBO_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：友の会仕様[リウボウストア様]のチェック
  /// 引数：なし
  /// 戻値：0:未設定 1:設定済み
  /// 関連tprxソース:cm_cksys.c - cm_tomoIF_system()
  static Future<int> cmTomoIFSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_TOMOIF_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：トータルログへの格納判定関数
  /// 引数：なし
  /// 戻値：0 :トータルログに格納しない 1 :トータルログに格納する
  /// /// 関連tprxソース:cm_cksys.c - cm_judge_ttllog()
  static Future<int> cmJudgeTtllog() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    // RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_PAYCLS2_SYSTEM, RecogTypes.RECOG_GETMEM);
    // if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
    //   return 1;
    // }
    return 0;
  }

  /// 機能：Pack On Time仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Pack On Time仕様でない 1:Pack On Time仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_pack_on_time_system()
  static Future<int> cmPackOnTimeSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_PACK_ON_TIME_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：Pack On Time仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Pack On Time仕様でない 1:Pack On Time仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_pack_on_time_tgate_system()
  static Future<int> cmPackOnTimeTgateSystem() async {
    // // 共有メモリポインタの取得
    // RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    // if (xRet.isInvalid()) {
    //   return 0;
    // }
    // RxCommonBuf pCom = xRet.object;
    // RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_PACK_ON_TIME_SYSTEM, RecogTypes.RECOG_GETMEM);
    // if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
    //   return 1;
    // }
    return 0;
  }

  /// 機能：特定SM71仕様[セレクション]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定SM71仕様[セレクション]
  /// /// 関連tprxソース:cm_cksys.c - cm_sm71_selection_system()
  static Future<int> cmSm71SelectionSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM71_SELECTION_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：ｷｯﾁﾝﾌﾟﾘﾝﾀﾚｼｰﾄ印字仕様[角田市役所様]のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:ｷｯﾁﾝﾌﾟﾘﾝﾀﾚｼｰﾄ印字仕様[角田市役所様]
  /// /// 関連tprxソース:cm_cksys.c - cm_kitchen_print_recipt()
  static Future<int> cmKitchnPrintRecipt() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_KITCHEN_PRINT_RECIPT, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定TOY仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定TOY仕様ではない 1:特定TOY仕様
  /// /// 関連tprxソース:cm_cksys.c - cm_toy_system()
  static Future<int> cmToySystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_TOY_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：宮崎市役所市民課仕様(特定地公体2仕様)のフラグを返す
  /// 引数：なし
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_miyazaki_city_system()
  static Future<int> cmMiyazakiCitySystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MIYAZAKI_CITY_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定公共料金4仕様[角田市役所様]のフラグを返す
  /// 引数：なし
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_public_barcode_pay4_system()
  static Future<int> cmPublicBarcodePay4System() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_PUBLIC_BARCODE_PAY4_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：現金支払限定仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_cashonly_keyopt_system()
  static Future<int> cmCashOnlyKeyOptSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_CASHONLY_KEYOPT_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：バリューデザイン社　バリューカード仕様のフラグを返す。
  /// 引数：なし
  /// 戻値：0:上記仕様ではない  1:上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_valuecard_system()
  static Future<int> cmValueCardSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_VALUECARD_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：オオゼキ様仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:仕様でない 1:特定SM74仕様[オオゼキ]
  /// 関連tprxソース:cm_cksys.c - cm_sm74_ozeki_system()
  static Future<int> cmSm74OzekiSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_SM74_OZEKI_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：駐車場QRコード印字仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:駐車場QRコード印字仕様ではない 1:駐車場QRコード印字仕様
  /// 関連tprxソース:cm_cksys.c - cm_carparking_qr_system()
  static Future<int> cmCarParkingQRSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_CARPARKING_QR_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定OLC仕様[オリエンタルランド様]のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定OLC仕様ではない 1:特定OLC仕様
  /// 関連tprxソース:cm_cksys.c - cm_olc_system()
  static Future<int> cmOlcSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_OLC_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：Lane[JET-S]接続仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:Lane[JET-S]接続仕様ではない 1:Lane[JET-S]接続仕様
  /// 関連tprxソース:cm_cksys.c - cm_jets_lane_system()
  static Future<int> cmJetsLaneSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_JETS_LANE_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：特定コスメ1仕様[アイスタイルリテイル様]のフラグを返す
  /// 引数：なし
  /// 戻値：0:特定コスメ1仕様でない 1:特定コスメ1仕様
  /// 関連tprxソース:cm_cksys.c - cm_cosme1_istyle_system()
  static Future<int> cmCosme1IstyleSystem() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RecogRetData status = await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_COSME1_ISTYLE_SYSTEM, RecogTypes.RECOG_GETMEM);
    if((status.result == RecogValue.RECOG_OK0893) || (status.result == RecogValue.RECOG_YES)){
      return 1;
    }
    return 0;
  }

  /// 機能：退店端末用のQR印字方式をチェックする
  /// 引数：tid
  /// 戻値：0:分割印字 1:結合印字
  /// 関連tprxソース:cm_cksys.c - cm_leave_qr_print_pattern_chk()
  static Future<int> cmLeaveQRPrintPatternChk(TprTID tid) async {
    /* セルフ関連 - 11.マシン環境 - 退店端末用 QRコード印字 しない/する */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;

    /* 印字する(1) or (2) */
    try {
      if (macInfo.select_self.leave_qr_prn_ptn == 0) {
        return 0; //分割印字
      }
      else if (macInfo.select_self.leave_qr_prn_ptn == 1) {
        return 1; //結合印字
      }
    } catch (e) {
      /* ini取得失敗 */
      TprLog().logAdd(tid, LogLevelDefine.error, "Ini Get Failed (leave_qr_prn_ptn)");
    }
    return 0;
  }

  /// 機能：WebシリーズとRMシリーズの連鎖運用(共通)
  /// 引数：なし
  /// 戻値：0:連鎖しない 1：連鎖する
  /// 関連tprxソース:cm_cksys.c - cm_chk_web_and_rm_system()
  static int cmChkWebAndRmRSystem() {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    // WebシリーズとRMシリーズの連鎖運用
    if (pCom.dbTrm.webAndRmNetwork != 0) {
      return 1;
    }
    else {
      return pCom.vtclRm5900Flg ? 1 : 0; // RM-3800
    }
  }

  /// 機能：WebシリーズとRMシリーズの連鎖運用(登録モード専用)
  /// 引数：なし
  /// 戻値：0:連鎖しない 1：連鎖する
  /// 関連tprxソース:cm_cksys.c - cm_chk_web_and_rm_regs_system()
  static int cmChkWebAndRmRegsSystem() {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    // WebシリーズとRMシリーズの連鎖運用
    if (pCom.dbTrm.webAndRmNetwork != 0) {
      return 1;
    }
    else {
      return pCom.vtclRm5900RegsOnFlg ? 1 : 0; // RM-3800
    }
  }

  /// 機能：新楽天ポイント仕様かチェック
  /// 引数：なし
  /// 戻値： RPOINT_STD_NON	:キャンペーン処理なし
  ///       RPOINT_STD_NISHITETSU	:キャンペーン処理[西鉄ストア様向け]
  ///       RPOINT_STD_SUNPLAZA	:キャンペーン処理[サンプラザ様向け]
  /// 関連tprxソース:cm_cksys.c - cm_Check_Rpoint_Standard()
  static Future<int> cmCheckRpointStandard() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return RpointStdTypeList.RPOINT_STD_NON.idx;
    }
    if (!(await cmCheckRpointStandard() != 0)) {
      return RpointStdTypeList.RPOINT_STD_NON.idx;
    }
    if (cmMatugenSystem() != 0) {
      RxCommonBuf pCom = xRet.object;
      Mac_infoJsonFile macInfo = pCom.iniMacInfo;

      JsonRet jsonRet =
      await macInfo.getValueWithName('comm_dest', 'destination');

      if (!jsonRet.result) {
        return RpointStdTypeList.RPOINT_STD_NON.idx;
      }
      else {
        if (jsonRet.value == 1) {
          return RpointStdTypeList.RPOINT_STD_MATUGEN.idx;
        }
        else {
          return RpointStdTypeList.RPOINT_STD_NON.idx;
        }
      }
    }
    if (await cmTb1System() != 0) { /* 特定交通系１仕様（西鉄ストア様） */
      return RpointStdTypeList.RPOINT_STD_NISHITETSU.idx;
    }
    if (await cmSm36SanprazaSystem() != 0) {
      return RpointStdTypeList.RPOINT_STD_SUNPLAZA.idx;
    }
    // 汎用ユーザー向けとして処理
    return RpointStdTypeList.RPOINT_STD_USER.idx;
  }

  /// 機能：新楽天ポイントのキャンペーン処理を行う仕様かチェック
  /// 引数：なし
  /// 戻値： RPOINT_STD_NON	:キャンペーン処理なし
  ///       RPOINT_STD_NISHITETSU	:キャンペーン処理[西鉄ストア様向け]
  ///       RPOINT_STD_SUNPLAZA	:キャンペーン処理[サンプラザ様向け]
  /// 関連tprxソース:cm_cksys.c - cm_Check_Rpoint_Campaign()
  static Future<int> cmCheckRpointCampaign() async {
    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return RpointStdTypeList.RPOINT_STD_NON.idx;
    }
    if (!(await cmCheckRpointStandard() != 0)) {
      return RpointStdTypeList.RPOINT_STD_NON.idx;
    }
    if (await cmTb1System() != 0) {
      return RpointStdTypeList.RPOINT_STD_NISHITETSU.idx;
    }
    else if (await cmSm36SanprazaSystem() != 0) {
      return RpointStdTypeList.RPOINT_STD_SUNPLAZA.idx;
    }
    if (cmMatugenSystem() != 0) { /* 松源様 */
      return RpointStdTypeList.RPOINT_STD_MATUGEN.idx;
    }
    return RpointStdTypeList.RPOINT_STD_NON.idx;
  }

  /// 機能：楽天ポイントのレシートクーポン処理を行う仕様かチェック
  /// 引数：なし
  /// 戻値： RPOINT_STD_NON	:レシートクーポン処理なし
  /// 関連tprxソース:cm_cksys.c - cm_Check_Rpoint_Coupon()
  static Future<int> cmCheckRpointCoupon() async {
    if (!(await cmCheckRpointStandard() != 0)) {
      return RpointStdTypeList.RPOINT_STD_NON.idx;
    }
    return RpointStdTypeList.RPOINT_STD_NON.idx;
  }

  /// 機能：セルフシステムを判定する
  /// 引数：なし
  /// 戻値： 0:セルフ関連仕様でない  1:セルフ関連仕様
  /// 関連tprxソース:cm_cksys.c - cm_qcashier_self_system
  static Future<int> cmQcashierSelfSystem() async {
    int ret = 0;

    if ((await cmQCashierSystem() == 1) // ＱＣａｓｈｉｅｒ仕様
        || (await cmSelfSystem() == 1) // セルフシステム
        || (await cmFrontSelfSystem() == 1)){ // 対面セルフシステム
      ret = 1;
    }
    if (CompileFlag.SMART_SELF) {
      if(await cmHappySelfSystem() == 1){ // HappySelf
        ret = 1;
      }
    }
    return ret;
  }

  /// 機能：従業員権限解除仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0=上記仕様でない  1=上記仕様
  /// 関連tprxソース:cm_cksys.c - cm_staff_release_system()
  static Future<int> cmStaffReleaseSystem() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    // 従業員権限解除仕様チェック
    RecogValue status = (await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
    RecogLists.RECOG_STAFF_RELEASE_SYSTEM,
    RecogTypes.RECOG_GETMEM)).result;
    if ((status == RecogValue.RECOG_OK0893) ||
        (status == RecogValue.RECOG_YES)) {
      return 1;
    }
    if (await cmDs2GodaiSystem() != 0) {
      return 1;
    }

    return 0;
  }

  /// 機能：QCashier.ini設定の顧客関連を有効にする条件のチェック
  /// 引数：なし
  /// 戻値：0=無効  1=有効
  /// 関連tprxソース:cm_cksys.c - cm_QC_cust_setting_system()
  static Future<int> cmQCCustSettingSystem() async {
    if (await cmCogcaSystem() != 0) {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        return 1;
      }
    } else if (await cmHC12JoyfulHondaSystem()!= 0) {
      return 1;
    } else if (await cmTpointSystem() != 0) {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        return 1;
      }
    } else if (await cmSm66FrestaSystem() != 0) {
      return 1;
    } else if (await cmDpointSystem() != 0) {
      if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
        return 1;
      }
    }

    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - cm_TwoConnect_Checker()
  static Future<bool> cmTwoConnectChecker() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((pCom.iniMacInfo.system.twoconnect == 1) &&
        (await CmCksys.cmReceiptQrSystem() == 1)
    ) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース:cm_cksys.c - cm_TwoConnect_Cashier()
  static Future<bool> cmTwoConnectCashier() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    if ((pCom.iniMacInfo.system.twoconnect == 1) &&
        (await CmCksys.cmReceiptQrSystem() == 0)) {
      return true;
    }
    return false;
  }

  /// クレジット端末Vega接続のフラグを返す
  /// 戻り値: 0=未接続  1=接続中
  /// 関連tprxソース:cm_cksys.c - cm_crdt_vega_system()
  static int cmCrdtVegaSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }

    /* Vega接続チェック */
    if (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 19) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース:cm_cksys.c - rcsyschk_ponta_self_system()
  static Future<int> rcsyschkPontaSelfSystem() async {
    if((await cmCustrealPontaSystem()) != 0) {
      if(  (await RcSysChk.rcChkSmartSelfSystem())				    /* HappySelf仕様 */
        && (! (await RcSysChk.rcSysChkHappySmile()))				  /* HappySelf対面モードでない */
        && (! (await RcSysChk.rcChkHappySelfQCashier())) ) {  /* QC切替を行っていない */
        return (1);
      } else if( (await RcSysChk.rcChkShopAndGoSystem()) ) {  /* Shop&Go仕様 */
        return (1);
      }
    }
    return (0);
  }


  // 機能：特定SM39仕様[カスミ]のフラグを返す
  // 引数：なし
  // 戻値：false:仕様でない true:特定SM39仕様[カスミ]
  // TODO:定義のみ追加
  /// 関連tprxソース:cm_cksys.c - cm_sm39_kasumi_system()
  static Future<bool> cmSm39KasumiSystem() async {
    // int		status = 0;
    // RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    // if (xRet.isInvalid()) {
    //   return false;
    // }
    // RxCommonBuf pCom = xRet.object;
    // status = await Recog.recogGetInt(
    //         Tpraid.TPRAID_SYSTEM
    //       , RecogLists.RECOG_SM39_KASUMI_SYSTEM
    //       , RecogTypes.RECOG_GETMEM);
    // if ( (status == RecogValue.RECOG_OK0893.index) || (status == RecogValue.RECOG_YES.index) ) {
    //   return(true);
    // }
    return(false);
  }

  //  機能：特定SM40仕様[よねや商事]のフラグを返す
  /// 関連tprxソース:cm_cksys.c - cm_sm40_yoneya_system()
  // TODO:定義のみ追加
  static bool cmSm40YoneyaSystem() {
    return false;
  }

  /// 関連tprxソース:cm_cksys.c - cm_sm19_nishimuta_system
  // TODO:定義のみ追加
  static int cmSm19NishimutaSystem() {
    return(0);
  }
  
  /// CPUBoxのタイプを返す
  /// 関連tprxソース:cm_cksys.c - cm_CPUBoxChk()
  /// @return 0: 旧型, 1: 一体型
  static int cmCPUBoxChk() {
    if (File(CPUBOX_FLAG).existsSync()) {
      return 0;
    }

    return 1;
  }
  
  /// 機能：ラルズ仕様のフラグを返す
  /// 引数：なし
  /// 戻値：0:ラルズ仕様でない 1:ラルズ仕様
  /// 関連tprxソース:cm_cksys.c - cm_arcs_system()
  static int cmArcsSystem() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    return pCom.dbTrm.arcsCompFlg;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:cm_cksys.c - cm_reason_select_std_system
  static int cmReasonSelectStdSystem(){
    return 0;
  }


}

/// アプリパス格納用（SubIsolateからJsonファイルを読み取るのに必要）
class AppPath {
  String _path = ""; //Null非許可のため、インスタンスが必要

  set path(String p) {
    _path = p;
    // 設定ファイル読み込み用パスにもセット.
    JsonPath().absolutePath = p;
  }

  String get path => _path;

  static final AppPath _cache = AppPath._internal();

  factory AppPath() {
    return _cache;
  }

  AppPath._internal();
}
