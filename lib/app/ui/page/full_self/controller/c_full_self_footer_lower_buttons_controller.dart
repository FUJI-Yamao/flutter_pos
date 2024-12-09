/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../component/w_full_self_change_language_dialog.dart';
import '../enum/e_full_self_footer_lower_button.dart';
import '../enum/e_full_self_kind.dart';
import '../model/m_full_self_navigation_button_info.dart';
import '../member_info_loading/page/p_full_self_load_card_page.dart';

/// フルセルフ画面のフッターの下部にあるボタンのコントローラー
class FullSelfFooterLowerButtonsController extends GetxController {
  /// コンストラクタ
  FullSelfFooterLowerButtonsController();

  /// ボタン情報のリストにボタン情報を追加する
  List<FullSelfNavigationButtonInfo> getButtonInfo(
      DisplayingFooterFullSelfKind fullSelfKind) {
    Map<FullSelfFooterLowerButtonsKind, bool> map =
        _getDisplaySwitching(fullSelfKind);

    List<FullSelfNavigationButtonInfo> buttonInfoList =
        <FullSelfNavigationButtonInfo>[
      FullSelfNavigationButtonInfo(
        buttonName: 'l_full_self_call_attendant',
        id: FullSelfFooterLowerButtonsKind.callStaff,
        iconKind: Icons.notifications,
        onTapCallback: () => _callStaff(),
        isVisible: map[FullSelfFooterLowerButtonsKind.callStaff]!,
      ),
      FullSelfNavigationButtonInfo(
        buttonName: 'l_full_self_membership_card',
        id: FullSelfFooterLowerButtonsKind.memberCard,
        iconKind: Icons.account_box,
        onTapCallback: () => _memberCard(),
        isVisible: map[FullSelfFooterLowerButtonsKind.memberCard]!,
      ),
      FullSelfNavigationButtonInfo(
        buttonName: 'l_full_self_plastic_bag',
        id: FullSelfFooterLowerButtonsKind.plasticBag,
        iconKind: Icons.shopping_bag,
        onTapCallback: () => _plasticBag(),
        isVisible: map[FullSelfFooterLowerButtonsKind.plasticBag]!,
      ),
      FullSelfNavigationButtonInfo(
        buttonName: 'l_full_self_cancel_registration',
        id: FullSelfFooterLowerButtonsKind.quitPurchase,
        iconKind: Icons.delete,
        onTapCallback: () => _quitPurchase(),
        isVisible: map[FullSelfFooterLowerButtonsKind.quitPurchase]!,
      ),
      FullSelfNavigationButtonInfo(
        buttonName: 'Language',
        id: FullSelfFooterLowerButtonsKind.language,
        iconKind: Icons.language,
        onTapCallback: () => language(),
        isVisible: map[FullSelfFooterLowerButtonsKind.language]!,
      ),
      FullSelfNavigationButtonInfo(
        buttonName: 'ボタン',
        id: FullSelfFooterLowerButtonsKind.button,
        iconKind: Icons.check_box_outline_blank,
        onTapCallback: () => {},
        isVisible: map[FullSelfFooterLowerButtonsKind.button]!,
      ),
    ];

    return buttonInfoList;
  }

  /// フルセルフの画面毎に、ボタン表示を切り替える
  Map<FullSelfFooterLowerButtonsKind, bool> _getDisplaySwitching(
      DisplayingFooterFullSelfKind fullSelfKind) {
    switch (fullSelfKind) {
      case DisplayingFooterFullSelfKind.start: // フルセルフのスタート画面
        return {
          FullSelfFooterLowerButtonsKind.callStaff: false, // 店員呼出
          FullSelfFooterLowerButtonsKind.memberCard: false, // 会員カードの読み込み
          FullSelfFooterLowerButtonsKind.plasticBag: false, // レジ袋を購入
          FullSelfFooterLowerButtonsKind.quitPurchase: false, // 買い物をやめる
          FullSelfFooterLowerButtonsKind.language: true, // Language(言語)
          FullSelfFooterLowerButtonsKind.button: false, // ボタン
        };
      case DisplayingFooterFullSelfKind.register: // 登録画面
        return {
          FullSelfFooterLowerButtonsKind.callStaff: false, // 店員呼出
          FullSelfFooterLowerButtonsKind.memberCard: true, // 会員カードの読み込み
          FullSelfFooterLowerButtonsKind.plasticBag: false, // レジ袋を購入
          FullSelfFooterLowerButtonsKind.quitPurchase: true, // 買い物をやめる
          FullSelfFooterLowerButtonsKind.language: true, // Language(言語)
          FullSelfFooterLowerButtonsKind.button: false, // ボタン
        };
      case DisplayingFooterFullSelfKind.preset: // プリセット画面
        AssertionError();
        return {};
      case DisplayingFooterFullSelfKind.selectPayment: // 支払い方法選択画面
        return {
          FullSelfFooterLowerButtonsKind.callStaff: false, // 店員呼出
          FullSelfFooterLowerButtonsKind.memberCard: false, // 会員カードの読み込み
          FullSelfFooterLowerButtonsKind.plasticBag: false, // レジ袋を購入
          FullSelfFooterLowerButtonsKind.quitPurchase: true, // 買い物をやめる
          FullSelfFooterLowerButtonsKind.language: true, // Language(言語)
          FullSelfFooterLowerButtonsKind.button: false, // ボタン
        };
      case DisplayingFooterFullSelfKind.amount: // 個数入力画面
        AssertionError();
        return {};
      case DisplayingFooterFullSelfKind.semiSelf: // セミセルフの場合
        return {
          FullSelfFooterLowerButtonsKind.callStaff: true, // 店員呼出
          FullSelfFooterLowerButtonsKind.memberCard: false, // 会員カードの読み込み
          FullSelfFooterLowerButtonsKind.plasticBag: false, // レジ袋を購入
          FullSelfFooterLowerButtonsKind.quitPurchase: false, // 買い物をやめる
          FullSelfFooterLowerButtonsKind.language: true, // Language(言語)
          FullSelfFooterLowerButtonsKind.button: false,
        };
    }
  }

  /// 店員呼出ボタン押下の処理
  void _callStaff() {
    // ガイダンス音声の停止
    RcSound.stop();
  }

  ///会員カードの読み込みボタン押下の処理
  void _memberCard() {
    // ガイダンス音声の停止
    RcSound.stop();
    ///会員カードの読み込みページへの遷移
    Get.to(() => const FullSelfMemberCardSelectPage());
  }

  /// レジ袋を購入ボタン押下の処理
  void _plasticBag() {
    // ガイダンス音声の停止
    RcSound.stop();
  }

  /// 買い物をやめるボタン押下時の処理
  void _quitPurchase() {
    // ガイダンス音声の停止
    RcSound.stop();

    RegsMem().resetTranData();

    // フルセルフのスタート画面に遷移
    Get.until((route) => route.settings.name == '/FullSelfStartPage');
  }

  /// Language(言語)ボタン押下の処理
  void language() {
    // ガイダンス音声の停止
    RcSound.stop();
    Get.dialog(
      // ダイアログ外タップで閉じない
      barrierDismissible: false,
      // 言語切り替えダイアログ
      const ChangeLanguageDialog(),
    );
  }
}
