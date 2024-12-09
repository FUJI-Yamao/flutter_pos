/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/sys/tpr_aid.dart';
import 'package:flutter_pos/app/regs/checker/rxregmem.dart';

class RcRegMain{
  /// 関連tprxソース: rcregmain.c - rcMemGet
  static rcMemGet() async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // rxMemGet()はcmn_sysfunc.dartに実装済みだが、
    // rxInfoMemGetの呼び出しは新POSでは呼ぶタイミングが異なるためコメントアウトする。

    // rxMemGet(RXMEM_COMMON);
    // rxMemGet(RXMEM_STAT);
    // rxMemGet(RXMEM_CHK_INP);
    // rxMemGet(RXMEM_CASH_INP);
    // rxMemGet(RXMEM_UPD_RCT);
    // rxMemGet(RXMEM_PRN_RCT);
    // rxMemGet(RXMEM_QCJC_C_PRN_RCT);
    // rxMemGet(RXMEM_KITCHEN1_PRN_RCT);
    // rxMemGet(RXMEM_KITCHEN2_PRN_RCT);
    // rxMemGet(RXMEM_CHK_RCT);
    // rxMemGet(RXMEM_CHK_CASH);
    // rxMemGet(RXMEM_SOCKET);
    // rxMemGet(RXMEM_PROCINST);
    // rxMemGet(RXMEM_STPR_RCT);
    // rxMemGet(RXMEM_SOUND);
    // rxMemGet(RXMEM_SOUND2);
    // rxMemGet(RXMEM_S2PR_RCT);
    // rxMemGet(RXMEM_MNTCLT);
    // #if CN_NSC
    // rxMemGet(RXMEM_NSC_RCT);
    // #endif
    // rxMemGet(RXMEM_MP1_RCT);
    // rxMemGet(RXMEM_MULTI_STAT);
    // rxMemGet(RXMEM_CUSTREAL_SOCKET);
    // rxMemGet(RXMEM_QCCONNECT_STAT);
    // rxMemGet(RXMEM_CREDIT_SOCKET);
    // rxMemGet(RXMEM_CUSTREAL_NECSOCKET);
    // if (( cm_mail_send_system() )
    //     || ( cm_net_receipt_system() ))
    // {
    //   rxMemGet( RXMEM_DUMMY_PRN_RCT );
    // }
    await RxRegMem.rxInfoMemGet(Tpraid.TPRAID_CHK);
  }
}