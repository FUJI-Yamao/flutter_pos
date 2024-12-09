/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/foundation.dart';
import 'package:sprintf/sprintf.dart';
import 'dart:io';
import 'dart:ffi';
import 'dart:ffi' as ffi;

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/t_item_log.dart';
import '../../inc/sys/tpr_ipc.dart';

///     関連tprxソース: rsmain.c
class ResultRsMem{
  int ret = 0;
  String buf = '';
}

class RsMain{

/**********************************************************************

    スプール管理メインプログラム

***********************************************************************/

/* デバッグ用コンパイルフラグ */
static const _RSMAIN_C_DEBUG_ = true;              /* デバッグ表示 */

/**********************************************************************
    デファイン定義
***********************************************************************/

static const RS_OK = 0;
static const RS_NG = -1;

static const RS_FIX_MAX = 9;
static const RS_COUNT_INITIAL = 0;

static const RS_FILENAME = "SPOOL%02d.TMP";
static const RS_DIRNAME  = "/tmp/regs";
static const RS_DIRNAME2 = "/tmp/regs2";
static const RS_DIRNAMEB = "/tmp/regsb";
static const RS_TEMPDIR  = "/tmp/";
static const RS_DEVNAME  = "/dev/shm/regs2";
static const SPOOL_NAME  = "SPOOL";
static const RS_TEMPFILE = "SPOOL99.TMP";
static const RS_COUNTFILE = "SPOOLCNT.TMP";
/**********************************************************************
    グローバル変数
***********************************************************************/

static int        fEnd = 0;              /* タスク終了フラグ */
static int        spoolMin = 1;          /* スプール開始ファイル名 */
static int        spoolMax = 5;          /* スプール最大数 */

static String      tprPath = "";         /* 環境変数 TPRX_HOME */
static String      rsFileName = "";      /* SPOOL file name */
static late RxCommonBuf  pCom;           /* 共有メモリ */
static late RxTaskStatBuf  pStat;        /* タスクステータスメモリ */

/**********************************************************************
    関数
***********************************************************************/

/// 関連tprxソース: rsmain.c  rsInit()
/// 関数：int rsInit()
/// 機能：スプール管理タスク初期処理
/// 引数：なし
/// 戻値：RS_OK:正常終了 / RS_NG:異常終了
  static Future<int> rsInit() async {

    /* 共通メモリポインタ取得 */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return RS_NG;
    }
    pCom = xRet.object;

    /* タスクステータスポインタ取得 */
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return RS_NG;
    }
    pStat = xRet.object;

    /* ホームディレクトリパス取得 */
    tprPath = EnvironmentData().sysHomeDir;

    /* スプール段数取得 */
    spoolMax = pCom.iniMacInfo.clerksave.spoolend;

    if (_RSMAIN_C_DEBUG_) {
      debugPrint("rsmain.c:spoolend[$spoolMax]");
    }

    /* スプールファイルディレクトリ初期化 */
    int ret = await _rsSpoolDirInit();

    /* スプールファイル初期化 */
    await _rsSpoolInit(ret);

    return RS_OK;
  }

/// 関連tprxソース: rsmain.c  rsSpoolDirInit()
/// 関数：int rsSpoolDirInit()
/// 機能：スプールファイルディレクトリ初期化
/// 引数：なし
/// 戻値：RS_OK:終了
  static Future<int> _rsSpoolDirInit() async {
    String  dir_name = "";
    int  dir_res = RS_OK;

    final directory = Directory(RS_DEVNAME);
    if (!await directory.exists()) {
      var directory = await Directory(RS_DEVNAME).create(recursive: true);
      if(directory.path != RS_DEVNAME) { 
        dir_res = RS_NG;
      }
    }

    if(dir_res == RS_OK) {
      dir_name = sprintf("%s/%s", [tprPath,RS_DIRNAME2]);
      File fp = File(dir_name);
      var fpStat = await fp.statSync();
      if (fpStat.type == FileSystemEntityType.notFound) {
        try {
          await Process.run('ln', ['-s', RS_DEVNAME, dir_name]);
        } catch (e) {
          dir_res = RS_NG;
        }
      }
    }

    /* SPOOL FILE NAME */
    if(dir_res == RS_OK) {
      /* /pj/tprx/tmp/regs2/SPOOL%02d.TMP */
      rsFileName = sprintf("%s/%s", [RS_DIRNAME2,RS_FILENAME]);
    } else {
      /* /pj/tprx/tmp/regs/SPOOL%02d.TMP */
      rsFileName = sprintf("%s/%s", [RS_DIRNAME,RS_FILENAME]);
    }

    return dir_res;
  }

/// 関連tprxソース: rsmain.c  rsSpoolInit()
/// 関数：int rsSpoolInit(int mem)
/// 機能：スプールファイル初期化
/// 引数：mem :_rsSpoolDirInit()処理結果
/// 戻値：RS_OK:終了
  static Future<int>  _rsSpoolInit(int mem) async {
    String  filename = "";
    String  bdir = "";

    if(mem == RS_OK) {
      /* spool file recovery */
      bdir = "";
      bdir = tprPath + RS_DIRNAMEB;

      File fp = File(bdir);
      var fpStat = await fp.statSync();

      if (fpStat.type == FileSystemEntityType.notFound) {
        /* not exist dir */ 
        //printf(log,sizeof(log),"Not exist dir:%s\n",bdir);
      } else {
        if (fpStat.type == FileSystemEntityType.directory) {
          var directory = Directory(bdir);
          var list = await directory.list(recursive: true, followLinks: false);

          // ディレクトリ内のファイルをすべて表示する
          await for (var file in list) {
            int index = file.path.indexOf("SPOOL");
            if (index >= 0) {
              String name = file.path.substring(index);
              String srcname = sprintf("%s%s/%s", [tprPath, RS_DIRNAMEB, name] );
              String toname  = sprintf("%s%s/%s", [tprPath, RS_DIRNAME2, name] );
              String mvcmd   = sprintf("/bin/mv %s %s", [srcname,toname]);
              try {
                await Process.run('/bin/mv', [srcname, toname]);
              } catch (e) {
              }
            }
          }
        }
      }
    }

    _createSpoolCount();
    for (int idx = 1; idx <= RS_FIX_MAX; idx++) {

      /* 存在チェック */
      filename = _rsGetSpoolFileName(idx);
      final file = File(filename);
      if (idx <= spoolMax) {
        if (!file.existsSync()) {
          await _rsCreateSpoolFile(filename);  /* 範囲内で存在しなければ作成 */
          continue;
        }
      } else {
        if (file.existsSync()) {
          file.delete();    /* 範囲外で存在したら削除 */
        }
        continue;
      }

    }

    return RS_OK;
  }

/// 関連tprxソース: rsmain.c  rsShiftFile()
/// 関数：int rsShiftFile(int num)
/// 機能：スプールファイルの内容をシフトする
///     ：  SPOOL(nn-1) <- SPOOL(nn)  SPOOL(num)はクリエイト
/// 引数：int num 使用中のスプール数
/// 戻値：RS_OK:終了
    static int rsShiftFile(int num) {
      try {
        int      idx = 0;
        String   dst_name = "";
        String   src_name = "";

        dst_name = _rsGetSpoolFileName(spoolMin);
        var dst_file = File(dst_name);
        dst_file.delete();

        for (idx = spoolMin; idx < num; idx++) {
          src_name = _rsGetSpoolFileName(idx + 1);
          var src_file = File(src_name);
          dst_name = _rsGetSpoolFileName(idx);

          src_file.rename(dst_name);
        }

        dst_name = _rsGetSpoolFileName(num);
        _rsCreateSpoolFile(dst_name);

      } catch (e, s) {
      }
      return RS_OK;
    }

/// 関数：ResultRegsMem rsReadTempFile()
/// 機能：スプールテンポラリーファイルを読み込む
/// 引数：なし
/// 戻値：読み込みデータ
  static Future<String> rsReadTempFile() async {
      String tempRetData = '';
      try {
        final filename = _rsGetTempSpoolFileName();
        var file = File(filename);
        tempRetData = file.readAsStringSync();
      } catch (e, s) {
      }
      return tempRetData;
  }

/// 関数：ResultRegsMem rsReadFile(String buf)
/// 機能：スプールテンポラリーファイルを読み込む
/// 引数：String 書き込みデータ
/// 戻値：RS_OK:正常終了 / RS_NG:異常終了
  static Future<int> rsWriteTempFile(String buf) async {
      try {
        final filename = _rsGetTempSpoolFileName();
        var file = File(filename);
        file.writeAsStringSync(buf);
      } catch (e, s) {
      }
      return RS_OK;
  }

/// 関数：ResultRegsMem rsReadCountFile()
/// 機能：スプールファイル数を読み込む
/// 引数：なし
/// 戻値：カウンター値
  static Future<int> getSpoolCount() async {
      int retData = 0;
      try {
        final filename = _rsGetSpoolCountFileName();
        var file = File(filename);
        String readData = file.readAsStringSync();
        retData = int.parse(readData);
      } catch (e, s) {
      }
      return retData;
  }

/// 関数：ResultRegsMem rsCountUpFile()
/// 機能：スプールファイル数を更新（+1）
/// 引数：なし
/// 戻値：カウンター値
  static int upSpoolCount() {
      int retData = 0;
      try {
        final filename = _rsGetSpoolCountFileName();
        var file = File(filename);
        String readData = file.readAsStringSync();
        retData = int.parse(readData);
        retData++;
        file.writeAsStringSync(retData.toString());
      } catch (e, s) {
      }
      return retData;
  }

/// 関数：ResultRegsMem rsCountDownFile()
/// 機能：スプールファイル数を更新（-1）
/// 引数：なし
/// 戻値：カウンター値
  static int downSpoolCount() {
      int retData = 0;
      try {
        final filename = _rsGetSpoolCountFileName();
        var file = File(filename);
        String readData = file.readAsStringSync();
        retData = int.parse(readData);
        if(retData>0) {
          retData--;
        }
        file.writeAsStringSync(retData.toString());
      } catch (e, s) {
      }
      return retData;
  }

/// 関数：ResultRegsMem rsCreateCountFile()
/// 機能：スプールファイル数ファイルを初期化
/// 引数：なし
/// 戻値：なし
  static void _createSpoolCount() {
      try {
        final filename = _rsGetSpoolCountFileName();
        var file = File(filename);
        if (!file.existsSync()) {
          file.createSync();
        }
        file.writeAsStringSync(RS_COUNT_INITIAL.toString());
      } catch (e, s) {
      }
      return ;
  }

/// 関連tprxソース: rsmain.c  rsReadFile()
/// 関数：ResultRsMem rsReadSpoolFile(int num)
/// 機能：スプールファイルを読み込む
/// 引数：int num 読み込むスプールファイルの番号
/// 戻値：RS_OK:正常終了 / RS_NG:異常終了
///     ：読み込みバッファ
  static ResultRsMem rsReadSpoolFile(int num) {
      ResultRsMem result = ResultRsMem();
      result.ret = RS_OK;
      try {
        final filename = _rsGetSpoolFileName(num);
        var file = File(filename);

        result.buf = file.readAsStringSync();
      } catch (e, s) {
        result.ret = RS_NG;
      }
      return (result);
  }

/// 関連tprxソース: rsmain.c  rsWriteFile()
/// 関数：int rsWriteSpoolFile(RegsMem buf, int num)
/// 機能：スプールファイルに書き込む
/// 引数：RegsMem buf 書き込みバッファ
///     ：int num 読み込むスプールファイルの番号
/// 戻値：RS_OK:正常終了 / RS_NG:異常終了
  static Future<int> rsWriteSpoolFile(String buf, int num) async {
      try {
        final filename = _rsGetSpoolFileName(num);
        var file = File(filename);
        file.writeAsStringSync(buf);
      } catch (e, s) {
      }
      return RS_OK;
  }

/// 関連tprxソース: rsmain.c  rsCreateFile()
/// 関数：int rsCreateSpoolFile(char *filename)
/// 機能：空のスプールファイルを作成する
/// 引数：String filename 作成するファイル名
/// 戻値：RS_OK:正常終了 / RS_NG:異常終了
  static Future<int> _rsCreateSpoolFile(String filename) async {
      try {
        var file = File(filename);
        if (file.existsSync()) {
          await file.delete();
        }
        await file.create();
      } catch (e, s) {
      }
      return RS_OK;
  }

/// 関連tprxソース: rsmain.c  rsGetFileName()
/// 関数：String rsGetFileName(int num)
/// 機能：スプールファイル名を作成する
/// 引数：int num スプールファイル番号
/// 戻値：String ファイル名
  static String _rsGetSpoolFileName(int num) {
    return (tprPath + sprintf(rsFileName, [num]));
  }

/// 関数：String rsGetTempFileName()
/// 機能：スプールテンポラリーファイル名を作成する
/// 引数：なし
/// 戻値：String ファイル名
  static String _rsGetTempSpoolFileName() {
    return tprPath + RS_TEMPDIR + RS_TEMPFILE;
  }

/// 関数：String _rsGetSpoolCountFileName()
/// 機能：スプールファイル数ファイル名を作成する
/// 引数：なし
/// 戻値：String ファイル名
  static String _rsGetSpoolCountFileName() {
    return tprPath + RS_TEMPDIR + RS_COUNTFILE;
  }

/// 関数：bool isSpoolFilePossibleRegister()
/// 機能：スプールファイル送出可能かチェックする
/// 引数：なし
/// 戻値：true: 送出可 / false: 送出不可
  static Future<bool> isSpoolFileSend() async {
    int count = await RsMain.getSpoolCount();
    return (count < spoolMax);
  }
}
