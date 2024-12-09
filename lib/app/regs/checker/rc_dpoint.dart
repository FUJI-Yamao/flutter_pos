/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_dpoint.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import 'rcfncchk.dart';

/// 関連tprxソース: rc_dpoint.c - DPOINT_ORGTRAN
class DPointOrgTran {
  // GtkWidget *window;
  // GtkWidget *fixed;
  // GtkWidget *title;
  // GtkWidget *inp_btn;
  // GtkWidget *end_btn;
  // GtkWidget *ret_btn;
  // GtkWidget *comment;GtkWidget *btn[2];
  // GtkWidget *ent[2];
  List<List<String>> data = List.generate(2, (_) => List.generate(20, (_) => ""));
  String inpData = ""; // 入力データ[20]
  int step = 0; // -1:なし 0:元取引通番 1:元取引合計額
  int inpFlg = 0; // 0:置数なし 1:置数あり
  int dlgFlg = 0; // 0:表示なし 1:表示あり
}

class RcDpoint {
  static DPtsmdfyInfo dPtsMdfy = DPtsmdfyInfo();

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_dpoint.c - rc_dPointUse
  static void rcDPointUse(){
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_dpoint.c - rc_dPointUpdate
  static void rcDPointUpdate(){
    return;
  }

  /// dポイント情報をクリアする
  /// 引数:[flg] 全削除フラグ
  /// 引数:[tTtllog] トータルログバッファ
  /// 関連tprxソース: rc_dpoint.c - rc_dPoint_DataClr
  static Future<void> rcDPointDataClr(int flg, TTtlLog ttllog) async {
    RegsMem mem = SystemFunc.readRegsMem();
    switch (flg) {
      case 0:  //dポイント情報全てをクリア
        mem.tmpbuf.dPointData = RxMemDPointData();
        if (await RcFncChk.rcCheckDPtsMdfyMode()) {
          dPtsMdfy.dPointData = RxMemDPointData();
        }
        ttllog.t100770.dpntMbrCd = "";  // dポイントカード番号15桁(上11桁マスク)
        ttllog.t100770.dpntCd1 = "";  // dポイントカード番号(上8桁)
        ttllog.t100770.dpntCd2 = "";  // dポイントカード番号(下7桁)
        ttllog.t100770.dpntProcKind = 0;			// dポイント処理種別
        ttllog.t100770.dpntInMethod = 0;			// dポイント入力方法
        ttllog.t100770Sts.dpntTranType = 0;			// 取引タイプ
        ttllog.t100770.dpntAddTerminalId = 0;		// dポイント端末識別番号(進呈用)
        ttllog.t100770.dpntUseTerminalId = 0;		// dポイント端末識別番号(利用用)
        ttllog.t100770.dpntAddProcNo = 0;			// dポイント端末処理通番(進呈用)
        ttllog.t100770.dpntUseProcNo = 0;			// dポイント端末処理通番(利用用)
        ttllog.t100770.orgDpntAddTerminalId = 0;		// dポイント元端末識別番号(進呈用)
        ttllog.t100770.orgDpntUseTerminalId = 0;		// dポイント元端末識別番号(利用用)
        ttllog.t100770.orgDpntAddProcNo = 0;		// dポイント元端末処理通番(進呈用)
        ttllog.t100770.orgDpntUseProcNo = 0;		// dポイント元端末処理通番(利用用)
        ttllog.t100770.dpntAddDatetime = "";		// dポイント加盟店処理日時(進呈用)
        ttllog.t100770.dpntUseDatetime = "";		// dポイント加盟店処理日時(利用用)
        ttllog.t100770.orgDpntAddDatetime = "";	// dポイント元加盟店処理日時(進呈用)
        ttllog.t100770.orgDpntUseDatetime = "";	// dポイント元加盟店処理日時(利用用)
        ttllog.t100770.dpntSaleQty = 0;		// 売上点数
        ttllog.t100770.dpntSaleAmt = 0;		// 売上金額
        ttllog.t100770.dpntNotsaleAmt = 0;		// 売上対象外金額
        ttllog.t100770.dpntAddpurAmt = 0;		// ポイント進呈対象額
        ttllog.t100770.dpntSalePnt = 0;		// 通常進呈ポイント数
        ttllog.t100770.dpntMbrVpnt = 0;		// 来店ポイント数
        ttllog.t100770.dpntCmpPnt = 0;		// キャンペーンポイント数
        ttllog.t100770.dpntBalancePnt = 0;		// ポイント残高
        ttllog.t100770.dpntAddPoint = 0;		// 進呈ポイント数
        ttllog.t100770.dpntUsePoint = 0;		// 利用ポイント数
        ttllog.t100770.dpntAddPer = 0;		// 本日ポイント割増倍率
        ttllog.t100770.dpntItemAddpnt = 0;		// 商品加算ポイント
        ttllog.t100770.dpntReceiptNo = 0;		// レシート番号(進呈・利用共通)
        ttllog.t100770.orgDpntReceiptNo = 0;	// 元レシート番号(進呈・利用共通)
        ttllog.t100770.dpntSalePntCnt = 0;		// 通常進呈ポイント件数
        ttllog.t100770.dpntMbrVpntCnt = 0;		// 来店ポイント件数
        ttllog.t100770.dpntCmpPntCnt = 0;		// キャンペーンポイント件数
        ttllog.t100770.dpntAddPntCnt = 0;		// 進呈ポイント件数
        ttllog.t100770.dpntUsePntCnt = 0;		// 利用ポイント件数
        for (int i=0; i < ttllog.t100001Sts.itemlogCnt; i++) {
          mem.tItemLog[i].t12100?.dpntPurAddamt = 0;	// 商品毎のポイント進呈対象額
          mem.tItemLog[i].t12100?.dpntPurUseamt = 0;	// 商品毎のポイント利用対象額
        }
        break;
      case 1:  //進呈関連情報をクリア
        ttllog.t100770.dpntAddTerminalId = 0;		// dポイント端末識別番号(進呈用)
        ttllog.t100770.dpntAddProcNo = 0;			// dポイント端末処理通番(進呈用)
        ttllog.t100770.orgDpntAddTerminalId = 0;		// dポイント元端末識別番号(進呈用)
        ttllog.t100770.orgDpntAddProcNo = 0;		// dポイント元端末処理通番(進呈用)
        ttllog.t100770.dpntAddDatetime = "";	// dポイント加盟店処理日時(進呈用)
        ttllog.t100770.orgDpntAddDatetime = "";	// dポイント元加盟店処理日時(進呈用)
        ttllog.t100770.dpntAddpurAmt = 0;			// ポイント進呈対象額
        ttllog.t100770.dpntSalePnt = 0;			// 通常進呈ポイント数
        ttllog.t100770.dpntMbrVpnt = 0;			// 来店ポイント数
        ttllog.t100770.dpntCmpPnt = 0;			// キャンペーンポイント数
        ttllog.t100770.dpntAddPoint = 0;			// 進呈ポイント数
        ttllog.t100770.dpntItemAddpnt = 0;			// 商品加算ポイント
        ttllog.t100770.dpntSalePntCnt = 0;			// 通常進呈ポイント件数
        ttllog.t100770.dpntMbrVpntCnt = 0;			// 来店ポイント件数
        ttllog.t100770.dpntCmpPntCnt = 0;			// キャンペーンポイント件数
        ttllog.t100770.dpntAddPntCnt = 0;			// 進呈ポイント件数
        for (int i=0; i < ttllog.t100001Sts.itemlogCnt; i++) {
          mem.tItemLog[i].t12100?.dpntPurAddamt = 0;	// 商品毎のポイント進呈対象額
        }
        break;
      case 2:  //利用関連情報をクリア
        ttllog.t100770.dpntUseTerminalId = 0;		// dポイント端末識別番号(利用用)
        ttllog.t100770.dpntUseProcNo = 0;			// dポイント端末処理通番(利用用)
        ttllog.t100770.orgDpntUseTerminalId = 0;		// dポイント元端末識別番号(利用用)
        ttllog.t100770.orgDpntUseProcNo = 0;		// dポイント元端末処理通番(利用用)
        ttllog.t100770.dpntUseDatetime = "";	// dポイント加盟店処理日時(利用用)
        ttllog.t100770.orgDpntUseDatetime = "";	// dポイント元加盟店処理日時(利用用)
        ttllog.t100770.dpntUsePoint = 0;			// 利用ポイント数
        ttllog.t100770.dpntUsePntCnt = 0;			// 利用ポイント件数
        for (int i=0; i < ttllog.t100001Sts.itemlogCnt; i++) {
          mem.tItemLog[i].t12100?.dpntPurUseamt = 0;	// 商品毎のポイント利用対象額
        }
        break;
      default:
        break;
    }
  }

  /*** dポイント元取引情報入力処理 *********************************/
  /// 機能概要：元取引情報入力処理
  /// 関連tprxソース: rc_dpoint.c - rc_dPoint_OrgTranSet
  static  Future<void> rcdPointOrgTranSet() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcdPointOrgTranSet Start");

    DPointOrgTran dPointOrgTran = DPointOrgTran();
    dPointOrgTran.data = List.generate(2, (_) => List.generate(20, (_) => ""));
    dPointOrgTran.inpData = "";
    dPointOrgTran.step = 0;
    dPointOrgTran.inpFlg = 0;
    dPointOrgTran.dlgFlg = 0;

    AcMem cMem = SystemFunc.readAcMem();

    if (FbInit.subinitMainSingleSpecialChk()) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(
            await RcSysChk.getTid(), LogLevelDefine.error, "rxMemRead error");
        return;
      }
      RxCommonBuf cBuf = xRet.object;
      cMem.stat.dualTSingle = cBuf.devId;
    } else {
      cMem.stat.dualTSingle = 0;
    }

    rcdPointOrgTranDisp();
    return;
  }

  /// 機能概要：元取引情報入力画面の表示
  /// 関連tprxソース:C rc_dpoint.c - rc_dPoint_OrgTranDisp
  static void rcdPointOrgTranDisp() {
    // 描画処理なので移植しない
  }
  
  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rc_dpoint.c - rcChk_dPoint_UseReceipt
  static int rcChkDPointUseReceipt(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rc_dpoint.c - rc_dPoint_SemFree
  static void rcDPointSemFree(){}

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rc_dpoint.c - rc_dPoint_SemInit
  static void rcDPointSemInit(){}

  //実装は必要だがARKS対応では除外
  ///  関連tprxソース: rc_dpoint.c - rcKy_dPointMInput
  static void rcKyDPointMInput(){}

}

/// 関連tprxソース:C rc_dpoint.h - dPtsmdfy_Info
class DPtsmdfyInfo {
  /// 従業員レベル
  int stfLvl = 0;
  /// 入力位置番号
  /// - 0:dポイントカード番号  1:進呈ポイント数  2:利用ポイント数
  /// - 3:前回営業日  4:前回取引日  10:従業員番号  11:パスワード
  int posNo = 0;
  /// ディスプレイ種類
  int display = 0;
  /// ファンクションコード
  int fncCode = 0;
  /// 修正理由
  int reason = 0;
  /*
  GtkWidget	*window_main;	// dポイント修正画面
  GtkWidget	*window_psw;	// 従業員入力画面
  GtkWidget	*wFixed;	// 画面下地
  GtkWidget	*TitleBar;	// タイトル
  GtkWidget	*button1;	/*
					 * dポイント修正画面：dポイントカード番号ボタン
					 * 従業員入力画面：従業員番号ボタン
					 */
  GtkWidget	*button2;	/*
					 * dポイント修正画面：修正理由ボタン
					 * 従業員入力画面：パスワード番号ボタン
					 */
  GtkWidget	 *button3;	// dポイント修正画面：進呈ポイントボタン
  GtkWidget	 *button4;	// dポイント修正画面：利用ポイントボタン
  GtkWidget	 *button5;	// dポイント修正画面：前回営業日ボタン
  GtkWidget	 *button6;	// dポイント修正画面：前回取引日ボタン
  GtkWidget	 *entry1;	/*
					 * dポイント修正画面：dポイントカード番号入力部
					 * 従業員入力画面：従業員番号入力部
					 */
  GtkWidget	 *entry2;	// 従業員入力画面：パスワード入力部
  GtkWidget	 *entry3;	// dポイント修正画面：進呈ポイント入力部
  GtkWidget	 *entry4;	// dポイント修正画面：利用ポイント入力部
  GtkWidget	 *entry5;	// dポイント修正画面：前回営業日入力部
  GtkWidget	 *entry6;	// dポイント修正画面：前回取引日入力部
  GtkWidget	 *ExitBtn;	// 終了ボタン
  GtkWidget	 *ExecBtn;	// 実行ボタン
  GtkWidget	 *IntBtn;	// 入力ボタン
  GtkWidget	 *bFixed1;	// ボタン下地
  GtkWidget	 *bFixed2;	// ボタン下地
  GtkWidget	 *Label1;	// 説明文1
  GtkWidget	 *Label2;	// 説明文2
  GtkWidget *lbl1_1;
  GtkWidget *lbl1_2;
  GtkWidget *lbl2;
   */
  /// dポイントカード番号
  String entryText1 = "";
  /// 進呈ポイント数
  String entryText3 = "";
  /// 利用ポイント数
  String entryText4 = "";
  /// 前回営業日
  String entryText5 = "";
  /// 前回取引日
  String entryText6 = "";
  /// 従業員番号
  String entryText10 = "";
  /// パスワード
  String entryText11 = "";
  String pass = "";
  /// タイトル
  String title = "";
  /// カード名
  String cardName = "";
  /// 付与ポイント
  String givePoint = "";
  /// 使用ポイント
  String usePoint = "";
  /// 前回売上日
  String orgSaleDate = "";
  /// 前回取引日
  String orgTradeDate = "";
  int skTotalBuyRslt = 0;
  int skAnyprcTermMny = 0;
  int skTotalPoint = 0;
  String mName = "";
  String mPass = "";
  int mLevel = 0;
  RxMemDPointData dPointData = RxMemDPointData();
  int inputMthd = 0;
  int procType = 0;
}