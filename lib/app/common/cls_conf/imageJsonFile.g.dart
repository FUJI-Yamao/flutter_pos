// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imageJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageJsonFile _$ImageJsonFileFromJson(
        Map<String, dynamic> json) =>
    ImageJsonFile()
      ..skin_icon =
          _Skin_icon.fromJson(json['skin_icon'] as Map<String, dynamic>);

Map<String, dynamic> _$ImageJsonFileToJson(ImageJsonFile instance) =>
    <String, dynamic>{
      'skin_icon': instance.skin_icon.toJson(),
    };

_Skin_icon _$Skin_iconFromJson(Map<String, dynamic> json) => _Skin_icon(
      skin: json['skin'] as String? ?? 'sk1 0',
      icon: json['icon'] as String? ?? 'icon_animal 8',
    );

Map<String, dynamic> _$Skin_iconToJson(_Skin_icon instance) =>
    <String, dynamic>{
      'skin': instance.skin,
      'icon': instance.icon,
    };
