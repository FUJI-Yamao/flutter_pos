/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../fb/fb_lib.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';


///  関連tprxソース: getfunccolor.c - FUNC_COLOR
class FuncColorDefine {
  late Map<FuncKey, FbColorGroup> colorMap;
  FuncColorDefine() {
    createFuncColorMap();
  }

  void createFuncColorMap() {
    colorMap = {};
    FbColorGroup numColor =
        CompileFlag.TW ? FbColorGroup.SkyBlue : FbColorGroup.DarkGray;
    colorMap[FuncKey.KY_1] = numColor; // 1
    colorMap[FuncKey.KY_2] = numColor; //  2
    colorMap[FuncKey.KY_3] = numColor; //  3
    colorMap[FuncKey.KY_4] = numColor; //  4
    colorMap[FuncKey.KY_5] = numColor; //  5
    colorMap[FuncKey.KY_6] = numColor; //  6
    colorMap[FuncKey.KY_7] = numColor; //  7
    colorMap[FuncKey.KY_8] = numColor; //  8
    colorMap[FuncKey.KY_9] = numColor; //  9
    colorMap[FuncKey.KY_0] = numColor; //  0
    colorMap[FuncKey.KY_00] = numColor; //  00
    colorMap[FuncKey.KY_000] = numColor; //  000
    colorMap[FuncKey.KY_STL] = FbColorGroup.TurquoiseBlue; //  小計
    colorMap[FuncKey.KY_CASH] = FbColorGroup.Yellow; //  預り／現計
    colorMap[FuncKey.KY_CHA1] = FbColorGroup.Purple; //  会計1
    colorMap[FuncKey.KY_CHA2] = FbColorGroup.Purple; //  会計2
    colorMap[FuncKey.KY_CHA3] = FbColorGroup.Purple; //  会計3
    colorMap[FuncKey.KY_CHA4] = FbColorGroup.Purple; //  会計4
    colorMap[FuncKey.KY_CHA5] = FbColorGroup.Purple; //  会計5
    colorMap[FuncKey.KY_CHA6] = FbColorGroup.Purple; //  会計6
    colorMap[FuncKey.KY_CHA7] = FbColorGroup.Purple; //  会計7
    colorMap[FuncKey.KY_CHA8] = FbColorGroup.Purple; //  会計8
    colorMap[FuncKey.KY_CHA9] = FbColorGroup.Purple; //  会計9
    colorMap[FuncKey.KY_CHA10] = FbColorGroup.Purple; //  会計10
    colorMap[FuncKey.KY_CHK1] = FbColorGroup.TurquoiseBlue; //  品券1
    colorMap[FuncKey.KY_CHK2] = FbColorGroup.TurquoiseBlue; //  品券2
    colorMap[FuncKey.KY_CHK3] = FbColorGroup.TurquoiseBlue; //  品券3
    colorMap[FuncKey.KY_CHK4] = FbColorGroup.TurquoiseBlue; //  品券4
    colorMap[FuncKey.KY_CHK5] = FbColorGroup.TurquoiseBlue; //  品券5
    colorMap[FuncKey.KY_CLR] = FbColorGroup.Red; //  クリアー
    colorMap[FuncKey.KY_MAN] = FbColorGroup.TurquoiseBlue; //  万券
    colorMap[FuncKey.KY_5SEN] = FbColorGroup.TurquoiseBlue; //  5千券
    colorMap[FuncKey.KY_2SEN] = FbColorGroup.TurquoiseBlue; //  2千券
    colorMap[FuncKey.KY_SEN] = FbColorGroup.TurquoiseBlue; //  千券
    colorMap[FuncKey.KY_DSC1] = FbColorGroup.Orange; //  値引1
    colorMap[FuncKey.KY_DSC2] = FbColorGroup.Orange; //  値引2
    colorMap[FuncKey.KY_DSC3] = FbColorGroup.Orange; //  値引3
    colorMap[FuncKey.KY_DSC4] = FbColorGroup.Orange; //  値引4
    colorMap[FuncKey.KY_DSC5] = FbColorGroup.Orange; //  値引5
    colorMap[FuncKey.KY_PM1] = FbColorGroup.Pink; //  割引1
    colorMap[FuncKey.KY_PM2] = FbColorGroup.Pink; //  割引2
    colorMap[FuncKey.KY_PM3] = FbColorGroup.Pink; //  割引3
    colorMap[FuncKey.KY_PM4] = FbColorGroup.Pink; //  割引4
    colorMap[FuncKey.KY_PM5] = FbColorGroup.Pink; //  割引5
    colorMap[FuncKey.KY_PLU] = FbColorGroup.Navy; //  PLU
    colorMap[FuncKey.KY_MG] = FbColorGroup.Navy; //  MG
    colorMap[FuncKey.KY_DRW] = FbColorGroup.LightGreen; //  ＃／両替
    colorMap[FuncKey.KY_RCT] = FbColorGroup.Purple; //  レシートフィード
    colorMap[FuncKey.KY_RPR] = FbColorGroup.Purple; //  再発行
    colorMap[FuncKey.KY_RCTFM] = FbColorGroup.Purple; //  領収書
    colorMap[FuncKey.KY_PRC] = FbColorGroup.LightGreen; //  金額
    colorMap[FuncKey.KY_CORR] = FbColorGroup.Orange; //  直前訂正
    colorMap[FuncKey.KY_VOID] = FbColorGroup.Orange; //  指定訂正
    colorMap[FuncKey.KY_CNCL] = FbColorGroup.Pink; //  取消
    colorMap[FuncKey.KY_REF] = FbColorGroup.Pink; //  返品
    colorMap[FuncKey.KY_SCRVOID] = FbColorGroup.Orange; //  画面訂正
    colorMap[FuncKey.KY_SUS] = FbColorGroup.Navy; //  仮締呼出
    colorMap[FuncKey.KY_MUL] = FbColorGroup.LightGreen; //  ×／日付
    colorMap[FuncKey.KY_CIN1] = FbColorGroup.Purple; //  入金1
    colorMap[FuncKey.KY_CIN2] = FbColorGroup.Purple; //  入金2
    colorMap[FuncKey.KY_CIN3] = FbColorGroup.Purple; //  入金3
    colorMap[FuncKey.KY_CIN4] = FbColorGroup.Purple; //  入金4
    colorMap[FuncKey.KY_CIN5] = FbColorGroup.Purple; //  入金5
    colorMap[FuncKey.KY_CIN6] = FbColorGroup.Purple; //  入金6
    colorMap[FuncKey.KY_CIN7] = FbColorGroup.Purple; //  入金7
    colorMap[FuncKey.KY_CIN8] = FbColorGroup.Purple; //  入金8
    colorMap[FuncKey.KY_CIN9] = FbColorGroup.Purple; //  入金9
    colorMap[FuncKey.KY_CIN10] = FbColorGroup.Purple; //  入金10
    colorMap[FuncKey.KY_OUT1] = FbColorGroup.Purple; //  支払1
    colorMap[FuncKey.KY_OUT2] = FbColorGroup.Purple; //  支払2
    colorMap[FuncKey.KY_OUT3] = FbColorGroup.Purple; //  支払3
    colorMap[FuncKey.KY_OUT4] = FbColorGroup.Purple; //  支払4
    colorMap[FuncKey.KY_OUT5] = FbColorGroup.Purple; //  支払5
    colorMap[FuncKey.KY_OUT6] = FbColorGroup.Purple; //  支払6
    colorMap[FuncKey.KY_OUT7] = FbColorGroup.Purple; //  支払7
    colorMap[FuncKey.KY_OUT8] = FbColorGroup.Purple; //  支払8
    colorMap[FuncKey.KY_OUT9] = FbColorGroup.Purple; //  支払9
    colorMap[FuncKey.KY_OUT10] = FbColorGroup.Purple; //  支払10
    colorMap[FuncKey.KY_LOAN] = FbColorGroup.Purple; //  釣準備
    colorMap[FuncKey.KY_PICK] = FbColorGroup.Purple; //  売上回収
    colorMap[FuncKey.KY_MENU] = FbColorGroup.Orange; //  終了
    colorMap[FuncKey.KY_RMOD] = FbColorGroup.TurquoiseBlue; //  登録画面
    colorMap[FuncKey.KY_CMOD] = FbColorGroup.TurquoiseBlue; //  扱者画面
    colorMap[FuncKey.KY_DSP1] = FbColorGroup.Yellow; //  画面1
    colorMap[FuncKey.KY_DSP2] = FbColorGroup.Orange; //  画面2
    colorMap[FuncKey.KY_DSP3] = FbColorGroup.Pink; //  画面3
    colorMap[FuncKey.KY_DSP4] = FbColorGroup.Purple; //  画面4
    colorMap[FuncKey.KY_DSP5] = FbColorGroup.SkyBlue; //  画面5
    colorMap[FuncKey.KY_DSP6] = FbColorGroup.TurquoiseBlue; //  画面6
    colorMap[FuncKey.KY_DSP7] = FbColorGroup.LightGreen; //  画面7
    colorMap[FuncKey.KY_UP] = FbColorGroup.Navy; //  UP
    colorMap[FuncKey.KY_DOWN] = FbColorGroup.Navy; //  DOWN
    colorMap[FuncKey.KY_CIN11] = FbColorGroup.Purple; //  入金11
    colorMap[FuncKey.KY_CIN12] = FbColorGroup.Purple; //  入金12
    colorMap[FuncKey.KY_CIN13] = FbColorGroup.Purple; //  入金13
    colorMap[FuncKey.KY_CIN14] = FbColorGroup.Purple; //  入金14
    colorMap[FuncKey.KY_CIN15] = FbColorGroup.Purple; //  入金15
    colorMap[FuncKey.KY_CIN16] = FbColorGroup.Purple; //  入金16
    colorMap[FuncKey.KY_OUT11] = FbColorGroup.Purple; //  支払11
    colorMap[FuncKey.KY_OUT12] = FbColorGroup.Purple; //  支払12
    colorMap[FuncKey.KY_OUT13] = FbColorGroup.Purple; //  支払13
    colorMap[FuncKey.KY_OUT14] = FbColorGroup.Purple; //  支払14
    colorMap[FuncKey.KY_OUT15] = FbColorGroup.Purple; //  支払15
    colorMap[FuncKey.KY_OUT16] = FbColorGroup.Purple; //  支払16
    colorMap[FuncKey.KY_STAMP1] = FbColorGroup.Yellow; //  ｽﾀﾝﾌﾟ1
    colorMap[FuncKey.KY_STAMP2] = FbColorGroup.Yellow; //  ｽﾀﾝﾌﾟ2
    colorMap[FuncKey.KY_STAMP3] = FbColorGroup.Yellow; //  ｽﾀﾝﾌﾟ3
    colorMap[FuncKey.KY_STAMP4] = FbColorGroup.Yellow; //  ｽﾀﾝﾌﾟ4
    colorMap[FuncKey.KY_STAMP5] = FbColorGroup.Yellow; //  ｽﾀﾝﾌﾟ5
    colorMap[FuncKey.KY_WRTY] = FbColorGroup.Purple; //  保証書
    colorMap[FuncKey.KY_DECIMAL] = FbColorGroup.LightGreen; //  小数点
    colorMap[FuncKey.KY_STPR_RCT] = FbColorGroup.Purple; //  伝票ﾌｨ-ﾄﾞ
    colorMap[FuncKey.KY_STPR_RPR] = FbColorGroup.Purple; //  伝票発行
    colorMap[FuncKey.KY_PLUS1] = FbColorGroup.SkyBlue; //  割増1
    colorMap[FuncKey.KY_PLUS2] = FbColorGroup.SkyBlue; //  割増2
    colorMap[FuncKey.KY_PLUS3] = FbColorGroup.SkyBlue; //  割増3
    colorMap[FuncKey.KY_PLUS4] = FbColorGroup.SkyBlue; //  割増4
    colorMap[FuncKey.KY_PLUS5] = FbColorGroup.SkyBlue; //  割増5
    colorMap[FuncKey.KY_MCASH] = FbColorGroup.Yellow; //  ｶ-ﾄﾞ現金
    colorMap[FuncKey.KY_MCRDT] = FbColorGroup.Purple; //  ｶ-ﾄﾞ一括
    colorMap[FuncKey.KY_HCRDT] = FbColorGroup.TurquoiseBlue; //  自社クレ
    colorMap[FuncKey.KY_MCALC] = FbColorGroup.LightGreen; //  単独割振
    colorMap[FuncKey.KY_ERCTFM] = FbColorGroup.Purple; //  検索領収書
    colorMap[FuncKey.KY_5HYAKU] = FbColorGroup.TurquoiseBlue; //  5百券
    colorMap[FuncKey.KY_MDL] = FbColorGroup.Navy; //  中分類
    colorMap[FuncKey.KY_LRG] = FbColorGroup.Navy; //  大分類
    colorMap[FuncKey.KY_CHGPICK] = FbColorGroup.Purple; //  釣機回収
    colorMap[FuncKey.KY_SLASH] = FbColorGroup.Navy; //  ／
    colorMap[FuncKey.KY_ITMINF] = FbColorGroup.Navy; //  明細付加情報
    colorMap[FuncKey.KY_TTLINF] = FbColorGroup.Navy; //  取引付加情報
    colorMap[FuncKey.KY_WORKIN] = FbColorGroup.Navy; //  業務宣言
    colorMap[FuncKey.KY_HCARDIN] = FbColorGroup.Navy; //  買物カード宣言
    colorMap[FuncKey.KY_HCRDTIN] = FbColorGroup.Navy; //  自社クレジット宣言
    colorMap[FuncKey.KY_OMC] = FbColorGroup.Navy; //  OMC優待
    if (CompileFlag.TW) {
      colorMap[FuncKey.KY_COMP_CD] = FbColorGroup.Orange; //  企業ｺ-ﾄﾞ
    }
    colorMap[FuncKey.KY_SPCNCL] = FbColorGroup.Pink; //  締め取消
    colorMap[FuncKey.KY_PRCLBL] = FbColorGroup.Purple; //  値付ﾗﾍﾞﾙ
    colorMap[FuncKey.KY_PRCLBL_RPR] = FbColorGroup.Purple; //  値付再発行
    colorMap[FuncKey.KY_CARRY] = FbColorGroup.Purple; //  積載指示書
    colorMap[FuncKey.KY_BRND_CHA] = FbColorGroup.Navy; //  ﾌﾞﾗﾝﾄﾞ取引選択
    colorMap[FuncKey.KY_BRND_REF] = FbColorGroup.Navy; //  ﾌﾞﾗﾝﾄﾞ残高照会
    colorMap[FuncKey.KY_BRND_CIN] = FbColorGroup.Pink; //  ﾌﾞﾗﾝﾄﾞ現金ﾁｬｰｼﾞ

    colorMap[FuncKey.KY_RESERVCALL] = FbColorGroup.Orange; //  予約呼出
    colorMap[FuncKey.KY_RESERVCNCL] = FbColorGroup.Orange; //  予約取消
    colorMap[FuncKey.KY_RESERVCONF] = FbColorGroup.Orange; //  予約確認
    colorMap[FuncKey.KY_PBCHG] = FbColorGroup.Orange; //  公共料金
    colorMap[FuncKey.KY_GIFT_CODE] = FbColorGroup.Navy; //  ギフトコード
    colorMap[FuncKey.KY_CARD_IN] = FbColorGroup.Navy; //  カード取引
    colorMap[FuncKey.KY_CARD_CIN] = FbColorGroup.Navy; //  カード入金
    colorMap[FuncKey.KY_DRWCHG] = FbColorGroup.Navy; //  独立現外
    colorMap[FuncKey.KY_BATCHREG] = FbColorGroup.Navy; //  一括登録
    colorMap[FuncKey.KY_CINDSC] = FbColorGroup.Navy; //  入金値引
    colorMap[FuncKey.KY_NETRESERV] = FbColorGroup.Orange; //  ﾈｯﾄ予約
    colorMap[FuncKey.KY_CHGDRW] = FbColorGroup.LightGreen; //  棒金開
    colorMap[FuncKey.KY_RFDOPR] = FbColorGroup.PalePink; //  返品ﾓｰﾄﾞ
    colorMap[FuncKey.KY_ACXINFO] = FbColorGroup.Orange; //  釣銭情報
    colorMap[FuncKey.KY_PITAPA_REF] = FbColorGroup.Navy; //  PiTaPa累計照会
    colorMap[FuncKey.KY_CHA11] = FbColorGroup.Purple; //  会計11
    colorMap[FuncKey.KY_CHA12] = FbColorGroup.Purple; //  会計12
    colorMap[FuncKey.KY_CHA13] = FbColorGroup.Purple; //  会計13
    colorMap[FuncKey.KY_CHA14] = FbColorGroup.Purple; //  会計14
    colorMap[FuncKey.KY_CHA15] = FbColorGroup.Purple; //  会計15
    colorMap[FuncKey.KY_CHA16] = FbColorGroup.Purple; //  会計16
    colorMap[FuncKey.KY_CHA17] = FbColorGroup.Purple; //  会計17
    colorMap[FuncKey.KY_CHA18] = FbColorGroup.Purple; //  会計18
    colorMap[FuncKey.KY_CHA19] = FbColorGroup.Purple; //  会計19
    colorMap[FuncKey.KY_CHA20] = FbColorGroup.Purple; //  会計20
    colorMap[FuncKey.KY_CHA21] = FbColorGroup.Purple; //  会計21
    colorMap[FuncKey.KY_CHA22] = FbColorGroup.Purple; //  会計22
    colorMap[FuncKey.KY_CHA23] = FbColorGroup.Purple; //  会計23
    colorMap[FuncKey.KY_CHA24] = FbColorGroup.Purple; //  会計24
    colorMap[FuncKey.KY_CHA25] = FbColorGroup.Purple; //  会計25
    colorMap[FuncKey.KY_CHA26] = FbColorGroup.Purple; //  会計26
    colorMap[FuncKey.KY_CHA27] = FbColorGroup.Purple; //  会計27
    colorMap[FuncKey.KY_CHA28] = FbColorGroup.Purple; //  会計28
    colorMap[FuncKey.KY_CHA29] = FbColorGroup.Purple; //  会計29
    colorMap[FuncKey.KY_CHA30] = FbColorGroup.Purple; //  会計30
    colorMap[FuncKey.KY_POINT_ADD] = FbColorGroup.DarkBlue; //  ポイント加算
    colorMap[FuncKey.KY_SPECIAL_PRICE] = FbColorGroup.Orange; //  特価品
    colorMap[FuncKey.KY_DELIVERY_SERVICE] = FbColorGroup.DarkBlue; //  宅配発行
    colorMap[FuncKey.KY_VESCA_RPR] = FbColorGroup.Purple; //  Verifone再印字

    colorMap[FuncKey.KY_FAULT_CHECK] = FbColorGroup.Navy; //  障害確認
    colorMap[FuncKey.KY_EXT_LR] = FbColorGroup.Navy; //  左右切替
    colorMap[FuncKey.KY_EXT_REG_ASSIST] = FbColorGroup.LightGreen; //  商品登録補助

    colorMap[FuncKey.KY_EXT_ASSIST] = FbColorGroup.LightGreen; //  登録補助

    colorMap[FuncKey.KY_EXT_PAYMENT] = FbColorGroup.LightGreen; //  決済
    colorMap[FuncKey.KY_REG_INP] = FbColorGroup.Navy; //  商品登録
    colorMap[FuncKey.KY_CASH_INP] = FbColorGroup.Purple; //  現金入力

    colorMap[FuncKey.KY_MCARD_IN] = FbColorGroup.Navy; //  会員カード読込(特定DS2仕様)
    colorMap[FuncKey.KY_MCARD_CHG] = FbColorGroup.Navy; //  会員カード切替(特定DS2仕様)

    colorMap[FuncKey.KY_QUOTATION] = FbColorGroup.Navy; //  見積宣言
    colorMap[FuncKey.KY_ZIPCODE] = FbColorGroup.Navy; //  ZIPコード
  }

  /// keyCdのenumと対応するカラーグループのenumを返す.
  /// keyCdのenumが無効値だった場合はnullをかえす.
  ///  関連tprxソース: getfunccolor.c - GetFuncColor
  FbColorGroup? getFuncColor(FuncKey key) {
    if (key == FuncKey.KY_NONE) {
      return null;
    }
    FbColorGroup retColor = colorMap[key] ?? FbColorGroup.MediumGray;
    return retColor;
  }

  /// keyCdのidと対応するカラーグループのIDを返す.
  ///  関連tprxソース: getfunccolor.c - GetFuncColor
  int getFuncColorCdFromKeyId(int keyId) {
    FuncKey key = FuncKey.getKeyDefine(keyId);
    FbColorGroup? cg = getFuncColor(key);
    if (cg == null) {
      return 0xffff;
    }
    return cg.index;
  }
}
