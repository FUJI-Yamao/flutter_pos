/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// 関連tprxソース:tprpipe.h
///

class TprPipe {
    static const TPRPIPE_SYS = "/var/tmp/tprPipeSys";
    static const TPRPIPE_ACK = "/var/tmp/tprPipeAck";
    static const TPRPIPE_TIM = "/var/tmp/tprPipeTim";

    static const TPRPIPE_DRV = "/var/tmp/tprPipeDrv";

    static const TPRPIPE_UPS = "/var/tmp/tprPipeUPS";

    static const TPRPIPE_PRNCOM1 = "/var/tmp/tprPipePrnCom1";	/* APLから印字プロセス1 */
    static const TPRPIPE_PRNCOM2 = "/var/tmp/tprPipePrnCom2";	/* APLから印字プロセス2 */
    static const TPRPIPE_PRNCOM3 = "/var/tmp/tprPipePrnCom3";	/* APLから印字プロセス3 */
    static const TPRPIPE_PRN_RET = "/var/tmp/tprPipePrnRet";	/* DRVから印字プロセス */
}
