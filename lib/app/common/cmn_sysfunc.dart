/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/dual_cashier_util.dart';

import '../../ps_control/ps_monitoring.dart';
import '../backend/update/actual_results.dart';
import '../if/if_changer_isolate.dart';
import '../inc/apl/rxregmem_define.dart';
import '../fb/fb_lib.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/sys/tpr_did.dart';
import '../inc/sys/tpr_log.dart';
import '../lib/cm_sys/cm_cksys.dart';
import '../regs/checker/rc_acracb.dart';
import '../regs/inc/rc_mem.dart';
import '../regs/checker/rc_elog.dart';
import '../regs/checker/rcstllcd.dart';
import '../if/if_drv_control.dart';
import '../if/if_drw_isolate.dart';
import '../if/if_mkey_isolate.dart';
import '../if/if_multiTmn_isolate.dart';
import '../if/if_scan_isolate.dart';
import '../if/if_sample_isolate.dart';


class SystemFuncPayload {
  RxMemIndex index = RxMemIndex.RXMEM_NON;  // 共有メモリの種別
  dynamic buf;                              // 共有メモリ用バッファ
  RxMemAttn attention = RxMemAttn.NON;      // 宛先
}

class RxMemRet {
  int result = RxMem.RXMEM_NG;
  RxMemResult cause = RxMemResult.other_error; // 結果理由
  dynamic object;
  /// 共有メモリポインタ取得条件
  bool isInvalid() {
    return (!isValid());
  }
  bool isValid() {
    return ((result == RxMem.RXMEM_OK) && (object != null));
  }
}

enum RxMemResult {
  success, // 成功
  invalid_parameter, // 不正パラメータ
  no_instance,   // インスタンス無しのクラスをコール
  invalid_type, // 型指定誤り
  other_error, // その他処理エラー
}

/// 共有関数
/// アプリからメイン側へデータを渡す関数として、暫定で用意
class SystemFunc {

  static bool DEBUG_UT = false;

  // シングルトンとする
  static final SystemFunc _instance = SystemFunc._internal();
  factory SystemFunc() {
    return _instance;
  }
  SystemFunc._internal() {
    SystemFunc();
  }

  static late RxCommonBuf     _rxMemCommon;             // 全タスク共通メモリ
  static late RxTaskStatBuf   _rxMemStat;               // タスクステータス
  static late RxInputBuf      _rxMemChkInp;             // チェッカー入力情報
  static late RxInputBuf      _rxMemCashInp;            // キャッシャー入力情報
  static late RegsMem         _rxMemChkRct;             // チェッカーレシートバッファ
  static late RegsMem         _rxMemCashRct;            // キャッシャーレシートバッファ
  static late RegsMem         _rxMemUpdRct;             // 実績加算レシートバッファ
  static late RegsMem         _rxMemPrnRct;             // レシート印字レシートバッファ
  static late RxPrnStat       _rxMemPrnStat;            // 印字ステータスバッファ
  static late RxInputBuf      _rxMemChkCash;            // 割込入力情報
  static late RxInputBuf      _rxMemAcxStat;            // ACXステータスバッファ
  static late RxInputBuf      _rxMemJpoStat;            // JPOステータスバッファ
  static late RxSocket        _rxMemSocket;             // SOCKET通信用共通メモリ
  static late RxInputBuf      _rxMemSclStat;            // SCLステータスバッファ
  static late RxInputBuf      _rxMemRwcStat;            // RWCステータスバッファ
  static late RxInputBuf      _rxMemStrOpnCls;          // 開閉設入力情報
  static late RxInputBuf      _rxMemSGSCL1Stat;         // セルフゲートSCL1ステータスバッファ
  static late RxInputBuf      _rxMemSGSCL2Stat;         // セルフゲートSCL2ステータスバッファ
  static late RxInputBuf      _rxMemProcInst;           // PROCESS CONTROL 入力情報
  static late RxInputBuf      _rxMemAnother1;           // another1入力情報
  static late RxInputBuf      _rxMemAnother2;           // another2入力情報
  static late RxInputBuf      _rxMemPmod;               // pmod情報
  static late RxInputBuf      _rxMemSale;               // sale_com_mm情報
  static late RxInputBuf      _rxMemRept;               // report情報
  static late RegsMem         _rxMemStprRct;            // ステーションプリンタ印字レシートバッファ
  static late RxPrnStat       _rxMemStprStat;           // 印字ステータスバッファ
  static late RxMntclt        _rxMemMntClt;             // menteclient information
  static late RxSoundStat     _rxMemSound;              // 音声情報(卓上部)
  static late RegsMem         _rxMemS2PrRct;            // ステーションプリンタ印字レシートバッファ
  static late RxPrnStat       _rxMemS2PrStat;           // 印字ステータスバッファ
  static late RxInputBuf      _rxMemBankStat;           // BANKステータスバッファ
  static late RegsMem         _rxMemNscRct;             // BANKレシートバッファ
  static late RxInputBuf      _rxMemFenceOver;          // FenceOver入力情報
  static late RxSoundStat     _rxMemSound2;             // 音声情報(タワー部)
  static late RxInputBuf      _rxMemSuicaStat;          // SUICAステータスバッファ
  static late RxInputBuf      _rxMemAcxReal;            // 釣銭釣札機リアル問い合わせ処理
  static late RegsMem         _rxMemMp1Rct;             // MP1印字レシートバッファ
  static late RxInputBuf      _rxMemMultiStat;          // MULTIステータスバッファ
  static late RxInputBuf      _rxMemCustRealStat;       // 顧客リアルステータスバッファ
  static late RxSocket        _rxMemCustRealSocket;     // 顧客リアルSOCKET通信用共通メモリ
  static late RxQcConnect     _rxMemQCConnectStat;      // QcConnectステータスバッファ
  static late RxSocket        _rxMemCreditSocket;       // クレジットSOCKET通信用共通メモリ
  static late RxSocket        _rxMemCustRealNecSocket;  // NEC SOCKET通信用共通メモリ
  static late RxInputBuf      _rxMemMasrStat;           // 自走式磁気リーダ
  static late RxInputBuf      _rxMemCashRecycle;        // キャッシュリサイクル
  static late RegsMem         _rxMemQCJC_CPrnRct;       // レシート印字レシートバッファ
  static late RxPrnStat       _rxMemQCJC_CPrnStat;      // 印字ステータスバッファ
  static late RxInputBuf      _rxMemSQRc;               // SQRC Ticket
  static late RegsMem         _rxMemKitchen1PrnRct;     // レシート印字レシートバッファ(Kitchen1)
  static late RxPrnStat       _rxMemKitchen1PrnStat;    // 印字ステータスバッファ(Kitchen1)
  static late RegsMem         _rxMemKitchen2PrnRct;     // レシート印字レシートバッファ(Kitchen2)
  static late RxPrnStat       _rxMemKitchen2PrnStat;    // 印字ステータスバッファ(Kitchen2)
  static late RxMailSender    _rxMemMailSender;         // 電子メール送信
  static late RegsMem         _rxMemDummyPrnRct;        // レシート印字レシートバッファ(ダミー)
  static late RxPrnStat       _rxMemDummyPrnStat;       // 印字ステータスバッファ(ダミー)
  static late RxNetReceipt    _rxMemNetReceipt;         // 電子レシート処理
  static late RxInputBuf      _rxMemHiTouch;            // ハイタッチ受信
  static late RxInputBuf      _rxMemFenceOver2;         // FenceOver入力情報 フェンスオーバー化対応

  static FbMem fbMem = FbMem();
  static AcMem cBuf = AcMem();
  static ERef eRef = ERef();
  static EsVoid esVoid = EsVoid();
  static Onetime ot = Onetime();
  static IfWaitSave ifSave = IfWaitSave();
  static RxSoundIni rxSoundIni = RxSoundIni();
  static AtSingl atSing = AtSingl();
  static RegsMem regsMem = RegsMem();
  static CommonLimitedInput comLtdInp = CommonLimitedInput();
  static AcbMem acbMem = AcbMem();
  //**** < 使用する？ > ********************************************

  /// [暫定] ファイルをクローズする（処理なし）
  ///  関連tprxソース:低水準入出力関数 - close()
  /// 引数 [handle]: クローズするファイルを指すファイルディスクリプタ
  /// 戻り値：0 = Normal End (固定)
  static int close(dynamic handle) {
    return 0;
  }

  /// [暫定] ファイルへデータを書き込む（処理なし）
  ///  関連tprxソース:低水準入出力関数 - write()
  /// 引数:[handle] 書き込み先ファイルを指すファイルディスクリプタ
  ///     [buf] 書き込むデータのアドレス
  ///     [len] 書き込むデータの大きさ
  /// 戻り値：0 = Normal End (固定)
  static int write(dynamic handle, dynamic buf, dynamic len) {
    return 0;
  }

  /// [暫定] ファイルのデータを読み取る（処理なし）
  ///   関連tprxソース:低水準入出力関数 - read()
  /// 引数:[handle] 読み取り先ファイルを指すファイルディスクリプタ
  ///     [buf] 読み取るデータのアドレス [in/out]
  ///     [len] 読み取るデータの大きさ
  /// 戻り値：読み取ったデータの大きさ (0に固定)
  static int read(dynamic handle, dynamic buf, dynamic len) {
    return 0;
  }


  /// rxMemGetAll
  ///
  /// 全共有メモリ初期化
  ///
  /// 引数:なし
  ///
  /// 戻り値：RXMEM_OK = Normal End
  ///
  ///      RxMem.RXMEM_NG = Error
  ///
  /// 関連tprxソース: rxmem.c - rxMemGetAll()
  static Future<int> rxMemGetAll() async {
    int result = RxMem.RXMEM_NG;

    // 共通メモリ  RXMEM_COMMON
    try {
      if (_rxMemCommon == null) {
        _rxMemCommon = RxCommonBuf();
      }
    } catch(e) {
      _rxMemCommon = RxCommonBuf();
    }

    // タスクステータス  RXMEM_STAT
    try {
      if (_rxMemStat == null) {
        _rxMemStat = RxTaskStatBuf();
      }
    } catch(e) {
      _rxMemStat = RxTaskStatBuf();
    }

    // チェッカー入力  RXMEM_CHK_INP
    try {
      if (_rxMemChkInp == null) {
        _rxMemChkInp = RxInputBuf();
      }
    } catch(e) {
      _rxMemChkInp = RxInputBuf();
    }

    // キャッシャー入力  RXMEM_CASH_INP
    try {
      if (_rxMemCashInp == null) {
        _rxMemCashInp = RxInputBuf();
      }
    } catch(e) {
      _rxMemCashInp = RxInputBuf();
    }

    // チェッカーレシート  RXMEM_CHK_RCT
    try {
      if (_rxMemChkRct == null) {
        _rxMemChkRct = RegsMem();
      }
    } catch(e) {
      _rxMemChkRct = RegsMem();
    }

    // キャッシャーレシート  RXMEM_CASH_RCT
    try {
      if (_rxMemCashRct == null) {
        _rxMemCashRct = RegsMem();
      }
    } catch(e) {
      _rxMemCashRct = RegsMem();
    }

    // 実績加算レシート // RXMEM_UPD_RCT
    try {
      if (_rxMemUpdRct == null) {
        _rxMemUpdRct = RegsMem();
      }
    } catch(e) {
      _rxMemUpdRct = RegsMem();
    }

    // レシート印字レシート  RXMEM_PRN_RCT
    try {
      if (_rxMemPrnRct == null) {
        _rxMemPrnRct = RegsMem();
      }
    } catch(e) {
      _rxMemPrnRct = RegsMem();
    }

    // レシート印字レシート  RXMEM_QCJC_C_PRN_RCT
    try {
      if (_rxMemQCJC_CPrnRct == null) {
        _rxMemQCJC_CPrnRct = RegsMem();
      }
    } catch(e) {
      _rxMemQCJC_CPrnRct = RegsMem();
    }

    // レシート印字レシート  RXMEM_KITCHEN1_PRN_STAT
    try {
      if (_rxMemKitchen1PrnStat == null) {
        _rxMemKitchen1PrnStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemKitchen1PrnStat = RxPrnStat();
    }

    // レシート印字レシート RXMEM_KITCHEN2_PRN_STAT
    try {
      if (_rxMemKitchen2PrnStat == null) {
        _rxMemKitchen2PrnStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemKitchen2PrnStat = RxPrnStat();
    }

    // ACX ステータス  RXMEM_ACX_STAT
    try {
      if (_rxMemAcxStat == null) {
        _rxMemAcxStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemAcxStat = RxInputBuf();
    }

    // 印字ステータス  RXMEM_PRN_STAT
    try {
      if (_rxMemPrnStat == null) {
        _rxMemPrnStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemPrnStat = RxPrnStat();
    }

    // 印字ステータス  RXMEM_QCJC_C_PRN_STAT
    try {
      if (_rxMemQCJC_CPrnStat == null) {
        _rxMemQCJC_CPrnStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemQCJC_CPrnStat = RxPrnStat();
    }

    // 割込入力  RXMEM_CHK_CASH
    try {
      if (_rxMemChkCash == null) {
        _rxMemChkCash = RxInputBuf();
      }
    } catch(e) {
      _rxMemChkCash = RxInputBuf();
    }

    // JPO ステータス  RXMEM_JPO_STAT
    try {
      if (_rxMemJpoStat == null) {
        _rxMemJpoStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemJpoStat = RxInputBuf();
    }

    // SOCKET通信用共通メモリ  RXMEM_SOCKET
    try {
      if (_rxMemSocket == null) {
        _rxMemSocket = RxSocket();
      }
    } catch(e) {
      _rxMemSocket = RxSocket();
    }

    // SUICA ステータス  RXMEM_SUICA_STAT
    try {
      if (_rxMemSuicaStat == null) {
        _rxMemSuicaStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemSuicaStat = RxInputBuf();
    }

    // MULTI ステータス  RXMEM_MULTI_STAT
    try {
      if (_rxMemMultiStat == null) {
        _rxMemMultiStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemMultiStat = RxInputBuf();
    }

    // SCL ステータス  RXMEM_SCL_STAT
    try {
      if (_rxMemSclStat == null) {
        _rxMemSclStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemSclStat = RxInputBuf();
    }

    // RWC ステータス  RXMEM_RWC_STAT
    try {
      if (_rxMemRwcStat == null) {
        _rxMemRwcStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemRwcStat = RxInputBuf();
    }

    // 開閉設 入力  RXMEM_STROPNCLS
    try {
      if (_rxMemStrOpnCls == null) {
        _rxMemStrOpnCls = RxInputBuf();
      }
    } catch(e) {
      _rxMemStrOpnCls = RxInputBuf();
    }

    // SGSCL1 ステータス  RXMEM_SGSCL1_STAT
    try {
      if (_rxMemSGSCL1Stat == null) {
        _rxMemSGSCL1Stat = RxInputBuf();
      }
    } catch(e) {
      _rxMemSGSCL1Stat = RxInputBuf();
    }

    // SGSCL2 ステータス  RXMEM_SGSCL2_STAT
    try {
      if (_rxMemSGSCL2Stat == null) {
        _rxMemSGSCL2Stat = RxInputBuf();
      }
    } catch(e) {
      _rxMemSGSCL2Stat = RxInputBuf();
    }

    // PROCINST ステータス  RXMEM_PROCINST
    try {
      if (_rxMemProcInst == null) {
        _rxMemProcInst = RxInputBuf();
      }
    } catch(e) {
      _rxMemProcInst = RxInputBuf();
    }

    // ANOTHER1 入力  RXMEM_ANOTHER1
    try {
      if (_rxMemAnother1 == null) {
        _rxMemAnother1 = RxInputBuf();
      }
    } catch(e) {
      _rxMemAnother1 = RxInputBuf();
    }

    // ANOTHER2 入力  RXMEM_ANOTHER2
    try {
      if (_rxMemAnother2 == null) {
        _rxMemAnother2 = RxInputBuf();
      }
    } catch(e) {
      _rxMemAnother2 = RxInputBuf();
    }

    // PMOD 入力  RXMEM_PMOD
    try {
      if (_rxMemPmod == null) {
        _rxMemPmod = RxInputBuf();
      }
    } catch(e) {
      _rxMemPmod = RxInputBuf();
    }

    // SALE_COM_MM 入力  RXMEM_SALE
    try {
      if (_rxMemSale == null) {
        _rxMemSale = RxInputBuf();
      }
    } catch(e) {
      _rxMemSale = RxInputBuf();
    }

    // REPORT 入力  RXMEM_REPT
    try {
      if (_rxMemRept == null) {
        _rxMemRept = RxInputBuf();
      }
    } catch(e) {
      _rxMemRept = RxInputBuf();
    }

    // ステーション印字  RXMEM_STPR_RCT
    try {
      if (_rxMemStprRct == null) {
        _rxMemStprRct = RegsMem();
      }
    } catch(e) {
      _rxMemStprRct = RegsMem();
    }

    // ステーションステータス  RXMEM_STPR_STAT
    try {
      if (_rxMemStprStat == null) {
        _rxMemStprStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemStprStat = RxPrnStat();
    }

    // MENTECLIENT Input  RXMEM_MNTCLT
    try {
      if (_rxMemMntClt == null) {
        _rxMemMntClt = RxMntclt();
      }
    } catch(e) {
      _rxMemMntClt = RxMntclt();
    }

    // 音声ステータス  RXMEM_SOUND
    try {
      if (_rxMemSound == null) {
        _rxMemSound = RxSoundStat();
      }
    } catch(e) {
      _rxMemSound = RxSoundStat();
    }

    // ２ステーション印字  RXMEM_S2PR_RCT
    try {
      if (_rxMemS2PrRct == null) {
        _rxMemS2PrRct = RegsMem();
      }
    } catch(e) {
      _rxMemS2PrRct = RegsMem();
    }

    // ２ステーションステータス  RXMEM_S2PR_STAT
    try {
      if (_rxMemS2PrStat == null) {
        _rxMemS2PrStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemS2PrStat = RxPrnStat();
    }

    // BANKステータスバッファ  RXMEM_BANK_STAT
    try {
      if (_rxMemBankStat == null) {
        _rxMemBankStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemBankStat = RxInputBuf();
    }

    //  BANKレシートバッファ  RXMEM_NSC_RCT
    try {
      if (_rxMemNscRct == null) {
        _rxMemNscRct = RegsMem();
      }
    } catch(e) {
      _rxMemNscRct = RegsMem();
    }

    // FenceOver  RXMEM_FENCE_OVER
    try {
      if (_rxMemFenceOver == null) {
        _rxMemFenceOver = RxInputBuf();
      }
    } catch(e) {
      _rxMemFenceOver = RxInputBuf();
    }

    // 音声ステータス  RXMEM_SOUND2
    try {
      if (_rxMemSound2 == null) {
        _rxMemSound2 = RxSoundStat();
      }
    } catch(e) {
      _rxMemSound2 = RxSoundStat();
    }

    // 釣銭釣札機リアル問い合わせ処理  RXMEM_ACXREAL
    try {
      if (_rxMemAcxReal == null) {
        _rxMemAcxReal = RxInputBuf();
      }
    } catch(e) {
      _rxMemAcxReal = RxInputBuf();
    }

    // MP1印字  RXMEM_MP1_RCT
    try {
      if (_rxMemMp1Rct == null) {
        _rxMemMp1Rct = RegsMem();
      }
    } catch(e) {
      _rxMemMp1Rct = RegsMem();
    }

    // 顧客リアルステータスバッファ  RXMEM_CUSTREAL_STAT
    try {
      if (_rxMemCustRealStat == null) {
        _rxMemCustRealStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemCustRealStat = RxInputBuf();
    }

    // 顧客リアルSOCKET通信用共通メモリ  RXMEM_CUSTREAL_SOCKET
    try {
      if (_rxMemCustRealSocket == null) {
        _rxMemCustRealSocket = RxSocket();
      }
    } catch(e) {
      _rxMemCustRealSocket = RxSocket();
    }

    // QcConnectステータスバッファ  RXMEM_QCCONNECT_STAT
    try {
      if (_rxMemQCConnectStat == null) {
        _rxMemQCConnectStat = RxQcConnect();
      }
    } catch(e) {
      _rxMemQCConnectStat = RxQcConnect();
    }

    // // クレジット SOCKET通信用共通メモリ  RXMEM_CREDIT_SOCKET
    try {
      if (_rxMemCreditSocket == null) {
        _rxMemCreditSocket = RxSocket();
      }
    } catch(e) {
      _rxMemCreditSocket = RxSocket();
    }

    // NECSOCKET通信用共通メモリ  RXMEM_CUSTREAL_NECSOCKET
    try {
      if (_rxMemCustRealNecSocket == null) {
        _rxMemCustRealNecSocket = RxSocket();
      }
    } catch(e) {
      _rxMemCustRealNecSocket = RxSocket();
    }

    // MASR自走式磁気リーダ ステータス  RXMEM_MASR_STAT
    try {
      if (_rxMemMasrStat == null) {
        _rxMemMasrStat = RxInputBuf();
      }
    } catch(e) {
      _rxMemMasrStat = RxInputBuf();
    }

    // キャッシュリサイクル処理  RXMEM_CASH_RECYCLE
    try {
      if (_rxMemCashRecycle == null) {
        _rxMemCashRecycle = RxInputBuf();
      }
    } catch(e) {
      _rxMemCashRecycle = RxInputBuf();
    }

    // SQRC Ticket  RXMEM_SQRC
    try {
      if (_rxMemSQRc == null) {
        _rxMemSQRc = RxInputBuf();
      }
    } catch(e) {
      _rxMemSQRc = RxInputBuf();
    }

    // 電子メール送信処理  RXMEM_MAIL_SENDER
    try {
      if (_rxMemMailSender == null) {
        _rxMemMailSender = RxMailSender();
      }
    } catch(e) {
      _rxMemMailSender = RxMailSender();
    }

    // ダミープリント処理  RXMEM_DUMMY_PRN_RCT
    try {
      if (_rxMemDummyPrnRct == null) {
        _rxMemDummyPrnRct = RegsMem();
      }
    } catch(e) {
      _rxMemDummyPrnRct = RegsMem();
    }

    // ダミープリント処理  RXMEM_DUMMY_PRN_STAT
    try {
      if (_rxMemDummyPrnStat == null) {
        _rxMemDummyPrnStat = RxPrnStat();
      }
    } catch(e) {
      _rxMemDummyPrnStat = RxPrnStat();
    }

    // 電子レシート処理  RXMEM_NET_RECEIPT
    try {
      if (_rxMemNetReceipt == null) {
        _rxMemNetReceipt = RxNetReceipt();
      }
    } catch(e) {
      _rxMemNetReceipt = RxNetReceipt();
    }


    // // ハイタッチ受信  RXMEM_HI_TOUCH
    try {
      if (_rxMemHiTouch == null) {
        _rxMemHiTouch = RxInputBuf();
      }
    } catch(e) {
      _rxMemHiTouch = RxInputBuf();
    }

    // FenceOver2 フェンスオーバー化対応（mem追加)  RXMEM_FENCE_OVER_2
    try {
      if (_rxMemFenceOver2 == null) {
        _rxMemFenceOver2 = RxInputBuf();
      }
    } catch(e) {
      _rxMemFenceOver2 = RxInputBuf();
    }
    result = RxMem.RXMEM_OK;
    return result;
  }

  /// rxMemGet
  ///
  /// 指定共有メモリ初期化
  ///
  /// 引数:[RxMemIndex]共通メモリインデックス
  ///
  /// 戻り値：RXMEM_OK = Normal End
  ///
  ///      RxMem.RXMEM_NG = Error
  ///
  /// 関連tprxソース: rxmem.c - rxMemGet()
  static Future<int> rxMemGet(RxMemIndex index) async {
    int result = RxMem.RXMEM_NG;
    switch(index) {
      case RxMemIndex.RXMEM_COMMON:   // 共通メモリ */
        try {
          if (_rxMemCommon == null) {
            _rxMemCommon = RxCommonBuf();
          }
        } catch(e) {
          _rxMemCommon = RxCommonBuf();
        }
        break;
      case RxMemIndex.RXMEM_STAT:   // タスクステータス */
        try {
          if (_rxMemStat == null) {
            _rxMemStat = RxTaskStatBuf();
          }
        } catch(e) {
          _rxMemStat = RxTaskStatBuf();
        }
        break;
      case RxMemIndex.RXMEM_CHK_INP:    // チェッカー入力 */
        try {
          if (_rxMemChkInp == null) {
            _rxMemChkInp = RxInputBuf();
          }
        } catch(e) {
          _rxMemChkInp = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_CASH_INP:      // キャッシャー入力 */
        try {
          if (_rxMemCashInp == null) {
            _rxMemCashInp = RxInputBuf();
          }
        } catch(e) {
          _rxMemCashInp = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_CHK_RCT:      // チェッカーレシート */
        try {
          if (_rxMemChkRct == null) {
            _rxMemChkRct = RegsMem();
          }
        } catch(e) {
          _rxMemChkRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_CASH_RCT:      // キャッシャーレシート */
        try {
          if (_rxMemCashRct == null) {
            _rxMemCashRct = RegsMem();
          }
        } catch(e) {
          _rxMemCashRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_UPD_RCT:      // 実績加算レシート */
        try {
          if (_rxMemUpdRct == null) {
            _rxMemUpdRct = RegsMem();
          }
        } catch(e) {
          _rxMemUpdRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_PRN_RCT:      // レシート印字レシート */
        try {
          if (_rxMemPrnRct == null) {
            _rxMemPrnRct = RegsMem();
          }
        } catch(e) {
          _rxMemPrnRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_QCJC_C_PRN_RCT:      // レシート印字レシート */
        try {
          if (_rxMemQCJC_CPrnRct == null) {
            _rxMemQCJC_CPrnRct = RegsMem();
          }
        } catch(e) {
          _rxMemQCJC_CPrnRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_KITCHEN1_PRN_STAT:      // レシート印字レシート */
        try {
          if (_rxMemKitchen1PrnStat == null) {
            _rxMemKitchen1PrnStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemKitchen1PrnStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_KITCHEN2_PRN_STAT:      // レシート印字レシート */
        try {
          if (_rxMemKitchen2PrnStat == null) {
            _rxMemKitchen2PrnStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemKitchen2PrnStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_ACX_STAT:      // ACX ステータス */
        try {
          if (_rxMemAcxStat == null) {
            _rxMemAcxStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemAcxStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_PRN_STAT:      // 印字ステータス */
        try {
          if (_rxMemPrnStat == null) {
            _rxMemPrnStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemPrnStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_QCJC_C_PRN_STAT:      // 印字ステータス */
        try {
          if (_rxMemQCJC_CPrnStat == null) {
            _rxMemQCJC_CPrnStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemQCJC_CPrnStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_CHK_CASH:      // 割込入力 */
        try {
          if (_rxMemChkCash == null) {
            _rxMemChkCash = RxInputBuf();
          }
        } catch(e) {
          _rxMemChkCash = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_JPO_STAT:      // JPO ステータス */
        try {
          if (_rxMemJpoStat == null) {
            _rxMemJpoStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemJpoStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SOCKET:      // SOCKET通信用共通メモリ */
        try {
          if (_rxMemSocket == null) {
            _rxMemSocket = RxSocket();
          }
        } catch(e) {
          _rxMemSocket = RxSocket();
        }
        break;
      case RxMemIndex.RXMEM_SUICA_STAT:      // SUICA ステータス */
        try {
          if (_rxMemSuicaStat == null) {
            _rxMemSuicaStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemSuicaStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_MULTI_STAT:      // MULTI ステータス */
        try {
          if (_rxMemMultiStat == null) {
            _rxMemMultiStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemMultiStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SCL_STAT:      // SCL ステータス */
        try {
          if (_rxMemSclStat == null) {
            _rxMemSclStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemSclStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_RWC_STAT:      // RWC ステータス */
        try {
          if (_rxMemRwcStat == null) {
            _rxMemRwcStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemRwcStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_STROPNCLS:      // 開閉設 入力 */
        try {
          if (_rxMemStrOpnCls == null) {
            _rxMemStrOpnCls = RxInputBuf();
          }
        } catch(e) {
          _rxMemStrOpnCls = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SGSCL1_STAT:      // SGSCL1 ステータス */
        try {
          if (_rxMemSGSCL1Stat == null) {
            _rxMemSGSCL1Stat = RxInputBuf();
          }
        } catch(e) {
          _rxMemSGSCL1Stat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SGSCL2_STAT:      // SGSCL2 ステータス */
        try {
          if (_rxMemSGSCL2Stat == null) {
            _rxMemSGSCL2Stat = RxInputBuf();
          }
        } catch(e) {
          _rxMemSGSCL2Stat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_PROCINST:      // PROCINST ステータス */
        try {
          if (_rxMemProcInst == null) {
            _rxMemProcInst = RxInputBuf();
          }
        } catch(e) {
          _rxMemProcInst = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_ANOTHER1:      // ANOTHER1 入力 */
        try {
          if (_rxMemAnother1 == null) {
            _rxMemAnother1 = RxInputBuf();
          }
        } catch(e) {
          _rxMemAnother1 = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_ANOTHER2:      // ANOTHER2 入力 */
        try {
          if (_rxMemAnother2 == null) {
            _rxMemAnother2 = RxInputBuf();
          }
        } catch(e) {
          _rxMemAnother2 = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_PMOD:      // PMOD 入力 */
        try {
          if (_rxMemPmod == null) {
            _rxMemPmod = RxInputBuf();
          }
        } catch(e) {
          _rxMemPmod = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SALE:      // SALE_COM_MM 入力 */
        try {
          if (_rxMemSale == null) {
            _rxMemSale = RxInputBuf();
          }
        } catch(e) {
          _rxMemSale = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_REPT:      // REPORT 入力 */
        try {
          if (_rxMemRept == null) {
            _rxMemRept = RxInputBuf();
          }
        } catch(e) {
          _rxMemRept = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_STPR_RCT:      // ステーション印字 */
        try {
          if (_rxMemStprRct == null) {
            _rxMemStprRct = RegsMem();
          }
        } catch(e) {
          _rxMemStprRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_STPR_STAT:      // ステーションステータス */
        try {
          if (_rxMemStprStat == null) {
            _rxMemStprStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemStprStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_MNTCLT:      // MENTECLIENT Input */
        try {
          if (_rxMemMntClt == null) {
            _rxMemMntClt = RxMntclt();
          }
        } catch(e) {
          _rxMemMntClt = RxMntclt();
        }
        break;
      case RxMemIndex.RXMEM_SOUND:      // 音声ステータス */
        try {
          if (_rxMemSound == null) {
            _rxMemSound = RxSoundStat();
          }
        } catch(e) {
          _rxMemSound = RxSoundStat();
        }
        break;
      case RxMemIndex.RXMEM_S2PR_RCT:      // ２ステーション印字 */
        try {
          if (_rxMemS2PrRct == null) {
            _rxMemS2PrRct = RegsMem();
          }
        } catch(e) {
          _rxMemS2PrRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_S2PR_STAT:      // ２ステーションステータス */
        try {
          if (_rxMemS2PrStat == null) {
            _rxMemS2PrStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemS2PrStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_BANK_STAT:      // BANKステータスバッファ */
        try {
          if (_rxMemBankStat == null) {
            _rxMemBankStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemBankStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_NSC_RCT:      //  BANKレシートバッファ */
        try {
          if (_rxMemNscRct == null) {
            _rxMemNscRct = RegsMem();
          }
        } catch(e) {
          _rxMemNscRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_FENCE_OVER:      // FenceOver */
        try {
          if (_rxMemFenceOver == null) {
            _rxMemFenceOver = RxInputBuf();
          }
        } catch(e) {
          _rxMemFenceOver = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SOUND2:      // 音声ステータス */
        try {
          if (_rxMemSound2 == null) {
            _rxMemSound2 = RxSoundStat();
          }
        } catch(e) {
          _rxMemSound2 = RxSoundStat();
        }
        break;
      case RxMemIndex.RXMEM_ACXREAL:      // 釣銭釣札機リアル問い合わせ処理 */
        try {
          if (_rxMemAcxReal == null) {
            _rxMemAcxReal = RxInputBuf();
          }
        } catch(e) {
          _rxMemAcxReal = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_MP1_RCT:      // MP1印字 */
        try {
          if (_rxMemMp1Rct == null) {
            _rxMemMp1Rct = RegsMem();
          }
        } catch(e) {
          _rxMemMp1Rct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_CUSTREAL_STAT:      // 顧客リアルステータスバッファ */
        try {
          if (_rxMemCustRealStat == null) {
            _rxMemCustRealStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemCustRealStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_CUSTREAL_SOCKET:      // 顧客リアルSOCKET通信用共通メモリ */
        try {
          if (_rxMemCustRealSocket == null) {
            _rxMemCustRealSocket = RxSocket();
          }
        } catch(e) {
          _rxMemCustRealSocket = RxSocket();
        }
        break;
      case RxMemIndex.RXMEM_QCCONNECT_STAT:      // QcConnectステータスバッファ */
        try {
          if (_rxMemQCConnectStat == null) {
            _rxMemQCConnectStat = RxQcConnect();
          }
        } catch(e) {
          _rxMemQCConnectStat = RxQcConnect();
        }
        break;
      case RxMemIndex.RXMEM_CREDIT_SOCKET:      // // クレジット SOCKET通信用共通メモリ */
        try {
          if (_rxMemCreditSocket == null) {
            _rxMemCreditSocket = RxSocket();
          }
        } catch(e) {
          _rxMemCreditSocket = RxSocket();
        }
        break;
      case RxMemIndex.RXMEM_CUSTREAL_NECSOCKET:      // NECSOCKET通信用共通メモリ */
        try {
          if (_rxMemCustRealNecSocket == null) {
            _rxMemCustRealNecSocket = RxSocket();
          }
        } catch(e) {
          _rxMemCustRealNecSocket = RxSocket();
        }
        break;
      case RxMemIndex.RXMEM_MASR_STAT:      // MASR自走式磁気リーダ ステータス */
        try {
          if (_rxMemMasrStat == null) {
            _rxMemMasrStat = RxInputBuf();
          }
        } catch(e) {
          _rxMemMasrStat = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_CASH_RECYCLE:      // キャッシュリサイクル処理 */
        try {
          if (_rxMemCashRecycle == null) {
            _rxMemCashRecycle = RxInputBuf();
          }
        } catch(e) {
          _rxMemCashRecycle = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_SQRC:      // SQRC Ticket */
        try {
          if (_rxMemSQRc == null) {
            _rxMemSQRc = RxInputBuf();
          }
        } catch(e) {
          _rxMemSQRc = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_MAIL_SENDER:      // 電子メール送信処理 */
        try {
          if (_rxMemMailSender == null) {
            _rxMemMailSender = RxMailSender();
          }
        } catch(e) {
          _rxMemMailSender = RxMailSender();
        }
        break;
      case RxMemIndex.RXMEM_DUMMY_PRN_RCT:      // ダミープリント処理 */
        try {
          if (_rxMemDummyPrnRct == null) {
            _rxMemDummyPrnRct = RegsMem();
          }
        } catch(e) {
          _rxMemDummyPrnRct = RegsMem();
        }
        break;
      case RxMemIndex.RXMEM_DUMMY_PRN_STAT:      // ダミープリント処理 */
        try {
          if (_rxMemDummyPrnStat == null) {
            _rxMemDummyPrnStat = RxPrnStat();
          }
        } catch(e) {
          _rxMemDummyPrnStat = RxPrnStat();
        }
        break;
      case RxMemIndex.RXMEM_NET_RECEIPT:      // 電子レシート処理 */
        try {
          if (_rxMemNetReceipt == null) {
            _rxMemNetReceipt = RxNetReceipt();
          }
        } catch(e) {
          _rxMemNetReceipt = RxNetReceipt();
        }
        break;
      case RxMemIndex.RXMEM_HI_TOUCH:      // // ハイタッチ受信 */
        try {
          if (_rxMemHiTouch == null) {
            _rxMemHiTouch = RxInputBuf();
          }
        } catch(e) {
          _rxMemHiTouch = RxInputBuf();
        }
        break;
      case RxMemIndex.RXMEM_FENCE_OVER_2:     // FenceOver2 フェンスオーバー化対応（mem追加) */
        try {
          if (_rxMemFenceOver2 == null) {
            _rxMemFenceOver2 = RxInputBuf();
          }
        } catch(e) {
          _rxMemFenceOver2 = RxInputBuf();
        }
        break;
      default:
        debugPrint("rxMemGet No Index");
        break;
    }
    result = RxMem.RXMEM_OK;
    return result;
  }

  /// [暫定] Isolate間で共有するSystemFuncクラスに内包する各クラスを更新する
  ///
  /// 引数:[_parentSendPort] Isolate間通信ポート（メインタスクでコールする場合はNULLで良い）
  ///
  ///     [index] 更新する共有メモリ（クラス）の種別（TASKSTAT_DRW、TASKSTAT_SCAN、TASKSTAT_SOUND、など）
  ///
  ///     [buf] 更新する共有メモリ（クラス）
  ///
  ///     [Attention] 更新箇所（MASTER：デバドラのマスター、MAINTASK：メインタスク、SLAVE：デバドラのスレーブ）
  ///
  ///     [distination] 実行場所（デバッグ用：基本的に空白文字で良い。）
  ///
  /// 戻り値：0 = Normal End (固定)
  ///
  /// ※ドロアでRxTaskStatDrwの内容を更新する場合、index＝TASKSTAT_DRW、buf＝RxTaskStatDrw、attention＝MASTERとする。
  ///
  /// 　もしメインタスクでRxTaskStatDrwの内容を更新する場合、index＝TASKSTAT_DRW、buf＝RxTaskStatDrw、attention＝MAINTASKとする。
  ///
  /// 　デバドラで更新した場合はメインタスクや他デバドラに、メインタスクで更新した場合は各デバドラに、変更が行き渡るよう仕掛けてあります。
  static Future<RxMemRet> rxMemWrite(SendPort? _parentSendPort, RxMemIndex index,
      dynamic buf, RxMemAttn attention, [String distination = ""]) async {

    SystemFuncPayload payload = SystemFuncPayload();
    payload.index = index;
    payload.attention = attention;
    RxMemRet ret = await _syncShareMemory(index, payload, buf, distination);

    if ((ret.result != RxMem.RXMEM_OK) && (attention != RxMemAttn.SLAVE)) {
      // ドライバ側は使っていない場合があるため、SLAVE指定の場合はエラーログは出さない。
      TprLog().logAdd(0, LogLevelDefine.error, "rxMemWrite() error[${index}] : no use");
      ret.result = RxMem.RXMEM_NG;
      return ret;
    }
    isolateRelation(_parentSendPort, index, buf, attention, payload, distination);
    return ret;
  }

  static Future<RxMemRet> _syncShareMemory(RxMemIndex index,
      SystemFuncPayload payload, dynamic buf, [String distination = ""]) async {

    RxMemRet ret = RxMemRet();
    switch (index) {
      case RxMemIndex.RXMEM_COMMON:
        ret.result = _writeRxCommonBuf(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_STAT:
        ret.result = _writeRxTaskStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CHK_INP:
        ret.result = _writeRxMemChkInp(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CASH_INP:
        ret.result = _writeRxMemCashInp(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CHK_RCT:
        ret.result = _writeRxMemChkRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CASH_RCT:
        ret.result = _writeRxMemCashRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_UPD_RCT:
        ret.result = _writeRxMemUpdRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_PRN_RCT:
        ret.result = _writeRxMemPrnRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_PRN_STAT:
        ret.result = _writeRxMemPrnstat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CHK_CASH:
        ret.result = _writeRxMemChkCash(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_ACX_STAT:
        ret.result = _writeRxMemAcxStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_JPO_STAT:
        ret.result = _writeRxMemJpoStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SOCKET:
        ret.result = _writeRxMemSocket(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SCL_STAT:
        ret.result = _writeRxMemSclStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_RWC_STAT:
        ret.result = _writeRxMemRwcStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_STROPNCLS:
        ret.result = _writeRxMemStrOpnCls(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SGSCL1_STAT:
        ret.result = _writeRxMemSGSCL1Stat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SGSCL2_STAT:
        ret.result = _writeRxMemSGSCL2Stat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_PROCINST:
        ret.result = _writeRxMemProcInst(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_ANOTHER1:
        ret.result = _writeRxMemAnother1(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_ANOTHER2:
        ret.result = _writeRxMemAnother2(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_PMOD:
        ret.result = _writeRxMemPmod(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SALE:
        ret.result = _writeRxMemSale(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_REPT:
        ret.result = _writeRxMemRept(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_STPR_RCT:
        ret.result = _writeRxMemStprRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_STPR_STAT:
        ret.result = _writeRxMemStprStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_MNTCLT:
        ret.result = _writeRxMntClt(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SOUND:
        ret.result = _writeRxMemSound(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_S2PR_RCT:
        ret.result = _writeRxMemS2PrRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_S2PR_STAT:
        ret.result = _writeRxMemS2PrStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_BANK_STAT:
        ret.result = _writeRxMemBankStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_NSC_RCT:
        ret.result = _writeRxMemNscRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_FENCE_OVER:
        ret.result = _writeRxMemFenceOver(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SOUND2:
        ret.result = _writeRxMemSound2(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SUICA_STAT:
        ret.result = _writeRxMemSuicaStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_ACXREAL:
        ret.result = _writeRxMemAcxReal(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_MP1_RCT:
        ret.result = _writeRxMemMp1Rct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_MULTI_STAT:
        ret.result = _writeRxMemMultiStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CUSTREAL_STAT:
        ret.result = _writeRxMemCustRealStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CUSTREAL_SOCKET:
        ret.result = _writeRxMemCustRealSocket(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_QCCONNECT_STAT:
        ret.result = _writeRxMemQCConnectStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CREDIT_SOCKET:
        ret.result = _writeRxMemCreditSocket(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CUSTREAL_NECSOCKET:
        ret.result = _writeRxMemCustRealNecSocket(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_MASR_STAT:
        ret.result = _writeRxMemMasrStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_CASH_RECYCLE:
        ret.result = _writeRxMemCashRecycle(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_QCJC_C_PRN_RCT:
        ret.result = _writeRxMemQCJC_CPrnRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_QCJC_C_PRN_STAT:
        ret.result = _writeRxMemQCJC_CPrnStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_SQRC:
        ret.result = _writeRxMemSQRc(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_KITCHEN1_PRN_RCT:
        ret.result = _writeRxMemKitchen1PrnRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_KITCHEN1_PRN_STAT:
        ret.result = _writeRxMemKitchen1PrnStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_KITCHEN2_PRN_RCT:
        ret.result = _writeRxMemKitchen2PrnRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_KITCHEN2_PRN_STAT:
        ret.result = _writeRxMemKitchen2PrnStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_MAIL_SENDER:
        ret.result = _writeRxMemMailSender(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_DUMMY_PRN_RCT:
        ret.result = _writeRxMemDummyPrnRct(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_DUMMY_PRN_STAT:
        ret.result = _writeRxMemDummyPrnStat(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_NET_RECEIPT:
        ret.result = _writeRxMemNetReceipt(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_HI_TOUCH:
        ret.result = _writeRxMemHiTouch(buf, payload, distination);
        break;
      case RxMemIndex.RXMEM_FENCE_OVER_2:
        ret.result = _writeRxMemFenceOver2(buf, payload, distination);
        break;
      default:
        TprLog().logAdd(0, LogLevelDefine.error, "rxMemWrite() error[${index}] : no asingned index");
        ret.result = RxMem.RXMEM_NG;
        return ret;
    }
    if (ret.result == RxMem.RXMEM_OK) {
      ret.cause = RxMemResult.success;
    }
    return ret;
  }

  static void isolateRelation(SendPort? _parentSendPort, RxMemIndex index,
      dynamic buf, RxMemAttn attention, SystemFuncPayload payload, [String distination = ""]) {
    switch (attention) {
      case RxMemAttn.MASTER:
        if (_parentSendPort != null) {
          if (DEBUG_UT) {
            debugPrint("${distination}  ${index.toString()} / ${attention.toString()}");
          }
          payload.attention = RxMemAttn.MAIN_TASK;
          _parentSendPort.send(NotifyFromSIsolate(
              NotifyTypeFromSIsolate.uploadShareMemory, payload));
        }
        break;
      case RxMemAttn.SLAVE:
        // 共有メモリを更新して終了
        if (DEBUG_UT) {
          debugPrint("${distination}  ${index.toString()} / ${attention.toString()}");
        }
        break;
      case RxMemAttn.MAIN_TASK:
        if (DEBUG_UT) {
          debugPrint("${distination}  ${index.toString()} / ${attention.toString()}");
        }
        payload.attention = RxMemAttn.SLAVE;
        if (_parentSendPort == null) {
          IfDrvControl().drwIsolateCtrl.updateShareMemory(payload);
          IfDrvControl().mkeyIsolateCtrl.updateShareMemory(payload);
          IfDrvControl().scanIsolateCtrl.updateShareMemory(payload);
          if (DualCashierUtil.isRegister2()) {
            IfDrvControl().scanIsolateCtrl2.updateShareMemory(payload);
          }
          IfDrvControl().multiTmnIsolateCtrl.updateShareMemory(payload);
          IfDrvControl().changerIsolateCtrl.updateShareMemory(payload);
          PosPsMonitoring.updateShareMemory(payload);
          IfDrvControl().sampleIsolateCtrl.updateShareMemory(payload); // 新規追加時確認用
          ActualResults().sendUpdateShareMemory(payload);   // 実績集計
        }
        break;
      default:
        break;
    }
  }

//*******************************************************************************
// 共有メモリ取得処理
//*******************************************************************************

  static RxMemRet rxMemRead(RxMemIndex index) {
    RxMemRet ret = RxMemRet();
    try {
      ret.result = RxMem.RXMEM_OK;
      switch (index) {
        case RxMemIndex.RXMEM_COMMON:
          ret.object = _rxMemCommon;
          break;
        case RxMemIndex.RXMEM_STAT:
          ret.object = _rxMemStat;
          break;
        case RxMemIndex.RXMEM_CHK_INP:
          ret.object = _rxMemChkInp;
          break;
        case RxMemIndex.RXMEM_CASH_INP:
          ret.object = _rxMemCashInp;
          break;
        case RxMemIndex.RXMEM_CHK_RCT:
          ret.object = _rxMemChkRct;
          break;
        case RxMemIndex.RXMEM_CASH_RCT:
          ret.object = _rxMemCashRct;
          break;
        case RxMemIndex.RXMEM_UPD_RCT:
          ret.object = _rxMemUpdRct;
          break;
        case RxMemIndex.RXMEM_PRN_RCT:
          ret.object = _rxMemPrnRct;
          break;
        case RxMemIndex.RXMEM_PRN_STAT:
          ret.object = _rxMemPrnStat;
          break;
        case RxMemIndex.RXMEM_CHK_CASH:
          ret.object = _rxMemChkCash;
          break;
        case RxMemIndex.RXMEM_ACX_STAT:
          ret.object = _rxMemAcxStat;
          break;
        case RxMemIndex.RXMEM_JPO_STAT:
          ret.object = _rxMemJpoStat;
          break;
        case RxMemIndex.RXMEM_SOCKET:
          ret.object = _rxMemSocket;
          break;
        case RxMemIndex.RXMEM_SCL_STAT:
          ret.object = _rxMemSclStat;
          break;
        case RxMemIndex.RXMEM_RWC_STAT:
          ret.object = _rxMemRwcStat;
          break;
        case RxMemIndex.RXMEM_STROPNCLS:
          ret.object = _rxMemStrOpnCls;
          break;
        case RxMemIndex.RXMEM_SGSCL1_STAT:
          ret.object = _rxMemSGSCL1Stat;
          break;
        case RxMemIndex.RXMEM_SGSCL2_STAT:
          ret.object = _rxMemSGSCL2Stat;
          break;
        case RxMemIndex.RXMEM_PROCINST:
          ret.object = _rxMemProcInst;
          break;
        case RxMemIndex.RXMEM_ANOTHER1:
          ret.object = _rxMemAnother1;
          break;
        case RxMemIndex.RXMEM_ANOTHER2:
          ret.object = _rxMemAnother2;
          break;
        case RxMemIndex.RXMEM_PMOD:
          ret.object = _rxMemPmod;
          break;
        case RxMemIndex.RXMEM_SALE:
          ret.object = _rxMemSale;
          break;
        case RxMemIndex.RXMEM_REPT:
          ret.object = _rxMemRept;
          break;
        case RxMemIndex.RXMEM_STPR_RCT:
          ret.object = _rxMemStprRct;
          break;
        case RxMemIndex.RXMEM_STPR_STAT:
          ret.object = _rxMemStprStat;
          break;
        case RxMemIndex.RXMEM_MNTCLT:
          ret.object = _rxMemMntClt;
          break;
        case RxMemIndex.RXMEM_SOUND:
          ret.object = _rxMemSound;
          break;
        case RxMemIndex.RXMEM_S2PR_RCT:
          ret.object = _rxMemS2PrRct;
          break;
        case RxMemIndex.RXMEM_S2PR_STAT:
          ret.object = _rxMemS2PrStat;
          break;
        case RxMemIndex.RXMEM_BANK_STAT:
          ret.object = _rxMemBankStat;
          break;
        case RxMemIndex.RXMEM_NSC_RCT:
          ret.object = _rxMemNscRct;
          break;
        case RxMemIndex.RXMEM_FENCE_OVER:
          ret.object = _rxMemFenceOver;
          break;
        case RxMemIndex.RXMEM_SOUND2:
          ret.object = _rxMemSound2;
          break;
        case RxMemIndex.RXMEM_SUICA_STAT:
          ret.object = _rxMemSuicaStat;
          break;
        case RxMemIndex.RXMEM_ACXREAL:
          ret.object = _rxMemAcxReal;
          break;
        case RxMemIndex.RXMEM_MP1_RCT:
          ret.object = _rxMemMp1Rct;
          break;
        case RxMemIndex.RXMEM_MULTI_STAT:
          ret.object = _rxMemMultiStat;
          break;
        case RxMemIndex.RXMEM_CUSTREAL_STAT:
          ret.object = _rxMemCustRealStat;
          break;
        case RxMemIndex.RXMEM_CUSTREAL_SOCKET:
          ret.object = _rxMemCustRealSocket;
          break;
        case RxMemIndex.RXMEM_QCCONNECT_STAT:
          ret.object = _rxMemQCConnectStat;
          break;
        case RxMemIndex.RXMEM_CREDIT_SOCKET:
          ret.object = _rxMemCreditSocket;
          break;
        case RxMemIndex.RXMEM_CUSTREAL_NECSOCKET:
          ret.object = _rxMemCustRealNecSocket;
          break;
        case RxMemIndex.RXMEM_MASR_STAT:
          ret.object = _rxMemMasrStat;
          break;
        case RxMemIndex.RXMEM_CASH_RECYCLE:
          ret.object = _rxMemCashRecycle;
          break;
        case RxMemIndex.RXMEM_QCJC_C_PRN_RCT:
          ret.object = _rxMemQCJC_CPrnRct;
          break;
        case RxMemIndex.RXMEM_QCJC_C_PRN_STAT:
          ret.object = _rxMemQCJC_CPrnStat;
          break;
        case RxMemIndex.RXMEM_SQRC:
          ret.object = _rxMemSQRc;
          break;
        case RxMemIndex.RXMEM_KITCHEN1_PRN_RCT:
          ret.object = _rxMemKitchen1PrnRct;
          break;
        case RxMemIndex.RXMEM_KITCHEN1_PRN_STAT:
          ret.object = _rxMemKitchen1PrnStat;
          break;
        case RxMemIndex.RXMEM_KITCHEN2_PRN_RCT:
          ret.object = _rxMemKitchen2PrnRct;
          break;
        case RxMemIndex.RXMEM_KITCHEN2_PRN_STAT:
          ret.object = _rxMemKitchen2PrnStat;
          break;
        case RxMemIndex.RXMEM_MAIL_SENDER:
          ret.object = _rxMemMailSender;
          break;
        case RxMemIndex.RXMEM_DUMMY_PRN_RCT:
          ret.object = _rxMemDummyPrnRct;
          break;
        case RxMemIndex.RXMEM_DUMMY_PRN_STAT:
          ret.object = _rxMemDummyPrnStat;
          break;
        case RxMemIndex.RXMEM_NET_RECEIPT:
          ret.object = _rxMemNetReceipt;
          break;
        case RxMemIndex.RXMEM_HI_TOUCH:
          ret.object = _rxMemHiTouch;
          break;
        case RxMemIndex.RXMEM_FENCE_OVER_2:
          ret.object = _rxMemFenceOver2;
          break;
        default:
          TprLog().logAdd(0, LogLevelDefine.error, "rxMemRead() error[${index}] : no asingned index");
          ret.result = RxMem.RXMEM_NG;
          ret.cause = RxMemResult.invalid_parameter;
          return ret;
      }
      ret.result = RxMem.RXMEM_OK;
      ret.cause = RxMemResult.success;
    } catch(e) {
      TprLog().logAdd(0, LogLevelDefine.error, "rxMemRead() error[${index}] : no instance");
      ret.result = RxMem.RXMEM_NG;
      ret.cause = RxMemResult.no_instance;
    }
    return ret;
  }

  // RxCommonBuf     _rxMemCommon;
  /// Isolate間で共有するクラス（RxCommonBuf）を取得する
  ///
  /// 引数:なし
  ///
  /// 戻り値：取得するクラス（RxCommonBuf）
  static RxCommonBuf readRxCommonBuf() {   // 削除予定
    RxMemRet ret = rxMemRead(RxMemIndex.RXMEM_COMMON);
    return ret.object;
  }

  static RxCommonBuf readRxCmn([dynamic isolate]) {   // 削除予定
    RxMemRet ret = rxMemRead(RxMemIndex.RXMEM_COMMON);
    return ret.object;
  }

  // RxTaskStatBuf   _rxMemStat;
  /// [暫定] Isolate間で共有するクラス（RxTaskStatBuf）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（RxTaskStatBuf）
  static RxTaskStatBuf readRxTaskStat([dynamic isolate]) {   // 削除予定
    RxMemRet ret = rxMemRead(RxMemIndex.RXMEM_STAT);
    return ret.object;
  }

  static RxInputBuf readRxInputBuf([dynamic isolate]) {   // 削除予定
    RxMemRet ret = rxMemRead(RxMemIndex.RXMEM_CHK_INP);
    return ret.object;
  }

  /// [暫定] Isolate間で共有するクラス（IfWaitSave）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（IfWaitSave）
  static IfWaitSave readIfWaitSave([dynamic isolate]) {
    return ifSave;
  }

  /// [暫定] Isolate間で共有するクラス（AtSingl）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（AtSingl）
  static AtSingl readAtSingl([dynamic isolate]) {
    return atSing;
  }

  /// [暫定] Isolate間で共有するクラス（RegsMem）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（RegsMem）
  static RegsMem readRegsMem([dynamic isolate]) {
    return regsMem;
  }

  /// [暫定] Isolate間で共有するクラス（CommonLimitedInput）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（CommonLimitedInput）
  static CommonLimitedInput readCommonLimitedInput([dynamic isolate]) {
    return comLtdInp;
  }

  /// [暫定] Isolate間で共有するクラス（CommonLimitedInput）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（AcbMem）
  static AcbMem readAcbMem([dynamic isolate]) {
    return acbMem;
  }

//*******************************************************************************
// 共有メモリ 読み込み処理のゴミ判断保留場所
//*******************************************************************************
  /// Isolate間で共有するクラス（FbMem）を取得する
  ///
  /// 引数:[isolate] 書き込み先のIsolate ←　意味ないので削除する。
  ///
  /// 戻り値：取得するクラス（FbMem）
  static FbMem readFbMem([dynamic isolate]) {
    return fbMem;
  }

  /// [暫定] Isolate間で共有するクラス（RxSoundStat）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（RxSoundStat）
  static RxSoundStat readRxSoundStat([dynamic isolate]) {
    RxMemRet ret = rxMemRead(RxMemIndex.RXMEM_SOUND);
    return ret.object;
  }

  /// [暫定] Isolate間で共有するクラス（AcMem）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（AcMem）
  static AcMem readAcMem([dynamic isolate]) {
    return cBuf;
  }

  /// [暫定] Isolate間で共有するクラス（Eref）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（Eref）
  static ERef readEref([dynamic isolate]) {
    return eRef;
  }

  /// [暫定] Isolate間で共有するクラス（EsVoid）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（EsVoid）
  static EsVoid readEsVoid([dynamic isolate]) {
    return esVoid;
  }

  /// [暫定] Isolate間で共有するクラス（Onetime）を取得する
  /// 引数:[isolate] 書き込み先のIsolate
  /// 戻り値：取得するクラス（Onetime）
  static Onetime readOnetime([dynamic isolate]) {
    return ot;
  }



//*******************************************************************************
// 共有メモリ書き込み処理
//*******************************************************************************
  // case RxMemIndex.RXMEM_COMMON:
  static int _writeRxCommonBuf(dynamic buf, SystemFuncPayload payload, String distination) {
    RxCommonBuf commonBuf = buf as RxCommonBuf;
    try {
      _rxMemCommon = commonBuf;
      payload.buf = _rxMemCommon;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_STAT:
  static int _writeRxTaskStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxTaskStatBuf rxMemStat = buf as RxTaskStatBuf;
    try {
      _rxMemStat = rxMemStat;
      payload.buf = _rxMemStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CHK_INP:
  static int _writeRxMemChkInp(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemChkInp = input;
      payload.buf = _rxMemChkInp;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CASH_INP:
  static int _writeRxMemCashInp(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemCashInp = input;
      payload.buf = _rxMemCashInp;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CHK_RCT:
  static int _writeRxMemChkRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemChkRct = input;
      payload.buf = _rxMemChkRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CASH_RCT:
  static int _writeRxMemCashRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemCashRct = input;
      payload.buf = _rxMemCashRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_UPD_RCT:
  static int _writeRxMemUpdRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemUpdRct = input;
      payload.buf = _rxMemUpdRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_PRN_RCT:
  static int _writeRxMemPrnRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemPrnRct = input;
      payload.buf = _rxMemPrnRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_PRN_STAT:
  static int _writeRxMemPrnstat(dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemPrnStat = input;
      payload.buf = _rxMemPrnStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }
  // case RxMemIndex.RXMEM_CHK_CASH:
  static int _writeRxMemChkCash(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemChkCash = input;
      payload.buf = _rxMemChkCash;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_ACX_STAT:
  static int _writeRxMemAcxStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemAcxStat = input;
      payload.buf = _rxMemAcxStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_JPO_STAT:
  static int _writeRxMemJpoStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemJpoStat = input;
      payload.buf = _rxMemJpoStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SOCKET:
  static int _writeRxMemSocket(dynamic buf, SystemFuncPayload payload, distination) {
    RxSocket input = buf as RxSocket;
    try {
      _rxMemSocket = input;
      payload.buf = _rxMemSocket;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SCL_STAT:
  static int _writeRxMemSclStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemSclStat = input;
      payload.buf = _rxMemSclStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_RWC_STAT:
  static int _writeRxMemRwcStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemRwcStat = input;
      payload.buf = _rxMemRwcStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_STROPNCLS:
  static int _writeRxMemStrOpnCls(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemStrOpnCls = input;
      payload.buf = _rxMemStrOpnCls;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SGSCL1_STAT:
  static int _writeRxMemSGSCL1Stat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemSGSCL1Stat = input;
      payload.buf = _rxMemSGSCL1Stat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SGSCL2_STAT:
  static int _writeRxMemSGSCL2Stat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemSGSCL2Stat = input;
      payload.buf = _rxMemSGSCL2Stat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_PROCINST:
  static int _writeRxMemProcInst(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemProcInst = input;
      payload.buf = _rxMemProcInst;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_ANOTHER1:
  static int _writeRxMemAnother1(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemAnother1 = input;
      payload.buf = _rxMemAnother1;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_ANOTHER2:
  static int _writeRxMemAnother2(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemAnother2 = input;
      payload.buf = _rxMemAnother2;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_PMOD:
  static int _writeRxMemPmod(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemPmod = input;
      payload.buf = _rxMemPmod;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SALE:
  static int _writeRxMemSale(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemSale = input;
      payload.buf = _rxMemSale;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_REPT:
  static int _writeRxMemRept(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemRept = input;
      payload.buf = _rxMemRept;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_STPR_RCT:
  static int _writeRxMemStprRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemStprRct = input;
      payload.buf = _rxMemStprRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_STPR_STAT:
  static int _writeRxMemStprStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemStprStat = input;
      payload.buf = _rxMemStprStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_MNTCLT:
  static int _writeRxMntClt(dynamic buf, SystemFuncPayload payload, distination) {
    RxMntclt input = buf as RxMntclt;
    try {
      _rxMemMntClt = input;
      payload.buf = _rxMemMntClt;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SOUND:
  static int _writeRxMemSound(dynamic buf, SystemFuncPayload payload, distination) {
    RxSoundStat input = buf as RxSoundStat;
    try {
      _rxMemSound = input;
      payload.buf = _rxMemSound;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_S2PR_RCT:
  static int _writeRxMemS2PrRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemS2PrRct = input;
      payload.buf = _rxMemS2PrRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_S2PR_STAT:
  static int _writeRxMemS2PrStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemS2PrStat = input;
      payload.buf = _rxMemS2PrStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_BANK_STAT:
  static int _writeRxMemBankStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemBankStat = input;
      payload.buf = _rxMemBankStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_NSC_RCT:
  static int _writeRxMemNscRct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemNscRct = input;
      payload.buf = _rxMemNscRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_FENCE_OVER:
  static int _writeRxMemFenceOver(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemFenceOver = input;
      payload.buf = _rxMemFenceOver;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SOUND2:
  static int _writeRxMemSound2(dynamic buf, SystemFuncPayload payload, distination) {
    RxSoundStat input = buf as RxSoundStat;
    try {
      _rxMemSound2 = input;
      payload.buf = _rxMemSound2;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SUICA_STAT:
  static int _writeRxMemSuicaStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemSuicaStat = input;
      payload.buf = _rxMemSuicaStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_ACXREAL:
  static int _writeRxMemAcxReal(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemAcxReal = input;
      payload.buf = _rxMemAcxReal;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_MP1_RCT:
  static int _writeRxMemMp1Rct(dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemMp1Rct = input;
      payload.buf = _rxMemMp1Rct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_MULTI_STAT:
  static int _writeRxMemMultiStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemMultiStat = input;
      payload.buf = _rxMemMultiStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CUSTREAL_STAT:
  static int _writeRxMemCustRealStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemCustRealStat = input;
      payload.buf = _rxMemCustRealStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CUSTREAL_SOCKET:
  static int _writeRxMemCustRealSocket(dynamic buf, SystemFuncPayload payload, distination) {
    RxSocket input = buf as RxSocket;
    try {
      _rxMemCustRealSocket = input;
      payload.buf = _rxMemCustRealSocket;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_QCCONNECT_STAT:
  static int _writeRxMemQCConnectStat(dynamic buf, SystemFuncPayload payload, distination) {
    RxQcConnect input = buf as RxQcConnect;
    try {
      _rxMemQCConnectStat = input;
      payload.buf = _rxMemQCConnectStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CREDIT_SOCKET:
  static int _writeRxMemCreditSocket(dynamic buf, SystemFuncPayload payload, distination) {
    RxSocket input = buf as RxSocket;
    try {
      _rxMemCreditSocket = input;
      payload.buf = _rxMemCreditSocket;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CUSTREAL_NECSOCKET:
  static int _writeRxMemCustRealNecSocket(dynamic buf, SystemFuncPayload payload, distination) {
    RxSocket input = buf as RxSocket;
    try {
      _rxMemCustRealNecSocket = input;
      payload.buf = _rxMemCustRealNecSocket;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_MASR_STAT:
  static int _writeRxMemMasrStat (dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemMasrStat = input;
      payload.buf = _rxMemMasrStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_CASH_RECYCLE:
  static int _writeRxMemCashRecycle (dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemCashRecycle = input;
      payload.buf = _rxMemCashRecycle;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_QCJC_C_PRN_RCT:
  static int _writeRxMemQCJC_CPrnRct (dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemQCJC_CPrnRct = input;
      payload.buf = _rxMemQCJC_CPrnRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_QCJC_C_PRN_STAT:
  static int _writeRxMemQCJC_CPrnStat (dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemQCJC_CPrnStat = input;
      payload.buf = _rxMemQCJC_CPrnStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_SQRC:
  static int _writeRxMemSQRc (dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemSQRc = input;
      payload.buf = _rxMemSQRc;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_KITCHEN1_PRN_RCT:
  static int _writeRxMemKitchen1PrnRct (dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemKitchen1PrnRct = input;
      payload.buf = _rxMemKitchen1PrnRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_KITCHEN1_PRN_STAT:
  static int _writeRxMemKitchen1PrnStat (dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemKitchen1PrnStat = input;
      payload.buf = _rxMemKitchen1PrnStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_KITCHEN2_PRN_RCT:
  static int _writeRxMemKitchen2PrnRct (dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemKitchen2PrnRct = input;
      payload.buf = _rxMemKitchen2PrnRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_KITCHEN2_PRN_STAT:
  static int _writeRxMemKitchen2PrnStat (dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemKitchen2PrnStat = input;
      payload.buf = _rxMemKitchen2PrnStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_MAIL_SENDER:
  static int _writeRxMemMailSender (dynamic buf, SystemFuncPayload payload, distination) {
    RxMailSender input = buf as RxMailSender;
    try {
      _rxMemMailSender = input;
      payload.buf = _rxMemMailSender;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_DUMMY_PRN_RCT:
  static int _writeRxMemDummyPrnRct (dynamic buf, SystemFuncPayload payload, distination) {
    RegsMem input = buf as RegsMem;
    try {
      _rxMemDummyPrnRct = input;
      payload.buf = _rxMemDummyPrnRct;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_DUMMY_PRN_STAT:
  static int _writeRxMemDummyPrnStat (dynamic buf, SystemFuncPayload payload, distination) {
    RxPrnStat input = buf as RxPrnStat;
    try {
      _rxMemDummyPrnStat = input;
      payload.buf = _rxMemDummyPrnStat;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_NET_RECEIPT:
  static int _writeRxMemNetReceipt (dynamic buf, SystemFuncPayload payload, distination) {
    RxNetReceipt input = buf as RxNetReceipt;
    try {
      _rxMemNetReceipt = input;
      payload.buf = _rxMemNetReceipt;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_HI_TOUCH:
  static int _writeRxMemHiTouch (dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemHiTouch = input;
      payload.buf = _rxMemHiTouch;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  // case RxMemIndex.RXMEM_FENCE_OVER_2:
  static int _writeRxMemFenceOver2 (dynamic buf, SystemFuncPayload payload, distination) {
    RxInputBuf input = buf as RxInputBuf;
    try {
      _rxMemFenceOver2 = input;
      payload.buf = _rxMemFenceOver2;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

//*******************************************************************************
// 共有メモリ 書き込み処理　不要となりそうな関数
//*******************************************************************************

  static int _writeRxCtrl(dynamic buf, SystemFuncPayload payload, String distination) {
    try {
      RxCtrl rxCtrl = buf as RxCtrl;
      rxCtrl = rxCtrl;
      payload.buf = rxCtrl;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }


  static int _writeFbMem(buf, payload, distination) {
    FbMem mem = buf as FbMem;
    try {
      fbMem = mem;
      payload.buf = fbMem;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }


  static int _writeCBuf(buf, payload, distination) {
    AcMem cbuf = buf as AcMem;
    try {
      cBuf = cbuf;
      payload.buf = cBuf;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  static int _writeERef(buf, payload, distination) {
    ERef eref = buf as ERef;
    try {
      eRef = eref;
      payload.buf = eRef;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  static int _writeEsVoid(buf, payload, distination) {
    EsVoid esvoid = buf as EsVoid;
    try {
      esVoid = esvoid;
      payload.buf = esVoid;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  static int _writeOt(buf, payload, distination) {
    Onetime otbuf = buf as Onetime;
    try {
      ot = otbuf;
      payload.buf = ot;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  static int _writeIfSave(buf, payload, distination) {
    IfWaitSave ifsave = buf as IfWaitSave;
    try {
      ifSave = ifsave;
      payload.buf = ifSave;
    } catch(e) {
      return RxMem.RXMEM_NG;
    }
    return RxMem.RXMEM_OK;
  }

  /// [暫定] Isolate間で共有するクラス（RxSoundStat）を更新する
  /// 引数:[isolate] 書き込み先のIsolate
  ///     [buf] 更新するクラス（RxSoundStat）
  /// 戻り値：0 = Normal End (固定)
  static Future<int> writeRxSoundStat(dynamic isolate, RxSoundStat buf) async {
    await rxMemWrite(null, RxMemIndex.RXMEM_SOUND, buf, RxMemAttn.MAIN_TASK);
    return 0;
  }
  /// [暫定] Isolate間で共有するクラス（FbMem）を更新する
  /// 引数:[isolate] 書き込み先のIsolate
  ///     [buf] 更新するクラス（FbMem）
  /// 戻り値：0 = Normal End (固定)
  static Future<int> writeFbMem(dynamic isolate, FbMem buf) async{
    return 0;
  }

  /// [暫定] Isolate間で共有するクラス（RxTaskStatBuf）を更新する
  /// 引数:[isolate] 書き込み先のIsolate
  ///     [buf] 更新するクラス（RxTaskStatBuf）
  /// 戻り値：0 = Normal End (固定)
  static Future<int> writeRxTaskStat(dynamic isolate, RxTaskStatBuf buf) async {
    await rxMemWrite(null, RxMemIndex.RXMEM_STAT, buf, RxMemAttn.MAIN_TASK, "");
    return 0;
  }

  /// [暫定] Isolate間で共有するクラス（RxCommonBuf）を更新する
  /// 引数:[isolate] 書き込み先のIsolate
  ///     [buf] 更新するクラス（RxCommonBuf）
  /// 戻り値：0 = Normal End (固定)
  static Future<int> writeRxCmn(dynamic isolate, RxCommonBuf buf) async {
    await rxMemWrite(null, RxMemIndex.RXMEM_COMMON, buf, RxMemAttn.MAIN_TASK);
    return 0;
  }

  /// ドロワのステータスを取得する
  /// 引数:[tsBuf] 更新するクラス（RxTaskStatBuf）
  /// 戻り値：0 = Normal End (固定)
  static Future<RxTaskStatDrw> statDrwGet(RxTaskStatBuf tsBuf) async {
    if (await CmCksys.cmDummyPrintMyself() == 1) {
      return(tsBuf.dummyDrw);
    }

    switch (CmCksys.cmPrintCheck()) {
      case TprDidDef.TPRDIDRECEIPT4:
        return(tsBuf.qcjccDrw);
      case TprDidDef.TPRDIDRECEIPT5:
        return(tsBuf.kitchen1Drw);
      case TprDidDef.TPRDIDRECEIPT6:
          return(tsBuf.kitchen2Drw);
      default:
          return(tsBuf.drw);
    }
  }
}