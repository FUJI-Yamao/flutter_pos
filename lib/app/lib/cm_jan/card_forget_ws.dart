/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
//import '../../common/cmn_sysfunc.dart';
//import '../../inc/apl/rxmem_define.dart';

class CardForgetWs{
  // /**********************************************************************
  //     関数 : cm_card_forget_ws_jan()
  //     機能 : サービス券バーコードだったら情報セットする
  //     引数 : Ji	Jan情報の構造体
  //     : flag	フラグ桁数
  //     戻値 : なし
  //  ***********************************************************************/
  ///関連tprxソース: card_forget_ws.c - cm_card_forget_ws_jan
  static void cmCardForgetWsJan(JANInf Ji,int flag){
    cmSetCardForgetWsBar(Ji);  ///  TODO:00007 梶原 中身の実装が必要

    if((Ji.flagDigit != flag) || (Ji.type != JANInfConsts.JANtypeCardforgetWs)){
      Ji.type = JANInfConsts.JANtype;
      Ji.format = 0;
      Ji.flagDigit = 0;
      Ji.flag = '';
    }
  }

  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: card_forget_ws.c - cm_set_card_forget_ws_bar
  static void cmSetCardForgetWsBar(JANInf Ji){

  }
  // static	void	cm_set_card_forget_ws_bar(JAN_inf *Ji)
  // {
  // RX_COMMON_BUF	*pCom;
  // int		i;
  //
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK)
  // {
  // return;
  // }
  //
  // Ji->Format = 0;
  // Ji->FlagDigit = (char)0;
  // memset(&Ji->Flag[0], 0x0, sizeof(Ji->Flag));
  //
  // for(i = 0; i < DB_INSTRE_MAX; i++)
  // {
  // if((pCom->db_instre[i].format_typ == JANtype_CARDFORGET_WS)
  // && (pCom->db_instre[i].format_no == JANformat_CARDFORGET_WS))
  // {
  // Ji->FlagDigit = (char)2;
  // cm_mov(&Ji->Flag[0], &Ji->Code[0], Ji->FlagDigit);
  // if(! strncmp(&Ji->Flag[0], &pCom->db_instre[i].instre_flg[0], Ji->FlagDigit))
  // {
  // Ji->Format = pCom->db_instre[i].format_no;
  // Ji->Type   = JANtype_CARDFORGET_WS;
  // }
  // else
  // {
  // Ji->FlagDigit = (char)0;
  // memset(&Ji->Flag[0], 0x0, sizeof(Ji->Flag));
  // }
  // }
  // if(Ji->Format != 0)
  // break;
  // }
  // }
}