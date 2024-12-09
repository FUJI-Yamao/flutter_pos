/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import '../../common/cls_conf/soundJsonFile.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../ui/enum/e_screen_kind.dart';
import 'sound_def.dart';
import 'sound_file_util.dart';
import 'sound_info.dart';

/// サウンド関連の処理（シングルトン）
/// 関連tprxソース:\lib\cm_sound\sound_start.c、lib\cm_sound\sound_stop.c、\sys\sound\sound.c
class Sound {
  static final Sound _instance = Sound._internal();

  factory Sound() {
    // 初期化されていないと例外をスローする
    return _instance;
  }

  Sound._internal();

  /// 初期化フラグ
  bool _isInitialize = false;

  /// タッチ音用のAudioPlayer
  final AudioPlayer _playerTap = AudioPlayer();

  /// 多重再生用のプレイヤーの数
  static const _multiPlayerCount = 5;

  /// 多重再生用のプレイヤー
  final List<AudioPlayer> _multiPlayerList = [];

  /// 多重再生用のプレイヤーの再生中かのフラグ
  final List<bool> _multiPlayerStatusList = [];

  /// サウンド情報
  final SoundInfo soundInfo = SoundInfo();

  /// サウンドファイルのソーステキスト
  String sourceText = '';

  /// 初期化
  Future<void> initialize() async {
    // 初期化フラグを参照して、一度しか実行されないようにする
    if (!_isInitialize) {
      _isInitialize = true;

      // 音声ファイルのルートディレクトリを決定
      SoundFileUtil.initialize();

      // registerプロセスの時だけ、ファイルコピーする
      if (EnvironmentData().screenKind == ScreenKind.register) {
        // Assetsフォルダ内の音声ファイルをユーザーディレクトリにコピーする
        await SoundFileUtil.copyFiles(tid: Tpraid.TPRAID_SOUND);
      }

      // 多重再生用のプレイヤーのインスタンス作成
      for (int i = 0; i < _multiPlayerCount; i++ ) {
        AudioPlayer player = AudioPlayer();
        player.onPlayerComplete.listen((_) {
          debugPrint('Sound::onPlayerComplete idx=$i');
          _multiPlayerStatusList[i] = false;
        });
        _multiPlayerList.add(player);
        _multiPlayerStatusList.add(false);
      }

      // 再初期化
      await reinitialize();
    }
  }

  /// 再初期化
  Future<void> reinitialize() async {
    try {
      // sound.jsonの読み込み
      SoundJsonFile soundJson = SoundJsonFile();
      await soundJson.load();

      // サウンド情報を初期化
      soundInfo.initialize(soundJson);
    } catch (e, s) {
      TprMID tid = (EnvironmentData().screenKind == ScreenKind.register) ? Tpraid.TPRAID_SOUND : Tpraid.TPRAID_SOUND2;
      TprLog().logAdd(tid, LogLevelDefine.error, "Sound soundJson.load error\n$e\n$s");
    }
  }

  /// タッチ音を鳴らす
  Future<void> playTapSound({
    required TprMID tid
  }) async {
    // tidのチェック
    tid = _checkTid(tid);

    // 停止 or リソース解放する
    _stopOrRelesse(tid: tid, player: _playerTap);

    // タッチ音
    SoundKind soundKind = SoundKind.tap;

    // 音声ファイル名を取得
    String fileName = await soundInfo.getSoundFileName(
      tid: tid,
      soundKind: soundKind,
    );

    // 音量とバランスを取得
    SoundVolume soundVolume = soundInfo.getSoundVolume(
      tid: tid,
      soundVolumeKind: soundKind.soundVolumeKind,
    );

    // タッチ音を鳴らす
    _playFile(
      tid: tid,
      player: _playerTap,
      fileName: fileName,
      volume: soundVolume.volume,
      balance: soundVolume.balance,
    );
  }

  /// 指定された音を鳴らす
  Future<void> playSound({
    required TprMID tid,
    required SoundKind soundKind,
  }) async {
    assert(soundKind != SoundKind.tap);   // タッチ音は、playTapSound関数で鳴らすこと！

    // tidのチェック
    tid = _checkTid(tid);

    // 音声ファイル名を取得
    String fileName = await soundInfo.getSoundFileName(
      tid: tid,
      soundKind: soundKind,
    );

    // 音量とバランスを取得
    SoundVolume soundVolume = soundInfo.getSoundVolume(
      tid: tid,
      soundVolumeKind: soundKind.soundVolumeKind,
    );

    // 空いているplayerで音を再生する
    _playMulti(
      tid: tid,
      fileName: fileName,
      soundVolume: soundVolume,
    );
  }

  /// 指定されたローカルファイルを鳴らす（音の設定画面で使用）
  void playSoundForFile({
    required TprMID tid,
    required String fileName,
    required SoundVolumeKind soundVolumeKind,
    bool isLoop = false,
  }) {
    // tidのチェック
    tid = _checkTid(tid);

    // ループ再生中の音を停止するために、sourceTextをクリアする
    sourceText = '';

    // 音量とバランスを取得
    SoundVolume soundVolume = soundInfo.getSoundVolume(
      tid: tid,
      soundVolumeKind: soundVolumeKind,
    );

    // 空いているplayerで音を再生する
    _playMulti(
      tid: tid,
      fileName: fileName,
      soundVolume: soundVolume,
      isLoop: isLoop,
    );
  }

  /// 再生中の音を停止する
  void playStop({
    required TprMID tid
  }) {
    // tidのチェック
    tid = _checkTid(tid);

    // 再生中の音声を全て停止する
    for (int i = 0; i < _multiPlayerCount; i++ ) {
      if (_multiPlayerStatusList[i]) {
        _multiPlayerStatusList[i] = false;
        // 停止 or リソース解放する
        _stopOrRelesse(tid: tid, player: _multiPlayerList[i]);
        TprLog().logAdd(
          tid,
          LogLevelDefine.normal,
          "sound AudioPlayer stop index=$i",
        );
      }
    }
  }

  /// 再生中の音を同期的に停止する
  Future<void> syncPlayStop({
    required TprMID tid
  }) async {
    // tidのチェック
    tid = _checkTid(tid);

    // ループ再生中の音を停止するために、sourceTextをクリアする
    sourceText = '';

    // 再生中の音声を全て停止する
    for (int i = 0; i < _multiPlayerCount; i++ ) {
      if (_multiPlayerStatusList[i]) {
        _multiPlayerStatusList[i] = false;
        // 停止 or リソース解放する
        await _syncStopOrRelesse(tid: tid, player: _multiPlayerList[i]);
        TprLog().logAdd(
          tid,
          LogLevelDefine.normal,
          "sound AudioPlayer stop index=$i",
        );
      }
    }
  }

  // 空いているplayerで音を再生する
  void _playMulti({
    required TprMID tid,
    required String fileName,
    required SoundVolume soundVolume,
    bool isLoop = false,
  }) {
    int index = _multiPlayerStatusList.indexWhere((e) => e == false);
    if (index >= 0) {
      _multiPlayerStatusList[index] = true;

      _playFile(
        tid: tid,
        player: _multiPlayerList[index],
        fileName: fileName,
        volume: soundVolume.volume,
        balance: soundVolume.balance,
        index: index,
        isLoop: isLoop,
      );
    } else {
      // 空いてるplayerがないのでログ出力
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound multiPlayer busy",
      );
    }
  }

  /// ローカルファイルを再生
  void _playFile({
    required TprMID tid,
    required AudioPlayer player,
    required String fileName,
    required double volume,
    required double balance,
    int index = 0,
    bool isLoop = false,
  }) {
    // 音声ファイルの存在確認
    if (File(fileName).existsSync()) {
      Source source = DeviceFileSource(fileName);
      sourceText = source.toString();
      if (isLoop) {
        // ループ再生
        _loopPlay(
          tid: tid,
          player: player,
          source: source,
          volume: volume,
          balance: balance,
          index: index,
        );
      } else {
        // 一回再生
        _play(
          tid: tid,
          player: player,
          source: source,
          volume: volume,
          balance: balance,
          index: index,
        );
      }
    } else {
      // 音声ファイルが存在しない場合は、ログ出力のみ
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound _playFile Not Found File $fileName",
      );
    }
  }

  /// 再生
  void _play({
    required TprMID tid,
    required AudioPlayer player,
    required Source source,
    required double volume,
    required double balance,
    required int index,
  }) {
    TprLog().logAdd(
      tid,
      LogLevelDefine.normal,
      "sound AudioPlayer play ${source.toString()} volume=$volume balance=$balance index=$index",
    );

    // 音を再生する
    player.play(source, volume: volume, balance: balance).catchError((e) {
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound AudioPlayer play error $e",
      );
    });
  }

  /// ループで音声再生を行う
  /// [tid] tid
  /// [player] AudioPlayer
  /// [source] 音声ファイル
  /// [volume] 音量
  /// [balance] ステレオバランス
  /// [index] プレイヤーのインデックス
  Future<void> _loopPlay({
    required TprMID tid,
    required AudioPlayer player,
    required Source source,
    required double volume,
    required double balance,
    required int index,
  }) async {
    TprLog().logAdd(
      tid,
      LogLevelDefine.normal,
      "sound AudioPlayer play ${source.toString()} volume=$volume balance=$balance index=$index",
    );

    // 音を再生する
    while (sourceText == source.toString()) {
      await player
          .play(source, volume: volume, balance: balance)
          .catchError((e) {
        TprLog().logAdd(
          tid,
          LogLevelDefine.error,
          "sound AudioPlayer play error $e",
        );
      });

      await Future.delayed(
          const Duration(milliseconds: SoundDef.guidanceRepeatInterval));
    }
  }

  /// 停止
  void _stop({
    required TprMID tid,
    required AudioPlayer player,
  }) {
    // 再生中の音を停止する
    player.stop().catchError((e) {
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound AudioPlayer stop error $e",
      );
    });
  }

  /// リソースを解放
  void _release({
    required TprMID tid,
    required AudioPlayer player,
  }) {
    // release関数内でstop関数が呼ばれている
    player.release().catchError((e) {
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound AudioPlayer release error $e",
      );
    });
  }

  /// 停止 or リソース解放する
  void _stopOrRelesse({
    required TprMID tid,
    required AudioPlayer player,
  }) {
    // 2024/02/28 ubuntu環境でstop⇒playすると、音が鳴らない時がある。
    // 回避として、インスタンスを再生成する
    // 2024/03/26 dispose→生成→playだと、windows環境でボタン連打するとアプリが落ちる現象があった。
    // 回避として、release→playに変更する

    if (Platform.isLinux) {
      // リソースを解放
      _release(tid: tid, player: player);
    } else {
      // 停止
      _stop(tid: tid, player: player);
    }
  }

  /// tidのチェック
  TprMID _checkTid(TprMID tid) {
    // TPRAID_SOUND/TPRAID_SOUND2以外の場合は、TPRAID_SOUNDとして扱う
    if (tid != Tpraid.TPRAID_SOUND && tid != Tpraid.TPRAID_SOUND2) {
      TprLog().logAdd(
        Tpraid.TPRAID_SOUND,
        LogLevelDefine.normal,
        "sound from tid:$tid",
      );
      return Tpraid.TPRAID_SOUND;
    }
    return tid;
  }

  /// 同期的に停止
  Future<void> _syncStop({
    required TprMID tid,
    required AudioPlayer player,
  }) async {
    // 再生中の音を停止する
    await player.stop().catchError((e) {
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound AudioPlayer stop error $e",
      );
    });
  }

  /// 同期的にリソースを解放
  Future<void> _syncRelease({
    required TprMID tid,
    required AudioPlayer player,
  }) async {
    // release関数内でstop関数が呼ばれている
    await player.release().catchError((e) {
      TprLog().logAdd(
        tid,
        LogLevelDefine.error,
        "sound AudioPlayer release error $e",
      );
    });
  }

  /// 同期的に停止 or リソース解放する
  Future<void> _syncStopOrRelesse({
    required TprMID tid,
    required AudioPlayer player,
  }) async {
    // 2024/02/28 ubuntu環境でstop⇒playすると、音が鳴らない時がある。
    // 回避として、インスタンスを再生成する
    // 2024/03/26 dispose→生成→playだと、windows環境でボタン連打するとアプリが落ちる現象があった。
    // 回避として、release→playに変更する

    if (Platform.isLinux) {
      // リソースを解放
      await _syncRelease(tid: tid, player: player);
    } else {
      // 停止
      await _syncStop(tid: tid, player: player);
    }
  }
}
