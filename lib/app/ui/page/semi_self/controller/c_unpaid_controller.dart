/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path/path.dart';

import '../../../../../clxos/calc_api.dart';
import '../../../../../clxos/calc_api_data.dart';
import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/environment.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/apl/t_item_log.dart';
import '../../../../inc/lib/spqc.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../lib/apllib/apllib_speedself.dart';
import '../../../../regs/checker/rc_clxos.dart';
import '../../../../regs/checker/rcky_plu.dart';
import '../../../../regs/checker/rcky_qcselect.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../../sys/sale_com_mm/rept_ejconf.dart';
import '../../register/controller/c_registerbody_controller.dart';


///未精算一覧の仮データコントローラ
class UnPaidListController extends GetxController {
  var unpaidList = <Map<String, dynamic>>[].obs; //未清算データリスト
  RxInt selectedIndex = 0.obs; //画面で選択された未清算データのインデックス
  var print_data = "".obs;
  var pluCdList = <Map<String, dynamic>>[].obs; //商品コードリスト
  var viewMax = 5.obs; //画面に表示する未清算データの最大件数
  var viewPage = 0.obs; //表示ページ
  /// TODO:仮実装。前,次ボタン非活性（isEnabled or Visibility）が実装出来たらfalseにする
  var nextBtnFlg = false.obs; //次ボタン表示フラグ
  var prevBtnFlg = false.obs; //前ボタン表示フラグ
  var outputList = <Map<String, dynamic>>[].obs; //画面表示する未清算データリスト
  var viewOffset = 0.obs; // 未清算データ（電子ジャーナル）の表示オフセット

  final ScrollController dataScrollerController = ScrollController();
  final RegisterBodyController regBodyCtrl = Get.find();

  void updateLoadDataList(List<Map<String, dynamic>> newList) {
    unpaidList.assignAll(newList);
    selectedIndex.value = -1;
  }

  void selectedItem(int index) {
    if (index >= 0 && index < outputList.length) {
      selectedIndex.value = index;
      print_data.value = outputList[index]['print_data'];
    }
  }

  /// 未清算項目に該当するマシン番号を取得し、それにに紐づくソケット番号を返す。
  /// TODO:仮実装
  int getSelectedItem() {
    if (selectedIndex.value < 0) {
      return 0;
    }
    int mac_no = outputList[selectedIndex.value]['mac_no'];
    int socketNo = RckyQcSelect.getSocketNoByMacNo(mac_no);
    return socketNo;
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
    updateButtonFlags();
    Future(() async {
      await searchDbData();
    });
  }

  ///上スクロールボタン押したときのメソッド　距離調整可能
  void scrollUp() {
    dataScrollerController.animateTo(
      dataScrollerController.offset - 250,
      duration: const Duration(microseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  ///下スクロールボタン押したときのメソッド
  void scrollDown() {
    dataScrollerController.animateTo(
      dataScrollerController.offset + 250,
      duration: const Duration(microseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  ///前　次ボタン表示状態
  void updateButtonFlags() {
    int maxPage = (unpaidList.length / viewMax.value).ceil() -1;
    prevBtnFlg.value =  viewPage.value > 0;
    nextBtnFlg.value = viewPage.value < maxPage;
  }

  ///前ボタン押下時のメソッド
  void onPreviousBtn() {
    if (viewPage > 0) {
      viewPage.value--;
      viewOffset.value = viewPage.value * viewMax.value;
      setOutputList(viewOffset.value);
      updateButtonFlags();
      print_data.value = outputList[selectedIndex.value]['print_data'];
    }
  }

  ///次ボタン押下時のメソッド
  void onNextBtn() {
    int maxPage = (unpaidList.length / viewMax.value).ceil() -1;

    if (viewPage.value < maxPage) {
      viewPage++;
      viewOffset.value = viewPage.value * viewMax.value;
      setOutputList(viewOffset.value);
      updateButtonFlags();
      print_data.value = outputList[selectedIndex.value]['print_data'];
    }
  }


  /// 画面起動時の初期化処理（内部パラメタのクリア＋未清算ファイル格納先の生成）
  Future<void> loadData() async {
    unpaidList.clear();
    outputList.clear();
    String dirPath = TprxPlatform.getPlatformPath(EnvironmentData.TPRX_HOME + SPQC_CLT_MAKE_DIR);
    viewPage.value = 0;
    /// TODO:仮実装。前,次ボタン非活性（isEnabled or Visibility）が実装出来たらfalseにする
    nextBtnFlg.value = true;
    prevBtnFlg.value = true;
    selectedIndex.value = -1;
  }

  /// 画面起動時、未清算ファイル名に記されるシリアルNoをキーとし、
  /// DBテーブル"c_ej_log"のレコードを検索する。
  /// レコードがある場合は、レコードデータを未清算一覧画面に反映する
  Future<void> searchDbData() async {
    String dirPath = EnvironmentData.TPRX_HOME + SPQC_CLT_MAKE_DIR;
    int readData = 0;
    String saleTime = "";
    String time = "";
    String receipt_no = "";
    int    mac_no = 0;
    String seq_no = "";
    String printData = "";
    int    quantity = 0;
    int    amount = 0;

    var fList = Directory(dirPath).listSync();
    unpaidList.clear();
    for (var f in fList) {
      // 電子ジャーナルを読み込み、セットする。
      final File file = File(f.path);
      if (!file.existsSync()) {
        continue;
      }
      String json = file.readAsStringSync();
      if (json == "") {
        continue;
      }
      String serialNo = f.path.substring(f.path.lastIndexOf("/") + 1, f.path.lastIndexOf("_"));
      String uuid     = f.path.substring(f.path.lastIndexOf("_") + 1, f.path.indexOf(".json"));  // 未清算ファイル名からUUIDを切り出す

      late Map<String, dynamic> mapData;
      Map<String, dynamic> mapFile = jsonDecode(json);
      // TODO:JSONの解析は仮実装。電子ジャーナルのJSONデータが判明したら正式に実装する。
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "UnPaidListController.loadData(): rxMemRead error");
        return;
      }
      RxCommonBuf pCom = xRet.object;

      // DBからデータを検索する
      try {
        DbManipulationPs db = DbManipulationPs();
        Map<String, dynamic> params = {"serialNo": serialNo, "comp_cd":pCom.dbRegCtrl.compCd, "stre_cd": pCom.dbRegCtrl.streCd};
        String sql = "SELECT * FROM c_ej_log WHERE serial_no = @serialNo AND comp_cd = @comp_cd AND stre_cd = @stre_cd";
        Result dbRes = await db.dbCon.execute(Sql.named(sql), parameters: params);
        if (dbRes.affectedRows == 0) {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
              "UnPaidListController.loadData():DB Record None for serial_no='$serialNo')");
          mapData = {};
          // TODO:クラウドPOSで支払い確認 or QC指定を行ってもc_ej_logにレコードが追加されない。いったん無くても良いように動かす。
          //continue;
        }
        else {
          mapData = dbRes.first.toColumnMap();
        }
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "UnPaidListController.loadData():DB Read Err $e $s )");
        selectedIndex.value = -1;
        return;
      }

      // 未清算ファイルから取得したデータを格納する
      saleTime = mapFile['saleTime'];
      if (saleTime != "") {
        DateTime dt = DateTime.parse(saleTime);
        time = "${"${dt.hour}".padLeft(2,'0')}:${"${dt.minute}".padLeft(2,'0')}:${"${dt.second}".padLeft(2,'0')}";
      }
      receipt_no = mapFile['receiptNo'] ?? "";
      mac_no     = mapFile['macNo'] ?? 0;
      seq_no     = serialNo;
      printData  = "詳細データがありません";
      quantity   = mapFile['qty'] ?? 0;
      amount     = mapFile['stlTaxInAmt'] ?? 0;
      if (mapData.length > 0) {
        // TODO:EJは条件により作成されない場合がある。当面コメントアウトする。print_dataはヒットすれば表示させる。
        // c_ej_logに該当するUUIDのデータがあった場合は以下の処理にて置換する。
      //DateTime dt = mapData['saleTime'] ?? DateTime(2000, 1, 1, 0, 0, 0, 0, 0);
      //time        = "${"${dt.hour}".padLeft(2,'0')}:${"${dt.minute}".padLeft(2,'0')}:${"${dt.second}".padLeft(2,'0')}";
      //receipt_no  = "R" + int.parse(mapData['receipt_no'] ?? "").toString().padLeft(4, '0');
      //seq_no      = (mapData['seq_no'] ?? 0).toString();
        printData   = mapData['print_data'] ?? "詳細データがありません";
      }
      unpaidList.add({
        'uuid'         : uuid,
        'time'         : time,
        'saleTime'     : saleTime,   // ソート用
        'sequence'     : seq_no,
        'receiptnumber': receipt_no,
        'quantity'     : quantity.toString(),
        'amount'       : amount,
        'mac_no'       : mac_no,
        'print_data'   : printData,
      });

      if (readData >= viewMax.value) {
        nextBtnFlg.value = true;  //未清算データが6件以上ある場合、次ボタンフラグを立てる
      }
      readData++;
    }
    if (unpaidList.length == 0) {
      selectedIndex.value = -1;
    } else {
      unpaidList.sort((a, b) => b['saleTime'].compareTo(a['saleTime']));  // saleTimeを降順でソートする。
      setOutputList(0);
      selectedIndex.value = 0;  // リスト0番目を選択状態とする。
      print_data.value = outputList[selectedIndex.value]['print_data'];  // 画面右側の初期表示
    }
  }

  // 表示用バッファにセットする。
  void setOutputList(int offset) {
    int max = viewMax.value + offset;
    if (unpaidList.length < viewMax.value) {
      max = unpaidList.length;
      offset = 0;
    }
    if (max >= unpaidList.length) {
      max = unpaidList.length;
    }
    outputList.clear();
    for (int i = offset; i < max; i++) {
      outputList.add({
        'uuid'         : unpaidList[i]['uuid'],
        'time'         : unpaidList[i]['time'],
        'saleTime'     : unpaidList[i]['saleTime'],
        'sequence'     : unpaidList[i]['sequence'],
        'receiptnumber': unpaidList[i]['receiptnumber'],
        'quantity'     : unpaidList[i]['quantity'],
        'amount'       : unpaidList[i]['amount'],
        'mac_no'       : unpaidList[i]['mac_no'],
        'print_data'   : unpaidList[i]['print_data'],
      }); //初期表示時、1~5件のデータを出力用変数に格納する
    }
  }

  /// 呼び戻すボタン押下時の処理（未清算商品を反映した登録画面へ戻る）
  Future<int> setUnpaidPluData(int idx) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "PLU rxMemRead error");
      return DlgConfirmMsgKind.MSG_QCNOTPAY_READ_ERR.dlgId;
    }
    RxCommonBuf pCom = xRet.object;

    //呼び戻すボタン押下前に未選択商品がある場合、消去する
    if (regBodyCtrl.purchaseData.isNotEmpty) {
      // タブ位置のデータを削除する
      regBodyCtrl.delTabList();
    }

    //品数に関わらない固定値をセット
    String uuid      = unpaidList[idx]["uuid"] ?? "";
    String seqNo     = unpaidList[idx]['sequence'];
    // TODO:c_ej_logからの取得のため残しておく
    // int    quantity  = int.parse(unpaidList[idx]['quantity']) ?? 0;
    // String saleDate  = unpaidList[idx]['sale_date'];
    // String printData = unpaidList[idx]['print_data'];
    // String pluCd = "0";
    // int pluCdLen = 0;  //商品コードが記される開始位置（print_data内に記される）
    // int startIdx = 0;  //商品コード検索を開始する文字位置（print_dataを検索する）

    String dirPath = TprxPlatform.getPlatformPath(EnvironmentData.TPRX_HOME + SPQC_CLT_MAKE_DIR);
    String fileName = seqNo + "_" + uuid + ".json";
    final File file = File(join(dirPath, fileName));
    if (!file.existsSync()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "setUnpaidPluData file load fail");
    }
    Map<String, dynamic> jsonFile = jsonDecode(file.readAsStringSync());
    CalcRequestParaPay paraPay;
    if (jsonFile['CalcRequestParaPay'] != null) {
      paraPay = CalcRequestParaPay.fromJson(jsonFile['CalcRequestParaPay']);
    } else {
      // TODO:エラーダイアログが必要（ParaPayが無いと員数データが取ってこれないため ⇒ 060_QC指定でDBに登録される？）
      return DlgConfirmMsgKind.MSG_QCNOTPAY_READ_ERR.dlgId;
    }

    Map<String, dynamic> params = { "uuid" : uuid };
    DbManipulationPs db = DbManipulationPs();
    String sql = "select * from p_cart_log where cart_id = @uuid;";
    Result mstList = await db.dbCon.execute(Sql.named(sql), parameters: params);
    pluCdList.clear();
    if ((!mstList.isEmpty) && (mstList.length > 0)) {
      // p_cart_logにデータがある場合
      for (int i = 0; i < mstList.length; i++) {
        Map<String, dynamic> data = mstList[i].toColumnMap();
        for (int j = 0; j < paraPay.itemList.length; j++) {
          if ((data['plu_cd'] == paraPay.itemList[j].barcode1)
           || (data['plu_cd'] == paraPay.itemList[j].barcode2)) {
            pluCdList.add({
              // 必要と思われるパラメータを列記しておく
              'sale_date' : paraPay.itemList[j].cnctTime,
              'quantity'  : paraPay.itemList[j].qty,
              'sequence'  : paraPay.itemList[j].seqNo,
              'barcode'   : data['plu_cd'],
            });
            break;
          }
        }
      }
    } else {
      // // TODO:p_cart_logからデータが取ってこれない場合。
      // // c_ej_logのprint_dataからデータを復帰させる。（念のためコードは残しておく）
      // // （※：クラウドPOSが機能していないので、c_ej_logには登録されていない）
      // if (quantity > 0) {
      //   for (int i = 0; i < quantity; i++) {
      //     pluCdLen = printData.indexOf('  P', startIdx) + 3; //商品コードを示す位置
      //     if (pluCdLen > startIdx + 3) {
      //       //商品コードが存在する場合
      //       pluCd =
      //           printData.substring(pluCdLen, pluCdLen + 13); //商品コード(13桁)を抽出
      //     } else {
      //       //商品コードがない場合
      //       break;
      //     }
      //     for (int j = 0; j < paraPay.itemList.length; j++) {
      //       if ((pluCd == paraPay.itemList[j].barcode1)
      //           || (pluCd == paraPay.itemList[j].barcode2)) {
      //         pluCdList.add({
      //           // 必要と思われるパラメータを列記しておく
      //           'sale_date' : paraPay.itemList[j].cnctTime,
      //           'quantity'  : paraPay.itemList[j].qty,
      //           'sequence'  : paraPay.itemList[j].seqNo,
      //           'barcode'   : pluCd,
      //         });
      //         break;
      //       }
      //     }
      //     startIdx = pluCdLen + 14; //次の商品コードを探すため、商品コード読取後の文字位置にインクリメントする
      //   }
      // }
    }

    //リクエストデータのセット
    CalcRequestParaItem req;
    CalcResultWithRawJson resultWithRawJson;
    RegsMem().lastRequestData = CalcRequestParaItem(compCd:pCom.dbRegCtrl.compCd, streCd:pCom.dbRegCtrl.streCd, uuid:uuid);
    req = RegsMem().lastRequestData!;
    req.macNo = pCom.dbRegCtrl.macNo;
    req.opeMode = RegsMem().tHeader.ope_mode_flg;
    req.posSpec = 0;  // 通常状態
    req.itemList = paraPay.itemList;  // アイテムリストをコピー
    req.refundFlag = RegsMem().refundFlag ? 1 : 0;

    // アイテム登録
    if (!RcClxosCommon.validClxos) {
      resultWithRawJson = await RcClxosCommon.stabItem(req);
    }
    else {
      resultWithRawJson = await CalcApi.loadItem(req);
      // 全体のエラーIDを取得.
      int err = resultWithRawJson.result.getErrId();
      if (err == 0) {
        // 登録したアイテムのエラーIDを取得.
        err = resultWithRawJson.result.calcResultItemList?.last.getErrId() ?? 0 ;
      }
      if (err != 0) {
        // 何らかのエラーが発生 → エラーが出た商品を削除.
        req.itemList.removeLast();
        TprLog().logAdd(
            Tpraid.TPRAID_CHK, LogLevelDefine.error, "PLU ${resultWithRawJson.result.errMsg}");
        return DlgConfirmMsgKind.MSG_QCNOTPAY_READ_ERR.dlgId;
      }
    }

    RcClxosCommon.settingMemResultData(resultWithRawJson.result);

    // 登録画面へ未清算商品を反映する
    int itemLen = RegsMem().tTtllog.getItemLogCount();
    List<TItemLog> itemLog = RegsMem().tItemLog;
    for (int i=0; i < itemLen; i++) {
      regBodyCtrl.addItem(i, itemLog[i]);
    }
    return DlgConfirmMsgKind.MSG_NONE.dlgId;
  }

}
