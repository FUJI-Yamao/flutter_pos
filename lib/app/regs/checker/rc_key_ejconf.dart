/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/if_th/if_th_creadsts.dart';
import '../../ui/page/EJConfirmation/basepage/p_ejconf_receipt_basepage.dart';
import '../../ui/page/common/component/w_msgdialog.dart';

///　「記録確認」画面表示項目
class EjConfRet {
  /// レシート番号　画面タイトル部の「R+4桁数値」
  String receiptNo = '';
  /// ジャーナル番号　画面タイトル部の「J+4桁数値」
  String printNo = '';
  /// 売上時間　画面タイトル部の日時
  String saleDatetime = '';
  /// メインデータ
  List<String> printData = [];
}

///　「記録確認」画面検索条件
class EjConfQuery {
  /// 「記録確認」画面検索条件；日付　YYYY-MM-DD
  String qDate = '';
  /// 「記録確認」画面検索条件；時間（from）HH24MI（半角4桁0～9からなる文字列）
  String qTimeFrom = '';
  /// 「記録確認」画面検索条件；時間（to）HH24MI（半角4桁0～9からなる文字列）
  String qTimeTo = '';
  /// 「記録確認」画面検索条件；レジ指定
  String qMachine = '';
}

///　「記録確認」処理
/// 関連tprxソース:なし、新作処理（既存のrcky_ejconf.cと関連性なし）
class RcKeyEjConf {
  /// 「記録確認」画面表示用　直近営業日　YYYY-MM-DD
  String presSaleDate = '';
  /// 「記録確認」内部処理用　現在表示中のデータの取引発生日時　YYYY-MM-DD HH24:MI:SS
  String orgSaleDatetime = '';
  /// 「記録確認」画面表示項目の格納変数
  EjConfRet ejConfRet = EjConfRet();
  /// 印字される時、一番上に表示させるログ
  static const String logo = "@bitmap@Logo/receipt.bmp@/bitmap@";


  /// 記録確認画面を開く
  /// 関連tprxソース: rcky_ejconf.c
  static void openRecordConfirmation(String title) {
    // 登録商品確認
    if (RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId,
          type: MsgDialogType.error,
        ),
      );
    } else {
      // 記録確認画面
      Get.to(() => EJConfirmationScreen(title: title));
    }
  }

  ///  クラス内部処理：画面データの取り出し（SQL検索結果から画面表示項目の格納変数へ）
  void retSet (Map<String, dynamic> data) {
    ejConfRet.printNo = 'J${(data["print_no"].toString()).padLeft(4, '0')}';
    ejConfRet.receiptNo = 'R${(data["receipt_no"].toString()).padLeft(4, '0')}';
    initializeDateFormatting('ja');
    orgSaleDatetime = data["now_sale_datetime"].toString().substring(0, 19);
    String tmpDT = DateFormat.yMMMMEEEEd('ja').format(DateTime.parse(orgSaleDatetime)).toString();
    ejConfRet.saleDatetime = '${tmpDT.substring(0, tmpDT.length - 3)}(${tmpDT.substring(tmpDT.length - 3, tmpDT.length - 2)})　${orgSaleDatetime.substring(11,16)}';
    ejConfRet.printData = List<String>.from(LineSplitter.split(data["print_data"].toString()));
    return;
  }

  ///　記録確認 - 初期表示処理
  Future<(bool, String)> getEjRecInit() async {
    ejConfRet = EjConfRet();
    try {
      var db = DbManipulationPs();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "getRecordInit : rxMemRead error");
        return (false, "rxMemRead error");
      }
      RxCommonBuf pCom = xRet.object;

      CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
          0, CompetitionIniLists.COMPETITION_INI_SALE_DATE,
          CompetitionIniType.COMPETITION_INI_GETSYS);
      presSaleDate =
          ret.value.substring(0, 4) + '-' + ret.value.substring(5, 7) + '-' +
              ret.value.substring(8, 10);

      String sql1 = "SELECT print_no, receipt_no, now_sale_datetime, STRING_AGG(print_data,'') AS print_data "
                    "FROM (SELECT * "
                      "FROM c_ej_log WHERE now_sale_datetime = (SELECT MAX(now_sale_datetime) "
                        "FROM (SELECT * "
                          "FROM c_ej_log WHERE comp_cd = @p1 AND stre_cd = @p2 AND "
                                              "mac_no = @p3 AND TO_CHAR(sale_date, 'YYYY-MM-DD') = @p4) AS t_day)) AS t_disp "
                    "GROUP BY print_no, receipt_no, now_sale_datetime";
      Map<String, dynamic>? subValues = {
        "p1": pCom.dbRegCtrl.compCd,
        "p2": pCom.dbRegCtrl.streCd,
        "p3": pCom.dbRegCtrl.macNo,
        "p4": presSaleDate
      };
      Result mstList = await db.dbCon.execute(
          Sql.named(sql1), parameters: subValues);

      if (mstList.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "getRecordInit : no sale data[comp_cd(${pCom.dbRegCtrl.compCd}), stre_cd(${pCom.dbRegCtrl.streCd}), mac_no(${pCom.dbRegCtrl.macNo}), presSaleDate($presSaleDate)]");
        // 取引なし
        return (false, "no sale data");
      }

      retSet(mstList[0].toColumnMap());
    } catch (e, s) {
      // DBエラーなど.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "RecordConfirmation  DB err. $e $s");
      // 空のリスト.
      return (false, "DB Error");
    }
    return (true, "");
  }

  ///　記録確認 - 「前の記録」ボタン押下処理
  Future<(bool, String)> getEjPrevRec() async {
    try {
      var db = DbManipulationPs();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "getRecordInit : rxMemRead error");
        return (false, "rxMemRead error");
      }
      RxCommonBuf pCom = xRet.object;

      String sql1 = "SELECT print_no, receipt_no, now_sale_datetime, STRING_AGG(print_data,'') AS print_data "
                    "FROM (SELECT * "
                      "FROM c_ej_log WHERE now_sale_datetime = (SELECT MAX(now_sale_datetime) "
                        "FROM (SELECT * "
                          "FROM c_ej_log WHERE comp_cd = @p1 AND stre_cd = @p2 AND mac_no = @p3 AND "
                                              "TO_CHAR(sale_date, 'YYYY-MM-DD') = @p4 AND "
                                              "TO_CHAR(now_sale_datetime, 'YYYY-MM-DD HH24:MI:SS') < @p5) AS t_day)) AS t_disp "
                    "GROUP BY print_no, receipt_no, now_sale_datetime";
      Map<String, dynamic>? subValues = {
        "p1": pCom.dbRegCtrl.compCd,
        "p2": pCom.dbRegCtrl.streCd,
        "p3": pCom.dbRegCtrl.macNo,
        "p4": presSaleDate,
        "p5": orgSaleDatetime
      };
      Result mstList = await db.dbCon.execute(
          Sql.named(sql1), parameters: subValues);

      if (mstList.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "getEjPrevRec : no sale data[comp_cd(${pCom.dbRegCtrl.compCd}), stre_cd(${pCom.dbRegCtrl.streCd}), mac_no(${pCom.dbRegCtrl.macNo}), orgSaleDatetime($orgSaleDatetime)]");
        // 取引なし
        ejConfRet = EjConfRet();
        ejConfRet.receiptNo = '   No';
        ejConfRet.printNo = 'Data';
        return (false, "no sale data");
      }

      retSet(mstList[0].toColumnMap());
    } catch (e, s) {
      // DBエラーなど.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "RecordConfirmation  DB err. $e $s");
      // 空のリスト.
      return (false, "DB Error");
    }
    return (true, "");
  }

  ///　記録確認 - 「後の記録」ボタン押下処理
  Future<(bool, String)> getEjNextRec() async {
    try {
      var db = DbManipulationPs();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "getRecordInit : rxMemRead error");
        return (false, "rxMemRead error");
      }
      RxCommonBuf pCom = xRet.object;

      String sql1 = "SELECT print_no, receipt_no, now_sale_datetime, STRING_AGG(print_data,'') AS print_data "
                    "FROM (SELECT * "
                      "FROM c_ej_log WHERE now_sale_datetime = (SELECT MIN(now_sale_datetime) "
                        "FROM (SELECT * "
                          "FROM c_ej_log WHERE comp_cd = @p1 AND stre_cd = @p2 AND "
                                              "mac_no = @p3 AND TO_CHAR(sale_date, 'YYYY-MM-DD') = @p4 AND "
                                              "TO_CHAR(now_sale_datetime, 'YYYY-MM-DD HH24:MI:SS') > @p5) AS t_day)) AS t_disp "
                    "GROUP BY print_no, receipt_no, now_sale_datetime";
      Map<String, dynamic>? subValues = {
        "p1": pCom.dbRegCtrl.compCd,
        "p2": pCom.dbRegCtrl.streCd,
        "p3": pCom.dbRegCtrl.macNo,
        "p4": presSaleDate,
        "p5": orgSaleDatetime
      };
      Result mstList = await db.dbCon.execute(
          Sql.named(sql1), parameters: subValues);

      if (mstList.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "getEjNextRec : no sale data[comp_cd(${pCom.dbRegCtrl.compCd}), stre_cd(${pCom.dbRegCtrl.streCd}), mac_no(${pCom.dbRegCtrl.macNo}), orgSaleDatetime($orgSaleDatetime)]");
        // 取引なし
        ejConfRet = EjConfRet();
        ejConfRet.receiptNo = '   No';
        ejConfRet.printNo = 'Data';
        return (false, "no sale data");
      }

      retSet(mstList[0].toColumnMap());
    } catch (e, s) {
      // DBエラーなど.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "RecordConfirmation  DB err. $e $s");
      // 空のリスト.
      return (false, "DB Error");
    }
    return (true, "");
  }

  ///　記録確認 - 指定条件での検索処理
  Future<(bool, String)> getEjSpecRec(EjConfQuery param) async {
    try {
      var db = DbManipulationPs();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "getRecordInit : rxMemRead error");
        return (false, "rxMemRead error");
      }
      RxCommonBuf pCom = xRet.object;

      String sql1 = "SELECT print_no, receipt_no, now_sale_datetime, STRING_AGG(print_data,'') AS print_data "
                    "FROM (SELECT * "
                      "FROM c_ej_log WHERE now_sale_datetime = (SELECT MAX(now_sale_datetime) "
                        "FROM (SELECT * "
                          "FROM c_ej_log WHERE comp_cd = @p1 AND stre_cd = @p2 AND mac_no = @p3 AND "
                                              "TO_CHAR(now_sale_datetime, 'YYYY-MM-DD HH24MI') >= @p4 AND "
                                              "TO_CHAR(now_sale_datetime, 'YYYY-MM-DD HH24MI') <= @p5) AS t_day)) AS t_disp "
                    "GROUP BY print_no, receipt_no, now_sale_datetime";
      /// SQL検索条件のqFromPart,qToPart書式　YYYY-MM-DD-HH24MI(例：2020-02-29-1701)
      String qFromPart = '${param.qDate == '' ? presSaleDate : param.qDate}-${param.qTimeFrom == '' ? '0000' : param.qTimeFrom}';
      String qToPart = '${param.qDate == '' ? presSaleDate : param.qDate}-${param.qTimeTo == '' ? '2359' : param.qTimeTo}';
      Map<String, dynamic>? subValues = {
        "p1": pCom.dbRegCtrl.compCd,
        "p2": pCom.dbRegCtrl.streCd,
        "p3": param.qMachine,
        "p4": qFromPart,
        "p5": qToPart
      };
      Result mstList = await db.dbCon.execute(
          Sql.named(sql1), parameters: subValues);

      if (mstList.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "getEjSpecRec : no sale data");
        // 取引なし
        return (false, "no sale data");
      }

      retSet(mstList[0].toColumnMap());
    } catch (e, s) {
      // DBエラーなど.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "RecordConfirmation  DB err. $e $s");
      // 空のリスト.
      return (false, "DB Error");
    }
    return (true, "");
  }

  ///　記録確認 - 印字ボタン押下処理
  Future<(bool, DlgConfirmMsgKind)> printPresEjRec(EjConfQuery param) async {
    String callFunc= 'printPresEjRec';
    if (ejConfRet.printData.isEmpty) {
      // 印字データが存在しない場合、エラーメッセージを返す
      return (false, DlgConfirmMsgKind.MSG_NONREG_ERR);
    }

    // 印字データを作成する処理
    final listForPrint = <String>[logo, ""];
    listForPrint.addAll(ejConfRet.printData);
    List<PayTRKReceiptImage> rcptImgList = List.generate(1, (_) => PayTRKReceiptImage(lineSpace:6, printType:"Line", cutType:"PartialCut", receiptLineList:listForPrint, pageParts:null));
    PayDigitalReceipt digitalReceipt = PayDigitalReceipt(transaction: PayTransaction(receiptDateTime: "", workstationID: "", receiptNumber:"", transactionID: "", receiptImage: null, retailTransaction:null, trkReceiptImageList: rcptImgList));

    // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
    await IfTh.printReceipt(Tpraid.TPRAID_CASH, digitalReceipt, callFunc, ejConfMode : true);

    int ret = await IfThCReadSts.ifThCReadStatus(Tpraid.TPRAID_STR);

    if (ret != 0) {
      return (false, DlgConfirmMsgKind.MSG_PRINTERERR);
    }
    return (true, DlgConfirmMsgKind.MSG_NONE);
  }
}
