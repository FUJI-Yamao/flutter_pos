/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:get/get.dart';

import '../../common/environment.dart';
import '../../lib/apllib/rxsyssend.dart';
import '../sys/tpr_ipc.dart';
import '../sys/tpr_log.dart';
import '../sys/tpr_mid.dart';
import '../sys/tpr_pipe.dart';

/// 関連tprxソース: rxsys.c
class RxSys {
  /// 機能：システムタスクにメッセージを送信する
  /// 引数：id      送信元タスクID (tpraid.h に定義)
  /// ：msg     送信するメッセージ
  /// 戻値：RXSYS_OK / RXSYS_NG
  /// 関連tprxソース: rxsys.c - rxSysSend
  static int rxSysSend(int id, Rxsys msg) {
    File hSysPipe;
    int ret = 0;
    TprApl_t apl = TprSysFail();
    String erLog = '';

    if (msg == Rxsys.RXSYS_MSG_PWRE) {
      RxSysSend.rxUpsFailChk(0);
    }

    if (msg == Rxsys.RXSYS_MSG_PWOFF) {
      RxSysSend.rxUpsFailChk(1);
    }

    /* システムのパイプオープン */
    RandomAccessFile raFile;
    try {
      hSysPipe = TprxPlatform.getFile(TprPipe.TPRPIPE_SYS);
      raFile = hSysPipe.openSync();
    } catch (e) {
      erLog = "rxSysSend: open() error!![$e]\n";
      TprLog().logAdd(0, LogLevelDefine.error, erLog);
      return RxSysDefine.RXSYS_NG;
    }

    /* メッセージ作成 */
    apl.mid = TprMidDef.TPRMID_APLNOTIFY;
    apl.length = 12 - 8; // sizeof(tprapl_t) - sizeof(tprcommon_t);
    apl.errnum = (id | msg.id);

    // TODO:10152 履歴ログ 確認
    /* メッセージ送信 */
    ret = RxSysDefine.RXSYS_OK;
    try {
      String strApl =
          apl.mid.toString() + apl.length.toString() + apl.errnum.toString();
      List<int> list = strApl.codeUnits;
      hSysPipe.writeAsBytesSync(list);
    } catch (e) {
      erLog = "rxSysSend: write() error!![$e]\n";
      TprLog().logAdd(0, LogLevelDefine.normal, erLog);
      ret = RxSysDefine.RXSYS_NG;
    }

    /* パイプクローズ */
    raFile.closeSync();

    return ret;
  }
}

/// 関連tprxソース: rxsys.h
enum Rxsys{
  /*-----  メッセージ定義  -----*/
  RXSYS_MSG_REGSEND     (0x01000000), /* 登録モード終了(メインメニュー) */
  RXSYS_MSG_OPNCLS      (0x02000000), /* 登録モード終了(オープンクローズ) */
  RXSYS_MSG_OPNST       (0x03000000), /* 開設開始 */
  RXSYS_MSG_OPNEND      (0x04000000), /* 開設終了 */
  RXSYS_MSG_CLSST       (0x05000000), /* 閉設開始 */
  RXSYS_MSG_CLSEND      (0x06000000), /* 閉設終了 */
  RXSYS_MSG_PWOFF       (0x07000000), /* パワーオフ処理 */
  RXSYS_MSG_PWRE        (0x08000000), /* リブート処理 */
  RXSYS_MSG_MENTE       (0x09000000), /* MENTENANCE MODE IDLE */
  RXSYS_MSG_USETUP      (0x0A000000), /* USERSETUP MODE IDLE */
  RXSYS_MSG_PMOD        (0x0B000000), /* SETTING MODE IDLE */
  RXSYS_MSG_MENU        (0x0C000000), /* MENU MODE IDLE */
  RXSYS_MSG_SPEC        (0x0D000000), /* SPEC MODE IDLE */
  RXSYS_MSG_FREQS       (0x0E000000), /* REQUEST EXCLUSIVE USE SALE EXAMINE START */
  RXSYS_MSG_FREQE       (0x0F000000), /* REQUEST EXCLUSIVE USE SALE EXAMINE END */
  RXSYS_MSG_REBOOT      (0x10000000), /* PROGRAM REBOOT */
  RXSYS_MSG_REBOOT1     (0x11000000), /* IMMEDIATE REBOOT */
  RXSYS_MSG_CUSTCLRS    (0x12000000), /* CUST ENQ CLEAR USE SALE EXAMINE START */
  RXSYS_MSG_CUSTCLRE    (0x13000000), /* CUST ENQ CLEAR USE SALE EXAMINE END */
  RXSYS_MSG_SPEC_SPECIAL(0x14000000), /* SPEC MODE SPECIAL(for cust enq clear) IDLE */
  RXSYS_MSG_USETUP_CALL (0x15000000), /* USERSETUP MODE SysMenuStatus CALL */
  RXSYS_MSG_MENTE_CALL  (0x16000000), /* MENTENANCE MODE SysMenuStatus CALL */
  RXSYS_MSG_SALE_CALL   (0x17000000), /* SALE MODE SysMenuStatus CALL */
  RXSYS_MSG_READFLAG    (0x18000000), /* rcPrt_ReadFlagData() CALL */
  RXSYS_MSG_FENCE_OVER_END     (0x19000000), /* FenceOver End */
  RXSYS_MSG_FENCE_OVER_START   (0x20000000), /* FenceOver Start */
  RXSYS_MSG_OPNST_ST           (0x21000000), /* 開設待ち */
  RXSYS_MSG_CASH_RECYCLE_END   (0x22000000), /* CashRecycle End */
  RXSYS_MSG_CASH_RECYCLE_START (0x23000000), /* CashRecycle Start */
  RXSYS_MSG_AUTOSTRCLS_START   (0x24000000), /* キャッシュマネジメント自動精算開始 */
  RXSYS_MSG_DATA_SHIFT         (0x25000000), /* DATA SHIFT MODE IDLE */
  // #if 0
  // RXSYS_MSG_STARTOK = 0x02000000, /* 開始OK */
  // RXSYS_MSG_STARTNG = 0x03000000, /* 開始NG */
  // RXSYS_MSG_STOPOK  = 0x04000000, /* 停止OK */
  // RXSYS_MSG_STOPNG  = 0x05000000, /* 停止NG */
  // RXSYS_MSG_APLOK   = 0x06000000, /* アプリ処理OK */
  // RXSYS_MSG_APLNG   = 0x07000000, /* アプリ処理NG */
  // #endif
  RXSYS_MSG_FINIT        (0x26000000), /* FREQ FILEINIT MODE */
  RXSYS_MSG_OPNCLS_2     (0x27000000), /* 登録モード終了(従業員精算) */
  RXSYS_MSG_REGS_RESTART (0x28000000), /* 登録モード再起動 */
  RXSYS_MSG_SYST_RESTART (0x29000000), /* syst再起動 */
  RXSYS_MSG_MASK         (0xff000000); /* メッセージマスク */
  // #if RF1_SYSTEM
  // ,RXSYS_MSG_FENCE_OVER_START_2 = 0x30000000 /* FenceOver Start */
  // #endif //if RF1_SYSTEM

  final int id;
  const Rxsys(this.id);
}

/// 関連tprxソース: rxsys.h
class RxSysDefine{
  /*-----  共有メモリ関数の戻り値  -----*/
  static const RXSYS_OK = 0;       /* 正常終了 */
  static const RXSYS_NG = -1;      /* 異常終了 */
}