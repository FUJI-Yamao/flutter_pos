/* 
 * (C)2023,2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'configJsonFile.dart';

part 'barcode_payJsonFile.g.dart';

@JsonSerializable(explicitToJson:true)
class Barcode_payJsonFile extends ConfigJsonFile {
  static final Barcode_payJsonFile _instance = Barcode_payJsonFile._internal();

  final String _confPath = "conf/";
  final String _fileName = "barcode_pay.json";

  Barcode_payJsonFile(){
    setPath(_confPath, _fileName);
  }
  Barcode_payJsonFile._internal();

  factory Barcode_payJsonFile.fromJson(Map<String, dynamic> json_T) =>
      _$Barcode_payJsonFileFromJson(json_T);

  Map<String, dynamic> toJson() => _$Barcode_payJsonFileToJson(this);

  String jsonFileToJson(){
    return jsonEncode(_$Barcode_payJsonFileToJson(this));
  }

  bool setSectionData(jsonR) {
    bool ret = true;
    try {
      Map<String, dynamic> jsonD = jsonDecode(jsonR);
      try {
        linepay = _$LinepayFromJson(jsonD['linepay']);
      } catch(e) {
        linepay = _$LinepayFromJson({});
        ret = false;
      }
      try {
        onepay = _$OnepayFromJson(jsonD['onepay']);
      } catch(e) {
        onepay = _$OnepayFromJson({});
        ret = false;
      }
      try {
        barcodepay = _$BarcodepayFromJson(jsonD['barcodepay']);
      } catch(e) {
        barcodepay = _$BarcodepayFromJson({});
        ret = false;
      }
      try {
        canalpayment = _$CanalpaymentFromJson(jsonD['canalpayment']);
      } catch(e) {
        canalpayment = _$CanalpaymentFromJson({});
        ret = false;
      }
      try {
        netstars = _$NetstarsFromJson(jsonD['netstars']);
      } catch(e) {
        netstars = _$NetstarsFromJson({});
        ret = false;
      }
      try {
        quiz = _$QuizFromJson(jsonD['quiz']);
      } catch(e) {
        quiz = _$QuizFromJson({});
        ret = false;
      }
    }catch(e){
      debugPrint("JSONファイルデータ展開失敗");
    }
    return ret;
  }

  _Linepay linepay = _Linepay(
    url                                : "",
    timeout                            : 0,
    channelId                          : "",
    channelSecretKey                   : "",
    line_at                            : "",
    debug_bal                          : 0,
  );

  _Onepay onepay = _Onepay(
    url                                : "",
    timeout                            : 0,
    product_key                        : "",
    branch_code                        : "",
    termnl_code                        : "",
    mercnt_code                        : "",
    debug_bal                          : 0,
  );

  _Barcodepay barcodepay = _Barcodepay(
    url                                : "",
    timeout                            : 0,
    merchantCode                       : "",
    cliantId                           : "",
    validFlg                           : 0,
    debug_bal                          : 0,
  );

  _Canalpayment canalpayment = _Canalpayment(
    url                                : "",
    timeout                            : 0,
    company_code                       : 0,
    branch_code                        : "",
    merchantId                         : "",
    debug_bal                          : 0,
  );

  _Netstars netstars = _Netstars(
    url                                : "",
    timeout                            : 0,
    company_name                       : "",
    merchant_license                   : "",
    api_key                            : "",
    verify_key                         : "",
    rcpt_info                          : "",
    proxy                              : "",
    debug_bal                          : 0,
  );

  _Quiz quiz = _Quiz(
    ccid                               : "",
    key                                : "",
    timeout                            : 0,
    storeID                            : "",
    terminalID                         : "",
    debug_flag                         : 0,
    debug_rescode                      : "",
    debug_vcode                        : "",
    debug_bal                          : 0,
  );
}

@JsonSerializable()
class _Linepay {
  factory _Linepay.fromJson(Map<String, dynamic> json) => _$LinepayFromJson(json);
  Map<String, dynamic> toJson() => _$LinepayToJson(this);

  _Linepay({
    required this.url,
    required this.timeout,
    required this.channelId,
    required this.channelSecretKey,
    required this.line_at,
    required this.debug_bal,
  });

  @JsonKey(defaultValue: "http://")
  String url;
  @JsonKey(defaultValue: 40)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String channelId;
  @JsonKey(defaultValue: "none")
  String channelSecretKey;
  @JsonKey(defaultValue: "none")
  String line_at;
  @JsonKey(defaultValue: 10000)
  int    debug_bal;
}

@JsonSerializable()
class _Onepay {
  factory _Onepay.fromJson(Map<String, dynamic> json) => _$OnepayFromJson(json);
  Map<String, dynamic> toJson() => _$OnepayToJson(this);

  _Onepay({
    required this.url,
    required this.timeout,
    required this.product_key,
    required this.branch_code,
    required this.termnl_code,
    required this.mercnt_code,
    required this.debug_bal,
  });

  @JsonKey(defaultValue: "http://")
  String url;
  @JsonKey(defaultValue: 20)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String product_key;
  @JsonKey(defaultValue: "none")
  String branch_code;
  @JsonKey(defaultValue: "none")
  String termnl_code;
  @JsonKey(defaultValue: "none")
  String mercnt_code;
  @JsonKey(defaultValue: 10000)
  int    debug_bal;
}

@JsonSerializable()
class _Barcodepay {
  factory _Barcodepay.fromJson(Map<String, dynamic> json) => _$BarcodepayFromJson(json);
  Map<String, dynamic> toJson() => _$BarcodepayToJson(this);

  _Barcodepay({
    required this.url,
    required this.timeout,
    required this.merchantCode,
    required this.cliantId,
    required this.validFlg,
    required this.debug_bal,
  });

  @JsonKey(defaultValue: "https://")
  String url;
  @JsonKey(defaultValue: 30)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String merchantCode;
  @JsonKey(defaultValue: "none")
  String cliantId;
  @JsonKey(defaultValue: 0)
  int    validFlg;
  @JsonKey(defaultValue: 10000)
  int    debug_bal;
}

@JsonSerializable()
class _Canalpayment {
  factory _Canalpayment.fromJson(Map<String, dynamic> json) => _$CanalpaymentFromJson(json);
  Map<String, dynamic> toJson() => _$CanalpaymentToJson(this);

  _Canalpayment({
    required this.url,
    required this.timeout,
    required this.company_code,
    required this.branch_code,
    required this.merchantId,
    required this.debug_bal,
  });

  @JsonKey(defaultValue: "https://")
  String url;
  @JsonKey(defaultValue: 30)
  int    timeout;
  @JsonKey(defaultValue: 0)
  int    company_code;
  @JsonKey(defaultValue: "none")
  String branch_code;
  @JsonKey(defaultValue: "none")
  String merchantId;
  @JsonKey(defaultValue: 10000)
  int    debug_bal;
}

@JsonSerializable()
class _Netstars {
  factory _Netstars.fromJson(Map<String, dynamic> json) => _$NetstarsFromJson(json);
  Map<String, dynamic> toJson() => _$NetstarsToJson(this);

  _Netstars({
    required this.url,
    required this.timeout,
    required this.company_name,
    required this.merchant_license,
    required this.api_key,
    required this.verify_key,
    required this.rcpt_info,
    required this.proxy,
    required this.debug_bal,
  });

  @JsonKey(defaultValue: "https://")
  String url;
  @JsonKey(defaultValue: 45)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String company_name;
  @JsonKey(defaultValue: "none")
  String merchant_license;
  @JsonKey(defaultValue: "none")
  String api_key;
  @JsonKey(defaultValue: "none")
  String verify_key;
  @JsonKey(defaultValue: "none")
  String rcpt_info;
  @JsonKey(defaultValue: "none")
  String proxy;
  @JsonKey(defaultValue: 10000)
  int    debug_bal;
}

@JsonSerializable()
class _Quiz {
  factory _Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);

  _Quiz({
    required this.ccid,
    required this.key,
    required this.timeout,
    required this.storeID,
    required this.terminalID,
    required this.debug_flag,
    required this.debug_rescode,
    required this.debug_vcode,
    required this.debug_bal,
  });

  @JsonKey(defaultValue: "")
  String ccid;
  @JsonKey(defaultValue: "")
  String key;
  @JsonKey(defaultValue: 60)
  int    timeout;
  @JsonKey(defaultValue: "none")
  String storeID;
  @JsonKey(defaultValue: "none")
  String terminalID;
  @JsonKey(defaultValue: 0)
  int    debug_flag;
  @JsonKey(defaultValue: "Q000")
  String debug_rescode;
  @JsonKey(defaultValue: "1001000000000000")
  String debug_vcode;
  @JsonKey(defaultValue: 10000)
  int    debug_bal;
}

