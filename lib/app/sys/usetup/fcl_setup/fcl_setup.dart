/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../inc/lib/if_fcl.dart';
import '../../../inc/sys/tpr_aid.dart';

/// 関連tprxソース: fcl_setup.h
class FclSetup{
/*-------------------------------------------------------------------------*
 * 定数マクロ宣言
 *-------------------------------------------------------------------------*/
  static const FCLS_LOG = Tpraid.TPRAID_FCLSETUP;	/* ログ出力用モジュールＩＤ */

  static const NETX_GO_TIME	= 100;
  static const EVENT_TO_TIME	= 300;
  static const RETRY_TIME	= 300;
  static const STEP_TO_TIME	= 1000;
}

/// 関連tprxソース: fcl_setup.h - FCLS_STS
enum FclsSts{
/*-------------------------------------------------------------------------*
 * 画面情報
 *-------------------------------------------------------------------------*/
  FCLS_STS_0,       /* メイン画面（ＦＣＬセットアップ／ＦＣＬ機能設定） */
  FCLS_STS_1_1,     /* 共通 センタ通信    */
  FCLS_STS_1_1_1,
  FCLS_STS_1_1_2,
  FCLS_STS_1_1_3,
  FCLS_STS_1_1_4,
  FCLS_STS_1_1_5,
  FCLS_STS_1_2,		  /* ＦＣＬ ＳＰ／ＶＴセンタ通信 */
  FCLS_STS_1_2_1,
  FCLS_STS_1_2_2,
  FCLS_STS_1_2_3,
  FCLS_STS_1_2_4,
  FCLS_STS_1_2_5,
  FCLS_STS_1_3,		  /* ＦＣＬ Ｅｄｙセンタ通信 */
  FCLS_STS_1_3_1,
  FCLS_STS_1_3_2,
  FCLS_STS_1_3_3,
  FCLS_STS_1_3_4,
  FCLS_STS_1_3_5,
  FCLS_STS_1_4,     /* ＦＣＬ ＱＰセンタ通信 */
  FCLS_STS_1_4_1,
  FCLS_STS_1_4_2,
  FCLS_STS_1_4_3,
  FCLS_STS_1_4_4,
  FCLS_STS_1_4_5,
  FCLS_STS_1_5,
  FCLS_STS_1_5_1,
  FCLS_STS_1_5_2,
  FCLS_STS_1_5_3,
  FCLS_STS_1_5_4,
  FCLS_STS_1_5_5,
  FCLS_STS_1_6,
  FCLS_STS_1_6_1,
  FCLS_STS_1_6_2,
  FCLS_STS_1_6_3,
  FCLS_STS_1_6_4,
  FCLS_STS_1_6_5,
  FCLS_STS_2_1,		  /* ＦＣＬ共通設定 */
  FCLS_STS_2_1_1,		/* 端末日付・時刻 */
  FCLS_STS_2_1_2,		/* 端末接客部輝度 */
  FCLS_STS_2_1_3,		/* 端末接客部待機表示有無 */
  FCLS_STS_2_1_4,		/* 端末音量  */
  FCLS_STS_2_1_5,
  FCLS_STS_2_1_6,		/* 端末通信情報 */
  FCLS_STS_2_1_7,
  FCLS_STS_2_2,		  /* ＦＣＬ ＳＰ／ＶＴ設定 */
  FCLS_STS_2_2_1,		/* 端末音量 */
  FCLS_STS_2_2_2,		/* 端末システム情報 */
  FCLS_STS_2_2_3,		/* 端末カードタッチ待ちタイムアウト時間 */
  FCLS_STS_2_2_4,		/* 端末カード処理リトライ時間 */
  FCLS_STS_2_2_5,		/* 端末終了方式 */
  FCLS_STS_2_3,
  FCLS_STS_2_3_1,
  FCLS_STS_2_3_2,
  FCLS_STS_2_3_3,
  FCLS_STS_2_3_4,
  FCLS_STS_2_3_5,
  FCLS_STS_2_3_6,
  FCLS_STS_2_3_7,
  FCLS_STS_2_4,
  FCLS_STS_2_4_1,
  FCLS_STS_2_4_2,
  FCLS_STS_2_4_3,
  FCLS_STS_2_4_4,
  FCLS_STS_2_4_5,
  FCLS_STS_2_5,
  FCLS_STS_2_5_1,
  FCLS_STS_2_5_2,
  FCLS_STS_2_5_3,
  FCLS_STS_2_5_4,
  FCLS_STS_2_5_5,
  FCLS_STS_2_6,
  FCLS_STS_2_6_1,
  FCLS_STS_2_6_2,
  FCLS_STS_2_6_3,
  FCLS_STS_2_6_4,
  FCLS_STS_2_6_5,
  FCLS_STS_3_1,
  FCLS_STS_3_1_1,
  FCLS_STS_3_1_2,
  FCLS_STS_3_1_3,
  FCLS_STS_3_1_4,
  FCLS_STS_3_1_5,
  FCLS_STS_3_1_12,
  FCLS_STS_3_2,		  /* ＦＣＬ ＳＰ／ＶＴ保守 */
  FCLS_STS_3_2_1,		/* 端末センタオンラインテスト */
  FCLS_STS_3_2_2,
  FCLS_STS_3_2_3,
  FCLS_STS_3_2_4,
  FCLS_STS_3_2_5,
  FCLS_STS_3_3,
  FCLS_STS_3_3_1,
  FCLS_STS_3_3_2,
  FCLS_STS_3_3_3,
  FCLS_STS_3_3_4,
  FCLS_STS_3_3_5,
  FCLS_STS_3_4,
  FCLS_STS_3_4_1,
  FCLS_STS_3_4_2,
  FCLS_STS_3_4_3,
  FCLS_STS_3_4_4,
  FCLS_STS_3_4_5,
  FCLS_STS_3_5,
  FCLS_STS_3_5_1,
  FCLS_STS_3_5_2,
  FCLS_STS_3_5_3,
  FCLS_STS_3_5_4,
  FCLS_STS_3_5_5,
  FCLS_STS_3_6,
  FCLS_STS_3_6_1,
  FCLS_STS_3_6_2,
  FCLS_STS_3_6_3,
  FCLS_STS_3_6_4,
  FCLS_STS_3_6_5;
}

/// 関連tprxソース: fcl_setup.h - FCLS_PROC
enum FclsProc{
  /*-------------------------------------------------------------------------*
 * 機能別処理情報
 *-------------------------------------------------------------------------*/
  /* センタ通信 － ＳＰ／ＶＴ                                         */
  FCLS_PR_COMM,		                /* センタ通信                     */
  /* センタ通信 － 共通                                              */
  FCLS_PR_SETUP_COMM,             /*  端末セットアップ通信            */
  /* センタ通信 － QP                                                */
  FCLS_PR_QP_DAILY_COMM,          /*  QPセンタ日計処理               */
  FCLS_PR_JPA_DLL_COMM,  		      /* ＪＰＡセンタＤＬＬ通信            */
  FCLS_PR_JCN_DLL_COMM,  		      /* ＪＣＮセンタＤＬＬ通信            */
  /* センタ通信 － Edy                                               */
  FCLS_PR_EDY_DAILY_COMM,         /*  Edy締め処理                   */
  FCLS_PR_FIRST_COMM,             /*  初回通信                      */
  FCLS_PR_EDY_REMOVAL,            /*  撤去通信                      */
  /* センタ通信 － iD                                                */
  FCLS_PR_ID_DAILY_COMM,          /*  iDセンタ日計処理               */
  FCLS_PR_ID_NEGAREQ_COMM,        /*  iDネガ配信要求                 */
  FCLS_PR_ID_KEYREQ_COMM,         /*  iD鍵配信要求                   */
  /* 設定 － 共通                                                    */
  FCLS_PR_DATE_TIME_REQ,		      /* 端末日付・時刻要求               */
  FCLS_PR_DATE_TIME_SET,		      /* 設定                           */
  FCLS_PR_DSP_LIGHT_REQ,		      /* 端末接客部輝度要求               */
  FCLS_PR_DSP_LIGHT_SET,		      /* 設定                           */
  FCLS_PR_CUST_DSP_REQ,		        /* 端末接客部待機表示有無要求        */
  FCLS_PR_CUST_DSP_SET,		        /* 設定                           */
  FCLS_PR_DAILY_ALARM_REQ,        /* 端末日計アラーム通知間隔要求       */
  FCLS_PR_DAILY_ALARM_SET,        /* 設定                           */
  FCLS_PR_COM_INF_REQ,		        /* 端末通信情報要求                 */
  FCLS_PR_COM_INF_SET,		        /* 設定                           */
  FCLS_PR_PIN_TMOUT_REQ,          /* ＰＩＮ入力待ちﾀｲﾑｱｳﾄ時間要求       */
  FCLS_PR_PIN_TMOUT_SET,          /* 設定                           */
  /* 設定 － ＳＰ／ＶＴ                                               */
  FCLS_PR_VOLUME_REQ,		          /* 端末音量要求                     */
  FCLS_PR_VOLUME_SET,		          /* 設定                           */
  FCLS_PR_SYSTEM_REQ,		          /* 端末システム情報要求              */
  FCLS_PR_SYSTEM_SET,		          /* 設定                           */
  FCLS_PR_CARD_TMOUT_REQ,		      /* 端末ｶｰﾄﾞﾀｯﾁ待ちﾀｲﾑｱｳﾄ時間要求      */
  FCLS_PR_CARD_TMOUT_SET,		      /* 設定                           */
  FCLS_PR_CARD_RETRY_REQ,		      /* 端末ｶｰﾄﾞ処理ﾘﾄﾗｲ時間要求          */
  FCLS_PR_CARD_RETRY_SET,		      /* 設定                           */
  FCLS_PR_END_REQ,		            /* 端末終了方式要求                 */
  FCLS_PR_END_SET,		            /* 設定                           */
  /* 設定 － QP                                                     */
  FCLS_PR_QP_SYSTEM_REQ,		      /* QP端末システム情報要求            */
  FCLS_PR_QP_SYSTEM_SET,		      /* 設定                           */
  /* 設定 － Edy                                                    */
  FCLS_PR_PARA_INF_REQ,           /* センタ接続パラメータ要求          */
  FCLS_PR_PARA_INF_SET,           /* センタ接続パラメータ設定          */
  /* 設定 － iD                                                     */
  FCLS_PR_ID_SYSTEM_REQ,		      /* iD端末システム情報要求            */
  FCLS_PR_ID_SYSTEM_SET,		      /* 設定                           */
  /* 保守 － 共通                                                    */
  FCLS_PR_LOGSEND_COMM,           /* 端末ログ送信                    */
  FCLS_PR_PING_TEST,              /* 疎通確認                       */
  FCLS_PR_LOG_READ,	            	/* 端末ログ読み出し                 */
  /* 保守 － ＳＰ／ＶＴ                                               */
  FCLS_PR_ONLINE_TEST,		        /* 端末センタオンラインテスト         */
  /* 保守 －  ＱＰ                                                   */
  FCLS_PR_JPA_ONLINE_TEST,	      /* ＪＰＡセンタオンラインテスト       */
  FCLS_PR_JCN_ONLINE_TEST,	      /* ＪＣＮセンタオンラインテスト       */
  /* 保守 －  Edy                                                   */
  FCLS_PR_EDY_FIRONLINE_TEST,     /* 初回通信センタオンラインテスト     */
  FCLS_PR_EDY_COMONLINE_TEST,     /* 通常通信センタオンラインテスト     */
  /* 保守 －  iD                                                    */
  FCLS_PR_ID_DAILYONLINE_TEST,    /* 決済サーバオンラインテスト         */
  FCLS_PR_ID_KEYONLINE_TEST;      /* 鍵配信サーバオンラインテスト       */
}

/// 関連tprxソース: fcl_setup.h - FCLS_ORDER
enum FclsOrder{
  /*----------------------------------------------------------------------*
 * ＦＣＬ端末へのコマンドレスポンス送受信情報
 *----------------------------------------------------------------------*/
  FCLS_OD_NONE,					              /* アイドル状態 */
  FCLS_OD_PROC_END,					          /* 処理終了 */
  FCLS_OD_STAT_REQ,					          /* 状態要求 */
  FCLS_OD_STAT_REQ_RES,
  FCLS_OD_ENCRYPT_REQ2,  		  	    	/* 版数要求２ */
  FCLS_OD_ENCRYPT_REQ2_RES,
  FCLS_OD_MUTUAL1,					          /* 通信認証１ */
  FCLS_OD_MUTUAL1_RES,
  FCLS_OD_MUTUAL1_CHK,				        /* 通信認証１乱数チェック */
  FCLS_OD_MUTUAL2,					          /* 通信認証２ */
  FCLS_OD_MUTUAL2_RES,
  FCLS_OD_TRAN_END,					          /* 取引完了 */
  FCLS_OD_TRAN_END_RES,
  FCLS_OD_OPEMODE_CONTROL,			      /* 動作モード制御 */
  FCLS_OD_OPEMODE_CONTROL_RES,
  FCLS_OD_OPEMODE_CONTROL_MUTUAL,	  	/* 動作モード制御(認証) */
  FCLS_OD_OPEMODE_CONTROL_RES_MUTUAL,
  FCLS_OD_MENTE_PW_CHK,			  	      /* 保守用パスワード確認 */
  FCLS_OD_MENTE_PW_CHK_RES,
  FCLS_OD_DLL_REQ,					          /* ＤＬＬ要求指示 */
  FCLS_OD_DLL_REQ_RES,
  FCLS_OD_DLL_REQ_CHK,				        /* ＤＬＬ要求指示状況確認 */
  FCLS_OD_DLL_REQ_CHK_RES,
  FCLS_OD_MENTE_IN,					          /* 保守入 */
  FCLS_OD_MENTE_IN_RES,
  FCLS_OD_MENTE_OUT,					        /* 保守出 */
  FCLS_OD_MENTE_OUT_RES,
  FCLS_OD_DATA_GET_START,			      	/* 端末データ取得開始*/
  FCLS_OD_DATA_GET_START_RES,
  FCLS_OD_DATA_GET,					          /* 端末データ取得 */
  FCLS_OD_DATA_GET_RES,
  FCLS_OD_DATA_GET_END,				        /* 端末データ取得終了 */
  FCLS_OD_DATA_GET_END_RES,
  FCLS_OD_DATE_TIME_REQ,			      	/* 日付・時刻要求 */
  FCLS_OD_DATE_TIME_REQ_RES,
  FCLS_OD_DATE_TIME_SET,			      	/* 日付・時刻設定 */
  FCLS_OD_DATE_TIME_SET_RES,
  FCLS_OD_DSP_LIGHT_REQ,			      	/* 接客部輝度要求 */
  FCLS_OD_DSP_LIGHT_REQ_RES,
  FCLS_OD_DSP_LIGHT_SET,			      	/* 接客部輝度設定 */
  FCLS_OD_DSP_LIGHT_SET_RES,
  FCLS_OD_CUSTOMER_DSP_REQ,		      	/* 接客部待機表示有無要求 */
  FCLS_OD_CUSTOMER_DSP_REQ_RES,
  FCLS_OD_CUSTOMER_DSP_SET,			      /* 接客部待機表示有無設定 */
  FCLS_OD_CUSTOMER_DSP_SET_RES,
  FCLS_OD_COM_INF2_REQ,				        /* 端末通信情報２要求 */
  FCLS_OD_COM_INF2_REQ_RES,
  FCLS_OD_COM_INF2_SET,				        /* 端末通信情報２設定 */
  FCLS_OD_COM_INF2_SET_RES,
  FCLS_OD_VOLUME_REQ,					        /* 音量要求 */
  FCLS_OD_VOLUME_REQ_RES,
  FCLS_OD_VOLUME_SET,					        /* 音量設定 */
  FCLS_OD_VOLUME_SET_RES,
  FCLS_OD_SYSTEM_REQ,					        /* 端末システム情報要求 */
  FCLS_OD_SYSTEM_REQ_RES,
  FCLS_OD_SYSTEM_SET,					        /* 端末システム情報設定 */
  FCLS_OD_SYSTEM_SET_RES,
  FCLS_OD_MANAGE_PW_CHK,		  		    /* 管理用パスワード確認 */
  FCLS_OD_MANAGE_PW_CHK_RES,
  FCLS_OD_FUNC_SETUP_IN,				      /* 機能設定入 */
  FCLS_OD_FUNC_SETUP_IN_RES,
  FCLS_OD_FUNC_SETUP_OUT,				      /* 機能設定出 */
  FCLS_OD_FUNC_SETUP_OUT_RES,
  FCLS_OD_CARD_TMOUT_REQ,				      /* カードタッチ待ちタイムアウト時間要求 */
  FCLS_OD_CARD_TMOUT_REQ_RES,
  FCLS_OD_CARD_TMOUT_SET,				      /* カードタッチ待ちタイムアウト時間設定 */
  FCLS_OD_CARD_TMOUT_SET_RES,
  FCLS_OD_CARD_RETRY_REQ,				      /* カード処理リトライ時間要求 */
  FCLS_OD_CARD_RETRY_REQ_RES,
  FCLS_OD_CARD_RETRY_SET,				      /* カード処理リトライ時間設定 */
  FCLS_OD_CARD_RETRY_SET_RES,
  FCLS_OD_END_REQ,					          /* 終了方式要求 */
  FCLS_OD_END_REQ_RES,
  FCLS_OD_END_SET,					          /* 終了方式設定 */
  FCLS_OD_END_SET_RES,
  FCLS_OD_ONLINE_TEST,				        /* オンラインテスト通信 */
  FCLS_OD_ONLINE_TEST_RES,
  FCLS_OD_ONLINE_TEST_CHK,			      /* オンラインテスト通信状況確認 */
  FCLS_OD_ONLINE_TEST_CHK_RES,
  FCLS_OD_LOG_REQ_START,				      /* ログ要求開始 */
  FCLS_OD_LOG_REQ_START_RES,
  FCLS_OD_LOG_REQ,					          /* ログ要求 */
  FCLS_OD_LOG_REQ_RES,
  FCLS_OD_LOG_REQ_END,				        /* ログ要求終了 */
  FCLS_OD_LOG_REQ_END_RES,
  FCLS_OD_OPEMODE_CONTROL_OFF,		    /* 動作モード制御(休止) */
  FCLS_OD_OPEMODE_CONTROL_RES_OFF,
  FCLS_OD_JPA_DLL_COMM,		            /* ＪＰＡセンタテーブルＤＬＬ通信 */
  FCLS_OD_JPA_DLL_COMM_RES,
  FCLS_OD_JPA_DLL_COMM_CHK,  		      /* ＪＰＡセンタテーブルＤＬＬ通信状況確認 */
  FCLS_OD_JPA_DLL_COMM_CHK_RES,
  FCLS_OD_JCN_DLL_COMM,		            /* ＪＣＮセンタテーブルＤＬＬ通信 */
  FCLS_OD_JCN_DLL_COMM_RES,
  FCLS_OD_JCN_DLL_COMM_CHK,  		      /* ＪＣＮセンタテーブルＤＬＬ通信状況確認 */
  FCLS_OD_JCN_DLL_COMM_CHK_RES,
  FCLS_OD_JPA_ONLINE_TEST,		        /* ＪＰＡセンタオンラインテスト通信 */
  FCLS_OD_JPA_ONLINE_TEST_RES,
  FCLS_OD_JPA_ONLINE_TEST_CHK,  		  /* ＪＰＡセンタオンラインテスト通信状況確認 */
  FCLS_OD_JPA_ONLINE_TEST_CHK_RES,
  FCLS_OD_JCN_ONLINE_TEST,		        /* ＪＣＮセンタオンラインテスト通信 */
  FCLS_OD_JCN_ONLINE_TEST_RES,
  FCLS_OD_JCN_ONLINE_TEST_CHK,			  /* ＪＣＮセンタオンラインテスト通信状況確認 */
  FCLS_OD_JCN_ONLINE_TEST_CHK_RES,
  FCLS_OD_QP_DAILY_COMM,		          /* QP日計 */
  FCLS_OD_QP_DAILY_COMM_RES,
  FCLS_OD_QP_DAILY_COMM_CHK,	        /* QP日計状況確認 */
  FCLS_OD_QP_DAILY_COMM_CHK_RES,
  FCLS_OD_EDY_DAILY_COMM,		          /* Edy締め */
  FCLS_OD_EDY_DAILY_COMM_RES,
  FCLS_OD_EDY_DAILY_COMM_CHK,	        /* Edy締め状況確認 */
  FCLS_OD_EDY_DAILY_COMM_CHK_RES,
  FCLS_OD_EDY_DATA_REQ,               /* EDY固定データ要求 */
  FCLS_OD_EDY_DATA_REQ_RES,
  FCLS_OD_MUL_PARA_REQ,				        /* マルチセンタ接続パラメータ要求 */
  FCLS_OD_MUL_PARA_REQ_RES,
  FCLS_OD_MUL_CENTER_COM,             /* マルチサービスセンタ通信指令   */
  FCLS_OD_MUL_CENTER_COM_RES,
  FCLS_OD_MUL_CENTER_COM_CHK,         /* マルチサービスセンタ通信状況確認   */
  FCLS_OD_MUL_CENTER_COM_CHK_RES,
  FCLS_OD_DAILY_ALARM_REQ,            /* 日計アラーム通知間隔要求       */
  FCLS_OD_DAILY_ALARM_REQ_RES,
  FCLS_OD_DAILY_ALARM_SET,            /* 日計アラーム通知間隔設定       */
  FCLS_OD_DAILY_ALARM_SET_RES,
  FCLS_OD_PARA_INF_REQ,               /* センタ接続パラメータ要求         */
  FCLS_OD_PARA_INF_REQ_RES,
  FCLS_OD_PARA_INF_SET,               /* センタ接続パラメータ設定         */
  FCLS_OD_PARA_INF_SET_RES,
  FCLS_OD_FIRST_COM,                  /*  初回通信                        */
  FCLS_OD_FIRST_COM_RES,
  FCLS_OD_FIRST_COM_CHK,              /*  EDY-拡張初回通信確認            */
  FCLS_OD_FIRST_COM_CHK_RES,
  FCLS_OD_FUNC_LIMIT,                 /*  マルチサービス機能制限          */
  FCLS_OD_FUNC_LIMIT_RES,
  FCLS_OD_RWNO_REQ,                   /* 端末識別番号要求                 */
  FCLS_OD_RWNO_REQ_RES,
  FCLS_OD_RWNO_SET,                   /* 端末識別番号設定                 */
  FCLS_OD_RWNO_SET_RES,
  FCLS_OD_PID_REQ,                    /* PID要求                          */
  FCLS_OD_PID_REQ_RES,
  FCLS_OD_PIDOLD_REQ,                 /* OLD PID要求                      */
  FCLS_OD_PIDOLD_REQ_RES,
  FCLS_OD_PIDOLD_SET,                 /*        設定                      */
  FCLS_OD_PIDOLD_SET_RES,
  FCLS_OD_QP_TRAN_END,				        /* QP取引完了                       */
  FCLS_OD_QP_TRAN_END_RES,
  FCLS_OD_MUL_DAILY_COMM,		          /* マルチサービス日計               */
  FCLS_OD_MUL_DAILY_COMM_RES,
  FCLS_OD_MUL_DAILY_COMM_CHK,	        /* マルチサービス日計状況確認       */
  FCLS_OD_MUL_DAILY_COMM_CHK_RES,
  FCLS_OD_MUL_DAILY_END,		          /* マルチサービス日計完了           */
  FCLS_OD_MUL_DAILY_END_RES,
  FCLS_OD_PIN_TMOUT_REQ,              /* ＰＩＮ入力待ちﾀｲﾑｱｳﾄ時間要求     */
  FCLS_OD_PIN_TMOUT_REQ_RES,
  FCLS_OD_PIN_TMOUT_SET,              /* ＰＩＮ入力待ちﾀｲﾑｱｳﾄ時間設定     */
  FCLS_OD_PIN_TMOUT_SET_RES,
  FCLS_OD_MUL_NEGAREQ,            	  /* マルチサービスネガ配信要求指示   */
  FCLS_OD_MUL_NEGAREQ_RES,
  FCLS_OD_MUL_NEGAREQ_CHK,            /* マルチサービスネガ配信要求指示状況確認   */
  FCLS_OD_MUL_NEGAREQ_CHK_RES,
  FCLS_OD_MUL_KEYREQ,                 /* マルチサービス鍵配信要求指示             */
  FCLS_OD_MUL_KEYREQ_RES,
  FCLS_OD_MUL_KEYREQ_CHK,             /* マルチサービス鍵配信要求指示状況確認     */
  FCLS_OD_MUL_KEYREQ_CHK_RES;
}

/// 関連tprxソース: fcl_setup.h - 構造体FCLS_LOG_DATA
class FclsLogData{
  /*-------------------------------------------------------------------------*
 * マルチサービスログ要求情報
 *-------------------------------------------------------------------------*/
  int logNo = 0;			  /* ログＮｏ． */
  String fname = "";		/* ログファイル名 */
}

/// 関連tprxソース: fcl_setup.h - 構造体FCLS_INFO
class FclsInfo{
 /*-------------------------------------------------------------------------*
 * グローバル変数
 *-------------------------------------------------------------------------*/
  int  mode = 0;			      /* 0:ユーザーセットアップ
							                 1:テストモード           */
  FclsSts state = FclsSts.FCLS_STS_0;			/* 画面情報                 */
  int  procAct = 0;		      /* ＦＣＬ端末への送受信処理
									             0:処理なし
									             1:処理中                 */
  late  FclsProc	procNo;		/* 機能別処理情報           */
  int  result = 0;			    /* ＦＣＬライブラリ戻り値   */
  String data = "";		      /* データ受け渡しメモリ
									             端末との通信結果異常の場合
									             レスポンスをセットする   */
  late  FclsOrder order;	  /* ＦＣＬ通信オーダー       */
  late  FclService	s_kind;	/* サービス種別             */
  int  dKind = 0;			      /* データ種別               */
  String dateTime = "";     /* 日付・時刻(YYMMDDhhmmss) */
  int light = 0;			      /* 接客部輝度 1～3          */
  int customerDsp = 0;    	/* 接客部待機表示有無 0～9  */
  int dhcp = 0;			        /* ＤＨＣＰ設定             */
  String ip_addr= "";     	/* Ｒ／ＷＩＰアドレス       */
  String sub_addr = "";	    /* サブネットマスク         */
  String gateway = "";	    /* デフォルトゲートウェイ   */
  int separateSet = 0;	    /* 個別設定                 */
  int connect = 0;		      /* センタへの接続方法       */
  String tid = "";		      /* 端末識別番号             */
  String pid = "";			    /* ＰＩＤ                   */
  String pidOld = "";		    /* ＰＩＤ（ＯＬＤ）         */
  String rwNo = "";		      /* Ｒ／Ｗ識別番号           */
  int  volume = 0;			    /* 音量 0～3                */
  int  touchTime = 0;		    /* ｶｰﾄﾞﾀｯﾁ待ちﾀｲﾑｱｳﾄ時間    */
  int  retryTime = 0;		    /* ｶｰﾄﾞ処理ﾘﾄﾗｲ時間         */
  int  endRule = 0;		      /* 終了方式                 */
  int  dspTime = 0;		      /* 取引結果の表示時間       */
  List<FclsLogData> logData = List.generate(3, (_) =>  FclsLogData()); /* ログ情報                 */
  int  boot = 0;			      /* 起動方法                 */
  int  opportune = 0;		    /* データ受信契機           */
  String autoRcvTime = "";  /* 自動ﾃﾞｰﾀ受信ﾀｲﾏ(hhmmss)  */
  int step = 0;             /*  1: 共通
                                2: SP/VT
                                3: QP
                                4: Edy
                                5: iD                   */
  int alarmTime = 0;		    /* ｶｰﾄﾞ処理ﾘﾄﾗｲ時間         */
  String ipAddr1 = "";
  int port1 = 0;
  String ipAddr2 = "";
  int port2 = 0;
  int contTyp = 0;          /* 接続機種  1: FCL-100  2: FAP-10   */
  int comNo = 0;            /* 初回通信No.                       */
  int comStat = 0;          /* 通信ステータス                    */
  int stat = 0;             /* 初回通信状態 1:初回通信済 2:正常終了 */
  int rmvStep = 0;          /* 0:機能制限 1:Edy締め 2:撤去通信   */
  int rmvResult = 0;        /* 撤去通信結果                      */
  late Fcl961eID idSystem;  /* iD端末システム情報                */
  int faulCode = 0;         /* 故障コード                        */
  String errMsg = "";
  int finishExe = 0;        /* ＰＦＭ端末処理実行済 */
  String ipAddr3 = "";
  int beforeStep2 = 0;      /* エラー直前のstep2 */
  String inpDate = "";
  int prnprocAct = 0;		    /* ＦＣＬ端末への送受信処理
									             0:印字処理なし
									             1:印字中                 */
  String ocxVer = "";
  String pfVer = "";
  String icVer = "";
  String apVer = "";
  String pitapaVer = "";
  String printDate = "";     /* 日付(YYYYMMDD) */
  int obsprnFlg = 0;
}

/// 関連tprxソース: fcl_setup.h - 構造体FCLS_WID
class FclsWid{
  /*-------------------------------------------------------------------------*
 * 共通画面ウィジェット
 *-------------------------------------------------------------------------*/
  // STD_DSP_INFO	Dsp;
  // GtkWidget		*Ent_msg;
  // GtkWidget		*Lbl_cmd;
  // GtkWidget		*Lbl_log;
  // GtkWidget		*Lbl_count;
}