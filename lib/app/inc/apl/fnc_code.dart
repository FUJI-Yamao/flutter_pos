/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';

/// 関連tprxソース:fnc_code.h - FKEY_LISTS以外の定数定義
enum FncCode {
  KY_ENT(1),   // キー入力状態
  KY_FNAL(2),  // スプリット状態
  KY_REG(3),   // レジ状態
  KY_SCAN(4),  // スキャン状態
  KY_PSET(5);  // プリセット

  final int keyId;
  const FncCode(this.keyId);
}

///
/// FUNCTION KEY CODE定義.
/// 関連tprxソース:fnc_code.h FKEY_LISTS
/// FuncKeyのindexはkeyIdとは値がずれているので使用禁止.
///
enum FuncKey {
  KY_NONE(-1),
  KY_1(1), //  テンキー1
  KY_2(2), //  テンキー2
  KY_3(3), //  テンキー3
  KY_4(4), //  テンキー4
  KY_5(5), //  テンキー5
  KY_6(6), //  テンキー6
  KY_7(7), //  テンキー7
  KY_8(8), //  テンキー8
  KY_9(9), //  テンキー9
  KY_0(10), //  テンキー0
  KY_00(11), //  テンキー00
  KY_000(12), //  テンキー000
  KY_STL(13), //  小計
  KY_CASH(14), //  預り／現計
  KY_CHA1(15), //  会計1
  KY_CHA2(16), //  会計2
  KY_CHA3(17), //  会計3
  KY_CHA4(18), //  会計4
  KY_CHA5(19), //  会計5
  KY_CHA6(20), //  会計6
  KY_CHA7(21), //  会計7
  KY_CHA8(22), //  会計8
  KY_CHA9(23), //  会計9
  KY_CHA10(24), //  会計10
  KY_CRDT(25), //  掛売
  KY_CHK1(26), //  品券1
  KY_CHK2(27), //  品券2
  KY_CHK3(28), //  品券3
  KY_CHK4(29), //  品券4
  KY_CHK5(30), //  品券5
  KY_CDCARD1(31), //  クレジット1
  KY_CDCARD2(32), //  クレジット2
  KY_PPC(33), //  PPC売上
  KY_CLR(34), //  クリアー
  KY_MAN(35), //  万券
  KY_5SEN(36), //  5千券
  KY_2SEN(37), //  2千券
  KY_SEN(38), //  千券
  KY_DSC1(39), //  値引1
  KY_DSC2(40), //  値引2
  KY_DSC3(41), //  値引3
  KY_DSC4(42), //  値引4
  KY_DSC5(43), //  値引5
  KY_PM1(44), //  割引1
  KY_PM2(45), //  割引2
  KY_PM3(46), //  割引3
  KY_PM4(47), //  割引4
  KY_PM5(48), //  割引5
  KY_PLU(49), //  PLU
  KY_MG(50), //  MG
  KY_DRW(51), //  ＃／両替
  KY_RCT(52), //  レシートフィード
  KY_RPR(53), //  再発行
  KY_RCTFM(54), //  領収書
  KY_RCTON(55), //  印字ON/OFF
  KY_PRC(56), //  金額
  KY_CORR(57), //  直前訂正
  KY_VOID(58), //  指定訂正
  KY_CNCL(59), //  取消
  KY_REF(60), //  返品
  KY_SCRVOID(61), //  画面訂正
  KY_SUS(62), //  仮締呼出
  KY_MUL(63), //  ×／日付
  KY_CIN1(64), //  入金1
  KY_CIN2(65), //  入金2
  KY_CIN3(66), //  入金3
  KY_CIN4(67), //  入金4
  KY_CIN5(68), //  入金5
  KY_CIN6(69), //  入金6
  KY_CIN7(70), //  入金7
  KY_CIN8(71), //  入金8
  KY_CIN9(72), //  入金9
  KY_CIN10(73), //  入金10
  KY_OUT1(74), //  支払1
  KY_OUT2(75), //  支払2
  KY_OUT3(76), //  支払3
  KY_OUT4(77), //  支払4
  KY_OUT5(78), //  支払5
  KY_OUT6(79), //  支払6
  KY_OUT7(80), //  支払7
  KY_OUT8(81), //  支払8
  KY_OUT9(82), //  支払9
  KY_OUT10(83), //  支払10
  KY_LOAN(84), //  釣準備
  KY_PICK(85), //  売上回収
  KY_INT(86), //  割込
  KY_MENU(87), //  終了
  KY_RMOD(88), //  登録画面
  KY_CMOD(89), //  扱者画面
  KY_MBR(90), //  会員呼出
  KY_CARD(91), //  カード読込
  KY_MEMSRV(92), //  割戻 掘
  KY_DSP1(93), //  画面1
  KY_DSP2(94), //  画面2
  KY_DSP3(95), //  画面3
  KY_DSP4(96), //  画面4
  KY_DSP5(97), //  画面5
  KY_DSP6(98), //  画面6
  KY_DSP7(99), //  画面7
  KY_CHGOUT(100), //  釣機払出
  KY_CHGREF(101), //  釣機参照
  KY_CHGPWR(102), //  釣機ON/OFF
  KY_CHGPTN(103), //  釣機両替
  KY_PRSN(104), //  人数
  KY_CULAY1(105), //  客層1
  KY_CULAY2(106), //  客層2
  KY_CULAY3(107), //  客層3
  KY_CULAY4(108), //  客層4
  KY_CULAY5(109), //  客層5
  KY_CULAY6(110), //  客層6
  KY_CULAY7(111), //  客層7
  KY_CULAY8(112), //  客層8
  KY_CULAY9(113), //  客層9
  KY_CULAY10(114), //  客層10
  KY_UP(115), //  UP
  KY_DOWN(116), //  DOWN
  KY_CHGDSP(117), //  画面切替
  KY_BRT(118), //  返瓶
  KY_BRA(119), //  未使用
  KY_SPR(120), //  スプロケット
  KY_SLIP(121), //  スリップ
  KY_CIN11(122), //  入金11
  KY_CIN12(123), //  入金12
  KY_CIN13(124), //  入金13
  KY_CIN14(125), //  入金14
  KY_CIN15(126), //  入金15
  KY_CIN16(127), //  入金16
  KY_OUT11(128), //  支払11
  KY_OUT12(129), //  支払12
  KY_OUT13(130), //  支払13
  KY_OUT14(131), //  支払14
  KY_OUT15(132), //  支払15
  KY_OUT16(133), //  支払16
  KY_ADDPNT(134), //  買上追加
  KY_EJCONF(135), //  記録確認
  KY_EVOID(136), //  一括訂正
  KY_EREF(137), //  検索返品
  KY_ERPR(138), //  検索ﾚｼｰﾄ
  KY_STAFF(139), //  従業員
  KY_2STAFF(140), //  2人制(未使用)
  KY_CRDTIN(141), //  クレジット宣言
  KY_WTTARE1(142), //  秤/風袋1
  KY_WTTARE2(143), //  秤/風袋2
  KY_WTTARE3(144), //  秤/風袋3
  KY_WTTARE4(145), //  秤/風袋4
  KY_WTTARE5(146), //  秤/風袋5
  KY_WTTARE6(147), //  秤/風袋6
  KY_WTTARE7(148), //  秤/風袋7
  KY_WTTARE8(149), //  秤/風袋8
  KY_WTTARE9(150), //  秤/風袋9
  KY_WTTARE10(151), //  秤/風袋10
  KY_UPRC(152), //  重さ単価
  KY_PCHG(153), //  売価変更
  KY_STLPPC(154), //  ｶ-ﾄﾞ小計
  KY_DISCHR(155), //  ｶ-ﾄﾞ排出
  KY_CARDMENT(156), //  ｶ-ﾄﾞ保守
  KY_CHGCIN(157), //  釣機入金
  KY_PRCCHK(158), //  売価ﾁｪｯｸ
  KY_DELIV_RCT(159), //  ﾚｼ-ﾄ控え
  KY_CALC(160), //  計算
  KY_RDRW(161), //  ﾘﾗｲﾄ読込
  KY_TCKTISSU(162), //  ﾁｹｯﾄ発行
  KY_WRTY(163), //  保証書
  KY_STAMP1(164), //  ｽﾀﾝﾌﾟ1
  KY_STAMP2(165), //  ｽﾀﾝﾌﾟ2
  KY_STAMP3(166), //  ｽﾀﾝﾌﾟ3
  KY_STAMP4(167), //  ｽﾀﾝﾌﾟ4
  KY_STAMP5(168), //  ｽﾀﾝﾌﾟ5
  KY_STAFFCALL(169), //  店員ｺ-ﾙ(未使用)
  KY_DECIMAL(170), //  小数点
  KY_FLIGHT1(171), //  ﾌﾗｲﾄ1
  KY_FLIGHT2(172), //  ﾌﾗｲﾄ2
  KY_FLIGHT3(173), //  ﾌﾗｲﾄ3
  KY_FLIGHT4(174), //  ﾌﾗｲﾄ4
  KY_FLIGHT5(175), //  ﾌﾗｲﾄ5
  KY_FLIGHT6(176), //  ﾌﾗｲﾄ6
  KY_FLIGHT7(177), //  ﾌﾗｲﾄ7
  KY_FLIGHT8(178), //  ﾌﾗｲﾄ8
  KY_FLIGHT9(179), //  ﾌﾗｲﾄ9
  KY_FLIGHT10(180), //  ﾌﾗｲﾄ10
  KY_FLIGHT11(181), //  ﾌﾗｲﾄ11
  KY_FLIGHT12(182), //  ﾌﾗｲﾄ12
  KY_FLIGHT13(183), //  ﾌﾗｲﾄ13
  KY_FLIGHT14(184), //  ﾌﾗｲﾄ14
  KY_FLIGHT15(185), //  ﾌﾗｲﾄ15
  KY_FLIGHT16(186), //  ﾌﾗｲﾄ16
  KY_FLIGHT17(187), //  ﾌﾗｲﾄ17
  KY_FLIGHT18(188), //  ﾌﾗｲﾄ18
  KY_FLIGHT19(189), //  ﾌﾗｲﾄ19
  KY_FLIGHT20(190), //  ﾌﾗｲﾄ20
  KY_FLIGHT21(191), //  ﾌﾗｲﾄ21
  KY_FLIGHT22(192), //  ﾌﾗｲﾄ22
  KY_FLIGHT23(193), //  ﾌﾗｲﾄ23
  KY_FLIGHT24(194), //  ﾌﾗｲﾄ24
  KY_FLIGHT25(195), //  ﾌﾗｲﾄ25
  KY_FLIGHT26(196), //  ﾌﾗｲﾄ26
  KY_FLIGHT27(197), //  ﾌﾗｲﾄ27
  KY_DETAIL(198), //  明細印字
  KY_MBRCLR(199), //  会員取消
  KY_TEL(200), //  電話番号
  KY_EDYREF(201), //  Edy残高
  KY_CARDFORGET(202), //  ｶ-ﾄﾞ忘れ
  KY_MOBILE(203), //  モバイル
  KY_PUSE(204), //  Pｶ-ﾄﾞ使用
  KY_PMNG(205), //  Pｶ-ﾄﾞ扱い
  KY_STPR_RCT(206), //  伝票ﾌｨ-ﾄﾞ
  KY_STPR_RPR(207), //  伝票発行
  KY_STPR_RRCTON(208), //  伝票ON/OFF
  KY_OFF(209), //  休止
  KY_MPRC(210), //  会員売価
  KY_PLUS1(211), //  割増1
  KY_PLUS2(212), //  割増2
  KY_PLUS3(213), //  割増3
  KY_PLUS4(214), //  割増4
  KY_PLUS5(215), //  割増5
  KY_MCASH(216), //  ｶ-ﾄﾞ現金
  KY_MCRDT(217), //  ｶ-ﾄﾞ一括
  KY_DRWCHK(218), //  差異ﾁｪｯｸ
  KY_ESVOID(219), //  検索訂正
  KY_ESVALLCNCL(220), //  未使用 */ /* 検索訂正時の全取消キーで使用
  KY_ESVDSCCHG(221), //  未使用 */ /* 検索訂正時の小計値下変更キーで使用
  KY_REZERO(222), //  ｾﾞﾛﾘｾｯﾄ
  KY_RDVMC(223), //  ﾋﾞｽﾏｯｸ読込
  KY_NOTAX(224), //  非課税
  KY_COMP_CD(225), //  企業ｺ-ﾄﾞ
  KY_CLSCNCL(226), //  分類解除
  KY_ISSU_STOP(227), //  発行停止
  KY_2PERSON(228), //  ２人制
  KY_HCRDT(229), //  自社クレ
  KY_MCALC(230), //  単独割振
  KY_MPINQ(231), //  ﾎﾟｲﾝﾄ照会
  KY_MRATE(232), //  倍率変更
  KY_ERCTFM(233), //  検索領収書
  KY_5HYAKU(234), //  5百券
  KY_MCNEW(235), //  ｶｰﾄﾞ更新
  KY_TWNOSET(236), //  發票設定
  KY_TWNOSR(237), //  發票廃棄
  KY_CASHINT(238), //  割込予約
  KY_MDL(239), //  中分類
  KY_MMINQ(240), //  顧客情報照会
  KY_CRDTVOID(241), //  クレジット訂正
  KY_STAFFPRC(242), //  社員売価
  KY_MCFEE(243), //  管理費登録
  KY_BEAMRELEASE(244), //  桁解除
  KY_LRG(245), //  大分類
  KY_FB_MEMO(246), //  メモ
  KY_PREITEM(247), //  明細表示
  KY_PMEMO(248), //  連絡確認
  KY_FB_PMEMO(249), //  連絡
  KY_DISHCALC(250), //  皿勘定
  KY_DISHCLR(251), //  勘定クリア
  KY_REVENUE(252), //  印紙除外
  KY_OUTRBT(253), //  割戻対象外
  KY_STLDSCCNCL(254), //  小計取消
  KY_GODUTCH(255), //  割勘額表示
  KY_FB_CMEMO(256), //  釣銭要求
  KY_RBTCNCL(257), //  割戻取消
  KY_PLUSCNCL(258), //  割増取消
  KY_KYREQ(259), //  呼出
  KY_MANUALMM1(260), //  手動ﾐｯｸｽﾏｯﾁ1
  KY_MANUALMM2(261), //  手動ﾐｯｸｽﾏｯﾁ2
  KY_MANUALMM3(262), //  手動ﾐｯｸｽﾏｯﾁ3
  KY_MANUALMM4(263), //  手動ﾐｯｸｽﾏｯﾁ4
  KY_MANUALMM5(264), //  手動ﾐｯｸｽﾏｯﾁ5
  KY_MANUALMM6(265), //  手動ﾐｯｸｽﾏｯﾁ6
  KY_MANUALMM7(266), //  手動ﾐｯｸｽﾏｯﾁ7
  KY_MANUALMM8(267), //  手動ﾐｯｸｽﾏｯﾁ8
  KY_MANUALMM9(268), //  手動ﾐｯｸｽﾏｯﾁ9
  KY_MANUALMM10(269), //  手動ﾐｯｸｽﾏｯﾁ10
  KY_SUICAREF(270), //  交通系ＩＣ残額
  KY_DISPLIST(271), //  画面一覧
  KY_CUSTD_HIST(272), //  顧客履歴
  KY_CHGQTY(273), //  個数変更
  KY_SPRIT(274), //  スプリット
  KY_CHGPICK(275), //  釣機回収
  KY_CUSTD_MTG(276), //  売筋検索
  KY_CUST_POPUP(277), //  顧客案内
  KY_DISBURSE(278), //  出納
  KY_TAGRD(279), //  タグ読込
  KY_TAGWT(280), //  タグ書込
  KY_CHGPOST(281), //  釣再計算
  KY_SLASH(282), //  ／
  KY_ITMINF(283), //  明細付加情報
  KY_TTLINF(284), //  取引付加情報
  KY_WORKIN(285), //  業務宣言
  KY_HCARDIN(286), //  会員カード読込
  KY_HCRDTIN(287), //  自社クレジット宣言
  KY_EDYNO(288), //  Edy番号
  KY_RRATE(289), //  ﾚｼｰﾄ倍率
  KY_OMC(290), //  OMC優待
  KY_SPCNCL(291), //  締め取消
  KY_PMOV(292), //  ﾎﾟｲﾝﾄ移行
  KY_HOME_DLV(293), //  配達便
  KY_PLU_INFO(294), //  商品情報
  KY_PRCLBL(295), //  値付ﾗﾍﾞﾙ
  KY_PRCLBL_RPR(296), //  値付再発行
  KY_PRCLBLON(297), //  値付ON/OFF
  KY_PRCLBLNOITEM(298), //  値付商品未登録
  KY_REL_MENTE(299), //  ﾒﾝﾃ解除
  KY_SALELMTBARIN(300), //  販売期限バーコード
  KY_WIZSTART(301), //  Wiz通信開始
  KY_WIZEND(302), //  Wiz通信終了
  KY_CARRY(303), //  積載指示書
  KY_BRND_CHA(304), //  ﾌﾞﾗﾝﾄﾞ取引選択
  KY_BRND_REF(305), //  ﾌﾞﾗﾝﾄﾞ残高照会
  KY_BRND_CIN(306), //  ﾌﾞﾗﾝﾄﾞ現金ﾁｬｰｼﾞ
  KY_GS1BAR(307), //  GS1入力
  KY_ASSORT(308), //  詰合固定
  KY_RESERVCALL(309), //  予約呼出
  KY_RESERVCNCL(310), //  予約取消
  KY_RESERVCONF(311), //  予約確認
  KY_MANUALMM_REPET(312), //  手動リピート
  KY_EDYHIST(313), //  Edy履歴
  KY_ASSORTCALL(314), //  詰合呼出
  KY_IMMED_PCHG(315), //  即時売変
  KY_TAB1(316), //  タブ右
  KY_TAB2(317), //  タブ中
  KY_TAB3(318), //  タブ左
  KY_POINTISSU(319), //  ﾎﾟｲﾝﾄ発券
  KY_MULRBT1(320), //  多段割戻1
  KY_MULRBT2(321), //  多段割戻2
  KY_MULRBT3(322), //  多段割戻3
  KY_MULRBT4(323), //  多段割戻4
  KY_MULRBT5(324), //  多段割戻5
  KY_PNT_SHIFT(325), //  ポイント移行
  KY_CHGITM(326), //  明細変更
  KY_BARIN(327), //  ﾊﾞｰｺｰﾄﾞ
  KY_PREPRC(328), //  金額(売価ﾁｪｯｸ)
  KY_QC_TCKT(329), //  お会計券
  KY_PBCHG(330), //  公共料金
  KY_DECISION(331), //  登録
  KY_TABPLUS(332), //  新規
  KY_TABRETURN(333), //  呼出
  KY_DUTY(334), //  勤怠

  KY_PRDINP(338), //  生産者/PLU
  KY_GIFT_CODE(339), //  ギフトコード
  KY_CARD_IN(340), //  カード取引
  KY_CARD_CIN(341), //  カード入金
  KY_DRWCHG(342), //  独立現外
  KY_BATCHREG(343), //  一括登録
  KY_CINDSC(344), //  入金値引
  KY_NETRESERV(345), //  ネット予約
  KY_SRCHREG(346), //  検索登録
  KY_QRPRNTYP(347), //  ＱＲ切替
  KY_DIVADJ(348), //  分割精算

  KY_SELPLUADJ(350), //  個別精算
  KY_CHGDRW(351), //  棒金開
  KY_CHGTRAN(352), //  入出金確認
  KY_CUSTOMERBARIN(353), //  カスタマーカードバーコード
  KY_QCSELECT(354), //  ＱＣ指定1
  KY_BACKSPACE(355), //  BackSpace(一文字削除)
  KY_QCSELECT2(356), //  ＱＣ指定2
  KY_QCSELECT3(357), //  ＱＣ指定3
  KY_CASHVOID(358), //  金種訂正
  KY_RPRRESERV(359), //  再発行予約
  KY_QC_NOTPAY_LIST(360), //  未精算一覧
  KY_REQUEST_DRW(361), //  両替依頼書
  KY_CNCL_CULAY(362), //  客層取消
  KY_DIV_CNCL(363), //  分割解除
  KY_INTERRUPT(364), //  中断
  KY_128BARIN(365), //  28桁バーコード
  KY_WTPRC(366), //  重量商品価格
  KY_RFDOPR(367), //  返品ﾓｰﾄﾞ
  KY_BRAINREAD(368), //  Brain File Read
  KY_ACXINFO(369), //  釣銭情報
  KY_CHGASSORTPLU(370), //  詰合せ固定商品変更
  KY_GRATIS(371), //  無償商品登録
  KY_QR_RPR(373), //  QR再発行
  KY_PITAPA_REF(374), //  PiTaPa累計照会
  KY_PRE_RCTFM(375), //  領収書宣言
  KY_MBRPRN(376), //  会員印字
  KY_WEIGHT_INP(377), //  重量入力
  KY_CHGCHK(378), //  釣機戻入
  KY_CHG_MENTEOUT(379), //  取引外払出
  KY_BC(380), //  ＢＣ券
  KY_PRECA_IN(381), //  プリカ宣言
  KY_PRECA_REF(382), //  プリカ残高照会
  KY_PRECAVOID(383), //  プリカ訂正
  KY_CHA11(384), //  会計11
  KY_CHA12(385), //  会計12
  KY_CHA13(386), //  会計13
  KY_CHA14(387), //  会計14
  KY_CHA15(388), //  会計15
  KY_CHA16(389), //  会計16
  KY_CHA17(390), //  会計17
  KY_CHA18(391), //  会計18
  KY_CHA19(392), //  会計19
  KY_CHA20(393), //  会計20
  KY_CHA21(394), //  会計21
  KY_CHA22(395), //  会計22
  KY_CHA23(396), //  会計23
  KY_CHA24(397), //  会計24
  KY_CHA25(398), //  会計25
  KY_CHA26(399), //  会計26
  KY_CHA27(400), //  会計27
  KY_CHA28(401), //  会計28
  KY_CHA29(402), //  会計29
  KY_CHA30(403), //  会計30
  KY_DRWCHK_CASH(404), //  手持現金入力
  KY_NIMOCAREF(405), //  ICﾎﾟｲﾝﾄ訂正
  KY_NEXTCUST_REGS(406), //  次客登録
  KY_NEXTCUST_RETN(407), //  次客呼出
  KY_PLUQTYCONF(408), //  個数確認
  KY_CHG_STATUS(409), //  釣機状態
  KY_CHGCIN_RETURN(410), //  入金返却
  KY_SALE_PERMISSION(411), //  販売許可
  KY_REG_INSPECT(412), //  レジ点検
  //  413-415は予約中(S.Uchino)
  KY_POINT_ADD(413), //  ポイント加算
  KY_SPECIAL_PRICE(414), //  特価品
  KY_DELIVERY_SERVICE(415), //  宅配発行
  KY_TPOINT_CPN(416), //  ｸｰﾎﾟﾝ利用
  KY_DISP1(417), //  画面1
  KY_DISP2(418), //  画面2
  KY_DISP3(419), //  画面3
  KY_DISP4(420), //  画面4
  KY_DISP5(421), //  画面5
  KY_DISP6(422), //  画面6
  KY_DISP7(423), //  画面7
  KY_DISP8(424), //  画面8
  KY_DISP9(425), //  画面9
  KY_DISP10(426), //  画面10
  KY_DISP11(427), //  画面11
  KY_DISP12(428), //  画面12
  KY_DISP13(429), //  画面13
  KY_DISP14(430), //  画面14
  KY_DISP15(431), //  画面15
  KY_DISP16(432), //  画面16
  KY_DISP17(433), //  画面17
  KY_DISP18(434), //  画面18
  KY_TAXFREE_IN(435), //  免税宣言
  KY_SS_VOID(436), //  ＳＳ訂正
  KY_EXT_GUARANTEE(437), //  延長保証
  KY_MBRINFCNF(438), //  会員情報確認
  KY_L22DSCBAR(443), //  22桁値下バーコード
  KY_CLSCNCLSGL(444), //  単品分類解除
  KY_STAFF_RELEASE(445), //  従業員権限解除

  KY_CHG_GOODS(448), //  指定商品データ変更
  KY_VESCA_RPR(449), //  Verifone再印字
  KY_LANG_CHG(450), //  言語切替
  KY_RCPT_VOID(451), //  通番訂正
  KY_ACXERRGUI(452), //  釣機復旧案内
  KY_SELF_CHG(456), //  セルフ切替

  KY_CHG_SELECT_ITEMS(463), //  指定変更
  KY_SELF_MENTE(464), //  セルフメンテ

  KY_PRECA_CLR(467), //  プリカ宣言取消
  KY_CAT_CARDREAD(468), //  端末カード読込
  KY_FAULT_CHECK(469), //  障害確認
  KY_WAONREF(470), //  WAON残高
  KY_WAONHIST(471), //  WAON履歴
  KY_QC_CHG(472), //  QC切替
  KY_WIZ_RENT(474), //  WIZ貸出
  KY_EXPQC_SEL(475), //  QC指定拡大表示
  KY_WIZSELF_CHG(476), //  WizSelf切替
  KY_CAPTURE(477), //  キャプチャ
  KY_OVERFLOW_PICK(481), //  ｵｰﾊﾞｰﾌﾛｰ回収
  KY_MBRREAD_CANCEL(482), //  会員読取中止
  KY_MOBILE_T_READ(483), //  ﾓﾊﾞｲﾙT読込
  KY_DPOINT_MINPUT(484), //  dﾎﾟｲﾝﾄ手入力
  KY_DPOINT_MODIFY(485), //  dﾎﾟｲﾝﾄ修正

  KY_MULTI_CHG(487), //  マルチ切替
  KY_OVERFLOW_MOVE(488), //  ｵｰﾊﾞｰﾌﾛｰ庫移動
  KY_OVERFLOW_MENTE(489), //  ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ
  KY_READ_MONEY(491), //  金額読込
  KY_MCHGMAG(492), //  倍率手動変更
  KY_REPICAPNT_MODIFY(495), //  ﾌﾟﾘｶﾎﾟｲﾝﾄ訂正

  KY_RPOINT_MINPUT(502), //  楽天ﾎﾟｲﾝﾄ手入力
  KY_PCT_IN(503), //  PCT宣言

  KY_MST_REF(700), //  残高照会
  KY_CPNPRN(701), //  クーポン印字
  KY_BARDSC(702), //  未使用 */ /* バーコード値引で使用
  KY_BARPDSC(703), //  未使用 */ /* バーコード割引で使用
  KY_PAYMENT(704), //  決済選択
  KY_CASHRECYCLE_IN(705), //  未使用 */ /* キャッシュリサイクル入金実績のky_cdで使用
  KY_CASHRECYCLE_OUT(706), //  未使用 */ /* キャッシュリサイクル出金実績のky_cdで使用
  KY_NORMAL_STLDSC(707), //  未使用 */ /* 一般小計割引: 小計値下実績のky_cdで使用
  KY_CUST_STLDSC(708), //  未使用 */ /* 会員小計割引: 小計値下実績のky_cdで使用
  KY_PORTAL_CONF(709), //  ポータル認証
  KY_QC_MENTEMODE(710), //  未使用 */ /* QCashierのメンテナンスモードに入る権限チェック用
  KY_AUTO_DECCIN(711), //  未使用 */ /* 従業員入金確定／従業員自動確定権限チェック用
  KY_STAFF_REPT(712), //  従業員精算
  KY_CHGTAX1(713), //  税変換1
  KY_CHGTAX2(714), //  税変換2
  KY_CHGTAX3(715), //  税変換3
  KY_CHGTAX4(716), //  税変換4
  KY_CHGTAX5(717), //  税変換5
  KY_CASHRECYCLE(718), //  キャッシュリサイクル(キー動作判別する為、ファンクションボタン作成しない
  KY_TMEMO_REL(719), //  連絡メモ関連
  KY_CHG_DECCIN(720), //  入金確定
  KY_RCTFM_RPR(721), //  領収書再発行
  KY_EXT_LR(722), //  左右切替
  KY_EXT_REG_ASSIST(723), //  商品登録補助
  KY_EXT_ASSIST(724), //  登録補助
  KY_EXT_PAYMENT(725), //  決済
  KY_REG_INP(726), //  商品登録
  KY_CASH_INP(727), //  現金入力
  KY_BUY_HIST(728), //  購買履歴
  KY_MCARD_IN(729), //  会員カード読込(特定DS2仕様)
  KY_MCARD_CHG(730), //  会員カード切替(特定DS2仕様)
  KY_RESERV(731), //  予約
  KY_RESERV_CREDIT(732), //  掛売
  KY_RESERV_DELIVERY(733), //  配達
  KY_RESERV_ESTIMATE(734), //  見積り
  KY_QUOTATION(735), //  見積宣言
  KY_SVSTCKTBAR_IN(736), //  サービス券バーコード
  KY_MNT_CHGR_RECUL(737), //  釣機再精査 (登録メンテナンス画面 用)
  KY_MNT_IN_CNCL(738), //  入金取消 (登録メンテナンス画面 用)
  KY_MNT_ITEM_CNCL(739), //  商品取消 (登録メンテナンス画面 用)
  KY_CASHLESS_OFF(740), //  還元なし (全日食様キャッシュレス還元用)
  KY_ZIPCODE(741), //  ZIPコード
  KY_POINT_HIST(742), //  ポイント履歴
  KY_MBRINFCNF2(743), //  会員情報照会
  KY_CPN_INPUT(744), //  クーポン手入力
  KY_AGENCY(745), //  代理店
  KY_INTEGRATED(746), //  会員統合
  KY_OMNI_CHANNEL(747), //  EC連携
  KY_MDLLIST(748), //  中分類一覧
  KY_COUPON_REISSUE(749), //  クーポン再発行
  KY_LOTOTCKT_SUM(750), //  抽選券集計
  KY_EC_FREE_RECEIPT(751), //  受領書
  KY_COUPON_TOGGLE(752), //  ｸｰﾎﾟﾝOFF
  KY_COUPON_REF(753), //  クーポン照会
  KY_WTCLR(754), //  計量取消 (RM-3800専用)
  KY_POINT_CANCEL(755), //  ポイント取消
  KY_DEPOBRT(756), //  瓶返却
  KY_CONTINUED_USE(757), //  容器継続利用
  KY_RCTFM_MANINP(758), //  手入力領収書
  KY_POINT_SEL(759), //  ポイント切替
  KY_PRESET_JUMP(760), //  プリセット切替
  KY_PRESET_RETURN(761), //  切替戻し
  KY_ACCOUNT_RECEIVABLE(762), //  売掛宣言
  KY_TOMOCARD_READ(763), //  友の会ｶｰﾄﾞ読込
  KY_TOMOCARD_INQ(764), //  友の会ｶｰﾄﾞ照会
  KY_CR_INOUT(765), //  CR入出金
  KY_HI_TOUCH(766), //  ﾊｲﾀｯﾁ (RM-3800専用)
  KY_SPECIAL_BARCODE_READ(767), //  特殊ﾊﾞｰｺｰﾄﾞ読取
  KY_PLUINFO(768),	// 商品情報(RF様特注)
  KY_PLUS_IDX_CLEAR(769),	// 加算情報クリア(RM-3800専用)
  KY_CHARGE_PLU_SLC(770),	/* ﾁｬｰｼﾞ商品選択 */
  KY_FL_SALESREPORT(771),	/* 売上速報 */
  KY_FL_SALESREPORTSINGLEITEM(772),  /* 単品売上 */
  KY_DRWCHK_2(773),	/* 在高入力 */
  KY_CASHBACK(774),	/* ｷｬｯｼｭﾊﾞｯｸ(オオゼキ様ｷｬｯｼｭﾊﾞｯｸ画面用) */
  KY_CHGQTY_RM59(775),	/* 点数変更 */	// RM-3800
  KY_PAY_LIST1(781), /*電子マネー*/
  KY_PAY_LIST2(782), /*商品券*/

  MAX_FKEY(999);	/* LAST  */

  /// 今定義されているFuncKeyの中の最大値+1の値を返す.
  static int get keyMax => FuncKey.values.last.keyId + 1;
  final int keyId;
  const FuncKey(this.keyId);

  /// keyIdから対応するFuncKeyを取得する.
  static FuncKey getKeyDefine(int keyId) {
    FuncKey? keyDefine =
        FuncKey.values.firstWhereOrNull((a) => a.keyId == keyId);
    keyDefine ??= FuncKey.KY_NONE; // 定義されているものになければnoneを入れておく.
    print('getKeyDefine keyId =$keyId. keyDefine = $keyDefine');
    return keyDefine;
  }

  // プロトタイプ向け.キーコードと数値の対応付け .
  int getFuncKeyNumber() {
    switch (this) {
      case FuncKey.KY_0:
      case FuncKey.KY_00:
      case FuncKey.KY_000:
        return 0;
      case FuncKey.KY_1:
        return 1;
      case FuncKey.KY_2:
        return 2;
      case FuncKey.KY_3:
        return 3;
      case FuncKey.KY_4:
        return 4;
      case FuncKey.KY_5:
        return 5;
      case FuncKey.KY_6:
        return 6;
      case FuncKey.KY_7:
        return 7;
      case FuncKey.KY_8:
        return 8;
      case FuncKey.KY_9:
        return 9;
      default:
        return 0;
    }
  }

  // プロトタイプ向け.キーコードと文字の対応付け .
  String getFuncKeyNumberStr() {
    switch (this) {
      case FuncKey.KY_00:
        return "00";
      case FuncKey.KY_000:
        return "000";
      default:
        int number = getFuncKeyNumber();
        return number.toString();
    }
  }
}
