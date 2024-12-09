/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/regs/inc/rc_mem.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_std_add.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../checker/rcsyschk.dart';

/// 関連tprxソース: rcrctfil.c
class RcRctFil{
/// レシートバッファファイルアクセス定義
/*-----  戻り値  -----*/
  static const RCRCT_OK = 0;		/* 正常終了 */
  static const RCRCT_NG = -1;		/* 異常終了 */

/*-----  フラグ定義  -----*/
  static const RCRCT_READ = 0;       /* 読み込み */
  static const RCRCT_WRITE = 1;       /* 書き込み */
  static const RCRCT_CHECK = 2;		/* データチェック */
  static const RCRCT_INIT = 3;		/* 初期化 */
  static const RCRCT_MODE = 4;		/* モードチェック */

/*----- -----*/
  static const SUSMULFLTOP =	"SUSMULTI";
  static const RCRCT_DIRECTORY = "/tmp/regs/";
  static const TABFLTOP = "TABSUS";
  static const TABFLTOPCHK = "TABCHKSUS";
  static const SUSMULFLTOPCHK = "SUSCHKMULTI";

/// デファイン
//#define RCRCT_DIRECTORY "/tmp/regs/"
  static const RCRCT_CHK = 0;
  static const RCRCT_CASH = 1;

  /// 関数：int rcChkRctFile(REGSMEM *regsmem, ACMEM *acmem, int mode)
  /// 機能：チェッカー仮締ファイルアクセス
  /// 引数：*regsmem レシートバッファのポインタ
  /// ：      (RCRCT_CHK RCRCT_INITはNULL指定可)
  /// ：*acmem 登録メモリバッファのポインタ
  /// ：      (RCRCT_CHK RCRCT_INITはNULL指定可)
  /// ：mode アクセスモード
  /// ：  RCRCT_READ  読み込み
  /// ：  RCRCT_WRITE 書き込み
  /// ：  RCRCT_CHECK データチェック
  /// ：  RCRCT_INIT  初期化
  /// ：  RCRCT_MODE  モードチェック(登録 / 訓練 / 訂正 / 廃棄)
  /// 戻値：RCRCT_OK / RCRCT_NG
  /// 関連tprxソース: rcrctfil.c - rcChkRctFile
  static Future<int> rcChkRctFile(RegsMem regsMem, AcMem acMem, int mode) async {
    return await rcRctFileMain(regsMem, acMem, mode, RCRCT_CHK);
  }

  /// 関数：int rcRctFileMain(REGSMEM *regsmem, ACMEM *acmem, int mode, int chk_cash)
  /// 機能：仮締ファイルアクセスメイン関数
  /// 引数：*regsmem レシートバッファのポインタ
  /// ：*acmem 登録メモリバッファのポインタ
  /// ：mode アクセスモード
  /// ：chk_cash チェッカー／キャッシャー区分
  /// 戻値：RCRCT_OK / RCRCT_NG
  /// 関連tprxソース: rcrctfil.c - rcRctFileMain
  static Future<int> rcRctFileMain(
      RegsMem regsMem, AcMem acMem, int mode, int chkCash) async {
    int result = 0;
    String tprPath = '';
    String enptyName = '';
    String usedName = '';
    RegsMem regsMemInit = RegsMem();
    AcMem acMemInit = AcMem();

    await EnvironmentData().tprLibGetEnv();
    tprPath = EnvironmentData().sysHomeDir;
    /* ホームディレクトリパス取得 */
    if (tprPath.isEmpty) {
      return RCRCT_NG;
    }

    /* 未使用ファイル名の取得 */
    enptyName = CmAry.setStringZero(128);
    enptyName = enptyName + tprPath;
    enptyName = enptyName + RCRCT_DIRECTORY;
    if (chkCash == RCRCT_CHK) {
      enptyName = '${enptyName}SUS1100.TMP';
    } else {
      enptyName = '${enptyName}SUS2100.TMP';
    }

    /* 使用中ファイル名の取得 */
    usedName = CmAry.setStringZero(128);
    usedName = usedName + tprPath;
    usedName = usedName + RCRCT_DIRECTORY;
    if (chkCash == RCRCT_CHK) {
      usedName = '${usedName}SUS1100.\$MP';
    } else {
      usedName = '${usedName}SUS2100.\$MP';
    }

    /* ファイルアクセス */
    switch (mode) {
      case RCRCT_READ:
      case RCRCT_CHECK:
      case RCRCT_MODE:
        result = rcRctFileRead(regsMem, acMem, usedName, mode);
        if (mode == RCRCT_READ) {
          // TODO:00013 三浦 renameの使い方合ってる？
          AplLibStdAdd.aplLibRename(
              await RcSysChk.getTid(), usedName, enptyName);
        }
        break;
      case RCRCT_WRITE:
        if (rcRctFileRead(regsMem, acMem, enptyName, RCRCT_CHECK) != RCRCT_OK) {
          result = RCRCT_NG;
          break;
        }
        result = await rcRctFileWrite(regsMem, acMem, enptyName);
        // TODO:00013 三浦 renameの使い方合ってる？
        AplLibStdAdd.aplLibRename(await RcSysChk.getTid(), enptyName, usedName);
        break;
      case RCRCT_INIT:
        result = RCRCT_OK;
        if ((rcRctFileRead(regsMem, acMem, enptyName, RCRCT_CHECK) !=
                RCRCT_OK) &&
            (rcRctFileRead(regsMem, acMem, usedName, RCRCT_CHECK) !=
                RCRCT_OK)) {
          // memset(&regsMeminit, 0, sizeof(regsMeminit));
          // memset(&acMeminit, 0, sizeof(acMeminit));
          result = await rcRctFileWrite(regsMemInit, acMemInit, enptyName);
        }
        break;
      default:
        result = RCRCT_NG;
        break;
    }

    return result;
  }

  /// 関数：int rcRctFileRead(REGSMEM *regsmem, ACMEM *acmem, char *filename, int mode)
  /// 機能：仮締ファイル読み込み
  /// 引数：*regsmem レシートバッファのポインタ
  /// ：*acmem 登録メモリバッファのポインタ
  /// ：*filename   読み込みファイル名
  /// ：mode アクセスモード
  /// 戻値：RCRCT_OK / RCRCT_NG
  /// 関連tprxソース: rcrctfil.c - rcRctFileRead
  static int rcRctFileRead(RegsMem regsMem, AcMem acMem, String fileName, int mode) {
    int handle = 0;
    int size = 0;
    RegsMem regsMemBuf = RegsMem();
    AcMem acMemBuf = AcMem();

    /* ファイルオープン */
    if (!TprxPlatform.getFile(fileName).existsSync()) {
      return RCRCT_NG;
    }

    if (mode == RCRCT_CHECK) {
      return RCRCT_OK;
    }

    // TODO:00013 三浦 後回し
    // /* ファイル読み込み(レシートバッファ部) */
    // size = regsMemBuf;
    // if (read(handle, &regsmembuf, size) != size) {
    // return RCRCT_NG;
    // }

    /* モードを返す */
    if (mode == RCRCT_MODE) {
      return regsMemBuf.tHeader.ope_mode_flg;
    }

    // TODO:00013 三浦 後回し
    // /* ファイル読み込み(登録メモリ部) */
    // memset(&acmembuf, 0, sizeof(acmembuf));
    // size = sizeof(ACMEM);
    // if (read(handle, &acmembuf, size) != size) {
    // close(handle);
    // return RCRCT_NG;
    // }

    // TODO:00013 三浦 後回し
    // memcpy(regsmem, &regsmembuf, sizeof(REGSMEM));
    // memcpy(acmem, &acmembuf, sizeof(ACMEM));
    return RCRCT_OK;
  }

  /// 関数：int rcRctFileWrite(REGSMEM *regsmem, ACMEM *acmem, char *filename)
  /// 機能：仮締ファイル書き込み
  /// 引数：*regsmem レシートバッファのポインタ
  /// ：*acmem 登録メモリバッファのポインタ
  /// ：*filename   書き込みファイル名
  /// 戻値：RCRCT_OK / RCRCT_NG
  /// 関連tprxソース: rcrctfil.c - rcRctFileWrite
  static Future<int> rcRctFileWrite(
      RegsMem regsMem, AcMem acMem, String fileName) async {
    int handle = 0;
    int regsSize = 0;
    int acSize = 0;
    int fileSize = 0;
    Stat st = Stat();
    String erLog = '';
    int j = 0;

    while (true) {
      /* ファイルオープン */
      if (!TprxPlatform.getFile(fileName).existsSync()) {
        return RCRCT_NG;
      }

      // TODO:00013 三浦 後回し
      // /* ファイル書き込み(レシートバッファ部) */
      // regs_size = sizeof(REGSMEM);
      // if (write(handle, regsmem, regs_size) != regs_size) {
      // return RCRCT_NG;
      // }

      // TODO:00013 三浦 後回し
      // /* ファイル書き込み(登録メモリ部) */
      // ac_size = sizeof(ACMEM);
      // if (write(handle, acmem, ac_size) != ac_size) {
      // return RCRCT_NG;
      // }

      FileStat fileStat = await FileStat.stat(fileName);
      fileSize = fileStat.size;
      if (fileSize != (regsSize + acSize)) {
        erLog = sprintf("%s SizeError j:%i regs_size:%i ac_size:%i file_size:%i\n",
            [fileName, j, regsSize, acSize, fileSize]);
        TprLog().logAdd(0, LogLevelDefine.error, erLog);
        if (j < 4) {
          // TODO:00013 三浦 ファイル削除処理合ってる？
          TprxPlatform.getFile(fileName).deleteSync();
          j++;
        } else {
          TprLog().logAdd(0, LogLevelDefine.error, "rcRctFileWrite Error invalid file size");
          return RCRCT_NG;
        }
      } else {
        break;
      }
    }
    return RCRCT_OK;
  }

      /// 関数：int rcCashRctFile(REGSMEM *buf, int mode)
      /// 機能：キャッシャー仮締ファイルアクセス
      /// 引数：*regsmem レシートバッファのポインタ
      /// ：      (RCRCT_CHK RCRCT_INITはNULL指定可)
      /// ：*acmem 登録メモリバッファのポインタ
      /// ：      (RCRCT_CHK RCRCT_INITはNULL指定可)
      /// ：mode アクセスモード
      /// ：  RCRCT_READ  読み込み
      /// ：  RCRCT_WRITE 書き込み
      /// ：  RCRCT_CHECK データチェック
      /// ：  RCRCT_INIT  初期化
      /// ：  RCRCT_MODE  モードチェック(t_ttllog.ope_mode_flg)
      /// 戻値：RCRCT_OK / RCRCT_NG
  /// 関連tprxソース: rcrctfil.c - rcCashRctFile
  static Future<int> rcCashRctFile(RegsMem regsMem, AcMem acMem, int mode) async {
    return await rcRctFileMain(regsMem, acMem, mode, RCRCT_CASH);
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcrctfil.c - rcTabChkRctFile
  static int rcTabChkRctFile(RegsMem regsMem, AcMem acMem, int mode)
  {
    return rcTabRctFileMain(regsMem, acMem, mode, RCRCT_CHK);
  }

  /// todo 動作未確認
  /// 関連tprxソース: rcrctfil.c - rcTabCashRctFile
  static int rcTabCashRctFile(RegsMem regsMem, AcMem acMem, int mode)
  {
    return rcTabRctFileMain(regsMem, acMem, mode, RCRCT_CASH);
  }

  /// todo 定義だけ追加
  /// 関連tprxソース: rcrctfil.c - rcTabRctFileMain
  static int rcTabRctFileMain(RegsMem regsMem, AcMem acMem, int mode, int chkCash)
  {
    return 0;
  }

}