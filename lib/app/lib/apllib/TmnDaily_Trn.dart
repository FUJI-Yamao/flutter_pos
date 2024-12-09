/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'package:path/path.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_fcl.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/checker/rc_apldlg.dart';
import '../../sys/usetup/fcl_setup/fcl_setup.dart';
import 'file_cpy.dart';
import 'TmnEj_Make.dart';
import 'ut_msg_lib.dart';

/// 関連tprxソース:TmnDaily_Trn.c
class TmnDailyTrn {
  static UtInfo utSaleInfo = UtInfo();
  static late RxTaskStatBuf pStat;
  static FclsInfo fclsInfo = FclsInfo();
  
  /// 関数: ut_daily_main_proc()
  /// 機能: QP/iD日計処理
  /// 引数：int tid
  ///      int  tranType  0:QUICPay A1:iDA 2:Edy
  ///      int  kind       0:メンテナンス、1:閉設
  /// 戻値： O:正常終了 / 0以外:エラー
  /// 関連tprxソース:TmnDaily_Trn.c - ut_daily_main_proc
  static Future<int> utDailyMainProc(int tid, int tranType, int kind)
  async {
    late File fp;
    late File fp2;
    late File fp3;
    String tmpbuf;
    String fileName;
    int errNo;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "pwoffmain_UT1_close rxMemPtr() ERROR");
      return 0;
    }
    pStat = xRet.object;

    utSaleInfo.result = 0;
    pStat.multi.errCd = 0;

    if(tranType == 0){
      fileName = "${EnvironmentData().sysHomeDir}/log/tmn/Re_QP.txt";
      pStat.multi.fclData.skind = FclService.FCL_QP;
    } else if(tranType == 2) {
      fileName = "${EnvironmentData().sysHomeDir}/log/tmn/Re_Edy.txt";
      pStat.multi.fclData.skind = FclService.FCL_EDY;
    } else{
      fileName = "${EnvironmentData().sysHomeDir}/log/tmn/Re_iD.txt";
      pStat.multi.fclData.skind = FclService.FCL_ID;
    }

    await TmnEjMake.tmnEJMakeStartEnd( tid, kind, 0 );

    fp = TprxPlatform.getFile(fileName);

    if(!fp.existsSync())
    {
      pStat.multi.fclData.tKind = 0;
      pStat.multi.order = FclProcNo.OCX_D_START.index;
      await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");

      errNo = await utProcDaily(tid, tranType);
      if(errNo != 0) utSaleInfo.result = 1;
    }
    else{
      List<String> lines = fp.readAsLinesSync();
      int lineNum = 0;
      while(true) {
        tmpbuf = lineNum < lines.length ? lines[lineNum] : "";
        if(lineNum++ < lines.length) {
          if(tranType == 2)
          {
            /* Edyの場合、不明取引センタ不成立メソッドが廃止の為、*/
            /* メソッド処理は行わない */
            pStat.multi.fclData.sndData.printNo = int.tryParse(tmpbuf) ?? 0;
            pStat.multi.order = FclProcNo.OCX_D_END.index;
            await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");// 取引不明一覧のｼｰｹﾝｽ番号のみ印字したい為メソッド終了状態とする
            errNo = await utProcDailyDelete(tid, tranType);
            if(errNo != 0){
              utSaleInfo.result = 2;
            }
          }
          else
          {
            pStat.multi.fclData.sndData.printNo = int.tryParse(tmpbuf) ?? 0;
            pStat.multi.fclData.tKind = 1;
            pStat.multi.order = FclProcNo.OCX_D_START.index;
            await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
            errNo = await utProcDailyDelete(tid, tranType);
            if(errNo != 0){
              utSaleInfo.result = 2;
            }
          }
        }
        else{
          if(tranType == 0){
            fileName = "${EnvironmentData().sysHomeDir}/log/tmn/ng_Re_QP.txt";
          }
          else if(tranType == 2)
          {
            fileName = "${EnvironmentData().sysHomeDir}/log/tmn/ng_Re_Edy.txt";
          }
          else{
            fileName = "${EnvironmentData().sysHomeDir}/log/tmn/ng_Re_iD.txt";
          }
          fp2 = TprxPlatform.getFile(fileName);

          if(!fp2.existsSync())
          {
            /* Edyの場合、ng_Re_Edy.txtは作成されない為、必ずここを通る。 */
            pStat.multi.fclData.tKind = 0;
            pStat.multi.order = FclProcNo.OCX_D_START.index;
            await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
            errNo = await utProcDaily(tid, tranType);
            if(errNo != 0) utSaleInfo.result = 1;
            if(tranType == 0){
              deleteFilesRecursively("${EnvironmentData().sysHomeDir}/log/tmn", "Re_QP.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Recursive delete Re_QP.txt in ${EnvironmentData().sysHomeDir}/log/tmn}");
            }
            else if(tranType == 2)
            {
              deleteFilesRecursively("${EnvironmentData().sysHomeDir}/log/tmn", "Re_Edy.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Recursive delete Re_Edy.txt in ${EnvironmentData().sysHomeDir}/log/tmn}");
            }
            else{
              deleteFilesRecursively("${EnvironmentData().sysHomeDir}/log/tmn", "Re_iD.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Recursive delete Re_iD.txt in ${EnvironmentData().sysHomeDir}/log/tmn}");
            }
            await TmnEjMake.tmnEJMakeStartEnd( tid, kind, 1 );
            return (errNo);
          }
          else{
  					errNo = DlgConfirmMsgKind.MSG_SALE_UPDERR.dlgId;
          }

          /* Re_QP.txt or Re_iD.txt Delete & ReName*/
          if(tranType == 0){
            utSaleInfo.resultCode = 0;
            errNo = DlgConfirmMsgKind.MSG_UT1_NOT_DAILYPROC.dlgId;
            TmnEjMake.tmnEjTxtMake( 1, 2, 0, 0, 0, '');
              deleteFilesRecursively("${EnvironmentData().sysHomeDir}/log/tmn", "Re_QP.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Recursive delete Re_QP.txt in ${EnvironmentData().sysHomeDir}/log/tmn}");
          }
          else if(tranType == 2)
          {
            /* Edyの場合、この処理は不要 (今後ut_proc_daily_deleteを行う事がある場合を考慮して実装) */
            utSaleInfo.resultCode = 0;
            errNo = DlgConfirmMsgKind.MSG_UT1_NOT_DAILYPROC.dlgId;
            TmnEjMake.tmnEjTxtMake( 5, 2, 0, 0, 0, '');
              deleteFilesRecursively("${EnvironmentData().sysHomeDir}/log/tmn", "Re_Edy.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Recursive delete Re_Edy.txt in ${EnvironmentData().sysHomeDir}/log/tmn}");
          }
          else{
            utSaleInfo.resultCode = 0;
            errNo = DlgConfirmMsgKind.MSG_UT1_NOT_DAILYPROC.dlgId;
            TmnEjMake.tmnEjTxtMake( 3, 2, 0, 0, 0, '');
              deleteFilesRecursively("${EnvironmentData().sysHomeDir}/log/tmn", "Re_iD.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Recursive delete Re_iD.txt in ${EnvironmentData().sysHomeDir}/log/tmn}");
          }

          if(tranType == 0){
            fileName = "${EnvironmentData().sysHomeDir}/log/tmn/ng_Re_QP.txt";
          }
          else if(tranType == 2)
          {
            /* Edyの場合、この処理は不要 (今後ut_proc_daily_deleteを行う事がある場合を考慮して実装) */
            fileName = "${EnvironmentData().sysHomeDir}/log/tmn/ng_Re_Edy.txt";
          }
          else{
            fileName = "${EnvironmentData().sysHomeDir}/log/tmn/ng_Re_iD.txt";
          }

          fp3 = TprxPlatform.getFile(fileName);
          if(fp3.existsSync())
          {
            if(tranType == 0) {
              renameFile(fp3, "Re_QP.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Rename file name ng_Re_QP to Re_QP.txt");
            } else if(tranType == 2)
            {
              /* Edyの場合、この処理は不要 (今後ut_proc_daily_deleteを行う事がある場合を考慮して実装) */
              renameFile(fp3, "Re_Edy.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Rename file name ng_Re_Edy to Re_Edy.txt");
            } else {
              renameFile(fp3, "Re_iD.txt");
              TprLog().logAdd(tid, LogLevelDefine.normal, "Rename file name ng_Re_iD to Re_iD.txt");
            }
          }
          break;
        }
      }
    }
    await TmnEjMake.tmnEJMakeStartEnd( tid, kind, 1 );
    return errNo;
  }

  /// 関連tprxソース:TmnDaily_Trn.c - ut_proc_daily
  static Future<int> utProcDaily(int tid, int tranType) async {
    int errNo;
    int typ;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "rxTaskStatRead error");
      return 0;
    }
    pStat = xRet.object;
    errNo = 0;
    typ = 0;
    if(tranType == 0) {
      typ = 1;
    } else if(tranType == 2) {
      typ = 5;
    } else {
      typ = 3;
    }
    switch (FclProcNo.getDefine(pStat.multi.order)) {
      case FclProcNo.OCX_D_START:
        await Future.delayed(const Duration(seconds: 1));
        errNo = await utProcDaily(tid, tranType);
        break;
      case FclProcNo.OCX_D_END:
        pStat.multi.order = FclProcNo.FCL_NOT_ORDER.index;
        await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
        TmnEjMake.tmnEjTxtMake( typ, 0, 0, 0, 0, '');
        TprLog().logAdd(tid, LogLevelDefine.normal, "ut_proc_daily  pStat.multi.order = OCX_D_END" );
        break;
      case	FclProcNo.FCL_NOT_ORDER:
        TprLog().logAdd(tid, LogLevelDefine.normal, "ut_proc_daily  pStat.multi.order = FCL_NOT_ORDER" );
        if(pStat.multi.errCd != 0){
          TprLog().logAdd(tid, LogLevelDefine.normal, "ut_proc_daily  pStat.multi.errCd" );
          utSaleInfo.seqNo = pStat.multi.fclData.sndData.printNo;
          utSaleInfo.resultCode = pStat.multi.fclData.resultCode;
          utSaleInfo.resultCodeExtended = pStat.multi.fclData.resultCodeExtended;
          utSaleInfo.centerResultCode = pStat.multi.fclData.centerResultCode;
          errNo = ut1ErrChk(tid);
          TmnEjMake.tmnEjTxtMake( typ, 1, utSaleInfo.seqNo, utSaleInfo.resultCode, utSaleInfo.resultCodeExtended, utSaleInfo.centerResultCode);
        }
        break;
      default:
        break;

    }
    return errNo;
  }

  /// 関連tprxソース:TmnDaily_Trn.c - ut_proc_daily_delete
  static Future<int> utProcDailyDelete(int tid, int tranType) async {
    int errNo;
    int typ;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "utProcDailyDelete rxMemPtr() ERROR");
      return 0;
    }
    pStat = xRet.object;


    errNo = 0;
    typ = 0;
    if (tranType == 0) {
      typ = 0;
    } else if(tranType == 2) {
      typ = 4;
    } else {
      typ = 2;
    }
    switch (FclProcNo.getDefine(pStat.multi.order)) {
      case FclProcNo.OCX_D_START:
        await Future.delayed(const Duration(seconds: 1));
        errNo = await utProcDailyDelete(tid, tranType);
        break;
      case FclProcNo.OCX_D_END:
        pStat.multi.order = FclProcNo.FCL_NOT_ORDER.index;
        await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, pStat, RxMemAttn.MAIN_TASK, "");
        utSaleInfo.seqNo = pStat.multi.fclData.sndData.printNo;
        if(pStat.multi.fclData.result != 0){
          TprLog().logAdd(tid, LogLevelDefine.normal, "ut_proc_daily_delete  pStat.multi.fclData.result" );
        }
        else{
          TprLog().logAdd(tid, LogLevelDefine.normal, "ut_proc_daily_delete  pStat.multi.order = OCX_D_END" );
        }
        TmnEjMake.tmnEjTxtMake( typ, 0, utSaleInfo.seqNo, 0, 0, '');
        break;
      case FclProcNo.FCL_NOT_ORDER:
        if(pStat.multi.errCd != 0){
          TprLog().logAdd(tid, LogLevelDefine.normal, "ut_proc_daily_delete  pStat.multi.errCd" );
          utNgFilewrite(tid, tranType);
          utSaleInfo.seqNo = pStat.multi.fclData.sndData.printNo;
          utSaleInfo.resultCode = pStat.multi.fclData.resultCode;
          utSaleInfo.resultCodeExtended = pStat.multi.fclData.resultCodeExtended;
          utSaleInfo.centerResultCode = pStat.multi.fclData.centerResultCode;
          errNo = ut1ErrChk(tid);
          TmnEjMake.tmnEjTxtMake( typ, 2, utSaleInfo.seqNo, utSaleInfo.resultCode, utSaleInfo.resultCodeExtended, utSaleInfo.centerResultCode);
        }
        break;
      default:
        break;
    }
    return errNo;
  }

  /// 関連tprxソース:TmnDaily_Trn.c - ut_ng_filewrite
  static void utNgFilewrite(int tid, int tranType)
  {
    String seqNo = pStat.multi.fclData.sndData.printNo.toString().padLeft(9, "0");
     seqNo += "\n";
    if(pStat.multi.fclData.sndData.printNo != 0){
      if(tranType == 0) {
        FileCpy.rxUTFileWrite(tid, seqNo, 0, 1);
      } else {
        FileCpy.rxUTFileWrite(tid, seqNo, 1, 1);
      }
    }
  }

  /// 関連tprxソース:TmnDaily_Trn.c - ut1_err_chk
  static int ut1ErrChk(int tid)
  {
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "pwoffmain_UT1_close rxMemPtr() ERROR");
      return 0;
    }
    pStat = xRet.object;

    switch(pStat.multi.errCd)
    {
      case Fcl.FCL_NORMAL:
        errNo = Typ.OK;
        break;
      case Fcl.FCL_SENDERR:
        errNo = DlgConfirmMsgKind.MSG_TELEGRAGHERR.dlgId;
        break;
      case Fcl.FCL_OFFLINE:
        errNo = DlgConfirmMsgKind.MSG_OFFLINE.dlgId;
        break;
      case Fcl.FCL_TIMEOUT:
        errNo = DlgConfirmMsgKind.MSG_TIMEOVER.dlgId;
        break;
      case Fcl.FCL_RETRYERR:
        errNo = DlgConfirmMsgKind.MSG_RETRYERR.dlgId;
        break;
      case Fcl.FCL_BUSY:
        errNo = DlgConfirmMsgKind.MSG_ACTIONERR.dlgId;
        break;
      case Fcl.FCL_SYSERR:
        errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
      case Fcl.FCL_CODEERR:
        errNo = DlgConfirmMsgKind.MSG_RECEIVEER.dlgId;
        break;
      case Fcl.FCL_RESERR:
      case Fcl.FCL_OCXERR:
        errNo = UtMsgLib.SetUtResErr(tid, 0, 0);
        break;
      case Fcl.FCL_INITCOMM:
        errNo = DlgConfirmMsgKind.MSG_INITCOMM.dlgId;
        break;
      case Fcl.FCL_NONINITCOMM:
        errNo = DlgConfirmMsgKind.MSG_NONINITCOMM.dlgId;
        break;
      default:
        errNo = DlgConfirmMsgKind.MSG_SYSERR.dlgId;
        break;
    }
    return errNo;
  }

  /// 機能：ディレクトリ配下を再帰的に操作してファイルを削除
  /// 引数：String dirName
  ///      String fileName
  /// 処理の共通化のため新規追加
  static void deleteFilesRecursively(String dirName, String fileName) {
    Directory targetDir = Directory(dirName);
    for (FileSystemEntity file in targetDir.listSync(recursive: true, followLinks: true)) {
      if (basename(file.path) == fileName) {
        file.deleteSync();
      }
    }
  }

  /// 機能：ファイル名を変更
  /// 引数：FileSystemEntity targetFile
  ///      String newFileName
  /// 処理の共通化のため新規追加
  static void renameFile(FileSystemEntity targetFile, String newFileName) {
    int sepalator = targetFile.path.lastIndexOf(Platform.pathSeparator);
    targetFile.renameSync(targetFile.path.substring(0, sepalator + 1) + newFileName);
  }
}