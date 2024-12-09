/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter_pos/app/lib/apllib/apllib_strutf.dart';
import 'package:flutter_pos/app/regs/checker/liblary.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../db_library/src/db_manipulation.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../drv/printer/drv_print_isolate.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_drv_control.dart';
import '../../if/rp_print.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/rxmem.dart' as rxMem;
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apl_cnv.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/mm_reptlib_def.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../../lib/cm_ej/cm_ejlib.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../regs/inc/rp_print.dart';
import '../if_th/aa/if_th_prnstr.dart';
import '../if_th/if_th_init.dart';
import '../if_th/if_th_alloc.dart';
import '../if_th/if_th_ccut.dart';
import '../if_th/if_th_cflush.dart';
import '../if_th/if_th_feed.dart';
import '../if_th/if_th_flushb.dart';
import '../if_th/if_th_prerct.dart';
import '../if_th/if_th_prnstr.dart';
import '../if_th/utf2shift.dart';
import 'mm_reptlib_def.dart';


/// レポートデータの出力
/// 関連tprxソース:mm_reptlib.c
class MmReptlib {
  static const SQL_REPT_SELECT = "select * from c_report_cnt where report_cnt_cd = @repCntCd and comp_cd = @comp and stre_cd = @stre and mac_no = @mac";
  static const BATCH_FLG2_EJ = [
    MmReptlibDef.MMREPTTITLE01EJ, MmReptlibDef.MMREPTTITLE02EJ,
    MmReptlibDef.MMREPTTITLE03EJ, MmReptlibDef.MMREPTTITLE04EJ,
    MmReptlibDef.MMREPTTITLE05EJ, MmReptlibDef.MMREPTTITLE06EJ,
    MmReptlibDef.MMREPTTITLE07EJ, MmReptlibDef.MMREPTTITLE08EJ,
    MmReptlibDef.MMREPTTITLE09EJ, MmReptlibDef.MMREPTTITLE10EJ,
    MmReptlibDef.MMREPTTITLE11EJ, MmReptlibDef.MMREPTTITLE12EJ,
    MmReptlibDef.MMREPTTITLE13EJ, MmReptlibDef.MMREPTTITLE14EJ,
    MmReptlibDef.MMREPTTITLE15EJ, MmReptlibDef.MMREPTTITLE16EJ,
    MmReptlibDef.MMREPTTITLE17EJ, "",
    MmReptlibDef.MMREPTTITLE19EJ, MmReptlibDef.MMREPTTITLE20EJ,
    MmReptlibDef.MMREPTTITLE21EJ
  ];
  static const REPT_FLG2 = [
    MmReptlibDef.MMREPTFLG21, MmReptlibDef.MMREPTFLG22,
    MmReptlibDef.MMREPTFLG23, MmReptlibDef.MMREPTFLG24,
    MmReptlibDef.MMREPTFLG25, MmReptlibDef.MMREPTFLG26,
    MmReptlibDef.MMREPTFLG27, MmReptlibDef.MMREPTFLG28,
    MmReptlibDef.MMREPTFLG29, MmReptlibDef.MMREPTFLG30
  ];
  static const REPT_NAME = [
    "",
    MmReptlibDef.MMREPT01NM, MmReptlibDef.MMREPT02NM, MmReptlibDef.MMREPT03NM, MmReptlibDef.MMREPT04NM, MmReptlibDef.MMREPT05NM,
    MmReptlibDef.MMREPT06NM, MmReptlibDef.MMREPT07NM, MmReptlibDef.MMREPT08NM, MmReptlibDef.MMREPT09NM, MmReptlibDef.MMREPT10NM,
    MmReptlibDef.MMREPT11NM, MmReptlibDef.MMREPT12NM, MmReptlibDef.MMREPT13NM, MmReptlibDef.MMREPT14NM, MmReptlibDef.MMREPT15NM,
    MmReptlibDef.MMREPT16NM, MmReptlibDef.MMREPT17NM, MmReptlibDef.MMREPT18NM, MmReptlibDef.MMREPT19NM, MmReptlibDef.MMREPT20NM,
    MmReptlibDef.MMREPT21NM, MmReptlibDef.MMREPT22NM, MmReptlibDef.MMREPT23NM, MmReptlibDef.MMREPT24NM, MmReptlibDef.MMREPT25NM,
    MmReptlibDef.MMREPT26NM, MmReptlibDef.MMREPT27NM, MmReptlibDef.MMREPT28NM, MmReptlibDef.MMREPT29NM, MmReptlibDef.MMREPT30NM,
    MmReptlibDef.MMREPT31NM, MmReptlibDef.MMREPT32NM, MmReptlibDef.MMREPT33NM, MmReptlibDef.MMREPT34NM, MmReptlibDef.MMREPT35NM,
    MmReptlibDef.MMREPT36NM, MmReptlibDef.MMREPT37NM, MmReptlibDef.MMREPT38NM, MmReptlibDef.MMREPT39NM, MmReptlibDef.MMREPT40NM,
    MmReptlibDef.MMREPT41NM, MmReptlibDef.MMREPT42NM, MmReptlibDef.MMREPT43NM, MmReptlibDef.MMREPT44NM, MmReptlibDef.MMREPT45NM,
    MmReptlibDef.MMREPT46NM, MmReptlibDef.MMREPT47NM, MmReptlibDef.MMREPT48NM, MmReptlibDef.MMREPT49NM, MmReptlibDef.MMREPT50NM,
    MmReptlibDef.MMREPT51NM, MmReptlibDef.MMREPT52NM, MmReptlibDef.MMREPT53NM, MmReptlibDef.MMREPT54NM, MmReptlibDef.MMREPT55NM,
    MmReptlibDef.MMREPT56NM, MmReptlibDef.MMREPT57NM, MmReptlibDef.MMREPT58NM, MmReptlibDef.MMREPT59NM, MmReptlibDef.MMREPT60NM,
    MmReptlibDef.MMREPT61NM, MmReptlibDef.MMREPT62NM, MmReptlibDef.MMREPT63NM, MmReptlibDef.MMREPT64NM, MmReptlibDef.MMREPT65NM,
    MmReptlibDef.MMREPT66NM, MmReptlibDef.MMREPT67NM, MmReptlibDef.MMREPT68NM, MmReptlibDef.MMREPT69NM, MmReptlibDef.MMREPT70NM,
    MmReptlibDef.MMREPT71NM, MmReptlibDef.MMREPT72NM, MmReptlibDef.MMREPT73NM, MmReptlibDef.MMREPT74NM, MmReptlibDef.MMREPT75NM,
    MmReptlibDef.MMREPT76NM, MmReptlibDef.MMREPT77NM, MmReptlibDef.MMREPT78NM, MmReptlibDef.MMREPT79NM, MmReptlibDef.MMREPT80NM,
    MmReptlibDef.MMREPT81NM, MmReptlibDef.MMREPT82NM, MmReptlibDef.MMREPT83NM, MmReptlibDef.MMREPT84NM, MmReptlibDef.MMREPT85NM,
    MmReptlibDef.MMREPT86NM, MmReptlibDef.MMREPT87NM, MmReptlibDef.MMREPT88NM, MmReptlibDef.MMREPT89NM, MmReptlibDef.MMREPT90NM,
    MmReptlibDef.MMREPT91NM, MmReptlibDef.MMREPT92NM, MmReptlibDef.MMREPT93NM, MmReptlibDef.MMREPT94NM, MmReptlibDef.MMREPT95NM,
    MmReptlibDef.MMREPT96NM, MmReptlibDef.MMREPT97NM, MmReptlibDef.MMREPT98NM, MmReptlibDef.MMREPT99NM, MmReptlibDef.MMREPT100NM,
    MmReptlibDef.MMREPT101NM, MmReptlibDef.MMREPT102NM, MmReptlibDef.MMREPT103NM, MmReptlibDef.MMREPT104NM, MmReptlibDef.MMREPT105NM,
    MmReptlibDef.MMREPT106NM, MmReptlibDef.MMREPT107NM, MmReptlibDef.MMREPT108NM, MmReptlibDef.MMREPT109NM, MmReptlibDef.MMREPT110NM,
    MmReptlibDef.MMREPT111NM, MmReptlibDef.MMREPT112NM, MmReptlibDef.MMREPT113NM, MmReptlibDef.MMREPT114NM, MmReptlibDef.MMREPT115NM,
    MmReptlibDef.MMREPT116NM, MmReptlibDef.MMREPT117NM, MmReptlibDef.MMREPT118NM, MmReptlibDef.MMREPT119NM, MmReptlibDef.MMREPT120NM,
    MmReptlibDef.MMREPT121NM, MmReptlibDef.MMREPT122NM, MmReptlibDef.MMREPT123NM, MmReptlibDef.MMREPT124NM, MmReptlibDef.MMREPT125NM,
    MmReptlibDef.MMREPT126NM, MmReptlibDef.MMREPT127NM, MmReptlibDef.MMREPT128NM, MmReptlibDef.MMREPT129NM, MmReptlibDef.MMREPT130NM,
    MmReptlibDef.MMREPT131NM, MmReptlibDef.MMREPT132NM, MmReptlibDef.MMREPT133NM, MmReptlibDef.MMREPT134NM, MmReptlibDef.MMREPT135NM,
    MmReptlibDef.MMREPT136NM, MmReptlibDef.MMREPT137NM, MmReptlibDef.MMREPT138NM, MmReptlibDef.MMREPT139NM, MmReptlibDef.MMREPT140NM,
    MmReptlibDef.MMREPT141NM, MmReptlibDef.MMREPT142NM, MmReptlibDef.MMREPT143NM, MmReptlibDef.MMREPT144NM, MmReptlibDef.MMREPT145NM,
    MmReptlibDef.MMREPT146NM, MmReptlibDef.MMREPT147NM, MmReptlibDef.MMREPT148NM, MmReptlibDef.MMREPT149NM, MmReptlibDef.MMREPT150NM,
    MmReptlibDef.MMREPT151NM, MmReptlibDef.MMREPT152NM, MmReptlibDef.MMREPT153NM, MmReptlibDef.MMREPT154NM, MmReptlibDef.MMREPT155NM,
    MmReptlibDef.MMREPT156NM, MmReptlibDef.MMREPT157NM, MmReptlibDef.MMREPT158NM, MmReptlibDef.MMREPT159NM, MmReptlibDef.MMREPT160NM,
    MmReptlibDef.MMREPT161NM, MmReptlibDef.MMREPT162NM, MmReptlibDef.MMREPT163NM, MmReptlibDef.MMREPT164NM, MmReptlibDef.MMREPT165NM,
    MmReptlibDef.MMREPT166NM, MmReptlibDef.MMREPT167NM, MmReptlibDef.MMREPT168NM, MmReptlibDef.MMREPT169NM, MmReptlibDef.MMREPT170NM,
    MmReptlibDef.MMREPT171NM, MmReptlibDef.MMREPT172NM, MmReptlibDef.MMREPT173NM, MmReptlibDef.MMREPT174NM, MmReptlibDef.MMREPT175NM,
    MmReptlibDef.MMREPT176NM, MmReptlibDef.MMREPT177NM, MmReptlibDef.MMREPT178NM, MmReptlibDef.MMREPT179NM, MmReptlibDef.MMREPT180NM,
    MmReptlibDef.MMREPT181NM, MmReptlibDef.MMREPT182NM, MmReptlibDef.MMREPT183NM, MmReptlibDef.MMREPT184NM, MmReptlibDef.MMREPT185NM,
    MmReptlibDef.MMREPT186NM, MmReptlibDef.MMREPT187NM, MmReptlibDef.MMREPT188NM, MmReptlibDef.MMREPT189NM, MmReptlibDef.MMREPT190NM,
    MmReptlibDef.MMREPT191NM, MmReptlibDef.MMREPT192NM, MmReptlibDef.MMREPT193NM, MmReptlibDef.MMREPT194NM, MmReptlibDef.MMREPT195NM,
    MmReptlibDef.MMREPT196NM, MmReptlibDef.MMREPT197NM, MmReptlibDef.MMREPT198NM, MmReptlibDef.MMREPT199NM, MmReptlibDef.MMREPT200NM,
    MmReptlibDef.MMREPT201NM
  ];
  static const MMREPT60_TITLE = [" " , MmReptlibDef.MMREPT_TENKEN, MmReptlibDef.MMREPT_SEISAN];

  static	int font16_e    = rxMem.PrnFontIdx.E16_16_1_1.id;
  static	int font16_j    = rxMem.PrnFontIdx.E16_16_1_1.id;
  static	int font24_e    = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int	font24_j    = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int font24_48_e = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int	font24_48_j = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int font48_24_e = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int	font48_24_j = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int font48_48_e = rxMem.PrnFontIdx.E24_24_1_1.id;
  static	int	font48_48_j = rxMem.PrnFontIdx.E24_24_1_1.id;

  static late RxCommonBuf pCom;
  static BatReptInfo reptDat = BatReptInfo();

  static TprMID mmReptlibTid = Tpraid.TPRAID_REPT;
  static bool mmReptejFlg = false;

  static int		prnIng = Typ.OFF;			    	/* レポート印字 */
  static int		mmSaledspFlg = Typ.OFF;			/* 速報表示 */
  static int		mmReptdspFlg = Typ.OFF;			/* 点検／精算表示 */
  static int		mmFreqdspFlg = Typ.OFF;			/* データ吸上表示 */
  static int		mmReptPrintError = 0;		/* プリンターのリターンカウンタ */
  static int		mmMptStopFlag = 0;			/* Report Stop Flag for Batch Report Out */
  static int		mmRtejFlg = Typ.OFF;
  static int		mmReEjFlg = Typ.OFF;
  static int		mmRptCount = 0;
  static int		mmReptSlctFlg = 0;			/* PORT Check is SLCT */

  static int printLine = 0;
  static int mmReptEndFlg = 0;

  /// 電子ジャーナル用テキストのヘッダ部を作成する
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_headprint_ej()
  /// 引数:[mode] 処理モード
  ///               1:登録　　　　   2:訓練　　   3:訂正　　  4:廃棄　　   5:メンテナンス
  ///     				  6:ファイル確認   7:売上点検   8:売上精算  9:設定　　  10:売価変更
  ///     				 11:クローズ　　  12:　　　　  13:ユーザーセットアップ
  ///     				 14:カード保守　  15:売上速報  16:ファイル初期設定
  ///     				 25:収納業務
  /// 引数:[reptNo] レポートNo
  /// 戻り値:true = Normal End
  ///       false = Error
  Future<bool> headprintEj(int mode, int reptNo) async {
    return await headprintEj2(mode, reptNo, 0);
  }

  /// 電子ジャーナル用テキストのヘッダ部を作成する（ファイルオープンフラグ付き）
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_headprint_ej2()
  /// 引数:[mode] 処理モード
  ///               1:登録　　　　   2:訓練　　   3:訂正　　  4:廃棄　　   5:メンテナンス
  ///               6:ファイル確認   7:売上点検   8:売上精算  9:設定　　  10:売価変更
  ///              11:クローズ　　  12:　　　　  13:ユーザーセットアップ
  ///              14:カード保守　  15:売上速報  16:ファイル初期設定
  ///              25:収納業務
  /// 引数:[reptNo] レポートNo
  /// 引数:[flg] ファイルオープンフラグ
  ///               0:通常ファイルオープン
  ///               1:staff_chk.txtオープン（個人情報保護対応用）
  ///               2:staff_cash.txtオープン（個人情報保護対応用）
  ///               3:modeのみを書き込み（クローズレポートで使用）
  ///               4:mode以外を追加で書き込み（クローズレポートで使用）
  /// 戻り値:true = Normal End
  ///       false = Error
  static Future<bool> headprintEj2(int mode, int reptNo, int flg) async {
    if ((mode < 1) ||
        ((mode > 26) &&
         !((mode >= OpeModeFlagList.OPE_MODE_REG) && (mode <= OpeModeFlagList.OPE_MODE_PRODUCTION)))) {
      return false;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    pCom = xRet.object;

    if (reptNo == 0) {
      reptNo = reptDat.batReport.batch_report_no;
    }
    mmReptejFlg = false;

    int settleCnt = 0;
    String bfrDatetime = '0000-00-00 00:00';
    Map<String, dynamic>? subValues;

    // DBからデータを取得
    if ( ( (mode == 5) || (mode == 8) ) &&
         ( (reptNo != ReptNumber.MMREPT27.index) && (reptNo != ReptNumber.MMREPT28.index) &&
           (reptNo != ReptNumber.MMREPT109.index) && (reptNo != ReptNumber.MMREPT92.index) &&
           (reptNo != ReptNumber.MMREPT187.index) && (reptNo != ReptNumber.MMREPT189.index) &&
           (reptNo != ReptNumber.MMREPT199.index) ) )
    {
      // store daily or store total or total clear
      if ( (reptDat.reptFlg == 1) || (reptDat.reptFlg == 5) ||
           (reptDat.reptFlg == 0) || (reptDat.reptFlg == 9) ||
           (reptNo == ReptNumber.MMREPT73.index) || (reptNo == ReptNumber.MMREPT74.index) ||
           (reptNo == ReptNumber.MMREPT75.index) || (reptNo == ReptNumber.MMREPT76.index) ||
           (reptNo == ReptNumber.MMREPT98.index) || (reptNo == ReptNumber.MMREPT33.index) )
      {
        subValues = {
          "repCntCd" : MmReptlibDef.REPT_CNT_DLY,
          "comp"     : pCom.dbRegCtrl.compCd,
          "stre"     : pCom.dbRegCtrl.streCd,
          "mac"      : pCom.dbRegCtrl.macNo
        };
      } else if ((reptDat.reptFlg == 2) || (reptDat.reptFlg == 6) || (reptDat.reptFlg == 7) ||
          (reptNo == ReptNumber.MMREPT99.index) || (reptNo == ReptNumber.MMREPT151.index)) {
        // store total or total clear
        if (await CmCksys.cmMmIniType() == CmSys.MacM2) {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_MLY_BS,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        } else {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_MLY,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        }
      } else {
        if (reptNo == ReptNumber.MMREPT101.index) {
          if (await CmCksys.cmMmIniType() == CmSys.MacM2) {
            subValues = {
              "repCntCd" : MmReptlibDef.REPT_CNT_CUST_ENQ_CLR_BS,
              "comp"     : pCom.dbRegCtrl.compCd,
              "stre"     : pCom.dbRegCtrl.streCd,
              "mac"      : pCom.dbRegCtrl.macNo
            };
          } else {
            subValues = {
              "repCntCd" : MmReptlibDef.REPT_CNT_CUST_ENQ_CLR,
              "comp"     : pCom.dbRegCtrl.compCd,
              "stre"     : pCom.dbRegCtrl.streCd,
              "mac"      : pCom.dbRegCtrl.macNo
            };
          }
        } else if (reptNo == ReptNumber.MMREPT81.index) {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_DEC_RBT,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        } else if (reptNo == ReptNumber.MMREPT80.index) {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_DEC_FSP_LVL,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        } else if (reptNo == ReptNumber.MMREPT102.index) {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_CUST_PLAY,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        } else if ((reptNo == ReptNumber.MMREPT122.index) || (reptNo == ReptNumber.MMREPT124.index)) {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_TEXT_READ,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        } else if (reptDat.batReport.batch_report_no == ReptNumber.MMREPT178.index) {
          subValues = {
            "repCntCd" : MmReptlibDef.REPT_CNT_CUST_POINT_CLR,
            "comp"     : pCom.dbRegCtrl.compCd,
            "stre"     : pCom.dbRegCtrl.streCd,
            "mac"      : pCom.dbRegCtrl.macNo
          };
        }
      }
      try {
        var db = DbManipulationPs();
        Result dataList = await db.dbCon.execute(Sql.named(SQL_REPT_SELECT), parameters: subValues);
        if (dataList.isEmpty) {
          TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
              'headprintEj2(): DB error (SQL_REPT_SELECT selected rec count = 0)', errId: -1);
        } else {
          Map<String, dynamic> data = dataList.first.toColumnMap();
          settleCnt = int.parse(data["settle_cnt"]);
          bfrDatetime =
              data["bfr_datetime"].toString();
        }
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "headprintEj2() : $e $s )");
      }
    }

    // 書き込むファイルのパスを設定
    String filePath ='';
    switch (flg) {
      case 1:
        filePath = '${EnvironmentData().sysHomeDir}/${CmEj.EJ_WORK_DIR}staff_chk.txt';
        break;
      case 2:
        filePath = '${EnvironmentData().sysHomeDir}/${CmEj.EJ_WORK_DIR}staff_cash.txt';
        break;
      default:
        filePath = '${EnvironmentData().sysHomeDir}/${CmEj.EJ_WORK_DIR}${CmEj.EJ_WORK_FILE}';
        break;
    }
    File tgtFile = File(filePath);

    // オペモードの新旧変更
    int idx2 = mode;
    if (mode == 13) {
      idx2 = 5;
    }
    switch (idx2) {
      case  1:
        idx2 = OpeModeFlagList.OPE_MODE_REG;
        break;		// 登録
      case  2:
        idx2 = OpeModeFlagList.OPE_MODE_TRAINING;
        break;	// 訓練
      case  3:
        idx2 = OpeModeFlagList.OPE_MODE_VOID;
        break;		// 訂正
      case  4:
        idx2 = OpeModeFlagList.OPE_MODE_SCRAP;
        break;		// 廃棄
      case  5:
        idx2 = OpeModeFlagList.OPE_MODE_MENTE;
        break;		// メンテナンス
//		case  6: break;				// ﾌｧｲﾙ確認
      case  7:
        idx2 = OpeModeFlagList.OPE_MODE_CHECK_REPT;
        break;	// 売上点検
      case  8:
        idx2 = OpeModeFlagList.OPE_MODE_FINISH_REPT;
        break;	// 売上精算
      case  9:
        idx2 = OpeModeFlagList.OPE_MODE_SETUP;
        break;		// 設定
      case 10:
        idx2 = OpeModeFlagList.OPE_MODE_PRC_CHANGE;
        break;	// 売価変更
      case 11:
        idx2 = OpeModeFlagList.OPE_MODE_STAFF_CLS;
        break;	// 従業員クローズ
//		case 12: idx2 = OPE_MODE_STORE_OPN; break;	// 開設
//		case 12: idx2 = OPE_MODE_STORE_CLS; break;	// 閉設
      case 13:
        idx2 = OpeModeFlagList.OPE_MODE_USER_SETUP;
        break;	// ユーザーセットアップ
//		case 14: break;				// ｶｰﾄﾞ保守
      case 15:
        idx2 = OpeModeFlagList.OPE_MODE_FLASH_REPT;
        break;	// 売上速報
      case 16:
        idx2 = OpeModeFlagList.OPE_MODE_INIT;
        break;		// ファイル初期設定
      case 17:
        idx2 = OpeModeFlagList.OPE_MODE_ORDER;
        break;		// 発注
      case 18:
        idx2 = OpeModeFlagList.OPE_MODE_STOCKTAKING;
        break;	// 棚卸
      default:
        break;
    }
    if (flg != 4) {
      //「mode以外書込み」以外
      tgtFile.writeAsStringSync(idx2.toString(), mode:FileMode.write, encoding: utf8, flush: false);
      if (flg == 3) {
        // modeのみ書込み
        mmReptejFlg = true;
        return true;
      }
    }

    int idx = 0;
    switch (mode) {
      case  1:
      case  OpeModeFlagList.OPE_MODE_REG:
        idx = 5;
        break;
      case  2:
      case  OpeModeFlagList.OPE_MODE_TRAINING:
        idx = 6;
        break;
      case  3:
      case  OpeModeFlagList.OPE_MODE_VOID:
        idx = 7;
        break;
      case  4:
      case  OpeModeFlagList.OPE_MODE_SCRAP:
        idx = 8;
        break;
      case  5:
        idx =  4;
        break;
      case  6:
        idx =  9;
        break;
      case  7:
        idx =  2;
        break;
      case  8:
        idx =  3;
        break;
      case  9:
        idx = 10;
        break;
      case 10:
        idx = 11;
        break;
      case 11:
        idx = 15;
        break;
      case 12:
        idx = 19;
        break;
      case 15:
        idx =  1;
        break;
      case 17:
        idx = 18;
        break;	// 発注モード 表示なし
      case 18:
        idx = 18;
        break;	// 棚卸モード 表示なし
      case 19:
        idx = 17;
        break;
      case 24:
        idx = 18;
        break;	// 生産モード 表示なし
      case 25:
        idx = 20;
        break;
      default:
        idx = mode;
        break;
    }

    // 日付・時刻を設定
    String saleDate = '';
    String utf8Buf = '';
    String ejBuf = '';
    if ( (reptNo != ReptNumber.MMREPT83.index) && (reptNo != ReptNumber.MMREPT187.index) &&
         (reptNo != ReptNumber.MMREPT189.index) && (reptNo != ReptNumber.MMREPT199.index)) {
      if (reptDat.bfreReptOutAdd.isNotEmpty) {
        saleDate =
        '${reptDat.bfreReptOutAdd.substring(0, 4)}-${reptDat.bfreReptOutAdd
            .substring(4, 6)}-${reptDat.bfreReptOutAdd.substring(6, 8)}';
      } else if (reptDat.saleDate.isNotEmpty) {
        saleDate =
        '${reptDat.saleDate.substring(0, 4)}-${reptDat.saleDate.substring(
            4, 6)}-${reptDat.saleDate.substring(6, 8)}';
      } else {
        saleDate = await CompetitionIni.competitionIniGet(
            mmReptlibTid,
            CompetitionIniLists.COMPETITION_INI_SALE_DATE,
            CompetitionIniType.COMPETITION_INI_GETMEM).toString();
      }
      if (saleDate == '0000-00-00') {
        // TODO: 10034 日付管理 - timestamp.c datetime_change()呼び出し
      } else {
        utf8Buf = MmReptlibDef.PRE_NO_OPN;
      }
      ejBuf = '${MmReptlibDef.PRESALEDATE}$utf8Buf';
      printStringEj(tgtFile, ejBuf);
    }

    if ( (reptNo != ReptNumber.MMREPT187.index) && (reptNo != ReptNumber.MMREPT189.index) &&
         (reptNo != ReptNumber.MMREPT199.index) ) {
      if (reptDat.bfreReptOutAdd.isNotEmpty) {
        ejBuf = '${MmReptlibDef.MM_REPT_ETC_AST2}${BATCH_FLG2_EJ[12]}${MmReptlibDef.MM_REPT_ETC_AST3}';
      } else {
        ejBuf = '${MmReptlibDef.MM_REPT_ETC_AST2}${BATCH_FLG2_EJ[idx-1]}${MmReptlibDef.MM_REPT_ETC_AST3}';
      }
      printStringEj(tgtFile, ejBuf);
    }

    if ( ( ((mode == 7) || (mode == 8)) &&
           (reptNo != ReptNumber.MMREPT144.index) && (reptNo != ReptNumber.MMREPT32.index) &&
           (reptNo != ReptNumber.MMREPT60.index) ) ||
         ( (mode == 15) &&
           ((reptNo >= ReptNumber.MMREPT40.index) && (reptNo <= ReptNumber.MMREPT57.index)) ) )
    {
      ejBuf = REPT_FLG2[reptDat.reptFlg];
      printStringEj(tgtFile, ejBuf);
    }

    if ( (reptNo != -1) && (reptNo != 0) &&
         (reptNo != ReptNumber.MMREPT137.index) && (reptNo != ReptNumber.MMREPT180.index) &&
         (reptNo != ReptNumber.MMREPT189.index) && (reptNo != ReptNumber.MMREPT199.index) ) {
      ejBuf = REPT_NAME[reptNo];
      if ((ejBuf == MmReptlibDef.MMREPT07NM) && (await CmCksys.cmHc3AyahaSystem() != 0)) {
        ejBuf = MmReptlibDef.MMREPT07NM_2;
      }
      if ( (reptDat.batReport.batch_report_no == ReptNumber.MMREPT60.index) &&
           (ejBuf.length <= 50) ) {
        ejBuf += MMREPT60_TITLE[reptDat.batchFlg];
      }
      printStringEj(tgtFile, ejBuf);
    } else if (reptNo == 0) {
      fillPrintEj(tgtFile, ' ');
    }

    // 売上点検：レジ途中日計
    JsonRet jsonRet;
    String dataBuf = '';
    int bufSize = CmEj.EJ_LINE_SIZE * 2 + 1;
    if ( (reptDat.reptFlg == 9) && (reptDat.batchFlg == 1) ) {
      fillPrintEj(tgtFile, ' ');
      filePath = '${EnvironmentData().sysHomeDir}/conf/mm_abj.json';
      ejBuf = MmReptlibDef.PRE_ABJ_DATE;
      jsonRet = await getJsonValue(filePath, 'now', 'now_exe_date');
      if (!jsonRet.result) {
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
            'Get mm_adj.json Err (batchFlg = 1) - now_exe_data: ${jsonRet.cause.name}', errId: -1);
      } else {
        dataBuf = jsonRet.value.toString();
        if ( (AplLibStrUtf.aplLibEntCnt(ejBuf) + dataBuf.length > 0) &&
             (bufSize + dataBuf.length < CmEj.EJ_LINE_SIZE) ) {
          ejBuf += ''.padLeft( (CmEj.EJ_LINE_SIZE - AplLibStrUtf.aplLibEntCnt(ejBuf) - dataBuf.length), ' ')  + dataBuf;
        }
      }
      printStringEj(tgtFile, ejBuf);
      fillPrintEj(tgtFile, ' ');
    }

    if ( ( ((mode == 5) || (mode == 8)) &&
           ((reptNo != ReptNumber.MMREPT27.index) &&
            (reptNo != ReptNumber.MMREPT28.index) &&
            (reptNo != ReptNumber.MMREPT32.index) &&
            (reptNo != ReptNumber.MMREPT33.index) &&
            (reptNo != ReptNumber.MMREPT72.index) &&
            (reptNo != ReptNumber.MMREPT77.index) &&
            (reptNo != ReptNumber.MMREPT78.index) &&
            (reptNo != ReptNumber.MMREPT83.index) &&
            (reptNo != ReptNumber.MMREPT84.index) &&
            (reptNo != ReptNumber.MMREPT92.index) &&
            (reptNo != ReptNumber.MMREPT103.index) &&
            (reptNo != ReptNumber.MMREPT104.index) &&
            (reptNo != ReptNumber.MMREPT105.index) &&
            (reptNo != ReptNumber.MMREPT106.index) &&
            (reptNo != ReptNumber.MMREPT107.index) &&
            (reptNo != ReptNumber.MMREPT108.index) &&
            (reptNo != ReptNumber.MMREPT109.index) &&
            (reptNo != ReptNumber.MMREPT110.index) &&
            (reptNo != ReptNumber.MMREPT111.index) &&
            (reptNo != ReptNumber.MMREPT112.index) &&
            (reptNo != ReptNumber.MMREPT113.index) &&
            (reptNo != ReptNumber.MMREPT114.index) &&
            (reptNo != ReptNumber.MMREPT115.index) &&
            (reptNo != ReptNumber.MMREPT116.index) &&
            (reptNo != ReptNumber.MMREPT117.index) &&
            (reptNo != ReptNumber.MMREPT118.index) &&
            (reptNo != ReptNumber.MMREPT119.index) &&
            (reptNo != ReptNumber.MMREPT120.index) &&
            (reptNo != ReptNumber.MMREPT121.index) &&
            (reptNo != ReptNumber.MMREPT128.index) &&
            (reptNo != ReptNumber.MMREPT129.index) &&
            (reptNo != ReptNumber.MMREPT130.index) &&
            (reptNo != ReptNumber.MMREPT134.index) &&
            (reptNo != ReptNumber.MMREPT141.index) &&
            (reptNo != ReptNumber.MMREPT142.index) &&
            (reptNo != ReptNumber.MMREPT143.index) &&
            (reptNo != ReptNumber.MMREPT144.index) &&
            (reptNo != ReptNumber.MMREPT47.index) &&
            (reptNo != ReptNumber.MMREPT152.index) &&
            (reptNo != ReptNumber.MMREPT153.index) &&
            (reptNo != ReptNumber.MMREPT155.index) &&
            (reptNo != ReptNumber.MMREPT156.index) &&
            (reptNo != ReptNumber.MMREPT157.index) &&
            (reptNo != ReptNumber.MMREPT48.index) &&
            (reptNo != ReptNumber.MMREPT49.index) &&
            (reptNo != ReptNumber.MMREPT29.index) &&
            (reptNo != ReptNumber.MMREPT29.index) &&
            (reptNo != ReptNumber.MMREPT59.index) &&
            (reptNo != ReptNumber.MMREPT173.index) &&
            (reptNo != ReptNumber.MMREPT174.index) &&
            (reptNo != ReptNumber.MMREPT175.index) &&
            (reptNo != ReptNumber.MMREPT176.index) &&
            (reptNo != ReptNumber.MMREPT180.index) &&
            (reptNo != ReptNumber.MMREPT181.index) &&
            (reptNo != ReptNumber.MMREPT182.index) &&
            (reptNo != ReptNumber.MMREPT183.index) &&
            (reptNo != ReptNumber.MMREPT184.index) &&
            (reptNo != ReptNumber.MMREPT185.index) &&
            (reptNo != ReptNumber.MMREPT187.index) &&
            (reptNo != ReptNumber.MMREPT189.index) &&
            (reptNo != ReptNumber.MMREPT190.index) &&
            (reptNo != ReptNumber.MMREPT191.index) &&
            (reptNo != ReptNumber.MMREPT192.index) &&
            (reptNo != ReptNumber.MMREPT193.index) &&
            (reptNo != ReptNumber.MMREPT197.index) &&
            (reptNo != ReptNumber.MMREPT199.index) &&
            (reptNo != ReptNumber.MMREPT137.index)) ) ||
         ( (mode == 8) &&
           ((reptDat.reptFlg == 0) || (reptDat.reptFlg == 9)) &&
           ((reptNo == ReptNumber.MMREPT01.index) ||
            (reptNo == ReptNumber.MMREPT02.index) ||
            (reptNo == ReptNumber.MMREPT03.index) ||
            (reptNo == ReptNumber.MMREPT04.index) ||
            (reptNo == ReptNumber.MMREPT30.index) ||
            (reptNo == ReptNumber.MMREPT93.index) ||
            (reptNo == ReptNumber.MMREPT158.index)) ) )
    {
      fillPrintEj(tgtFile, ' ');
      if (reptDat.saleDate.isNotEmpty) {
        saleDate = '${reptDat.saleDate.substring(0, 4)}-${reptDat.saleDate.substring(4, 6)}-${reptDat.saleDate.substring(6, 8)}';
        printStringEj(tgtFile, MmReptlibDef.MM_REPT_UPDERR0_EJ);  /* ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊ */
        ejBuf = sprintf(MmReptlibDef.MM_REPT_ASS_REPT_EJ, [saleDate]);  /* [YYYY-MM-DD]のレポートです */
        printStringEj(tgtFile, ejBuf);
        printStringEj(tgtFile, MmReptlibDef.MM_REPT_UPDERR0_EJ);  /* ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊ */
      } else {
        if ( (reptDat.reptFlg == 1) || (reptDat.reptFlg == 5) ||
             (reptDat.reptFlg == 0) || (reptDat.reptFlg == 9) ||
             (reptNo == ReptNumber.MMREPT73.index) || (reptNo == ReptNumber.MMREPT74.index) ||
             (reptNo == ReptNumber.MMREPT75.index) || (reptNo == ReptNumber.MMREPT76.index) ||
             (reptNo == ReptNumber.MMREPT98.index)) {
          ejBuf = '${MmReptlibDef.PRELASTSALEDATE}   ';
          CompetitionIni.competitionIniGet(
              mmReptlibTid,
              CompetitionIniLists.COMPETITION_INI_LAST_SALE_DATE,
              CompetitionIniType.COMPETITION_INI_GETSYS).toString();
          // TODO: 10034 日付管理 - timestamp.c datetime_change()呼び出し → dateBufへ格納
          ejBuf += ' $dataBuf';
          printStringEj(tgtFile, ejBuf);
        }
        ejBuf = '${MmReptlibDef.PREADJDATE}   ';
        if (bfrDatetime.isEmpty) {
          bfrDatetime = '0000-00-00 00:00';
        }
        // TODO: 10034 日付管理 - timestamp.c datetime_change()呼び出し → dateBufへ格納
        ejBuf += ' $dataBuf';
        printStringEj(tgtFile, ejBuf);
        ejBuf = '${MmReptlibDef.PREADJCOUNT} ${settleCnt.toString().padLeft(4, '0')}';
        printStringEj(tgtFile, ejBuf);
      }
      if (reptDat.reptFlg == 9) {
        filePath = '${EnvironmentData().sysHomeDir}/conf/mm_abj.json';
        ejBuf = MmReptlibDef.PRE_ABJ_DATE;
        jsonRet = await getJsonValue(filePath, 'now', 'now_exe_date');
        if (!jsonRet.result) {
          TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
              'Get mm_adj.json Err - now_exe_data: ${jsonRet.cause.name}', errId: -1);
        } else {
          dataBuf = jsonRet.value.toString();
          if ( (AplLibStrUtf.aplLibEntCnt(ejBuf) + dataBuf.length > 0) &&
              (bufSize + dataBuf.length < CmEj.EJ_LINE_SIZE) ) {
            ejBuf += ''.padLeft(  (CmEj.EJ_LINE_SIZE - AplLibStrUtf.aplLibEntCnt(ejBuf) - dataBuf.length), ' ')  + dataBuf;
          }
        }
        printStringEj(tgtFile, ejBuf);
      }
      fillPrintEj(tgtFile, ' ');
    }
    mmReptejFlg = true;

    return true;
  }

  /// 該当文字の１文字分を１行にして、電子ジャーナルテキストに書込む
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_fillprint_ej()
  /// 引数:[ejFile] 電子ジャーナル用テキストファイル
  /// 引数:[character] 書き込む文字列
  /// 戻り値:なし
  static void fillPrintEj(File ejFile, String character) {
    String buf = ''.padLeft(CmEj.EJ_LINE_SIZE+1,character);
    printStringEj(ejFile, buf);
  }

  /// １行分の文字列を、電子ジャーナルテキストに書込む
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_printstring_ej()
  /// 引数:[ejFile] 電子ジャーナル用テキストファイル
  /// 引数:[printBuf] 書き込む文字列
  /// 戻り値:なし
  static void printStringEj(File ejFile, String printBuf) {
    EjLib().cmEjWriteString(ejFile, writePosi.EJ_LEFT.index, printBuf);
  }

  /// ジャーナル（レポート）カウンタアップ
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_countup()
  /// 引数:なし
  /// 戻り値:なし
  static Future<void> countUp() async {
    CompetitionIniRet ret = await CompetitionIni.competitionIniGetPrintNo(Tpraid.TPRAID_REPT);
    int printNo = 0;

    if (ret.value != null) {
      printNo = ret.value;
    }
    printNo++;
    if (printNo > 9999) {
      printNo = 1;
    }
    await CompetitionIni.competitionIniSetPrintNo(Tpraid.TPRAID_STR,printNo);

    mmReptejFlg = false;
  }



  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_font_open()
  /// 関数：プリンタフォントオープン
  /// 機能：VF関数の初期化とフォントのオープン
  /// 引数：無し
  /// 戻値：OK or NG
  int fontOpen(TprMID tid) {
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "mm_reptlib.c:mm_reptlib_font_open START !!\n");

    ///TODO: メイン処理部分は4/8向けには不要のため未実装


    TprLog().logAdd(tid, LogLevelDefine.normal, "mm_reptlib.c:mm_reptlib_font_open END !!\n");
    return 0;
  }
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_font_open()
  /// 関数：プリンタフォント終了
  /// 機能：フォントのクローズ
  /// 引数：無し
  /// 戻値：OK or NG
  static void fontClose(TprMID tid) {
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "mm_reptlib.c:mm_reptlib_font_close START !!\n");

    ///TODO: メイン処理部分は4/8向けには不要のため未実装
    ///fontOpen関数で呼び出されるため、あわせて実装するように

    // if (font24_j != -1) {
    //   font24_j = -1;
    // }
    // if (font24_e != -1) {
    //   font24_e = -1;
    // }
    // if (font16_j != -1) {
    //   font16_j = -1;
    // }
    // if (font16_e != -1) {
    //   font16_e = -1;
    // }
    // if (font48_24_j != -1) {
    //   font48_24_j = -1;
    // }
    // if (font48_24_e != -1) {
    //   font48_24_e = -1;
    // }
    // if (font24_48_j != -1) {
    //   font24_48_j = -1;
    // }
    // if (font24_48_e != -1) {
    //   font24_48_e = -1;
    // }
    // if (font48_48_j != -1) {
    //   font48_48_j = -1;
    // }
    // if (font48_48_e != -1) {
    //   font48_48_e = -1;
    // }
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "mm_reptlib.c:mm_reptlib_font_close END !!\n");
    return;
  }

  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_init
  /// #define　mm_reptlib_init( ) mm_reptlib_init_( -1 )
  Future<int> mmReptlibInit() async {
    return(await mmReptlibInit_(-1));
  }

  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_init_
  /// 関数：プリンタ初期化
  /// 機能：サーマルプリンタ関数を初期化する
  /// 引数：無し
  /// 戻値：OK or NG
  Future<int> mmReptlibInit_(TprMID tid) async {
    int ret;

    if(tid == -1){
      mmReptlibTid = Tpraid.TPRAID_REPT;
    }else{
      mmReptlibTid = tid;
    }

    TprLog().logAdd(mmReptlibTid, LogLevelDefine.normal, "mm_reptlib_init()");

    printLine = 0;
    prnIng = 0;
    mmReptPrintError = 0;
    mmRptCount = 0;
    mmReptSlctFlg = 0;
    mmReptEndFlg = 0;

    ret = await IfThInit.ifThInit(mmReptlibTid);
    if(ret < 0){
      return Typ.NG;
    }

    mmReptPrintError -= 1;
    return Typ.OK;
  }

  /// レポートエンド印字
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_endprint2
  static Future<int> mmReptlibEndprint2() async {
    return( await mmReptlibEndprint2Main(InterfaceDefine.IF_TH_LOGO1, 0));
  }

  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_endprint2_Main
  static Future<int> mmReptlibEndprint2Main(int wLogo, int feed) async {
    int ret = 0;

    if( printLine > 0 ){
      ret = await IfThFlushB.ifThFlushBuf(mmReptlibTid, printLine * RegsPrint.printStr);
      if (ret != 0) {
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_endprint2() : if_th_FlushBuf" );
        return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
      else{
        mmReptPrintError--;
      }
      ret = await IfThCFlush.ifThCFlush(mmReptlibTid);
      if (ret != 0) {
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_endprint2() : if_th_cFlush" );
        return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
      else{
        mmReptPrintError--;
      }
    }
    if (feed != 0) {
      ret = await IfThFeed.ifThFeed(mmReptlibTid, feed);
      if(ret != 0){
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_endprint2() : if_th_Feed" );
        return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
    }

    ret = await IfThCCut.ifThCCut(mmReptlibTid, InterfaceDefine.IF_TH_NOLOGO2);
    if(ret != 0) {
      TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_endprint2() : if_th_cCut" );
      return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
    }
    else{
      mmReptPrintError--;
    }
    return 0;
  }

  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_fillprint
  /// 関数：行印字
  /// 機能：該当文字の１文字分を１行に印字を行う
  /// 引数：String flash:フラッシュ ON or OFF,String:文字列ポインタ, int fSize:サイズ
  /// 戻値：OK or NG
  static Future<int> mmReptlibFillPrint(int flash, String charactor, int fSize) async {
    String pb = ''.padLeft(32, charactor);
    return await printString(flash, pb, fSize);
  }

  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_font_open()
  /// 関数：電子ジャーナルテキスト追加
  /// 機能：電子ジャーナルテキストに、作成したテキストを追加する
  /// 引数：[tid] タスクID
  ///      [textName] ファイル名（フルパス）
  ///      [batchFlg] 0:売上速報
  ///                 1:売上点検
  ///                 2:売上精算
  ///                 3:メンテナンス
  ///                 4:登録
  ///                 5:訓練
  ///                 6:訂正
  ///                 7:廃棄
  ///                 19:収納業務
  ///                 20:キャッシュリサイクル
  ///      [reptNo] レポート
  /// 戻値：OK or NG
  Future<int> addEjDataText(TprMID tid, String textName, int batchFlg, int reptNo) async {
    String filename = '';
    String ejDataName = '';
    String log = '';
    File fp1;
    File fp2;
    int rtn;

    if (textName.isNotEmpty) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "mm_reptlib_add_ejdata_text(): no set textName \n");
      return -1;
    }
    if (batchFlg < 0 || batchFlg >= 21) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "mm_reptlib_add_ejdata_text(): limit batchFlg \n");
      return -1;
    }
    if (reptNo < 0 || reptNo >= ReptNumber.NUM_REPTNAMED.index) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "mm_reptlib_add_ejdata_text(): limit reptNo \n");
      return -1;
    }

    filename = textName;
    ejDataName = sprintf("%s%s%s", [
      EnvironmentData().sysHomeDir,
      CmEj.EJ_WORK_DIR,
      CmEj.EJ_WORK_FILE
    ]);

    if (textName == ejDataName) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "mm_reptlib_add_ejdata_text(): same ejdata.txt \n");
      return -1;
    }

    /* 電子ジャーナルテキスト　編集 */
    fp1 = File(ejDataName);
    fp2 = File(filename);

    var fp1Stat = await fp1.stat();
    var fp2Stat = await fp2.stat();

    if (fp1Stat.type != FileSystemEntityType.notFound) {
      if (fp2Stat.type == FileSystemEntityType.notFound) {
        if (MmReptlibDef.MMREPT_EJ_TEXT_MAX_LEN <= fp1Stat.size + fp2Stat.size) {
          rtn = await EjLib().cmEjOther();
          if (rtn != 0) {
            log = sprintf("mm_reptlib_add_ejdata_text(): cm_ejother[%i] \n", [rtn]);
            TprLog().logAdd(tid, LogLevelDefine.error, log);
          }

          countUp();
          switch (batchFlg) {
            case 0:
              headprintEj2(15, reptDat.batReport.batch_report_no, 3);
              break;
            case 1:
              headprintEj2(7, reptDat.batReport.batch_report_no, 3);
              break;
            case 2:
              headprintEj2(8, reptDat.batReport.batch_report_no, 3);
              break;
            case 3:
              headprintEj2(5, reptDat.batReport.batch_report_no, 3);
              break;
            case 4:
              headprintEj2(1, reptDat.batReport.batch_report_no, 3);
              break;
            case 5:
              headprintEj2(2, reptDat.batReport.batch_report_no, 3);
              break;
            case 6:
              headprintEj2(3, reptDat.batReport.batch_report_no, 3);
              break;
            case 7:
              headprintEj2(4, reptDat.batReport.batch_report_no, 3);
              break;
            case 19:
              headprintEj2(25, reptDat.batReport.batch_report_no, 3);
              break;
          }
          TprLog().logAdd(tid, LogLevelDefine.normal,
              "mm_reptlib_add_ejdata_text(): cmEjOther \n");
        }
        fp1.openSync(mode: FileMode.append);
        if (await fp1.exists()) {
          if (await fp2.exists()) {
            IOSink sink1;
            sink1 = fp1.openWrite();
            var lines = fp2.readAsLinesSync();
            for (var line in lines) {
              sink1.write(line);
              await sink1.flush();
            }
            await sink1.close();
          }
        }
      }
      else {
        TprLog().logAdd(tid, LogLevelDefine.error,
            "mm_reptlib_add_ejdata_text(): size get error ejdate.txt \n");
      }
    }
    else {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "mm_reptlib_add_ejdata_text(): size get error ejdate.txt \n");
    }
    return 0;
  }

  /// 関連tprxソース:mm_reptlib.h - mm_reptlib_printstring
  static Future<int> printString(
    int flash, 
    String printBuf, 
    int fSize
  ) async {
    return await printString3(flash, printBuf, fSize, -1, -1, 0, null);
  }

  /// 関連tprxソース:mm_reptlib.h - mm_reptlib_printstring2
  static Future<int> printString2(
    int flash, 
    String printBuf, 
    int fSize, 
    int xPos, 
    int yPos, 
    int wAttr
  ) async {
    return await printString3(flash, printBuf, fSize, xPos, yPos, wAttr, null);
  }

  /// 機能：１行分の文字列をプリンタに渡す
  /// 引数：String Flash     フラッシュ ON or OFF
  ///      String print_buf  文字列ポインタ
  ///      int    FSIZE      フォントサイズ  0:16*16 1:24*24
  /// 戻値：0 or MSG_PRINTERERR
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_printstring3
  static Future<int> printString3(
    int flash, 
    String printBuf, 
    int fSize, 
    int xPos, 
    int yPos, 
    int wAttr, 
    String? str
  ) async {
    int 	ret;
    int		result = 0;
    int		wXpos, wYpos;
    String buf;

    if (fSize == MmReptLibDef.MMREPTFS24_48 || fSize == MmReptLibDef.MMREPTFS48_48) {
      printLine+=2;
    } else {
      printLine++;
    }

    if (printLine > RegsPrint.maxBufLine) {
      ret = await printFlash();
      if (ret != 0) {
        return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
      if (fSize == MmReptLibDef.MMREPTFS24_48 || fSize == MmReptLibDef.MMREPTFS48_48) {
        printLine+=2;
      } else {
        printLine++;
      }
    }

    if (fSize == MmReptLibDef.MMREPTFS16) {
      buf = AplLibStrUtf.aplLibEucAdjust(printBuf, 130, 64).$2;
    } else {
      buf = AplLibStrUtf.aplLibEucAdjust(printBuf, 130, 32).$2;
    }
    if (str != null && str.isNotEmpty) {
      buf += str.substring(0, 1);
    }
    if (xPos == -1) {
      wXpos = 0;
    } else {
      wXpos = xPos;
    }

    if (yPos == -1) {
      wYpos = ( printLine - 1 ) * RegsPrint.printStr + RegsPrint.vfFont1;
    } else {
      wYpos = yPos;
    }

    await IfThAlloc.ifThAllocArea(mmReptlibTid, 30);
    if (fSize == MmReptLibDef.MMREPTFS16) {
      ret = await IfThPrnStr.ifThPrintString(mmReptlibTid, wXpos, wYpos, wAttr, font16_e, font16_j, buf);
      if (ret != 0) {
        result = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        printLine-=1;
      }
    } else if (fSize == MmReptLibDef.MMREPTFS24) {
      ret = await IfThPrnStr.ifThPrintString(mmReptlibTid, wXpos, wYpos, wAttr, font24_e, font24_j, buf);
      if (ret != 0) {
        result = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        printLine-=1;
      }
    } else if (fSize == MmReptLibDef.MMREPTFS24_48) {
      ret = await IfThPrnStr.ifThPrintString(mmReptlibTid, wXpos, wYpos, wAttr, font24_48_e, font24_48_j, buf);
      if (ret != 0) {
        result = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        printLine-=2;
      }
    } else if (fSize == MmReptLibDef.MMREPTFS48_24) {
      ret = await IfThPrnStr.ifThPrintString(mmReptlibTid, wXpos, wYpos, wAttr, font48_24_e, font48_24_j, buf);
      if (ret != 0) {
        result = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        printLine-=1;
      }
    } else if (fSize == MmReptLibDef.MMREPTFS48_48) {
      ret = await IfThPrnStr.ifThPrintString(mmReptlibTid, wXpos, wYpos, wAttr, font48_48_e, font48_48_j, buf);
      if (ret != 0) {
        result = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        printLine-=2;
      }
    }

    if (flash == Typ.ON) {
      ret = await printFlash();
      if (ret  != 0 ) {
        result = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
    }

    if (result == DlgConfirmMsgKind.MSG_PRINTERERR.dlgId) {
      TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib.c:mm_reptlib_printstring\n");
    }

    return result;
  }

  /// 関連tprxソース:mm_reptlib.h - mm_reptlib_PrintFlash
  static Future<int> printFlash() async {
    return await printFlash2(1);
  }

  /// 機能：プリンタフラッシュ
  /// 引数：NONE
  /// 戻値：0 or MSG_PRINTERERR
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_PrintFlash2()
  static Future<int> printFlash2(int allocFlg) async {
    int ret;

    if( printLine != 0 ){
      ret = await IfThFlushB.ifThFlushBuf(mmReptlibTid, printLine * RegsPrint.printStr );
      if (ret != 0 ){
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_PrintFlash() : if_th_FlushBuf\n");
        return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
      else{
        mmReptPrintError-- ;
      }
      ret = await IfThCFlush.ifThCFlush(mmReptlibTid);
      if (ret != 0 ){
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_PrintFlash() : if_th_cFlush\n");
        return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      }
      else{
        mmReptPrintError-- ;
      }

      if (allocFlg != 0) {
        ret = await IfThAlloc.ifThAllocArea(mmReptlibTid, RegsPrint.MAX_Y_DOT);
        if (ret != 0 ){
          TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib_PrintFlash() : if_th_AllocArea\n");
          return DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
        }
        printLine = 0;
      }
    }


    return 0;
  }

  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_headprint2
  static Future<int> mmReptlibHeadprint2(int fSize) async {
    return await mmReptlibHeadprint2_(fSize,0,null);
  }

  /// 関数： レポートヘッダ印字
  /// 機能： 該当文字を１行分印字する印字を行う
  /// 引数： int	fSize	: フォントサイズ  0:16*16 1:24*24
  /// 戻値： OK or NG
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_headprint2_
  static Future<int> mmReptlibHeadprint2_(int fSize, int jcC, IfThHead? chData) async {
    String sql = '';					/* SQL						*/
    //PGconn			*con;						/* 接続データベースポインタ */
    //TLogParam localCon = TLogParam();
    Result res;						/* 読込データポインタ 		*/
    int	nTuples = 0;					/* 件数						*/
    IfThHead hData = IfThHead();
    CStaffopenMstColumns so = CStaffopenMstColumns();
    // RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    // if (xRet.isInvalid()) {
    //   return 0;
    // }
    // RxCommonBuf pCom = xRet.object;
    int	pRtn = 0;
    // int printNo = 0;
    // int macNo = 0;

    DbManipulationPs db = DbManipulationPs();
    sql = sprintf("select * from c_staffopen_mst where mac_no='%i';", [(await CompetitionIni.competitionIniGetRcptNo(mmReptlibTid)).value]);

    if (chData != null) {
      hData.iChkrCode = chData.iChkrCode;
      hData.szChkrName = chData.szChkrName;
      hData.iCshrCode = chData.iCshrCode;
      hData.szCshrName = chData.szCshrName;
    }else{
      try {
        /* ｄＢへ問い合わせ */
        res = await db.dbCon.execute(Sql.named(sql));
        if (res.isEmpty) {
          TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
              "rmstOpen_chprice_backup DB backup ERROR\n");
          return 0;
        }
        nTuples = res.length;

        if(nTuples != 0){
          Map<String, dynamic> data = res.elementAt(0).toColumnMap();
          so.chkr_cd = data["chkr_cd"] ?? '';
          /* チェッカー従業員番号 */

          so.chkr_name = data["chkr_name"] ?? '';
          /* チェッカー従業員名 */

          so.chkr_status = data["chkr_status"] ?? 0;
          /* チェッカーステータス */

          so.cshr_cd = data["cshr_cd"] ?? '';
          /* キャッシャー従業員番号 */

          so.cshr_name =data["cshr_name"] ?? '';
          /* キャッシャー従業員名 */

          so.cshr_status = data["cshr_status"] ?? '';
          /* キャッシャーステータス */

          if (so.chkr_status == 1) {
            /* チェッカーがオープン */
            hData.iChkrCode = int.tryParse(so.chkr_cd!) ?? 0;
            hData.szChkrName = so.chkr_name!;
          }

          if (so.cshr_status == 1) {
            /* キャッシャーがオープン */
            hData.iCshrCode = int.tryParse(so.cshr_cd!) ?? 0;
            hData.szCshrName = so.cshr_name!;
          }
        }
        //db_PQclear( mm_reptlib_tid, res );
      } catch (e, s) {
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error, "mm_reptlib.c:mm_reptlib_headprint db_PQexec\n" );
      }
    //db_PQfinish( mm_reptlib_tid, con );
    }

    if(jcC == 0){
      hData.iJournalNo = await Counter.competitionGetPrintNo(Tpraid.TPRAID_REPT);
    /* レポートNo. */

    if(fSize == MmReptLibDef.MMREPTFS16){
      pRtn = await IfThPreRct.ifThPreReceipt(mmReptlibTid, hData,
          InterfaceDefine.IF_TH_REPORT,
          (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO),
          font16_e, font16_j);
    }else if(fSize == MmReptLibDef.MMREPTFS24){
      pRtn = await IfThPreRct.ifThPreReceipt(mmReptlibTid, hData,
          InterfaceDefine.IF_TH_REPORT,
          (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO),
          font24_e, font24_j );
    }else if(fSize == MmReptLibDef.MMREPTFS48_24){
      pRtn = await IfThPreRct.ifThPreReceipt(mmReptlibTid, hData,
          InterfaceDefine.IF_TH_REPORT,
          (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO),
          font48_24_e, font48_24_j );
    }else if(fSize == MmReptLibDef.MMREPTFS24_48){
      pRtn = await IfThPreRct.ifThPreReceipt(mmReptlibTid, hData,
          InterfaceDefine.IF_TH_REPORT,
          (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO),
          font24_48_e, font24_48_j );
    }else if(fSize == MmReptLibDef.MMREPTFS48_48){
      pRtn = await IfThPreRct.ifThPreReceipt(mmReptlibTid, hData,
          InterfaceDefine.IF_TH_REPORT,
          (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO),
          font48_48_e, font48_48_j );
    }
    /* ヘッダ印字 */

      if (pRtn != InterfaceDefine.IF_TH_POK) {
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
            "mm_reptlib.c:mm_reptlib_headprint if_th_PreReceipt\n");
        return Typ.NG;
      }

      mmReptPrintError -= 2;					/* アンサー2回*/ /* 2008/04/23 */

    // #if 0
    // print_no = competition_get_printno(TPRAID_REPT);
    // if( mm_reptej_flg == ON ){
    // print_no-=1;
    // if( print_no <= 0 ){
    // print_no = 9999;
    // }
    // mm_reptej_flg = OFF;
    // competition_ini( mm_reptlib_tid, COMPETITION_INI_PRINT_NO, COMPETITION_INI_SETMEM, &print_no, sizeof(print_no) );
    // }
    //
    // competition_ini( mm_reptlib_tid, COMPETITION_INI_PRINT_NO, COMPETITION_INI_SETSYS, &print_no, sizeof(print_no) );
    // /* counter.ini書込 */
    // #endif

    }else{
      hData.iJournalNo = (await CompetitionIni.competitionIniGetRcptNo(Tpraid.TPRAID_REPT)).value;
      /* レポートNo. */

      hData.iMacNo = (await CompetitionIni.competitionIniGetRcptNo(mmReptlibTid)).value;
      //cm_read_sysdate( &tDate );	/* Read system date & time */

      DateTime tDate = DateTime.now();

      if(fSize == MmReptLibDef.MMREPTFS16){
        pRtn = await IfThPreRct.ifThPreReceipt2(mmReptlibTid, hData,
            InterfaceDefine.IF_TH_REPORT,
            (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO),
            font16_e, font16_j, tDate);
      }else if(fSize == MmReptLibDef.MMREPTFS24 ){
        pRtn = await IfThPreRct.ifThPreReceipt2(mmReptlibTid, hData, InterfaceDefine.IF_TH_REPORT, (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO), font24_e, font24_j, tDate);
      }else if(fSize == MmReptLibDef.MMREPTFS48_24 ){
        pRtn = await IfThPreRct.ifThPreReceipt2(mmReptlibTid, hData, InterfaceDefine.IF_TH_REPORT, (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO), font48_24_e, font48_24_j, tDate);
      }else if(fSize == MmReptLibDef.MMREPTFS24_48 ){
        pRtn = await IfThPreRct.ifThPreReceipt2(mmReptlibTid, hData, InterfaceDefine.IF_TH_REPORT, (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO), font24_48_e, font24_48_j, tDate);
      }else if(fSize == MmReptLibDef.MMREPTFS48_48 ){
        pRtn = await IfThPreRct.ifThPreReceipt2(mmReptlibTid, hData, InterfaceDefine.IF_TH_REPORT, (InterfaceDefine.IF_TH_PRT_SHOP | InterfaceDefine.IF_TH_PRT_RCTNO), font48_48_e, font48_48_j, tDate);
      }
    /* ヘッダ印字 */

      if (pRtn != InterfaceDefine.IF_TH_POK) {
        TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
            "mm_reptlib.c:mm_reptlib_headprint if_th_PreReceipt\n");
        return Typ.NG;
      }

      mmReptPrintError -= 1;					/* アンサー１回*/

    // #if 0 /* if_th_PreReceipt3()は、ジャーナル番号を更新しないので、減算の必要なし */
    // print_no = competition_get_printno_JC_C(TPRAID_REPT);
    // if( mm_reptej_flg == ON ){
    // print_no-=1;
    // if( print_no <= 0 ){
    // print_no = 9999;
    // }
    // mm_reptej_flg = OFF;
    // competition_ini( mm_reptlib_tid, COMPETITION_INI_PRINT_NO, COMPETITION_INI_SETMEM_JC_C, &print_no, sizeof(print_no) );
    // }
    //
    // competition_ini( mm_reptlib_tid, COMPETITION_INI_PRINT_NO, COMPETITION_INI_SETSYS_JC_C, &print_no, sizeof(print_no) );
    // /* counter.ini書込 */
    // #endif
    }

    pRtn = await IfThAlloc.ifThAllocArea(mmReptlibTid, RegsPrint.MAX_Y_DOT);
    if (pRtn != InterfaceDefine.IF_TH_POK) {
      TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
          "mm_reptlib.c:mm_reptlib_headprint if_th_AllocArea\n");
      return Typ.NG;
    }

    pRtn = await mmReptlibFillPrint(Typ.OFF, ' ', fSize);
    if (pRtn != 0) {
      TprLog().logAdd(mmReptlibTid, LogLevelDefine.error,
          "mm_reptlib.c:mm_reptlib_headprint mm_reptlib_fillprint 2\n");
      return Typ.NG;
    }

    return Typ.OK;
  }

  /// 関数： パラレルポート状態取得
  /// 機能： パラレルポートの状態絵を取得する
  /// 引数： 無し
  /// 戻値：
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_port_get
  static Future<int> mmReptlibPortGet() async {
    /* 変更した場合は、rp_print.c - port_get() も対応すること */
    int result = 0;
    int webType = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          0, LogLevelDefine.error, "mmReptlibPortGet() rxMemRead error\n");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    webType = await CmCksys.cmWebType();

    RxTaskStatDrw drw = await SystemFunc.statDrwGet(tsBuf);

    // #if 0 /* 2009/10/23 */
    // if(( web_type == WEBTYPE_WEBPLUS ) || ( web_type == WEBTYPE_WEB2300 ) ||
    // ( web_type == WEBTYPE_WEB2800 ) || ( web_type == WEBTYPE_WEB2500 ) )
    // #endif

    if (await CmCksys.cmCheckAfterWeb2300() == 1) {
      return drw.drwStat;
    }

    result = 0;

    // TODO:10129 - Linux デバイスドライバ（inb, ioperm）
    // if( ioperm( BASEPORT, 2, 1 ) )
    // return( XPRN_ERR );
    //
    // result = inb(BASEPORT+1);
    //
    // if( ioperm( BASEPORT, 2, 0 ) )
    // return( XPRN_ERR );

    return result;
  }

  /// 関数：プリンタ終了
  /// 機能：サーマルプリンタ関数を終了する
  /// 引数：無し
  /// 戻値：OK or NG
  /// 関連tprxソース:mm_reptlib.c - mm_reptlib_end
  static void mmReptlibEnd() {
    TprLog().logAdd(mmReptlibTid, LogLevelDefine.normal, "mmReptlibEnd()" );

    prnIng = Typ.OFF;
    mmReptPrintError = 0;
    mmReptSlctFlg = 0;
    mmReptEndFlg = 0;

    mmReptlibTid = Tpraid.TPRAID_REPT;	/* 念のためTIDを戻す */
  }
}

/// 関連tprxソース:mm_reptlib.c - MM_REPT_T
/* 印字情報 */
class MmReptT{
  List<String> name = List.filled(RxMem.DB_IMG_DATASIZE + 1, ''); /* 名称 */
  /*  半角片仮名32文字 */
  double value = 0; /* 値 */
  int offset = 0; /* 開始位置 */
  /*  nで、半角右にn個分 */
  int point = 0; /* 小数点 0～3 */
  int flg = 0; /* 印字情報フラグ */
  /*  下記を参照 論理和でセット */
  List<String> rData = List.filled(64+1, ''); /* 右寄せに印字する文字列	*/
}
