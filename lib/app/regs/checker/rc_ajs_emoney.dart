/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import 'rcsyschk.dart';

class RcAjsEmoney {
  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_ajs_emoney.c - rcCheck_Ajs_Emoney_Deposit_Item()
  static int rcCheckAjsEmoneyDepositItem(int flg) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_ajs_emoney.c - rcKy_Ajs_Emoney_Deposit()
  static void rcKyAjsEmoneyDeposit () {
    return ;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C: rc_ajs_emoney.c - rcKy_Ajs_Emoney_In()
  static void rcKyAjsEmoneyIn(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_ajs_emoney.c - rcKy_Ajs_Emoney_Sales()
  static int rcKyAjsEmoneySales(int){
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C: rc_ajs_emoney.c - rc_ajs_Sptend_Check()
  static int rcAjsSptendCheck(TTtlLog ttl, int checktyp, int chkMax){
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_ajs_emoney.c - rcAjs_Emoney_AutoSusChk()
  static int rcAjsEmoneyAutoSusChk() {
    if (RcSysChk.rcsyschkSm66FrestaSystem()) {
      return 1;
    }
    return 0;
  }

  // TODO checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_ajs_emoney.c - rcKy_Ajs_Emoney_Ref()
  static void rcKyAjsEmoneyRef() {
    return;
  }

  /// 関数名       : rcAjs_Sptend_Fnc_Check
  /// 機能概要     : ファンクションがプリペイドかチェック
  /// 呼び出し方法 : #include
  ///              : rcAjs_Sptend_Fnc_Check()
  /// パラメータ   :
  /// 戻り値       : 1:プリペイド 0:プリペイドでない
  ///  関連tprxソース: rc_ajs_emoney.c - rcAjs_Sptend_Fnc_Check()
  static Future<int> rcAjsSptendFncCheck(int fncCode) async {
    int tmpbuf = 0;
    AcMem cMem = SystemFunc.readAcMem();

    if(await CmCksys.cmPrecacardMultiUse() == 0) {
      return 0;
    }

    if(cMem.qrChgKoptFlg == 1) {
      tmpbuf = cMem.qrChgKoptFlg;
      cMem.qrChgKoptFlg = 0;
    }
    KopttranBuff kopttran = KopttranBuff();
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);
    if(tmpbuf != 0) {
      cMem.qrChgKoptFlg = tmpbuf;
    }

    if((kopttran.crdtEnbleFlg == 1)	/* キーオプションの掛売登録:するの設定かチェック */
      && ((kopttran.crdtTyp == SPTEND_STATUS_LISTS.SPTEND_STATUS_PREPAID)		/* 掛売の種類がプリペードの設定かチェック */
      || (kopttran.crdtTyp == SPTEND_STATUS_LISTS.SPTEND_STATUS_PREPAID2))   ) 	/* 掛売の種類がプリペード2の設定かチェック */
    {
      return 1;
    }

    return 0;
  }
}

/// 関連tprxソース:C: rc_ajs_emoney.h - MULPRECA_SPTEND_COUNT_CHECK_TYP
enum MulprecaSptendCountCheckTyp				/* プリペイド複数枚利用 スプリット内プリペイドチェック */
{
  MULPRECA_SPTEND_NON(-1),        	/* 未使用 */
  MULPRECA_SPTEND_PREPAID(0),	      /* 掛売  プリペイド取引有無チェック */
  MULPRECA_SPTEND_NONPREPAID(1);	  /* 掛売  プリペイド以外取引有無チェック */

  final int keyId;
  const MulprecaSptendCountCheckTyp(this.keyId);
}