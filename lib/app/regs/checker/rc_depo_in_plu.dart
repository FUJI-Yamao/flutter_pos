/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/lib/cm_chg/ltobcd.dart';
import '../inc/rc_mem.dart';
import 'liblary.dart';
import 'rc_set.dart';
import 'rcky_mul.dart';

/// 関連tprxソース:rcdepoinplu.c
class RcDepoInPlu {
  static int btlmbrinpDsp = 0;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcdepoinplu.c - rcChk_DepoMbrInPlu
  static int rcChkDepoMbrInPlu(int kind, int p) {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcdepoinplu.c - rcChk_DepoBtl_IdChk
  static int rcChkDepoBtlIdChk() {
    return 1;
  }

  /// 貸出管理会員入力モード中チェック関数
  /// 戻り値: true=入力中  false=入力中でない
  /// 関連tprxソース: rcdepoinplu.c - rcChk_DepoBtlMbrInp_Mode
  static bool rcChkDepoBtlMbrInpMode() {
    return ((btlmbrinpDsp == FuncKey.KY_MBR.keyId) ||
        (btlmbrinpDsp == ImageDefinitions.IMG_TELNO) ||
        (btlmbrinpDsp == FuncKey.KY_TEL.keyId));
  }

  /// 貸瓶付き商品情報クリア処理 */
  /// 関連tprxソース: rcdepoinplu.c - rcClear_DepoInPluBar
  static void rcClearDepoInPluBar() {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    cMem.depoinplu = DepoinpluBar();
    cMem.depoinplu!.depoinpluBarFlg = "";
    atSing.depoBrtInFlg = 0; // 瓶返却フラグ

    return;
  }

  /// 貸瓶付商品登録かチェック
  /// 戻り値
  /// 　TRUE :貸瓶付商品登録中
  /// 　FALSE:貸瓶付商品登録中でない
  /// 関連tprxソース: rcdepoinplu.c - rcCheck_DepoInPlu_Item
  static bool rcCheckDepoInPluItem() {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.depoinplu?.depoinpluBarFlg == "1") {
      return (true);
    }
    return (false);
  }

  /// 貸瓶付き管理商品バーコードの貸瓶登録
  /// 関連tprxソース: rcdepoinplu.c - rcDepoInPlu_Set
  static Future<int> rcDepoInPluSet() async {

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if (cMem.depoinplu?.depopluCd != "") {
      if (mem.tItemLog[mem.tTtllog.t100001Sts.itemlogCnt - 1].t10000.realQty > 1) {
        cMem.stat.fncCode = FuncKey.KY_MUL.keyId;

        // 文字列に変換
        String bcd = Ltobcd.cmLtobcd(mem.tItemLog[mem.tTtllog.t100001Sts.itemlogCnt - 1].t10000.realQty, cMem.ent.entry.length);
        for (int i = 0; i < cMem.ent.entry.length; i++) {
          // 文字列bcdを文字コードに変換して代入
          cMem.ent.entry[i] = bcd.codeUnits[i];
        }
        cMem.ent.tencnt = Liblary.cmChkZero0(bcd, cMem.ent.entry.length);
        RckyMul.rcKyMul();
      }
      cMem.stat.fncCode = FuncKey.KY_PLU.keyId;
      cMem.ent.tencnt = Liblary.cmChkZero0(cMem.depoinplu!.depopluCd.substring(11,), cMem.ent.entry.length);
      rcClearDepoInPluBar();
      RcSet.rcClearRepeatBuf();
    }

    return (0);
  }
}