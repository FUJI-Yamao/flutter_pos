/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/cls_conf/soundJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../if/if_sound.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../inc/sys/tpr_type.dart';
import '../../../../lib/cm_sound/sound.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../lib/cm_sound/sound_file_util.dart';
import '../../../../lib/cm_sound/sound_volume_info.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../p_sound_selection.dart';
import 'c_sound_scroll_controller.dart';

/// 設定の対象
enum SoundSettingTarget {
  mainBody('本体側'),                // 本体側
  tower('タワー側'),                 // タワー側
  customerPanel('客側表示パネル'),   // 客側表示パネル
  guidance('ガイダンス音声');        // ガイダンス音声

  final String name;        // 画面に表示する名称
  const SoundSettingTarget(this.name);
}

/// 音の設定画面で扱う音の種類
enum SoundSettingKind {
  tap('タッチ音'),                   // タッチ音（メイン音量）
  error('エラー音'),                 // エラー音
  warning('警告音'),                 // 警告音
  popup('ポップアップ音'),           // ポップアップ音
  fanfare1('ファンファーレ1音'),     // ファンファーレ1音
  fanfare2('ファンファーレ2音'),     // ファンファーレ2音
  fanfare3('ファンファーレ3音'),     // ファンファーレ3音
  verifone('verifone音'),            // verifone音
  birth('誕生日音'),                 // 誕生日音
  guidance('ガイダンス音声');        // ガイダンス音声

  final String name;        // 画面に表示する名称
  const SoundSettingKind(this.name);
}

/// 音の設定画面のコントローラー
class SoundSettingController extends GetxController {
  static const double volumeMin = 0.0;          // 音量の最小値
  static const double volumeMax = 100.0;        // 音量の最大値

  /// タブの選択位置
  RxInt tabSelectedIndex = 0.obs;
  /// タブ情報リスト
  final RxList<SoundSettingTargetInfo> tabList = <SoundSettingTargetInfo>[].obs;
  /// タブのPageController
  late final PageController pageController = PageController(initialPage: tabSelectedIndex.value);
  /// 設定画面のスクロール動作用のクラス
  final SoundScrollController soundScrollController = SoundScrollController();
  /// スクロールボタン表示のフラグ（trueで表示）
  final Rx<bool> isScrollable = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // 設定ファイルから音量と種類を読み込む
    await _loadSoundJson();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // スクロールボタン表示のフラグの切り替え
      checkFlagForDisplayingScrollButton();
    });
  }

  /// スクロールボタン表示のフラグの切り替え
  void checkFlagForDisplayingScrollButton() {
    // maxScrollExtentが0より大きい時にスクロールボタンを表示する
    isScrollable.value = soundScrollController.position.maxScrollExtent > 0;
  }

  /// 変更した音量を確定させる
  Future<void> decideSoundVolume(SoundSettingInfo soundSettingInfo) async {
    // 保存処理
    await _saveSoundJsonForVolume(soundSettingInfo);

    // Soundクラスの音量を変更して、該当の音を鳴らす
    switch (tabList[tabSelectedIndex.value].soundSettingTarget) {
      case SoundSettingTarget.mainBody || SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        // 本体側で再生するか客側で再生するかを取得する
        TprMID tid = _getTid();             // Tpraid.TPRAID_SOUNDは本体側、Tpraid.TPRAID_SOUND2が客側
        // 指定された音を鳴らす
        _playSound(tid: tid, soundSettingInfo: soundSettingInfo);
      case SoundSettingTarget.guidance:
        // ガイダンス音声の音量変更
        Sound sound = Sound();
        sound.soundInfo.soundVolumeInfo1.setGuidance(volume: soundSettingInfo.volume.value);
        sound.soundInfo.soundVolumeInfo2.setGuidance(volume: soundSettingInfo.volume.value);
        // ガイダンス音声のサンプルを再生
        RcSound.play(sndFile: SoundDef.guidanceSampleFile);
    }
  }

  /// 指定された音を鳴らす
  void _playSound({
    required TprMID tid,
    required SoundSettingInfo soundSettingInfo,
  }) {
    Sound sound = Sound();

    // Soundクラスから音量情報を保持するクラスのインスタンスを取得
    SoundVolumeInfo soundVolumeInfo;
    if (tid == Tpraid.TPRAID_SOUND2) {
      soundVolumeInfo = sound.soundInfo.soundVolumeInfo2;
    } else {
      soundVolumeInfo = sound.soundInfo.soundVolumeInfo1;
    }

    // 音を鳴らす
    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        soundVolumeInfo.setTap(volume: soundSettingInfo.volume.value);
        sound.playTapSound(tid: tid);
      case SoundSettingKind.error:
        soundVolumeInfo.setError(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.error);
      case SoundSettingKind.warning:
        soundVolumeInfo.setWarning(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.warning);
      case SoundSettingKind.popup:
        soundVolumeInfo.setPopup(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.popup);
      case SoundSettingKind.fanfare1:
        soundVolumeInfo.setFanfare1(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.fanfare1);
      case SoundSettingKind.fanfare2:
        soundVolumeInfo.setFanfare2(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.fanfare2);
      case SoundSettingKind.fanfare3:
        soundVolumeInfo.setFanfare3(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.fanfare3);
      case SoundSettingKind.verifone:
        soundVolumeInfo.setVerifone(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.verifone);
      case SoundSettingKind.birth:
        soundVolumeInfo.setBirth(volume: soundSettingInfo.volume.value);
        sound.playStop(tid: tid);
        sound.playSound(tid: tid, soundKind: SoundKind.birth);
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

  /// タッチ音の音量を、設定ファイルに保存する
  Future<void> _saveSoundJsonForVolume(SoundSettingInfo soundSettingInfo) async {
    // SoundJsonFileを読込む
    SoundJsonFile soundJsonFile = SoundJsonFile();
    await soundJsonFile.load();

    // 音情報を設定
    switch (tabList[tabSelectedIndex.value].soundSettingTarget) {
      case SoundSettingTarget.mainBody:
        _setSoundJsonR(soundSettingInfo: soundSettingInfo, soundJsonFile: soundJsonFile);
      case SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        _setSoundJsonL(soundSettingInfo: soundSettingInfo, soundJsonFile: soundJsonFile);
      case SoundSettingTarget.guidance:
        _setSoundJsonGuidance(soundSettingInfo: soundSettingInfo, soundJsonFile: soundJsonFile);
    }

    await soundJsonFile.save();
  }

  /// 本体側の音情報を設定
  void _setSoundJsonR({
    required SoundSettingInfo soundSettingInfo,
    required SoundJsonFile soundJsonFile,
  }) {
    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        soundJsonFile.volume.G1R = soundSettingInfo.volume.value;
      case SoundSettingKind.error:
        soundJsonFile.volume.ERR_R = soundSettingInfo.volume.value;
      case SoundSettingKind.warning:
        soundJsonFile.volume.WARN_R = soundSettingInfo.volume.value;
      case SoundSettingKind.popup:
        soundJsonFile.volume.POPUP_R = soundSettingInfo.volume.value;
      case SoundSettingKind.fanfare1:
        soundJsonFile.volume.FANFARE1_R = soundSettingInfo.volume.value;
      case SoundSettingKind.fanfare2:
        soundJsonFile.volume.FANFARE2_R = soundSettingInfo.volume.value;
      case SoundSettingKind.fanfare3:
        soundJsonFile.volume.FANFARE3_R = soundSettingInfo.volume.value;
      case SoundSettingKind.verifone:
        soundJsonFile.volume.VERIFONE_R = soundSettingInfo.volume.value;
      case SoundSettingKind.birth:
        soundJsonFile.volume.BIRTH_R = soundSettingInfo.volume.value;
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

  /// 客側の音情報を設定
  void _setSoundJsonL({
    required SoundSettingInfo soundSettingInfo,
    required SoundJsonFile soundJsonFile,
  }) {
    switch (soundSettingInfo.soundSettingKind) {
      case SoundSettingKind.tap:
        soundJsonFile.volume.G1L = soundSettingInfo.volume.value;
      case SoundSettingKind.error:
        soundJsonFile.volume.ERR_L = soundSettingInfo.volume.value;
      case SoundSettingKind.warning:
        soundJsonFile.volume.WARN_L = soundSettingInfo.volume.value;
      case SoundSettingKind.popup:
        soundJsonFile.volume.POPUP_L = soundSettingInfo.volume.value;
      case SoundSettingKind.fanfare1:
        soundJsonFile.volume.FANFARE1_L = soundSettingInfo.volume.value;
      case SoundSettingKind.fanfare2:
        soundJsonFile.volume.FANFARE2_L = soundSettingInfo.volume.value;
      case SoundSettingKind.fanfare3:
        soundJsonFile.volume.FANFARE3_L = soundSettingInfo.volume.value;
      case SoundSettingKind.verifone:
        soundJsonFile.volume.VERIFONE_L = soundSettingInfo.volume.value;
      case SoundSettingKind.birth:
        soundJsonFile.volume.BIRTH_L = soundSettingInfo.volume.value;
      case SoundSettingKind.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

  /// ガイダンス音声の音情報を設定
  void _setSoundJsonGuidance({
    required SoundSettingInfo soundSettingInfo,
    required SoundJsonFile soundJsonFile,
  }) {
      soundJsonFile.guidance.right_volume = soundSettingInfo.volume.value;
      soundJsonFile.guidance.left_volume = soundSettingInfo.volume.value;
  }
  
  /// 設定ファイルから音量と種類を読み込む
  Future<void> _loadSoundJson() async {

    // 共有メモリを取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_writeTrm() rxMemRead RXMEM_COMMON get error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    // SoundJsonFileを読込む
    SoundJsonFile soundJsonFile = SoundJsonFile();
    await soundJsonFile.load();

    // 本体側の音情報を取得
    SoundSettingTarget soundSettingTarget = SoundSettingTarget.mainBody;
    tabList.add(SoundSettingTargetInfo(
      soundSettingTarget: soundSettingTarget,
      soundSettingInfoList: await _getSoundJsonR(
        soundJsonFile: soundJsonFile,
      ),
    ));

    //「タワー側」：sys.iniの[type]セクションtowerが"yes"の時のみ使用可
    if (pCom.iniSys_tower) {
      // タワー側の音情報を取得
      soundSettingTarget = SoundSettingTarget.tower;
      tabList.add(SoundSettingTargetInfo(
        soundSettingTarget: soundSettingTarget,
        soundSettingInfoList: await _getSoundJsonL(
          soundJsonFile: soundJsonFile,
        ),
      ));
    }

    // TODO:表示切り替え処理を一旦コメントアウトにする
    //「客側表示パネル」：add_tpanel_connectが0でない時のみ使用可
    // if (pCom.addTpanelConnect != 0) {
      // 客側表示パネルの音情報を取得
      soundSettingTarget = SoundSettingTarget.customerPanel;
      tabList.add(SoundSettingTargetInfo(
        soundSettingTarget: soundSettingTarget,
        soundSettingInfoList: await _getSoundJsonL(
          soundJsonFile: soundJsonFile,
        ),
      ));
    // }

    // TODO:表示切り替え処理を一旦コメントアウトにする
    //「ガイダンス音声」：cm front self systemが0でない 且つ add_tpanel_connectが0でない時のみ使用可
    // if (await CmCksys.cmFrontSelfSystem() != 0
    //     && pCom.addTpanelConnect != 0) {
      // ガイダンス音声の音情報を取得
      soundSettingTarget = SoundSettingTarget.guidance;
      tabList.add(SoundSettingTargetInfo(
        soundSettingTarget: soundSettingTarget,
        soundSettingInfoList: await _getSoundJsonGuidance(
          soundJsonFile: soundJsonFile,
        ),
      ));
    // }
  }

  /// 本体側の音情報を取得
  Future<RxList<SoundSettingInfo>> _getSoundJsonR({
    required SoundJsonFile soundJsonFile,
  }) async {
    List<SoundSettingInfo> soundSettingInfoList = <SoundSettingInfo>[];
    int volume = 0;
    int num = 0;
    SoundKind soundKind;
    for (SoundSettingKind soundSettingKind in SoundSettingKind.values) {
      // 設定値を取得する
      switch (soundSettingKind) {
        case SoundSettingKind.tap:
          volume = soundJsonFile.volume.G1R;
          num = soundJsonFile.pitch.CLICK_NUM_R;
          soundKind = SoundKind.tap;
        case SoundSettingKind.error:
          volume = soundJsonFile.volume.ERR_R;
          num = soundJsonFile.pitch.ERR_NUM_R;
          soundKind = SoundKind.error;
        case SoundSettingKind.warning:
          volume = soundJsonFile.volume.WARN_R;
          num = soundJsonFile.pitch.WARNING_NUM_R;
          soundKind = SoundKind.warning;
        case SoundSettingKind.popup:
          volume = soundJsonFile.volume.POPUP_R;
          num = soundJsonFile.pitch.POPUP_NUM_R;
          soundKind = SoundKind.popup;
        case SoundSettingKind.fanfare1:
          volume = soundJsonFile.volume.FANFARE1_R;
          num = soundJsonFile.pitch.FANFARE1_NUM_R;
          soundKind = SoundKind.fanfare1;
        case SoundSettingKind.fanfare2:
          volume = soundJsonFile.volume.FANFARE2_R;
          num = soundJsonFile.pitch.FANFARE2_NUM_R;
          soundKind = SoundKind.fanfare2;
        case SoundSettingKind.fanfare3:
          volume = soundJsonFile.volume.FANFARE3_R;
          num = soundJsonFile.pitch.FANFARE3_NUM_R;
          soundKind = SoundKind.fanfare3;
        case SoundSettingKind.verifone:
          volume = soundJsonFile.volume.VERIFONE_R;
          num = soundJsonFile.pitch.VERIFONE_NUM_R;
          soundKind = SoundKind.verifone;
        case SoundSettingKind.birth:
          volume = soundJsonFile.volume.BIRTH_R;
          num = soundJsonFile.pitch.BIRTH_NUM_R;
          soundKind = SoundKind.birth;
        case SoundSettingKind.guidance:
          continue;   // ここではガイダンス音声は扱わないのでスキップ
      }
      // 番号の一覧を取得する
      List<int> numList = await SoundFileUtil.getNumberList(soundKind);
      soundSettingInfoList.add(
        SoundSettingInfo(
          soundSettingKind: soundSettingKind,
          volume: volume.obs,
          num: num.obs,
          numList: numList,
        ),
      );
    }

    return soundSettingInfoList.obs;
  }

  /// 客側表示パネル（タワー側）の音情報を取得
  Future<RxList<SoundSettingInfo>> _getSoundJsonL({
    required SoundJsonFile soundJsonFile,
  }) async {
    List<SoundSettingInfo> soundSettingInfoList = <SoundSettingInfo>[];
    int volume = 0;
    int num = 0;
    SoundKind soundKind;
    for (SoundSettingKind soundSettingKind in SoundSettingKind.values) {
      // 設定値を取得する
      switch (soundSettingKind) {
        case SoundSettingKind.tap:
          volume = soundJsonFile.volume.G1L;
          num = soundJsonFile.pitch.CLICK_NUM_L;
          soundKind = SoundKind.tap;
        case SoundSettingKind.error:
          volume = soundJsonFile.volume.ERR_L;
          num = soundJsonFile.pitch.ERR_NUM_L;
          soundKind = SoundKind.error;
        case SoundSettingKind.warning:
          volume = soundJsonFile.volume.WARN_L;
          num = soundJsonFile.pitch.WARNING_NUM_L;
          soundKind = SoundKind.warning;
        case SoundSettingKind.popup:
          volume = soundJsonFile.volume.POPUP_L;
          num = soundJsonFile.pitch.POPUP_NUM_L;
          soundKind = SoundKind.popup;
        case SoundSettingKind.fanfare1:
          volume = soundJsonFile.volume.FANFARE1_L;
          num = soundJsonFile.pitch.FANFARE1_NUM_L;
          soundKind = SoundKind.fanfare1;
        case SoundSettingKind.fanfare2:
          volume = soundJsonFile.volume.FANFARE2_L;
          num = soundJsonFile.pitch.FANFARE2_NUM_L;
          soundKind = SoundKind.fanfare2;
        case SoundSettingKind.fanfare3:
          volume = soundJsonFile.volume.FANFARE3_L;
          num = soundJsonFile.pitch.FANFARE3_NUM_L;
          soundKind = SoundKind.fanfare3;
        case SoundSettingKind.verifone:
          volume = soundJsonFile.volume.VERIFONE_L;
          num = soundJsonFile.pitch.VERIFONE_NUM_L;
          soundKind = SoundKind.verifone;
        case SoundSettingKind.birth:
          volume = soundJsonFile.volume.BIRTH_L;
          num = soundJsonFile.pitch.BIRTH_NUM_L;
          soundKind = SoundKind.birth;
        case SoundSettingKind.guidance:
          continue;   // ここではガイダンス音声は扱わないのでスキップ
      }
      // 番号の一覧を取得する
      List<int> numList = await SoundFileUtil.getNumberList(soundKind);
      soundSettingInfoList.add(
        SoundSettingInfo(
          soundSettingKind: soundSettingKind,
          volume: volume.obs,
          num: num.obs,
          numList: numList,
        ),
      );
    }

    return soundSettingInfoList.obs;
  }

  /// ガイダンス音声の音情報を取得
  Future<RxList<SoundSettingInfo>> _getSoundJsonGuidance({
    required SoundJsonFile soundJsonFile,
  }) async {
    List<SoundSettingInfo> soundSettingInfoList = <SoundSettingInfo>[];

    // ガイダンス音声は、right_volume/left_volumeとあるが、値が同じなので、right_volumeのみ取得
    soundSettingInfoList.add(
      SoundSettingInfo(
        soundSettingKind: SoundSettingKind.guidance,
        volume: soundJsonFile.guidance.right_volume.obs,
        num: 0.obs,
        numList: [],
      ),
    );

    return soundSettingInfoList.obs;
  }

  /// 音の名称
  String getSoundName(SoundSettingInfo soundSettingInfo) {
    int num = soundSettingInfo.num.value;
    // numが0の場合は、音の名称に連結しない
    if (num != 0) {
      return '${soundSettingInfo.soundSettingKind.name}$num';
    } else {
      return soundSettingInfo.soundSettingKind.name;
    }
  }

  /// -ボタンで音量を下げる
  bool volumeDown(SoundSettingInfo soundSettingInfo) {
    if (soundSettingInfo.volume > SoundSettingController.volumeMin) {
      soundSettingInfo.volume -= 1;
      return true;
    } else {
      return false;
    }
  }

  /// +ボタンで音量を上げる
  bool volumeUp(SoundSettingInfo soundSettingInfo) {
    if (soundSettingInfo.volume < SoundSettingController.volumeMax) {
      soundSettingInfo.volume += 1;
      return true;
    } else {
      return false;
    }
  }

  /// スライダーで音量を調整する
  void volumeChange(SoundSettingInfo soundSettingInfo, int volume) {
    soundSettingInfo.volume.value = volume;
  }

  /// 選択画面へ遷移する
  void goToSelectionPage(SoundSettingInfo soundSettingInfo) {
    // 再生中の音を停止する
    _stopPlayer();
    // 本体側のタッチ音を再生する
    IfSound.ifBz();
    // 選択画面へ遷移する
    Get.to(() => SoundSelectionPage(
      soundSettingTarget: tabList[tabSelectedIndex.value].soundSettingTarget,
      soundSettingInfo: soundSettingInfo,
    ));
  }

  /// 設定画面から一つ前の画面に戻る
  void backToPreviousPage() {
    // 再生中の音を停止する
    _stopPlayer();
    // 本体側のタッチ音を再生する
    IfSound.ifBz();
    // 一つ前の画面に戻る
    Get.back();
  }

  /// 本体側と客側を切り替える
  void changeTab(int idx) {
    // 再生中の音を停止する
    _stopPlayer();
    // 本体側のタッチ音を再生する
    IfSound.ifBz();
    // 本体側と客側を切り替える
    pageController.jumpToPage(idx);
  }

  /// 再生中の音を停止する
  void _stopPlayer() {
    switch (tabList[tabSelectedIndex.value].soundSettingTarget) {
      case SoundSettingTarget.mainBody || SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        // 本体側で再生するか客側で再生するかを取得する
        TprMID tid = _getTid();             // Tpraid.TPRAID_SOUNDは本体側、Tpraid.TPRAID_SOUND2が客側
        // 再生中の音を停止する
        Sound().playStop(tid: tid);
      case SoundSettingTarget.guidance:
        // ガイダンス音声の停止
        RcSound.stop();
    }
  }

  /// 本体側で再生するか客側で再生するかを取得する
  TprMID _getTid() {
    switch (tabList[tabSelectedIndex.value].soundSettingTarget) {
      case SoundSettingTarget.mainBody:
        return Tpraid.TPRAID_SOUND;
      case SoundSettingTarget.tower || SoundSettingTarget.customerPanel:
        return Tpraid.TPRAID_SOUND2;
      case SoundSettingTarget.guidance:
        throw AssertionError();   // ガイダンス音声になるケースはありえない
    }
  }

}

/// 本体側、客側表示パネル（タワー側）毎の音の情報を持つデータクラス
class SoundSettingTargetInfo {
  /// コンストラクタ
  SoundSettingTargetInfo({
    required this.soundSettingTarget,
    required this.soundSettingInfoList,
  });

  /// 設定の対象
  final SoundSettingTarget soundSettingTarget;
  /// 音の情報を持つデータクラス
  final RxList<SoundSettingInfo> soundSettingInfoList;
}

/// 音の情報を持つデータクラス
class SoundSettingInfo {
  /// コンストラクタ
  SoundSettingInfo({
    required this.soundSettingKind,
    required this.volume,
    required this.num,
    required this.numList,
  });

  /// 音の設定画面で扱う音の種類
  final SoundSettingKind soundSettingKind;
  /// 音量
  RxInt volume;
  /// 音の選択番号（タッチ音1、タッチ音2等）
  RxInt num;
  /// 音の選択番号のリスト
  final List<int> numList;
}
