/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ffi';
import 'dart:io';
import "dart:isolate";

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/drv/ffi/library.dart';
import 'package:path/path.dart' as path;
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/tmncat.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../ui/enum/e_screen_kind.dart';
import '../ffi/ubuntu/ffi_multiTmn.dart';

/// Isolateを起動するときのデータ
class MultiTmnMainData {
  SendPort appPort;
  SendPort logPort;
  int taskId;
  RxTaskStatBuf? tsBuf;
  ScreenKind screenKind;
  MultiTmnMainData(this.appPort, this.logPort, this.taskId, this.tsBuf, this.screenKind);
}

/// 参考：rc_multi_tmn.c
///    rc_multi_tmn.c - Multi R/W TMN main program
///
class TprDrvRcMultiTmn {
  int TRUE  = 1;
  int FALSE = 0;
  int FAILE = -1;

  int TMN_EVT_WAIT             = 250;      // 250000us = 250ms
  int TMN_TRAN_TIMEOUT         = 300000;
  int TMN_DAIL_TIMEOUT         = 600000;
  int TMN_ASIDATA_CNT          = 6;
  int DATE_TIME_SIZE           = 12;
  int CENTER_RESULTCODE_SIZE   = 5;
  int RES_TIMEOUT_CNT          = (10*30); // 0.1秒 × 300 ＝ 30秒
  int RES_TIMEOUT_WAIT         = (100);   // 0.1秒 100ms
  int INIT_WAIT                = (500);   // 0.5秒 500ms

  TprLog myLog = TprLog();

  TprTID myTid = 0;

  bool fEnd = false;
  RxTaskStatBuf tsBuf = RxTaskStatBuf();

  FFIMultiTmn ffiMultiTmn = FFIMultiTmn();
  SendPort? _parentSendPort;

  /// 中断フラグ
  static bool _isAbort = false;
  /// 停止フラグ
  static bool _isStop = false;

  /// 関連tprxソース: rc_multi_tmn.c - main()
  /// Multi R/W TMN Management program
  /// 引数: なし
  /// 戻り値：0 = Normal End
  ///       -1 = Error
  Future<void> multiTmnMain(MultiTmnMainData initData) async {
    int ret = 0;
    final receivePort = ReceivePort();

    myTid = initData.taskId;
    _parentSendPort = initData.appPort;
    // ログ設定.
    myLog.setIsolateName("tmn", initData.screenKind);
    myLog.logPort = initData.logPort;
    myLog.sendWaitListLog();

    // 使用する共有メモリをセットアップする
    await SystemFunc.rxMemGet(RxMemIndex.RXMEM_STAT);
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT,   initData.tsBuf! , RxMemAttn.MASTER);

    _parentSendPort!
        .send(receivePort.sendPort);

    // アプリからの通知を受け取る.
    receivePort.listen((notify) {
      final notifyData = notify as NotifyFromApp;
      switch (notifyData.notifyType) {
        case NotifyTypeFromMIsolate.receiveStart:
          debugPrint("multiTmnMain receiveStart receive. ");
          _parentSendPort = notifyData.returnPort!;
          break;
        case NotifyTypeFromMIsolate.abort:   // 中断
          abort();
          break;
        case NotifyTypeFromMIsolate.stop:    // 停止
          stop();
          break;
        case NotifyTypeFromMIsolate.restart: // 再開
          restart();
          break;
        case NotifyTypeFromMIsolate.updateShareMemory:
          var payload = notify.option as SystemFuncPayload;
          SystemFunc.rxMemWrite(notify.returnPort!, payload.index, payload.buf, RxMemAttn.SLAVE, "MultiTmn");
          if( payload.index == RxMemIndex.RXMEM_STAT ) {
              tsBuf = payload.buf;
          }
          break;
        default:
          break;
      }
    });

    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        myLog.logAdd( myTid, LogLevelDefine.error, "Task stat memory get error" );
        debugPrint( "Task stat memory get error" );
        return ;
      }
      tsBuf = xRet.object;

      // TMNプロセス準備完了待ち
      while(true) {
        if(ffiMultiTmn.tmnApiIsReady() == tmncat.OPOS_SUCCESS) {
          myLog.logAdd(myTid, LogLevelDefine.warning, "multi tmn mainProcess start");
          int flg = tsBuf.multi.flg ?? 0;
          tsBuf.multi.flg = flg | 0x08;
          if(tsBuf.multi.fclData == null ) {
            tsBuf.multi.fclData = FclData();
          }
          tsBuf.multi.step = FclStepNo.FCL_STEP_AUTO_INIT.value;
          tsBuf.multi.fclData.tKind = 0;
          tsBuf.multi.order = FclProcNo.OCX_U_START.index;

          fEnd = false;
          break;
        }
        await new Future.delayed(new Duration(milliseconds: RES_TIMEOUT_WAIT));
      }

      while(fEnd == false) {
        if (_isAbort) {
          // 中断
          return;
        }
        if (_isStop) {
          // 停止中は、5秒待機
          await Future.delayed(const Duration(seconds: 5));
          continue;
        }
        xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (xRet.isValid()) {
          tsBuf = xRet.object;
        }
        if(tsBuf.multi.fclData == null ) {
          continue;
        }

        switch(FclProcNo.getDefine(tsBuf.multi.order)) {
          case FclProcNo.FCL_T_START:
            if( tsBuf.multi.fclData.skind != null ) {
              if( (tsBuf.multi.fclData.skind != FclService.FCL_QP) && (tsBuf.multi.fclData.skind != FclService.FCL_ID) ) {
                 break;
              }
            } else {
              await rcTmnSysError();
              break;
            }
            myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal, "FCL_T_START");
            rcTmnInitStep();
            ret = await rcTmnTransact();
            break;
          case FclProcNo.OCX_D_START:
            if( tsBuf.multi.fclData.skind != null ) {
              if( (tsBuf.multi.fclData.skind != FclService.FCL_QP) && (tsBuf.multi.fclData.skind != FclService.FCL_ID) ) {
                break;
              }
            } else {
              await rcTmnSysError();
              break;
            }
            myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal, "OCX_D_START");
            rcTmnInitStep();
            switch(tsBuf.multi.fclData.tKind) {
              case 0: ret = await rcTmnDaily();        break;
              case 1: ret = await rcTmnDelete();       break;
              default: await rcTmnSysError();                break;
            }
            break;
          case FclProcNo.OCX_U_START:
            myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal, "OCX_U_START");
            rcTmnInitStep();
            switch(tsBuf.multi.fclData.tKind) {
              case 0: ret = await rcTmnOpen();            break;
              case 1: ret = await rcTmnClose();           break;
              case 2: ret = await rcTmnSetupTid();        break;
              case 3: ret = await rcTmnIniDownload();     break;
              case 4: ret = await rcTmnChangeTid();       break;
              case 5: ret = await rcTmnChangeUt();        break;
              case 6: ret = await rcTmnCheckHealth();     break;
              case 7: ret = await rcTmnOnlineTest();      break;
              case 8: ret = await rcTmnGetVolume();       break;
              case 9: ret = await rcTmnSetVolume();       break;
              default: await rcTmnSysError();                   break;
            }
            break;
          default:
            break;
        }
        if((tsBuf.multi.step == FclStepNo.FCL_STEP_AUTO_INIT.value)
        && ((tsBuf.multi.order == FclProcNo.OCX_U_END.index) || (tsBuf.multi.order == FclProcNo.FCL_NOT_ORDER.index))) {
          if(tsBuf.multi.order == FclProcNo.OCX_U_END.index) {
            myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal, "Init OK!");
          } else {
            myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal, "Init NG!");
          }
          tsBuf.multi.errCd = Fcl.FCL_NORMAL;
          tsBuf.multi.order  = FclProcNo.FCL_NOT_ORDER.index;
          tsBuf.multi.step   = FclStepNo.FCL_STEP_WAIT.index;
          await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "MultiTmn");
        }
        await new Future.delayed(new Duration(milliseconds: RES_TIMEOUT_WAIT));
      }
    } catch(e,s) {
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"multiTmnMain $e,$s");
    }
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal, "multi tmn process end");
    debugPrint("multiTmnMain multi tmn process end");
  }

  /// 文字列変換
  ///   引数: data = 入力文字列
  ///         start = 開始相対アドレス
  ///         length = 抽出文字数
  ///   戻り値: 出力文字列
  String _convertSubstring(String data, int start, int length) {
    String retData = "";
    int len = data.length < length ? data.length : length;
    try {
      retData = data.substring(start, len);
    } catch (e,s) {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"_convertSubstring $e,$s");
    }
    return( retData );
  }

  /// メイン処理終了指示
  void endFunc(int sig)
  {
    fEnd = true;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_GetEvent()
  /// rcTmnGetEvent
  /// 引数: なし
  /// 戻り値：CifGetEvent
  Future<int> rcTmnGetEvent() async {
    int       ret = 0;
    String    log = "";
    int       numBuf1 = 0;
    int       numBuf2 = 0;
    int       eventNumber = 0;
    String    strBuf;

    while(fEnd == false) {
      if((tsBuf.multi.flg & 0x01) == 0x01) {
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposClearOutput");
        ret = ffiMultiTmn.tmnOposClearOutput();
        log = "Cancel NO! ResultCode = $ret";
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

        int flg = tsBuf.multi.flg;
        tsBuf.multi.flg = flg & ~0x01;
      }
      TmnCifGetEventResult tmnCifGetEventRet = ffiMultiTmn.tmnCifGetEvent();
      numBuf1 = tmnCifGetEventRet.errorResponse;
      numBuf2 = tmnCifGetEventRet.directIOData;
      strBuf = tmnCifGetEventRet.directIOString;
      eventNumber = tmnCifGetEventRet.directIOEventNumber;
      switch(tmnCifGetEventRet.result) {
        case tmncat.CIF_EVT_NONE:
          break;
        case tmncat.CIF_EVT_OUTPUTCOMPLETE:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"OUTPUTCOMPLETE!");
          return(tmnCifGetEventRet.result);
        case tmncat.CIF_EVT_ERROR:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"ERROR!");
          return(tmnCifGetEventRet.result);
        case tmncat.CIF_EVT_DIRECTIO:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"DIRECTIO!");
          log = "EventNumber = " + eventNumber.toString();
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
          if(tsBuf.multi.order == FclProcNo.FCL_T_START.index) {
             bool flag = false;
             switch(tsBuf.multi.fclData.skind) {
               case FclService.FCL_QP:
                 switch(eventNumber) {
                   case 1001:
                   case 1002:
                   case 1004:
                   case 1003:
                   case 1005:  tsBuf.multi.step  = FclStepNo.FCL_STEP_TRAN_TOUCH.index; flag = true; break;
                 }
                 switch(eventNumber) {
                   case 1001:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_AUT.index; flag = true; break;
                   case 1002: 
                   case 1004:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_FIRSTCARD.index; flag = true; break;
                   case 1003:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_RETOUCH.index; flag = true; break;
                   case 1006:
                     int flg = tsBuf.multi.flg ?? 0;
                     tsBuf.multi.flg = flg | 0x10;
                     flag = true;
                     break;
                 }
                 break;
               case FclService.FCL_ID:
                 switch(eventNumber) {
                   case 2001:
                   case 2002:
                   case 2003:
                   case 2004:
                   case 2005:
                   case 2006:  tsBuf.multi.step  = FclStepNo.FCL_STEP_TRAN_TOUCH.index; flag = true; break;
                 }
                 switch(eventNumber) {
                   case 2002:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_REPIN.index; flag = true;   break;
                   case 2003:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_AUT.index; flag = true;   break;
                   case 2004:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_RETOUCH.index; flag = true; break;
                   case 2005:  tsBuf.multi.step2 = FclStep2No.FCL_STEP2_FIRSTCARD.index; flag = true; break;
                   case 2007:
                     int flg = tsBuf.multi.flg ?? 0;
                     tsBuf.multi.flg = flg | 0x10;
                     flag = true;
                     break;
                 }
                 break;
               default:
                 break;
             }
             if( flag ) {
               await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.SLAVE, "MultiTmn");
             }
           }
           break;
         default:
           return(tmnCifGetEventRet.result);
       }
       await Future.delayed(Duration(milliseconds: TMN_EVT_WAIT));
    }
    return(tmncat.CIF_EVT_NONE); /* SysError */
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_Transact()
  /// rcTmnTransact
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnTransact() async
  {
    String    log = "";
    int       ret = 0;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    TmnCY     amount = TmnCY();
    TmnCY     tax = TmnCY();
    int       resultFlg = 0;
    List<String>    asiData = ["","","","","",""];

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnTransact>");

    try {

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
      switch(tsBuf.multi.fclData.skind) {
        case FclService.FCL_QP:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
          lng = tmncat.CAT_MEDIA_QUICPAY;
          break;
        case FclService.FCL_ID:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
          lng = tmncat.CAT_MEDIA_ID;
          break;
        default:
          return 0;
      }
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
      bol = TRUE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
      if(tsBuf.multi.fclData.mode == 3) {
        bol = TRUE;
      } else {
        bol = FALSE;
      }
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AdditionalSecurityInformation)");
      bstr = "";
      /* Set ASI Data */
      switch(tsBuf.multi.fclData.skind) {
        case FclService.FCL_QP:
          if(tsBuf.multi.fclData.tKind == 1) {
            if((tsBuf.multi.fclData.sndData.canIcNo == 0)
            || (tsBuf.multi.fclData.sndData.canSlipNo == 0)) {
              await rcTmnSysError();
              return 0;
            }
            bstr = (tsBuf.multi.fclData.sndData.canIcNo! % 10000).toString().padLeft(4, '0') + ","
                         + (tsBuf.multi.fclData.sndData.canSlipNo! % 100000).toString().padLeft(5, '0') + ",,";
         } else {
         }
         break;
       case FclService.FCL_ID:
         if(tsBuf.multi.fclData.tKind == 1) {
           if(tsBuf.multi.fclData.sndData.canSlipNo == 0) {
             await rcTmnSysError();
             return 0;
           }

           if( (tsBuf.multi.fclData.sndData.pluCd != null) && (tsBuf.multi.fclData.sndData.pluCd!.length > 1) ) {
              bstr = (tsBuf.multi.fclData.sndData.canSlipNo! % 100000).toString().padLeft(5, '0') + ",2,"
                        + _convertSubstring(tsBuf.multi.fclData.sndData.pluCd ?? "", 1, 8) + ",,";
           } else {
              bstr = (tsBuf.multi.fclData.sndData.canSlipNo! % 100000).toString().padLeft(5, '0') + ",2,,,";
           }
         } else {
           if( (tsBuf.multi.fclData.sndData.pluCd != null) && (tsBuf.multi.fclData.sndData.pluCd!.length > 1) ) {
              bstr = _convertSubstring(tsBuf.multi.fclData.sndData.pluCd ?? "", 1, 8) + ",1,";
           } else {
              bstr = ",1,";
           }
         }
         break;
       default:
         break;
     }
     log = "bstr = [" + _convertSubstring(bstr, 0, 100) + "]";
     myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

     ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ADDITIONALSECURITYINFORMATION, lng, bol, bstr);
     if(ret != tmncat.OPOS_SUCCESS) {
       await rcTmnOcxError(ret);
       return 0;
     }
     if((tsBuf.multi.fclData.sndData.ttlAmt == 0)
     || (tsBuf.multi.fclData.sndData.printNo == 0)) {
        await rcTmnSysError();
        return 0;
     }
     log = "(SequenceNumber = ${tsBuf.multi.fclData.sndData.printNo.toString().padLeft(9, '0')})";
     myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
     log = "(Amount = ${tsBuf.multi.fclData.sndData.ttlAmt})";
     myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
     amount.hi = 0;
     amount.lo = tsBuf.multi.fclData.sndData.ttlAmt;
     tax.hi    = 0;
     tax.lo    = 0;
     TmnOposAuthorizeResult tmnOposAuthorizeRet = TmnOposAuthorizeResult();
     if(tsBuf.multi.fclData.tKind == 1) {
       myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposAuthorizeVoid");
       tmnOposAuthorizeRet = ffiMultiTmn.tmnOposAuthorizeVoid(tsBuf.multi.fclData.sndData.printNo, amount, tax, TMN_TRAN_TIMEOUT);
     } else {
       myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposAuthorizeSales");
       tmnOposAuthorizeRet = ffiMultiTmn.tmnOposAuthorizeSales(tsBuf.multi.fclData.sndData.printNo, amount, tax, TMN_TRAN_TIMEOUT);
     }
     if(tmnOposAuthorizeRet.result != tmncat.OPOS_SUCCESS) {
       await rcTmnOcxError(tmnOposAuthorizeRet.result);
       return 0;
     }
     tsBuf.multi.step = FclStepNo.FCL_STEP_TRAN_BEFORE.index;

     final result = await rcTmnGetEvent();
     switch(result) {
       case tmncat.CIF_EVT_NONE:
         await rcTmnSysError();
         return 0;
       case tmncat.CIF_EVT_OUTPUTCOMPLETE:
         ret = await rcTmnGetTranData();
         if(ret != tmncat.OPOS_SUCCESS) {
           await rcTmnOcxError(ret);
           return 0;
         }

         myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
         bstr = "";

         TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
         if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
           await rcTmnOcxError(tmnCifPropertyRet.result);
           return 0;
         }
         log = "bstr = [" + _convertSubstring( tmnCifPropertyRet.bstr, 0, 100) + "]";
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

          /* Get ASI Data */
          asiData = rcTmnPickAsiData(tmnCifPropertyRet.bstr, asiData);
          switch(tsBuf.multi.fclData.skind) {
            case FclService.FCL_QP:
              tsBuf.multi.fclData.rcvData.dateTime = _convertSubstring(asiData[0], 2, DATE_TIME_SIZE+2);
              log = "date_time = " + _convertSubstring(tsBuf.multi.fclData.rcvData.dateTime ?? "", 0, 12);
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
              break;
            case FclService.FCL_ID:
              tsBuf.multi.fclData.rcvData.dateTime = _convertSubstring(asiData[0], 2, DATE_TIME_SIZE+2);
              log = "date_time = " + _convertSubstring(tsBuf.multi.fclData.rcvData.dateTime ?? "", 0, 12);
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
              if(tsBuf.multi.fclData.mode == 3) {
                 tsBuf.multi.fclData.rcvData.limitDate = 9999;
              } else {
                 tsBuf.multi.fclData.rcvData.limitDate = int.parse(asiData[2]);
              }
              log = "limit_date = " + tsBuf.multi.fclData.rcvData.limitDate.toString().padLeft(4, '0');
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
              break;
            default:
              break;
          }
          break;
        case tmncat.CIF_EVT_ERROR:
          resultFlg = 0;
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(ResultCode)");
          TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.RESULTCODE);
          if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
            await rcTmnOcxError(tmnCifPropertyRet.result);
            return 0;
          }
          tsBuf.multi.fclData.resultCode = tmnCifPropertyRet.lng;
          if(tsBuf.multi.fclData.resultCode == tmncat.OPOS_E_EXTENDED) {
            myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(ResultCodeExtended)");
            tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.RESULTCODEEXTENDED);
            if(tmnCifPropertyRet.result == tmncat.OPOS_SUCCESS) {
              tsBuf.multi.fclData.resultCodeExtended = tmnCifPropertyRet.lng;
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(CenterResultCode)");
              bstr = "";
              tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.CENTERRESULTCODE);
              if(tmnCifPropertyRet.result == tmncat.OPOS_SUCCESS) {
                tsBuf.multi.fclData.centerResultCode = _convertSubstring(tmnCifPropertyRet.bstr, 0,CENTER_RESULTCODE_SIZE);
              } else {
                resultFlg = 2;
              }
            } else {
              resultFlg = 2;
            }
          }
          log = "ResultCode = " + tsBuf.multi.fclData.resultCode.toString().padLeft(3, '0') + " : "
                                + tsBuf.multi.fclData.resultCodeExtended.toString().padLeft(9, '0') + " : "
                                + _convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5);
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

          if(resultFlg == 0) {
            resultFlg = rcTmnChkResultcode();
          }
          switch(resultFlg) {
            case 1: /* CANCEL */
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"-> Cancel");
              await rcTmnCancelEnd();
              return 0;
            case 2: /* UNKNOWN */
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"-> Unknown");
              ret = await rcTmnRefer();
              return 0;
            default: /* ERROR */
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"-> Error");
              await rcTmnResError();
              return 0;
          }
        default:
          await rcTmnOcxError(ret);
          return 0;
      }

      await rcTmnNormalEnd();
    } catch(e,s) {
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"rcTmnTransact $e,$s");
        ret = tmncat.OPOS_E_INTERNAL;
        await rcTmnOcxError(ret);
    }
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_Refer()
  /// rcTmnRefer
  /// 引数: なし
  /// 戻り値：なし
  Future<int> rcTmnRefer() async
  {
    String    log = "";
    int       ret = 0;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    str = "";
    List<String>    asiData = ["","","","","",""];

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnRefer>");
    try {
      if(tsBuf.multi.fclData.rcvData == null ) {
        tsBuf.multi.fclData.rcvData = FclRcvData();
      }
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
      switch(tsBuf.multi.fclData.skind) {
        case FclService.FCL_QP:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
          lng = tmncat.CAT_MEDIA_QUICPAY;
          command = 1010;
          break;
        case FclService.FCL_ID:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
          lng = tmncat.CAT_MEDIA_ID;
          command = 2010;
          break;
       default:
          await rcTmnSysError();
          return 0;
      }
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        rcTmnSetUnknownFlg();
        await rcTmnResError();
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        rcTmnSetUnknownFlg();
        await rcTmnResError();
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      if(tsBuf.multi.fclData.sndData.printNo == 0) {
        await rcTmnSysError();
        return 0;
      }
      log = "(SequenceNumber = " + tsBuf.multi.fclData.sndData.printNo.toString().padLeft(9, '0');
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(X010)");
      data = tsBuf.multi.fclData.sndData.printNo as int;
      str = "";
      TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, str);
      if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
        rcTmnSetUnknownFlg();
        await rcTmnResError();
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
      TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
      if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
        rcTmnSetUnknownFlg();
        await rcTmnResError();
        return 0;
      }
      log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

      /* Get ASI Data */
      asiData = rcTmnPickAsiData(tmnCifPropertyRet.bstr, asiData);
      switch(asiData[0][0]) {
        case '0': /* EXIST */
          ret = await rcTmnGetTranData();
          if(ret != tmncat.OPOS_SUCCESS) {
            rcTmnSetUnknownFlg();
            await rcTmnResError();
            return 0;
          }

          switch(tsBuf.multi.fclData.skind) {
            case FclService.FCL_QP:
              tsBuf.multi.fclData.rcvData.dateTime = _convertSubstring(asiData[1], 2, DATE_TIME_SIZE+2);
              log = "date_time = " + _convertSubstring(tsBuf.multi.fclData.rcvData.dateTime ?? "", 0, 12);
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
              break;

            case FclService.FCL_ID:
              tsBuf.multi.fclData.rcvData.dateTime = _convertSubstring(asiData[1], 2, DATE_TIME_SIZE+2);
              log = "date_time = " + _convertSubstring(tsBuf.multi.fclData.rcvData.dateTime ?? "", 0, 12);
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

              if(tsBuf.multi.fclData.mode == 3) {
                tsBuf.multi.fclData.rcvData.limitDate = 9999;
              } else {
                tsBuf.multi.fclData.rcvData.limitDate = int.parse(asiData[3]);
              }
              log = "limit_date = " + tsBuf.multi.fclData.rcvData.limitDate.toString().padLeft(4, '0');
              myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
              break;
            default:
              break;
          }
          break;
        default: /* NOTHING */
          await rcTmnResError();
          return 0;
      }

      await rcTmnNormalEnd();
    } catch(e,s) {
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"rcTmnRefer $e,$s");
        ret = tmncat.OPOS_E_INTERNAL;
        await rcTmnOcxError(ret);
    }
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_GetTranData()
  /// rcTmnGetTranData
  /// 引数: なし
  /// 戻り値：OPOS "ResultCode" Property Constants
  Future<int> rcTmnGetTranData() async
  {
    String    log = "";
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    String    buf = "";

    if(tsBuf.multi.fclData.rcvData == null ) {
      tsBuf.multi.fclData.rcvData = FclRcvData();
    }
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AccountNumber)");
    TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ACCOUNTNUMBER);
    if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
      return(tmnCifPropertyRet.result);
    }
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    switch(tsBuf.multi.fclData.skind) {
      case FclService.FCL_QP:
        tsBuf.multi.fclData.rcvData.cardId = _convertSubstring(tmnCifPropertyRet.bstr, 0, 20);
        log = "card_id = " + _convertSubstring(tsBuf.multi.fclData.rcvData.cardId ?? "", 0, 20);
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
        break;
      case FclService.FCL_ID:
        tsBuf.multi.fclData.rcvData.cardId = _convertSubstring(tmnCifPropertyRet.bstr, 0, 16);
        log = "card_id = " + _convertSubstring(tsBuf.multi.fclData.rcvData.cardId ?? "", 0, 16);
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
        break;
      default:
        break;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(SlipNumber)");
    tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.SLIPNUMBER);
    if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
      return(tmnCifPropertyRet.result);
    }
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    buf = _convertSubstring(tmnCifPropertyRet.bstr, 0, 5);
    tsBuf.multi.fclData.rcvData.slipNo = int.parse(buf);
    log = "slip_no = " + tsBuf.multi.fclData.rcvData.slipNo.toString().padLeft(5, '0');
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(TransactionNumber)");
    tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.TRANSACTIONNUMBER);
    if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
      return(tmnCifPropertyRet.result);
    }
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    switch(tsBuf.multi.fclData.skind) {
      case FclService.FCL_QP:
        buf = _convertSubstring(tmnCifPropertyRet.bstr, 0, 4);
        tsBuf.multi.fclData.rcvData.icNo = int.parse(buf);
        log = "ic_no = " + tsBuf.multi.fclData.rcvData.icNo.toString().padLeft(4, '0');
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
        break;
      case FclService.FCL_ID:
        if(tmnCifPropertyRet.bstr.length > 0) {
          buf = _convertSubstring(tmnCifPropertyRet.bstr, 1, 6);
          tsBuf.multi.fclData.rcvData.recognNo = int.parse(buf);
        }
        log = "recogn_no = " + tsBuf.multi.fclData.rcvData.recognNo.toString().padLeft(6, '0');
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
        break;
      default:
        break;
    }

    return(tmncat.OPOS_SUCCESS);
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_ChkResultcode()
  /// rcTmnChkResultcode
  /// 引数: なし
  /// 戻り値：0 ～ 2
  ///         1:resultCode = 114 resultCodeExtended = 130000001
  ///         2:resultCode = 106
  ///         2:resultCode = 114 resultCodeExtended = 123000002
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T0601
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T0602
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T0603
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T0605
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T0606
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T0607
  ///         2:resultCode = 114 resultCodeExtended = 200000010/200000110 centerResultCode = T1701
  ///         2:resultCode = 114 resultCodeExtended = 200000000 centerResultCode = T0622
  ///         0:上記以外
  int rcTmnChkResultcode()
  {
    if(tsBuf.multi.fclData.resultCode == 106) {
      return(2);
    }
    if(tsBuf.multi.fclData.resultCode == 114) {
      if(tsBuf.multi.fclData.resultCodeExtended == 130000001) {
         return(1);
      }
      if(tsBuf.multi.fclData.resultCodeExtended == 123000002) {
        return(2);
      }
      if((tsBuf.multi.fclData.resultCodeExtended == 200000010)
      || (tsBuf.multi.fclData.resultCodeExtended == 200000110)) {
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0601") {
          return(2);
        }
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0602") {
          return(2);
        }
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0603") {
          return(2);
        }
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0605") {
          return(2);
        }
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0606") {
          return(2);
        }
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0607") {
          return(2);
        }
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T1701") {
          return(2);
        }
      }

      if(tsBuf.multi.fclData.resultCodeExtended == 200000000) {
        if(_convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5) == "T0622") {
          return(2);
        }
      }
   }

    return(0);
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_PickAsiData()
  /// rcTmnPickAsiData
  /// 引数: String indata
  ///       List<String> outdata
  /// 戻り値：List<String>
  List<String> rcTmnPickAsiData(String indata, List<String> outdata)
  {
    return indata.split(',');
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_Daily()
  /// rcTmnDaily
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnDaily() async
  {
    String    log = "";
    int       ret = 0;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       resultFlg = 0;

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnDaily>");
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    switch(tsBuf.multi.fclData.skind) {
      case FclService.FCL_QP:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
        lng = tmncat.CAT_MEDIA_QUICPAY;
        break;
      case FclService.FCL_ID:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
        lng = tmncat.CAT_MEDIA_ID;
        break;
      default:
        return 0;
    }
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = TRUE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- AccessDailyLog");
    ret = ffiMultiTmn.tmnOposAccessDailyLog(999999999, tmncat.CAT_DL_SETTLEMENT, TMN_DAIL_TIMEOUT);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    final result = await rcTmnGetEvent();
    switch(result) {
      case tmncat.CIF_EVT_NONE:
        await rcTmnSysError();
        return 0;
      case tmncat.CIF_EVT_OUTPUTCOMPLETE:
        /* For LogWrite */
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
        TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
        log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
        break;
      case tmncat.CIF_EVT_ERROR:
        resultFlg = 0;
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(ResultCode)");
        TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.RESULTCODE);
        if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
           await rcTmnOcxError(tmnCifPropertyRet.result);
           return 0;
        }
        tsBuf.multi.fclData.resultCode = tmnCifPropertyRet.lng;
        if(tsBuf.multi.fclData.resultCode == tmncat.OPOS_E_EXTENDED) {
           myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(ResultCodeExtended)");
           tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.RESULTCODEEXTENDED);
           if(tmnCifPropertyRet.result == tmncat.OPOS_SUCCESS) {
             tsBuf.multi.fclData.resultCodeExtended = tmnCifPropertyRet.lng;
             myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(CenterResultCode)");
             tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.CENTERRESULTCODE);
             if(tmnCifPropertyRet.result == tmncat.OPOS_SUCCESS) {
                tsBuf.multi.fclData.centerResultCode = _convertSubstring(tmnCifPropertyRet.bstr, 0, CENTER_RESULTCODE_SIZE);
             } else {
                resultFlg = 2;
             }
           } else {
             resultFlg = 2;
           }
         }
         log = "ResultCode = " + tsBuf.multi.fclData.resultCode.toString().padLeft(3, '0')
                               + tsBuf.multi.fclData.resultCodeExtended.toString().padLeft(9, '0')
                               + _convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5);
         myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

         if(resultFlg == 0) {
           resultFlg = rcTmnChkResultcode();
         }
         switch(resultFlg) {
           case 1: /* CANCEL */
           default: /* ERROR */
             myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"-> Error");
             await rcTmnResError();
             return 0;
         }
       default:
         await rcTmnOcxError(ret);
         return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_Delete()
  /// rcTmnDelete
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int>  rcTmnDelete() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnDelete>");
    try {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
      switch(tsBuf.multi.fclData.skind) {
        case FclService.FCL_QP:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
          lng = tmncat.CAT_MEDIA_QUICPAY;
          command = 1014;
          break;
        case FclService.FCL_ID:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
          lng = tmncat.CAT_MEDIA_ID;
          command = 2014;
          break;
        default:
          return 0;
      }
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }
      if(tsBuf.multi.fclData.sndData.printNo == 0) {
        await rcTmnSysError();
        return 0;
      }
      log = "(SequenceNumber = " + tsBuf.multi.fclData.sndData.printNo.toString().padLeft(9, '0');
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(X014)");
      data = tsBuf.multi.fclData.sndData.printNo;
      strBuf = "";
      TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
      if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(tmnOposDirectIORet.result);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
      TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
      if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(tmnCifPropertyRet.result);
        return 0;
      }

      log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

      if(_convertSubstring(tmnCifPropertyRet.bstr, 0, 1) == '0') {
        tsBuf.multi.fclData.result = 0;
      } else {
        tsBuf.multi.fclData.result = 1;
      }
      log = "result = " + tsBuf.multi.fclData.result.toString();
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
      await rcTmnNormalEnd();
    } catch(e,s) {
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"rcTmnDelete $e,$s");
        ret = tmncat.OPOS_E_INTERNAL;
        await rcTmnOcxError(ret);
    }
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_ReferExist()
  /// rcTmnReferExist
  /// 引数: なし
  /// 戻り値：なし
  Future<int>  rcTmnReferExist() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnReferExist>");
    try {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
      switch(tsBuf.multi.fclData.skind) {
        case FclService.FCL_QP:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
          lng = tmncat.CAT_MEDIA_QUICPAY;
          command = 1010;
          break;
        case FclService.FCL_ID:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
          lng = tmncat.CAT_MEDIA_ID;
          command = 2010;
          break;
        default:
          await rcTmnSysError();
          return 0;
      }
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      if(tsBuf.multi.fclData.sndData.printNo == 0) {
        await rcTmnSysError();
        return 0;
      }
      log = "(SequenceNumber = " + tsBuf.multi.fclData.sndData.printNo.toString().padLeft(9, '0');
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(X010)");
      data = tsBuf.multi.fclData.sndData.printNo as int;
      strBuf = "";
      TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
      if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(tmnOposDirectIORet.result);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
      TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
      if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(tmnCifPropertyRet.result);
        return 0;
      }
      log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

      tsBuf.multi.fclData.data![0] = _convertSubstring(tmnCifPropertyRet.bstr, 0, 2);
      log = "bstr = [" + _convertSubstring(tsBuf.multi.fclData.data![0], 0, 100) + "]";
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

      await rcTmnNormalEnd();
    } catch(e,s) {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"rcTmnDelete $e,$s");
      ret = tmncat.OPOS_E_INTERNAL;
      await rcTmnOcxError(ret);
    }
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_Open()
  /// rcTmnOpen
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int>  rcTmnOpen() async
  {
    int       ret = 0;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnOpen>");

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposOpen");
    ret = ffiMultiTmn.tmnOposOpen();
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposClaimDevice");
    ret = ffiMultiTmn.tmnOposClaimDevice(0);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(DeviceEnabled)");
    bol = TRUE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.DEVICEENABLED, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_Close()
  /// rcTmnClose
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int>  rcTmnClose() async
  {
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnClose>");

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(DeviceEnabled)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.DEVICEENABLED, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposReleaseDevice");
    ret = ffiMultiTmn.tmnOposReleaseDevice();
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposClose");
    ret = ffiMultiTmn.tmnOposClose();
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_SetupTid()
  /// rcTmnSetupTid
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int>  rcTmnSetupTid() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnSetupTid>");
    try {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
      lng = tmncat.CAT_MEDIA_COMMON;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(300)");
      command = 300;
      data = 0;
      strBuf = "";
      TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
      if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(tmnOposDirectIORet.result);
        return 0;
      }

      /* For LogWrite */
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
      TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
      log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

      await rcTmnNormalEnd();
    } catch(e,s) {
       myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"rcTmnSetupTid $e,$s");
       ret = tmncat.OPOS_E_INTERNAL;
       await rcTmnOcxError(ret);
    }
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_IniDownload()
  /// rcTmnIniDownload
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int>  rcTmnIniDownload() async
  {
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnIniDownload>");

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    lng = tmncat.CAT_MEDIA_COMMON;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(303)");
    command = 303;
    data = 0;
    strBuf = "";
    TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    lng = tmncat.CAT_MEDIA_COMMON;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(304)");
    command = 304;
    data = 0;
    strBuf = "";
    tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_ChangeTid()
  /// rcTmnChangeTid
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnChangeTid() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnChangeTid>");

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    lng = tmncat.CAT_MEDIA_COMMON;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(305)");
    command = 305;
    data = 0;
    strBuf = "";
    TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    /* For LogWrite */
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
    TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_ChangeUt()
  /// rcTmnChangeUt
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnChangeUt() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnChangeUt>");

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    lng = tmncat.CAT_MEDIA_COMMON;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(204)");
    command = 204;
    data = 0;
    strBuf = "";
    TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
    TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
    if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnCifPropertyRet.result);
      return 0;
    }
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    lng = tmncat.CAT_MEDIA_COMMON;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AdditionalSecurityInformation)");
    bstr = "";
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ADDITIONALSECURITYINFORMATION, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(306)");
    command = 306;
    data = 0;
    strBuf = "";
    tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_CheckHealth()
  /// rcTmnCheckHealth
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnCheckHealth() async
  {
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnCheckHealth>");

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    lng = tmncat.CAT_MEDIA_COMMON;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposCheckHealth");
    ret = ffiMultiTmn.tmnOposCheckHealth(tmncat.OPOS_CH_EXTERNAL);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_OnlineTest()
  /// rcTmnOnlineTest
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnOnlineTest() async
  {
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnOnlineTest>");
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    switch(tsBuf.multi.fclData.skind) {
      case FclService.FCL_QP:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
        lng = tmncat.CAT_MEDIA_QUICPAY;
        command = 1005;
        break;
      case FclService.FCL_ID:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
        lng = tmncat.CAT_MEDIA_ID;
        command = 2005;
        break;
      default:
        await rcTmnSysError();
        return 0;
    }
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(X005)");
    data = 0;
    strBuf = "";
    TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_GetVolume()
  /// rcTmnGetVolume
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnGetVolume() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";
    String    buf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnGetVolume>");
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    switch(tsBuf.multi.fclData.skind) {
      case FclService.FCL_QP:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
        lng = tmncat.CAT_MEDIA_QUICPAY;
        command = 1006;
        break;
      case FclService.FCL_ID:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
        lng = tmncat.CAT_MEDIA_ID;
        command = 2006;
        break;
      default:
        await rcTmnSysError();
        return 0;
    }
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
    bol = FALSE;
    ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
    if(ret != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(ret);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(X006)");
    data = 0;
    strBuf = "";
    TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
    if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnOposDirectIORet.result);
      return 0;
    }

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(AdditionalSecurityInformation)");
    TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.ADDITIONALSECURITYINFORMATION);
    if(tmnCifPropertyRet.result != tmncat.OPOS_SUCCESS) {
      await rcTmnOcxError(tmnCifPropertyRet.result);
      return 0;
    }
    log = "bstr = [" + _convertSubstring(tmnCifPropertyRet.bstr, 0, 100) + "]";
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    buf = "";
    buf = _convertSubstring(tmnCifPropertyRet.bstr, 0, 1);
    if(buf.length > 0) {
      tsBuf.multi.fclData.result = int.parse(buf);
    }
    log = "volume = " + tsBuf.multi.fclData.result.toString();
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    await rcTmnNormalEnd();
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_SetVolume()
  /// rcTmnSetVolume
  /// 引数: なし
  /// 戻り値：0 終了
  Future<int> rcTmnSetVolume() async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";
    int       command = 0;
    int       data = 0;
    String    strBuf = "";

    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"<rcTmnSetVolume>");
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(PaymentMedia)");
    try {
      switch(tsBuf.multi.fclData.skind) {
        case FclService.FCL_QP:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_QUICPAY)");
          lng = tmncat.CAT_MEDIA_QUICPAY;
          command = 1007;
          break;
        case FclService.FCL_ID:
          myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"(CAT_MEDIA_ID)");
          lng = tmncat.CAT_MEDIA_ID;
          command = 2007;
          break;
        default:
          await rcTmnSysError();
          return 0;
      }
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.PAYMENTMEDIA, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AsyncMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ASYNCMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(TrainingMode)");
      bol = FALSE;
      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.TRAININGMODE, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifSetProperty(AdditionalSecurityInformation)");
      if(tsBuf.multi.fclData.result as int > 5) {
        await rcTmnSysError();
        return 0;
      }

      bstr = tsBuf.multi.fclData.result.toString();
      log = "bstr = [" + _convertSubstring(tsBuf.multi.fclData.result.toString(), 0, 100) + "]";
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

      ret = ffiMultiTmn.tmnCifSetProperty(tmncat.ADDITIONALSECURITYINFORMATION, lng, bol, bstr);
      if(ret != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(ret);
        return 0;
      }

      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- OposDirectIO(X007)");
      data = 0;
      strBuf = "";
      TmnOposDirectIOResult tmnOposDirectIORet = ffiMultiTmn.tmnOposDirectIO(command, data, strBuf);
      if(tmnOposDirectIORet.result != tmncat.OPOS_SUCCESS) {
        await rcTmnOcxError(tmnOposDirectIORet.result);
        return 0;
      }

      await rcTmnNormalEnd();
    } catch(e,s) {
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"rcTmnSetVolume $e,$s");
        ret = tmncat.OPOS_E_INTERNAL;
        await rcTmnOcxError(ret);
    }
    return 0;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_ResError()
  Future<void> rcTmnResError() async
  {
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"FCL_RESERR");
    int flg = tsBuf.multi.flg ?? 0;
    tsBuf.multi.flg = flg & ~0x01;
    tsBuf.multi.errCd = Fcl.FCL_RESERR;
    tsBuf.multi.order  = FclProcNo.FCL_NOT_ORDER.index;
    await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "MultiTmn");
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_OcxError()
  Future<void> rcTmnOcxError(int code) async
  {
    String    log = "";
    int       ret = 0;;
    int       lng = 0;
    int       bol = 0;
    String    bstr = "";

    tsBuf.multi.fclData.resultCode = code;
    tsBuf.multi.fclData.resultCodeExtended = 0;
    tsBuf.multi.fclData.centerResultCode = "";
    
    if(code == tmncat.OPOS_E_EXTENDED) {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(ResultCodeExtended)");
      TmnCifPropertyResult tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.RESULTCODEEXTENDED);
      if(tmnCifPropertyRet.result == tmncat.OPOS_SUCCESS) {
        tsBuf.multi.fclData.resultCodeExtended = tmnCifPropertyRet.lng;
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"--- CifGetProperty(CenterResultCode)");
        tmnCifPropertyRet = ffiMultiTmn.tmnCifGetProperty(tmncat.CENTERRESULTCODE);
        if(tmnCifPropertyRet.result == tmncat.OPOS_SUCCESS) {
          tsBuf.multi.fclData.centerResultCode = _convertSubstring(tmnCifPropertyRet.bstr, 0, CENTER_RESULTCODE_SIZE);
        }
      }
    }
    log = "ResultCode = " + tsBuf.multi.fclData.resultCode.toString().padLeft(3, '0') + " : " + tsBuf.multi.fclData.resultCodeExtended.toString().padLeft(9, '0') + " : " + _convertSubstring(tsBuf.multi.fclData.centerResultCode ?? "", 0, 5);
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,log);

    if((tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_BEFORE.index)
    || (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.index)) {
      rcTmnSetUnknownFlg();
    }
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"FCL_OCXERR");
    int flg = tsBuf.multi.flg ?? 0;
    tsBuf.multi.flg = flg & ~0x01;
    tsBuf.multi.errCd = Fcl.FCL_OCXERR;
    tsBuf.multi.order  = FclProcNo.FCL_NOT_ORDER.index;
    await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "MultiTmn");
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_SysError()
  Future<void> rcTmnSysError() async
  {
    if((tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_BEFORE.index)
    || (tsBuf.multi.step == FclStepNo.FCL_STEP_TRAN_TOUCH.index)) {
      rcTmnSetUnknownFlg();
    }
    myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"FCL_SYSERR");
    int flg = tsBuf.multi.flg ?? 0;
    tsBuf.multi.flg = flg & ~0x01;
    tsBuf.multi.errCd = Fcl.FCL_SYSERR;
    tsBuf.multi.order  = FclProcNo.FCL_NOT_ORDER.index;
    await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "MultiTmn");
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_NormalEnd()
  Future<void> rcTmnNormalEnd() async
  {
    int flg = tsBuf.multi.flg ?? 0;
    tsBuf.multi.flg = flg & ~0x01;
    int order = tsBuf.multi.order ?? 0;
    switch(FclProcNo.getDefine(tsBuf.multi.order)) {
      case FclProcNo.FCL_T_START:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"FCL_T_END");
        tsBuf.multi.order  = FclProcNo.FCL_T_END.index;
        break;
      case FclProcNo.OCX_D_START:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"OCX_D_END");
        tsBuf.multi.order  = FclProcNo.OCX_D_END.index;
        break;
      case FclProcNo.OCX_U_START:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"OCX_U_END");
        tsBuf.multi.order  = FclProcNo.OCX_U_END.index;
        break;
      default:
        await rcTmnSysError();
        break;
    }
    if( order != tsBuf.multi.order ) {
      await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "MultiTmn");
    }

  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_CancelEnd()
  Future<void> rcTmnCancelEnd() async
  {
    int flg = tsBuf.multi.flg ?? 0;
    tsBuf.multi.flg = flg & ~0x01;
    int order = tsBuf.multi.order ?? 0;
    switch(FclProcNo.getDefine(tsBuf.multi.order)) {
      case FclProcNo.FCL_T_START:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"FCL_T_CAN_END");
        tsBuf.multi.order  = FclProcNo.FCL_T_CAN_END.index;
        break;
      case FclProcNo.OCX_D_START:
        myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"OCX_D_CAN_END");
        tsBuf.multi.order  = FclProcNo.OCX_D_CAN_END.index;
        break;
      default:
        await rcTmnSysError();
        break;
    }
    if( order != tsBuf.multi.order ) {
       await SystemFunc.rxMemWrite(_parentSendPort, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER, "MultiTmn");
    }
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_InitStep()
  void rcTmnInitStep() 
  {
    if(tsBuf.multi.step != FclStepNo.FCL_STEP_AUTO_INIT.value) {
      tsBuf.multi.step = FclStepNo.FCL_STEP_WAIT.index;
    }
    tsBuf.multi.step2 = FclStep2No.FCL_STEP2_NORMAL.index;
  }

  /// 関連tprxソース: rc_multi_tmn.c - rcTmn_SetUnknownFlg()
  void rcTmnSetUnknownFlg()
  {
    if(tsBuf.multi.fclData.mode != 3) {
      myLog.logAdd(Tpraid.TPRAID_MULTI_TMN, LogLevelDefine.normal,"Unknown Flg ON!");
      int flg = tsBuf.multi.flg ?? 0;
      tsBuf.multi.flg = flg | 0x20;
    }
  }

  /// 中断処理
  void abort() {
    _isAbort = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "TprDrvRcMultiTmn (TMN Isolate) _abort");
  }

  /// 停止処理
  void stop() {
    _isStop = true;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "TprDrvRcMultiTmn (TMN Isolate) _stop");
  }

  /// 再開処理
  void restart() {
    _isStop = false;
    TprLog().logAdd(myTid, LogLevelDefine.normal, "TprDrvRcMultiTmn (TMN Isolate) _restart");
  }
}
/* end of rc_multi_tmn.c */
