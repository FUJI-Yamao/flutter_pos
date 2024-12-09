/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../dummy.dart';
import '../../../postgres_library/src/customer_table_access.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../postgres_library/src/royalty_promotion_table_access.dart';
import '../../common/cls_conf/custreal_necJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemayaha.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/hostfile_control.dart';
import '../../lib/apllib/rcsch_other.dart';
import '../../lib/cm_mbr/cmmbrsys.dart';
import '../../lib/cm_mcd/cmmcdchk.dart';
import '../../lib/cm_mcd/cmmcdset.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import 'rc_depo_in_plu.dart';
import 'rc_flrd.dart';
import 'rc_mbr_com.dart';
import 'rc_set.dart';
import 'rc_stl.dart';
import 'rcfncchk.dart';
import 'rcitmset.dart';
import 'rcmbrrealsvr.dart';
import 'rcsyschk.dart';

class RcMbrFlrd {
  /// クラス変数として格納するDBテーブル
  static CCustMstColumns cust = CCustMstColumns();  //顧客マスタ
  static SCustTtlTbl enq = SCustTtlTbl();  //顧客別累計購買情報テーブル
  static PPromschMst svs = PPromschMst();  //プロモーションスケジュールマスタ
  static CCustMstColumns custParent = CCustMstColumns();  //親_顧客マスタ
  static SCustTtlTbl enqParent = SCustTtlTbl();  //親_顧客別累計購買情報テーブル
  /// フロントへ渡すデータ（疑似サーバーから取得する）
  static bool rcdStatus = true;  //登録済み判定結果（true=登録  false=未登録）
  static int ttlPoint = 0;  //累計ポイント
  static int lapsePoint = 0;  //期限切れポイント
  static String lapseDay = "";  //有効期限日
  static int cardType = 0;  //カード種類
  static bool seniorFlg = false;  //シニア会員フラグ

  // TODO:10155 顧客呼出 - 疑似サーバー対応
  static Custreal_necJsonFile jsonFile = Custreal_necJsonFile();

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// スタンプカード印字用のデータを取得する
  /// 関連tprxソース: rcmbrflrd.c - rcmbrRead_StpCdPrintData
  static void rcmbrReadStpCdPrintData() {}

  /// 関数：rcRd_custtrmFL_SmpluStldscTyp()
  /// 機能：今回サービス期間番号読み込み
  /// 引数：無し
  /// 戻値： 0 <= :今回サービス期間番号  -1:エラー
  /// 関連tprxソース: rcmbrflrd.c - rcRd_custtrmFL_SmpluStldscTyp
  static int rcRdcusttrmFLSmpluStldscTyp() {
    int nowSrvNo = 0;

    // #if 0	//@@@V15	ビスマックはとりあえず削除
    // char	sql[256];
    // RX_COMMON_BUF *pCom;
    //
    // if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
    // TprLibLogWrite(rcGetProcessID(), TPRLOG_ERROR, -1, "C_BUF get error\n");
    // return( -1 );
    // }
    //
    // /* sql文作成 */
    // memset(sql, 0, sizeof(sql));
    // sprintf(sql, "select * from c_cust_trm_mst where trm_grp_cd = '%ld' and stre_cd='%ld'\n", pCom->db_regctrl.trm_grp_cd, pCom->db_regctrl.stre_cd);
    //
    // printf("%s\n", sql);
    // /* データベース読み込み */
    // if( ReadData(sql) == Error )
    // {
    // return( -1 );
    // }
    //
    // /* メモリにデータを書き込み */
    // nowsrvno = atoi(GetField("smplu_stldsc_typ"));
    //
    // /* 読み込みデータの開放 */
    // ClearData();
    // #endif	//@@@V15

    return nowSrvNo;
  }

  /// TODO:00002 佐野 - 顧客呼出のため、先行して構築
  /// 顧客サーバーに対して顧客のロック解除指示を行う
  /// 引数:[macNo] マシン番号
  /// 引数:[custNo] 顧客番号
  /// 引数:[opeModeFlg] 操作モード
  /// 引数:[realCustSrvFlg] サーバー接続フラグ
  /// 引数:[mbrInput] 会員入力有無
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_StdCust_Unlock
  static void rcmbrStdCustUnlock(int macNo, String? custNo, int opeModeFlg,
      int realCustSrvFlg, int mbrInput) {
  }

  /// アカウントマスタの存在チェック
  /// 戻値: エラーコード
  /// 関連tprxソース:rcmbrflrd.c - rcmbrRead_AccountMstChk
  static Future<int> rcmbrReadAccountMstChk() async {
    List<CAcctMstColumns> acctbuf = <CAcctMstColumns>[];
    int ret;
    String readDate = RcFlrd.rcGetSchReadDate();

    // アカウント情報(ポイントの種類などを表す情報)の取得
    ret = await RcSchOther.rcSchAccountMstRead(
        await RcSysChk.getTid(), acctbuf, CntList.acntMax, readDate);
    if (ret <= 0) {
      return DlgConfirmMsgKind.MSG_ACCT_NOTREAD.dlgId; // アカウントマスタが\n読込めませんでした
    }
    return Typ.OK;
  }

  /// サービス分類マスタ読み込み(p_promsch_mst)
  /// 引数:[svsClsCd] サービス分類コード
  /// 戻値:[int] 0=正常終了  0以外=エラーコード
  /// 戻値:[PPromschMst] プロモーションスケジュールマスタ (p_promsch_mst.svs)
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustSvs
  static Future<(int, PPromschMst)> rcmbrReadCustSvs(int svsClsCd) async {
    int retInt = 0;
    PPromschMst retSvs = PPromschMst();

    if (await RcSysChk.rcChkZHQsystem()) {
      return (retInt, retSvs);
    }
    if (RcSysChk.rcChkCustrealPointInfinitySystem()) {
      return (retInt, retSvs);
    }
    AcMem cMem = SystemFunc.readAcMem();
    if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0) &&
        (cMem.working.janInf.type == JANInfConsts.JANformatChargeSlip)) {
      return (retInt, retSvs);
    }
    if (RcSysChk.rcChkCosme1IstyleSystem()) {
      return (retInt, retSvs);
    }
    if (svsClsCd == 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrReadCustSvs(): svs_cls_cd = 0. OK.");
      return (retInt, retSvs);
    }
    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100700.otherStoreMbr == 2) {
      return (retInt, retSvs);
    }

    String readDate = RcFlrd.rcGetSchReadDate(); // スケジュール読込日時
    (retInt, retSvs) = await RcSchOther.rcSchCustSvsRead(
        await RcSysChk.getTid(), svsClsCd, readDate);

    if (retInt < 0) {
      retInt = DlgConfirmMsgKind.MSG_SVSCLSNONFILE.dlgId;
    }

    return (retInt, retSvs);
  }

  /// 顧客Noのカード種別からサービス分類マスタ読み込み(p_promsch_mst)
  /// 引数:[custNo] 顧客番号
  /// 引数:[svs] 読み込みバッファのポインタ
  /// 戻値:[int] 0=正常終了  0以外=エラーコード
  /// 戻値:[PPromschMst] プロモーションスケジュールマスタ (p_promsch_mst.svs)
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_StdCust_Unlock
  static Future<(int, PPromschMst)> rcmbrReadCustSvsCustNo(String? custNo) async {
    int retInt = 0;
    PPromschMst retSvs = PPromschMst();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (retInt, retSvs);
    }
    RxCommonBuf cBuf = xRet.object;
    int svsClsCd = -1;

    if (cBuf.dbTrm.nalsePanacode != 0) {
      if (int.tryParse(custNo!.substring(0, 1)) != null) {
        svsClsCd = int.parse(custNo.substring(0, 1));
      }
    } else {
      if (int.tryParse(custNo!.substring(4, 5)) != null) {
        svsClsCd = int.parse(custNo.substring(4, 5));
      }
    }
    if (svsClsCd < 0 || svsClsCd > 9) {
      retInt = DlgConfirmMsgKind.MSG_SVSCLSNONFILE.dlgId;
    } else {
      (retInt, retSvs) = await rcmbrReadCustSvs(svsClsCd);
    }

    return (retInt, retSvs);
  }

  /// 顧客ファイル読み込み(顧客呼出時)
  /// 引数:[custNo] 顧客番号
  /// 引数:[srchTelno] 電話番号
  /// 引数:[member] 会員入力方法
  /// 引数:[waitFlg] 待ち時間
  /// 戻値:[int] 0=正常終了  0以外=エラーコード
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCust
  static Future<int> rcmbrReadCust(String custNo, String srchTelno,
      String birthday, int member, int waitFlg) async {
    int ret = 0;
    //       char other_store_mbr = 0;
    String tmpBuf = '';
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    // TODO:10155 顧客呼出 - 疑似サーバー対応
    await jsonFile.load();

    if (RcSysChk.rcsyschkAyahaSystem()) {
      RegsMem().tmpbuf.ayaha = RxMemAyaha();
    }
    if (CmCksys.cmIKEASystem() != 0) {
      if (custNo.substring(0, 9) == "627598034") {
        tmpBuf = custNo.substring(0, 20);
        custNo = tmpBuf.substring(9, 19);
      }
    }
    if ((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) &&
        (atSing.inputbuf.Acode[0] == 'N')) {
      tmpBuf = custNo.substring(0, 20);
      custNo = tmpBuf.substring(1, CmMbrSys.cmMbrcdLen() - 1);
    }

    if (((await CmCksys.cmCogcaSystem()) != 0) &&
        (CmMbrSys.cmMagcdLen() == 8) &&
        (custNo.isNotEmpty)) {
      /* CoGCa仕様 + 会員番号8桁 磁気カードと同様に番号変換を行う */
      if (custNo.length == 8) {
        tmpBuf = '';
        (ret, tmpBuf) = await Cmmcdset.cmMcdToMbr(custNo);
        /* ポインタ置換 本関数内に限り、この先の cust_no は tmp_buf を実体として参照される */
        custNo = tmpBuf;
      }
    }

    debugPrint('********** 実機調査ログ（会員呼出）6: RcMbrFlrd.referCust($custNo, ${""}, ${""}, $member, RcMbr.RCMBR_WAIT) スタート地点');
    ret = await referCust(custNo, srchTelno, birthday, member, waitFlg);
    debugPrint('********** 実機調査ログ（会員呼出）10: RcMbrFlrd.referCust() = $ret');

    if (RcSysChk.rcChkCustrealsvrSystem()
        || (RcSysChk.rcChkCustrealUIDSystem() != 0)
        || (RcSysChk.rcChkCustrealUIDSystem() != 0)
        || RcSysChk.rcChkCustrealOPSystem()
        || (RcSysChk.rcChkCustrealPointartistSystem() != 0)
        || (RcSysChk.rcChkTpointSystem() != 0)
        || (RcSysChk.rcChkCustrealPointTactixSystem() != 0)
        || RcSysChk.rcChkCustrealPointInfinitySystem()
        || RcSysChk.rcChkCustrealFrestaSystem()
        || RcSysChk.rcChkCosme1IstyleSystem()) {
      if (ret == RcMbr.RCMBR_NON_READ) {
        return (ret);
      }
      ret = rcmbrReadCustDataSet(ret, member, custNo, cust,
          enq, svs);
    }
    else if (RcSysChk.rcChkCustrealWebserSystem()) {
      if (ret == RcMbr.RCMBR_NON_READ) {
        return (ret);
      }
      ret = rcmbrReadCustDataSet(ret, member, custNo, cust,
          enq, svs);
    }
    else {
      if ((RcFncChk.rcCheckScanCheck()) &&
          (ret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId)) {
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
      if ((ret == Typ.OK) ||
          (ret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId)) {
        /* 会員売価キー */
        if ((mem.tTtllog.t100700.mbrInput ==
            MbrInputType.mbrprcKeyInput.index) &&
            (RcFncChk.rcCheckRegistration()) &&
            (!RcFncChk.rcCheckScanCheck())) {
          rcmbrTmpCustDataClr();
        }
        setCustData(member);
        if (ret == DlgConfirmMsgKind.MSG_OTHERMBR.dlgId) {
          /* 他店会員 Other store member */
          ret = rcmbrSetOtherStoreMbr(custNo);
        }
        /* 記念日種別マスタ読み込み / Anniversary kind master reading */
        referCustAnv(cMem.custData.cust);
        if ((await CmCksys.cmZHQSystem()) != 0) {
          rcmbrReadOneToOnePromotionTbl('0');
        } else {
          rcmbrReadStpPlnMst(custNo); // スタンプカード企画マスタの有効企画を取得
          rcmbrReadOneToOnePromotionTbl(custNo);
        }
      }
    }
    rcmbrReadPntSch(ret);

    return ret;
  }

  /// メモリに顧客マスタ、顧客問い合わせテーブル、サービス分類マスタのデータを読み込む
  /// 引数:[custNo] 顧客番号
  /// 引数:[srchTelNo] 電話番号
  /// 引数:[birthday] 誕生日
  /// 引数:[member] 会員入力方法
  /// 引数:[waitFlg] 処理待ち時間
  /// 戻り値: NORMAL=正常終了 / MSG_OTHERMBR=他店会員/ その他=異常終了
  /// ※下記テーブルデータは、当クラスのstatic変数より取得すること
  ///   RcMbrFlrd.cust: 顧客マスタ (c_cust_mst)
  ///   RcMbrFlrd.enq: 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  ///   RcMbrFlrd.svs: プロモーションスケジュールマスタ (p_promsch_mst)
  /// 関連tprxソース: rcmbrflrd.c - Refer_Cust
  static Future<int> referCust(String custNo, String srchTelNo,
      String birthday, int member, int waitFlg) async {
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return Typ.NORMAL;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (!(await RcSysChk.rcChkZHQsystem())) {
      if (!RcFncChk.rcCheckScanCheck()) {
        mem.custTtlTbl = SCustTtlTbl();
        mem.custCpnTbl = List.generate(RxCntList.OTH_PROM_MAX, (_) => SCustCpnTbl());
        mem.custLoyTbl = List.generate(RxCntList.LOY_PROM_TTL_MAX, (_) => SCustLoyTbl());
        mem.custStpTbl = List.generate(RxCntList.OTH_PROM_MAX, (_) => SCustStpTbl());
      }
    }

    if (RcSysChk.rcChkCustrealsvrSystem()
        || (await RcSysChk.rcChkCustrealNecSystem(0))
        || (RcSysChk.rcChkCustrealUIDSystem() != 0)
        || RcSysChk.rcChkCustrealOPSystem()
        || (RcSysChk.rcChkCustrealPointartistSystem() != 0)
        || (RcSysChk.rcChkTpointSystem() != 0)
        || (RcSysChk.rcChkCustrealPointTactixSystem() != 0)
        || RcSysChk.rcChkCustrealPointInfinitySystem()
        || RcSysChk.rcChkCustrealFrestaSystem()
        || RcSysChk.rcChkCosme1IstyleSystem()) {
      // TODO:10155 顧客呼出 実装対象外
      //CustReal_memberWorkSet( member );
    }

    if (member == MbrInputType.mbrprcKeyInput.index) {
      /* 会員売価キー */
      if (CompileFlag.RALSE_MBRSYSTEM) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          mem.tTtllog.t100700Sts.mbrTyp = atSing.mbrTyp;
        }
        if (RcSysChk.rcChkCustrealFrestaSystem()) {
          /* 固定会員番号にてオファーId取得を行う */
          // TODO:10155 顧客呼出 実装対象外
          //rcrealsvr_Fresta_OfferId_Add(1);
        }
        return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
      } else {
        return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
      }
    }

    /* 顧客マスタ読み込み */
    debugPrint('********** 実機調査ログ（会員呼出）7: RcMbrFlrd.rcmbrReadCustCust($custNo, ${""}, ${""}, RcMbr.RCMBR_WAIT) スタート地点');
    ret = await rcmbrReadCustCust(custNo, srchTelNo, birthday, waitFlg);
    debugPrint('********** 実機調査ログ（会員呼出）8: RcMbrFlrd.rcmbrReadCustCust() = $ret');
    if (CompileFlag.RALSE_MBRSYSTEM) {
      if (RcSysChk.rcChkCustrealsvrSystem()
          || (await RcSysChk.rcChkCustrealNecSystem(0))
          || (RcSysChk.rcChkCustrealUIDSystem() != 0)
          || RcSysChk.rcChkCustrealOPSystem()
          || (RcSysChk.rcChkCustrealPointartistSystem() != 0)
          || (RcSysChk.rcChkTpointSystem() != 0)
          || (RcSysChk.rcChkCustrealPointTactixSystem() != 0)
          || RcSysChk.rcChkCustrealPointInfinitySystem()
          || RcSysChk.rcChkCustrealFrestaSystem()
          || RcSysChk.rcChkCosme1IstyleSystem()) {
        if (ret == RcMbr.RCMBR_NON_READ) {
          return ret;
        }
        ret = await custRlsErrMsgSet(ret);
      }
      else if (RcSysChk.rcChkCustrealWebserSystem()) {
        if (ret == RcMbr.RCMBR_NON_READ) {
          return ret;
        }
      }
      else if (await RcSysChk.rcChkCustrealNecSystem(0)) {
        if (ret == RcMbr.RCMBR_NON_READ) {
          return ret;
        }
        ret = await custRlsErrMsgSet(ret);
      }
      else {
        if (RcSysChk.rcChkRalseCardSystem()) {
          if (ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId) {
            if (CompileFlag.ARCS_MBR) {
              if (atSing.mbrTyp != Mcd.MCD_RLSSTAFF) {
                return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
              }
            }
            return DlgConfirmMsgKind.MSG_RLSSTAFFNOLIST.dlgId;
          }
          if (RcFncChk.rcCheckRegistration() &&
              (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index)) {
            switch (mem.tTtllog.t100700Sts.mbrTyp) {
              case Mcd.MCD_RLSSTAFF:
                if (atSing.mbrTyp != mem.tTtllog.t100700Sts.mbrTyp) {
                  return DlgConfirmMsgKind.MSG_CALL_RLSSTAFF.dlgId;
                }
                break;
              case Mcd.MCD_RLSCARD:
              case Mcd.MCD_RLSVISA:
              case Mcd.MCD_RLSCRDT:
                if ((Mcd.MCD_RLSCARD != atSing.mbrTyp) &&
                    (Mcd.MCD_RLSVISA != atSing.mbrTyp) &&
                    (Mcd.MCD_RLSCRDT != atSing.mbrTyp)) {
                  return DlgConfirmMsgKind.MSG_CALL_RLSMBR.dlgId;
                }
                break;
              case Mcd.MCD_RLSOTHER:
                if (atSing.mbrTyp != mem.tTtllog.t100700Sts.mbrTyp) {
                  return DlgConfirmMsgKind.MSG_CALL_RLSSTAFF.dlgId;
                }
                break;
              default:
                break;
            }
          }
        }
      }
    }
    if (ret != Typ.NORMAL) {
      debugPrint('********** 実機調査ログ（会員呼出）9-ERR: RcMbrFlrd.referCust() = $ret');
      return ret;
    }

    PPromschMst retSvs = PPromschMst();
    if (RcSysChk.rcChkCustrealsvrSystem()
        || (RcSysChk.rcChkCustrealUIDSystem() != 0)
        || RcSysChk.rcChkCustrealOPSystem()
        || (RcSysChk.rcChkCustrealPointartistSystem() != 0)
        || (RcSysChk.rcChkTpointSystem() != 0)
        || (RcSysChk.rcChkCustrealPointTactixSystem() != 0)
        || RcSysChk.rcChkCustrealPointInfinitySystem()
        || RcSysChk.rcChkCustrealFrestaSystem()
        || RcSysChk.rcChkCosme1IstyleSystem()) {
      ret = custErrMsgSet(ret, cust);
      if (ret == Typ.NORMAL) {
        ret = await rcmbrReadCustCustEnqDataRd(ret, member);
      }
    }
    else if (RcSysChk.rcChkCustrealWebserSystem()) {
      ret = custErrMsgSet(ret, cust);
      if (ret == Typ.NORMAL) {
        ret = await rcmbrReadCustCustEnqDataRd(ret, member);
      }
    }
    else if (await RcSysChk.rcChkCustrealNecSystem(0)) {
      ret = custErrMsgSet(ret, cust);
      if (ret == Typ.NORMAL) {
        ret = await rcmbrReadCustCustEnqDataRd(ret, member);
      }
    }
    else {
      debugPrint('********** 実機調査ログ（会員呼出）9-1: RcMbrFlrd.referCust() cust.cust_status = ${cust.cust_status}');
      /* 会員状態(cust_status)の判断 */
      if (cust.cust_status == 2) {
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
      else if (cust.cust_status == 1) {
        if (cBuf.dbTrm.errorSleepMbr != 0) {
          if (cBuf.dbTrm.seikatsuclubOpe != 0) {
            return DlgConfirmMsgKind.MSG_UNIONSTOP.dlgId;
          } else {
            return DlgConfirmMsgKind.MSG_MBRSTOP.dlgId;
          }
        }
      }
      else if (cust.cust_status == 4) {
        if (cBuf.dbTrm.seikatsuclubOpe != 0) {
          return DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId;
        }
      }
      /* サービス分類マスタ読み込み */
      String tmpCustNo = cust.cust_no ?? "";
      if (CompileFlag.RALSE_MBRSYSTEM) {
        if (!RcSysChk.rcChkRalseCardSystem()) {
          (ret, retSvs) = await rcmbrReadCustSvs(cust.svs_cls_cd!);
          if (ret != Typ.NORMAL) {
            return ret;
          }
          svs = retSvs;
          if (CompileFlag.SIMS_CUST) {
            if (mem.tTtllog.t100700.otherStoreMbr != 2) {
              ret = await rcmbrReadCustEnq(tmpCustNo, "");
              if (ret != Typ.NORMAL) {
                return ret;
              }
            }
          }
          else {
            ret = await rcmbrReadCustEnq(tmpCustNo, "");
            if (ret != Typ.NORMAL) {
              return ret;
            }
          }
        }
        else {
          if (CompileFlag.ARCS_MBR) {
            ret = await rcmbrGetServerData(custNo);
            if (ret != Typ.NORMAL) {
              return ret;
            }
          }
        }
      }
      else {
        (ret, retSvs) = await rcmbrReadCustSvs(cust.svs_cls_cd!);
        if (ret != Typ.NORMAL) {
          return ret;
        }
        svs = retSvs;
        if (CompileFlag.SIMS_CUST) {
          if (mem.tTtllog.t100700.otherStoreMbr != 2) {
            ret = await rcmbrReadCustEnq(tmpCustNo, "");
            if (ret != Typ.NORMAL) {
              return ret;
            }
          }
        }
        else {
          ret = await rcmbrReadCustEnq(tmpCustNo, "");
          if (ret != Typ.NORMAL) {
            return ret;
          }
        }
      }
    }

    if (RcSysChk.rcChkCustrealsvrSystem() ||
        (RcSysChk.rcChkCustrealUIDSystem() != 0) ||
        RcSysChk.rcChkCustrealWebserSystem() ||
        (await RcSysChk.rcChkCustrealNecSystem(0)) ||
        RcSysChk.rcChkCustrealOPSystem() ||
        (RcSysChk.rcChkCustrealPointartistSystem() != 0) ||
        (RcSysChk.rcChkTpointSystem() != 0) ||
        (RcSysChk.rcChkCustrealPointTactixSystem() != 0) ||
        RcSysChk.rcChkCustrealPointInfinitySystem() ||
        RcSysChk.rcChkCustrealFrestaSystem() ||
        RcSysChk.rcChkCosme1IstyleSystem()) {
      return ret;
    }

    return Typ.NORMAL;
  }

  /// 顧客マスタ読み込み (c_cust_mst)
  /// 引数:[custNo] 顧客番号
  /// 引数:[srchTelNo] 電話番号
  /// 引数:[birthday] 誕生日
  /// 引数:[waitFlg] 処理待ち時間
  /// 戻り値: NORMAL=正常終了 / MSG_OTHERMBR=他店会員/ MSG_MBRNOLIST=データなし / その他=異常終了
  /// ※下記テーブルデータは、当クラスのstatic変数より取得すること
  ///   RcMbrFlrd.cust: 顧客マスタ (c_cust_mst)
  ///   RcMbrFlrd.enq: 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  ///   RcMbrFlrd.svs: プロモーションスケジュールマスタ (p_promsch_mst)
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustCust
  static Future<int> rcmbrReadCustCust(String custNo, String srchTelNo,
      String birthday, int waitFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxMemRet xtRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid() || xtRet.isInvalid()) {
      return Typ.NORMAL;
    }
    RxCommonBuf cBuf = xRet.object;
    RxTaskStatBuf tsBuf = xtRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    // 売価チェック時に以下の項目は０クリアして良いか？
    mem.tTtllog.t100700Sts.mulrbtPrnAmt = 0;
    mem.tTtllog.t100700Sts.mulrbtPnt = 0;

    TprMID aid = 0;
    if (CompileFlag.SIMS_CUST && CompileFlag.SEGMENT) {
      aid = await RcFlrd.rcGetProcessID();
    }

    if (RcSysChk.rcChkMbrRCPdscSystem() &&
        (ReptEjConf.rcCheckRegistration())) {
      if ((custNo != "") && (mem.tTtllog.t100700Sts.mbrTyp == 4) ) {
        rcRcpdscMbrTypSet(custNo);
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
    }
    if ((cBuf.dbTrm.memUseTyp == 1) && (cBuf.dbTrm.loasonNw7mbr != 0)) {
      if (custNo != "") {
        return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
      }
      return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
    }

    int ret = Typ.NORMAL;
    int maxlen = 0;
    int	idx = 0;
    int	cnt = 0;
    int	zeroCnt = 0;
    int formatNo = 0;
    int errNo = 0;
    int statBuf = 0;  // 0=正常  1=新規会員登録
    bool msgDspFlg = false;  //「お待ちください」

    if (srchTelNo == "") {
      if (cBuf.dbTrm.memBcdTyp != 1) {
        /* Member barcode type 10digit */
        maxlen = CmMbrSys.cmMbrcdLen() - 2 - 1;  //12桁＋パリティビット
        idx = 2;
        // TODO:10155 顧客呼出 - 疑似サーバー対応のため暫定処理を追加
        maxlen = custNo.length - idx;  //暫定処理（入力値長-idx）
      }
      else {
        /* Member barcode type 8digit  */
        for (idx = 0; idx < RxMem.DB_INSTRE_MAX; idx++) {
          if (cBuf.dbInstre[idx].format_typ == 3) {
            /* バーコードタイプが顧客 */
            formatNo = cBuf.dbInstre[idx].format_no;
            break;
          }
        }
        if (formatNo == 11) {
          maxlen = 6;
          idx = 6;
        } else {
          maxlen = 5;
          idx = 7;
        }
      }
      if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
        maxlen = CmMbrSys.cmMbrcdLen();
        idx = 0;
      }
      if (await RcSysChk.rcChkZHQsystem()) {
        if (custNo[0] != '0') {
          cnt++;
        }
      }
      else {
        for (; cnt < maxlen; cnt++,idx++) {
          if (custNo[idx] == '0') {
            zeroCnt++;
          }
        }
      }
      if (!(await RcSysChk.rcChkEdyNoMbrSystem())) {
        if (CompileFlag.SAPPORO) {
          if (!(await RcSysChk.rcChkPointCardSystem()) &&
              !(await RcSysChk.rcChkPharmacySystem()) &&
              (!((await RcSysChk.rcChkSapporoPanaSystem()) ||
                  (await RcSysChk.rcChkJklPanaSystem()))) &&
              !(await RcSysChk.rcChkHt2980System())) {
            if (!(await RcSysChk.rcChkCOOPSystem())) {
              if (cnt == zeroCnt) {
                // TODO:10155 顧客呼出 - 疑似サーバー対応（バーコード読み取りなし）
                //return DlgConfirmMsgKind.MSG_BARFMTERR.dlgId;
              }
            }
          }
        }
        else if (CompileFlag.POINT_CARD) {
          if (!(await RcSysChk.rcChkPointCardSystem()) &&
              !(await RcSysChk.rcChkPharmacySystem())) {
            if (!(await RcSysChk.rcChkCOOPSystem())) {
              if (cnt == zeroCnt) {
                return DlgConfirmMsgKind.MSG_BARFMTERR.dlgId;
              }
            }
          }
        }
        else {
          if (!(await RcSysChk.rcChkCOOPSystem())) {
            if (cnt == zeroCnt) {
              return DlgConfirmMsgKind.MSG_BARFMTERR.dlgId;
            }
          }
        }
      }
    }

    /* 他店会員形式 Other store member forms */
    if (cBuf.dbTrm.memUseTyp == 1) {
      if (CompileFlag.RALSE_MBRSYSTEM) {
        if (!RcSysChk.rcChkRalseCardSystem() ||
            (RcSysChk.rcChkRalseCardSystem() && (atSing.mbrTyp != 0) &&
              ((atSing.mbrTyp == Mcd.MCD_RLSCARD) ||
               (atSing.mbrTyp == Mcd.MCD_RLSVISA) ||
               (atSing.mbrTyp == Mcd.MCD_RLSCRDT)))) {
          if (custNo != "") {
            if ((await CmCksys.cmMoriyaMemberSystem() != 0) &&
                (cBuf.dbTrm.otherPanaCardFlg != 0)) {
              /* フレスコキクチ向け */
              ret = await rcmbrReadCustSqlExec(custNo, srchTelNo, birthday, waitFlg);
              return ret;
            } else {
              return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
            }
          }
          return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
        }
      } else {
        if (custNo != "") {
          if ((await CmCksys.cmMoriyaMemberSystem() != 0) &&
              (cBuf.dbTrm.otherPanaCardFlg != 0)) {
            /* フレスコキクチ向け */
            ret = await rcmbrReadCustSqlExec(custNo, srchTelNo, birthday, waitFlg);
            return ret;
          } else {
            return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
          }
        }
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
    }
    else {
      if (await RcSysChk.rcCheckWatariCardSystem()) {
        /* 自店他店会員形式 */
        if (cBuf.dbTrm.memUseTyp == 2) {
          if (!RcMbrCom.rcChkWatariHouseCard(0)) {
            if (custNo != "") {
              return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
            }
          }
        }
      }
    }

    if (CompileFlag.ARCS_MBR && CompileFlag.CUSTREALSVR) {
      if (RcSysChk.rcChkRalseCardSystem() &&
          (await RcSysChk.rcChkCustrealNecSystem(0)) &&
          (atSing.mbrTyp != Mcd.MCD_RLSSTAFF)) {
        Rcmbrrealsvr.custRealMemberStepSet(RcMbr.RCMBR_CUST_READ);
        ret = Rcmbrrealsvr.custRealSvrFlRd(waitFlg, custNo, cust, enq);
        if (ret == RcMbr.RCMBR_NON_READ) {
          return ret;
        }
        ret = await errMsgSet(ret, custNo);
        if (ret == Typ.NORMAL) {
          if (cust.status == 2) {		/* 2:退会 */
            return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
          }
        }
        if (ret != Typ.NORMAL)  {
          return ret;
        }
      }
      else {
        if (RcSysChk.rcChkCustrealsvrSystem() && (tsBuf.rwc.order == 0)) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCustrealWebserSystem()) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (!CompileFlag.ARCS_MBR &&
            (await RcSysChk.rcChkCustrealNecSystem(0))) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCustrealOPSystem()) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCustrealPointartistSystem() != 0) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkTpointSystem() != 0) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (await RcSysChk.rcChkZHQsystem()) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0) &&
            (cMem.working.janInf.type == JANformat_CHARGE_SLIP)) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if ((await rcmbrChkDataTranSysDS2())
            || (await rcmbrChkDataTranSysTsStd())
            || (rcmbrChkDataTranSysExtSvr() != 0)) {
          if (RcFncChk.rcCheckScanCheck() &&
              (rcmbrChkDataTranSysExtSvr() != 0)) {
            return DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
          }
          // TODO:10155 顧客呼出 - 疑似サーバー対応のため、暫定処理に置換（当条件下の処理は省略）
        }
        else if (RcSysChk.rcChkCustrealPointInfinitySystem()) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCustrealFrestaSystem()) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else if (RcSysChk.rcChkCosme1IstyleSystem()) {
          // TODO:10155 顧客呼出 実装対象外
        }
        else {
          ret =
          await rcmbrReadCustSqlExec(custNo, srchTelNo, birthday, waitFlg);
        }
      }
    }
    else {
      if (RcSysChk.rcChkCustrealsvrSystem() && (tsBuf.rwc.order == 0)) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealWebserSystem()) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealUIDSystem() != 0) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (!CompileFlag.ARCS_MBR &&
          (await RcSysChk.rcChkCustrealNecSystem(0))) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealOPSystem()) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealPointartistSystem() != 0) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkTpointSystem() != 0) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealPointTactixSystem() != 0) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (await RcSysChk.rcChkZHQsystem()) {
        // TODO:10155 顧客呼出 実装対象外
      } else if ((RcSysChk.rcsyschkYunaitoHdSystem() != 0) &&
          (cMem.working.janInf.type == JANformat_CHARGE_SLIP)) {
        // TODO:10155 顧客呼出 実装対象外
      } else if ((await rcmbrChkDataTranSysDS2())
          || (await rcmbrChkDataTranSysTsStd())
          || (rcmbrChkDataTranSysExtSvr() != 0)) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealPointInfinitySystem()) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCustrealFrestaSystem()) {
        // TODO:10155 顧客呼出 実装対象外
      } else if (RcSysChk.rcChkCosme1IstyleSystem()) {
        // TODO:10155 顧客呼出 実装対象外
      } else {
        ret = await rcmbrReadCustSqlExec(custNo, srchTelNo, birthday, waitFlg);
      }
    }

    return ret;
  }

  /// 顧客マスタ読み込み (c_cust_mst) - SQL文作成
  /// 引数:[custNo] 顧客番号
  /// 引数:[srchTelNo] 電話番号
  /// 引数:[birthday] 誕生日
  /// 引数:[waitFlg] 処理待ち時間
  /// 戻り値: NORMAL=正常終了 / MSG_OTHERMBR=他店会員/ MSG_MBRNOLIST=データなし / その他=異常終了
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustCust
  static Future<int> rcmbrReadCustSqlExec(String custNo, String srchTelNo,
      String birthday, int waitFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return Typ.NORMAL;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    String sql = "";

    if (srchTelNo != "") {
      sql = await makeCustMstSql(srchTelNo);
    }
    if (custNo != "") {
      sql = "SELECT * FROM c_cust_mst WHERE comp_cd = '${cBuf.dbRegCtrl
          .compCd}' and cust_no = '$custNo'";
    } else {
      return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
    }

    if (RcSysChk.rcChkMbrRCPdscSystem() && (custNo != "")) {
      if (RcMbrCom.rcChkMemberRCpdsc(custNo) ||
          RcMbrCom.rcChkMemberStaffpdsc(custNo)) {
        cust.cust_no = custNo.substring(0, CmMbrSys.cmMbrcdLen());
        return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
      }
    }

    int status = 0;
    DbManipulationPs db = DbManipulationPs();
    Result dbRes;

    if (CompileFlag.ARCS_MBR) {
      if (RcSysChk.rcChkRalseCardSystem()) {
        debugPrint('********** 実機調査ログ（会員呼出）8B-2: RcMbrFlrd.rcmbrReadCustEnq($custNo) スタート地点');
        int tmpRet = await rcmbrReadCustEnq(custNo, "");
        debugPrint('********** 実機調査ログ（会員呼出）8B-3: RcMbrFlrd.rcmbrReadCustEnq($custNo) = $tmpRet');
        if (tmpRet == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId) {
          if (cust.cust_no?.substring(2, 3) != '1') {
            cust.cust_no = custNo;
            if (atSing.mbrTyp == 0) {
              atSing.mbrTyp = Mcd.MCD_RLSCARD;
            }
            if ((cBuf.dbTrm.memUseTyp != 0) &&
                ((atSing.mbrTyp == Mcd.MCD_RLSCARD) ||
                    (atSing.mbrTyp == Mcd.MCD_RLSVISA)||
                    (atSing.mbrTyp == Mcd.MCD_RLSCRDT))) {
              return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
            }
          }
          return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
        }
        else {
          cust = CCustMstColumns();
          cust.cust_no = custNo;
          if (cust.cust_no?.substring(2, 3) == '1') {
            atSing.mbrTyp = Mcd.MCD_RLSSTAFF;
          } else if (atSing.mbrTyp == 0) {
            atSing.mbrTyp = Mcd.MCD_RLSCARD;
          }
        }
        return Typ.NORMAL;
      }
    }

    /* データベース読み込み */
    try {
      dbRes = await db.dbCon.execute(sql);
      if (dbRes.affectedRows == 0) {
        if (CompileFlag.RALSE_MBRSYSTEM) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            if (atSing.mbrTyp == Mcd.MCD_RLSSTAFF) {
              return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
            }
            atSing.mbrTyp = Mcd.MCD_RLSCARD;
            return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
          }
        }
        /* 自店他店会員形式 Store and others store member form  */
        if ((custNo != "") && (cBuf.dbTrm.memUseTyp == 2)) {
          return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
        }
        if ((await CmCksys.cmMoriyaMemberSystem() != 0) &&
            (cBuf.dbTrm.otherPanaCardFlg != 0)) {
          /* フレスコキクチ向けは、基本他店会員 */
          return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
        }
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
      if ((custNo == "") && (dbRes.affectedRows > 1)) {
        // TODO:10155 顧客呼出 実装対象外（会員電話番号非表示）
        /*
        /* 会員電話番号一覧 */
        if (await RcSysChk.rcCheckPrimeStat() == RcRegs.PRIMETOWER) {
          if (atSing.inputbuf.no == DevIn.KEY1) {
            return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
          }
        }
        PopupTellList(buf);							/* 電話番号一覧を出す */
        return RcMbr.RCMBR_TEL_LIST;
       */
      }
      Map<String, dynamic> data = dbRes.first.toColumnMap();
      status = int.tryParse(data["cust_status"]) ?? 0; /* 会員状態をチェック */
      if (RcSysChk.rcsyschkAyahaSystem()) {
        if (status == 2) {
          return DlgConfirmMsgKind.MSG_LIMITERR_NEW.dlgId;
        }
        if (status == 3) {
          return DlgConfirmMsgKind.MSG_MAGERR_AGAIN.dlgId;
        }
        if (status == 4) {
          return DlgConfirmMsgKind.MSG_CARD_NOTUSE.dlgId;
        }
      }
      if (status == 2) {
        /* 2:退会 */
        if (cBuf.dbTrm.coopYamaguchiGreenStamp != 0) {
          /* コープやまぐち仕様 */
          mem.tTtllog.t100700.otherStoreMbr = 0;
        }
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
      /* メモリにデータを書き込み */
      cust.cust_no = data["cust_no"];
      cust.comp_cd = int.tryParse(data["comp_cd"]) ?? 0;
      cust.stre_cd = int.tryParse(data["stre_cd"]) ?? 0;
      cust.last_name = data["last_name"];
      cust.first_name = data["first_name"];
      cust.kana_last_name = data["kana_last_name"];
      cust.kana_first_name = data["kana_first_name"];
      cust.birth_day = data["birth_day"];
      cust.tel_no1 = data["tel_no1"];
      cust.tel_no2 = data["tel_no2"];
      cust.sex = int.tryParse(data["sex"]) ?? 0;
      cust.cust_status = int.tryParse(data["cust_status"]) ?? 0;
      cust.admission_date = data["admission_date"];
      cust.withdraw_date = data["withdraw_date"];
      cust.withdraw_typ = int.tryParse(data["withdraw_typ"]) ?? 0;
      cust.withdraw_resn = data["withdraw_resn"];
      cust.card_clct_typ = int.tryParse(data["card_clct_typ"]) ?? 0;
      cust.custzone_cd = int.tryParse(data["custzone_cd"]) ?? 0;
      cust.post_no = data["post_no"];
      cust.address1 = data["address1"];
      cust.address2 = data["address2"];
      cust.address3 = data["address3"];
      if (await CmCksys.cmZHQSystem() == 0) {
        cust.address4 = data["address4"];
      }
      cust.mail_addr = data["mail_addr"];
      cust.mail_flg = int.tryParse(data["mail_flg"]) ?? 0;
      cust.dm_flg = int.tryParse(data["dm_flg"]) ?? 0;
      cust.password = data["password"];
      cust.targ_typ = int.tryParse(data["targ_typ"]) ?? 0;
      cust.attrib1 = int.tryParse(data["attrib1"]) ?? 0;
      cust.attrib2 = int.tryParse(data["attrib2"]) ?? 0;
      cust.attrib3 = int.tryParse(data["attrib3"]) ?? 0;
      cust.attrib4 = int.tryParse(data["attrib4"]) ?? 0;
      cust.attrib5 = int.tryParse(data["attrib5"]) ?? 0;
      cust.attrib6 = int.tryParse(data["attrib6"]) ?? 0;
      cust.attrib7 = int.tryParse(data["attrib7"]) ?? 0;
      cust.attrib8 = int.tryParse(data["attrib8"]) ?? 0;
      cust.attrib9 = int.tryParse(data["attrib9"]) ?? 0;
      cust.attrib10 = int.tryParse(data["attrib10"]) ?? 0;
      cust.mov_flg = int.tryParse(data["mov_flg"]) ?? 0;
      cust.pre_cust_no = data["pre_cust_no"];
      cust.remark = data["remark"];
      cust.ins_datetime = data["ins_datetime"];
      cust.upd_datetime = data["upd_datetime"];
      cust.status = int.tryParse(data["status"]) ?? 0;
      cust.send_flg = int.tryParse(data["send_flg"]) ?? 0;
      cust.upd_user = int.tryParse(data["upd_user"]) ?? 0;
      cust.upd_system = int.tryParse(data["upd_system"]) ?? 0;
      cust.svs_cls_cd = int.tryParse(data["svs_cls_cd"]) ?? 0;
      cust.staff_flg = int.tryParse(data["staff_flg"]) ?? 0;
      setMagMbrCd(cust, custNo);
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
        "RcMbrFlrd.rcmbrReadCustSqlExec():DB Read Err $e $s )");
      return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
    }

    if (CompileFlag.RALSE_MBRSYSTEM) {
      if (!(await RcSysChk.rcChkCustrealNecSystem(0))) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          atSing.mbrTyp = Mcd.MCD_RLSSTAFF;
        }
      }
    }
    if (cBuf.dbTrm.coopYamaguchiGreenStamp != 0) {
      return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
    } else if ((await CmCksys.cmMoriyaMemberSystem() != 0) &&
        (cBuf.dbTrm.otherPanaCardFlg != 0)) {
      /* フレスコキクチ向けは、基本他店会員 */
      return DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
    }

    return Typ.NORMAL;
  }

  /// 顧客マスタ読み込み用のSQL文を作成する
  /// 引数: 電話番号
  /// 戻り値: SQL文
  /// 関連tprxソース: rcmbrflrd.c - MakeCustMstSql
  static Future<String> makeCustMstSql(String telNo) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return "";
    }
    RxCommonBuf cBuf = xRet.object;

    String ret = "";
    String chkCode = "";
    if (cBuf.dbTrm.memBcdTyp == 1) {
      /* 8桁バーコード */
      chkCode = "~'^00000'";
    } else if (await CmCksys.cmSm36SanprazaSystem() != 0) {
      chkCode = "~'^00000'";
    } else {
      /* 13桁バーコード */
      chkCode = "!~'^00000'";
    }

    if (await CmCksys.cmZHQSystem() != 0) {
      if (cBuf.dbTrm.seikatsuclubOpe != 0) {
        ret = "SELECT * FROM c_cust_mst WHERE cust_status <> 2 AND srch_telno = '$telNo' AND cust_no $chkCode ORDER BY cust_no";
      } else {
        ret = "SELECT * FROM c_cust_mst WHERE srch_telno = '$telNo' AND cust_no $chkCode ORDER BY cust_no";
      }
    } else {
      if (cBuf.dbTrm.seikatsuclubOpe != 0) {
        ret = "SELECT * FROM c_cust_mst WHERE cust_status <> 2 AND tel_no1 = '$telNo' AND cust_no $chkCode ORDER BY cust_no";
      } else {
        if ((CmCksys.cmRm5900System() != 0) && RcDepoInPlu.rcChkDepoBtlMbrInpMode()) {
          ret = "SELECT * FROM c_cust_mst WHERE tel_no1 ~ '$telNo' AND cust_no $chkCode ORDER BY cust_no LIMIT 100";
        } else {
          ret = "SELECT * FROM c_cust_mst WHERE tel_no1 = '$telNo' AND cust_no $chkCode ORDER BY cust_no";
        }
      }
    }
    return ret;
  }

  /// 顧客問合せテーブル読み込み
  /// 引数:[rcvret] 当関数呼出前のエラーメッセージNo
  /// 引数:[member] 会員入力方法
  /// 戻り値: エラーメッセージNo
  /// ※下記テーブルデータは、当クラスのstatic変数より取得すること
  ///   RcMbrFlrd.cust: 顧客マスタ (c_cust_mst)
  ///   RcMbrFlrd.enq: 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  ///   RcMbrFlrd.svs: プロモーションスケジュールマスタ (p_promsch_mst)
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustCustEnqDataRd
  static Future<int> rcmbrReadCustCustEnqDataRd(int rcvret, int member) async {
    int ret = 0;
    RegsMem mem = SystemFunc.readRegsMem();
    PPromschMst retSvs = PPromschMst();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMbrFlrd.rcmbrReadCustCustEnqDataRd(): Read Cust Enq Read");
    if (CompileFlag.RALSE_MBRSYSTEM && RcSysChk.rcChkRalseCardSystem()) {
      /* サービス分類マスタ読み込み */
      (ret, retSvs) = await rcmbrReadCustSvs(cust.svs_cls_cd!);
      if (ret != Typ.NORMAL) {
        return ret;
      }
      svs = retSvs;
      ret = await rcmbrReadCustChargeMst(cust.cust_no!, cust);
      if (ret != Typ.NORMAL) {
        return ret;
      }
      /* 顧客問合せテーブル読み込み */
      if (CompileFlag.SIMS_CUST && (mem.tTtllog.t100700.otherStoreMbr != 2)) {
        await rcmbrReadCustEnq(cust.cust_no!, "");
      } else {
        await rcmbrReadCustEnq(cust.cust_no!, "");
      }
    } else {
      if (CompileFlag.ARCS_MBR) {
        await rcmbrReadCustEnq(cust.cust_no!, "");
      }
    }

    if (RcSysChk.rcChkCustrealPointInfinitySystem() ||
        RcSysChk.rcChkCustrealFrestaSystem() ||
        RcSysChk.rcChkCosme1IstyleSystem() ||
        (RcSysChk.rcChkSm74OzekiSystem() &&
            (await CmCksys.cmCustrealHpsSystem() != 0)) ) {
      enqParent = enq;
    }

    return Typ.NORMAL;
  }

  /// 掛売マスタ（顧客マスタ）マスタ読み込み (c_cust_mst)
  /// 引数:[custNo] 顧客番号
  /// 引数:[cust] 顧客マスタ (c_cust_mst)
  /// 戻り値: NORMAL=正常終了 / MSG_SVSCLSNONFILE=データなし
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCust_ChargeMst
  static Future<int> rcmbrReadCustChargeMst(String custNo, CCustMstColumns cust) async {
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();

    atSing.chargeSlipFlg = 0;
    if (!(await RcSysChk.rcChkChargeSlipSystem())) {
      return Typ.NORMAL;
    }
    if (RcFncChk.rcCheckScanCheck()) {
      return Typ.NORMAL;
    }
    if (RcSysChk.rcTROpeModeChk() && !RcSysChk.rcsyschkAyahaSystem()) {
      if (custNo.substring(0, 7) == "7000001") {
        atSing.chargeSlipFlg = 1;
        mem.prnrBuf.chargeSlipFlg = 1;
      }
      return Typ.NORMAL;
    }
    if ((custNo == "") || (custNo.length != 13)) {
      return Typ.NORMAL;  /* 会員Ｎｏ．ミス */
    }
    if (RcSysChk.rcsyschkAyahaSystem()) {
      // TODO:10155 顧客呼出 実装対象外
      /*
      if (rcfncchk_ayaha_mbr_divi_get(mem.tTtllog.t100700.svsClsCd) == 7) {
        /* 700000～799999は売掛会員  */
        mem.prnrBuf.chargeSlipFlg = 1;
      } else {
        mem.prnrBuf.chargeSlipFlg = 0;	/* 念のため０クリア */
      }
      return Typ.NORMAL;
       */
    }
    if (custNo.substring(0, 7) == "7000001") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrReadCustChargeMst(): cust_no is not Charge cust");
      return Typ.NORMAL;  /* 掛売会員ではありません */
    }

    String sql = "";
    if ((custNo != "") && (custNo.length > 0)) {
      sql = "SELECT * FROM c_cust_mst WHERE cust_no = '$custNo'";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, sql);
    } else {
      return DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId;  /*会員Ｎｏ．ミス */
    }

    DbManipulationPs db = DbManipulationPs();
    Result dbRes;
    int status = 0;

    try {
      /* データベース読み込み */
      dbRes = await db.dbCon.execute(sql);
      if (dbRes.affectedRows == 0) {  /* ０件 */
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;	 /* 会員は存在しません */
      }
      Map<String, dynamic> data = dbRes.first.toColumnMap();
      status = int.tryParse(data["cust_status"]) ?? 0;	/* 会員状態をチェック */
      if (status == 2) {  /* 2:退会 */
        return DlgConfirmMsgKind.MSG_CHARGE_SLIP_MBR_NG.dlgId;	/* お取扱いできません。\n本社に確認してください。 */
      }
      /* メモリにデータを書き込み */
      cust.kana_last_name = data["kana_last_name"];
      cust.kana_first_name = data["kana_first_name"];
      cust.post_no = data["post_no"];
      cust.address1 = data["address1"];
      cust.address2 = data["address2"];
      cust.address3 = data["address3"];
      cust.tel_no2 = data["tel_no2"];
      cust.cust_status = int.tryParse(data["cust_status"]) ?? 0;
    } catch (e, s) {  /* SQLがエラー */
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "RcMbrFlrd.rcmbrReadCustSqlExec():DB Read Err $e $s )");
      return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;	 /* 会員は存在しません */
    }

    return Typ.NORMAL;
  }

  /// データサーバーからデータを取得する
  /// 引数: 会員番号
  /// 戻り値: エラーダイアログNo
  // ・会員番号、ステータス(入力番号との整合を判定出来る)、累積ポイントは取得可能
  // ・curlコマンドのIPアドレスは、メンテナンスメニューで設定した値を取得する
  //  （メンテナンス->ネットワーク->リアル顧客(NEC)接続 接続先URLの設定値）
  static Future<int> rcmbrGetServerData(String custNo) async {
    cust.cust_no = custNo; //暫定

    // TODO:10155 顧客呼出 - NECサーバーとの通信が確定するまでコメント化
    /*
    CustrealNec custrealNecSocketClient = CustrealNec();
    final mbrData = RxSocket();
    RxSocket response;
    String data1 = 'FCSP0009';
    String data2  = 'FCSP0001,,,,,,,,,,,,,,${custNo.padLeft(16, "0")}';

    // ソケット通信 - 疎通確認
    mbrData.data = data1;
    mbrData.order = RcCustrealNec.ORDER_NEC_REQUEST;
    response = await custrealNecSocketClient.socketMain(mbrData);
    if (response.errNo != 0 || response.data.isEmpty) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "getMbrPoint():socket connect error");
      return false;
    }

    // ソケット通信開始 - シニア/非シニア会員 確認
    mbrData.data = data2;
    mbrData.order = RcCustrealNec.ORDER_NEC_REQUEST;
    response = await custrealNecSocketClient.socketMain(mbrData);
    if (response.data.isNotEmpty) {
      List<String> resList = response.data.split('%2C');
      if (resList[15] != "N000000000") {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "chkMbrSenior():get memberData error");
        return false;
      }
      // 応答電文確認
      String preliminaryItems = resList[37]; // 予備項目A1(応答電文)
      if ((int.tryParse(resList[36]) == 1) &&
          (preliminaryItems.substring(0, 2) == "01") &&
          (preliminaryItems.substring(2, 3) == "1") &&
          (preliminaryItems.substring(4, 5) == "1") &&
          (preliminaryItems.substring(5, 9) != "0000")) {
        return true;
      }else{
        return false;
      }
    } else {
      // TODO:顧客管理サーバーから取得できなかった場合は、シニア割引機能の中で判定を行う（未実装）
      return false;
    }
     */

    // TODO:10155 顧客呼出 - 暫定サーバー処理。NECサーバー通信確定時、下記処理は削除する
    // サーバーからデータを取得
    String data = 'DATA=FCSP0001,,,,,,,,,,,,,,${custNo.padLeft(16, "0")}';
    ProcessResult procResult = await Process.run('curl',['${jsonFile.nec.url}?$data']);
    String srvRcv = procResult.stdout.toString();
    if (srvRcv.isEmpty) {
      return DlgConfirmMsgKind.MSG_MBRDATA_FAILED.dlgId;
    }

    // 取得データのチェック＆格納
    debugPrint('********** 実機調査ログ（会員呼出）9-2: RcMbrFlrd.rcmbrReadCustEnq(${cust.cust_no!}, $srvRcv) スタート地点');
    int ret = await rcmbrReadCustEnq(cust.cust_no, srvRcv);

    return ret;
  }

  /// データサーバから取得したデータを格納する
  /// 引数:[custNo] 会員番号
  /// 引数:[svrRcv] 疑似サーバーから取得したデータ
  /// 戻り値: エラーメッセージNo
  /// ※下記テーブルデータは、当クラスのstatic変数より取得すること
  ///   RcMbrFlrd.enq: 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustEnq
  static Future<int> rcmbrReadCustEnq(String? custNo, String strRcv) async {
    // TODO:10155 顧客呼出 - 疑似サーバー対応のため、入力値チェックを追加
    if (custNo == null) {
      return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return Typ.NORMAL;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    if (strRcv == "") {  //疑似サーバーアドレス未設定
      // TODO:10155 顧客呼出 - ARCS向けはローカルDBがないため、エラーを返す
      return DlgConfirmMsgKind.MSG_MBRDATA_FAILED.dlgId;
      /*
      /* データベース読み込み */
      DbManipulationPs db = DbManipulationPs();
      Result dbRes;
      String sql = "SELECT * FROM s_cust_ttl_tbl WHERE comp_cd = '${cBuf.dbRegCtrl
          .compCd}' and cust_no = '$custNo'";
      try {
        cust.cust_no = custNo;
        dbRes = await db.dbCon.execute(sql);
        if (dbRes.affectedRows == 0) {
          return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
        }
        else {
          Map<String, dynamic> data = dbRes.first.toColumnMap();
          enq.cust_no = custNo;
          enq.acct_cd_1 = int.tryParse(data["acct_cd_1"]) ?? 0;
          enq.acct_totalpnt_1 = int.tryParse(data["acct_totalpnt_1"]) ?? 0;
          enq.acct_cd_2 = int.tryParse(data["acct_cd_2"]) ?? 0;
          enq.acct_totalpnt_2 = int.tryParse(data["acct_totalpnt_2"]) ?? 0;
          enq.acct_cd_3 = int.tryParse(data["acct_cd_3"]) ?? 0;
          enq.acct_totalpnt_3 = int.tryParse(data["acct_totalpnt_3"]) ?? 0;
          enq.acct_cd_4 = int.tryParse(data["acct_cd_4"]) ?? 0;
          enq.acct_totalpnt_4 = int.tryParse(data["acct_totalpnt_4"]) ?? 0;
          enq.acct_cd_5 = int.tryParse(data["acct_cd_5"]) ?? 0;
          enq.acct_totalpnt_5 = int.tryParse(data["acct_totalpnt_5"]) ?? 0;
        }
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "RcMbrFlrd.rcmbrReadCustEnq():DB Read Err $e $s");
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
       */
    }
    else {  //疑似サーバーアドレス設定あり
      List<String> resList = strRcv.split('%2C');
      if (resList[15] != "N000000000") {
        rcdStatus = false;
        return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
      rcdStatus = true;
      ttlPoint = int.tryParse(resList[21]) ?? 0;
      seniorFlg = false;
      if ((int.tryParse(resList[36]) == 1) && resList[37].isNotEmpty) {
        String preliminaryItems = resList[37]; // 予備項目A1(応答電文)
        if ((preliminaryItems.length >= 9) &&
            (preliminaryItems.substring(0, 2) == "01") &&
            (preliminaryItems.substring(2, 3) == "1") &&
            (preliminaryItems.substring(4, 5) == "1") &&
            (preliminaryItems.substring(5, 9) != "0000")) {
          seniorFlg = true;
        }
      }
      cardType = atSing.mbrTyp;
    }

    return Typ.NORMAL;
  }

  /// メモリに顧客マスタ、顧客問い合わせテーブル、サービス分類マスタのデータを書き込む
  /// 引数:[member] 会員入力方法
  /// 戻り値: 0固定
  /// 関連tprxソース: rcmbrflrd.c - Set_CustData
  static Future<int> setCustData(int member) async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    int i = 0;

    cMem.ent.errNo = Typ.NORMAL;
    if (!((await RcFncChk.rcCheckESVoidSMode()) ||
          (await RcFncChk.rcCheckEVoidMode()) ||
          (await RcFncChk.rcCheckESVoidIMode()) ) ) {
      if ((!ReptEjConf.rcCheckRegistration()) &&
          !RcFncChk.rcCheckScanCheck()) {
        // 登録開始時刻セット
        await RcSet.rcSetStartTime(await RcSysChk.getTid(), 1);
      }
      RcItmSet.rcSetInitData(FuncKey.KY_MBR.keyId);
    }

    if (RcFncChk.rcCheckScanCheck()) {
      if (await CmCksys.cmIchiyamaMartSystem() != 0) {
        for (i=0; i<CmMbrSys.cmMagcdLen()-1; i++) {
          if ((cust.cust_no!.substring(i, i+1) == ' ') ||
              (cust.cust_no!.length < i)) {
            break;
          }
        }
        atSing.scanchkMbr.custNo = " ".padLeft(CmMbrSys.cmMagcdLen()-i, " ");
        atSing.scanchkMbr.custNo += cust.cust_no!.substring(0, i);
      } else {
        atSing.scanchkMbr.custNo = cust.cust_no ?? "";
      }
      atSing.scanchkMbr.name = "${cust.last_name} ${cust.first_name}";
      if (enqParent.cust_no!.isNotEmpty) {
        atSing.scanchkMbr.totalBuyRslt = enqParent.n_data1;
        atSing.scanchkMbr.totalPoint = enqParent.n_data2;
        atSing.scanchkMbr.anyprcTermMny = enqParent.n_data6;
        atSing.scanchkMbr.fspLvl = enqParent.s_data2;
      } else {
        // TODO 売価チェック時のENQの項目は変更
        if (CmCksys.cmMmSystem() == 0) {
          if (await CmCksys.cmWsSystem() != 0)	{
            // とりあえず分かっている範囲(仕様によってはこちらに入ると思われる)
            atSing.scanchkMbr.totalBuyRslt = enq.n_data1;
            atSing.scanchkMbr.totalPoint = enq.n_data2 + enq.n_data3;
          } else {
            atSing.scanchkMbr.totalBuyRslt = mem.custTtlTbl.ttl_amt;
            atSing.scanchkMbr.totalPoint = mem.custTtlTbl.acct_totalpnt_1;
          }
        } else {
          atSing.scanchkMbr.totalBuyRslt = enq.ttl_amt;
          atSing.scanchkMbr.totalPoint = enq.acct_totalpnt_1;
        }
        atSing.scanchkMbr.anyprcTermMny = enq.n_data6;
        atSing.scanchkMbr.fspLvl = enq.s_data2;
      }
    } else {
      mem.tTtllog.t100700.mbrInput = member;
      mem.tTtllog.t100700Sts.msMbrSys = 0x01;
      if (CompileFlag.CUSTREALSVR) {
        if (RcSysChk.rcChkMbrRCPdscSystem()) {
          rcRcpdscMbrTypSet(cust.cust_no!);
        }
      }
      if (CompileFlag.RALSE_MBRSYSTEM) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          mem.tTtllog.t100700Sts.mbrTyp = atSing.mbrTyp;
        }
      }
      cMem.custData.cust = cust;
      cMem.custData.enq = enq;
      if (enqParent.cust_no != null) {
        cMem.custData.enqParent = enqParent;
      } else {
        cMem.custData.enqParent = enq;
      }
      cMem.custData.svsCls = svs;
      if (await CmCksys.cmZHQSystem() == 0) {
        rcmbrReadSetCustSvs(svs);
      }

      // 顧客番号変換仕様
      if (await CmCksys.cmCssEhimedensanSystem() != 0 ) {
        if (cust.mail_addr!.length == 5) {
          // NW付の顧客コードを保存しておく.
          String temp = cust.cust_no!.substring(4, 12);
          mem.tTtllog.t100700Sts.orgNw7Code = "${cust.mail_addr}$temp";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "RcMbrFlrd.setCustData(): cust[${cust.cust_no}] org[${mem.tTtllog.t100700Sts.orgNw7Code}]");
        }
      }
    }

    return Typ.NORMAL;
  }

  /// mag_mbr_cdをセットする
  /// (旧Verのshot_cust_noがなくなったため代わりの処理、基本の処理は変えていない)
  /// 引数:[cust] 顧客マスタ (c_cust_mst)
  /// 引数:[custNo] 会員番号
  /// 関連tprxソース: rcmbrflrd.c - rcmbrflrd_Set_mag_mbr_cd
  static void setMagMbrCd(CCustMstColumns cust, String custNo) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RegsMem mem = SystemFunc.readRegsMem();
    int formatNo = 0;
    int sa = 0;
    int tmpLen = 0;

    mem.tTtllog.t100700.magMbrCd = "";
    if (cBuf.dbTrm.memBcdTyp != 1)	{
      /* Member type 13digit */
      tmpLen = CmMbrSys.cmMbrcdLen() - CmMbrSys.cmMagcdLen();
      if (CmMbrSys.cmMbrcdLen() > CmMbrSys.cmMagcdLen()) {
        mem.tTtllog.t100700.magMbrCd = cust.cust_no!.substring(tmpLen, tmpLen + CmMbrSys.cmMagcdLen());
      } else {
        mem.tTtllog.t100700.magMbrCd = cust.cust_no!.substring(0, CmMbrSys.cmMbrcdLen());
      }
    } else {
      /* Member type 8digit  */
      mem.tTtllog.t100700.magMbrCd = "0".padLeft(CmMbrSys.cmMagcdLen(), "0");
      for (int idx = 0; idx < RxMem.DB_INSTRE_MAX; idx++) {
        if (cBuf.dbInstre[idx].format_typ == Mcd.FMT_TYP_MBR) {
          formatNo = cBuf.dbInstre[idx].format_no;
          break;
        }
      }
      if (CmMbrSys.cmMagcdLen() > Mcd.ASC_MCD_CD) {
        sa = CmMbrSys.cmMagcdLen() - Mcd.ASC_MCD_CD;
      }
      if (formatNo == Mcd.FMT_NO_MBR8) {
        mem.tTtllog.t100700.magMbrCd =
            mem.tTtllog.t100700.magMbrCd.substring(0, (3+sa)) +
                cust.cust_no!.substring(7) +
                mem.tTtllog.t100700.magMbrCd.substring(8+sa);
      } else {
        mem.tTtllog.t100700.magMbrCd = cust.cust_no!.substring(6) +
            mem.tTtllog.t100700.magMbrCd.substring(6);
      }
    }
  }

  /// 会員フラグを設定する
  /// 引数:[custNo] 顧客番号
  /// 関連tprxソース: rcmbrflrd.c - rc_rcpdscMbrTypSet
  static void rcRcpdscMbrTypSet(String custNo) {
    RegsMem mem = SystemFunc.readRegsMem();
    if (RcMbrCom.rcChkMemberRCpdsc(custNo)) {
      if (RcFncChk.rcCheckRegistration()) {
        mem.tTtllog.t100700Sts.mbrTyp |= 2;
      } else {
        mem.tTtllog.t100700Sts.mbrTyp = 2;
      }
    } else if (RcMbrCom.rcChkMemberStaffpdsc(custNo)) {
      if (RcFncChk.rcCheckRegistration()) {
        mem.tTtllog.t100700Sts.mbrTyp |= 1;
      } else {
        mem.tTtllog.t100700Sts.mbrTyp = 1;
      }
    } else {
      if (RcFncChk.rcCheckRegistration()) {
        mem.tTtllog.t100700Sts.mbrTyp |= 4;
      } else {
        mem.tTtllog.t100700Sts.mbrTyp = 4;
      }
    }
    if (RcFncChk.rcCheckRegistration()) {
      RcMbrCom.rcMbrMemberClsPDscSet();
    }
  }

  /// エラーメッセージNoをセットする
  /// 引数:[rcvret] メッセージNo
  /// 引数:[custNo] 顧客No
  /// 戻り値: エラーメッセージNo
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadErrMsgSet
  static Future<int> errMsgSet(int rcvret, String custNo) async {
    int ret = rcvret;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ret;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    if (ret != Typ.NORMAL) {
      if (CompileFlag.RALSE_MBRSYSTEM && RcSysChk.rcChkRalseCardSystem()) {
        if (CompileFlag.ARCS_MBR) {
          if (ret != DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId) {
            if (atSing.mbrTyp != Mcd.MCD_RLSSTAFF) {
              if (atSing.mbrTyp == 0) {
                atSing.mbrTyp = Mcd.MCD_RLSCARD;
              }
            }
            ret = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
          }
        }
      } else {
        /* 自店他店会員形式 Store and others store member form  */
        if ((custNo != "") && (cBuf.dbTrm.memUseTyp == 2)) {
          if (await CmCksys.cmDcmpointSystem() != 0) {
            if ((await RcFncChk.rcCheckBuyAddMode()) ||
                (await RcFncChk.rcCheckTcktIssuMode())) {
              if (Cmmcdchk.cmMcdCheckTS3(custNo) != TS3.TS3_DAIKI_MBR_CRDT.value) {
                ret = DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
              }
            } else {
              ret = DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
            }
          } else {
            ret = DlgConfirmMsgKind.MSG_OTHERMBR.dlgId;
          }
        }
      }
    }

    return ret;
  }

  /// 顧客エラーメッセージNoをセットする
  /// 引数:[rcvret] メッセージNo
  /// 引数:[cust] 顧客マスタ (c_cust_mst)
  /// 戻り値: エラーメッセージNo
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustCustErrMsgSet
  static int custErrMsgSet(int rcvret, CCustMstColumns cust) {
    int ret = rcvret;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ret;
    }
    RxCommonBuf cBuf = xRet.object;

    /* 会員状態(cust_status)の判断 */
    if (cust.cust_status == 2) {
      if (RcSysChk.rcChkPalCoopWithdrawalSystem()) {
        return ret;
      }
      if (RcSysChk.rcChkSm74OzekiSystem()) {
        ret = DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId;
      } else {
        ret = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
      }
    } else if (cust.cust_status == 1) {
      if (cBuf.dbTrm.errorSleepMbr != 0) {
        if (cBuf.dbTrm.seikatsuclubOpe != 0) {
          ret = DlgConfirmMsgKind.MSG_UNIONSTOP.dlgId;
        } else {
          ret = DlgConfirmMsgKind.MSG_MBRSTOP.dlgId;
        }
      }
    } else if (cust.cust_status == 4) {
      if (cBuf.dbTrm.seikatsuclubOpe != 0) {
        ret = DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId;
      }
    }

    return ret;
  }

  /// [Ralseカード仕様] 顧客エラーメッセージNoをセットする
  /// 引数: メッセージNo
  /// 戻り値: エラーメッセージNo
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustCustRlsErrMsgSet
  static Future<int> custRlsErrMsgSet(int rcvret) async {
    int ret = rcvret;
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();

    if (RcSysChk.rcChkRalseCardSystem()) {
      if (ret == DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId) {
        if (CompileFlag.ARCS_MBR) {
          if (atSing.mbrTyp != Mcd.MCD_RLSSTAFF) {
            ret = DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
          } else {
            ret = DlgConfirmMsgKind.MSG_RLSSTAFFNOLIST.dlgId;
          }
        } else {
          ret = DlgConfirmMsgKind.MSG_RLSSTAFFNOLIST.dlgId;
        }
      } else if (ret == DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId) {
        ret = DlgConfirmMsgKind.MSG_CARD_ERR_CHG_CARD.dlgId;
      } else {
        if ((ReptEjConf.rcCheckRegistration()) &&
            (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index)) {
          switch (mem.tTtllog.t100700Sts.mbrTyp) {
            case Mcd.MCD_RLSSTAFF:
              if (atSing.mbrTyp != mem.tTtllog.t100700Sts.mbrTyp)
                ret = DlgConfirmMsgKind.MSG_CALL_RLSSTAFF.dlgId;
              break;
            case Mcd.MCD_RLSCARD:
            case Mcd.MCD_RLSVISA:
            case Mcd.MCD_RLSCRDT:
              if ((Mcd.MCD_RLSCARD != atSing.mbrTyp) &&
                  (Mcd.MCD_RLSVISA != atSing.mbrTyp) &&
                  (Mcd.MCD_RLSCRDT != atSing.mbrTyp) )
                ret = DlgConfirmMsgKind.MSG_CALL_RLSMBR.dlgId;
              break;
            case Mcd.MCD_RLSOTHER:
              if (atSing.mbrTyp != mem.tTtllog.t100700Sts.mbrTyp)
                ret = DlgConfirmMsgKind.MSG_CALL_RLSSTAFF.dlgId;
              break;
            default:
              break;
          }
        }
      }
    } else if (await CmCksys.cmPointartistConect() == CmSys.PARTIST_SOCKET) {
      if ((await RcFncChk.rcCheckBuyAddMode()) &&
          (mem.tTtllog.t100700.realCustsrvFlg != 0)) {
        if (ret == DlgConfirmMsgKind.MSG_OTHERUSE_MBR.dlgId) {
          ret = DlgConfirmMsgKind.MSG_CUSTOTHUSE.dlgId;
        } else {
          ret = DlgConfirmMsgKind.MSG_CUSTREALSVR_COM_ERR.dlgId;
        }
      }
    }

    return ret;

  }

  /// サービス分類スケジュール情報をセットする
  /// 引数: プロモーションスケジュールマスタ (p_promsch_mst)
  /// 関連tprxソース: rcmbrflrd.c - rcmbrRead_SetCustSvs
  static void rcmbrReadSetCustSvs(PPromschMst inSvs) {
    RegsMem mem = SystemFunc.readRegsMem();

    mem.tTtllog.t102501.planCd = inSvs.plan_cd ?? "";
    mem.tTtllog.t102501.svsClsCd = inSvs.item_cd ?? "";
    mem.tTtllog.t102501.svsClsSchCd	= inSvs.prom_cd ?? 0;
    mem.tTtllog.t102501.pointAddMemTyp = inSvs.point_add_mem_typ;
    mem.tTtllog.t102501.pointAddMagn = inSvs.point_add_magn ?? 0;
    mem.tTtllog.t102501.acctCd = inSvs.acct_cd;
    mem.tTtllog.t102501Sts.pointAddMagn = inSvs.point_add_magn ?? 0;
    mem.tTtllog.t102501Sts.pointAddMemTyp = inSvs.point_add_mem_typ;
    mem.tTtllog.t102501Sts.acctCd = inSvs.acct_cd;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客情報_実機ログ未出力）
  /// アヤハディオ様仕様会員別スケジュール情報のリード
  /// 引数:[pluCd] 商品コード
  /// 引数:[price] 単価
  /// 引数:[brgnSch] 読み込みバッファのポインタ(プロモーションスケジュールマスタ)
  /// 引数:[brgnItem] 読み込みバッファのポインタ(商品ポイント加算商品マスタ)
  /// 引数:[pluItem] 読み込みバッファのポインタ(特売商品マスタ)
  /// 戻値: 0=正常終了  MSG_NONFILE=データなし
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadAyahaItmSch
  static int rcmbrReadAyahaItmSch(String pluCd, int price, PPromschMst brgnSch,
      PBrgnitemMst brgnItem, CPluitemMst pluItem) {
    return 0;
  }

  /// 顧客サーバー接続で使用する通信タイプを判別する
  /// 戻り値: true=curl  false=sql
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_Chk_DataTranSys
  static Future<bool> rcmbrChkDataTranSys() async {
    // 外部接続仕様である
    if (rcmbrChkDataTranSysExtSvr() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSys(): [false] external server");
      return false;
    }

    if (CmCksys.cmMmSystem() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSys(): M/S system active, using SQL");
      return false;
    }

    // TS仕様シェル実行 IP設定が /etc/hosts にない
    String ipAddr = HostFileControl.getHostByNameStr("tswebsvr");
    if (ipAddr == "") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSys(): failed to obtain curl server IP, using SQL");
      return false;
    }
    // TS仕様シェル実行 IP設定が "0.0.0.0"である
    if (ipAddr == "0.0.0.0") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSys(): IP of curl server not set, using SQL");
      return false;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMbrFlrd.rcmbrChkDataTranSys(): system configuration set for curl connection, using curl");

    return true;
  }

  /// 顧客サーバー接続で仕様する通信タイプを判別する
  /// 戻り値: true=curl  false=sql
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_Chk_DataTranSys_DS2
  static Future<bool> rcmbrChkDataTranSysDS2() async {
    // 外部接続仕様である
    if (rcmbrChkDataTranSysExtSvr() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysDS2(): [false] external server");
      return false;
    }
    // M/S仕様である
    if (CmCksys.cmMmSystem() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysDS2(): M/S system active, using SQL");
      return false;
    }
    // 特定WS仕様である
    if (await CmCksys.cmWsSystem() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysDS2(): cm_ws_system active");
      return false;
    }
    // 顧客サーバー IP設定が /etc/hosts にない
    String ipAddr = HostFileControl.getHostByNameStr("cust_reserve_svr");
    if (ipAddr == "") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysDS2(): failed to obtain curl server IP");
      return false;
    }
    // 顧客サーバー IP設定が "0.0.0.0"である
    if (ipAddr == "0.0.0.0") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysDS2(): IP of curl server not set");
      return false;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMbrFlrd.rcmbrChkDataTranSysDS2(): system configuration set for curl connection, using curl");

    return true;
  }

  /// 1ver標準のTS顧客仕様か判定する
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_Chk_DataTranSys_TsStd
  static Future<bool> rcmbrChkDataTranSysTsStd() async {
    // 外部接続仕様である
    if (rcmbrChkDataTranSysExtSvr() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysTsStd(): [false] external server");
      return false;
    }
    // M/S仕様である
    if (CmCksys.cmMmSystem() != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysTsStd(): M/S system active, using SQL");
      return false;
    }

    // 既存のユーザーは除く
    if ((await CmCksys.cmWsSystem() != 0)
        || (await CmCksys.cmDs2GodaiSystem() != 0)
        || (await CmCksys.cmZHQSystem() != 0)
        || RcSysChk.rcChkCustrealFrestaSystem()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysTsStd(): user recog active");
      return false;
    }
    // 顧客サーバーIP設定ある場合は除く
    if (await rcmbrChkDataTranSysDS2()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysTsStd(): rcmbr_Chk_DataTranSys_DS2");
      return false;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMbrFlrd.rcmbrChkDataTranSysTsStd(): system configuration set for curl connection, using curl");

    return true;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 外部会員サーバー接続仕様であるか判定する
  /// 戻り値: 0=上記仕様でない   0以外=上記仕様
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_Chk_DataTranSys_ExtSvr
  static int rcmbrChkDataTranSysExtSvr() {
    return 0;
    /*
    if ((await rcmbrChkDataTranSysExtSvrU1())
        || (await rcmbrChkDataTranSysExtSvrCRM())) {
      return true;
    }
    return false;
     */
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 外部会員サーバー接続仕様(特定ユーザー1)であるか判定する
  /// 戻り値: 0=上記仕様でない   0以外=上記仕様
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_Chk_DataTranSys_ExtSvr_U1
  static int rcmbrChkDataTranSysExtSvrU1() {
    return 0;
    /*
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    // 外部会員サーバー接続設定(特定ユーザー1)でない
    if (cBuf.dbTrm.extMbrSvrCom != ExtMbrSvrTyp.EXT_MBR_SVR_U1.index) {
      return false;
    }
    // 顧客サーバー IP設定が /etc/hosts にない
    String ipAddr = HostFileControl.getHostByNameStr("cust_reserve_svr");
    if (ipAddr == "") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysExtSvrU1(): failed to obtain curl server IP");
      return false;
    }
    // 顧客サーバー IP設定が "0.0.0.0"である
    if (ipAddr == "0.0.0.0") {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "RcMbrFlrd.rcmbrChkDataTranSysExtSvrU1(): IP of curl server not set");
      return false;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcMbrFlrd.rcmbrChkDataTranSysExtSvrU1(): [true]");

    return true;
     */
  }

  /// 外部会員サーバー接続仕様(寺岡CRM)であるか判定する
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcmbrflrd.c - rcmbr_Chk_DataTranSys_ExtSvr_CRM
  static Future<bool> rcmbrChkDataTranSysExtSvrCRM() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    // 外部会員サーバー接続設定でない
    if (cBuf.dbTrm.extMbrSvrCom != ExtMbrSvrTyp.EXT_MBR_SVR_CRM.index) {
      return false;
    }
    // Details TBD
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
    "RcMbrFlrd.rcmbrChkDataTranSysExtSvrCRM(): [true]");
    return true;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客情報_実機ログ未出力）
  /// 関連tprxソース: rcmbrflrd.c - rcmbrReadCustDataSet
  static int rcmbrReadCustDataSet(int rcvRet, int member, String custNo
      , CCustMstColumns cust, SCustTtlTbl enq
      , PPromschMst svs) {
    return 0;
  }

  /// 会員上書きのために一度会員をクリアする。（会員売価キー用）
  /// ただしスタンプはクリアしない。
  /// 関連tprxソース: rcmbrflrd.c - rcmbrTmpCustDataClr
  static void rcmbrTmpCustDataClr() {
    RcStl.rcClrTtlRBufMbr(ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_ALL);
    RcStl.rcClrItmMbrData(1);
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客情報_実機ログ未出力）
  /// 他店会員データのセット
  /// 引数: 会員番号
  /// 戻り値: ダイアログNo.1072（MSG_MBRNOLIST）固定
  /// 関連tprxソース: rcmbrflrd.c - rcmbrSetOtherStoreMbr
  static int rcmbrSetOtherStoreMbr(String custNo) {
    return DlgConfirmMsgKind.MSG_MBRNOLIST.dlgId;
  }

  /// メモリに記念日種別マスタ1～記念日種別マスタ5のデータを読み込む
  /// 引数: 読み込みバッファのポインタ
  /// 戻り値: 0固定
  /// 関連tprxソース: rcmbrflrd.c - Refer_CustAnv
  static int referCustAnv(CCustMstColumns cust) {
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客情報_実機ログ未出力）
  /// スタンプカード企画マスタの有効企画読込
  /// 引数: 会員番号
  /// 関連tprxソース: rcmbrflrd.c - rcmbrRead_StpPlnMst
  static void rcmbrReadStpPlnMst(String custNo) {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客情報_実機ログ未出力）
  /// One To Oneプロモーションの企画読込(すべて)
  /// 引数: 会員番号
  /// 関連tprxソース: rcmbrflrd.c - rcmbrRead_OneToOnePromotionTbl
  static void rcmbrReadOneToOnePromotionTbl(String custNo) {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（顧客情報_実機ログ未出力）
  /// ポイントスケジュールの読込
  /// 引数: 顧客呼出の戻値
  /// 関連tprxソース: rcmbrflrd.c - rcmbrRead_PntSch
  static void rcmbrReadPntSch(int custRet) {}

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 顧客ソケット通信データのセット（ロンフレ様用）(テスト版)
  /// 引数: 顧客呼出の戻値
  /// 関連tprxソース: rcmbrflrd.c - rcMbrReal_Socket
  static void rcMbrRealSocket() {}

  /// 会員呼出済みか否か
  static bool isCalledMember() => rcdStatus;
}
