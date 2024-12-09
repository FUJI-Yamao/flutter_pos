/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/cls_conf/soundJsonFile.dart';
import '../../../../if/if_sound.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../inc/sys/tpr_type.dart';
import '../../../../lib/cm_sound/sound.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../lib/cm_sound/sound_file_info.dart';
import '../../../../lib/cm_sound/sound_file_util.dart';
import 'c_sound_scroll_controller.dart';
import 'c_sound_setting_controller.dart';

/// 音の選択画面のコントローラー
class SoundSelectionController extends GetxController {

  /// コンストラクタ
  SoundSelectionController({
    required this.soundSettingTarget,
    required this.soundSettingInfo,
  }) {
    selectedNum = soundSettingInfo.num.value.obs;
  }

  /// 設定の対象
  final SoundSettingTarget soundSettingTarget;

  /// 音の設定情報
  final SoundSettingInfo soundSettingInfo;

  /// 選択された音の選択番号
  late RxInt selectedNum;

  /// 選択画面の一行の高さ(選択肢の高さ + 上余白 + 下余白)
  static const int rowHeight = (50 + 8 + 8);

  /// 選択画面のスクロール動作用のクラス
  final SoundScrollController soundScrollController = SoundScrollController();

  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isScrollable = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // スクロールボタン表示のフラグの切り替え
      checkFlagForDisplayingScrollButton();
      if (isScrollable.value) {
        // 選択状態の選択肢までスクロールする
        scrollToSelected();
      }
    });
  }

  /// スクロールボタン表示のフラグの切り替え
  void checkFlagForDisplayingScrollButton() {
    // maxScrollExtentが0より大きい時にスクロールボタンを表示する
    isScrollable.value = soundScrollController.position.maxScrollExtent > 0;
  }

  /// 選択状態の選択肢までスクロールする
  void scrollToSelected() {
    // 移動量 = 一行の高さ　* (選択番号 - 1(1番目の選択肢はスクロールしない))
    double scrollPixel = rowHeight * (selectedNum.value - 1);

    // 移動量がスクロール可能な最大範囲より大きいときは最大の分を移動量とする
    if (scrollPixel > soundScrollController.position.maxScrollExtent) {
      scrollPixel = soundScrollController.position.maxScrollExtent;
    }

    // 指定した位置へスクロール
    soundScrollController.scrollToPosition(position: scrollPixel);
  }

  /// 現在選択されている音の選択番号を、選択番号の一覧を持つnumListの内、
  /// 選択されたindex番目に入っている値に書き換える
  void setSelectedSoundNum(int index) {
    // 選択された音の選択番号を取得する
    selectedNum.value = soundSettingInfo.numList[index];
    // サンプル音を再生する
    _playSampleSound();
  }

  /// 変更した音の選択番号を確定させる
  Future<void> decideSoundNum() async {
    // 音の選択番号を設定ファイルに保存する
    await _saveSoundJsonForNum();
    // 音の選択番号をメモリにセットする
    _setNumToMem();
    // 再生中の音を停止する
    _stopPlayer();
    // 本体側のタッチ音を再生する
    IfSound.ifBz();
    // 一つ前の画面に戻る
    Get.back();
  }

  /// 選択画面から一つ前の画面に戻る
  void backToPreviousPage() {
    // 再生中の音を停止する
    _stopPlayer();
    // 本体側のタッチ音を再生する
    IfSound.ifBz();
    // 一つ前の画面に戻る
    Get.back();
  }

  /// 音の選択番号を設定ファイルに保存する
  Future<void> _saveSoundJsonForNum() async {
    // SoundJsonFileを読込む
    SoundJsonFile soundJsonFile = SoundJsonFile();
    await soundJsonFile.load();

    // データクラスの音の選択番号に、選択されている番号を代入
    soundSettingInfo.num.value = selectedNum.value;

    // 音の選択番号を設定
    switch (soundSettingTarget) {
      case SoundSettingTarget.mainBody:
        _setNumJsonR(soundJsonFile: soundJsonFile);
      case SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        _setNumJsonL(soundJsonFile: soundJsonFile);
      case SoundSettingTarget.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }

    await soundJsonFile.save();
  }

  /// 本体側の音の選択番号を設定
  void _setNumJsonR({
    required SoundJsonFile soundJsonFile,
  }) {
    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        soundJsonFile.pitch.CLICK_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.error:
        soundJsonFile.pitch.ERR_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.warning:
        soundJsonFile.pitch.WARNING_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.popup:
        soundJsonFile.pitch.POPUP_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.fanfare1:
        soundJsonFile.pitch.FANFARE1_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.fanfare2:
        soundJsonFile.pitch.FANFARE2_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.fanfare3:
        soundJsonFile.pitch.FANFARE3_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.verifone:
        soundJsonFile.pitch.VERIFONE_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.birth:
        soundJsonFile.pitch.BIRTH_NUM_R = soundSettingInfo.num.value;
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

  /// 客側の音の選択番号を設定
  void _setNumJsonL({
    required SoundJsonFile soundJsonFile,
  }) {
    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        soundJsonFile.pitch.CLICK_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.error:
        soundJsonFile.pitch.ERR_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.warning:
        soundJsonFile.pitch.WARNING_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.popup:
        soundJsonFile.pitch.POPUP_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.fanfare1:
        soundJsonFile.pitch.FANFARE1_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.fanfare2:
        soundJsonFile.pitch.FANFARE2_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.fanfare3:
        soundJsonFile.pitch.FANFARE3_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.verifone:
        soundJsonFile.pitch.VERIFONE_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.birth:
        soundJsonFile.pitch.BIRTH_NUM_L = soundSettingInfo.num.value;
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

  /// 項目の選択状態を判定する関数
  bool isSelected(int index) {
    return selectedNum.value == soundSettingInfo.numList[index];
  }

  /// サンプル音の再生
  void _playSampleSound() {

    String preFileName;
    SoundVolumeKind soundVolumeKind;

    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        preFileName = SoundDef.preTapFile;
        soundVolumeKind = SoundVolumeKind.tap;
      case SoundSettingKind.error:
        preFileName = SoundDef.preErrFile;
        soundVolumeKind = SoundVolumeKind.error;
      case SoundSettingKind.warning:
        preFileName = SoundDef.preWarnFile;
        soundVolumeKind = SoundVolumeKind.warning;
      case SoundSettingKind.popup:
        preFileName = SoundDef.prePopupFile;
        soundVolumeKind = SoundVolumeKind.popup;
      case SoundSettingKind.fanfare1:
        preFileName = SoundDef.preFnfl1File;
        soundVolumeKind = SoundVolumeKind.fanfare1;
      case SoundSettingKind.fanfare2:
        preFileName = SoundDef.preFnfl2File;
        soundVolumeKind = SoundVolumeKind.fanfare2;
      case SoundSettingKind.fanfare3:
        preFileName = SoundDef.preFnfl3File;
        soundVolumeKind = SoundVolumeKind.fanfare3;
      case SoundSettingKind.verifone:
        preFileName = SoundDef.preVerifoneFile;
        soundVolumeKind = SoundVolumeKind.verifone;
      case SoundSettingKind.birth:
        preFileName = SoundDef.preBirthFile;
        soundVolumeKind = SoundVolumeKind.birth;
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }

    // ファイル名生成
    String fileName = SoundFileUtil.makeFileName(
      preFileName: preFileName,
      num: selectedNum.value,
      ext: SoundDef.extWav,
    );

    Sound sound = Sound();              // 音声再生
    // 本体側で再生するか客側で再生するかを取得する
    TprMID tid = _getTid();             // Tpraid.TPRAID_SOUNDは本体側、Tpraid.TPRAID_SOUND2が客側

    // 再生中の音を停止する
    sound.playStop(tid: tid);
    // 指定されたローカルファイルを鳴らす
    sound.playSoundForFile(tid: tid, fileName: fileName, soundVolumeKind: soundVolumeKind);
  }

  /// 決定ボタン押下時に音の選択番号をメモリにセットする(本体側)
  void _setNumToMem() {
    Sound sound = Sound();

    // Soundクラスから音声ファイル情報を保持するクラスのインスタンスを取得
    SoundFileInfo soundFileInfo;

    switch (soundSettingTarget) {
      case SoundSettingTarget.mainBody:
        soundFileInfo = sound.soundInfo.soundFileInfo1;
      case SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        soundFileInfo = sound.soundInfo.soundFileInfo2;
      case SoundSettingTarget.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }

    // メモリ上にセット
    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        soundFileInfo.setTap(num: soundSettingInfo.num.value);
      case SoundSettingKind.error:
        soundFileInfo.setError(num: soundSettingInfo.num.value);
      case SoundSettingKind.warning:
        soundFileInfo.setWarning(num: soundSettingInfo.num.value);
      case SoundSettingKind.popup:
        soundFileInfo.setPopup(num: soundSettingInfo.num.value);
      case SoundSettingKind.fanfare1:
        soundFileInfo.setFanfare1(num: soundSettingInfo.num.value);
      case SoundSettingKind.fanfare2:
        soundFileInfo.setFanfare2(num: soundSettingInfo.num.value);
      case SoundSettingKind.fanfare3:
        soundFileInfo.setFanfare3(num: soundSettingInfo.num.value);
      case SoundSettingKind.verifone:
        soundFileInfo.setVerifone(num: soundSettingInfo.num.value);
      case SoundSettingKind.birth:
        soundFileInfo.setBirth(num: soundSettingInfo.num.value);
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

  /// 再生中の音を停止する
  void _stopPlayer() {
    // 本体側で再生するか客側で再生するかを取得する
    TprMID tid = _getTid();             // Tpraid.TPRAID_SOUNDは本体側、Tpraid.TPRAID_SOUND2が客側
    // 再生中の音を停止する
    Sound().playStop(tid: tid);
  }

  /// 本体側で再生するか客側で再生するかを取得する
  TprMID _getTid() {
    switch (soundSettingTarget) {
      case SoundSettingTarget.mainBody:
        return Tpraid.TPRAID_SOUND;
      case SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        return Tpraid.TPRAID_SOUND2;
      case SoundSettingTarget.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

}