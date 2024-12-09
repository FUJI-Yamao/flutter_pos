// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speeza_comJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speeza_comJsonFile _$Speeza_comJsonFileFromJson(Map<String, dynamic> json) =>
    Speeza_comJsonFile()
      ..QcSelect = _QQcSelect.fromJson(json['QcSelect'] as Map<String, dynamic>)
      ..StatusMenu =
          _SStatusMenu.fromJson(json['StatusMenu'] as Map<String, dynamic>)
      ..StatusWait =
          _SStatusWait.fromJson(json['StatusWait'] as Map<String, dynamic>)
      ..StatusActive =
          _SStatusActive.fromJson(json['StatusActive'] as Map<String, dynamic>)
      ..StatusCall =
          _SStatusCall.fromJson(json['StatusCall'] as Map<String, dynamic>)
      ..StatusOffline = _SStatusOffline.fromJson(
          json['StatusOffline'] as Map<String, dynamic>)
      ..StatusAnotherActive = _SStatusAnotherActive.fromJson(
          json['StatusAnotherActive'] as Map<String, dynamic>)
      ..StatusMente =
          _SStatusMente.fromJson(json['StatusMente'] as Map<String, dynamic>)
      ..StatusCreateMax = _SStatusCreateMax.fromJson(
          json['StatusCreateMax'] as Map<String, dynamic>)
      ..StatusPause =
          _SStatusPause.fromJson(json['StatusPause'] as Map<String, dynamic>)
      ..StatusPrecaBalSht = _SStatusPrecaBalSht.fromJson(
          json['StatusPrecaBalSht'] as Map<String, dynamic>)
      ..StatusPrecaChg = _SStatusPrecaChg.fromJson(
          json['StatusPrecaChg'] as Map<String, dynamic>)
      ..StatusCoinFullRecover = _SStatusCoinFullRecover.fromJson(
          json['StatusCoinFullRecover'] as Map<String, dynamic>)
      ..StatusTerminal = _SStatusTerminal.fromJson(
          json['StatusTerminal'] as Map<String, dynamic>)
      ..CautionNormal = _CCautionNormal.fromJson(
          json['CautionNormal'] as Map<String, dynamic>)
      ..CautionAcxErr = _CCautionAcxErr.fromJson(
          json['CautionAcxErr'] as Map<String, dynamic>)
      ..CautionAcxEnd = _CCautionAcxEnd.fromJson(
          json['CautionAcxEnd'] as Map<String, dynamic>)
      ..CautionAcxFull = _CCautionAcxFull.fromJson(
          json['CautionAcxFull'] as Map<String, dynamic>)
      ..CautionRcptEnd = _CCautionRcptEnd.fromJson(
          json['CautionRcptEnd'] as Map<String, dynamic>);

Map<String, dynamic> _$Speeza_comJsonFileToJson(Speeza_comJsonFile instance) =>
    <String, dynamic>{
      'QcSelect': instance.QcSelect.toJson(),
      'StatusMenu': instance.StatusMenu.toJson(),
      'StatusWait': instance.StatusWait.toJson(),
      'StatusActive': instance.StatusActive.toJson(),
      'StatusCall': instance.StatusCall.toJson(),
      'StatusOffline': instance.StatusOffline.toJson(),
      'StatusAnotherActive': instance.StatusAnotherActive.toJson(),
      'StatusMente': instance.StatusMente.toJson(),
      'StatusCreateMax': instance.StatusCreateMax.toJson(),
      'StatusPause': instance.StatusPause.toJson(),
      'StatusPrecaBalSht': instance.StatusPrecaBalSht.toJson(),
      'StatusPrecaChg': instance.StatusPrecaChg.toJson(),
      'StatusCoinFullRecover': instance.StatusCoinFullRecover.toJson(),
      'StatusTerminal': instance.StatusTerminal.toJson(),
      'CautionNormal': instance.CautionNormal.toJson(),
      'CautionAcxErr': instance.CautionAcxErr.toJson(),
      'CautionAcxEnd': instance.CautionAcxEnd.toJson(),
      'CautionAcxFull': instance.CautionAcxFull.toJson(),
      'CautionRcptEnd': instance.CautionRcptEnd.toJson(),
    };

_QQcSelect _$QQcSelectFromJson(Map<String, dynamic> json) => _QQcSelect(
      ChangeAmountType: json['ChangeAmountType'] as int? ?? 0,
      PopUpType: json['PopUpType'] as int? ?? 0,
      CautionType: json['CautionType'] as int? ?? 0,
      QCSel_Rpr_ItemPrn: json['QCSel_Rpr_ItemPrn'] as int? ?? 0,
      Stl_Pushed_Expand: json['Stl_Pushed_Expand'] as int? ?? 0,
      ChaTranSpeezaUpd: json['ChaTranSpeezaUpd'] as int? ?? 0,
      Disp_Preca_Bal_Sht: json['Disp_Preca_Bal_Sht'] as int? ?? 0,
    );

Map<String, dynamic> _$QQcSelectToJson(_QQcSelect instance) =>
    <String, dynamic>{
      'ChangeAmountType': instance.ChangeAmountType,
      'PopUpType': instance.PopUpType,
      'CautionType': instance.CautionType,
      'QCSel_Rpr_ItemPrn': instance.QCSel_Rpr_ItemPrn,
      'Stl_Pushed_Expand': instance.Stl_Pushed_Expand,
      'ChaTranSpeezaUpd': instance.ChaTranSpeezaUpd,
      'Disp_Preca_Bal_Sht': instance.Disp_Preca_Bal_Sht,
    };

_SStatusMenu _$SStatusMenuFromJson(Map<String, dynamic> json) => _SStatusMenu(
      Message: json['Message'] as String? ?? 'ﾒﾆｭｰ',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusMenuToJson(_SStatusMenu instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusWait _$SStatusWaitFromJson(Map<String, dynamic> json) => _SStatusWait(
      Message: json['Message'] as String? ?? '待機',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusWaitToJson(_SStatusWait instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusActive _$SStatusActiveFromJson(Map<String, dynamic> json) =>
    _SStatusActive(
      Message: json['Message'] as String? ?? '使用中',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusActiveToJson(_SStatusActive instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusCall _$SStatusCallFromJson(Map<String, dynamic> json) => _SStatusCall(
      Message: json['Message'] as String? ?? 'CALL',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusCallToJson(_SStatusCall instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusOffline _$SStatusOfflineFromJson(Map<String, dynamic> json) =>
    _SStatusOffline(
      Message: json['Message'] as String? ?? 'ｵﾌﾗｲﾝ',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusOfflineToJson(_SStatusOffline instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusAnotherActive _$SStatusAnotherActiveFromJson(
        Map<String, dynamic> json) =>
    _SStatusAnotherActive(
      Message: json['Message'] as String? ?? '使用中',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusAnotherActiveToJson(
        _SStatusAnotherActive instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusMente _$SStatusMenteFromJson(Map<String, dynamic> json) =>
    _SStatusMente(
      Message: json['Message'] as String? ?? 'ﾒﾝﾃﾅﾝｽ',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusMenteToJson(_SStatusMente instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusCreateMax _$SStatusCreateMaxFromJson(Map<String, dynamic> json) =>
    _SStatusCreateMax(
      Message: json['Message'] as String? ?? '使用中',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusCreateMaxToJson(_SStatusCreateMax instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusPause _$SStatusPauseFromJson(Map<String, dynamic> json) =>
    _SStatusPause(
      Message: json['Message'] as String? ?? '休止',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusPauseToJson(_SStatusPause instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusPrecaBalSht _$SStatusPrecaBalShtFromJson(Map<String, dynamic> json) =>
    _SStatusPrecaBalSht(
      Message: json['Message'] as String? ?? '残高不足',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusPrecaBalShtToJson(_SStatusPrecaBalSht instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusPrecaChg _$SStatusPrecaChgFromJson(Map<String, dynamic> json) =>
    _SStatusPrecaChg(
      Message: json['Message'] as String? ?? 'ﾁｬｰｼﾞ中',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusPrecaChgToJson(_SStatusPrecaChg instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusCoinFullRecover _$SStatusCoinFullRecoverFromJson(
        Map<String, dynamic> json) =>
    _SStatusCoinFullRecover(
      Message: json['Message'] as String? ?? 'ﾌﾙ解除',
      BackColor: json['BackColor'] as int? ?? 44,
      TextColor: json['TextColor'] as int? ?? 23,
    );

Map<String, dynamic> _$SStatusCoinFullRecoverToJson(
        _SStatusCoinFullRecover instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_SStatusTerminal _$SStatusTerminalFromJson(Map<String, dynamic> json) =>
    _SStatusTerminal(
      return_time: json['return_time'] as int? ?? 2,
    );

Map<String, dynamic> _$SStatusTerminalToJson(_SStatusTerminal instance) =>
    <String, dynamic>{
      'return_time': instance.return_time,
    };

_CCautionNormal _$CCautionNormalFromJson(Map<String, dynamic> json) =>
    _CCautionNormal(
      Message: json['Message'] as String? ?? '',
      BackColor: json['BackColor'] as int? ?? 35,
      TextColor: json['TextColor'] as int? ?? 15,
    );

Map<String, dynamic> _$CCautionNormalToJson(_CCautionNormal instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_CCautionAcxErr _$CCautionAcxErrFromJson(Map<String, dynamic> json) =>
    _CCautionAcxErr(
      Message: json['Message'] as String? ?? '釣機ｴﾗｰ',
      BackColor: json['BackColor'] as int? ?? 35,
      TextColor: json['TextColor'] as int? ?? 15,
    );

Map<String, dynamic> _$CCautionAcxErrToJson(_CCautionAcxErr instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_CCautionAcxEnd _$CCautionAcxEndFromJson(Map<String, dynamic> json) =>
    _CCautionAcxEnd(
      Message: json['Message'] as String? ?? 'お釣不足',
      BackColor: json['BackColor'] as int? ?? 35,
      TextColor: json['TextColor'] as int? ?? 15,
    );

Map<String, dynamic> _$CCautionAcxEndToJson(_CCautionAcxEnd instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_CCautionAcxFull _$CCautionAcxFullFromJson(Map<String, dynamic> json) =>
    _CCautionAcxFull(
      Message: json['Message'] as String? ?? 'お釣過剰',
      BackColor: json['BackColor'] as int? ?? 35,
      TextColor: json['TextColor'] as int? ?? 15,
    );

Map<String, dynamic> _$CCautionAcxFullToJson(_CCautionAcxFull instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };

_CCautionRcptEnd _$CCautionRcptEndFromJson(Map<String, dynamic> json) =>
    _CCautionRcptEnd(
      Message: json['Message'] as String? ?? 'ﾚｼｰﾄ交換',
      BackColor: json['BackColor'] as int? ?? 35,
      TextColor: json['TextColor'] as int? ?? 15,
    );

Map<String, dynamic> _$CCautionRcptEndToJson(_CCautionRcptEnd instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'BackColor': instance.BackColor,
      'TextColor': instance.TextColor,
    };
