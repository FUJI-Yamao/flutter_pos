/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/drv/ffi/library.dart';

import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../common/cls_conf/configJsonFile.dart';
import '../common/cls_conf/acbJsonFile.dart';
import '../common/cls_conf/sioJsonFile.dart';
import '../common/cls_conf/sysJsonFile.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/lib/if_acx.dart';
import '../inc/sys/tpr_log.dart';
import '../inc/sys/tpr_def_asc.dart';
import '../inc/sys/tpr_type.dart';
import '../inc/sys/tpr_ipc.dart';
import '../inc/sys/tpr_did.dart';
import '../inc/sys/tpr_dlg.dart';
import '../inc/sys/tpr_mid.dart';
import '../drv/changer/drv_changer_isolate.dart';
import '../lib/if_acx/acx_answ.dart';
import '../lib/if_acx/acx_calcg.dart';
import '../lib/if_acx/acx_com.dart';
import '../lib/if_acx/acx_stcr.dart';
import '../lib/if_acx/ecs_opes.dart';
import '../regs/acx/rc_acx.dart';
import '../sys/mente/sio/sio01.dart';
import '../sys/mente/sio/sio_def.dart';
import 'if_drv_control.dart';

class changerCalcgRet {
  int result = 0;      // 関数実行結果
  int mode = AcrCalcMode.ACR_CALC_MANUAL.no;        // 
}

/// 釣銭機　アプリ側のインターフェース
/// mainIsolateとchangerIsolateとのやり取りを管理する.
class IfChangerIsolate{
  /// 釣銭機のIsolateのport.
  SendPort? changerIsolatePort;

  /// ドライバの情報
  static int taskId = 0;
  AcxCom changerCom = AcxCom();
  String fName = '';

  static bool isChangerStat = false;
  static bool isInit = false;

  /// 釣銭機のIsolateをスタートする.
  Future<void> startChangerIsolate(String absolutePath, int tid) async {
    // 受信ポート.
    var receivePort = ReceivePort();
    taskId = tid;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    isChangerStat = await _getSectionChangerCheck();
    if( isChangerStat ){
       tsBuf.acx.jsonFileName = fName;
    }
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK, "");

    await Isolate.spawn( DrvChangerIsolate.drvChangerIsolateStart,
        DeviceIsolateInitData(receivePort.sendPort, TprLog().logPort!,
            taskId, absolutePath, EnvironmentData(),
            SystemFunc.readRxCommonBuf(), SystemFunc.readRxTaskStat()));
    // 初めにportが返ってくるので、portをセットする.
    changerIsolatePort  = await receivePort.first as SendPort?;
    receivePort.close();
    if (changerIsolatePort == null) {
       TprLog().logAdd(
           taskId, LogLevelDefine.normal, "Changer driver not initialized.");
    } else {
       isInit = true;
       TprLog().logAdd(
           taskId, LogLevelDefine.normal, "changer Isolate port set.");
    }
    if (isInit && (!isWithoutDevice() || isDummyAcx())) {
      debugPrint("Changer Receive Start");
      await RcAcx.rcAcxReceiveStart();
    }
  }

  /// SIO設定から、釣銭機系をチェックする
  /// 引数:なし
  /// 戻り値: true=釣銭機系  false=非釣銭機系
  Future<bool> _getSectionChangerCheck() async {
    JsonRet jsonRet = JsonRet();
    bool isChanger = false;
    String section = '';
    var tmpTbl = List<List<SioToolTbl>>.generate(SioDef.PAGE_MAX,
            (index) => List.generate(SioDef.TOOL_MAX, (index) => SioToolTbl()));

    // DBにアクセスする必要がある情報は、アイソレート開始前に取得し、タスク間通信で受け渡す。
    Sio01 sio01 = Sio01();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    sio01.pCom = xRet.object;
    if (!(await sio01.setDevTableInit())) {
      return false;
    }
    if (!(await sio01.createSectTitleTable())) {
      return false;
    }
    // All Tool Get
    var sioJson = SioJsonFile();
    var sysJson = SysJsonFile();
    await sioJson.load();
    await sysJson.load();
    for (int sioNo = 0; sioNo < SioDef.SIONUM_MAX; sioNo++) {
      // SIO接続機器一覧画面
      for (int page = 0; page < SioDef.PAGE_MAX; page++) {
        for (int tool = 0; tool < SioDef.TOOL_MAX; tool++) {
          String tmpKeyword = 'button${((page*SioDef.TOOL_MAX)+tool+1).toString().padLeft(2, '0')}';

          jsonRet = await sioJson.getValueWithName(tmpKeyword, 'title');
          if (!jsonRet.result) {
            TprLog().logAdd(taskId, LogLevelDefine.error,
                'sio Get Json Err - title: ${jsonRet.cause.name}', errId: -1);
            return false;
          }
          if (jsonRet.value != SioDef.NONE_CH) {
            if (jsonRet.value != SioDef.NOT_USE) {
              // section（ドライバ セクション名）取得
              jsonRet = await sioJson.getValueWithName(tmpKeyword, 'section');
              if (!jsonRet.result) {
                TprLog().logAdd(taskId, LogLevelDefine.error,
                    'sio Get Json Err - section: ${jsonRet.cause.name}', errId: -1);
                return false;
              }
              tmpTbl[page][tool].section = jsonRet.value;

              // セクションタイトル名テーブルからセクション日本語タイトルを取得
              String tmpSection = jsonRet.value.toString();
              String tmpTitle = '';
              for (int i = 0; i < SioDef.PAGE_MAX * SioDef.TOOL_MAX; i++) {
                if (tmpSection == sio01.sioSectTitleTbl[i].sectionName) {
                  tmpTitle = sio01.sioSectTitleTbl[i].titleName;
                  break;
                }
              }
              if ((tmpTitle.isEmpty) ||
                  (!(await _isSectionChanger(tmpSection)))) {
                continue;
              } else {
                tmpTbl[page][tool].label = tmpTitle;
              }

              // ドライバセクション名が、sys.jsonで定義されるinifileに設定されているか
              jsonRet = await sysJson.getValueWithName(tmpTbl[page][tool].section, 'inifile');
              if (!jsonRet.result) {
                TprLog().logAdd(taskId, LogLevelDefine.error,
                    'sio Get sysJson Err - inifile: ${jsonRet.cause.name}', errId: -1);
                return false;
              }
              tmpTbl[page][tool].fName = jsonRet.value;

              // search section
              if (sio01.sioDevTblOld[sioNo].device == tmpTbl[page][tool].label) {
                if(!isChanger) {     //重複設定に対応
                  isChanger = true;
                  fName = tmpTbl[page][tool].fName.substring(5);
                  section = tmpTbl[page][tool].section;
                }
                TprLog().logAdd(taskId, LogLevelDefine.normal,
                    'sio# = ${sioNo + 1}  filename = $fName  section = $section');
              }
            }
          }
        }
      }
    }
    return isChanger;
  }
  /// ドライバセクションから、釣銭機系をチェックする
  /// 引数:[section] ドライバセクション名
  /// 戻り値: true=釣銭機系  false=非釣銭機系
  Future<bool> _isSectionChanger(String section) async {
    bool isRet = false;
    switch( section ) {
      case SioDef.SIO_SEC_ACR:
      case SioDef.SIO_SEC_ACB:
      case SioDef.SIO_SEC_ACB20:
      case SioDef.SIO_SEC_ACB50:
      case SioDef.SIO_SEC_FAL2:
        isRet = true;
        break;
      defalt:
        break;
    }

    return isRet;
  }

  ///釣銭機からデータを受信する
  ///引数     : TprTID src
  ///戻り値    : 受信データ
  Future<ChangerDataReceiveResult> changerAcxReceive( TprTID src ) async {
    TprMsgDevNotify2_t ret = TprMsgDevNotify2_t();
    ret.result = TprDidDef.TPRDEVRESULTNOTOPEN;
    ChangerDataReceiveResult result = ChangerDataReceiveResult(ret);

    if (IfDrvControl.isWithoutDeviceMode() && !isDummyAcx()) {
      debugPrint("changerAcxReceive -- WITHOUT_DEVICE実行");
      return result;
    }
    if (changerIsolatePort == null) {
      TprLog().logAdd(src, LogLevelDefine.error, "changerAcxReceive changer Isolate port not set.");
      debugPrint("changer Isolate port not set.");
      return result;
    }
    ReceivePort receivePort = ReceivePort();
    changerIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.changerReceive, 0, returnPort:receivePort.sendPort));
    debugPrint("receivePort.first as ChangerDataReceiveResult in." );
    result = await receivePort.first as ChangerDataReceiveResult;
    debugPrint("receivePort.first as ChangerDataReceiveResult out." );
    receivePort.close();
    return result;
  }

  /// デバドラ側で保持している共有メモリを更新させる。
  void updateShareMemory(SystemFuncPayload payload) async {
    if (changerIsolatePort != null) {
      changerIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.updateShareMemory, payload));
    }
  }
}

