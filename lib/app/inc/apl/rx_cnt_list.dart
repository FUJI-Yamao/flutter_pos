/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import '../../inc/apl/fnc_code.dart';
/// ログ系の配列数
/// 在高種類
/// 関連tprxソース:rxcntlists.h - enum AMT_KIND
enum AmtKind {
  amtCash,
  amtCha1,
  amtCha2,
  amtCha3,
  amtCha4,
  amtCha5,
  amtCha6,
  amtCha7,
  amtCha8,
  amtCha9,
  amtCha10,
  amtCha11,
  amtCha12,
  amtCha13,
  amtCha14,
  amtCha15,
  amtCha16,
  amtCha17,
  amtCha18,
  amtCha19,
  amtCha20,
  amtCha21,
  amtCha22,
  amtCha23,
  amtCha24,
  amtCha25,
  amtCha26,
  amtCha27,
  amtCha28,
  amtCha29,
  amtCha30,
  amtChk1,
  amtChk2,
  amtChk3,
  amtChk4,
  amtChk5,
  amtMax
}

/// 関連tprxソース:rxcntlists.h - struct t_AmtKindList
class TAmtKindList {
  int amtKind = 0;
  int keyCd = 0;
  TAmtKindList(this.amtKind, this.keyCd);
}

///ミックスマッチの種類
/// 関連tprxソース:rxcntlists.h - enum BDL_KIND
enum BdlKind { bdlNormal, bdlMbr, bdlKindMax }

/// 売価変更の種類
/// 関連tprxソース:rxcntlists.h - enum PRCCHG_KIND
enum PrcChgKind {
  notPrcchg(0), // 通常
  prcchgDsc(1), // 売価変更値引
  prcchgPrc(2), // 売価変更
  prcchgBardsc(3), // バーコード売価変更値引
  prcchgBarprc(4), // バーコード売価変更
//	prcchgSchdsc(5),
//	prcchgSchprc(6),
  prcchgBrgn(7); // 特価品

  /// PrcChgKind+1の値を返す.
  static int get prcChgKindMax => PrcChgKind.values.last.id + 1;
  final int id;

  const PrcChgKind(this.id);
}

/// ログ系の配列数
/// 関連tprxソース:rxcntlists.h - define値
class CntList {
  static const sptendMax = 36; // スプリット段数の最大
  static const taxMax = 10; // 税金マスタレコード数の最大
  static const promMax = 50; // プロモーション数の最大
  static const itemRegsMax = 250; // 登録商品段数の最大
  static const stldscRegsMax = 6; // 値引と割引段数の最大
  static const itemMax = itemRegsMax + stldscRegsMax; // 商品段数の最大
  static const loyPromTtlMax = 300; // one to oneプロモーションのトータル系の最大
  static const loyPromItmMax = 50; // one to oneプロモーションのアイテム系の最大
  static const othPromMax = 99; // ロイヤリティ以外のプロモーション(クーポンやスタンプカード)の最大
  static const acntMax = 99; // アカウント段数の最大
  static const custDataMax = 30; // one to oneプロモーションでの1企画あたりの最大数
  static const dsckindMax = 5; // 値引と割引, 割増種類の最大
  static const promStldscMax = 99; // プロモーション小計値引・割引段数の最大
  static const loyCustKindTrgtMax = 30; // ロイヤリティ企画の対象会員種別の配列最大値

  static const itemMax99 = 99;
  static const itemMax50 = 50;
  static const itemMax1 = 1;

  static const restPromMax = 10; // 残権利数印字の最大
  static const trmplanMax = 10; // ターミナル企画番号の最大

  static const tcpnPrnMax = 10; // tポイント仕様 1取引内で作成する発券ログの最大数
  static const taiyoCpnMax = 20; // タイヨー仕様 クーポン発券レコードの最大数
  static const packOnTimeCnctMax = 21; // PackOnTimeでの機器番号の最大設定数

  static const rcschStmItmsch = 6; // セットマッチスケジュール商品指定保持件数
  static const rcschStmClssch = 0; // セットマッチスケジュール分類指定保持件数
  static const rcschStmAllsch =
      rcschStmItmsch + rcschStmClssch; // セットマッチスケジュール保持件数

  static List<TAmtKindList> tAmtKindList = [
        TAmtKindList(AmtKind.amtCash.index,  FuncKey.KY_CASH.keyId),
        TAmtKindList(AmtKind.amtCha1.index, FuncKey.KY_CHA1.keyId),
        TAmtKindList(AmtKind.amtCha2.index, FuncKey.KY_CHA2.keyId),
        TAmtKindList(AmtKind.amtCha3.index, FuncKey.KY_CHA3.keyId),
        TAmtKindList(AmtKind.amtCha4.index, FuncKey.KY_CHA4.keyId),
        TAmtKindList(AmtKind.amtCha5.index, FuncKey.KY_CHA5.keyId),
        TAmtKindList(AmtKind.amtCha6.index, FuncKey.KY_CHA6.keyId),
        TAmtKindList(AmtKind.amtCha7.index, FuncKey.KY_CHA7.keyId),
        TAmtKindList(AmtKind.amtCha8.index, FuncKey.KY_CHA8.keyId),
        TAmtKindList(AmtKind.amtCha9.index, FuncKey.KY_CHA9.keyId),
        TAmtKindList(AmtKind.amtCha10.index, FuncKey.KY_CHA10.keyId),
        TAmtKindList(AmtKind.amtCha11.index, FuncKey.KY_CHA11.keyId),
        TAmtKindList(AmtKind.amtCha12.index, FuncKey.KY_CHA12.keyId),
        TAmtKindList(AmtKind.amtCha13.index, FuncKey.KY_CHA13.keyId),
        TAmtKindList(AmtKind.amtCha14.index, FuncKey.KY_CHA14.keyId),
        TAmtKindList(AmtKind.amtCha15.index, FuncKey.KY_CHA15.keyId),
        TAmtKindList(AmtKind.amtCha16.index, FuncKey.KY_CHA16.keyId),
        TAmtKindList(AmtKind.amtCha17.index, FuncKey.KY_CHA17.keyId),
        TAmtKindList(AmtKind.amtCha18.index, FuncKey.KY_CHA18.keyId),
        TAmtKindList(AmtKind.amtCha19.index, FuncKey.KY_CHA19.keyId),
        TAmtKindList(AmtKind.amtCha20.index, FuncKey.KY_CHA20.keyId),
        TAmtKindList(AmtKind.amtCha21.index, FuncKey.KY_CHA21.keyId),
        TAmtKindList(AmtKind.amtCha22.index, FuncKey.KY_CHA22.keyId),
        TAmtKindList(AmtKind.amtCha23.index, FuncKey.KY_CHA23.keyId),
        TAmtKindList(AmtKind.amtCha24.index, FuncKey.KY_CHA24.keyId),
        TAmtKindList(AmtKind.amtCha25.index, FuncKey.KY_CHA25.keyId),
        TAmtKindList(AmtKind.amtCha26.index, FuncKey.KY_CHA26.keyId),
        TAmtKindList(AmtKind.amtCha27.index, FuncKey.KY_CHA27.keyId),
        TAmtKindList(AmtKind.amtCha28.index, FuncKey.KY_CHA28.keyId),
        TAmtKindList(AmtKind.amtCha29.index, FuncKey.KY_CHA29.keyId),
        TAmtKindList(AmtKind.amtCha30.index, FuncKey.KY_CHA30.keyId),
        TAmtKindList(AmtKind.amtChk1.index, FuncKey.KY_CHK1.keyId),
        TAmtKindList(AmtKind.amtChk2.index, FuncKey.KY_CHK2.keyId),
        TAmtKindList(AmtKind.amtChk3.index, FuncKey.KY_CHK3.keyId),
        TAmtKindList(AmtKind.amtChk4.index, FuncKey.KY_CHK4.keyId),
        TAmtKindList(AmtKind.amtChk5.index, FuncKey.KY_CHK5.keyId)
  ];

  static const fgUseSerialArrMax = 20; // FG券利用通信 利用発券番号情報の配列数
}

/// rxcntLists.h 各種定数
class RxCntList {
  static const OTH_PROM_MAX = 99;  // ロイヤリティ以外のプロモーション(クーポンやスタンプカード)の最大
  static const LOY_PROM_TTL_MAX = 300;	// one to oneプロモーションのトータル系の最大
}
