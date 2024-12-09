/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/typ.dart';
import '../inc/rc_mem.dart';
import 'rc_flrda.dart';
import 'rc_preca.dart';
import 'rcsyschk.dart';

class RcGcat {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_gcat.c - rcJmups_Main_Proc()
  static void rcJmupsMainProc (int fncCd, int settleTyp) {
    return ;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_gcat.c - rcG_Cat_Proc()
  static void rcGCatProc(){
    return;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_gcat.c - rc_gcat_cashchaConfDlgAndSound()
  static int rcGcatCashchaConfDlgAndSound (int fncCd) {
    return 0;
  }

  /// ベスカ決済端末利用時、一部預りの掛売種類をチェックする
  /// 戻り値: エラーNo（0=エラーなし）
  /// 関連tprxソース: rcqc_dsp.c - rc_gcat_vesca_sptend_check
  static Future<int> rcGcatVescaSptendCheck() async {
    int errNo = Typ.OK;

    if (RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()) {
      RegsMem mem = SystemFunc.readRegsMem();
      int tendCd = 0;
      KopttranBuff kopttran = KopttranBuff();
      for (int i = 0; i < CntList.sptendMax; i++) {
        tendCd = mem.tTtllog.t100100[i].sptendCd;
        if (RcSysChk.rcChkKYCHA(tendCd)) {
          await RcFlrda.rcReadKopttran(tendCd, kopttran);
          if (kopttran.crdtEnbleFlg == 1) {
            switch (kopttran.crdtTyp) {
              case  0 : // クレジット
              case  2 : // Edy
              case  5 : // iD
              case  7 : // 交通系
              case  9 : // QUICpay
              case 17 : // 銀聯
              case 21 : // WAON
              case 22 : // nanaco
                errNo = tendCd;
                break;
              case  6 : // プリペイド
                if (await RcSysChk.rcChkEntryPrecaTyp() != 0) {
                  // 後通信プリペイドの場合
                  if (tendCd == RcPreca.rcGetPrecaFncCode()) {
                    // プリカキー
                    AtSingl atSing = SystemFunc.readAtSingl();
                    if (atSing.entryPrecaInquFlag == 0) {
                      // 未引き去り、べスカ端末を支払で使用しないためチェックしない
                      errNo = Typ.OK;
                    }
                  }
                }
                else {
                  errNo = tendCd;
                }
                break;
              default :
                break;
            }
          }
        }
      }
    }
    return errNo;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// ベスカ決済端末へ会員情報取得を指示する
  /// 引数: ステイタス（0=通常磁気カード  1=Tポイントカード）
  /// 関連tprxソース: rc_gcat.c - rc_gcat_vesca_checkcard_info()
  static void rcGcatVescaCheckCardInfo(int status) {}

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rc_gcat.c- rc_gcat_vesca_balance
  static void rcGcatVescaBalance(){}

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rc_gcat.c- rc_gcat_vesca_end_rpr
  static void rcGcatVescaEndRpr(){}

  //実装は必要だがARKS対応では除外
  ///関連tprxソース: rc_gcat.c- rc_gcat_vesca_rpr
  static void rcGcatVescaRpr(){}

}