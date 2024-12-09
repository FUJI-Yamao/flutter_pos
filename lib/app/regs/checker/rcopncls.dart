/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/lib/apllib/qr2txt.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/opncls_lib.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_sys/cm_stf.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcfncchk.dart';
import 'rcky_stfrelease.dart';
import 'rcsyschk.dart';

class RcOpnCls {
  static const codeLen = 10;
  static const ean13Len = 13;

  static String nameBuf = "";
  static String codeBuf = "";
  static String nameSave = "";
  static String codeSave = "";

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// キャッシャークローズ
  /// 引数:[over] 従業員交代（0=従業員交代ではない  1=従業員交代）
  /// 戻値: エラーコード
  /// 関連tprxソース: rcopncls.c - rc_cshr_close()
  static int rcCshrClose(int over){
    return OK;
  }

  /// 入力された従業員コードをチェックし、従業員コードであれば外部変数に取得データを格納する
  /// （簡易従業員１人制 従業員キーで使用）
  /// 戻値: エラーコード
  /// 関連tprxソース: rcopncls.c - rcopncls_entry()
  static Future<int> entry() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcOpnCls.entry(): call");

    String entryCd = "";
    String tmpCd = "";
    String passwd = "";
    String tmpEntry = "";
    int editTyp = -1;
    int mode = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcOpnCls.entry(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RxInputBuf iBuf = RxInputBuf();

    /* get current entry data strings */
    if (atSing.inputbuf.dev == DevIn.D_OBR) {
      if (await CmCksys.cmTb1System() != 0) {
        tmpEntry = atSing.inputbuf.Acode;
      } else {
        tmpEntry = cMem.working.janInf.code;
      }
    } else if ((atSing.inputbuf.dev == DevIn.D_KEY) ||
        (atSing.inputbuf.dev == DevIn.D_TCH) ||
        (atSing.inputbuf.dev == DevIn.D_SML)) {
      if (atSing.inputbuf.Smlcode != 0) {
        if (RcFncChk.rcChkTenOn()) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcOpnCls.entry2(): rcChk_Ten_On() Error");
          return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        }
        tmpCd = Ltobcd.cmLltobcd(atSing.inputbuf.Smlcode, codeLen);
        // TODO:10124 文字コード変換（cm_bcdtoa）
        //cm_bcdtoa(entryCd, tmpCd, ean13Len, codeLen);
        editTyp = 2;
      } else if (atSing.inputbuf.Smlcode == 0) {
        if (!RcFncChk.rcChkTenOn()) {
          mode = await RcSysChk.rcChkStfMode();
          if (mode == 0) {
            return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
          } else if (mode == 1) {
            tmpCd = Ltobcd.cmLltobcd(int.parse(cBuf.dbStaffopen.cshr_cd!), codeLen);
            // TODO:10124 文字コード変換（cm_bcdtoa）
            //cm_bcdtoa(entryCd, tmpCd, ean13Len, codeLen);
            editTyp = 2;
          } else if ((mode == 2)||(mode == 3)) {
            if ((iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) ||
                (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1)) {
              tmpCd = Ltobcd.cmLltobcd(int.parse(cBuf.dbStaffopen.cshr_cd!), codeLen);
              // TODO:10124 文字コード変換（cm_bcdtoa）
              //cm_bcdtoa(entryCd, tmpCd, ean13Len, codeLen);
            } else {
              if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
                tmpCd = Ltobcd.cmLltobcd(int.parse(cBuf.dbStaffopen.cshr_cd!), codeLen);
                // TODO:10124 文字コード変換（cm_bcdtoa）
                //cm_bcdtoa(tmpEntry, tmpCd, ean13Len, codeLen);
              } else {
                tmpCd = Ltobcd.cmLltobcd(cBuf.dbStaffopen.chkr_cd!, codeLen);
                // TODO:10124 文字コード変換（cm_bcdtoa）
                //cm_bcdtoa(tmpEntry, tmpCd, ean13Len, codeLen);
              }
            }
          } else if (mode == 4) {
            tmpCd = Ltobcd.cmLltobcd(cBuf.dbStaffopen.chkr_cd!, codeLen);
            // TODO:10124 文字コード変換（cm_bcdtoa）
            //cm_bcdtoa(tmpEntry, tmpCd, ean13Len, codeLen);
          }
        } else {
          if (await CmCksys.cmTb1System() != 0) {
            tmpEntry = "";
            // TODO:10124 文字コード変換（cm_bcdtoa, rc_EntryCodeChange）
            /*
            cm_bcdtoa(tmpEntry, cMem.ent.entry, ean13Len, cMem.ent.entry.length);
            rc_EntryCodeChange(tmpEntry, entryCd);
             */
          } else {
            if (cMem.ent.tencnt > await CmStf.apllibStaffCDInputLimit(0)) {
              return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
            }
            // TODO:10124 文字コード変換（cm_bcdtoa）
            //cm_bcdtoa(entryCd, cMem.ent.entry, ean13Len, cMem.ent.entry.length);
            if (int.parse(entryCd) == 0) {
              return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
            }
            editTyp = 0;
          }
        }
      }
    } else {
      /* 自動開閉設仕様 */
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
        // TODO:10124 文字コード変換（cm_bcdtoa）
        //cm_bcdtoa(tmpEntry, cMem.ent.entry, ean13Len, cMem.ent.entry.length);
      }
    }

    String dataBuf = "";
    int tmpNo = 0;
    if (editTyp >= 0) {
      tmpEntry = "";
      (tmpEntry, tmpNo) = await CmStf.apllibStaffCdEdit(await RcSysChk.getTid(), editTyp, int.parse(entryCd), 1);
    }

    /* input code check */
    /*
    if (!cm_opncls_check_inputcode(await RcSysChk.getTid(), dataBuf, tmpEntry)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcOpnCls.entry2(): input data error");
      return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
    }
     */

    /* get staff number */
    codeBuf = dataBuf;
    OpnClsLibRet ret = await OpnClsLib.cmOpnClsReadStaff(await RcSysChk.getTid(), int.parse(codeBuf));
    if (!ret.isSuccess) {
      if (ret.errMsgId == DlgConfirmMsgKind.MSG_NONEREC.dlgId) {
        return DlgConfirmMsgKind.MSG_CLKNONFILE.dlgId;
      } else {
        return ret.errMsgId;
      }
    }

    if ((await CmCksys.cmStaffReleaseSystem() == 0) ||
        !(await RckyStfRelease.rcChkStfRelease())) {
      /* name, number back up */
      nameSave = nameBuf;
      codeSave = codeBuf;
    }

    return 0;
  }

  /// 入力された従業員コードをチェックし、従業員コードであれば外部変数に取得データを格納する
  /// （簡易従業員２人制 従業員キーで使用）
  /// 戻値: エラーコード
  /// 関連tprxソース: rcopncls.c - rcopncls_entry2()
  static Future<int> entry2() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "RcOpnCls.entry2(): call");

    String entryCd = "";
    String tmpCd = "";
    String passwd = "";
    String tmpEntry = "";
    int editTyp = -1;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcOpnCls.entry2(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    RxInputBuf iBuf = RxInputBuf();

    /* get current entry data strings */
    if (atSing.inputbuf.dev == DevIn.D_OBR) {
      if (await CmCksys.cmTb1System() != 0) {
        tmpEntry = atSing.inputbuf.Acode;
      } else {
        tmpEntry = cMem.working.janInf.code;
      }
    } else if ((atSing.inputbuf.dev == DevIn.D_KEY) ||
        (atSing.inputbuf.dev == DevIn.D_TCH) ||
        (atSing.inputbuf.dev == DevIn.D_SML)) {
      if (atSing.inputbuf.Smlcode != 0) {
        if (RcFncChk.rcChkTenOn()) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "RcOpnCls.entry2(): rcChk_Ten_On() Error");
          return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        }
        tmpCd = Ltobcd.cmLltobcd(atSing.inputbuf.Smlcode, codeLen);
        // TODO:10124 文字コード変換（cm_bcdtoa）
        //cm_bcdtoa(entryCd, tmpCd, ean13Len, sizeof(tmpCd));
        editTyp = 2;
      } else if (atSing.inputbuf.Smlcode == 0) {
        if (!RcFncChk.rcChkTenOn()) {
          if (await CmStf.cmPersonChk() == 1) {
            if (cBuf.dbStaffopen.cshr_status == 0) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                  "RcOpnCls.entry2(): one person cshr_status = 0");
              return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
            } else {
              tmpCd = Ltobcd.cmLltobcd(int.parse(cBuf.dbStaffopen.cshr_cd!), codeLen);
              // TODO:10124 文字コード変換（cm_bcdtoa）
              //cm_bcdtoa(entryCd, tmpCd, ean13Len, codeLen);
            }
            editTyp = 2;
          } else if (await CmStf.cmPersonChk() == 2) {
            if ((iBuf.devInf.devId == TprDidDef.TPRDIDTOUKEY1) ||
                (iBuf.devInf.devId == TprDidDef.TPRDIDMECKEY1) ||
                (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)) {
              if (cBuf.dbStaffopen.cshr_status == 0) {
                TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                    "RcOpnCls.entry2(): two person cshr_status = 0");
                return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
              } else {
                tmpCd = Ltobcd.cmLltobcd(int.parse(cBuf.dbStaffopen.cshr_cd!), codeLen);
                // TODO:10124 文字コード変換（cm_bcdtoa）
                //cm_bcdtoa(entryCd, tmpCd, ean13Len, codeLen);
              }
            } else {
              if (cBuf.dbStaffopen.chkr_status == 0) {
                TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                    "RcOpnCls.entry2(): two person chkr_status = 0");
                return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
              } else {
                tmpCd = Ltobcd.cmLltobcd(cBuf.dbStaffopen.chkr_cd!, codeLen);
                // TODO:10124 文字コード変換（cm_bcdtoa）
                //cm_bcdtoa(entryCd, tmpCd, ean13Len, codeLen);
              }
            }
            editTyp = 2;
          } else {
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
                "RcOpnCls.entry2(): cm_person_chk() ERROR");
          }
        } else {
          if (await CmCksys.cmTb1System() != 0) {
            tmpEntry = "";
            // TODO:10124 文字コード変換（cm_bcdtoa, rc_EntryCodeChange）
            /*
            cm_bcdtoa(tmpEntry, cMem.ent.entry, ean13Len, cMem.ent.entry.length);
            rc_EntryCodeChange(tmpEntry, entryCd);
             */
          } else {
            if (cMem.ent.tencnt > await CmStf.apllibStaffCDInputLimit(0)) {
              return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
            }
            // TODO:10124 文字コード変換（cm_bcdtoa）
            //cm_bcdtoa(entryCd, cMem.ent.entry, ean13Len, cMem.ent.entry.length);
            if (int.parse(entryCd) == 0) {
              return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
            }
            editTyp = 0;
          }
        }
      }
    } else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcOpnCls.entry2(): dev Error");
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    String dataBuf = "";
    int tmpNo = 0;
    if (editTyp >= 0) {
      tmpEntry = "";
      (tmpEntry, tmpNo) = await CmStf.apllibStaffCdEdit(await RcSysChk.getTid(), editTyp, int.parse(entryCd), 1);
    }

    /* input code check */
    /*
    if (!cm_opncls_check_inputcode(await RcSysChk.getTid(), dataBuf, tmpEntry)) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcOpnCls.entry2(): input data error");
      return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
    }
     */

    /* get staff number */
    codeBuf = dataBuf;
    OpnClsLibRet ret = await OpnClsLib.cmOpnClsReadStaff(await RcSysChk.getTid(), int.parse(codeBuf));
    if (!ret.isSuccess) {
      if (ret.errMsgId == DlgConfirmMsgKind.MSG_NONEREC.dlgId) {
        return DlgConfirmMsgKind.MSG_CLKNONFILE.dlgId;
      } else {
        return ret.errMsgId;
      }
    }

    if ((await CmCksys.cmStaffReleaseSystem() == 0) ||
        !(await RckyStfRelease.rcChkStfRelease())) {
      /* name, number back up */
      nameSave = nameBuf;
      codeSave = codeBuf;
    }

    return 0;
  }

  /// 従業員交代チェック
  /// 戻値: 0=交代あり  1=交代なし  -1=エラー
  /// 関連tprxソース: rcopncls.c - rcopncls_overopen_check()
  static Future<int> overOpenCheck() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog()
          .logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcOpnCls.overOpenCheck(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await CmCksys.cmChk2PersonSystem() == 2) {
      if (await CmStf.cmPersonChk() == 1) {
        if ((cBuf.dbStaffopen.cshr_status == 1) &&
            (codeBuf != cBuf.dbStaffopen.cshr_cd)) {
          return 0;
        } else {
          return 1;
        }
      } else if (await CmStf.cmPersonChk() == 2) {
        if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
          if ((cBuf.dbStaffopen.cshr_status == 1) &&
              (codeBuf != cBuf.dbStaffopen.cshr_cd)) {
            return 0;
          } else {
            return 1;
          }
        } else {
          if ((cBuf.dbStaffopen.chkr_status == 1) &&
              (int.parse(codeBuf) != cBuf.dbStaffopen.chkr_cd)) {
            return 0;
          } else {
            return 1;
          }
        }
      } else {
        TprLog()
            .logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RcOpnCls.overOpenCheck(): error");
      }
    } else {
      if (((cBuf.dbStaffopen.cshr_status == 1) &&
           (codeBuf != cBuf.dbStaffopen.cshr_cd)) ||
          ((cBuf.dbStaffopen.chkr_status == 1) &&
           (int.parse(codeBuf) != cBuf.dbStaffopen.chkr_cd))) {
        return 0;
      } else {
        return 1;
      }
    }
    return -1;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// チェッカーで作成したアップデートファイルを元に実績上げを行うか確認する
  ///　（print_no, receipt_noが重複するのを防ぐため）
  /// 関連tprxソース: rcopncls.c - rcCheckAfterUpdate()
  static void rcCheckAfterUpdate() {
    return;
  }
}

