/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../common/environment.dart';
import '../../inc/lib/L_AplLib.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/mm_reptlib_def.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../cm_ej/cm_ejlib.dart';

import 'apllib_strutf.dart';
import 'mm_reptlib.dart';

class TmnEjMake {
  static int cnt = 0;
  static File? fpEj;
  static File? fpPrn;
  static TprMID tid = 0;

  /// 引数：mode 0:メンテナンス日計処理　1：閉設日計処理
  ///    	 flg 0:Start 1:End
  /// 戻値：0:異常　　１：正常
  /// 関連tprxソース: TmnEj_Make.c - Tmn_EJ_Make_Start_End
  static Future<int> tmnEJMakeStartEnd(TprMID src, int mode, int flg) async {
    String ejPath;
    String prnPath;
    int ret;
    String log;
    String ej_data = '';
    BatReptInfo reptDat = BatReptInfo();

    log = "Tmn_EJ_Make_Start_End : mode[$mode], flg[$flg]";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);
    if (fpEj != null) {
      if (flg != 0) {
        try {
          MmReptlib.fillPrintEj(fpEj!, '-');
          MmReptlib.printStringEj(fpEj!, MmReptlibDef.MMREPT_RCT_END);
        } catch (e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "Tmn_EJ_Make_Start_End : ej file open Error,$e,$s");
        }
      }
      fpEj = null;
    }
    if (fpPrn != null) {
      fpPrn = null;
    }

    ejPath =
        "${EnvironmentData.TPRX_HOME}${CmEj.EJ_WORK_DIR}${CmEj.EJ_WORK_FILE}";
    prnPath =
        "${EnvironmentData.TPRX_HOME}${CmEj.EJ_WORK_DIR}${AplLib.EJ_TMN_PRN_FILE}";
    final File prnFile = File(prnPath);

    if (flg == 0) {
      /* Start */
      tid = src;
      cnt = 0;
      if (prnFile.existsSync()) {
        prnFile.deleteSync();
      }
      reptDat.batReport.batch_report_no = ReptNumber.MMREPT132.index; //現在売価
      reptDat.batchFlg = 9; //設定
      reptDat.kind = 0;
      reptDat.reptFlg = 4;
      ret =
          await MmReptlib().headprintEj(9, ReptNumber.MMREPT187.index) ? 0 : 1;
      if (ret != 0) {
        log = "Tmn_EJ_Make_Start_End : EJ Head Error!";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        return 0;
      }
      fpEj = File(ejPath);
      if (!fpEj!.existsSync()) {
        ///TODO　errno取得方法
        // log = "Tmn_EJ_Make_Start_End : ej file open Error[$errno]";
        log = "Tmn_EJ_Make_Start_End : ej file open Error[]";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        return 0;
      }
      ej_data = ej_data.padLeft(AplLib.EJ_LENGTH * 2 + 1, ' ');
      if (mode == 1) {
        ej_data = ej_data.replaceFirst(
            ''.padLeft(LAplLib.APLLIB_TMN_STITLE.length, ' '),
            LAplLib.APLLIB_TMN_STITLE,
            15);
        ej_data = ej_data.trimRight();
        try {
          MmReptlib.printStringEj(fpEj!, ej_data);
        } catch (e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "Tmn_EJ_Make_Start_End : ej file open Error,$e,$s");
        }
        fpPrn = File(prnPath);
        try {
          if (fpPrn != null) {
            ej_data = "     ${LAplLib.APLLIB_TMN_STITLE}";
            MmReptlib.printStringEj(fpPrn!, ej_data);
          } else {
            ///TODO　errno取得方法
            // log = "Tmn_EJ_Make_Start_End : prn file open Error[$errno]";
            log = "Tmn_EJ_Make_Start_End : prn file open Error[]";
            TprLog().logAdd(tid, LogLevelDefine.error, log);
          }
        } catch (e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "Tmn_EJ_Make_Start_End : prn file open Error,$e,$s");
        }
      } else {
        ej_data = ej_data.replaceFirst(
            ''.padLeft(LAplLib.APLLIB_TMN_MTITLE.length, ' '),
            LAplLib.APLLIB_TMN_MTITLE,
            15);
        ej_data = ej_data.trimRight();
        try {
          MmReptlib.printStringEj(fpEj!, ej_data);
        } catch (e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "Tmn_EJ_Make_Start_End : ej file open Error,$e,$s");
        }
      }
    } else {
      /* End */
      ret = await EjLib().cmEjOther();
      if (ret == 0) {
        await MmReptlib.countUp();
      } else {
        log = "cm_ejother() error : $ret";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
      }
      if ((cnt == 0) || (mode == 0)) {
        if (prnFile.existsSync()) {
          prnFile.deleteSync();
        }
      }
      cnt = 0;
    }
    return 1;
  }

  /// EJ、閉設印字用ファイル作成
  /// 引数：
  ///   typ
  ///   TMN_OBS_DEAL_QP	:QP不明取引
  ///   TMN_DAILY_QP	:QP日計処理
  ///   TMN_OBS_DEAL_iD	:iD不明取引
  ///   TMN_DAILY_iD	:iD日計処理
  ///       TMN_OBS_DEAL_Edy:Edy不明取引
  ///       TMN_DAILY_Edy   :Edy日計処理
  ///   result		実行結果  0:正常　1：異常 　2：中止
  ///   code		結果コード１(resultcode)
  ///   extendCode	結果コード２(resultcode_extend)
  ///   centerCode	結果コード３(center_resultcode)
  /// 戻り値:  0:異常　　１：正常
  /// 関連tprxソース:TmnEj_Make.c - Tmn_EJTxt_Make
  static int tmnEjTxtMake(int typ, int result, int sequence, int code,
      int extendCode, String centerCode) {
    String prnData = "";
    String ejData = "";
    String wData = "";
    int ejSize = 50;
    int prnSize = 32;
    int kanaCnt = 0;
    int prnMake = 1;

    if (fpPrn == null) {
      prnMake = 0;
    }

    switch (TMN_EJ_TYP.values.firstWhere((element) => element.index == typ)) {
      case TMN_EJ_TYP.TMN_OBS_DEAL_QP:
      case TMN_EJ_TYP.TMN_DAILY_QP:
        if (cnt == 0) {
          wData =
              "${LAplLib.APLLIB_TMN_AST}${LAplLib.APLLIB_TMN_QP_TITILE}${LAplLib.APLLIB_TMN_AST}";
          ejData = "   $wData   ";
          ejData += "\n";
          if (fpEj != null && fpEj!.existsSync()) {
            try {
              MmReptlib.printStringEj(fpEj!, ejData);
            } on FileSystemException catch (e, s) {
              TprLog().logAdd(tid, LogLevelDefine.error,
                  "tmnEjTxtMake : ej file write Error,$e,$s");
            }
          }
          if (typ == TMN_EJ_TYP.TMN_OBS_DEAL_QP.index) {
            cnt++;
            if (fpPrn != null && fpPrn!.existsSync()) {
              try {
                fpPrn!.writeAsStringSync("${LAplLib.APLLIB_TMN_QP_TITILE}\n",
                    mode: FileMode.append);
              } catch (e, s) {
                TprLog().logAdd(tid, LogLevelDefine.error,
                    "tmnEjTxtMake : prn file write Error,$e,$s");
              }
            }
          }
        }
        break;
      case TMN_EJ_TYP.TMN_OBS_DEAL_iD:
      case TMN_EJ_TYP.TMN_DAILY_iD:
        if (cnt == 0) {
          wData =
              "${LAplLib.APLLIB_TMN_AST}${LAplLib.APLLIB_TMN_iD_TITILE}${LAplLib.APLLIB_TMN_AST}";
          ejData = "   $wData   ";
          if (fpEj != null && fpEj!.existsSync()) {
            try {
              MmReptlib.printStringEj(fpEj!, ejData);
            } catch (e, s) {
              TprLog().logAdd(tid, LogLevelDefine.error,
                  "tmnEjTxtMake : ej file write Error,$e,$s");
            }
          }
          if (typ == TMN_EJ_TYP.TMN_OBS_DEAL_iD.index) {
            cnt++;
            if (fpPrn != null && fpPrn!.existsSync()) {
              try {
                fpPrn!.writeAsStringSync("${LAplLib.APLLIB_TMN_iD_TITILE}\n",
                    mode: FileMode.append);
              } catch (e, s) {
                TprLog().logAdd(tid, LogLevelDefine.error,
                    "tmnEjTxtMake : prn file write Error,$e,$s");
              }
            }
          }
        }
        break;
      case TMN_EJ_TYP.TMN_OBS_DEAL_Edy:
      case TMN_EJ_TYP.TMN_DAILY_Edy:
        if (cnt == 0) {
          wData =
              "${LAplLib.APLLIB_TMN_AST}${LAplLib.APLLIB_TMN_Edy_TITILE}${LAplLib.APLLIB_TMN_AST}";
          ejData = "   $wData   ";
          if (fpEj != null && fpEj!.existsSync()) {
            try {
              MmReptlib.printStringEj(fpEj!, ejData);
            } catch (e, s) {
              TprLog().logAdd(tid, LogLevelDefine.error,
                  "tmnEjTxtMake : ej file write Error,$e,$s");
            }
          }
          if (typ == TMN_EJ_TYP.TMN_OBS_DEAL_Edy.index) {
            cnt++;
            if (fpPrn != null && fpPrn!.existsSync()) {
              try {
                fpPrn!.writeAsStringSync("${LAplLib.APLLIB_TMN_Edy_TITILE}\n",
                    mode: FileMode.append);
              } catch (e, s) {
                TprLog().logAdd(tid, LogLevelDefine.error,
                    "tmnEjTxtMake : prn file write Error,$e,$s");
              }
            }
          }
        }
        break;
      default:
        TprLog().logAdd(
            tid, LogLevelDefine.error, "Tmn_EJTxt_Make: type Error[$typ]");
        return 0;
    }
    switch (TMN_EJ_TYP.values.firstWhere((element) => element.index == typ)) {
      case TMN_EJ_TYP.TMN_DAILY_QP:
      case TMN_EJ_TYP.TMN_DAILY_iD:
      case TMN_EJ_TYP.TMN_DAILY_Edy:
        wData = "";
        if (typ == TMN_EJ_TYP.TMN_DAILY_QP.index) {
          List<int> bytes = utf8.encode(LAplLib.APLLIB_TMN_QP);
          final (int cnt, String afterData) =
              AplLibStrUtf.aplLibEucCopy(LAplLib.APLLIB_TMN_QP, bytes.length);
          wData = afterData;
          kanaCnt = cnt;
        } else if (typ == TMN_EJ_TYP.TMN_DAILY_Edy.index) {
          List<int> bytes = utf8.encode(LAplLib.APLLIB_TMN_Edy);
          final (int cnt, String afterData) =
              AplLibStrUtf.aplLibEucCopy(LAplLib.APLLIB_TMN_Edy, bytes.length);
          wData = afterData;
          kanaCnt = cnt;
        } else {
          List<int> bytes = utf8.encode(LAplLib.APLLIB_TMN_ID);
          final (int cnt, String afterData) =
              AplLibStrUtf.aplLibEucCopy(LAplLib.APLLIB_TMN_ID, bytes.length);
          wData = afterData;
          kanaCnt = cnt;
        }
        ejData = "   $wData";
        if (result == 0) {
          final resultAdj =
              AplLibStrUtf.aplLibEucCopy(LAplLib.APLLIB_DEAIL_RET_OK, 80);
          // APLLIB_TMN_*とAPLLIB_DEAIL_RET_*の全角文字数を保持
          kanaCnt +=
              (AplLibStrUtf.aplLibEntCnt(resultAdj.$2) - resultAdj.$2.length);
          ejData =
              "$ejData${resultAdj.$2.padLeft(ejSize - kanaCnt - ejData.length, " ")}";
        } else if (result == 1) {
          final resultAdj =
              AplLibStrUtf.aplLibEucCopy(LAplLib.APLLIB_DEAIL_RET_NG, 80);
          kanaCnt +=
              (AplLibStrUtf.aplLibEntCnt(resultAdj.$2) - resultAdj.$2.length);
          ejData =
              "$ejData${resultAdj.$2.padLeft(ejSize - kanaCnt - ejData.length, " ")}";
        } else {
          final resultAdj =
              AplLibStrUtf.aplLibEucCopy(LAplLib.APLLIB_DEAIL_RET_CNCL, 80);
          kanaCnt +=
              (AplLibStrUtf.aplLibEntCnt(resultAdj.$2) - resultAdj.$2.length);
          // '   §ＱＰ日計処理| 34がいい　正常.padLeft(50-8-10=32)
          ejData =
              "$ejData${resultAdj.$2.padLeft(ejSize - kanaCnt - ejData.length, " ")}";
        }
        if (fpEj != null && fpEj!.existsSync()) {
          try {
            MmReptlib.printStringEj(fpEj!, ejData);
          } catch (e, s) {
            TprLog().logAdd(tid, LogLevelDefine.error,
                "tmnEjTxtMake : ej file write Error,$e,$s");
          }
        }
        if (result == 2) {
          return 1;
        }
        prnMake = 0;
        break;
      case TMN_EJ_TYP.TMN_OBS_DEAL_QP:
      case TMN_EJ_TYP.TMN_OBS_DEAL_iD:
      case TMN_EJ_TYP.TMN_OBS_DEAL_Edy:
        List<int> bytes = utf8.encode(LAplLib.APLLIB_TMN_SEQUENCE);
        final (int cnt, String afterData) = AplLibStrUtf.aplLibEucCopy(
            LAplLib.APLLIB_TMN_SEQUENCE, bytes.length);
        wData = afterData;
        kanaCnt = cnt;

        if (result != 0) {
          wData = "    ${sequence.toString().padLeft(9, "0")}  NG";
        } else {
          wData = "    ${sequence.toString().padLeft(9, "0")}  OK";
        }
        // TODO:00013 三浦 レシートのレイアウト突貫対応
        ejData = "   ${LAplLib.APLLIB_TMN_SEQUENCE}";
        ejData =
            "$ejData${wData.padLeft(ejSize + LAplLib.APLLIB_TMN_SEQUENCE.length - wData.length - 2, " ")}";
        if (fpEj != null && fpEj!.existsSync()) {
          try {
            MmReptlib.printStringEj(fpEj!, ejData);
          } catch (e, s) {
            TprLog().logAdd(tid, LogLevelDefine.error,
                "tmnEjTxtMake : ej file write Error,$e,$s");
          }
        }
        if (fpPrn != null) {
          wData = "";
          if (result != 0) {
            wData = "      ${sequence.toString().padLeft(9, "0")}  NG";
          } else {
            wData = "      ${sequence.toString().padLeft(9, "0")}  OK";
          }
          // TODO:00013 三浦 レシートのレイアウト突貫対応
          prnData = LAplLib.APLLIB_TMN_SEQUENCE;
          prnData =
              "$prnData${wData.padLeft(prnSize + LAplLib.APLLIB_TMN_SEQUENCE.length - wData.length + 3, " ")}";
          try {
            fpPrn!.writeAsStringSync("$prnData\n", mode: FileMode.append);
          } catch (e, s) {
            TprLog().logAdd(tid, LogLevelDefine.error,
                "tmnEjTxtMake : prn file write Error,$e,$s");
          }
        }
        break;
    }
    if (result == 0) {
      return 1;
    }

    if (code != 0) {
      wData = code.toString().padLeft(3, "0");
      ejData = "       ${LAplLib.APLLIB_TMN_CODE1}";
      ejData = "$ejData${wData.padLeft(ejSize - ejData.length - 4, " ")}    ";
      if (fpEj != null && fpEj!.existsSync()) {
        try {
          MmReptlib.printStringEj(fpEj!, ejData);
        } catch (e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "tmnEjTxtMake : ej file write Error,$e,$s");
        }
      }
      if (prnMake != 0) {
        prnData = " ${LAplLib.APLLIB_TMN_CODE1}";
        prnData = "$prnData${wData.padLeft(prnSize - prnData.length - 3)}   ";
        if (fpPrn != null && fpPrn!.existsSync()) {
          try {
            fpPrn!.writeAsStringSync("$prnData\n", mode: FileMode.append);
          } catch (e, s) {
            TprLog().logAdd(tid, LogLevelDefine.error,
                "tmnEjTxtMake : prn file write Error,$e,$s");
          }
        }
      }
    }
    if (extendCode != 0) {
      wData = extendCode.toString().padLeft(9, "0");
      ejData = "       ${LAplLib.APLLIB_TMN_CODE2}";
      ejData = "$ejData${wData.padLeft(ejSize - ejData.length - 4, " ")}    ";
      if (fpEj != null && fpEj!.existsSync()) {
        try {
          MmReptlib.printStringEj(fpEj!, ejData);
        } catch (e, s) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              "tmnEjTxtMake : ej file write Error,$e,$s");
        }
      }
      if (prnMake != 0) {
        prnData = " ${LAplLib.APLLIB_TMN_CODE2}";
        prnData = "$prnData${wData.padLeft(prnSize - prnData.length - 3)}   ";
        if (fpPrn != null && fpPrn!.existsSync()) {
          try {
            fpPrn!.writeAsStringSync("$prnData\n", mode: FileMode.append);
          } catch (e, s) {
            TprLog().logAdd(tid, LogLevelDefine.error,
                "tmnEjTxtMake : prn file write Error,$e,$s");
          }
        }
      }
    }

    if (centerCode != null) {
      List<int> bytes = utf8.encode(centerCode);
      final (int cnt, String afterData) =
          AplLibStrUtf.aplLibEucCopy(centerCode, bytes.length);
      wData = afterData;
      kanaCnt = cnt;

      if (wData.isNotEmpty) {
        ejData = "       ${LAplLib.APLLIB_TMN_CODE3}";
        ejData =
            "$ejData${wData.padLeft(50 - ejData.length - kanaCnt - 4, " ")}    ";
        if (fpEj != null && fpEj!.existsSync()) {
          try {
            MmReptlib.printStringEj(fpEj!, ejData);
          } catch (e, s) {
            TprLog().logAdd(tid, LogLevelDefine.error,
                "tmnEjTxtMake : ej file write Error,$e,$s");
          }
        }
        if (prnMake != 0) {
          prnData = " ${LAplLib.APLLIB_TMN_CODE3}";
          prnData =
              "$prnData${wData.padLeft(prnSize - prnData.length - 3, " ")}   ";
          if (fpPrn != null && fpPrn!.existsSync()) {
            try {
              fpPrn!.writeAsStringSync("$prnData\n", mode: FileMode.append);
            } catch (e, s) {
              TprLog().logAdd(tid, LogLevelDefine.error,
                  "tmnEjTxtMake : prn file write Error,$e,$s");
            }
          }
        }
      }
    }
    return 1;
  }

  /// 関連tprxソース:TmnEj_Make.c - Ut_MsgDisp
  static void utMsgDisp(
      int errCode,
      MsgDialogType dialogType,
      Function leftFunction,
      String leftText,
      Function rightFunction,
      String rightText,
      String addMsg) {

    // エラーダイアログの表示.
    MsgDialog.show(MsgDialog.twoButtonDlgId(
      type: dialogType,
      dialogId: errCode,
      footerMessage: addMsg,
      leftBtnTxt: leftText,
      leftBtnFnc: () {
        Get.back();
        leftFunction.call();
      },
      rightBtnTxt: rightText,
      rightBtnFnc: () {
        Get.back();
        rightFunction.call();
      },
    ));
  }

  // ボタンの結果確認
  static bool buttonConfirm = false;

  // Ut1日計処理時のエラーダイアログ
  static Future<void> ut1ErrDialog (
      int errCode,
      MsgDialogType dialogType,
      String leftText,
      String rightText,
      String addMsg) async {

    // エラーダイアログの表示.
    buttonConfirm = await MsgDialog.showConfirm(MsgDialog.twoButtonDlgId(
      type: dialogType,
      dialogId: errCode,
      footerMessage: addMsg,
      leftBtnTxt: leftText,
      leftBtnFnc: () {
        Get.back(result: true);
      },
      rightBtnTxt: rightText,
      rightBtnFnc: () {
        Get.back(result: false);
      },
    ));
  }
}
