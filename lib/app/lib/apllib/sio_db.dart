/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// SIO（DB）レコード操作
/// 関連tprxソース:sio_db.c
class SioDB {
  static const RECOG_SQL_REGCNCTSIO_EXIST	=
      "SELECT com_port_no "
      "FROM c_regcnct_sio_mst "
      "WHERE comp_cd = @comp AND stre_cd = @stre AND mac_no = @mac "
      "AND (com_port_no >= '1' AND com_port_no <= '4')";

  static const RECOG_SQL_REGCNCTSIO_READ =
      "select regcnctMst.com_port_no, regcnctMst.cnct_kind, regcnctMst.cnct_grp, "
      "sioMst.drv_sec_name, regcnctMst.sio_rate, regcnctMst.sio_stop, regcnctMst.sio_record, "
      "regcnctMst.sio_parity, regcnctMst.qcjc_flg "
      "from c_regcnct_sio_mst regcnctMst inner join c_sio_mst sioMst on (sioMst.cnct_kind = regcnctMst.cnct_kind) "
      "where regcnctMst.comp_cd = @comp and regcnctMst.stre_cd = @stre and "
      "regcnctMst.mac_no = @mac and com_port_no = @cp_no";

  static const RECOG_CMD_SET_REGCNCTSIO	=
      "psql -U postgres tpr_db -f %s/apl/db/mm_regcnct_sio.out -v COMP=%d -v STRE=%d -v MACNO=%d";


  /// レジ接続機器SIO情報マスタをチェックする
  /// 関連tprxソース:sio_db.c - sio_regcnct_db_chk()
  /// 引数:[tid] メッセージID
  /// 戻り値:true = Normal End
  ///       false = Error
  static Future<bool> sioRegcnctDbCheck(TprTID tid) async {
    TprLog().logAdd(tid, LogLevelDefine.normal, 'sioRegcnctDbCheck()');

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      TprLog().logAdd(tid, LogLevelDefine.error,
          'sioRegcnctDbCheck(): SystemFunc.rxMemRead[RXMEM_COMMON]');
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macinfo = pCom.iniMacInfo;

    JsonRet jsonRet = await macinfo.getValueWithName('system', 'macno');
    if (!jsonRet.result) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          'sioRegcnctDbCheck(): Get Json mac_info(system, macno) error: ${jsonRet
          .cause.name}');
      return false;
    }
    int macNo = jsonRet.value;

    jsonRet = await macinfo.getValueWithName('system', 'shpno');
    if (!jsonRet.result) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          'sioRegcnctDbCheck(): Get Json mac_info(system, shpno) error: ${jsonRet
          .cause.name}');
      return false;
    }
    int streCd = jsonRet.value;

    jsonRet = await macinfo.getValueWithName('system', 'crpno');
    if (!jsonRet.result) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          'sioRegcnctDbCheck(): Get Json mac_info(system, crpno) error: ${jsonRet
          .cause.name}');
      return false;
    }
    int compCd = jsonRet.value;

    if ((compCd != 0) && (streCd != 0) && (macNo != 0)) {
      try {
        // 対象レコード取得SQL実行
        var db = DbManipulationPs();
        String sql = RECOG_SQL_REGCNCTSIO_EXIST;
        Map<String, dynamic>? subValues = {
          "comp" : compCd,
          "stre" : streCd,
          "mac"  : macNo
        };


        Result dataList = await db.dbCon.execute(Sql.named(sql), parameters: subValues);
        if (dataList.isEmpty) {
          TprLog().logAdd(tid, LogLevelDefine.error,
              'sioRegcnctDbCheck(): DB error (c_regcnct_sio_mst read)');
          return false;
        }
        if (dataList.length < 4) {
          // TODO:10095 webAPI 上位サーバ連携
          TprLog().logAdd(tid, LogLevelDefine.normal,
              sprintf(RECOG_CMD_SET_REGCNCTSIO,
                  [EnvironmentData().sysHomeDir, compCd, streCd, macNo]));
        }
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "sioRegcnctDbCheck() : $e $s )");
        return false;
      }
    }

    return true;
  }
}