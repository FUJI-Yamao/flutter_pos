/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */



///  関連tprxソース: if_aibox.c
class IfAibox {

/*-------------------------------------------------------------------------*
 *	関数: if_aibox_DrvInput()
 *	      指定データをtprdrv_aibox ドライバへ送信する
 *	引数: int    InOut
 *	      uchar  *SendData	送信データ
 *	      size_t len	送信データ長
 *	戻値: AIBOX_NORMAL	正常終了
 *	      AIBOX_ERROR		異常終了
 *-------------------------------------------------------------------------*/
  // short if_aibox_DrvInput(int src, int InOut, uchar *SendData, size_t len)
  // {
  //   tprmsgdevreq2_t	msgbuff;
  //   int		hMyPipe;
  //   int		w_length;
  //   int		ret;
  //
  //   /* Drvice No. Get */
  //   hMyPipe = TprLibFindFds(TPRDIDAIBOX1);
  //
  //   if(hMyPipe == -1)
  //   {
  //   return AIBOX_ERROR;
  // }
  //
  // /*----------------------------------*/
  // /* A requirement message is edited. */
  // /*----------------------------------*/
  // msgbuff.mid	= TPRMID_DEVREQ;
  // msgbuff.length	= sizeof(msgbuff.tid)
  // + sizeof(msgbuff.src)		/* Spec-N001 */
  // + sizeof(msgbuff.io)
  // + sizeof(msgbuff.result)
  // + sizeof(msgbuff.datalen)
  // + 2
  // + len;
  // //+ sizeof( aCmd );
  // msgbuff.src	= src;
  // msgbuff.tid	= TPRDIDAIBOX1;		/* device ID */
  // msgbuff.io	= InOut;
  // msgbuff.result	= 0;
  // msgbuff.datalen = 0;
  // msgbuff.data[0] = 0;
  // msgbuff.data[1] = len;
  // memcpy(&msgbuff.data[2], &SendData[0], sizeof(SendData[0]));
  // if(src == AIBOX_CMD_TOTAL_SEND)
  // {
  // memcpy(&msgbuff.data[3], &SendData[1], sizeof(SendData[1]));
  // }
  //
  // /* Send the request */
  // w_length = msgbuff.length + sizeof(tprcommon_t);
  // ret = write(hMyPipe, &msgbuff, w_length);
  // if(ret != w_length)
  // {
  // return AIBOX_ERROR;
  // }
  //
  // return AIBOX_NORMAL;
  //}


/*-------------------------------------------------------------------------*
 *	関数: if_aibox_Send()
 *	      APL側 AIBOXへの送信するデータをセットする
 *	引数: ステータスコード(3桁)
 *	戻値: AIBOX_NORMAL	正常
 *	      AIBOX_ERROR	異常
 *-------------------------------------------------------------------------*/
  /// 関連tprxソース: if_aibox.c - if_aibox_Send()
  static int ifAiboxSend(int code) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // size_t	len = 0;
    // short	err_cd;
    // uchar	SendBuf[32];
    //
    // memset(&SendBuf, 0x0, sizeof(SendBuf));
    // SendBuf[len++] = code;
    // err_cd = if_aibox_DrvInput(AIBOX_CMD_SEND, TPRDEVOUT, SendBuf, len);
    //
    // return err_cd;
    return 0;
  }


/*-------------------------------------------------------------------------*
 *	関数: if_aibox_Total_Send()
 *	      APL側 AIBOXへ107ステータス用の合計スキャン数を通知
 *	引数: ステータスコード(3桁)
 *	      スキャンの合計総数
 *	戻値: AIBOX_NORMAL	正常
 *	      AIBOX_ERROR	異常
 *-------------------------------------------------------------------------*/
  /// 関連tprxソース: if_aibox.c - if_aibox_Total_Send()
  static int ifAiboxTotalSend(int code, int total)
  {
    //   size_t	len = 0;
    //   short	err_cd;
    //   uchar	SendBuf[32];
    //
    //   memset(&SendBuf, 0x0, sizeof(SendBuf));
    // SendBuf[len++] = code;
    // SendBuf[len++] = total;
    // err_cd = if_aibox_DrvInput(AIBOX_CMD_TOTAL_SEND, TPRDEVOUT, SendBuf, len);
    //
    //   return err_cd;
    return 0;
  }


/*-------------------------------------------------------------------------*
 *	関数: if_aibox_Init_Reset()
 *	      リセットリクエストをtprdrv_aibox ドライバへ送信する
 *	引数: なし
 *      戻値: AIBOX_NORMAL        正常終了
 *            AIBOX_ERROR         異常終了
 *-------------------------------------------------------------------------*/
  // short if_aibox_Init_Reset(void)
  // {
  // tprmsgdevreq2_t msgbuff;
  // int		hMyPipe;
  // int		w_length;
  // int		ret;
  //
  // /* Drvice No. Get */
  // hMyPipe = TprLibFindFds(TPRDIDAIBOX1);
  //
  // if(hMyPipe == -1)
  // {
  // return AIBOX_ERROR;
  // }
  //
  // /*----------------------------------*/
  // /* A requirement message is edited. */
  // /*----------------------------------*/
  // msgbuff.mid	= TPRMID_DEVREQ;
  // msgbuff.length	= sizeof(msgbuff.tid)
  // + sizeof(msgbuff.src)		/* Spec-N001 */
  // + sizeof(msgbuff.io)
  // + sizeof(msgbuff.result)
  // + sizeof(msgbuff.datalen)
  // + 2;
  // msgbuff.src	= AIBOX_CMD_RESET;
  // msgbuff.tid	= TPRDIDAIBOX1;		/* device ID */
  // msgbuff.io	= TPRDEVOUT;
  // msgbuff.result	= 0;
  // msgbuff.datalen	= 0;
  // msgbuff.data[0] = 0;
  // msgbuff.data[1] = 1;
  //
  // /* Send the request */
  // w_length = msgbuff.length + sizeof(tprcommon_t);
  // ret = write(hMyPipe, &msgbuff, w_length);
  // if(ret != w_length)
  // {
  // return AIBOX_ERROR;
  // }
  //
  // return AIBOX_NORMAL;
  // }
}


