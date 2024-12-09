/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/apllib_auto_staffpw.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import '../../../regs/checker/rxregstr.dart';
import '../../page/common/component/w_msgdialog.dart';
import '../../page/full_self/controller/c_full_self_register_controller.dart';
import '../../page/full_self/controller/c_full_self_select_pay_controller.dart';
import '../../page/full_self/controller/c_full_self_start_controller.dart';
import '../../page/full_self/page/p_full_self_select_pay_page.dart';
import '../../page/full_self/page/p_full_self_start_page.dart';
import '../../page/p_register_start_page.dart';
import '../../page/register/controller/c_transaction_management.dart';
import '../../socket/client/customer_socket_client.dart';
import '../../socket/model/customer_socket_model.dart';
import '../register/enum/e_register_page.dart';
import 'c_menu_scroll_controller.dart';


const Map<String, IconData> iconMap = {
  'barcode_reader': Icons.barcode_reader,
  'shield_moon_outlined': Icons.shield_moon_outlined,
  'remove_shopping_cart_outlined': Icons.remove_shopping_cart_outlined,
  'receipt_long_outlined': Icons.receipt_long_outlined,
  'computer': Icons.computer,
  'storefront': Icons.storefront,
  'volume_up': Icons.volume_up,
  'settings_applications': Icons.settings_applications,
  'mode_change': Icons.change_circle,
};

const mainMenuJson = '''
{
  "groups": [
    {
      "name": "モードの選択",
      "items": [
        {
          "path": "/register",
          "icons": "barcode_reader",
          "title": "登録・会計",
          "subtitle": "商品の登録・会計をする"
        },
        {
          "path": "/tranining",
          "icons": "shield_moon_outlined",
          "title": "訓練モード",
          "subtitle": "売り上げずに商品の登録・会計をする"
        },
        {
          "path": "/mode_change",
          "icons": "mode_change",
          "title": "モード切替",
          "subtitle": "通常／対面、フルセルフ、精算機の切替"
        }
      ]
    },
    {
      "name": "レジ締めの業務",
      "items": [
        {
          "path": "/storeclose",
          "icons": "remove_shopping_cart_outlined",
          "title": "閉設",
          "subtitle": "1日の売り上げを確認して集計する"
        },
        {
          "path": "/batchReportOutput",
          "icons": "computer",
          "title": "予約レポートの出力",
          "subtitle": "予約レポートを出力する"
        }
      ]
    },
    {
      "name": "その他のメニュー",
      "items": [
        {
          "path": "/tmpstorecloseut1",
          "icons": "storefront",
          "title": "UT1閉設",
          "subtitle": "UT1を閉設する"
        },
        {
          "path": "/sound_setting",
          "icons": "volume_up",
          "title": "音の設定",
          "subtitle": "音量の変更や音声の設定"
        },
        {
          "path": "/testsetting",
          "icons": "settings_applications",
          "title": "設定(テスト用)",
          "subtitle": "テスト用の設定"
        }
      ]
    }
  ]
}
''';

/// メインメニューのデータ
class TileMenuData {
  const TileMenuData({required this.title,required this.subtitle, required this.icon,required this.path});
  final String title;
  final IconData icon;
  final String path;
  final String subtitle;

  factory TileMenuData.fromJson(Map<String, dynamic> json) {
    return TileMenuData(
      title: json['title'],
      subtitle: json['subtitle'],
      icon: iconMap[json['icons']] ?? Icons.error,
      path: json['path'],
    );
  }
}

/// メインメニューのリストデータ
class TileMenuListData{
  const TileMenuListData({required this.title, required this.list});
  final String title;
  final List<TileMenuData> list;

  factory TileMenuListData.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<TileMenuData> itemsList = itemsFromJson.map((item) => TileMenuData.fromJson(item)).toList();

    return TileMenuListData(
      title: json['name'],
      list: itemsList,
    );
  }
}

/// メインメニューのコントローラー
class MainMenuPageController extends GetxController {

  /// メインメニューのリストデータ
  RxList menuList = List<TileMenuListData>.empty(growable: true).obs;
  /// スクロールバーのコントローラー
  final MenuScrollController scrollController = MenuScrollController();
  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isScrollable = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // メニューデータをロードする関数
    await loadMenuData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // スクロールボタン表示のフラグの切り替え
      _checkFlagForDisplayingScrollButton();
    });
  }

  /// メニューデータをロードする関数
  Future<void> loadMenuData() async {
    late Map<String, dynamic> jsonMap;
    try{
      Mac_infoJsonFile macinfoJson = Mac_infoJsonFile();
      await macinfoJson.load();

      // DBアクセスのインスタンス取得
      DbManipulationPs db = DbManipulationPs();

      String sql = "SELECT menu_object FROM c_pos_menu_mst WHERE comp_cd=${macinfoJson.system.crpno} AND stre_cd=${macinfoJson.system.shpno}";

      List<List<dynamic>> result = await db.dbCon.execute(sql);
      if (result.isEmpty) {
        throw Exception('No data found');
      } else {
        jsonMap = result[0][0];
      }
    }
    catch (e) {
      jsonMap = jsonDecode(mainMenuJson);
    }

    // HappySelf仕様か
    bool isHappySelfSystem = await CmCksys.cmHappySelfSystem() != 0;

    var groups = jsonMap['groups'] as List;
    for (var group in groups) {
      TileMenuListData tileMenuListData =TileMenuListData.fromJson(group);

      // HappySelf仕様でない場合
      if (!isHappySelfSystem) {
        // モード切替ボタン
        TileMenuData? tileMenuData = tileMenuListData.list.firstWhereOrNull((e) => e.path == '/mode_change');
        if (tileMenuData != null) {
          // 表示しないので、リストから削除する
          tileMenuListData.list.remove(tileMenuData);
        }
      }

      menuList.add(tileMenuListData);
    }
  }

  /// スクロールボタン表示のフラグの切り替え
  void _checkFlagForDisplayingScrollButton() {
    // maxScrollExtentが0より大きい時にスクロールボタンを表示する
    isScrollable.value = scrollController.position.maxScrollExtent > 0;
  }

  /// メインメニューのボタン押下時の処理
  Future<void> menuButtonClick(int i, int j) async {
    debugPrint('${menuList[i].list[j].title}ボタン押下');
    String path = menuList[i].list[j].path;
    if (path == RegisterPage.register.routeName) {
      // 登録ボタン押下
      await Rxregstr.rxRegsStart(Rxregstr.ConfOpeMode_RG);
      _registerButtonClick(path);
    } else if (path == RegisterPage.tranining.routeName) {
      // 訓練ボタン押下
      await Rxregstr.rxRegsStart(Rxregstr.ConfOpeMode_TR);
      _registerButtonClick(path);
    } else if (path == RegisterPage.storeClose.routeName) {
      // 閉設ボタン押下
      // 未精算取引がないか確認する（訓練時の未精算取引は確認しない）
      if (TransactionManagement.isExist()) {
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_TABDATA_EXPLAIN.dlgId,
          ),
        );
      } else {
        // 閉設画面へ
        Get.toNamed(path);
      }
    } else {
      Get.toNamed(path);
    }
  }

  /// 登録ボタン押下
  Future<void> _registerButtonClick(String path) async {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "_registerButtonClick start");

    // 共有メモリポインタの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      // システムエラー
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "_registerButtonClick rxMemRead error");
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: DlgConfirmMsgKind.MSG_SYSERR.dlgId,
        ),
      );
      return;
    }
    RxCommonBuf pCom = xRet.object;

    // TODO:00005 田中:QP/ID検定の為、暫定的にqc_modeを1する
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();

    // モード毎の画面遷移
    switch (pCom.iniMacInfo.select_self.kpi_hs_mode) {
      case 0: // 0:通常／対面
      // TODO:00005 田中:QP/ID検定の為、暫定的にqc_modeを1する
        macInfo.select_self.qc_mode = 1;
        pCom.iniMacInfo.select_self.qc_mode = 1;

        _startNormal(path);
      case 1: // 1:フルセルフ
      // TODO:00005 田中:QP/ID検定の為、暫定的にqc_modeを1する
        macInfo.select_self.qc_mode = 1;
        pCom.iniMacInfo.select_self.qc_mode = 1;

        await _startFullSelf(pCom);
      case 2: // 2:精算機
        await _startAdjustment(pCom);
      default:  // システムエラー
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_SYSERR.dlgId,
          ),
        );
        return;
    }
    // TODO:00005 田中:QP/ID検定の為、暫定的にqc_modeを1する
    await macInfo.save();

    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "_registerButtonClick end");
  }

  /// 通常／対面のスタート
  void _startNormal(String path) {
    // 店員画面を登録画面にする
    Get.toNamed(path);
  }

  /// フルセルフのスタート
  Future<void> _startFullSelf(RxCommonBuf pCom) async {
    // 従業員オープン
    AplLibAutoStaffPw aplLibAutoStaffPw = AplLibAutoStaffPw();
    if (await aplLibAutoStaffPw.openStaff(pCom)) {
      // 従業員オープンで使用した従業員コードを取得
      AutoStaffInfo autoStaffInfo = AutoStaffInfo(
        compCd: pCom.iniMacInfoCrpNoNo,
        streCd: pCom.iniMacInfoShopNo,
        macNo: pCom.iniMacInfoMacNo,
        staffCd: aplLibAutoStaffPw.staffCd,
      );

      // カラー客表接続で1画面フルセルフと2画面フルセルフの判定をする
      if (pCom.iniMacInfo.internal_flg.colordsp_cnct == 0) {
        // 1画面フルセルフ
        Get.off(() => FullSelfStartPage(autoStaffInfo));
      } else {
        // 2画面フルセルフ

        // 客側画面をフルセルフのスタート画面にする
        CustomerSocketClient().sendFullSelfStart(autoStaffInfo);

        // 店員画面を起動画面にする
        Get.to(() => const RegisterStartPage(isBoot: false));
      }
    }
  }

  /// 精算機のスタート
  Future<void> _startAdjustment(RxCommonBuf pCom) async {
    // 従業員オープン
    AplLibAutoStaffPw aplLibAutoStaffPw = AplLibAutoStaffPw();
    if (await aplLibAutoStaffPw.openStaff(pCom)) {
      AutoStaffInfo autoStaffInfo = AutoStaffInfo(
        compCd: pCom.iniMacInfoCrpNoNo,
        streCd: pCom.iniMacInfoShopNo,
        macNo: pCom.iniMacInfoMacNo,
        staffCd: aplLibAutoStaffPw.staffCd,
      );
      // TODO:精算機の画面を表示する
      if (pCom.iniMacInfo.internal_flg.colordsp_cnct == 0) {
        FullSelfStartController startcontroller = Get.put(FullSelfStartController(autoStaffInfo));
        FullSelfSelectPayController selecPayCtrl = Get.put(FullSelfSelectPayController());
        FullSelfRegisterController controller = Get.put(FullSelfRegisterController());
        controller.totalAmount.value = '0';
        Get.off(() => FullSelfSelectPayPage(isFromAdjustment: true));
      }
    }
  }
}