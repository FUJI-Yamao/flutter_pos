/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../clxos/calc_api_data.dart';
import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../postgres_library/src/pos_basic_table_access.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/date_util.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../sys/report/batch_report.dart';
import '../../../component/c_scroll_button_and_bar_controller.dart';
import '../../common/component/w_msgdialog.dart';
import '../model/m_batch_report_info.dart';

/// 予約レポートの出力コントローラー
class BatchReportOutputController extends GetxController {

  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isScrollable = false.obs;
  /// スクロール動作用のコントローラー
  final ScrollButtonAndBarController batchReportScrollController = ScrollButtonAndBarController();
  /// 予約レポート情報
  final BatchReportInfo batchReportInfo = BatchReportInfo();
  /// 予約レポート詳細情報のリスト
  final RxList<BatchReportDetail> batchReportDetailList = <BatchReportDetail>[].obs;

  // onInit関数ではダイアログ表示できないので、onReady関数を使用する
  @override
  Future<void> onReady() async {
    super.onReady();

    DlgConfirmMsgKind dlgConfirmMsgKind = DlgConfirmMsgKind.MSG_NONE;

    while (true) {
      /// 共有メモリから必要な情報を取得する
      dlgConfirmMsgKind = await _memRead();
      if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
        break;
      }

      // DBアクセスのインスタンス取得
      DbManipulationPs db = DbManipulationPs();

      // レジ情報グループ管理マスタから予約レポートのグループコードを取得
      dlgConfirmMsgKind = await selectRegInfoGrpMst(db);
      if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
        break;
      }

      // 予約レポートマスタから予約レポート情報を取得
      dlgConfirmMsgKind = await selectBatRepoMst(db);
      if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
        break;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // スクロールボタン表示のフラグの切り替え
        checkFlagForDisplayingScrollButton();
      });

      // 正常終了
      break;
    }

    // エラーがあれば、ダイアログ表示する
    if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: dlgConfirmMsgKind.dlgId,
        ),
      );
    }
  }

  /// スクロールボタン表示のフラグの切り替え
  void checkFlagForDisplayingScrollButton() {
    // maxScrollExtentが0より大きい時にスクロールボタンを表示する
    isScrollable.value = batchReportScrollController.position.maxScrollExtent > 0;
  }

  /// 選択状態を反転させる
  void updateCheckState (int index) {
    batchReportDetailList[index].isChecked.value = !batchReportDetailList[index].isChecked.value;
  }

  /// 印字ボタン押下時の処理
  void onReport() {
    // 選択状態の確認
    if (batchReportDetailList.any((e) => e.isChecked.value == true)) {
      MsgDialog.show(
        MsgDialog.twoButtonDlgId(
          type: MsgDialogType.info,
          dialogId: DlgConfirmMsgKind.MSG_BATREPO_CONF.dlgId,
          rightBtnFnc: () {
            Get.back(); // MSG_BATREPO_CONFのダイアログを閉じる
            /// 予約レポートの印字処理
            _batchReport();
          },
          leftBtnTxt: 'いいえ',    // 「はい」と「いいえ」を表示する
        ),
      );
    } else {
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: '選択されていません',     // TODO:mm_dialogに登録する？
        ),
      );
    }
  }

  /// 共有メモリから必要な情報を取得する
  Future<DlgConfirmMsgKind> _memRead() async {
    // 共有メモリを取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      // システムエラー
      TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "BatchReportOutputController rxMemRead error");
      return DlgConfirmMsgKind.MSG_SYSERR;
    }
    RxCommonBuf pCom = xRet.object;

    // 共有メモリから必要な情報を取得
    batchReportInfo.compCd = pCom.iniMacInfoCrpNoNo;            // 企業番号
    batchReportInfo.streCd = pCom.iniMacInfoShopNo;             // 店舗番号
    batchReportInfo.macNo = pCom.iniMacInfoMacNo;               // マシン番号

    // 営業日は、yyyy-MM-dd から yyyy/MM/dd に変換する
    try {
      DateTime dateTime = DateUtil.getDateTime(pCom.iniCounter.tran.sale_date, DateUtil.formatDate);
      batchReportInfo.saleDate = DateUtil.getString(dateTime, DateUtil.formatDateSlash);
    } catch (e, s) {
      // システムエラー
      TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "date format error\n$e\n$s");
      return DlgConfirmMsgKind.MSG_SYSERR;
    }

    // 正常終了
    return DlgConfirmMsgKind.MSG_NONE;
  }

  /// レジ情報グループ管理マスタから予約レポートのグループコードを取得
  Future<DlgConfirmMsgKind> selectRegInfoGrpMst(DbManipulationPs db) async {
    // レジ情報グループ管理マスタから予約レポートのグループコードを取得のSQL
    String sqlSelectRegInfoGrpMst = "SELECT grp_cd FROM c_reginfo_grp_mst WHERE grp_typ = 5 AND comp_cd = ${batchReportInfo.compCd} AND stre_cd = ${batchReportInfo.streCd} AND mac_no = ${batchReportInfo.macNo}";
    try {
      // レジ情報グループ管理マスタから予約レポートのグループコードを取得
      Result result = await db.dbCon.execute(sqlSelectRegInfoGrpMst);
      if (result.isEmpty) {
        // データがありません
        TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "non exist data [$sqlSelectRegInfoGrpMst]");
        return DlgConfirmMsgKind.MSG_NONEXISTDATA;
      } else {
        // グループコードが複数取得されることはない
        batchReportInfo.batchGrpCd = int.tryParse(result[0].toColumnMap()[CReginfoGrpMstField.grp_cd]) ?? 0;
      }
    } catch (e, s) {
      // ＤＢ読込エラー
      TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "db error [$sqlSelectRegInfoGrpMst]\n$e\n$s");
      return DlgConfirmMsgKind.MSG_FILEREADERR;
    }

    // 正常終了
    return DlgConfirmMsgKind.MSG_NONE;
  }

  /// 予約レポートマスタから予約レポート情報を取得
  Future<DlgConfirmMsgKind> selectBatRepoMst(DbManipulationPs db) async {
    // 予約レポートマスタから予約レポート情報を取得のSQL
    String sqlBatRepoMst = "SELECT * FROM c_batrepo_mst WHERE comp_cd = ${batchReportInfo.compCd} AND stre_cd = ${batchReportInfo.streCd} AND batch_grp_cd = ${batchReportInfo.batchGrpCd} ORDER BY batch_no, report_ordr";
    try {
      // 予約レポートマスタから予約レポート情報を取得
      Result result = await db.dbCon.execute(sqlBatRepoMst);
      if (result.isEmpty) {
        // データがありません
        TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "non exist data [$sqlBatRepoMst]");
        return DlgConfirmMsgKind.MSG_NONEXISTDATA;
      } else {
        // 予約レポート詳細情報のリストの作成
        _createBatchReportDetailList(result);
      }
    } catch (e, s) {
      // ＤＢ読込エラー
      TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "db error [$sqlBatRepoMst]\n$e \n$s");
      return DlgConfirmMsgKind.MSG_FILEREADERR;
    }

    // 正常終了
    return DlgConfirmMsgKind.MSG_NONE;
  }

  /// 予約レポート詳細情報のリストの作成
  void _createBatchReportDetailList(Result result) {
    List<BatchReportDetail> list = batchReportDetailList;

    int i = 0;
    Map<String, dynamic> data = result[i].toColumnMap();
    while (i < result.length) {
      int batchNo = int.tryParse(data[CBatrepoMstField.batch_no]) ?? 0;   // 作成した予約番号(1～9999)
      String batchName = data[CBatrepoMstField.batch_name] ?? '';         // 予約名称
      RxList<BatchReportOrderDetail> batchReportOrderDetailList = <BatchReportOrderDetail>[].obs;

      while (batchNo == (int.tryParse(data[CBatrepoMstField.batch_no]) ?? 0)) {
        // 予約レポート順番詳細情報のリストに追加する
        batchReportOrderDetailList.add(
          BatchReportOrderDetail(
            reportOrdr: data[CBatrepoMstField.report_ordr] ?? 0,                      // 順番(1～12)
            batchReportNo: int.tryParse(data[CBatrepoMstField.batch_report_no]) ?? 0, // 登録したレポート番号
            batchFlg2: data[CBatrepoMstField.batch_flg2] ?? 0,                        // 予約フラグ２（0：レジ日計　1：店舗日計）
          ),
        );

        // 次のデータを参照
        i++;
        if (i >= result.length){
          break;
        }
        data = result[i].toColumnMap();
      }

      // 予約レポート詳細情報のリストに追加する
      list.add(
        BatchReportDetail(
          batchNo: batchNo,       // 作成した予約番号(1～9999)
          batchName: batchName,   // 予約名称
          batchReportOrderDetailList: batchReportOrderDetailList,
        ),
      );
    }
  }

  /// 予約レポートの印字処理
  void _batchReport() {
    // 予約レポートのインスタンス生成
    BatchReport batchReport = BatchReport();

    // 印字中のダイアログを表示する
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_NOW_PRINTING.dlgId,
        btnTxt: '中断',
        btnFnc: () => _abortDialog(batchReport),
      ),
    );

    List<CalcRequestBatchReport> calcRequestBatchReportList = [];

    // 予約レポート詳細情報で選択されているものを対象にしたデータリストを作成
    Iterable<BatchReportDetail> iterable = batchReportDetailList.where((e) => e.isChecked.value == true).toList();
    for (BatchReportDetail detail in iterable) {
      late CalcRequestBatchReport data;
      for (BatchReportOrderDetail orderDetail in detail
          .batchReportOrderDetailList) {
        data = CalcRequestBatchReport(
          compCd: batchReportInfo.compCd,
          streCd: batchReportInfo.streCd,
          macNo: batchReportInfo.macNo,
          saleDate: batchReportInfo.saleDate,
          batchGrpCd: batchReportInfo.batchGrpCd,
          batchNo: detail.batchNo,
          batchOrder: orderDetail.reportOrdr,
        );
        debugPrint('isChecked=${detail.isChecked}, batchNo=${detail.batchNo}, batchName=${detail.batchName}, reportOrdr=${orderDetail.reportOrdr}, batchReportNo=${orderDetail.batchReportNo}, batchFlg2=${orderDetail.batchFlg2}, batchReportNoName=${orderDetail.batchReportNoName}');
        calcRequestBatchReportList.add(data);
      }
    }

    // 予約レポートの処理開始
    batchReport.start(calcRequestBatchReportList);
  }

  /// 中断ボタン押下時の処理
  void _abortDialog(BatchReport batchReport) {
    // 中断確認ダイアログ
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_DOINTERRUPT.dlgId,
        rightBtnFnc: () => _abort(batchReport),
        leftBtnTxt: 'いいえ',    // 「はい」と「いいえ」を表示する
      ),
    );
  }

  /// 中断処理
  void _abort(BatchReport batchReport) {
    Get.back(); // 中断ダイアログを閉じる
    Get.back(); // 印字中ダイアログを閉じる
    // 中断中のダイアログを表示
    MsgDialog.show(
      MsgDialog.noButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_INTERRUPT.dlgId,
      ),
    );
    // 処理を中断する
    batchReport.abort();
  }
}
