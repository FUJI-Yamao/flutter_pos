/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_pos/app/ui/page/change_coin_connection/p_change_coin_connection_page.dart';
import 'package:get/get.dart';

import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/image_label_dbcall.dart';
import '../../regs/inc/rc_regs.dart';
import '../enum/e_dual_status.dart';
import '../language/l_languagedbcall.dart';
import '../socket/model/customer_socket_model.dart';

/// 表示可能な状態タイプ
enum StatusType {
  notChange(name: "釣機OFF"),
  coinOff(name: "釣銭機OFF"),
  billOff(name: "釣札機OFF");

  const StatusType({required this.name});

  final String name;
}

///共通コントローラクラス
class CommonController extends GetxController {

  /// 現在の釣り機の状態を保持
  static ChangeType changeStatusType = ChangeType.all;

  /// 表示する状態
  RxList changeDisplay = [].obs;

  ///　通信用URL
  final strUrl = ''.obs;

  /// 多言語関連変数
  List<LanguagesData> lstLngsRtn = [];

  /// イメージラベル関連変数
  Map<int, String> imgLblRtn = {};

  /// 初期値　国区分
  final intCountry = LocaleNo.Japanese.no.obs;

  /// デフォルト国
  int defaultCountry = 0;

  /// キー操作の判別
  final RxInt rcKySelf = RcRegs.DESKTOPTYPE.obs;

  /// 1人制でメイン側
  final isMainMachine = false.obs;
  /// 1人制のロック解除可否
  final isUnlockEnabled = true.obs;
  /// 2人制で操作端末切り替え時に登録する従業員情報
  AutoStaffInfo? autoStaffInfo;
  /// 2人制で稼働（Windows動作時のみ使用）
  final isDualMode = false.obs;
  /// 2人制でタワー側からデータ受領済み時
  final dualModeDataReceived = false.obs;
  /// 2人制状態
  DualStatus dualStatus = DualStatus.none;
  /// 2人制で稼働できるか否か
  RxBool enable2Person = false.obs;

  /// 登録画面がRoute上に存在する
  RxBool onRegisterRoute = false.obs;
  /// 小計画面がRoute上に存在する
  RxBool onSubtotalRoute = false.obs;

  /// コントローラが準備完了したときに呼び出す
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    _setDefaultCountry();
    await fetchMultilingualData();
    await fetchImageLabel();
    enable2Person.value = await DualCashierUtil.check2Person();
  }

  // お客様側　DBより多言語データとイメージラベルデータ取得
  Future<void> fetchMultilingualData() async {
    try {
      lstLngsRtn = await LanguagesMstDbCall().multilingualSelect();
    } catch (e) {
      // エラーでも多言語Keyが表示されるため、続行は可能（ただし切り替え機能は使えない）
      String strMsg = '***** データ取得エラー（LanguagesMstDbCall）****：$e}';
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, strMsg);
    }
  }

  /// DBからイメージラベル取得
  Future<void> fetchImageLabel() async {
    try {
      imgLblRtn = await ImageLabelDbCall().getAllImageLabels();
    } catch (e) {
      String strMsg = '***** データ取得エラー（ImageLabelDbCall）****：$e}';
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, strMsg);
    }
  }

  /// デフォルト国の設定
  void _setDefaultCountry() {
    String country = Get.deviceLocale.toString();
    if (Platform.isAndroid) {
      // TODO:10106 多言語　Androidの場合はLocaleNo.valuesの値が違う.
    } else {
      //一致しない場合は日本語に返す
      defaultCountry = LocaleNo.values
          .firstWhere((a) => a.kind == country, orElse: () => LocaleNo.Japanese)
          .no;
    }
  }
  
  /// 状態削除
  void removeStatus() {
    if (changeDisplay.isNotEmpty) {
      changeDisplay.removeLast();
    }
  }

  /// 状態追加
  void addStatus(StatusType addStatus) {
    if (!(changeDisplay.contains(addStatus)) && changeDisplay.length < 4) {
      if (addStatus == StatusType.billOff || addStatus == StatusType.coinOff || addStatus == StatusType.notChange) {
        removeDisplayStatus();
      }
      changeDisplay.add(addStatus);
    }
  }

  /// displayStatusTypeの重複を削除（引数：なし）
  /// パラメータ：なし
  /// 戻り値：なし
  void removeDisplayStatus() {
    if (changeDisplay.contains(StatusType.billOff)) {
      changeDisplay.remove(StatusType.billOff);
    }
    if (changeDisplay.contains(StatusType.coinOff)) {
      changeDisplay.remove(StatusType.coinOff);
    }
    if (changeDisplay.contains(StatusType.notChange)) {
      changeDisplay.remove(StatusType.notChange);
    }
  }
}
