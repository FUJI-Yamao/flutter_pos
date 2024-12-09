/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../enum/e_member_kind.dart';

/// 顧客情報
class MemberInfo {
  // シニア会員の顧客種別に付与する
  static const String typeSenior = 'シニア';
  // 顧客Noの前に表示する
  static const String memberNoPrefix = 'No.';
  // ポイント類畏敬の単位で表示する
  static const String pointCumulateTotalUnit = 'P';
  // クレジット会員の顧客Noの後に付ける'*'
  static const String creditMemberSuffix = '*';
  // 手入力呼出時に顧客Noの前に付ける'@'
  static const String memberNoHandyMark = '@';

  // 顧客種別
  MemberKind memberKind;
  // 顧客情報エリアの顧客種別に表示する
  String memberType = '';
  // 顧客情報エリアの顧客Noに表示する
  String memberNoString = '';
  // 顧客情報エリアのポイント累計に表示する
  String pointCumulateTotalString = '';
  // 顧客情報エリアの顧客種別の背景色
  Color memberBackColor = BaseColor.baseColor;

  // 顧客No(内部所持値)
  int memberNo;
  // ポイント累計(内部所持値)
  int pointCumulateTotal;

  // クレジットカード種別の表示値
  String creditName;
  // シニアか否か
  bool isSenior;

  // 顧客情報全体の表示有無
  bool isViewMemberInfo = true;
  // 顧客種別のアイコン表示有無
  bool isViewMemberIcon = true;
  // 顧客No表示有無
  bool isViewMemberNo = true;
  // ポイント累計表示有無
  bool isViewMemberPoints = true;

  /// コンストラクタ
  MemberInfo({
    required this.memberKind,
    this.memberNo = 0,
    this.pointCumulateTotal = 0,
    this.creditName = '',
    this.isSenior = false
  });

  /// 顧客情報を作成する
  /// パラメータ設定後に実行することで、最終的に表示する値を作成する
  void makeMemberInfo() {
    isViewMemberInfo = memberKind != MemberKind.none;

    String workMemberType = memberKind.memberKindName;
    // クレジットカードの種別を設定する
    if (memberKind == MemberKind.raraCredit ||
        memberKind == MemberKind.raraCreditEmployee) {
      workMemberType += creditName;
    }

    // シニアかどうかを設定する
    if ((memberKind == MemberKind.rara
        || memberKind == MemberKind.raraPreca
        || memberKind == MemberKind.raraHouse
        || memberKind == MemberKind.raraCredit)
        && isSenior) {
      workMemberType += ' $typeSenior';
    }

    memberType = workMemberType;

    // 顧客Noの表示有無、表示値を設定
    if (memberKind == MemberKind.memberPrice || memberKind == MemberKind.employeePrice) {
      isViewMemberIcon = false;
      isViewMemberPoints = false;
    }
    else {
      isViewMemberIcon = true;
      isViewMemberPoints = true;
      memberNoString = '$memberNoPrefix$memberNoHandyMark${memberNo.toString()}';
      if (memberKind == MemberKind.raraCredit ||
          memberKind == MemberKind.raraCreditEmployee) {
        memberNoString += creditMemberSuffix;
      }
    }

    // ポイント累計の表示有無、表示値を設定
    if (memberKind == MemberKind.raraCreditEmployee
        || memberKind == MemberKind.memberPrice
        || memberKind == MemberKind.employeePrice) {
      isViewMemberPoints = false;
    }
    else {
      isViewMemberPoints = true;
      pointCumulateTotalString = '${pointCumulateTotal.toString()} $pointCumulateTotalUnit';
    }

    // 顧客種別の背景色を設定
    switch (memberKind) {
      case MemberKind.rara:
      case MemberKind.raraPreca:
      case MemberKind.raraHouse:
      case MemberKind.raraCredit:
        memberBackColor = BaseColor.memberInfoNormalBackColoer;
      case MemberKind.employee:
        memberBackColor = BaseColor.memberInfoEmployeeBackColoer;
      case MemberKind.raraCreditEmployee:
        memberBackColor = BaseColor.memberInfoCreditEmployeeBackColoer;
      case MemberKind.memberPrice:
        memberBackColor = BaseColor.memberInfoMemberPriceBackColoer;
      case MemberKind.employeePrice:
        memberBackColor = BaseColor.memberInfoEmployeePriceBackColoer;
      default:
        memberBackColor = BaseColor.baseColor;
    }
  }
}
