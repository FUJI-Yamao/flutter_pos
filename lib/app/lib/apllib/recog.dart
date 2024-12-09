/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

import 'package:flutter_pos/app/common/cls_conf/configJsonFile.dart';

import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import 'rx_prt_flag_set.dart';

export '../../inc/apl/rx_mbr_ata_chk.dart';

class RecogRetData {
  RecogValue result = RecogValue.RECOG_NO;
  int keyCheckResult = 0;
  RecogRetData(this.result, {this.keyCheckResult = 0});
}

/// 承認キー関連クラス
///  関連tprxソース:\lib\apllib\recog.c
class Recog {
  static final Recog _instance = Recog._internal();
  factory Recog() {
    return _instance;
  }
  Recog._internal() {}

  /// 変数
  bool typeModeOn = false; /* recog_type_mode */
  /// 共有メモリを更新するかどうか
  /// 大量のデータをアップデートするときなどはfalseにし、全部の処理が終わったら手動でupdateすること.
  bool isUpdateSharedMemory = true; 

  /// 承認キーのJC切り分けを統合する
  ///  関連tprxソース:recog.c - recog_type_on()
  /// 引数: なし
  /// 戻り値: なし
  void recog_type_on() {
    typeModeOn = true;
  }

  /// 承認キーのJC切り分けを行う
  ///  関連tprxソース:recog.c - recog_type_off()
  /// 引数: なし
  /// 戻り値: なし
  void recog_type_off() {
    typeModeOn = false;
  }

  /// 承認キーに関連するパラメタを設定する
  ///  関連tprxソース:recog.c - recog_set()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  ///     [tid] メッセージID
  ///     [recog_num] 取得、設定するパラメタの種類
  ///     [typ] 処理の種類（メモリの値または設定ファイルを更新）
  ///     [RecogValue] 更新する値(enum定義)
  /// 戻り値：1 = Normal End (固定)
  ///       0 = Error
  Future<RecogRetData> recogSetEnum(
      TprTID tid, RecogLists recogNum, RecogTypes typ, RecogValue value) async {
    return await recogSet(tid, recogNum, typ, value.index);
  }

  /// 承認キーに関連するパラメタを設定する
  ///  関連tprxソース:recog.c - recog_set()
  /// 引数:[sysIni] 設定ファイルから取得したデータ
  ///     [tid] メッセージID
  ///     [recog_num] 取得、設定するパラメタの種類
  ///     [typ] 処理の種類（メモリの値または設定ファイルを更新）
  ///     [value] 更新する値
  /// 戻り値：1 = Normal End (固定)
  ///       0 = Error
  Future<RecogRetData> recogSet(
      TprTID tid, RecogLists recogNum, RecogTypes typ, int value) async {
    return await _recogMain(tid, recogNum, true, typ, value, false, "");
  }

  /// 承認キーに関連するパラメタを取得する
  ///  関連tprxソース:recog.c - recog_get()
  /// 引数:[tid] メッセージID
  ///     [recogNum] 設定するパラメタの種類
  ///     [typ] 処理の種類（メモリまたは設定ファイルから値を取得）
  /// 戻り値：RecogRet（0:NO, 1:YES, 2:OK0893, 3:YES_EMER）
  Future<RecogRetData> recogGet(
      TprTID tid, RecogLists recogNum, RecogTypes typ) async {
    return await _recogMain(tid, recogNum, false, typ, 0, false, '');
  }

  /// 承認キーに関連するパラメタを取得する（戻り値:int - RcInfoMem.rcRecog格納用）
  ///  関連tprxソース:recog.c - recog_get()
  /// 引数:[tid] メッセージID
  ///     [recogNum] 設定するパラメタの種類
  ///     [typ] 処理の種類（メモリまたは設定ファイルから値を取得）
  /// 戻り値：RecogRet（0:NO, 1:YES,OK0893,YES_EMER）
  Future<int> recogGetInt(
      TprTID tid, RecogLists recogNum, RecogTypes typ) async {
    RecogValue val = (await _recogMain(tid, recogNum, false, typ, 0, false, '')).result;
    switch (val) {
      case RecogValue.RECOG_YES:
      case RecogValue.RECOG_OK0893:
      case RecogValue.RECOG_EMER:
      case RecogValue.RECOG_YES_EMER:
        return 1;
      default:
        return 0;
    }
  }

  /// 承認キーに関連するパラメタを取得する（参照ファイル名追記）
  ///  関連tprxソース:recog.c - recog_get_dir()
  /// 引数: [tid] メッセージID
  ///     [recogNum] 取得するパラメタの種類
  ///     [typ] 処理の種類（メモリまたは設定ファイルから値を取得）
  ///     [filename] 参照ファイル名の頭に追記する名称
  /// 戻り値：RecogRet（0:NO, 1:YES, 2:OK0893, 3:YES_EMER）
  Future<RecogRetData> recogGetDir(
      TprTID tid, RecogLists recogNum, RecogTypes typ, String filename) async {
    return await _recogMain(tid, recogNum, false, typ, 0, false, filename);
  }

  /// 承認キーに関連するパラメタを取得する
  ///  関連tprxソース:recog.c - recog_chk_get()
  ///  - recog_get()とほぼ同じだが, 第4引数に取得時の結果を返している.
  ///    recog_numが使用していないキーの場合, recog_main()で-1をセットする.
  ///		 承認キーを1つだけみるのであれば不要だが,
  ///    承認キーをすべて見るときなどはエラーが出やすいのでこの関数を用意している.
  ///     [tid] メッセージID
  ///     [recogNum] 設定するパラメタの種類
  ///     [typ] 処理の種類（メモリまたは設定ファイルから値を取得）
  ///     備考  戻り値のRECOG_NOはエラーでもこの値で,
  ///          さらにチェック関数の大部分は != RECOG_NOで確認していることから安易にエラーを返せない.
  /// 戻り値：RecogRet（0:NO, 1:YES, 2:OK0893, 3:YES_EMER）
  Future<RecogRetData> recogChkGet(
      TprTID tid, RecogLists recogNum, RecogTypes typ) async {
    return await _recogMain(tid, recogNum, false, typ, 0, true, '');
  }

  /// 承認キーに関連するパラメタをメモリまたは設定ファイルから取得、設定を行う
  ///  関連tprxソース:recog.c - recog_main()
  /// 引数:[sysIni] 読み込んだ設定ファイル
  ///     [tid] メッセージID
  ///     [recog_num] 取得、設定するパラメタの種類
  ///     [typ] 処理の種類（メモリの値または設定ファイルを更新）
  ///     [settingValue] 更新する値
  ///     [keyChk] recog_chk_get()の時にセットする.のちに続くsetなどで再度エラーになるのを防ぐため.
  ///     備考  戻り値のRECOG_NOはエラーでもこの値で,
  ///          さらにチェック関数の大部分は != RECOG_NOで確認していることから安易にエラーを返せない.
  ///     [filename] 参照ファイル名の頭に追記する名称
  /// 戻り値：[取得時] 承認キー関連パラメタの値
  ///       [設定時] 1 = Normal End
  ///              0 = Error
  Future<RecogRetData> _recogMain(
      TprTID tid,
      RecogLists recogNum,
      bool isSetting,
      RecogTypes checkType,
      int settingValue,
      bool isRetKey,
      String filename) async {
    RecogTypes typ = checkType;
    /* 登録モードで、承認キーをＪＣ分けを行わない場合 */
    if (typeModeOn) {
      switch (typ) {
        case RecogTypes.RECOG_GETMEM:
        case RecogTypes.RECOG_GETMEM_JC_J:
        case RecogTypes.RECOG_GETMEM_JC_C:
          typ = RecogTypes.RECOG_GETMEM_ALL;
          break;
        case RecogTypes.RECOG_GETSYS:
        case RecogTypes.RECOG_GETSYS_JC_J:
        case RecogTypes.RECOG_GETSYS_JC_C:
        case RecogTypes.RECOG_GETSYS_ALL:
          typ = RecogTypes.RECOG_GETSYS_ALL;
          break;
        default:
          break;
      }
    }

    /* パラメータチェック */
    if ((recogNum.index < 0 || recogNum.index >= RecogLists.RECOG_MAX.index) ||
        (isSetting != typ.isSetting)) {
      // recogNumがenumの範囲外だったり、isSettingがRecogTypesと一致してなかったらNG.
      TprLog().logAdd(tid, LogLevelDefine.error,
          "_recogMain() param error[$recogNum][$isSetting][$typ][$settingValue]");
      return RecogRetData(RecogValue.RECOG_NO);
    }
    if (isSetting &&
        (settingValue != RecogValue.RECOG_NO.index) &&
        (settingValue != RecogValue.RECOG_YES.index) &&
        (settingValue != RecogValue.RECOG_OK0893.index) &&
        (settingValue != RecogValue.RECOG_EMER.index)) {
      // セットする場合、セットするIDが存在しないものならNG
      TprLog().logAdd(tid, LogLevelDefine.error,
          "_recogMain() param error2[$recogNum][$isSetting][$typ][$settingValue]");
      return RecogRetData(RecogValue.RECOG_NO);
    }
    RxCommonBuf? cMem;
    bool isUseMemory = typ.isMemory;
    if (isUseMemory) {
      // メモリを使用するタイプなら、共有メモリが使用できるかチェック.
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "_recogMain() rxMemRead error[$recogNum][$isSetting][$typ][$settingValue]");
        return RecogRetData(RecogValue.RECOG_NO);
      }
      cMem = xRet.object;
    }

    // 承認キー 参照用情報取得
    var (retValue,refInfo) = await getRefInfo(recogNum,  isUseMemory);
    switch (retValue) {
      case RefInfoRet.ERROR: // エラー
        TprLog().logAdd(
            tid, LogLevelDefine.error, "_recogMain() error[$recogNum][$typ]");
        return RecogRetData(RecogValue.RECOG_NO);
      case RefInfoRet.RECOG_NUM_ERROR: // 承認キーなし
        int retValue = 0;
        if (isRetKey) {
          retValue = -1; // 承認キー確認は全捜査するが, 不要なチェックをしているため, スキップ用に戻り値をセット.
        } else {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "_recogMain() recog_num error[$recogNum][$typ]");
        }
        return RecogRetData(RecogValue.RECOG_NO, keyCheckResult: retValue);
      case RefInfoRet.NOT_USE: // 未使用
        return RecogRetData(RecogValue.RECOG_NO, keyCheckResult: -1);
      default: // 正常
        break;
    }
    // 設定ファイルの設定値.
    String iniValue = "";
    if (isUseMemory) {
      iniValue = refInfo.data;
    }
    int page = refInfo.page;
    int func = refInfo.func;
    String keyword = refInfo.keyword;

    if ((page < 1) ||
        (page > RxMbrAtaChk.RECOG_PAGE_MAX) ||
        (func < 1) ||
        (func > RxMbrAtaChk.RECOG_FUNC_MAX)) {
      if (!((page == 1) && ((func == 19) || (func == 20)))) {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "recog_main() page[$page] func[$func] error[$recogNum][$typ]");
        return RecogRetData(RecogValue.RECOG_NO);
      }
    }

    /* 承認キーの結果を返す */
    switch (typ) {
      case RecogTypes.RECOG_GETMEM:
      case RecogTypes.RECOG_GETMEM_JC_J:
      case RecogTypes.RECOG_GETMEM_JC_C:
      case RecogTypes.RECOG_GETMEM_ALL:
        // メモリに保存されている設定データからのデータ取得.
        RecogValue iniStrDefine = (iniValue == RecogValue.RECOG_YES.iniStr)
            ? RecogValue.RECOG_YES
            : RecogValue.RECOG_NO;
        /* QCJC */
        if ((cMem!.iniSys.type.qcashier_system != RecogValue.RECOG_NO.iniStr) &&
            (cMem!.iniSys.type.receipt_qr_system != RecogValue.RECOG_NO.iniStr)) {
          if (typ == RecogTypes.RECOG_GETMEM_JC_J) {
            /* QCashierJ */
            if (cMem.recog_qcjc[page - 1][func - 1] == 2) {
              iniStrDefine = RecogValue.RECOG_NO;
            }
          } else if (typ == RecogTypes.RECOG_GETMEM_JC_C) {
            /* WebSpeezaC */
            if (cMem.recog_qcjc[page - 1][func - 1] == 1) {
              iniStrDefine = RecogValue.RECOG_NO;
            }
          } else if (typ == RecogTypes.RECOG_GETMEM_ALL) {
          } else {
            /* 登録モードの場合は、以下のＪＣ判断が必要 */
            if (cMem.qcjc_c > 0) {
              if ((cMem.qcjc_c == pid) || (cMem.qcjc_c_print == pid)) {
                /* WebSpeezaC */
                if (cMem.recog_qcjc[page - 1][func - 1] == 1) {
                  iniStrDefine = RecogValue.RECOG_NO;
                }
              } else {
                /* QCashierJ */
                if (cMem.recog_qcjc[page - 1][func - 1] == 2) {
                  iniStrDefine = RecogValue.RECOG_NO;
                }
              }
            }
          }
        }
        if (recogNum == RecogLists.RECOG_REMOTESYSTEM) {
          if (CmCksys.cmAutoUpdateSystem() != 0) {
            //オートアップデート仕様時には、リモートメンテナンス仕様有効扱いにする
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "recog_main() typ[$typ] num[$recogNum] data force ok0893");
            iniStrDefine = RecogValue.RECOG_OK0893;
          }
        }
        if (iniStrDefine == RecogValue.RECOG_YES ||
            iniStrDefine == RecogValue.RECOG_OK0893 ||
            iniStrDefine == RecogValue.RECOG_NO) {
          // 正常値なのでそのまま返す.
          return RecogRetData(iniStrDefine);
        }
        // NGな値が返ってきたのでNOを返す.
        TprLog().logAdd(tid, LogLevelDefine.error,
            "recog_main() typ[$typ] data error[$page][$func][$recogNum][${iniStrDefine.name}]");
        return RecogRetData(RecogValue.RECOG_NO);
      case RecogTypes.RECOG_SETMEM:
        // メモリに設定値をセットする.
        String sVal = (settingValue > RecogValue.RECOG_NO.index)
            ? RecogValue.RECOG_YES.iniStr
            : RecogValue.RECOG_NO.iniStr;
        await setSysIni(recogNum, sVal, false);
        return RecogRetData(RecogValue.RECOG_YES);
      case RecogTypes.RECOG_GETSYS:
      case RecogTypes.RECOG_GETSYS_JC_J:
      case RecogTypes.RECOG_GETSYS_JC_C:
      case RecogTypes.RECOG_GETSYS_ALL:
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          TprLog().logAdd(tid, LogLevelDefine.error,
            "recog_main() typ[$typ] SystemFunc.rxMemRead[RXMEM_COMMON] error");
          return RecogRetData(RecogValue.RECOG_NO);
        }
        cMem = xRet.object;

        final ret = await cMem!.iniSys.getValueWithName("type", keyword);
        if (!ret.result) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "recog_main() typ[$typ] TprLibGetIni error[$page][$func][$recogNum][$keyword][${ret.cause.name}]");
          return RecogRetData(RecogValue.RECOG_NO);
        }
        String sVal = ret.value.toString();

        /* QCJC */
        if ((cMem!.iniSys.type.qcashier_system != RecogValue.RECOG_NO.iniStr) &&
            (cMem!.iniSys.type.receipt_qr_system != RecogValue.RECOG_NO.iniStr)) {
          if (typ == RecogTypes.RECOG_GETSYS) {
            /* 登録モードの場合は、以下のＪＣ判断が必要 */
            if (cMem.qcjc_c > 0) {
              if ((cMem.qcjc_c == pid) || (cMem.qcjc_c_print == pid)) {
                /* WebSpeezaC */
                if (cMem.recog_qcjc[page - 1][func - 1] == 1) {
                  sVal = RecogValue.RECOG_NO.iniStr;
                }
              } else {
                /* QCashierJ */
                if (cMem.recog_qcjc[page - 1][func - 1] == 2) {
                  sVal = RecogValue.RECOG_NO.iniStr;
                }
              }
            }
          } else if (typ == RecogTypes.RECOG_GETSYS_JC_J) {
            if (cMem.recog_qcjc[page - 1][func - 1] == 2) {
              sVal = RecogValue.RECOG_NO.iniStr;
            }
          } else if (typ == RecogTypes.RECOG_GETSYS_JC_C) {
            if (cMem.recog_qcjc[page - 1][func - 1] == 1) {
              sVal = RecogValue.RECOG_NO.iniStr;
            }
          }
        }
        if (recogNum == RecogLists.RECOG_REMOTESYSTEM) {
          if (CmCksys.cmAutoUpdateSystem() != 0) {
            //オートアップデート仕様時には、リモートメンテナンス仕様有効扱いにする
            TprLog().logAdd(tid, LogLevelDefine.normal,
                "recog_main() typ[$typ] num[$recogNum] data force ok0893");
            sVal = RecogValue.RECOG_OK0893.iniStr;
          }
        }
        if (sVal == RecogValue.RECOG_YES.iniStr) {
          return RecogRetData(RecogValue.RECOG_YES);
        }
        if ((sVal == RecogValue.RECOG_OK0893.iniStr) ||
            (sVal == RecogValue.RECOG_OK0893.iniStr2)) {
          return RecogRetData(RecogValue.RECOG_OK0893);
        }
        if (sVal == RecogValue.RECOG_NO.iniStr) {
          return RecogRetData(RecogValue.RECOG_NO);
        }
        TprLog().logAdd(tid, LogLevelDefine.error,
            "recog_main() typ[$typ] TprLibGetIni data[$sVal] error[$page][$func][$recogNum][$keyword]");
        return RecogRetData(RecogValue.RECOG_NO);
      case RecogTypes.RECOG_SETSYS:
        String sVal = "";
        RecogValue define = RecogValue.getDefine(settingValue);
        switch (define) {
          case RecogValue.RECOG_OK0893: //RecogRet.RECOG_OK0893
            sVal = RecogValue.RECOG_OK0893.iniStr;
            break;
          case RecogValue.RECOG_YES: //RecogRet.RECOG_YES
          case RecogValue.RECOG_EMER: //RecogRet.RECOG_YES
            sVal = RecogValue.RECOG_YES.iniStr;
            break;
          default:
            sVal = RecogValue.RECOG_NO.iniStr;
            break;
        }
        await setSysIni(recogNum, sVal, true);
        return RecogRetData(RecogValue.RECOG_YES);
    }

    return RecogRetData(RecogValue.RECOG_NO);
  }

  /// 承認キー番号から、「承認キー参照用情報:RECOG_REF_INFO」 を取得する
  ///  関連tprxソース:recog.c - recog_getRefInfo()
  /// 引数:[sysIni] 読み込んだ設定ファイル
  ///     [recogNo] 承認キーNo
  ///     [refInfo] 取得先の承認キー参照用情報
  ///     [isMemory] 設定ファイル参照フラグ（true:有効  false:無効）
  /// 戻り値: 0=正常, -1=異常, -2:該当承認キーなし, -3:未使用(SKIP指定)
  Future<(RefInfoRet, RecogRefInfo)> getRefInfo(
      RecogLists recogNo, bool isMemory) async {
    RecogRefInfo refInfo = RecogRefInfo(); // 初期化.
    late RxCommonBuf cMem;
    if (isMemory) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return (RefInfoRet.RECOG_NUM_ERROR,refInfo); // 該当承認キーなし
      }
      cMem = xRet.object;
    }
    RecogData data = RecogData.recogDataList[recogNo.index];
    refInfo.keyword = data.keyword;
    refInfo.page = data.page;
    refInfo.func = data.func;

    /* 承認キー毎処理 */
    /// TODO: SysJsonFileクラスに未定義のパラメタは、暫定値として "no" をセット
    switch (recogNo) {
      /* 1ページ */
      case RecogLists.RECOG_MEMBERSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.membersystem;
        break;
      case RecogLists.RECOG_MEMBERPOINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.memberpoint;
        break;
      case RecogLists.RECOG_MEMBERFSP:
        if (isMemory) refInfo.data = cMem.iniSys.type.memberfsp;
        break;
      case RecogLists.RECOG_CREDITSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.creditsystem;
        break;
      case RecogLists.RECOG_SPECIAL_RECEIPT:
        if (isMemory) refInfo.data = "no";
        break; //cMem.iniSys.type.spl_rct;                        break;
      case RecogLists.RECOG_DISC_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.disc_barcode;
        break;
      case RecogLists.RECOG_IWAISYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.iwaisystem;
        break;
      case RecogLists.RECOG_SELF_GATE:
        if (isMemory) refInfo.data = cMem.iniSys.type.self_gate;
        break;
      case RecogLists.RECOG_SYS_24HOUR:
        if (isMemory) refInfo.data = cMem.iniSys.type.sys_24hour;
        break;
      case RecogLists.RECOG_VISMACSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.vismacsystem;
        break;
      case RecogLists.RECOG_HQ_ASP:
        if (isMemory) refInfo.data = cMem.iniSys.type.hq_asp;
        break;
      case RecogLists.RECOG_JASAITAMA_SYS:
        if (isMemory) refInfo.data = cMem.iniSys.type.jasaitama_sys;
        break;
      case RecogLists.RECOG_PROMSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.promsystem;
        break;
      case RecogLists.RECOG_EDYSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.edysystem;
        break;
      case RecogLists.RECOG_FRESH_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.fresh_barcode;
        break;
      case RecogLists.RECOG_SUGI_SYS:
        if (isMemory) refInfo.data = cMem.iniSys.type.sugi_sys;
        break;
      case RecogLists.RECOG_HESOKURISYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.hesokurisystem;
        break;
      case RecogLists.RECOG_GREENSTAMP_SYS:
        if (isMemory) refInfo.data = cMem.iniSys.type.greenstamp_sys;
        break;
      case RecogLists.RECOG_COOPSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.coopsystem;
        break;
      case RecogLists.RECOG_POINTCARDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pointcardsystem;
        break;
      /* 2ページ */
      case RecogLists.RECOG_MOBILESYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.mobilesystem;
        break;
      case RecogLists.RECOG_HQ_OTHER:
        if (isMemory) refInfo.data = cMem.iniSys.type.hq_other;
        break;
      case RecogLists.RECOG_REGCONNECTSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.regconnectsystem;
        break;
      case RecogLists.RECOG_CLOTHES_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.clothes_barcode;
        break;
      case RecogLists.RECOG_FJSS:
        if (isMemory) refInfo.data = cMem.iniSys.type.fjss;
        break;
      case RecogLists.RECOG_MCSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.mcsystem;
        break;
      case RecogLists.RECOG_NETWORK_PRN:
        if (isMemory) refInfo.data = cMem.iniSys.type.network_prn;
        break;
      case RecogLists.RECOG_POPPY_PRINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.poppy_print;
        break;
      case RecogLists.RECOG_TAG_PRINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.tag_print;
        break;
      case RecogLists.RECOG_TAURUS:
        if (isMemory) refInfo.data = cMem.iniSys.type.taurus;
        break;
      case RecogLists.RECOG_NTT_ASP:
        if (isMemory) refInfo.data = cMem.iniSys.type.ntt_asp;
        break;
      case RecogLists.RECOG_EAT_IN:
        if (isMemory) refInfo.data = cMem.iniSys.type.eat_in;
        break;
      case RecogLists.RECOG_MOBILESYSTEM2:
        if (isMemory) refInfo.data = cMem.iniSys.type.mobilesystem2;
        break;
      case RecogLists.RECOG_MAGAZINE_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.magazine_barcode;
        break;
      case RecogLists.RECOG_HQ_OTHER_REAL:
        if (isMemory) refInfo.data = cMem.iniSys.type.hq_other_real;
        break;
      case RecogLists.RECOG_PW410SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pw410system;
        break;
      case RecogLists.RECOG_NSC_CREDIT:
        if (isMemory) refInfo.data = cMem.iniSys.type.nsc_credit;
        break;
      /* 3ページ */
      case RecogLists.RECOG_HQ_PROD:
        if (isMemory) refInfo.data = cMem.iniSys.type.hq_prod;
        break;
      case RecogLists.RECOG_FELICASYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.felicasystem;
        break;
      case RecogLists.RECOG_PSP70SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.psp70system;
        break;
      case RecogLists.RECOG_NTT_BCOM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ntt_bcom;
        break;
      case RecogLists.RECOG_CATALINASYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.catalinasystem;
        break;
      case RecogLists.RECOG_PRCCHKR:
        if (isMemory) refInfo.data = cMem.iniSys.type.prcchkr;
        break;
      case RecogLists.RECOG_DISHCALCSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.dishcalcsystem;
        break;
      case RecogLists.RECOG_ITF_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.itf_barcode;
        break;
      case RecogLists.RECOG_CSS_ACT:
        if (isMemory) refInfo.data = cMem.iniSys.type.css_act;
        break;
      case RecogLists.RECOG_CUST_DETAIL:
        if (isMemory) refInfo.data = cMem.iniSys.type.cust_detail;
        break;
      case RecogLists.RECOG_CUSTREALSVR:
        if (isMemory) refInfo.data = cMem.iniSys.type.custrealsvr;
        break;
      case RecogLists.RECOG_SUICA_CAT:
        if (isMemory) refInfo.data = cMem.iniSys.type.suica_cat;
        break;
      case RecogLists.RECOG_YOMOCASYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.yomocasystem;
        break;
      case RecogLists.RECOG_SMARTPLUSSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.smartplussystem;
        break;
      case RecogLists.RECOG_DUTY:
        if (isMemory) refInfo.data = cMem.iniSys.type.duty;
        break;
      case RecogLists.RECOG_ECOASYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ecoasystem;
        break;
      case RecogLists.RECOG_ICCARDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.iccardsystem;
        break;
      case RecogLists.RECOG_SUB_TICKET:
        if (isMemory) refInfo.data = cMem.iniSys.type.sub_ticket;
        break;
      /* 4ページ */
      case RecogLists.RECOG_QUICPAYSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.quicpaysystem;
        break;
      case RecogLists.RECOG_IDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.idsystem;
        break;
      case RecogLists.RECOG_REVIVAL_RECEIPT:
        if (isMemory) refInfo.data = cMem.iniSys.type.revival_receipt;
        break;
      case RecogLists.RECOG_QUICK_SELF:
        if (isMemory) refInfo.data = cMem.iniSys.type.quick_self;
        break;
      case RecogLists.RECOG_QUICK_SELF_CHG:
        if (isMemory) refInfo.data = cMem.iniSys.type.quick_self_chg;
        break;
      case RecogLists.RECOG_ASSIST_MONITOR:
        if (isMemory) refInfo.data = cMem.iniSys.type.assist_monitor;
        break;
      case RecogLists.RECOG_MP1_PRINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.mp1_print;
        break;
      case RecogLists.RECOG_REALITMSEND:
        if (isMemory) refInfo.data = cMem.iniSys.type.realitmsend;
        break;
      case RecogLists.RECOG_RAINBOWCARD:
        if (isMemory) refInfo.data = cMem.iniSys.type.rainbowcard;
        break;
      case RecogLists.RECOG_GRAMX:
        if (isMemory) refInfo.data = cMem.iniSys.type.gramx;
        break;
      case RecogLists.RECOG_MM_ABJ:
        if (isMemory) refInfo.data = cMem.iniSys.type.mm_abj;
        break;
      case RecogLists.RECOG_CAT_POINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.cat_point;
        break;
      case RecogLists.RECOG_TAGRDWT:
        if (isMemory) refInfo.data = cMem.iniSys.type.tagrdwt;
        break;
      case RecogLists.RECOG_DEPARTMENT_STORE:
        if (isMemory) refInfo.data = cMem.iniSys.type.department_store;
        break;
      case RecogLists.RECOG_EDYNO_MBR:
        if (isMemory) refInfo.data = cMem.iniSys.type.edyno_mbr;
        break;
      case RecogLists.RECOG_FCF_CARD:
        if (isMemory) refInfo.data = cMem.iniSys.type.fcf_card;
        break;
      case RecogLists.RECOG_PANAMEMBERSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.panamembersystem;
        break;
      case RecogLists.RECOG_LANDISK:
        if (isMemory) refInfo.data = cMem.iniSys.type.landisk;
        break;
      /* 5ページ */
      case RecogLists.RECOG_PITAPASYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pitapasystem;
        break;
      case RecogLists.RECOG_TUOCARDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.tuocardsystem;
        break;
      case RecogLists.RECOG_SALLMTBAR:
        if (isMemory) refInfo.data = cMem.iniSys.type.sallmtbar;
        break;
      case RecogLists.RECOG_BUSINESS_MODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.business_mode;
        break;
      case RecogLists.RECOG_MCP200SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.mcp200system;
        break;
      case RecogLists.RECOG_SPVTSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.spvtsystem;
        break;
      case RecogLists.RECOG_REMOTESYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.remotesystem;
        break;
      case RecogLists.RECOG_ORDER_MODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.order_mode;
        break;
      case RecogLists.RECOG_JREM_MULTISYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.jrem_multisystem;
        break;
      case RecogLists.RECOG_MEDIA_INFO:
        if (isMemory) refInfo.data = cMem.iniSys.type.media_info;
        break;
      case RecogLists.RECOG_GS1_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.gs1_barcode;
        break;
      case RecogLists.RECOG_ASSORTSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.assortsystem;
        break;
      case RecogLists.RECOG_CENTER_SERVER:
        if (isMemory) refInfo.data = cMem.iniSys.type.center_server;
        break;
      case RecogLists.RECOG_RESERVSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.reservsystem;
        break;
      case RecogLists.RECOG_DRUG_REV:
        if (isMemory) refInfo.data = cMem.iniSys.type.drug_rev;
        break;
      case RecogLists.RECOG_GINCARDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.gincardsystem;
        break;
      case RecogLists.RECOG_FCLQPSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.fclqpsystem;
        break;
      case RecogLists.RECOG_FCLEDYSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.fcledysystem;
        break;
      /* 6ページ */
      case RecogLists.RECOG_CAPS_CAFIS:
        if (isMemory) refInfo.data = cMem.iniSys.type.caps_cafis;
        break;
      case RecogLists.RECOG_FCLIDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.fclidsystem;
        break;
      case RecogLists.RECOG_PTCKTISSUSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ptcktissusystem;
        break;
      case RecogLists.RECOG_ABS_PREPAID:
        if (isMemory) refInfo.data = cMem.iniSys.type.abs_prepaid;
        break;
      case RecogLists.RECOG_PROD_ITEM_AUTOSET:
        if (isMemory) refInfo.data = cMem.iniSys.type.prod_item_autoset;
        break;
      case RecogLists.RECOG_PROD_ITF14_BARCODE:
        if (isMemory) refInfo.data = cMem.iniSys.type.prod_itf14_barcode;
        break;
      case RecogLists.RECOG_SPECIAL_COUPON:
        if (isMemory) refInfo.data = cMem.iniSys.type.special_coupon;
        break;
      case RecogLists.RECOG_BLUECHIP_SERVER:
        if (isMemory) refInfo.data = cMem.iniSys.type.bluechip_server;
        break;
      case RecogLists.RECOG_HITACHI_BLUECHIP:
        if (isMemory) refInfo.data = cMem.iniSys.type.hitachi_bluechip;
        break;
      case RecogLists.RECOG_HQ_OTHER_CANTEVOLE:
        if (isMemory) refInfo.data = cMem.iniSys.type.hq_other_cantevole;
        break;
      case RecogLists.RECOG_QCASHIER_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.qcashier_system;
        break;
      case RecogLists.RECOG_RECEIPT_QR_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.receipt_qr_system;
        break;
      case RecogLists.RECOG_VISATOUCH_INFOX:
        if (isMemory) refInfo.data = cMem.iniSys.type.visatouch_infox;
        break;
      case RecogLists.RECOG_PBCHG_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pbchg_system;
        break;
      case RecogLists.RECOG_HC1_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.hc1_system;
        break;
      case RecogLists.RECOG_CAPS_HC1_CAFIS:
        if (isMemory) refInfo.data = cMem.iniSys.type.caps_hc1_cafis;
        break;
      case RecogLists.RECOG_REMOTESERVER:
        if (isMemory) refInfo.data = cMem.iniSys.type.remoteserver;
        break;
      case RecogLists.RECOG_MRYCARDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.mrycardsystem;
        break;
      /* 7ページ */
      case RecogLists.RECOG_SP_DEPARTMENT:
        if (isMemory) refInfo.data = cMem.iniSys.type.sp_department;
        break;
      case RecogLists.RECOG_DECIMALITMSEND:
        if (isMemory) refInfo.data = cMem.iniSys.type.decimalitmsend;
        break;
      case RecogLists.RECOG_WIZ_CNCT:
        if (isMemory) refInfo.data = cMem.iniSys.type.wiz_cnct;
        break;
      case RecogLists.RECOG_ABSV31_RWT:
        if (isMemory) refInfo.data = cMem.iniSys.type.absv31_rwt;
        break;
      case RecogLists.RECOG_PLURALQR_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pluralqr_system;
        break;
      case RecogLists.RECOG_NETDOARESERV:
        if (isMemory) refInfo.data = cMem.iniSys.type.netdoareserv;
        break;
      case RecogLists.RECOG_SELPLUADJ:
        if (isMemory) refInfo.data = cMem.iniSys.type.selpluadj;
        break;
      case RecogLists.RECOG_CUSTREAL_WEBSER:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_webser;
        break;
      case RecogLists.RECOG_WIZ_ABJ:
        if (isMemory) refInfo.data = cMem.iniSys.type.wiz_abj;
        break;
      case RecogLists.RECOG_CUSTREAL_UID:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_uid;
        break;
      case RecogLists.RECOG_BDLITMSEND:
        if (isMemory) refInfo.data = cMem.iniSys.type.bdlitmsend;
        break;
      case RecogLists.RECOG_CUSTREAL_NETDOA:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_netdoa;
        break;
      case RecogLists.RECOG_UT_CNCT:
        if (isMemory) refInfo.data = cMem.iniSys.type.ut_cnct;
        break;
      case RecogLists.RECOG_CAPS_PQVIC:
        if (isMemory) refInfo.data = cMem.iniSys.type.caps_pqvic;
        break;
      case RecogLists.RECOG_YAMATO_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.yamato_system;
        break;
      case RecogLists.RECOG_CAPS_CAFIS_STANDARD:
        if (isMemory) refInfo.data = cMem.iniSys.type.caps_cafis_standard;
        break;
      case RecogLists.RECOG_NTTD_PRECA:
        if (isMemory) refInfo.data = cMem.iniSys.type.nttd_preca;
        break;
      case RecogLists.RECOG_USBCAM_CNCT:
        if (isMemory) refInfo.data = cMem.iniSys.type.usbcam_cnct;
        break;
      /* 8ページ */
      case RecogLists.RECOG_DRUGSTORE:
        if (isMemory) refInfo.data = cMem.iniSys.type.drugstore;
        break;
      case RecogLists.RECOG_CUSTREAL_NEC:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_nec;
        break;
      case RecogLists.RECOG_CUSTREAL_OP:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_op;
        break;
      case RecogLists.RECOG_DUMMY_CRDT:
        if (isMemory) refInfo.data = cMem.iniSys.type.dummy_crdt;
        break;
      case RecogLists.RECOG_HC2_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.hc2_system;
        break;
      case RecogLists.RECOG_PRICE_SOUND:
        if (isMemory) refInfo.data = cMem.iniSys.type.price_sound;
        break;
      case RecogLists.RECOG_DUMMY_PRECA:
        if (isMemory) refInfo.data = cMem.iniSys.type.dummy_preca;
        break;
      case RecogLists.RECOG_MONITORED_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.monitored_system;
        break;
      case RecogLists.RECOG_JMUPS_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.jmups_system;
        break;
      case RecogLists.RECOG_UT1QPSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ut1qpsystem;
        break;
      case RecogLists.RECOG_UT1IDSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ut1idsystem;
        break;
      case RecogLists.RECOG_BRAIN_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.brain_system;
        break;
      case RecogLists.RECOG_PFMPITAPASYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pfmpitapasystem;
        break;
      case RecogLists.RECOG_PFMJRICSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pfmjricsystem;
        break;
      case RecogLists.RECOG_CHARGESLIP_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.chargeslip_system;
        break;
      case RecogLists.RECOG_PFMJRICCHARGESYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pfmjricchargesystem;
        break;
      case RecogLists.RECOG_ITEMPRC_REDUCTION_COUPON:
        if (isMemory) refInfo.data = cMem.iniSys.type.itemprc_reduction_coupon;
        break;
      case RecogLists.RECOG_CAT_JNUPS_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cat_jmups_system;
        break;
      /* 9ページ */
      case RecogLists.RECOG_SQRC_TICKET_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sqrc_ticket_system;
        break;
      case RecogLists.RECOG_CCT_CONNECT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cct_connect_system;
        break;
      case RecogLists.RECOG_CCT_EMONEY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cct_emoney_system;
        break;
      case RecogLists.RECOG_TEC_INFOX_JET_S_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.tec_infox_jet_s_system;
        break;
      case RecogLists.RECOG_PROD_INSTORE_ZERO_FLG:
        if (isMemory) refInfo.data = cMem.iniSys.type.prod_instore_zero_flg;
        break;
      /* 10ページ */
      case RecogLists.RECOG_FRONT_SELF_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.front_self_system;
        break;
      case RecogLists.RECOG_TRK_PRECA:
        if (isMemory) refInfo.data = cMem.iniSys.type.trk_preca;
        break;
      case RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.desktop_cashier_system;
        break;
      case RecogLists.RECOG_SUICA_CHARGE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.suica_charge_system;
        break;
      case RecogLists.RECOG_NIMOCA_POINT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.nimoca_point_system;
        break;
      case RecogLists.RECOG_CUSTREAL_POINTARTIST:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_pointartist;
        break;
      case RecogLists.RECOG_TB1_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.tb1_system;
        break;
      case RecogLists.RECOG_TAX_FREE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.tax_free_system;
        break;
      case RecogLists.RECOG_REPICA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.repica_system;
        break;
      case RecogLists.RECOG_CAPS_CARDNET_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.caps_cardnet_system;
        break;
      case RecogLists.RECOG_YUMECA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.yumeca_system;
        break;
      case RecogLists.RECOG_DUMMY_SUICA:
        if (isMemory) refInfo.data = cMem.iniSys.type.dummy_suica;
        break;
      case RecogLists.RECOG_PAYMENT_MNG:
        if (isMemory) refInfo.data = cMem.iniSys.type.payment_mng;
        break;
      case RecogLists.RECOG_CUSTREAL_TPOINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_tpoint;
        break;
      case RecogLists.RECOG_MAMMY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.mammy_system;
        break;
      case RecogLists.RECOG_ITEMTYP_SEND:
        if (isMemory) refInfo.data = cMem.iniSys.type.itemtyp_send;
        break; /* 商品区分 */
      case RecogLists.RECOG_YUMECA_POL_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.yumeca_pol_system;
        break;
      case RecogLists.RECOG_COGCA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cogca_system;
        break;
      /* 11ページ */
      case RecogLists.RECOG_CUSTREAL_HPS:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_hps;
        break;
      case RecogLists.RECOG_MARUTO_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.maruto_system;
        break;
      case RecogLists.RECOG_HC3_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.hc3_system;
        break;
      case RecogLists.RECOG_SM3_MARUI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm3_marui_system;
        break;
      case RecogLists.RECOG_KITCHEN_PRINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.kitchen_print;
        break;
      case RecogLists.RECOG_BDL_MULTI_SELECT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.bdl_multi_select_system;
        break; /* ﾐｯｸｽﾏｯﾁ共通 */
      case RecogLists.RECOG_SALL_LMTBAR26:
        if (isMemory) refInfo.data = cMem.iniSys.type.sallmtbar26;
        break;
      case RecogLists.RECOG_PURCHASE_TICKET_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.purchase_ticket_system;
        break; /* 特定売上チケット発券 */
      case RecogLists.RECOG_CUSTREAL_UNI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_uni_system;
        break;
      case RecogLists.RECOG_EJ_ANIMATION_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ej_animation_system;
        break;
      case RecogLists.RECOG_VALUECARD_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.value_card_system;
        break;
      case RecogLists.RECOG_SM4_COMODI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm4_comodi_system;
        break;
      case RecogLists.RECOG_SM5_ITOKU_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm5_itoku_system;
        break;
      case RecogLists.RECOG_CCT_POINTUSE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cct_pointuse_system;
        break;
      case RecogLists.RECOG_ZHQ_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.zhq_system;
        break;
      /* 12ページ */
      case RecogLists.RECOG_RPOINT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.rpoint_system;
        break;
      case RecogLists.RECOG_VESCA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.vesca_system;
        break;
      case RecogLists.RECOG_CR_NSW_SYSTEM:
        if (isMemory) refInfo.data = "no";
        break; //cMem.iniSys.type.cr_nsw_system;                  break;
      case RecogLists.RECOG_AJS_EMONEY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ajs_emoney_system;
        break;
      /* 13ページ */
      case RecogLists.RECOG_SM16_TAIYO_TOYOCHO_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm16_taiyo_toyocho_system;
        break;
      case RecogLists.RECOG_CR_NSW_DATA_SYSTEM:
        if (isMemory) refInfo.data = "no";
        break; //cMem.iniSys.type.cr2_nsw_system;                 break;
      case RecogLists.RECOG_INFOX_DETAIL_SEND_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.infox_detail_send_system;
        break;
      case RecogLists.RECOG_SELF_MEDICATION_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.self_medication_system;
        break;
      case RecogLists.RECOG_SM20_MAEDA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm20_maeda_system;
        break;
      /* 14ページ */
      case RecogLists.RECOG_PANAWAONSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pana_waon_system;
        break;
      case RecogLists.RECOG_ONEPAYSYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.onepay_system;
        break;
      case RecogLists.RECOG_HAPPYSELF_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.happyself_system;
        break;
      case RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.happyself_smile_system;
        break;
      /* 15ページ */
      case RecogLists.RECOG_LINEPAY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.linepay_system;
        break;
      case RecogLists.RECOG_STAFF_RELEASE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.staff_release_system;
        break;
      case RecogLists.RECOG_REASON_SELECT_STD_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.reason_select_std_system;
        break;
      case RecogLists.RECOG_WIZ_BASE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.wiz_base_system;
        break;
      case RecogLists.RECOG_PACK_ON_TIME_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.pack_on_time_system;
        break;
      /* 16ページ */
      case RecogLists.RECOG_SHOP_AND_GO_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.shop_and_go_system;
        break;
      case RecogLists.RECOG_STAFFID1_YMSS_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.staffid1_ymss_system;
        break;
      case RecogLists.RECOG_TAXFREE_PASSPORTINFO_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.taxfree_passportinfo_system;
        break;
      case RecogLists.RECOG_SM33_NISHIZAWA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm33_nishizawa_system;
        break;
      case RecogLists.RECOG_DS2_GODAI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ds2_godai_system;
        break;
      /* 17ページ */
      case RecogLists.RECOG_SM36_SANPRAZA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm36_sanpraza_system;
        break;
      case RecogLists.RECOG_CR50_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cr50_system;
        break;
      case RecogLists.RECOG_CASE_CLOTHES_BARCODE_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.case_clothes_barcode_system;
        break;
      case RecogLists.RECOG_DPOINT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.dpoint_system;
        break;
      case RecogLists.RECOG_CUSTREAL_DUMMY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_dummy_system;
        break;
      case RecogLists.RECOG_BARCODE_PAY1_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.barcode_pay1_system;
        break;
      case RecogLists.RECOG_CUSTREAL_PTACTIX:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_ptactix;
        break;
      case RecogLists.RECOG_CR3_SHARP_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cr3_sharp_system;
        break;
      case RecogLists.RECOG_GAME_BARCODE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.game_barcode_system;
        break;
      case RecogLists.RECOG_CCT_CODEPAY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cct_codepay_system;
        break;
      case RecogLists.RECOG_WS_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ws_system;
        break;
      case RecogLists.RECOG_CUSTREAL_POINTINFINITY:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_pointinfinity;
        break;
      case RecogLists.RECOG_TOY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.toy_system;
        break;
      case RecogLists.RECOG_CANAL_PAYMENT_SERVICE_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.canal_payment_service_system;
        break;
      /* 18ページ */
      case RecogLists.RECOG_MULTI_VEGA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.multi_vega_system;
        break;
      case RecogLists.RECOG_DISPENSING_PHARMACY_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.dispensing_pharmacy_system;
        break;
      case RecogLists.RECOG_SM41_BELLEJOIS_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm41_bellejois_system;
        break;
      case RecogLists.RECOG_SM42_KANESUE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm42_kanesue_system;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.public_barcode_pay_system;
        break;
      case RecogLists.RECOG_TS_INDIV_SETTING_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.ts_indiv_setting_system;
        break;
      case RecogLists.RECOG_SM44_JA_TSURUOKA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm44_ja_tsuruoka_system;
        break;
      case RecogLists.RECOG_STERA_TERMINAL_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.stera_terminal_system;
        break;
      case RecogLists.RECOG_SM45_OCEAN_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm45_ocean_system;
        break;
      case RecogLists.RECOG_REPICA_POINT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.repica_point_system;
        break;
      case RecogLists.RECOG_FUJITSU_FIP_CODEPAY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.fujitsu_fip_codepay_system;
        break;
      /* 19ページ */
      case RecogLists.RECOG_TAXFREE_SERVER_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.taxfree_server_system;
        break;
      case RecogLists.RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.employee_card_payment_system;
        break;
      case RecogLists.RECOG_NET_RECEIPT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.net_receipt_system;
        break;
      case RecogLists.RECOG_SM49_ITOCHAIN_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm49_itochain_system;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY2_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.public_barcode_pay2_system;
        break;
      case RecogLists.RECOG_MULTI_ONEPAYSYSTEM:
        if (isMemory) refInfo.data = "no";
        break; //cMem.iniSys.type.multi_onepay_system;            break;
      case RecogLists.RECOG_SM52_PALETTE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm52_palette_system;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY3_SYSTEM:
        if (isMemory)
          refInfo.data = cMem.iniSys.type.public_barcode_pay3_system;
        break;
      /* 20ページ */
      case RecogLists.RECOG_SVSCLS2_STLPDSC_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.svscls2_stlpdsc_system;
        break;
      case RecogLists.RECOG_SM55_TAKAYANAGI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm55_takayanagi_system;
        break;
      case RecogLists.RECOG_MAIL_SEND_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.mail_send_system;
        break;
      case RecogLists.RECOG_NETSTARS_CODEPAY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.netstars_codepay_system;
        break;
      case RecogLists.RECOG_SM56_KOBEBUSSAN_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm56_kobebussan_system;
        break;
      case RecogLists.RECOG_HYS1_SERIA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.hys1_seria_system;
        break;
      case RecogLists.RECOG_LIQR_TAXFREE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.liqr_taxfree_system;
        break;
      /* 21ページ */
      case RecogLists.RECOG_CUSTREAL_GYOMUCA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_gyomuca_system;
        break;
      case RecogLists.RECOG_SM59_TAKARAMC_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm59_takaramc_system;
        break;
      case RecogLists.RECOG_DETAIL_NOPRN_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.detail_noprn_system;
        break;
      case RecogLists.RECOG_SM61_FUJIFILM_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm61_fujifilm_system;
        break;
      case RecogLists.RECOG_DEPARTMENT2_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.department2_system;
        break;
      case RecogLists.RECOG_CUSTREAL_CROSSPOINT:
        if (isMemory) refInfo.data = cMem.iniSys.type.custreal_crosspoint;
        break;
      case RecogLists.RECOG_HC12_JOYFUL_HONDA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.hc12_joyful_honda_system;
        break;
      case RecogLists.RECOG_SM62_MARUICHI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm62_maruichi_system;
        break;
      /* 22ページ */
      case RecogLists.RECOG_SM65_RYUBO_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm65_ryubo_system;
        break;
      case RecogLists.RECOG_TOMOIF_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.tomoIF_system;
        break;
      case RecogLists.RECOG_SM66_FRESTA_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm66_fresta_system;
        break;
      case RecogLists.RECOG_COSME1_ISTYLE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.cosme1_istyle_system;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY4_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.public_barcode_pay4_system;
        break;
      case RecogLists.RECOG_SM71_SELECTION_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm71_selection_system;
        break;
      case RecogLists.RECOG_KITCHEN_PRINT_RECIPT:
        if (isMemory) refInfo.data = cMem.iniSys.type.kitchen_print_recipt;
        break;
      case RecogLists.RECOG_MIYAZAKI_CITY_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.miyazaki_city_system;
        break;
      case RecogLists.RECOG_SP1_QR_READ_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sp1_qr_read_system;
        break;
      case RecogLists.RECOG_RF1_HS_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.rf1_hs_system;
        break;
      case RecogLists.RECOG_CASHONLY_KEYOPT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.carparking_qr_system;
        break;
      case RecogLists.RECOG_AIBOX_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.aibox_alignment_system;
        break;
      case RecogLists.RECOG_SM74_OZEKI_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.sm74_ozeki_system;
        break;
      case RecogLists.RECOG_CARPARKING_QR_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.carparking_qr_system;
        break;
      case RecogLists.RECOG_OLC_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.olc_system;
        break;
      case RecogLists.RECOG_QUIZ_PAYMENT_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.quiz_payment_system;
        break;
      case RecogLists.RECOG_JETS_LANE_SYSTEM:
        if (isMemory) refInfo.data = cMem.iniSys.type.jets_lane_system;
        break;
      // 未使用
      case RecogLists.RECOG_SKIP_9_06:
      case RecogLists.RECOG_SKIP_9_07:
      case RecogLists.RECOG_SKIP_9_08:
      case RecogLists.RECOG_SKIP_9_09:
      case RecogLists.RECOG_SKIP_9_10:
      case RecogLists.RECOG_SKIP_9_11:
      case RecogLists.RECOG_SKIP_9_12:
      case RecogLists.RECOG_SKIP_9_13:
      case RecogLists.RECOG_SKIP_9_14:
      case RecogLists.RECOG_SKIP_9_15:
      case RecogLists.RECOG_SKIP_9_16:
      case RecogLists.RECOG_SKIP_9_17:
      case RecogLists.RECOG_SKIP_9_18:
      case RecogLists.RECOG_SKIP_11_16:
      case RecogLists.RECOG_SKIP_11_17:
      case RecogLists.RECOG_SKIP_11_18:
      case RecogLists.RECOG_SKIP_12_1:
      case RecogLists.RECOG_SKIP_12_2:
      case RecogLists.RECOG_SKIP_12_3:
      case RecogLists.RECOG_SKIP_12_4:
      case RecogLists.RECOG_SKIP_12_5:
      case RecogLists.RECOG_SKIP_12_6:
      case RecogLists.RECOG_SKIP_12_8:
      case RecogLists.RECOG_SKIP_12_10:
      case RecogLists.RECOG_SKIP_12_12:
      case RecogLists.RECOG_SKIP_12_13:
      case RecogLists.RECOG_SKIP_12_14:
      case RecogLists.RECOG_SKIP_12_15:
      case RecogLists.RECOG_SKIP_12_16:
      //case RecogLists.RECOG_SKIP_12_17:
      case RecogLists.RECOG_SKIP_12_18:
      case RecogLists.RECOG_SKIP_13_1:
      case RecogLists.RECOG_SKIP_13_2:
      case RecogLists.RECOG_SKIP_13_3:
      case RecogLists.RECOG_SKIP_13_4:
      case RecogLists.RECOG_SKIP_13_6:
      case RecogLists.RECOG_SKIP_13_7:
      case RecogLists.RECOG_SKIP_13_8:
      case RecogLists.RECOG_SKIP_13_9:
      case RecogLists.RECOG_SKIP_13_12:
      case RecogLists.RECOG_SKIP_13_13:
      case RecogLists.RECOG_SKIP_13_14:
      case RecogLists.RECOG_SKIP_13_15:
      case RecogLists.RECOG_SKIP_13_17:
      case RecogLists.RECOG_SKIP_14_1:
      case RecogLists.RECOG_SKIP_14_2:
      case RecogLists.RECOG_SKIP_14_3:
      case RecogLists.RECOG_SKIP_14_4:
      case RecogLists.RECOG_SKIP_14_5:
      case RecogLists.RECOG_SKIP_14_6:
      case RecogLists.RECOG_SKIP_14_7:
      case RecogLists.RECOG_SKIP_14_8:
      case RecogLists.RECOG_SKIP_14_9:
      case RecogLists.RECOG_SKIP_14_10:
      case RecogLists.RECOG_SKIP_14_11:
      case RecogLists.RECOG_SKIP_14_12:
      case RecogLists.RECOG_SKIP_14_13:
      case RecogLists.RECOG_SKIP_14_18:
        return (RefInfoRet.NOT_USE,refInfo); // 未使用
      default:
        return  (RefInfoRet.RECOG_NUM_ERROR,refInfo); // 該当承認キーなし
    }

    return  (RefInfoRet.NO_ERROR,refInfo); // 正常終了
  }

  /// 設定ファイルパラメタを格納する変数の更新、および設定ファイルへの書き込みを行う
  /// 引数: [num] 取得、設定するパラメタの種類
  ///     [val] 更新する値
  ///     [isUpdateSysIni] 設定ファイル更新フラグ（true:有効  false:無効）
  ///                      falseの場合はメモリ上の設定ファイル値のみ更新する.
  /// 戻り値: なし
  Future<void> setSysIni(
      RecogLists num, String val, bool isUpdateSysIni) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cMem = xRet.object;

    /// TODO: SysJsonFileクラスに未定義のパラメタは、更新の対象外とする
    switch (num) {
      /* 1ページ */
      case RecogLists.RECOG_MEMBERSYSTEM:
        cMem.iniSys.type.membersystem = val;
        break;
      case RecogLists.RECOG_MEMBERPOINT:
        cMem.iniSys.type.memberpoint = val;
        break;
      case RecogLists.RECOG_MEMBERFSP:
        cMem.iniSys.type.memberfsp = val;
        break;
      case RecogLists.RECOG_CREDITSYSTEM:
        cMem.iniSys.type.creditsystem = val;
        break;
      case RecogLists.RECOG_SPECIAL_RECEIPT:
        break; //cMem.iniSys.type.spl_rct = val;                        break;
      case RecogLists.RECOG_DISC_BARCODE:
        cMem.iniSys.type.disc_barcode = val;
        break;
      case RecogLists.RECOG_IWAISYSTEM:
        cMem.iniSys.type.iwaisystem = val;
        break;
      case RecogLists.RECOG_SELF_GATE:
        cMem.iniSys.type.self_gate = val;
        break;
      case RecogLists.RECOG_SYS_24HOUR:
        cMem.iniSys.type.sys_24hour = val;
        break;
      case RecogLists.RECOG_VISMACSYSTEM:
        cMem.iniSys.type.vismacsystem = val;
        break;
      case RecogLists.RECOG_HQ_ASP:
        cMem.iniSys.type.hq_asp = val;
        break;
      case RecogLists.RECOG_JASAITAMA_SYS:
        cMem.iniSys.type.jasaitama_sys = val;
        break;
      case RecogLists.RECOG_PROMSYSTEM:
        cMem.iniSys.type.promsystem = val;
        break;
      case RecogLists.RECOG_EDYSYSTEM:
        cMem.iniSys.type.edysystem = val;
        break;
      case RecogLists.RECOG_FRESH_BARCODE:
        cMem.iniSys.type.fresh_barcode = val;
        break;
      case RecogLists.RECOG_SUGI_SYS:
        cMem.iniSys.type.sugi_sys = val;
        break;
      case RecogLists.RECOG_HESOKURISYSTEM:
        cMem.iniSys.type.hesokurisystem = val;
        break;
      case RecogLists.RECOG_GREENSTAMP_SYS:
        cMem.iniSys.type.greenstamp_sys = val;
        break;
      case RecogLists.RECOG_COOPSYSTEM:
        cMem.iniSys.type.coopsystem = val;
        break;
      case RecogLists.RECOG_POINTCARDSYSTEM:
        cMem.iniSys.type.pointcardsystem = val;
        break;
      /* 2ページ */
      case RecogLists.RECOG_MOBILESYSTEM:
        cMem.iniSys.type.mobilesystem = val;
        break;
      case RecogLists.RECOG_HQ_OTHER:
        cMem.iniSys.type.hq_other = val;
        break;
      case RecogLists.RECOG_REGCONNECTSYSTEM:
        cMem.iniSys.type.regconnectsystem = val;
        break;
      case RecogLists.RECOG_CLOTHES_BARCODE:
        cMem.iniSys.type.clothes_barcode = val;
        break;
      case RecogLists.RECOG_FJSS:
        cMem.iniSys.type.fjss = val;
        break;
      case RecogLists.RECOG_MCSYSTEM:
        cMem.iniSys.type.mcsystem = val;
        break;
      case RecogLists.RECOG_NETWORK_PRN:
        cMem.iniSys.type.network_prn = val;
        break;
      case RecogLists.RECOG_POPPY_PRINT:
        cMem.iniSys.type.poppy_print = val;
        break;
      case RecogLists.RECOG_TAG_PRINT:
        cMem.iniSys.type.tag_print = val;
        break;
      case RecogLists.RECOG_TAURUS:
        cMem.iniSys.type.taurus = val;
        break;
      case RecogLists.RECOG_NTT_ASP:
        cMem.iniSys.type.ntt_asp = val;
        break;
      case RecogLists.RECOG_EAT_IN:
        cMem.iniSys.type.eat_in = val;
        break;
      case RecogLists.RECOG_MOBILESYSTEM2:
        cMem.iniSys.type.mobilesystem2 = val;
        break;
      case RecogLists.RECOG_MAGAZINE_BARCODE:
        cMem.iniSys.type.magazine_barcode = val;
        break;
      case RecogLists.RECOG_HQ_OTHER_REAL:
        cMem.iniSys.type.hq_other_real = val;
        break;
      case RecogLists.RECOG_PW410SYSTEM:
        cMem.iniSys.type.pw410system = val;
        break;
      case RecogLists.RECOG_NSC_CREDIT:
        cMem.iniSys.type.nsc_credit = val;
        break;
      /* 3ページ */
      case RecogLists.RECOG_HQ_PROD:
        cMem.iniSys.type.hq_prod = val;
        break;
      case RecogLists.RECOG_FELICASYSTEM:
        cMem.iniSys.type.felicasystem = val;
        break;
      case RecogLists.RECOG_PSP70SYSTEM:
        cMem.iniSys.type.psp70system = val;
        break;
      case RecogLists.RECOG_NTT_BCOM:
        cMem.iniSys.type.ntt_bcom = val;
        break;
      case RecogLists.RECOG_CATALINASYSTEM:
        cMem.iniSys.type.catalinasystem = val;
        break;
      case RecogLists.RECOG_PRCCHKR:
        cMem.iniSys.type.prcchkr = val;
        break;
      case RecogLists.RECOG_DISHCALCSYSTEM:
        cMem.iniSys.type.dishcalcsystem = val;
        break;
      case RecogLists.RECOG_ITF_BARCODE:
        cMem.iniSys.type.itf_barcode = val;
        break;
      case RecogLists.RECOG_CSS_ACT:
        cMem.iniSys.type.css_act = val;
        break;
      case RecogLists.RECOG_CUST_DETAIL:
        cMem.iniSys.type.cust_detail = val;
        break;
      case RecogLists.RECOG_CUSTREALSVR:
        cMem.iniSys.type.custrealsvr = val;
        break;
      case RecogLists.RECOG_SUICA_CAT:
        cMem.iniSys.type.suica_cat = val;
        break;
      case RecogLists.RECOG_YOMOCASYSTEM:
        cMem.iniSys.type.yomocasystem = val;
        break;
      case RecogLists.RECOG_SMARTPLUSSYSTEM:
        cMem.iniSys.type.smartplussystem = val;
        break;
      case RecogLists.RECOG_DUTY:
        cMem.iniSys.type.duty = val;
        break;
      case RecogLists.RECOG_ECOASYSTEM:
        cMem.iniSys.type.ecoasystem = val;
        break;
      case RecogLists.RECOG_ICCARDSYSTEM:
        cMem.iniSys.type.iccardsystem = val;
        break;
      case RecogLists.RECOG_SUB_TICKET:
        cMem.iniSys.type.sub_ticket = val;
        break;
      /* 4ページ */
      case RecogLists.RECOG_QUICPAYSYSTEM:
        cMem.iniSys.type.quicpaysystem = val;
        break;
      case RecogLists.RECOG_IDSYSTEM:
        cMem.iniSys.type.idsystem = val;
        break;
      case RecogLists.RECOG_REVIVAL_RECEIPT:
        cMem.iniSys.type.revival_receipt = val;
        break;
      case RecogLists.RECOG_QUICK_SELF:
        cMem.iniSys.type.quick_self = val;
        break;
      case RecogLists.RECOG_QUICK_SELF_CHG:
        cMem.iniSys.type.quick_self_chg = val;
        break;
      case RecogLists.RECOG_ASSIST_MONITOR:
        cMem.iniSys.type.assist_monitor = val;
        break;
      case RecogLists.RECOG_MP1_PRINT:
        cMem.iniSys.type.mp1_print = val;
        break;
      case RecogLists.RECOG_REALITMSEND:
        cMem.iniSys.type.realitmsend = val;
        break;
      case RecogLists.RECOG_RAINBOWCARD:
        cMem.iniSys.type.rainbowcard = val;
        break;
      case RecogLists.RECOG_GRAMX:
        cMem.iniSys.type.gramx = val;
        break;
      case RecogLists.RECOG_MM_ABJ:
        cMem.iniSys.type.mm_abj = val;
        break;
      case RecogLists.RECOG_CAT_POINT:
        cMem.iniSys.type.cat_point = val;
        break;
      case RecogLists.RECOG_TAGRDWT:
        cMem.iniSys.type.tagrdwt = val;
        break;
      case RecogLists.RECOG_DEPARTMENT_STORE:
        cMem.iniSys.type.department_store = val;
        break;
      case RecogLists.RECOG_EDYNO_MBR:
        cMem.iniSys.type.edyno_mbr = val;
        break;
      case RecogLists.RECOG_FCF_CARD:
        cMem.iniSys.type.fcf_card = val;
        break;
      case RecogLists.RECOG_PANAMEMBERSYSTEM:
        cMem.iniSys.type.panamembersystem = val;
        break;
      case RecogLists.RECOG_LANDISK:
        cMem.iniSys.type.landisk = val;
        break;
      /* 5ページ */
      case RecogLists.RECOG_PITAPASYSTEM:
        cMem.iniSys.type.pitapasystem = val;
        break;
      case RecogLists.RECOG_TUOCARDSYSTEM:
        cMem.iniSys.type.tuocardsystem = val;
        break;
      case RecogLists.RECOG_SALLMTBAR:
        cMem.iniSys.type.sallmtbar = val;
        break;
      case RecogLists.RECOG_BUSINESS_MODE:
        cMem.iniSys.type.business_mode = val;
        break;
      case RecogLists.RECOG_MCP200SYSTEM:
        cMem.iniSys.type.mcp200system = val;
        break;
      case RecogLists.RECOG_SPVTSYSTEM:
        cMem.iniSys.type.spvtsystem = val;
        break;
      case RecogLists.RECOG_REMOTESYSTEM:
        cMem.iniSys.type.remotesystem = val;
        break;
      case RecogLists.RECOG_ORDER_MODE:
        cMem.iniSys.type.order_mode = val;
        break;
      case RecogLists.RECOG_JREM_MULTISYSTEM:
        cMem.iniSys.type.jrem_multisystem = val;
        break;
      case RecogLists.RECOG_MEDIA_INFO:
        cMem.iniSys.type.media_info = val;
        break;
      case RecogLists.RECOG_GS1_BARCODE:
        cMem.iniSys.type.gs1_barcode = val;
        break;
      case RecogLists.RECOG_ASSORTSYSTEM:
        cMem.iniSys.type.assortsystem = val;
        break;
      case RecogLists.RECOG_CENTER_SERVER:
        cMem.iniSys.type.center_server = val;
        break;
      case RecogLists.RECOG_RESERVSYSTEM:
        cMem.iniSys.type.reservsystem = val;
        break;
      case RecogLists.RECOG_DRUG_REV:
        cMem.iniSys.type.drug_rev = val;
        break;
      case RecogLists.RECOG_GINCARDSYSTEM:
        cMem.iniSys.type.gincardsystem = val;
        break;
      case RecogLists.RECOG_FCLQPSYSTEM:
        cMem.iniSys.type.fclqpsystem = val;
        break;
      case RecogLists.RECOG_FCLEDYSYSTEM:
        cMem.iniSys.type.fcledysystem = val;
        break;
      /* 6ページ */
      case RecogLists.RECOG_CAPS_CAFIS:
        cMem.iniSys.type.caps_cafis = val;
        break;
      case RecogLists.RECOG_FCLIDSYSTEM:
        cMem.iniSys.type.fclidsystem = val;
        break;
      case RecogLists.RECOG_PTCKTISSUSYSTEM:
        cMem.iniSys.type.ptcktissusystem = val;
        break;
      case RecogLists.RECOG_ABS_PREPAID:
        cMem.iniSys.type.abs_prepaid = val;
        break;
      case RecogLists.RECOG_PROD_ITEM_AUTOSET:
        cMem.iniSys.type.prod_item_autoset = val;
        break;
      case RecogLists.RECOG_PROD_ITF14_BARCODE:
        cMem.iniSys.type.prod_itf14_barcode = val;
        break;
      case RecogLists.RECOG_SPECIAL_COUPON:
        cMem.iniSys.type.special_coupon = val;
        break;
      case RecogLists.RECOG_BLUECHIP_SERVER:
        cMem.iniSys.type.bluechip_server = val;
        break;
      case RecogLists.RECOG_HITACHI_BLUECHIP:
        cMem.iniSys.type.hitachi_bluechip = val;
        break;
      case RecogLists.RECOG_HQ_OTHER_CANTEVOLE:
        cMem.iniSys.type.hq_other_cantevole = val;
        break;
      case RecogLists.RECOG_QCASHIER_SYSTEM:
        cMem.iniSys.type.qcashier_system = val;
        break;
      case RecogLists.RECOG_RECEIPT_QR_SYSTEM:
        cMem.iniSys.type.receipt_qr_system = val;
        break;
      case RecogLists.RECOG_VISATOUCH_INFOX:
        cMem.iniSys.type.visatouch_infox = val;
        break;
      case RecogLists.RECOG_PBCHG_SYSTEM:
        cMem.iniSys.type.pbchg_system = val;
        break;
      case RecogLists.RECOG_HC1_SYSTEM:
        cMem.iniSys.type.hc1_system = val;
        break;
      case RecogLists.RECOG_CAPS_HC1_CAFIS:
        cMem.iniSys.type.caps_hc1_cafis = val;
        break;
      case RecogLists.RECOG_REMOTESERVER:
        cMem.iniSys.type.remoteserver = val;
        break;
      case RecogLists.RECOG_MRYCARDSYSTEM:
        cMem.iniSys.type.mrycardsystem = val;
        break;
      /* 7ページ */
      case RecogLists.RECOG_SP_DEPARTMENT:
        cMem.iniSys.type.sp_department = val;
        break;
      case RecogLists.RECOG_DECIMALITMSEND:
        cMem.iniSys.type.decimalitmsend = val;
        break;
      case RecogLists.RECOG_WIZ_CNCT:
        cMem.iniSys.type.wiz_cnct = val;
        break;
      case RecogLists.RECOG_ABSV31_RWT:
        cMem.iniSys.type.absv31_rwt = val;
        break;
      case RecogLists.RECOG_PLURALQR_SYSTEM:
        cMem.iniSys.type.pluralqr_system = val;
        break;
      case RecogLists.RECOG_NETDOARESERV:
        cMem.iniSys.type.netdoareserv = val;
        break;
      case RecogLists.RECOG_SELPLUADJ:
        cMem.iniSys.type.selpluadj = val;
        break;
      case RecogLists.RECOG_CUSTREAL_WEBSER:
        cMem.iniSys.type.custreal_webser = val;
        break;
      case RecogLists.RECOG_WIZ_ABJ:
        cMem.iniSys.type.wiz_abj = val;
        break;
      case RecogLists.RECOG_CUSTREAL_UID:
        cMem.iniSys.type.custreal_uid = val;
        break;
      case RecogLists.RECOG_BDLITMSEND:
        cMem.iniSys.type.bdlitmsend = val;
        break;
      case RecogLists.RECOG_CUSTREAL_NETDOA:
        cMem.iniSys.type.custreal_netdoa = val;
        break;
      case RecogLists.RECOG_UT_CNCT:
        cMem.iniSys.type.ut_cnct = val;
        break;
      case RecogLists.RECOG_CAPS_PQVIC:
        cMem.iniSys.type.caps_pqvic = val;
        break;
      case RecogLists.RECOG_YAMATO_SYSTEM:
        cMem.iniSys.type.yamato_system = val;
        break;
      case RecogLists.RECOG_CAPS_CAFIS_STANDARD:
        cMem.iniSys.type.caps_cafis_standard = val;
        break;
      case RecogLists.RECOG_NTTD_PRECA:
        cMem.iniSys.type.nttd_preca = val;
        break;
      case RecogLists.RECOG_USBCAM_CNCT:
        cMem.iniSys.type.usbcam_cnct = val;
        break;
      /* 8ページ */
      case RecogLists.RECOG_DRUGSTORE:
        cMem.iniSys.type.drugstore = val;
        break;
      case RecogLists.RECOG_CUSTREAL_NEC:
        cMem.iniSys.type.custreal_nec = val;
        break;
      case RecogLists.RECOG_CUSTREAL_OP:
        cMem.iniSys.type.custreal_op = val;
        break;
      case RecogLists.RECOG_DUMMY_CRDT:
        cMem.iniSys.type.dummy_crdt = val;
        break;
      case RecogLists.RECOG_HC2_SYSTEM:
        cMem.iniSys.type.hc2_system = val;
        break;
      case RecogLists.RECOG_PRICE_SOUND:
        cMem.iniSys.type.price_sound = val;
        break;
      case RecogLists.RECOG_DUMMY_PRECA:
        cMem.iniSys.type.dummy_preca = val;
        break;
      case RecogLists.RECOG_MONITORED_SYSTEM:
        cMem.iniSys.type.monitored_system = val;
        break;
      case RecogLists.RECOG_JMUPS_SYSTEM:
        cMem.iniSys.type.jmups_system = val;
        break;
      case RecogLists.RECOG_UT1QPSYSTEM:
        cMem.iniSys.type.ut1qpsystem = val;
        break;
      case RecogLists.RECOG_UT1IDSYSTEM:
        cMem.iniSys.type.ut1idsystem = val;
        break;
      case RecogLists.RECOG_BRAIN_SYSTEM:
        cMem.iniSys.type.brain_system = val;
        break;
      case RecogLists.RECOG_PFMPITAPASYSTEM:
        cMem.iniSys.type.pfmpitapasystem = val;
        break;
      case RecogLists.RECOG_PFMJRICSYSTEM:
        cMem.iniSys.type.pfmjricsystem = val;
        break;
      case RecogLists.RECOG_CHARGESLIP_SYSTEM:
        cMem.iniSys.type.chargeslip_system = val;
        break;
      case RecogLists.RECOG_PFMJRICCHARGESYSTEM:
        cMem.iniSys.type.pfmjricchargesystem = val;
        break;
      case RecogLists.RECOG_ITEMPRC_REDUCTION_COUPON:
        cMem.iniSys.type.itemprc_reduction_coupon = val;
        break;
      case RecogLists.RECOG_CAT_JNUPS_SYSTEM:
        cMem.iniSys.type.cat_jmups_system = val;
        break;
      /* 9ページ */
      case RecogLists.RECOG_SQRC_TICKET_SYSTEM:
        cMem.iniSys.type.sqrc_ticket_system = val;
        break;
      case RecogLists.RECOG_CCT_CONNECT_SYSTEM:
        cMem.iniSys.type.cct_connect_system = val;
        break;
      case RecogLists.RECOG_CCT_EMONEY_SYSTEM:
        cMem.iniSys.type.cct_emoney_system = val;
        break;
      case RecogLists.RECOG_TEC_INFOX_JET_S_SYSTEM:
        cMem.iniSys.type.tec_infox_jet_s_system = val;
        break;
      case RecogLists.RECOG_PROD_INSTORE_ZERO_FLG:
        cMem.iniSys.type.prod_instore_zero_flg = val;
        break;
      /* 10ページ */
      case RecogLists.RECOG_FRONT_SELF_SYSTEM:
        cMem.iniSys.type.front_self_system = val;
        break;
      case RecogLists.RECOG_TRK_PRECA:
        cMem.iniSys.type.trk_preca = val;
        break;
      case RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM:
        cMem.iniSys.type.desktop_cashier_system = val;
        break;
      case RecogLists.RECOG_SUICA_CHARGE_SYSTEM:
        cMem.iniSys.type.suica_charge_system = val;
        break;
      case RecogLists.RECOG_NIMOCA_POINT_SYSTEM:
        cMem.iniSys.type.nimoca_point_system = val;
        break;
      case RecogLists.RECOG_CUSTREAL_POINTARTIST:
        cMem.iniSys.type.custreal_pointartist = val;
        break;
      case RecogLists.RECOG_TB1_SYSTEM:
        cMem.iniSys.type.tb1_system = val;
        break;
      case RecogLists.RECOG_TAX_FREE_SYSTEM:
        cMem.iniSys.type.tax_free_system = val;
        break;
      case RecogLists.RECOG_REPICA_SYSTEM:
        cMem.iniSys.type.repica_system = val;
        break;
      case RecogLists.RECOG_CAPS_CARDNET_SYSTEM:
        cMem.iniSys.type.caps_cardnet_system = val;
        break;
      case RecogLists.RECOG_YUMECA_SYSTEM:
        cMem.iniSys.type.yumeca_system = val;
        break;
      case RecogLists.RECOG_DUMMY_SUICA:
        cMem.iniSys.type.dummy_suica = val;
        break;
      case RecogLists.RECOG_PAYMENT_MNG:
        cMem.iniSys.type.payment_mng = val;
        break;
      case RecogLists.RECOG_CUSTREAL_TPOINT:
        cMem.iniSys.type.custreal_tpoint = val;
        break;
      case RecogLists.RECOG_MAMMY_SYSTEM:
        cMem.iniSys.type.mammy_system = val;
        break;
      case RecogLists.RECOG_ITEMTYP_SEND:
        cMem.iniSys.type.itemtyp_send = val;
        break; /* 商品区分 */
      case RecogLists.RECOG_YUMECA_POL_SYSTEM:
        cMem.iniSys.type.yumeca_pol_system = val;
        break;
      case RecogLists.RECOG_COGCA_SYSTEM:
        cMem.iniSys.type.cogca_system = val;
        break;
      /* 11ページ */
      case RecogLists.RECOG_CUSTREAL_HPS:
        cMem.iniSys.type.custreal_hps = val;
        break;
      case RecogLists.RECOG_MARUTO_SYSTEM:
        cMem.iniSys.type.maruto_system = val;
        break;
      case RecogLists.RECOG_HC3_SYSTEM:
        cMem.iniSys.type.hc3_system = val;
        break;
      case RecogLists.RECOG_SM3_MARUI_SYSTEM:
        cMem.iniSys.type.sm3_marui_system = val;
        break;
      case RecogLists.RECOG_KITCHEN_PRINT:
        cMem.iniSys.type.kitchen_print = val;
        break;
      case RecogLists.RECOG_BDL_MULTI_SELECT_SYSTEM:
        cMem.iniSys.type.bdl_multi_select_system = val;
        break; /* ﾐｯｸｽﾏｯﾁ共通 */
      case RecogLists.RECOG_SALL_LMTBAR26:
        cMem.iniSys.type.sallmtbar26 = val;
        break;
      case RecogLists.RECOG_PURCHASE_TICKET_SYSTEM:
        cMem.iniSys.type.purchase_ticket_system = val;
        break; /* 特定売上チケット発券 */
      case RecogLists.RECOG_CUSTREAL_UNI_SYSTEM:
        cMem.iniSys.type.custreal_uni_system = val;
        break;
      case RecogLists.RECOG_EJ_ANIMATION_SYSTEM:
        cMem.iniSys.type.ej_animation_system = val;
        break;
      case RecogLists.RECOG_VALUECARD_SYSTEM:
        cMem.iniSys.type.value_card_system = val;
        break;
      case RecogLists.RECOG_SM4_COMODI_SYSTEM:
        cMem.iniSys.type.sm4_comodi_system = val;
        break;
      case RecogLists.RECOG_SM5_ITOKU_SYSTEM:
        cMem.iniSys.type.sm5_itoku_system = val;
        break;
      case RecogLists.RECOG_CCT_POINTUSE_SYSTEM:
        cMem.iniSys.type.cct_pointuse_system = val;
        break;
      case RecogLists.RECOG_ZHQ_SYSTEM:
        cMem.iniSys.type.zhq_system = val;
        break;
      /* 12ページ */
      case RecogLists.RECOG_RPOINT_SYSTEM:
        cMem.iniSys.type.rpoint_system = val;
        break;
      case RecogLists.RECOG_VESCA_SYSTEM:
        cMem.iniSys.type.vesca_system = val;
        break;
      case RecogLists.RECOG_CR_NSW_SYSTEM:
        break; //cMem.iniSys.type.cr_nsw_system = val;                  break;
      case RecogLists.RECOG_AJS_EMONEY_SYSTEM:
        cMem.iniSys.type.ajs_emoney_system = val;
        break;
      /* 13ページ */
      case RecogLists.RECOG_SM16_TAIYO_TOYOCHO_SYSTEM:
        cMem.iniSys.type.sm16_taiyo_toyocho_system = val;
        break;
      case RecogLists.RECOG_CR_NSW_DATA_SYSTEM:
        break; //cMem.iniSys.type.cr2_nsw_system = val;                 break;
      case RecogLists.RECOG_INFOX_DETAIL_SEND_SYSTEM:
        cMem.iniSys.type.infox_detail_send_system = val;
        break;
      case RecogLists.RECOG_SELF_MEDICATION_SYSTEM:
        cMem.iniSys.type.self_medication_system = val;
        break;
      case RecogLists.RECOG_SM20_MAEDA_SYSTEM:
        cMem.iniSys.type.sm20_maeda_system = val;
        break;
      /* 14ページ */
      case RecogLists.RECOG_PANAWAONSYSTEM:
        cMem.iniSys.type.pana_waon_system = val;
        break;
      case RecogLists.RECOG_ONEPAYSYSTEM:
        cMem.iniSys.type.onepay_system = val;
        break;
      case RecogLists.RECOG_HAPPYSELF_SYSTEM:
        cMem.iniSys.type.happyself_system = val;
        break;
      case RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM:
        cMem.iniSys.type.happyself_smile_system = val;
        break;
      /* 15ページ */
      case RecogLists.RECOG_LINEPAY_SYSTEM:
        cMem.iniSys.type.linepay_system = val;
        break;
      case RecogLists.RECOG_STAFF_RELEASE_SYSTEM:
        cMem.iniSys.type.staff_release_system = val;
        break;
      case RecogLists.RECOG_REASON_SELECT_STD_SYSTEM:
        cMem.iniSys.type.reason_select_std_system = val;
        break;
      case RecogLists.RECOG_WIZ_BASE_SYSTEM:
        cMem.iniSys.type.wiz_base_system = val;
        break;
      case RecogLists.RECOG_PACK_ON_TIME_SYSTEM:
        cMem.iniSys.type.pack_on_time_system = val;
        break;
      /* 16ページ */
      case RecogLists.RECOG_SHOP_AND_GO_SYSTEM:
        cMem.iniSys.type.shop_and_go_system = val;
        break;
      case RecogLists.RECOG_STAFFID1_YMSS_SYSTEM:
        cMem.iniSys.type.staffid1_ymss_system = val;
        break;
      case RecogLists.RECOG_TAXFREE_PASSPORTINFO_SYSTEM:
        cMem.iniSys.type.taxfree_passportinfo_system = val;
        break;
      case RecogLists.RECOG_SM33_NISHIZAWA_SYSTEM:
        cMem.iniSys.type.sm33_nishizawa_system = val;
        break;
      case RecogLists.RECOG_DS2_GODAI_SYSTEM:
        cMem.iniSys.type.ds2_godai_system = val;
        break;
      /* 17ページ */
      case RecogLists.RECOG_SM36_SANPRAZA_SYSTEM:
        cMem.iniSys.type.sm36_sanpraza_system = val;
        break;
      case RecogLists.RECOG_CR50_SYSTEM:
        cMem.iniSys.type.cr50_system = val;
        break;
      case RecogLists.RECOG_CASE_CLOTHES_BARCODE_SYSTEM:
        cMem.iniSys.type.case_clothes_barcode_system = val;
        break;
      case RecogLists.RECOG_DPOINT_SYSTEM:
        cMem.iniSys.type.dpoint_system = val;
        break;
      case RecogLists.RECOG_CUSTREAL_DUMMY_SYSTEM:
        cMem.iniSys.type.custreal_dummy_system;
        break;
      case RecogLists.RECOG_BARCODE_PAY1_SYSTEM:
        cMem.iniSys.type.barcode_pay1_system = val;
        break;
      case RecogLists.RECOG_CUSTREAL_PTACTIX:
        cMem.iniSys.type.custreal_ptactix = val;
        break;
      case RecogLists.RECOG_CR3_SHARP_SYSTEM:
        cMem.iniSys.type.cr3_sharp_system = val;
        break;
      case RecogLists.RECOG_GAME_BARCODE_SYSTEM:
        cMem.iniSys.type.game_barcode_system = val;
        break;
      case RecogLists.RECOG_CCT_CODEPAY_SYSTEM:
        cMem.iniSys.type.cct_codepay_system = val;
        break;
      case RecogLists.RECOG_WS_SYSTEM:
        cMem.iniSys.type.ws_system = val;
        break;
      case RecogLists.RECOG_CUSTREAL_POINTINFINITY:
        cMem.iniSys.type.custreal_pointinfinity = val;
        break;
      case RecogLists.RECOG_TOY_SYSTEM:
        cMem.iniSys.type.toy_system = val;
        break;
      case RecogLists.RECOG_CANAL_PAYMENT_SERVICE_SYSTEM:
        cMem.iniSys.type.canal_payment_service_system = val;
        break;
      /* 18ページ */
      case RecogLists.RECOG_MULTI_VEGA_SYSTEM:
        cMem.iniSys.type.multi_vega_system = val;
        break;
      case RecogLists.RECOG_DISPENSING_PHARMACY_SYSTEM:
        cMem.iniSys.type.dispensing_pharmacy_system = val;
        break;
      case RecogLists.RECOG_SM41_BELLEJOIS_SYSTEM:
        cMem.iniSys.type.sm41_bellejois_system = val;
        break;
      case RecogLists.RECOG_SM42_KANESUE_SYSTEM:
        cMem.iniSys.type.sm42_kanesue_system = val;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY_SYSTEM:
        cMem.iniSys.type.public_barcode_pay_system = val;
        break;
      case RecogLists.RECOG_TS_INDIV_SETTING_SYSTEM:
        cMem.iniSys.type.ts_indiv_setting_system = val;
        break;
      case RecogLists.RECOG_SM44_JA_TSURUOKA_SYSTEM:
        cMem.iniSys.type.sm44_ja_tsuruoka_system = val;
        break;
      case RecogLists.RECOG_STERA_TERMINAL_SYSTEM:
        cMem.iniSys.type.stera_terminal_system = val;
        break;
      case RecogLists.RECOG_SM45_OCEAN_SYSTEM:
        cMem.iniSys.type.sm45_ocean_system = val;
        break;
      case RecogLists.RECOG_REPICA_POINT_SYSTEM:
        cMem.iniSys.type.repica_point_system = val;
        break;
      case RecogLists.RECOG_FUJITSU_FIP_CODEPAY_SYSTEM:
        cMem.iniSys.type.fujitsu_fip_codepay_system = val;
        break;
      /* 19ページ */
      case RecogLists.RECOG_TAXFREE_SERVER_SYSTEM:
        cMem.iniSys.type.taxfree_server_system = val;
        break;
      case RecogLists.RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM:
        cMem.iniSys.type.employee_card_payment_system = val;
        break;
      case RecogLists.RECOG_NET_RECEIPT_SYSTEM:
        cMem.iniSys.type.net_receipt_system = val;
        break;
      case RecogLists.RECOG_SM49_ITOCHAIN_SYSTEM:
        cMem.iniSys.type.sm49_itochain_system = val;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY2_SYSTEM:
        cMem.iniSys.type.public_barcode_pay2_system = val;
        break;
      case RecogLists.RECOG_MULTI_ONEPAYSYSTEM:
        break; //cMem.iniSys.type.multi_onepay_system = val;            break;
      case RecogLists.RECOG_SM52_PALETTE_SYSTEM:
        cMem.iniSys.type.sm52_palette_system = val;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY3_SYSTEM:
        cMem.iniSys.type.public_barcode_pay3_system = val;
        break;
      /* 20ページ */
      case RecogLists.RECOG_SVSCLS2_STLPDSC_SYSTEM:
        cMem.iniSys.type.svscls2_stlpdsc_system = val;
        break;
      case RecogLists.RECOG_SM55_TAKAYANAGI_SYSTEM:
        cMem.iniSys.type.sm55_takayanagi_system = val;
        break;
      case RecogLists.RECOG_MAIL_SEND_SYSTEM:
        cMem.iniSys.type.mail_send_system = val;
        break;
      case RecogLists.RECOG_NETSTARS_CODEPAY_SYSTEM:
        cMem.iniSys.type.netstars_codepay_system = val;
        break;
      case RecogLists.RECOG_SM56_KOBEBUSSAN_SYSTEM:
        cMem.iniSys.type.sm56_kobebussan_system = val;
        break;
      case RecogLists.RECOG_HYS1_SERIA_SYSTEM:
        cMem.iniSys.type.hys1_seria_system = val;
        break;
      case RecogLists.RECOG_LIQR_TAXFREE_SYSTEM:
        cMem.iniSys.type.liqr_taxfree_system = val;
        break;
      /* 21ページ */
      case RecogLists.RECOG_CUSTREAL_GYOMUCA_SYSTEM:
        cMem.iniSys.type.custreal_gyomuca_system = val;
        break;
      case RecogLists.RECOG_SM59_TAKARAMC_SYSTEM:
        cMem.iniSys.type.sm59_takaramc_system = val;
        break;
      case RecogLists.RECOG_DETAIL_NOPRN_SYSTEM:
        cMem.iniSys.type.detail_noprn_system = val;
        break;
      case RecogLists.RECOG_SM61_FUJIFILM_SYSTEM:
        cMem.iniSys.type.sm61_fujifilm_system = val;
        break;
      case RecogLists.RECOG_DEPARTMENT2_SYSTEM:
       cMem.iniSys.type.department2_system = val;
       break;
      case RecogLists.RECOG_CUSTREAL_CROSSPOINT:
        cMem.iniSys.type.custreal_crosspoint = val;
        break;
      case RecogLists.RECOG_HC12_JOYFUL_HONDA_SYSTEM:
        cMem.iniSys.type.hc12_joyful_honda_system = val;
        break;
      case RecogLists.RECOG_SM62_MARUICHI_SYSTEM:
        cMem.iniSys.type.sm62_maruichi_system = val;
        break;
      /* 22ページ */
      case RecogLists.RECOG_SM65_RYUBO_SYSTEM:
        cMem.iniSys.type.sm65_ryubo_system = val;
        break;
      case RecogLists.RECOG_TOMOIF_SYSTEM:
        cMem.iniSys.type.tomoIF_system = val;
        break;
      case RecogLists.RECOG_SM66_FRESTA_SYSTEM:
        cMem.iniSys.type.sm66_fresta_system = val;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY4_SYSTEM:
        cMem.iniSys.type.public_barcode_pay4_system = val;
        break;
      case RecogLists.RECOG_SM71_SELECTION_SYSTEM:
        cMem.iniSys.type.sm71_selection_system = val;
        break;
      case RecogLists.RECOG_KITCHEN_PRINT_RECIPT:
        cMem.iniSys.type.kitchen_print_recipt = val;
        break;
      case RecogLists.RECOG_MIYAZAKI_CITY_SYSTEM:
        cMem.iniSys.type.miyazaki_city_system = val;
        break;
      case RecogLists.RECOG_SP1_QR_READ_SYSTEM:
        cMem.iniSys.type.sp1_qr_read_system = val;
        break;
      case RecogLists.RECOG_RF1_HS_SYSTEM:
        cMem.iniSys.type.rf1_hs_system = val;
        break;
      default:
        break;
    }
    if (isUpdateSysIni) {
      await cMem.iniSys.save();
    }
    if (isUpdateSharedMemory) {
      updateSharedMemory(cMem);
    }
  }

  /// 共有メモリの更新    
  void updateSharedMemory(RxCommonBuf cMem){
     SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, cMem, RxMemAttn.MAIN_TASK);
  }
  
}
enum RefInfoRet{
  NO_ERROR, //エラーなし.
  ERROR, // エラー.
  RECOG_NUM_ERROR, // 承認キーなし.
  NOT_USE, // 未使用.
}
