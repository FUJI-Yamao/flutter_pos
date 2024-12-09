// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_payJsonFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barcode_payJsonFile _$Barcode_payJsonFileFromJson(Map<String, dynamic> json) =>
    Barcode_payJsonFile()
      ..linepay = _Linepay.fromJson(json['linepay'] as Map<String, dynamic>)
      ..onepay = _Onepay.fromJson(json['onepay'] as Map<String, dynamic>)
      ..barcodepay =
          _Barcodepay.fromJson(json['barcodepay'] as Map<String, dynamic>)
      ..canalpayment =
          _Canalpayment.fromJson(json['canalpayment'] as Map<String, dynamic>)
      ..netstars = _Netstars.fromJson(json['netstars'] as Map<String, dynamic>)
      ..quiz = _Quiz.fromJson(json['quiz'] as Map<String, dynamic>);

Map<String, dynamic> _$Barcode_payJsonFileToJson(
        Barcode_payJsonFile instance) =>
    <String, dynamic>{
      'linepay': instance.linepay.toJson(),
      'onepay': instance.onepay.toJson(),
      'barcodepay': instance.barcodepay.toJson(),
      'canalpayment': instance.canalpayment.toJson(),
      'netstars': instance.netstars.toJson(),
      'quiz': instance.quiz.toJson(),
    };

_Linepay _$LinepayFromJson(Map<String, dynamic> json) => _Linepay(
      url: json['url'] as String? ?? 'http://',
      timeout: json['timeout'] as int? ?? 40,
      channelId: json['channelId'] as String? ?? 'none',
      channelSecretKey: json['channelSecretKey'] as String? ?? 'none',
      line_at: json['line_at'] as String? ?? 'none',
      debug_bal: json['debug_bal'] as int? ?? 10000,
    );

Map<String, dynamic> _$LinepayToJson(_Linepay instance) => <String, dynamic>{
      'url': instance.url,
      'timeout': instance.timeout,
      'channelId': instance.channelId,
      'channelSecretKey': instance.channelSecretKey,
      'line_at': instance.line_at,
      'debug_bal': instance.debug_bal,
    };

_Onepay _$OnepayFromJson(Map<String, dynamic> json) => _Onepay(
      url: json['url'] as String? ?? 'http://',
      timeout: json['timeout'] as int? ?? 20,
      product_key: json['product_key'] as String? ?? 'none',
      branch_code: json['branch_code'] as String? ?? 'none',
      termnl_code: json['termnl_code'] as String? ?? 'none',
      mercnt_code: json['mercnt_code'] as String? ?? 'none',
      debug_bal: json['debug_bal'] as int? ?? 10000,
    );

Map<String, dynamic> _$OnepayToJson(_Onepay instance) => <String, dynamic>{
      'url': instance.url,
      'timeout': instance.timeout,
      'product_key': instance.product_key,
      'branch_code': instance.branch_code,
      'termnl_code': instance.termnl_code,
      'mercnt_code': instance.mercnt_code,
      'debug_bal': instance.debug_bal,
    };

_Barcodepay _$BarcodepayFromJson(Map<String, dynamic> json) => _Barcodepay(
      url: json['url'] as String? ?? 'https://',
      timeout: json['timeout'] as int? ?? 30,
      merchantCode: json['merchantCode'] as String? ?? 'none',
      cliantId: json['cliantId'] as String? ?? 'none',
      validFlg: json['validFlg'] as int? ?? 0,
      debug_bal: json['debug_bal'] as int? ?? 10000,
    );

Map<String, dynamic> _$BarcodepayToJson(_Barcodepay instance) =>
    <String, dynamic>{
      'url': instance.url,
      'timeout': instance.timeout,
      'merchantCode': instance.merchantCode,
      'cliantId': instance.cliantId,
      'validFlg': instance.validFlg,
      'debug_bal': instance.debug_bal,
    };

_Canalpayment _$CanalpaymentFromJson(Map<String, dynamic> json) =>
    _Canalpayment(
      url: json['url'] as String? ?? 'https://',
      timeout: json['timeout'] as int? ?? 30,
      company_code: json['company_code'] as int? ?? 0,
      branch_code: json['branch_code'] as String? ?? 'none',
      merchantId: json['merchantId'] as String? ?? 'none',
      debug_bal: json['debug_bal'] as int? ?? 10000,
    );

Map<String, dynamic> _$CanalpaymentToJson(_Canalpayment instance) =>
    <String, dynamic>{
      'url': instance.url,
      'timeout': instance.timeout,
      'company_code': instance.company_code,
      'branch_code': instance.branch_code,
      'merchantId': instance.merchantId,
      'debug_bal': instance.debug_bal,
    };

_Netstars _$NetstarsFromJson(Map<String, dynamic> json) => _Netstars(
      url: json['url'] as String? ?? 'https://',
      timeout: json['timeout'] as int? ?? 45,
      company_name: json['company_name'] as String? ?? 'none',
      merchant_license: json['merchant_license'] as String? ?? 'none',
      api_key: json['api_key'] as String? ?? 'none',
      verify_key: json['verify_key'] as String? ?? 'none',
      rcpt_info: json['rcpt_info'] as String? ?? 'none',
      proxy: json['proxy'] as String? ?? 'none',
      debug_bal: json['debug_bal'] as int? ?? 10000,
    );

Map<String, dynamic> _$NetstarsToJson(_Netstars instance) => <String, dynamic>{
      'url': instance.url,
      'timeout': instance.timeout,
      'company_name': instance.company_name,
      'merchant_license': instance.merchant_license,
      'api_key': instance.api_key,
      'verify_key': instance.verify_key,
      'rcpt_info': instance.rcpt_info,
      'proxy': instance.proxy,
      'debug_bal': instance.debug_bal,
    };

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
      ccid: json['ccid'] as String? ?? '',
      key: json['key'] as String? ?? '',
      timeout: json['timeout'] as int? ?? 60,
      storeID: json['storeID'] as String? ?? 'none',
      terminalID: json['terminalID'] as String? ?? 'none',
      debug_flag: json['debug_flag'] as int? ?? 0,
      debug_rescode: json['debug_rescode'] as String? ?? 'Q000',
      debug_vcode: json['debug_vcode'] as String? ?? '1001000000000000',
      debug_bal: json['debug_bal'] as int? ?? 10000,
    );

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
      'ccid': instance.ccid,
      'key': instance.key,
      'timeout': instance.timeout,
      'storeID': instance.storeID,
      'terminalID': instance.terminalID,
      'debug_flag': instance.debug_flag,
      'debug_rescode': instance.debug_rescode,
      'debug_vcode': instance.debug_vcode,
      'debug_bal': instance.debug_bal,
    };
