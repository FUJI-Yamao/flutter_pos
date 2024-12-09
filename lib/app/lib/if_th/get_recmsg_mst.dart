/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../db_library/src/db_manipulation.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_msg.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_sys/cm_cksys.dart';

class GetRecMsgMst {
  /// 関連tprxソース: get_recmsg_mst.c - get_recmsg_mst
  static Future<int> getRecmsgMst(TprTID tid, CMsgMstColumns ptRecmsg) async {
    RxCommonBuf pCom = RxCommonBuf(); /* Pointer to shared memory */
    List<MsgMstData> pComRecMsg = List<MsgMstData>.generate(DbMsgMstId.DB_MSGMST_MAX, (index) => MsgMstData()); /* Pointer to c_recmsg_mst on common memory */
    String sLogMsg;   /* Log message buffer */
    int recmsgCd;   /* receiptmessage code */
    int i; /* Loop counter */

    tid = await CmCksys.cmQCJCCPrintAid(tid);
    /* Read recmsg on common memory */
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      sLogMsg = sprintf("get_recmsg_mst : Error on rxMemPtr. ret(%d) pCOM(0x%p)", [xRet, pCom]);
      TprLog().logAdd(tid, LogLevelDefine.error, sLogMsg);
      return -1;   /* Can't read, error return */
    } else {
      pCom = xRet.object;
      pComRecMsg = pCom.dbRecMsg;   /* get regctrl memory address */
    }

    /* Search specified receipt code */
    for (i = 0; (i < DbMsgMstId.DB_MSGMST_MAX); i++) {
      recmsgCd = pComRecMsg[i].msg_cd;
      if (recmsgCd == ptRecmsg.msg_cd) {
        break;
      }
    }
    /* Check if found or not */
    if (i >= DbMsgMstId.DB_MSGMST_MAX) {
      return -1;   /* Can't read, error return */
    }

    /* Copy receipt messages from common buffer to APL buffer */
    ptRecmsg.msg_cd = pComRecMsg[i].msg_cd;
    ptRecmsg.msg_kind = pComRecMsg[i].msg_kind;
    ptRecmsg.msg_data_1 = pComRecMsg[i].msg_data_1;
    ptRecmsg.msg_data_2 = pComRecMsg[i].msg_data_2;
    ptRecmsg.msg_data_3 = pComRecMsg[i].msg_data_3;
    ptRecmsg.msg_data_4 = pComRecMsg[i].msg_data_4;
    ptRecmsg.msg_data_5 = pComRecMsg[i].msg_data_5;

    return 0;
  }
}