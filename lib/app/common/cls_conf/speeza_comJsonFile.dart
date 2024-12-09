/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'speeza_comJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Speeza_comJsonFile extends ConfigJsonFile {
  static final Speeza_comJsonFile _instance = Speeza_comJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "speeza_com.json";

  Speeza_comJsonFile(){
    setPath(_confPath, _fileName);
  }
  Speeza_comJsonFile._internal();

  factory Speeza_comJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Speeza_comJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Speeza_comJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Speeza_comJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        QcSelect = _$QQcSelectFromJson(jsonD['QcSelect']);
      } catch(e) {
        QcSelect = _$QQcSelectFromJson({});
        ret = false;
      }
      try {
        StatusMenu = _$SStatusMenuFromJson(jsonD['StatusMenu']);
      } catch(e) {
        StatusMenu = _$SStatusMenuFromJson({});
        ret = false;
      }
      try {
        StatusWait = _$SStatusWaitFromJson(jsonD['StatusWait']);
      } catch(e) {
        StatusWait = _$SStatusWaitFromJson({});
        ret = false;
      }
      try {
        StatusActive = _$SStatusActiveFromJson(jsonD['StatusActive']);
      } catch(e) {
        StatusActive = _$SStatusActiveFromJson({});
        ret = false;
      }
      try {
        StatusCall = _$SStatusCallFromJson(jsonD['StatusCall']);
      } catch(e) {
        StatusCall = _$SStatusCallFromJson({});
        ret = false;
      }
      try {
        StatusOffline = _$SStatusOfflineFromJson(jsonD['StatusOffline']);
      } catch(e) {
        StatusOffline = _$SStatusOfflineFromJson({});
        ret = false;
      }
      try {
        StatusAnotherActive = _$SStatusAnotherActiveFromJson(jsonD['StatusAnotherActive']);
      } catch(e) {
        StatusAnotherActive = _$SStatusAnotherActiveFromJson({});
        ret = false;
      }
      try {
        StatusMente = _$SStatusMenteFromJson(jsonD['StatusMente']);
      } catch(e) {
        StatusMente = _$SStatusMenteFromJson({});
        ret = false;
      }
      try {
        StatusCreateMax = _$SStatusCreateMaxFromJson(jsonD['StatusCreateMax']);
      } catch(e) {
        StatusCreateMax = _$SStatusCreateMaxFromJson({});
        ret = false;
      }
      try {
        StatusPause = _$SStatusPauseFromJson(jsonD['StatusPause']);
      } catch(e) {
        StatusPause = _$SStatusPauseFromJson({});
        ret = false;
      }
      try {
        StatusPrecaBalSht = _$SStatusPrecaBalShtFromJson(jsonD['StatusPrecaBalSht']);
      } catch(e) {
        StatusPrecaBalSht = _$SStatusPrecaBalShtFromJson({});
        ret = false;
      }
      try {
        StatusPrecaChg = _$SStatusPrecaChgFromJson(jsonD['StatusPrecaChg']);
      } catch(e) {
        StatusPrecaChg = _$SStatusPrecaChgFromJson({});
        ret = false;
      }
      try {
        StatusCoinFullRecover = _$SStatusCoinFullRecoverFromJson(jsonD['StatusCoinFullRecover']);
      } catch(e) {
        StatusCoinFullRecover = _$SStatusCoinFullRecoverFromJson({});
        ret = false;
      }
      try {
        StatusTerminal = _$SStatusTerminalFromJson(jsonD['StatusTerminal']);
      } catch(e) {
        StatusTerminal = _$SStatusTerminalFromJson({});
        ret = false;
      }
      try {
        CautionNormal = _$CCautionNormalFromJson(jsonD['CautionNormal']);
      } catch(e) {
        CautionNormal = _$CCautionNormalFromJson({});
        ret = false;
      }
      try {
        CautionAcxErr = _$CCautionAcxErrFromJson(jsonD['CautionAcxErr']);
      } catch(e) {
        CautionAcxErr = _$CCautionAcxErrFromJson({});
        ret = false;
      }
      try {
        CautionAcxEnd = _$CCautionAcxEndFromJson(jsonD['CautionAcxEnd']);
      } catch(e) {
        CautionAcxEnd = _$CCautionAcxEndFromJson({});
        ret = false;
      }
      try {
        CautionAcxFull = _$CCautionAcxFullFromJson(jsonD['CautionAcxFull']);
      } catch(e) {
        CautionAcxFull = _$CCautionAcxFullFromJson({});
        ret = false;
      }
      try {
        CautionRcptEnd = _$CCautionRcptEndFromJson(jsonD['CautionRcptEnd']);
      } catch(e) {
        CautionRcptEnd = _$CCautionRcptEndFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _QQcSelect QcSelect = _QQcSelect(
    ChangeAmountType                   : 0,
    PopUpType                          : 0,
    CautionType                        : 0,
    QCSel_Rpr_ItemPrn                  : 0,
    Stl_Pushed_Expand                  : 0,
    ChaTranSpeezaUpd                   : 0,
    Disp_Preca_Bal_Sht                 : 0,
  );

  _SStatusMenu StatusMenu = _SStatusMenu(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusWait StatusWait = _SStatusWait(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusActive StatusActive = _SStatusActive(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusCall StatusCall = _SStatusCall(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusOffline StatusOffline = _SStatusOffline(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusAnotherActive StatusAnotherActive = _SStatusAnotherActive(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusMente StatusMente = _SStatusMente(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusCreateMax StatusCreateMax = _SStatusCreateMax(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusPause StatusPause = _SStatusPause(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusPrecaBalSht StatusPrecaBalSht = _SStatusPrecaBalSht(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusPrecaChg StatusPrecaChg = _SStatusPrecaChg(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusCoinFullRecover StatusCoinFullRecover = _SStatusCoinFullRecover(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _SStatusTerminal StatusTerminal = _SStatusTerminal(
    return_time                        : 0,
  );

  _CCautionNormal CautionNormal = _CCautionNormal(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _CCautionAcxErr CautionAcxErr = _CCautionAcxErr(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _CCautionAcxEnd CautionAcxEnd = _CCautionAcxEnd(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _CCautionAcxFull CautionAcxFull = _CCautionAcxFull(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );

  _CCautionRcptEnd CautionRcptEnd = _CCautionRcptEnd(
    Message                            : "",
    BackColor                          : 0,
    TextColor                          : 0,
  );
}

@JsonSerializable()
class _QQcSelect {
  factory _QQcSelect.fromJson(Map<String, dynamic> json) => _$QQcSelectFromJson(json);
  Map<String, dynamic> toJson() => _$QQcSelectToJson(this);

  _QQcSelect({
    required this.ChangeAmountType,
    required this.PopUpType,
    required this.CautionType,
    required this.QCSel_Rpr_ItemPrn,
    required this.Stl_Pushed_Expand,
    required this.ChaTranSpeezaUpd,
    required this.Disp_Preca_Bal_Sht,
  });

  @JsonKey(defaultValue: 0)
  int    ChangeAmountType;
  @JsonKey(defaultValue: 0)
  int    PopUpType;
  @JsonKey(defaultValue: 0)
  int    CautionType;
  @JsonKey(defaultValue: 0)
  int    QCSel_Rpr_ItemPrn;
  @JsonKey(defaultValue: 0)
  int    Stl_Pushed_Expand;
  @JsonKey(defaultValue: 0)
  int    ChaTranSpeezaUpd;
  @JsonKey(defaultValue: 0)
  int    Disp_Preca_Bal_Sht;
}

@JsonSerializable()
class _SStatusMenu {
  factory _SStatusMenu.fromJson(Map<String, dynamic> json) => _$SStatusMenuFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusMenuToJson(this);

  _SStatusMenu({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "ﾒﾆｭｰ")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusWait {
  factory _SStatusWait.fromJson(Map<String, dynamic> json) => _$SStatusWaitFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusWaitToJson(this);

  _SStatusWait({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "待機")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusActive {
  factory _SStatusActive.fromJson(Map<String, dynamic> json) => _$SStatusActiveFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusActiveToJson(this);

  _SStatusActive({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "使用中")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusCall {
  factory _SStatusCall.fromJson(Map<String, dynamic> json) => _$SStatusCallFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusCallToJson(this);

  _SStatusCall({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "CALL")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusOffline {
  factory _SStatusOffline.fromJson(Map<String, dynamic> json) => _$SStatusOfflineFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusOfflineToJson(this);

  _SStatusOffline({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "ｵﾌﾗｲﾝ")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusAnotherActive {
  factory _SStatusAnotherActive.fromJson(Map<String, dynamic> json) => _$SStatusAnotherActiveFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusAnotherActiveToJson(this);

  _SStatusAnotherActive({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "使用中")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusMente {
  factory _SStatusMente.fromJson(Map<String, dynamic> json) => _$SStatusMenteFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusMenteToJson(this);

  _SStatusMente({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "ﾒﾝﾃﾅﾝｽ")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusCreateMax {
  factory _SStatusCreateMax.fromJson(Map<String, dynamic> json) => _$SStatusCreateMaxFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusCreateMaxToJson(this);

  _SStatusCreateMax({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "使用中")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusPause {
  factory _SStatusPause.fromJson(Map<String, dynamic> json) => _$SStatusPauseFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusPauseToJson(this);

  _SStatusPause({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "休止")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusPrecaBalSht {
  factory _SStatusPrecaBalSht.fromJson(Map<String, dynamic> json) => _$SStatusPrecaBalShtFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusPrecaBalShtToJson(this);

  _SStatusPrecaBalSht({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "残高不足")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusPrecaChg {
  factory _SStatusPrecaChg.fromJson(Map<String, dynamic> json) => _$SStatusPrecaChgFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusPrecaChgToJson(this);

  _SStatusPrecaChg({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "ﾁｬｰｼﾞ中")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusCoinFullRecover {
  factory _SStatusCoinFullRecover.fromJson(Map<String, dynamic> json) => _$SStatusCoinFullRecoverFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusCoinFullRecoverToJson(this);

  _SStatusCoinFullRecover({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "ﾌﾙ解除")
  String Message;
  @JsonKey(defaultValue: 44)
  int    BackColor;
  @JsonKey(defaultValue: 23)
  int    TextColor;
}

@JsonSerializable()
class _SStatusTerminal {
  factory _SStatusTerminal.fromJson(Map<String, dynamic> json) => _$SStatusTerminalFromJson(json);
  Map<String, dynamic> toJson() => _$SStatusTerminalToJson(this);

  _SStatusTerminal({
    required this.return_time,
  });

  @JsonKey(defaultValue: 2)
  int    return_time;
}

@JsonSerializable()
class _CCautionNormal {
  factory _CCautionNormal.fromJson(Map<String, dynamic> json) => _$CCautionNormalFromJson(json);
  Map<String, dynamic> toJson() => _$CCautionNormalToJson(this);

  _CCautionNormal({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "")
  String Message;
  @JsonKey(defaultValue: 35)
  int    BackColor;
  @JsonKey(defaultValue: 15)
  int    TextColor;
}

@JsonSerializable()
class _CCautionAcxErr {
  factory _CCautionAcxErr.fromJson(Map<String, dynamic> json) => _$CCautionAcxErrFromJson(json);
  Map<String, dynamic> toJson() => _$CCautionAcxErrToJson(this);

  _CCautionAcxErr({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "釣機ｴﾗｰ")
  String Message;
  @JsonKey(defaultValue: 35)
  int    BackColor;
  @JsonKey(defaultValue: 15)
  int    TextColor;
}

@JsonSerializable()
class _CCautionAcxEnd {
  factory _CCautionAcxEnd.fromJson(Map<String, dynamic> json) => _$CCautionAcxEndFromJson(json);
  Map<String, dynamic> toJson() => _$CCautionAcxEndToJson(this);

  _CCautionAcxEnd({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "お釣不足")
  String Message;
  @JsonKey(defaultValue: 35)
  int    BackColor;
  @JsonKey(defaultValue: 15)
  int    TextColor;
}

@JsonSerializable()
class _CCautionAcxFull {
  factory _CCautionAcxFull.fromJson(Map<String, dynamic> json) => _$CCautionAcxFullFromJson(json);
  Map<String, dynamic> toJson() => _$CCautionAcxFullToJson(this);

  _CCautionAcxFull({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "お釣過剰")
  String Message;
  @JsonKey(defaultValue: 35)
  int    BackColor;
  @JsonKey(defaultValue: 15)
  int    TextColor;
}

@JsonSerializable()
class _CCautionRcptEnd {
  factory _CCautionRcptEnd.fromJson(Map<String, dynamic> json) => _$CCautionRcptEndFromJson(json);
  Map<String, dynamic> toJson() => _$CCautionRcptEndToJson(this);

  _CCautionRcptEnd({
    required this.Message,
    required this.BackColor,
    required this.TextColor,
  });

  @JsonKey(defaultValue: "ﾚｼｰﾄ交換")
  String Message;
  @JsonKey(defaultValue: 35)
  int    BackColor;
  @JsonKey(defaultValue: 15)
  int    TextColor;
}

