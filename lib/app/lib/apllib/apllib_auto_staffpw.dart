/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/checker/rc_clxos.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/socket/model/customer_socket_model.dart';
import 'rm_db_read.dart';

/// フルセルフ、精算機の場合の従業員登録処理
class AplLibAutoStaffPw {

  /// 従業員番号
  String _staffCd = '';
  String get staffCd => _staffCd;

  /// パスワード
  String _passwd = '';

  /// 従業員オープン
  Future<bool> openStaff(RxCommonBuf pCom) async {
    DlgConfirmMsgKind dlgConfirmMsgKind = DlgConfirmMsgKind.MSG_NONE;

    while (true) {
      // 従業員コードとパスワードを取得する
      dlgConfirmMsgKind = await _getStaffCd(pCom);
      if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
        break;
      }

      // クラウドPOS問い合わせ用のリクエスト作成
      CalcRequestStaff reqData = CalcRequestStaff(
        compCd: pCom.iniMacInfoCrpNoNo,
        streCd: pCom.iniMacInfoShopNo,
        macNo: pCom.iniMacInfoMacNo,
        staffCd: _staffCd,
        passwd: _passwd,
        scanFlag: 0,
      );

      // クラウドPOS問い合わせ
      CalcResultStaff calcResultStaff;
      if (!RcClxosCommon.validClxos) {
        calcResultStaff = CalcResultStaff(
          retSts: 0,
          errMsg: '',
          posErrCd: null,
          staffCd: null,
          staffName: null,
          menuAuthNotCodeList: null,
          keyAuthNotCodeList: null,
        );
      } else {
        calcResultStaff = await CalcApi.openStaff(reqData);
      }

      if (calcResultStaff.retSts == null || calcResultStaff.retSts != 0) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "AplLibStaffPwAuto openStaff CalcApi.openStaff error retSts=${calcResultStaff.retSts} errMsg=${calcResultStaff.errMsg}");
        MsgDialog.show(
          MsgDialog.singleButtonMsg(
            type: MsgDialogType.error,
            message: calcResultStaff.errMsg ?? 'システムエラー',
          ),
        );
        return false;
      }

      // 正常終了
      break;
    }

    if (dlgConfirmMsgKind != DlgConfirmMsgKind.MSG_NONE) {
      // 異常終了
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: dlgConfirmMsgKind.dlgId,
        ),
      );
      return false;
    }
     if (!RcClxosCommon.validClxos) {
        pCom.dbStaffopen.cshr_status = 1;
     }else{
      // DBを読みこみ直す
        await RmDBRead().rmDbStaffopenRead();
     }
    
    return true;
  }

  /// 従業員クローズ
  static Future<void> closeStaff(AutoStaffInfo autoStaffInfo) async {
    // クラウドPOS問い合わせ用のリクエスト作成
    CalcRequestStaff reqData = CalcRequestStaff(
      compCd: autoStaffInfo.compCd,
      streCd: autoStaffInfo.streCd,
      macNo: autoStaffInfo.macNo,
      staffCd: autoStaffInfo.staffCd,
    );

    // クラウドPOS問い合わせ
    CalcResultStaff calcResultStaff;
    if (!RcClxosCommon.validClxos) {
      calcResultStaff = CalcResultStaff(
        retSts: 0,
        errMsg: '',
        posErrCd: null,
        staffCd: null,
        staffName: null,
        menuAuthNotCodeList: null,
        keyAuthNotCodeList: null,
      );
    } else {
      calcResultStaff = await CalcApi.closeStaff(reqData);
    }

    if (calcResultStaff.retSts != 0) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "AplLibStaffPwAuto closStaff CalcApi.closeStaff error retSts=${calcResultStaff.retSts} errMsg=${calcResultStaff.errMsg}");
    }
  }

  /// 従業員コードとパスワードを取得する
  Future<DlgConfirmMsgKind> _getStaffCd(RxCommonBuf pCom) async {
    // レジ情報マスタに登録されている auto_opn_cshr_cd を取得するSQL
    // パスワードは従業員マスタ（c_staff_mst）に登録されれいるものを取得する
    String sql = '''
SELECT reg.auto_opn_cshr_cd, staff.passwd
 FROM c_reginfo_mst reg
 LEFT OUTER JOIN c_staff_mst staff
  ON reg.comp_cd = staff.comp_cd AND reg.auto_opn_cshr_cd = staff.staff_cd
 WHERE reg.comp_cd = ${pCom.iniMacInfoCrpNoNo} AND reg.stre_Cd = ${pCom.iniMacInfoShopNo} AND reg.mac_no = ${pCom.iniMacInfoMacNo};
''';

    // DBアクセスのインスタンス取得
    DbManipulationPs db = DbManipulationPs();

    try {
      // レジ情報グループ管理マスタから予約レポートのグループコードを取得
      Result result = await db.dbCon.execute(sql);
      if (result.isEmpty) {
        // データがありません
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "non exist data [$sql]");
        return DlgConfirmMsgKind.MSG_NONEXISTDATA;
      } else {
        // 従業員番号を取得
        String staffCd = result[0].toColumnMap()['auto_opn_cshr_cd'] ?? '';

        // 有効な従業員番号か確認する
        if (_isValidStaffCd(staffCd)) {
          // 従業員番号
          _staffCd = result[0].toColumnMap()['auto_opn_cshr_cd'] ?? '';
          // パスワード
          _passwd = result[0].toColumnMap()['passwd'] ?? '';
        } else {
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "AplLibStaffPwAuto autoOpenStaff invalid StaffCd={$staffCd}");
          return DlgConfirmMsgKind.MSG_SYSERR;
        }
      }
    } catch (e, s) {
      // ＤＢ読込エラー
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "db error [$sql]\n$e\n$s");
      return DlgConfirmMsgKind.MSG_FILEREADERR;
    }
    if (!RcClxosCommon.validClxos) {
        pCom.dbStaffopen.cshr_status = 0;
     }else{
      // DBを読みこみ直す
        await RmDBRead().rmDbStaffopenRead();
     }
    // 正常終了
    return DlgConfirmMsgKind.MSG_NONE;
  }

  /// 有効な従業員番号か確認する
  bool _isValidStaffCd(String staffCd) {
    return staffCd.isNotEmpty && staffCd != '0';
  }
}
