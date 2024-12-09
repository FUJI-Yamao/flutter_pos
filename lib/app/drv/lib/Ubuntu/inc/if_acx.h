#ifndef	_IF_ACX_H_
#define	_IF_ACX_H_


#define     ERR_LOG_DATA    10          /* 13byte x 10data = 130 BYTE */
#define     OPERATION_LOG_DATA    10    /* 24byte x 10data = 240 BYTE */

/*--------------------------------------------------------------------------*/
/*	Common Structure														*/
/*--------------------------------------------------------------------------*/
typedef struct {
	short	bill10000;
	short	bill5000;
	short	bill2000;
	short	bill1000;
	short	coin500;
	short	coin100;
	short	coin50;
	short	coin10;
	short	coin5;
	short	coin1;
} CBILLKIND;

typedef struct {
	ushort	rjctfull;
	ushort	csetfull;
	ushort	act_flg;
} CBILLFULL;

typedef struct {
	ushort	bill_flg;	/* 紙幣収納庫 0:確定／1:不確定 */
	ushort	coin_flg;	/* 硬貨収納庫 0:確定／1:不確定 */
	ushort	bill_overflow;	/* 紙幣回収庫 0:確定／1:不確定 */
} STOCK_STATE;

typedef struct {
	CBILLKIND		holder;
	ushort			billrjct;	/* リジェクト合計 */
	ushort			billrjct_in;	/* 入金リジェクト */
	ushort			billrjct_out;	/* 出金リジェクト */
	ushort			billrjct_2000;	/* 二千券リジェクト */
	ushort			coinrjct;
	CBILLKIND		overflow;
	CBILLFULL		billfull;
	ushort			coinslot;
	STOCK_STATE		stock_state;
	CBILLKIND		draw_data;
	ushort			draw_stat;
} COINDATA;

typedef struct {
	uchar	year[2];
	uchar	mon[2];
	uchar	day[2];
	uchar	hour[2];
	uchar	min[2];
	uchar	errcode[3];
} errlogdata_t;

typedef struct {
    errlogdata_t errlogdata[ERR_LOG_DATA];
} ERRLOGDATA;

typedef struct {
	uchar	year[2];
	uchar	mon[2];
	uchar	day[2];
	uchar	hour[2];
	uchar	min[2];
	uchar	kind;
	uchar	amount[8];
	uchar	coinreject[3];
	uchar	rej;
	uchar	cnd;
} oplogdata_t;

typedef struct {
    oplogdata_t   oplogdata[OPERATION_LOG_DATA];
} OPLOGDATA;

typedef struct {
	uint	busy			:1;
	uint	ctm_err_stat	:1;
	uint	css_err_stat	:1;
	uint	rcv_paid_type	:1;
	uint	pickup_mode		:1;
	uint	coin_chg_mode	:1;
	uint	fix1			:1;
	uint	dummy			:1;
} ST1;

typedef struct {
	uint	css_clean_h		:1;
	uint	css_clean_s		:1;
	uint	fix0			:1;
	uint	css_paid_out	:1;
	uint	css_rcv_out		:1;
	uint	css_rjt_stat	:1;
	uint	fix1			:1;
	uint	dummy			:1;
} ST2;

typedef struct {
	uint	ctm_clean		:1;
	uint	ctm_paid_out	:1;
	uint	ctm_rcv_out		:1;
	uint	ctm_bunit		:1;
	uint	ctm_connect		:1;
	uint	ctm_rjt_stat	:1;
	uint	fix1			:1;
	uint	dummy			:1;
} ST3;

typedef struct {
	uint    fix0            :1;
	uint    fix1            :1;
	uint    fix2            :1;
	uint    fix3            :1;
	uint    ctm_position    :1;
	uint    ctm_kind        :1;
	uint    fix4            :1;
	uint    dummy           :1;
} ST4;

typedef struct {
	ST1		st1;
	ST2		st2;
	ST3		st3;
	ST4		st4;
	uchar	hopper_stat[10];
	uchar	err_code[3];
} STATEDATA;

typedef struct {
	uchar		memdata[32];
} COIN_MEM;



/* if_acb_StataeSet */
typedef struct {
	ushort	dummy;
	ushort	bill5000;
	ushort	bill2000;
	ushort	bill1000;
	ushort	coin500;
	ushort	coin100;
	ushort	coin50;
	ushort	coin10;
	ushort	coin5;
	ushort	coin1;
} NEAREND;



/* if_acb_ NearGet  */
typedef struct {
	ushort	dummy;
	ushort	bill5000;
	ushort	bill2000;
	ushort	bill1000;
	ushort	coin500;
	ushort	coin100;
	ushort	coin50;
	ushort	coin10;
	ushort	coin5;
	ushort	coin1;
} NEARILLK;


typedef struct {
	NEARILLK	nearfull;
	NEARILLK	nearend;
	uchar	    StateData[10];
} NEARDATA;

typedef struct {
	uchar		flag;
	ulong		enumamt;
	uchar		crj;
	uchar		brj;
} ENUMDATA;

typedef struct {
	ushort bill10000;
	ushort bill5000;
	ushort bill2000;
	ushort bill1000;
	ushort coin500;
	ushort coin100;
	ushort coin50;
	ushort coin10;
	ushort coin5;
	ushort coin1;
} CINDATA;

typedef struct {
	uint cininfo;
	uint cinstopcom;
	uint device_state;
	uint billinfo;
	uint billdetail;
	uint coininfo;
	uint coindetail;
	uint opeflg;
} CINFLG;

typedef struct {
        CINDATA cindata;
        CINFLG  cinflg;
} CININFO;

typedef struct {
	CBILLKIND	holder;
	ushort		billrjct;	/* リジェクト合計 */
	ushort		billrjct_in;	/* 入金リジェクト */
	ushort		billrjct_out;	/* 出金リジェクト */
	ushort		billrjct_2000;	/* 二千券リジェクト */
	ushort		coinrjct;
	CBILLKIND	overflow;
	CBILLKIND	draw_data;
	char		datetime[20+1];		// 在高取得日時 YYYY-MM-DD HH:MM:SS
} COIN_STOCK;

typedef struct {
	uint total_sht : 1;		/* トータル枚数 0:クリアしない／1:クリアする */
	uint auto_continue : 1;	/*自動継続 0:あり／1:なし */
	uint suspention : 1;	/* 一時保留 0:しない／1:する */
	CINDATA reject;			/* 金種別リジェクト 0:しない／1:する */
} CINSTART_ECS;

typedef struct {
	CINDATA cindata;		/* 入金枚数 */
	uint reject_coin : 1;	/* 硬貨リジェクト 0:無し／1:有り */
	uint reject_bill : 1;	/* 紙幣リジェクト 0:無し／1:有り */
} CINREAD_ECS;

typedef struct {
	CBILLKIND cbillkind;	/* 金種別回収枚数
							   0～999:枚数指定
							   10000:回収残設定超枚数
							   10001:全回収 */
	uint coin : 1;			/* 硬貨 0:混合回収／1:金種別回収 */
	uint bill : 1;			/* 紙幣 0:混合回収／1:金種別回収 */
	uint leave : 1;			/* 金額残置回収 0:しない／1:する */
	uint caset : 1;			/* 回収庫回収 0:しない／1:する */
} PICK_ECS;	//富士電機用回収指示データ

typedef struct {
	CBILLKIND cbillkind;		/* 金種別回収枚数	*/
	uint coin_mode;			/* 硬貨回収方法 */
	uint bill_mode;			/* 紙幣回収方法 */
	uint coin : 1;			/* 硬貨 0:混合回収／1:金種別回収 */
	uint bill : 1;			/* 紙幣 0:混合回収／1:金種別回収 */
	uint leave : 1;			/* 金額残置回収 0:しない／1:する */
} PICK_DATA;	//共通回収指示データ

/* 富士電機製釣銭釣札機 詳細状態リードデータ格納領域 */
typedef struct {
	short	unit;				/* ユニットコード */
	char	proc_code;			/* 処理コード */
	char	content_code[2];	/* 内容コード */
} STATE_ERR;

typedef struct {
	short	bill_in;			/* 紙幣投入口 */
	short	bill_out;			/* 紙幣出金口 */
	short	coin_in;			/* 硬貨投入口 */
	short	coin_return;		/* 硬貨返却口 */
	short	coin_out;			/* 硬貨出金口 */
} STATE_SENSOR;

typedef struct {
	short	full;				/* フル */
	short	nearfull;			/* ニアフル */
	short	nearempty;			/* ニアエンプティ */
	short	empty;				/* エンプティ */
} STATE_HOLDER;

typedef struct {
	short	lid;				/* 紙幣回収庫ふた開検知 */
	short	set;				/* 紙幣回収庫セット検知 */
	short	bill;				/* 紙幣回収庫紙幣検知 */
	short	full;				/* 紙幣回収庫フル */
} STATE_CASHBOX;

typedef struct {
	short	bill_set;			/* 紙幣部セット検知 */
	char	bill_key;			/* 紙幣部鍵位置 */
	short	coin_set;			/* 硬貨部セット検知 */
	char	coin_key;			/* 硬貨部鍵位置 */
} STATE_KEY;

typedef struct {
	short	bill_full;			/* 紙幣一時保留部のフル検知 */
	short	coin_full;			/* 硬貨一時保留部のフル検知 */
	short	bill_status;		/* 紙幣一時保留部の紙幣有無 */
	short	coin_status;		/* 硬貨一時保留部の硬貨有無 */
} STATE_TEMP;

typedef struct {
	char	bill[2];			/* 紙幣部詳細動作モード */
	char	coin[2];			/* 硬貨部詳細動作モード */
} STATE_DETAIL;

typedef struct {
	char			unit;			/* ユニット情報 */
	char			act_mode;		/* 動作モード */
	char			cin_mode;		/* 入金モード */
	STATE_ERR		err;			/* エラーコード */
	STATE_SENSOR	sensor;			/* センサ情報 */
	CBILLKIND		full;			/* フル */
	CBILLKIND		nearfull;		/* ニアフル */
	CBILLKIND		nearempty;		/* ニアエンプティ */
	CBILLKIND		empty;			/* エンプティ */
	STATE_HOLDER	holder;			/* 紙幣混合収納庫情報 */
	char			act_state[21];	/* 動作情報 */
	STATE_CASHBOX	cashbox;		/* 金庫等の情報 */
	STATE_KEY		key;			/* 鍵情報等 */
	STATE_TEMP		temp;			/* 一時保留庫 */
	STATE_DETAIL	detail;			/* 詳細動作モード */
} STATE_ECS;

typedef struct {
	uchar		logdata[254];	/* ログデータ */
} LOGDATA_ECS;

typedef struct {
	CINDATA 	cindata;
	ushort  	reject;			/* リジェクト枚数 */
} CINCANCEL_SST1;

typedef struct {
	ushort		motion;			/* 動作段階 */
	uchar		logdata[250];	/* ログデータ */
} LOGDATA_SST1; 

typedef struct {
	ushort		eject_coin;		/* 排出硬貨有無  0:無し 0:有り */
	ushort		eject_bill;		/* 排出紙幣有無  0:無し 0:有り */
	ushort		reserve_bill;	/* 保留紙幣有無  0:無し 0:有り */
	ushort		stop;			/* 途中停止有無  0:無し 0:有り */
	ushort		bill;			/* 紙幣 */
	ushort		coin;			/* 硬貨 */
} RECALCDATA;

typedef struct {
	char		detail_errcode[12];	/* 詳細エラーコード */
	ushort		reject_coin;		/* 硬貨リジェクト */
	ushort		reject_bill;		/* 紙幣リジェクト */
} STATE_SST1;

typedef struct {
        char            errcode[4];             /* エラーコード */
        ushort          restore_flg;            /* 解除手順 */
        ushort          sensor_info;            /* 搬送路センサー情報 */
	ushort		stockerr_bill10000;	/* 在高不確定解除方法 */
	ushort		stockerr_bill5000;	/* 在高不確定解除方法 */
	ushort		stockerr_bill2000;	/* 在高不確定解除方法 */
	ushort		stockerr_bill1000;	/* 在高不確定解除方法 */
	ushort		stockerr_caset;		/* 在高不確定解除方法 */
} STATE_ACB_BILL;

typedef struct {
        char            errcode[4];             /* エラーコード */
        ushort          restore_flg;            /* 解除手順 */
        ushort          sensor_info;            /* 搬送路センサー情報 */
        ushort          unit_info;              /* 硬貨メカセット */
	ushort		draw_stat;
	ushort		stockerr_coin500;	/* 在高不確定解除方法 */
	ushort		stockerr_coin100;	/* 在高不確定解除方法 */
	ushort		stockerr_coin50;	/* 在高不確定解除方法 */
	ushort		stockerr_coin10;	/* 在高不確定解除方法 */
	ushort		stockerr_coin5;		/* 在高不確定解除方法 */
	ushort		stockerr_coin1;		/* 在高不確定解除方法 */
} STATE_ACB_COIN;

typedef struct {
        STATE_ACB_BILL  bill;
        STATE_ACB_COIN  coin;
} STATE_ACB;

typedef struct {
	CBILLKIND	stock;		/* 収納枚数 */
	char		device_state;	/* 動作情報 */
	CBILLKIND	cbill_state;	/* 状態フラグ */
	ushort		reserv1_stock;	/* 予備金種1収納枚数 */
	ushort		reserv2_stock;  /* 予備金種2収納枚数 */
	ushort		reserv1_state;  /* 予備金種1状態フラグ */
	ushort		reserv2_state;  /* 予備金種2状態フラグ */
} STATE_ACXDRW;	//棒金ドロアデータ

typedef struct {
	ushort		type;		/* 0:出金 1:回収 */
	ulong		price;
	PICK_DATA	data;		/* 回収の指示データ or 出金枚数データ */
} CHGOUT_DATA;	//出金、回収データ

/*--------- 動作環境取得コマンド取得データ格納領域 ---------*/
#define	ECS_ENVSET_DATAGP_MAX	32
#define	ECS_ENVSET_DATA_MAX	12
typedef struct {
//	uchar   envir[16][5];
	uchar   envir[ECS_ENVSET_DATAGP_MAX][ECS_ENVSET_DATA_MAX];
}ECS_ENVIRONMENT;

/* 型式リードコマンド */
typedef struct {
	char	maker[20];
	char	model[8];
}ECS_MODEL;

/* 払出枚数リードコマンド */
typedef struct {
	short	payout_bill10000;
	short	payout_bill5000;
	short	payout_bill2000;
	short	payout_bill1000;
	short	payout_coin500;
	short	payout_coin100;
	short	payout_coin50;
	short	payout_coin10;
	short	payout_coin5;
	short	payout_coin1;
}ECS_PAYOUT;

/* NEC製釣銭釣札機(FAL2) */
/*--------- 状態センスコマンド取得データ格納領域 ---------*/
/* 常時通知データ */
typedef struct {
	uchar	act_status[2];		/* 動作ステータス */
	uchar	act_resultcode[2];	/* 動作結果コード */
	uchar	unit_offinfo;		/* 外れ情報 */
	uchar	type_code;		/* 代表コード */
	uchar	detail_code[2];		/* 詳細コード */
} FAL2_ALWAYS_RESP;

/* 変化データ有無情報 */
typedef struct {
	ushort	stat_media_exist;	/* 媒体有無情報 */
	ushort	stat_seculity_info;	/* セキュリティー情報 */
	ushort	stat_battery_alarm;	/* バッテリーアラーム */
	ushort	stat_holder_a;		/* 収納庫A状態 */
	ushort	stat_holder_b;		/* 収納庫B状態 */
	ushort	stat_holder_c;		/* 収納庫C状態 */
	ushort	stat_cash_box;		/* 紙幣回収庫状態 */
	ushort	stat_reject_box;	/* 紙幣リジェクト庫状態 */
	ushort	stat_coin500_box;	/* 500円庫状態 */
	ushort	stat_coin100_box;	/* 100円庫状態 */
	ushort	stat_coin50_box;	/* 50円庫状態 */
	ushort	stat_coin10_box;	/* 10円庫状態 */
	ushort	stat_coin5_box;		/* 5円庫状態 */
	ushort	stat_coin1_box;		/* 1円庫状態 */
	ushort	stat_coin_reject;	/* 硬貨リジェクト枚数 */
	ushort	stat_cin_mode;		/* 入金モード */
	ushort	stat_sensor_info;	/* センサ情報 */
	ushort	stat_holder_amt;	/* 収納庫在高状態 */
	ushort	stat_local_mode;	/* ローカルモード */
	ushort	stat_count_up;		/* 計数内容 */
	ushort	stat_always_cin;	/* 常時入金計数内容 */
} FAL2_CHGINFO;

/* 媒体有無情報 0:媒体なし 1:媒体あり */
typedef struct {
	ushort	bill_inout;		/* 紙幣入出金口 */
	ushort	bill_route;		/* 紙幣搬送路 */
	ushort	coin_in;		/* 硬貨投入口 */
	ushort	coin_out;		/* 硬貨出金口 */
	ushort	coin_inroute;		/* 硬貨入金搬送路 */
} FAL2_MEDIA_EXIST;

/* セキュリティー情報 0:電源OFF中の外れなし 1:電源OFF中の外れあり */
typedef struct {
	ushort	coin_box;		/* 硬貨金庫 */
	ushort	bill_box;		/* 紙幣金庫 */
	ushort	reject_boxdoor;		/* リジェクト庫扉 */
	ushort	collect_box;		/* 回収庫 */
	ushort	unit;			/* ユニット */
} FAL2_SECULITY;

/* 収納庫/回収庫/紙幣リジェクト庫/硬貨リジェクト口の状態 */
/* 0:エンド 1:ニアエンド 2:ニアフル 3:フル 4:媒体あり */
typedef struct {
	ushort	holder_a;		/* 収納庫A状態 */
	ushort	holder_b;		/* 収納庫B状態 */
	ushort	holder_c;		/* 収納庫C状態 */
	ushort	cash_box;		/* 紙幣回収庫状態 */
	ushort	reject_box;		/* 紙幣リジェクト庫状態 */
	ushort	coin500_box;		/* 500円庫状態 */
	ushort	coin100_box;		/* 100円庫状態 */
	ushort	coin50_box;		/* 50円庫状態 */
	ushort	coin10_box;		/* 10円庫状態 */
	ushort	coin5_box;		/* 5円庫状態 */
	ushort	coin1_box;		/* 1円庫状態 */
	ushort	coin_reject;		/* 硬貨リジェクト口状態 */
} FAL2_UNIT_STATUS;

/* センサ情報 0:該当センサはOFF 1:該当センサはON */
typedef struct {
	ushort	sc22;
	ushort	sc21;
	ushort	sc19;
	ushort	sc02;
	ushort	reserve;
	ushort	sc04;
	ushort	sc03;
	ushort	sc01_1;

	ushort	sc08;
	ushort	sc07;
	ushort	sc12;
	ushort	sc11;
	ushort	sc16;
	ushort	sc15;

	ushort	sc10;
	ushort	sc09;
	ushort	sc14;
	ushort	sc13;
	ushort	sc18;
	ushort	sc17;

	ushort	sc53;
	ushort	sc52;
	ushort	sc45;
	ushort	sc33;
	ushort	sc35;
	ushort	sc34;
	ushort	sc32;
	ushort	sc31;

	ushort	sc38;
	ushort	sc37;
	ushort	sc44;
	ushort	sc43;
	ushort	sc42;
	ushort	sc41;
	ushort	sc40;
	ushort	sc39;

	ushort	sc54;
	ushort	sc51;
	ushort	sc50;
	ushort	sc49;
	ushort	sc48;
	ushort	sc47;
	ushort	sc46;

	ushort	sc60;
	ushort	sc59;
	ushort	sc58;
	ushort	sc57;
	ushort	sc56;
	ushort	sc55;
} FAL2_SENSOR;

/* 計数内容 */
typedef struct {
	uint	amount;			/* 計数金額 */
	ushort	bill10000;		/* 万券枚数 */
	ushort	bill5000;		/* 五千券枚数 */
	ushort	bill2000;		/* 二千券枚数 */
	ushort	bill1000;		/* 千券枚数 */
	ushort	coin500;		/* 500円枚数 */
	ushort	coin100;		/* 100円枚数 */
	ushort	coin50;			/* 50円枚数 */
	ushort	coin10;			/* 10円枚数 */
	ushort	coin5;			/* 5円枚数 */
	ushort	coin1;			/* 1円枚数 */
	ushort	bill_reject;		/* 紙幣リジェクト枚数 */
	ushort	coin_reject;		/* 硬貨リジェクト枚数 */
	ushort	out1000_reject;		/* 千券の出金 */
	ushort	out5000_reject;		/* 五千券の出金 */
	ushort	out10000_reject;	/* 万券の出金 */
} FAL2_COUNT;

/* 常時入金計数内容 */
typedef struct {
	uint	amount;		/* 計数金額 */
	ushort	bill10000;	/* 万券枚数 */
	ushort	bill5000;	/* 五千券枚数 */
	ushort	bill2000;	/* 二千券枚数 */
	ushort	bill1000;	/* 千券枚数 */
	ushort	coin500;	/* 500円枚数 */
	ushort	coin100;	/* 100円枚数 */
	ushort	coin50;		/* 50円枚数 */
	ushort	coin10;		/* 10円枚数 */
	ushort	coin5;		/* 5円枚数 */
	ushort	coin1;		/* 1円枚数 */
	ushort	bill_reject;	/* 紙幣リジェクト枚数 */
	ushort	coin_reject;	/* 硬貨リジェクト枚数 */
} FAL2_ALWAYSCIN;

/* 状態センスコマンド取得データ */
typedef struct {
	FAL2_ALWAYS_RESP	always_resp;	/* 常時通知データ */
	FAL2_MEDIA_EXIST	media_exist;	/* 媒体有無情報 */
	FAL2_SECULITY		seculity;	/* セキュリティー情報 */
	ushort			battery_alarm;	/* バッテリーアラーム   0:正常 1:バッテリーアラーム */
	FAL2_UNIT_STATUS	unit_status;	/* 収納庫/回収庫/紙幣リジェクト庫/硬貨リジェクト口の状態 */
	ushort			standby_mode;	/* 釣銭機待機モード     0:常時入金モード 1:指定入金モード */
	FAL2_SENSOR		sensor;		/* センサ情報 */
	ushort			holder_amt;	/* 収納庫在高状態       0:紙幣、硬貨共に確定 1:紙幣不確定 2:硬貨不確定 3:紙幣、硬貨共に不確定 */
	ushort			local_mode;	/* ローカルモード       0:運用モード 1:運用モードの補充or両替中 2:ローカルモード 3:保守モード */
	FAL2_COUNT		count;		/* 計数内容 */
	FAL2_ALWAYSCIN		always_cin;	/* 常時入金計数内容 */
} STATE_FAL2;

/*--------- RASデータ取得コマンド取得データ格納領域 ---------*/
/* リザーブ領域、ログ、エラー情報は保持しない */
/* 釣銭機ID情報(詳細) */
typedef struct {
	uchar	year;		/* 日付情報 */
	uchar	mon;
	uchar	day;
	uchar	hour;
	uchar	min;
	uchar	sec;
	uchar	serial_no[5];
	uchar	id[5];
	uchar	revision[5];
}FAL2_IDDATA;

/* 寿命情報(詳細) */
typedef struct {
	uchar	year;		/* 日付情報 */
	uchar	mon;
	uchar	day;
	uchar	hour;
	uchar	min;
	uchar	sec;
	uchar	data[4];
}FAL2_LIFEDATA;

/* 紙幣認識情報 */
typedef struct {
	uchar	year;		/* 日付情報 */
	uchar	mon;
	uchar	day;
	uchar	hour;
	uchar	min;
	uchar	sec;
	uint	in_bill_1000;	/* 紙幣金種別走行枚数(入金) */
	uint	in_bill_5000;
	uint	in_bill_10000;
	uint	in_bill_2000;
	uint	in_reject;
	uint	out_bill_1000;	/* 紙幣金種別走行枚数(出金) */
	uint	out_bill_5000;
	uint	out_bill_10000;
	uint	out_bill_2000;
	uint	out_reject;
	uint	in_all_cnt;	/* 紙幣認識情報(入金) */
	uchar	in_reject_fact[30][2];
	uint	a_all_cnt;	/* 紙幣認識情報(収納庫A) */
	uchar	a_reject_fact[30][2];
	uint	b_all_cnt;	/* 紙幣認識情報(収納庫B) */
	uchar	b_reject_fact[30][2];
	uint	c_all_cnt;	/* 紙幣認識情報(収納庫C) */
	uchar	c_reject_fact[30][2];
}FAL2_BILL_RECOG;

/* 硬貨認識情報 */
typedef struct {
	uchar	year;		/* 日付情報 */
	uchar	mon;
	uchar	day;
	uchar	hour;
	uchar	min;
	uchar	sec;
	uint	in_coin_500;	/* 硬貨金種別走行枚数(入金) */
	uint	in_coin_100;
	uint	in_coin_50;
	uint	in_coin_10;
	uint	in_coin_5;
	uint	in_coin_1;
	uint	in_reject;
	uint	out_coin_500;	/* 硬貨金種別走行枚数(出金) */
	uint	out_coin_100;
	uint	out_coin_50;
	uint	out_coin_10;
	uint	out_coin_5;
	uint	out_coin_1;
	uint	out_reject;
	uint	in_all_cnt;	/* 硬貨認識情報(入金) */
	uchar	in_reject_fact[255][2];
}FAL2_COIN_RECOG;

/* RASデータ */
typedef struct {
	FAL2_IDDATA	id_all;		/* 釣銭機ID情報(全体) */
	FAL2_IDDATA	id_bill;	/* 釣銭機ID情報(紙幣) */
	FAL2_IDDATA	id_coin;	/* 釣銭機ID情報(硬貨) */
	FAL2_LIFEDATA	lifedata;	/* 寿命情報(装置全体) */
	FAL2_LIFEDATA	bill_life[30];	/* 紙幣寿命情報 */
	FAL2_LIFEDATA	coin_life[50];	/* 硬貨寿命情報 */
	FAL2_BILL_RECOG	b_recog;	/* 紙幣認識情報 */
	FAL2_COIN_RECOG	c_recog;	/* 硬貨認識情報 */
}FAL2_RASDATA;

/*--------- 金庫状態コマンド取得データ格納領域 ---------*/
typedef struct {
	FAL2_UNIT_STATUS	full;		/* フル */
	FAL2_UNIT_STATUS	nearfull;	/* ニアフル */
	FAL2_UNIT_STATUS	nearend;	/* ニアエンド */
	FAL2_UNIT_STATUS	end;		/* エンド */
}FAL2_HOLDER_STATE;

/*--------- 動作環境取得コマンド取得データ格納領域 ---------*/
typedef struct {
	uchar	envir[60][2];
}FAL2_ENVIRONMENT;

/*--------- 釣銭機ID情報取得コマンド取得データ格納領域 ---------*/
typedef struct {
	uchar	id[4];
	uchar	bill_id[4];
	uchar	coin_id[4];
}FAL2_ID;

/*--------- バージョンリードコマンド取得データ格納領域 ---------*/
typedef struct {
	uchar	ipl_a[2];
	uchar	ipl_b[2];
	uchar	base_prg[2];
	uchar	fpga[2];
	uchar	coin_recog[2];
}FAL2_VERSION;

/*--------- センサ調整コマンド取得データ格納領域 ---------*/
typedef struct {
	uchar	offset[16];
	uchar	adj_data[512];
	uchar	ctrl_data1[8];
	uchar	ctrl_data2[64];
	uchar	ctrl_data3[128];
	uchar	ctrl_data4[64];
	uchar	id_ver_hash[6];
}FAL2_SENSORADJ_DETAIL;

typedef struct {
	FAL2_SENSORADJ_DETAIL	bill_unit;
	FAL2_SENSORADJ_DETAIL	coin_unit;
}FAL2_SENSORADJ;

/*--------- センサ清掃情報取得コマンド取得データ格納領域 ---------*/
typedef struct {
	ushort	sc22;
	ushort	sc21;
	ushort	sc19;
	ushort	sc02;
	ushort	sc04;
	ushort	sc03;
	ushort	sc01;

	ushort	sc08;
	ushort	sc07;
	ushort	sc12;
	ushort	sc11;
	ushort	sc16;
	ushort	sc15;

	ushort	sc10;
	ushort	sc09;
	ushort	sc14;
	ushort	sc13;
	ushort	sc18;
	ushort	sc17;

	ushort	sc06;
	ushort	sc05;

	ushort	sc33;
	ushort	sc35;
	ushort	sc34;
	ushort	sc32;
	ushort	sc31;

	ushort	sc38;
	ushort	sc37;
	ushort	sc44;
	ushort	sc43;
	ushort	sc42;
	ushort	sc41;
	ushort	sc40;
	ushort	sc39;

	ushort	sc54;
	ushort	sc53;
	ushort	sc52;
	ushort	sc45;
}FAL2_SENSORCLEAN;

/* 紙幣在高異常データ */
typedef struct {
	ushort	holder_open;	/* 収納庫開 */
	ushort	caset;
	ushort	bill10000;
	ushort	bill5000;
	ushort	bill2000;
	ushort	bill1000;
} BILL_STOCK_ERR;

/* 硬貨在高異常データ */
typedef struct {
	ushort	holder_open;	/* 収納庫開 */
	ushort	coin500;
	ushort	coin100;
	ushort	coin50;
	ushort	coin10;
	ushort	coin5;
	ushort	coin1;
} COIN_STOCK_ERR;

/* 紙幣区間ステータス */
typedef struct {
	ushort	holder_err;
	ushort	stock_err;
	ushort	rj_now_err;
	ushort	rj_bfr_err;
} BILL_SEGMENT_STATUS;

/* 硬貨区間ステータス */
typedef struct {
	ushort	holder_err;
	ushort	stock_err;
	ushort	drawer_err;
} COIN_SEGMENT_STATUS;

/* 交代データ */
typedef struct {
	ushort			index;
	char			start_date[8];	/* MMDDHHMM */
	char			now_date[8];	/* MMDDHHMM */
	ulong			start_price;	/* 開始時在高金額(※電文データ長は10桁だが釣銭機に億単位が収納されている可能性はないものとしてlong型とした) */
	ulong			in_price;	/* 累積入金系金額 */
	ulong			out_price;	/* 累積出金系金額 */
	ulong			now_price;	/* 現在在高金額 */
	ulong			diff_price;	/* 在高差分金額 */
	BILL_STOCK_ERR		bill_stock;
	COIN_STOCK_ERR		coin_stock;
	BILL_SEGMENT_STATUS	bill_seg_st;
	COIN_SEGMENT_STATUS	coin_seg_st;
	ulong			close_id;
} CLOSE_DATA;

/* 前回データ */
typedef struct {
	CBILLKIND		in;	//計数枚数データ
	CBILLKIND		out;	//放出枚数データ
} LAST_DATA;

// 釣機内の保留枚数の状態
typedef	enum
{
	HOLDER_NORMAL = 0,		// 問題なし
	HOLDER_EMPTY,			// エンプティ
	HOLDER_FULL,			// フル
	HOLDER_NEAR_END,		// ニアエンド
	HOLDER_NEAR_FULL,		// ニアフル
	HOLDER_NEAR_FULL_BFR_ALERT,	// ニアフル前警告（サインポール表示等）
	HOLDER_NON,			// エンプティ(ニアエンド設定0のため、不足していても問題ない扱い)
} HOLDER_FLAG_LIST;

// 各金種を表す
typedef	enum
{
	CB_KIND_10000 = 0,
	CB_KIND_05000,
	CB_KIND_02000,
	CB_KIND_01000,
	CB_KIND_00500,
	CB_KIND_00100,
	CB_KIND_00050,
	CB_KIND_00010,
	CB_KIND_00005,
	CB_KIND_00001,
	CB_KIND_MAX,
} COINBILL_KIND_LIST;

// 各金種の保留枚数の状態を格納
typedef struct
{
	int			NearFullDiff;	// ニアフルチェック用枚数
	int			QcNearFullDiff;	// ニアフルチェック用枚数(Qcashier)
	int			QcSignpFullChk;	// ニアフルサインポールチェック用枚数(Qcashier)
	HOLDER_FLAG_LIST	SimpleFlg;	// 全体の保留枚数状態の簡易チェック用
	HOLDER_FLAG_LIST	KindFlg[CB_KIND_MAX];	// 各金種の保留枚数状態
	short			percentage[CB_KIND_MAX];	// 各金種の在高割合((収納枚数 * 100) / 最大保留枚数)
} HOLDER_DATA_FLG;

/*----------------------------------------------------------------------*
 * Device Status
 *----------------------------------------------------------------------*/
typedef enum {
	CinEnd	= 0,
	CinStart,
	CinAct,
	CinWait,
	CinStop,
	CinReset,
} ACXSTATUS;

/*--------------------------------------------------------------------------*/
/*	Auto Coin Changer Common Definition										*/
/*--------------------------------------------------------------------------*/
#define    STX    0x02
#define    DC1    0x11
#define    ETX    0x03
#define    ENQ    0x05
#define    DLE    0x10

#define    ACK    0x06
#define    NAK    0x15
#define    CAN    0x18		/* Abnormal End */
#define    ETB    0x17		/* Near End */
#define    DC3    0x13
#define    SUB    0x1A		/* Active */
#define    BON    0x1C		/* Active */
#define    DC4    0x14
#define    DC2    0x12
#define    BEL    0x07

#define    DEV    0xC6

/*----------------------------------------------------------------------*
 * Definition Order
 *----------------------------------------------------------------------*/
typedef enum {
	ACX_NOT_ORDER	= 0,
	ACX_STATE_READ,
	ACX_STATE_GET,
	ACX_STATE_SET,
	ACX_DATETIMESET,
	ACX_STOCK_READ,
	ACX_STOCK_GET,
	ACX_CHANGE_OUT,
	ACX_SPECIFY_OUT,
	ACX_ANS_READ,
	ACX_RESET,		//10
	ACX_RESULT_GET,
	ACX_ENUM_READ,
	ACX_ENUM_GET,
	ACX_SSW_SET,
	ACX_CIN_READ,
	ACX_CIN_GET,
	ACX_CIN_READ_RES,
	ECS_CIN_READ,
	ECS_CIN_READ_RES,
	ECS_CIN_STATE_READ,	//20
	ECS_CIN_STATE_RES,
	SST_CIN_READ,
	SST_CIN_READ_RES,
	SST_CIN_STATE01,
	SST_CIN_STATE01_RES,
	SST_CIN_STATE80,
	SST_CIN_STATE80_RES,
	ACB_STATE80,
	ACB_STATE80_RES,
	ACB_STATE80_GET,	//30
	ECS_STATE_READ,
	ECS_STATE_RES,
	ECS_STATE_GET,
	SST_STATE01,
	SST_STATE01_RES,
	SST_STATE01_GET,
	SST_STATE80,
	SST_STATE80_RES,
	SST_STATE80_GET,
	ACX_START,		//40
	ACX_START_GET,
	ACX_STOP,
	ACX_END,
	ACX_CANCEL,
	ACX_PICKUP,
	ECS_OPE_SET,
	ACX_DRW_OPEN,
	ECS_DRW_READ,
	ECS_DRW_GET,
	ACX_CHANGE_OUT_GET,	//50
	ACX_PICKUP_GET,
	FAL2_CIN_READ,
	FAL2_CIN_READ_RES,
	ACB_STATE_LASTDATA,
	ACB_STATE_LASTDATA_RES,
	ACB_STATE_LASTDATA2,
	ACB_STATE_LASTDATA2_RES,
	ACB_STATE_LASTDATA_GET,
	ACX_CALCMODE_SET,
	ACX_CALCMODE_CHK,	//60
	ACX_CALCMODE_GET,
	ECS_RAS_SETTING_READ,
	ECS_RAS_SETTING_SET,
	ECS_RAS_SETTING_GET,
	ECS_PAYOUT_READ,
	ECS_PAYOUT_GET,
	ACX_OVERFLOW_MOVE_AUTO_START,
	ACX_OVERFLOW_MOVE_AUTO_01_CMD,
	ACX_OVERFLOW_MOVE_AUTO_01_RES,
	ACX_OVERFLOW_MOVE_AUTO_02_CMD,	//70
	ACX_OVERFLOW_MOVE_AUTO_02_RES,
	ACX_OVERFLOW_MOVE_AUTO_03_CMD,
	ACX_OVERFLOW_MOVE_AUTO_03_RES,
	ACX_OVERFLOW_MOVE_AUTO_04_CMD,
	ACX_OVERFLOW_MOVE_AUTO_04_RES,
	ACX_OVERFLOW_MOVE_AUTO_05_CMD,
	ACX_OVERFLOW_MOVE_AUTO_05_RES,
	ACX_OVERFLOW_MOVE_AUTO_06_CMD,
	ACX_OVERFLOW_MOVE_AUTO_06_RES,
	ACX_OVERFLOW_MOVE_AUTO_07_CMD,	//80
	ACX_OVERFLOW_MOVE_AUTO_07_RES,
	ACX_OVERFLOW_MOVE_AUTO_08_CMD,
	ACX_OVERFLOW_MOVE_AUTO_08_RES,
	ACX_OVERFLOW_MOVE_AUTO_09_CMD,
	ACX_OVERFLOW_MOVE_AUTO_09_RES,
	ACX_OVERFLOW_MOVE_AUTO_FINISH,
	ACX_CIN_END,
	ACX_CIN_END_RES,
	ACX_CIN_END_STATE_READ,
	ACX_CIN_END_STATE_RES,		//90
	ECS_CIN_END,
	ECS_CIN_END_RES,
	ECS_CIN_END_STATE_READ,
	ECS_CIN_END_STATE_RES,
	ECS_CIN_END_MOTION2,
	ECS_CIN_END_MOTION2_RES,
	ECS_CIN_END_MOTION2_STATE_READ,
	ECS_CIN_END_MOTION2_STATE_RES,
	ACX_CIN_END_GET,	//共通
//	ECS_CIN_END_GET,
	ACX_ORDER_RESET = 9999,		//acxにてNOT_ORDERへ変更させる
} ACXPROCNO;

#if ACX_LOG_SPEEDUP
// 釣銭機ログ取得において、釣銭機の状態
typedef enum
{
	ACX_LOG_IDLE = 0, // 初期状態
	ECS_ADDRESS,
	ECS_TRADE,
	ECS_MOVEMENT,
	N8384_GETLOG,
	GETMACCODE,
	GETMACCODE2,
	RAD50_GETLOG,
	RT50_GETLOG,
	RADS1_GETLOG,
	RT10_GETLOG,
	FAL2_GETLOG,
	RT300_GETLOG,
	ACX_LOG_END, // ログ取得終了（正常、異常、中断）
} ACX_LOG_STATE;

// 釣銭機ログ取得において、ログ取得の種類
typedef enum
{
	RAD50RT50 = 0,
	RAD50,
	RT50,
	RADS1RT10,
	RADS1,
	RT10,
	SST1,
	ECS_2000, // ECS通常
	ECS_6000, // ECS詳細
	FAL2,
	RT300,
} ACX_LOG_KIND;

// 釣銭機ログ取得情報
typedef struct
{
	ACX_LOG_STATE	state;			// 状態
	int	*address[7];			// アドレス
	int	*size;				// 取得データバイト数
	ACX_LOG_KIND	Changer_kind;		// ログ取得の種類
	long	data_start;			// 取引ログデータ開始アドレス
	long	data_end;			// 取引ログデータ終了アドレス
	long	log_max;			// 取引ログバイト数
	char	logfilepath[TPRMAXPATHLEN];	// ファイル書き込む先
	long	write_byte;			// 現在のログ書き込みサイズ
	long	start_address;			// ログ書き込み開始アドレス
	uchar	log[256];			// 
	char    buf_trade[TPRMAXPATHLEN];//
	char    buf_movement[TPRMAXPATHLEN];
}ACX_LOGINFO;
#endif

/*--------------------------------------------------------------------------*/
/*	result Definition														*/
/*--------------------------------------------------------------------------*/
/* #define MSG_INPUTERR        1   *//* Inpur Error */
/* #define MSG_FILEUPDATEERR   3   *//* File Update Error */
/* #define MSG_ACRACT          4   *//* SUB (Busy) */
/* #define MSG_CHARGING        6   *//* DC4 (in progress) */
/* #define MSG_ACRLINEOFF      7   *//* Lineoff (not connected) */
/* #define MSG_ACRERROR        8   *//* Illegal Response */
#define MSG_ACROK           0   /* Normal End */
#define MSG_ACRSENDERR    (-1)  /* Send Error */
#define MSG_ACRFLGERR       2   /* Flag Error */
#define MSG_ACRCMDERR     (-2)  /* Command Send Error */
#define MSG_SETTEINGERR     5   /* DC3 (Setting Error) */
#define MSG_ACRCAN          9   /* CAN (Abnornal End) */
#define MSG_ACRNAK          10  /* NAK (Not Ack) */
#define MSG_ACTTMOUT        11  /* TIME OUT */
#define MSG_ACRDATAERR      12  /* Terminal Data Error */

/*--------------------------------------------------------------------------*/
/*	Command Definition														*/
/*--------------------------------------------------------------------------*/
#define		ACR_RESET		0x30
#define		ACR_COINOUT		0x31
#define		ACR_INSPECT		0x32
#define		ACR_CLEAR		0x33
#define		ACR_MEMREAD		0x34
#define		ACR_SPECOUT		0x35
#define		ACR_CONNECTMODE		0x36
#define		ACR_DATETIMESET		0x37
#define		ACR_PICKUP		0x38
#define		ACR_SSWSET		0x3A
#define		ACR_STATEREAD		0x3B
#define		ACR_SSWSET2		0x3F
#define		ACR_CINREAD		0x41
#define		ACR_CINSTART		0x45
#define		ACR_CINEND		0x46
#define		ACR_CINSTOP		0x47
#define		ACR_CINRESTART		0x48
#define		ACR_CALCLATEMODE	0x49
#define		ACR_LOCALOPEBAN		0x4C
#define		ACR_DRWOPEN		0x50
#define		ACR_CLOSE		0x52
#define		ACR_COININSERT		0x53
#define		ACR_MENTE_IN		0x54
#define		ACR_MENTE_OUT		0x55
#define		ACR_MENTE_SPECOUT	0x56
#define		ACR_OUTERR_IN		0x57
#define		ACR_CLOSE_DATAREAD	0x59

#define		ECS_CINSTART		0x46
#define		ECS_STATEREAD		0x48
#define		ECS_CALCLATEMODE	0x49
#define		ECS_DOWNLOAD		0x4D
#define		ECS_PROGRAMLOAD		0x4E
#define		ECS_ENDDOWNLOAD		0x4F
#define		ECS_CINCONTINUE		0x50
#define		ECS_OPESET		0x51
#define		ECS_SETTINGREAD		0x57
#define		ECS_VERREAD		0x5A
#define		ECS_DRWREAD		0x5B
#define		ECS_DRWOPEN		0x5C
#define		ECS_CINEND		0x5F
#define		ECS_RECALC		0x66
#define		ECS_LOGREAD		0x6A
#define		ECS_COINOUT6DIGIT	0x6D
#define		ECS_CINREAD		0x6F
#define		ECS_PICKUP		0x70
#define		ECS_DATETIMESET		0x72
#define		ECS_SPEEDCHG		0x7D
#define		ECS_MODELREAD		0x3A
#define		ECS_PAYOUTREAD		0x71

#define		SST1_STATEREAD		0x3B
#define		SST1_CINCANCEL		0x4A
#define		SST1_LOGREAD		0x4B
#define		SST1_DATETIMESET	0x4C
#define		SST1_COINCLEAR		0x4D
#define		SST1_FLGCLEAR		0x4E
#define		SST1_CONNECTON		0x99

#define		FAL2_CINSTART		0x45
#define		FAL2_CINEND		0x80
#define		FAL2_STATESENSE		0x83
#define		FAL2_RASDATAGET		0x84
#define		FAL2_HOLDERSETREAD	0x86
#define		FAL2_STATESETREAD	0x87
#define		FAL2_IDSETREAD		0x88
#define		FAL2_LIFEDATACLEAR	0x89
#define		FAL2_VERREAD		0x8A
#define		FAL2_LOCALLOGREAD	0x8B
#define		FAL2_MEMREAD		0x8E
#define		FAL2_BILLMODEWRITE	0x8F
#define		FAL2_SENSORDATAREAD	0x90
#define		FAL2_SENSORADJUST	0x91
#define		FAL2_STOCKREAD		0x92
#define		FAL2_COININSERT		0x93
#define		FAL2_AUTOINSPECT	0x94
#define		FAL2_SHUTTERCONTROL	0x95
#define		FAL2_BUZZERCONTROL	0x96
#define		FAL2_SCLEANDATAGET	0x97

#define		RT300_LOGREAD		0x3D

/*--------------------------------------------------------------------------*/
/*	Coin/Bill Changer or Coin Changer discrimination Definition		    	*/
/*--------------------------------------------------------------------------*/
#define		ACR_COINBILL	0x01
#define		ACR_COINONLY	0x02

#define	    LINEBUFSIZ		 260

#define         ACB_10          1
#define         ACB_20          2
#define         ACB_50_         4
#define         ECS             8
#define         SST1            16
#define         ACB_200         32
#define			FAL2			64
#define         RT_300			128
#define			ECS_777			256

#define         RT_300_X	RT_300
#define         ACB_200_X       (ACB_200 + RT_300_X)
#define         ACB_50_X        (ACB_50_ + ACB_200_X)
#define         ACB_20_X        (ACB_20 + ACB_50_X)

#define		ECS_X	(ECS + ECS_777)



#define		ACX_OVERFLOW_MOV_FILE	"acx_overflow_mov.txt"
#define		ACX_OVERFLOW_MOV_PATH	"/pj/tprx/tmp/"ACX_OVERFLOW_MOV_FILE
#define		ACX_OVERFLOW_LINE_LABEL	"****************************************"
#define		ACX_OVERFLOW_TIME_LABEL	"time="
#define		ACX_OVERFLOW_TYPE_LABEL	"type="
#define		ACX_OVERFLOW_CNT_LABEL	"count="
#define		ACX_OVERFLOW_PRC_LABEL	"price="



enum ACX_DATA_TYPE
{
	ACX_DATA_NON = 0,
	ACX_DATA_COIN,
	ACX_DATA_BILL,
	ACX_DATA_COINBILL,
};

enum ACR_UNIT_CMD
{
    COIN_CMD = 0,
    BILL_CMD,
};

enum ACR_CONNECT_RAD
{
    ACR_RAD_CONNECT = 0,
    ACR_RAD_CUT,
};

enum ACR_CONNECT_ACR
{
    ACR_ACR_CONNECT = 0,
    ACR_ACR_CUT,
};

enum ACR_CALC_FLAG
{
    ACR_CALC_ENQ = 0,
    ACR_CALC_SET,
};

enum ACR_CALC_MODE
{
    ACR_CALC_MANUAL = 0,
    ACR_CALC_AUTO,
    ACR_CALC_CTRL,
};

enum ACR_CLOSE_TYP
{
    ACR_CLOSE_TYP_CHG = 0,
    ACR_CLOSE_TYP_CLS,
};

enum ACR_PICK {
    ACR_PICK_NON = 0,
    ACR_PICK_10000,
    ACR_PICK_5000,
    ACR_PICK_2000,
    ACR_PICK_1000,
    ACR_PICK_500,
    ACR_PICK_100,
    ACR_PICK_50,
    ACR_PICK_10,
    ACR_PICK_5,
    ACR_PICK_1,
    ACR_PICK_ALL,
    ACR_PICK_LEAVE,
    ACR_PICK_DATA,
    ACR_PICK_CASET,
};

enum SST1_LOG
{
    SST1_LOG_FIRST = 0,
    SST1_LOG_MIDDLE,
	SST1_LOG_LASTONRY,
};

enum SST1_FLGCLR
{
    SST1_FCLR_BILL = 0,
    SST1_FCLR_COIN,
};

enum ACR_LOCALOPEBAN_FLG
{
    ACR_LOCALOPEBAN_YES = 0,
    ACR_LOCALOPEBAN_NO,
};

enum ACR_DRAWER_LOCK_FLG
{
    ACR_DRW_NON    = 0,
    ACR_DRW_UNLOCK,
    ACR_DRW_LOCK,
};

enum CHGPICK_BTN
{
   BTN_OFF = 0,
   ALLBTN_ON,
   RESERVEBTN_ON,
   MANBTN_ON,
   BILLBTN_ON,
   COINBTN_ON,
   USERDATABTN_ON,
   FULLBTN_ON,
   CASETBTN_ON,
};

enum ACXREAL_STEP
{
	ACXREAL_STEP_NON = 0,
	ACXREAL_STEP_RESWAIT,
	ACXREAL_STEP_RESGET,
};

enum ACX_CALC_TYPE
{
	ACX_CALC_ALL = 0,
	ACX_CALC_COIN,
	ACX_CALC_BILL,
};

enum ACX_OVERFLOW_MOVE_MODE
{
	ACX_OVERFLOW_MOVE_AUTO = 0,			//自動で回収（ニアフル休止中等にて裏で実行）
	ACX_OVERFLOW_MOVE_MANU,				//手動で回収（ｵｰﾊﾞｰﾌﾛｰ庫移動キーを使用）
	ACX_OVERFLOW_MOVE_MENTE_PICK_RECALC,		//手動で回収<回収前の精査>（ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽキーを使用）
	ACX_OVERFLOW_MOVE_MENTE_PICK_RECALC_END,	//手動で回収<精査完了>（ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽキーを使用）
};

enum ACX_OVERFLOW_MENTE_EXEC_TYPE
{
	ACX_OVERFLOW_MENTE_SELECT_NON = 0,
	ACX_OVERFLOW_MENTE_SELECT_PICK,		//回収選択実行
	ACX_OVERFLOW_MENTE_SELECT_CIN,		//補充選択実行
};

/*--------------------------------------------------------------------------*/
/* 	Prototype definition                                                    */
/*--------------------------------------------------------------------------*/
int LtoAddr(uchar *address, long ldata);
long AddrtoL(uchar *address);
short if_acx_ChangeOut( TPRTID src, uchar Changer_flg , uint mChange );
short if_acx_StockRead( TPRTID src, uchar Changer_flg );
short if_acx_StockGet( TPRTID src, uchar Changer_flg ,
                           COINDATA *CoinData , tprmsgdevreq2_t *Rcvbuf );
short if_acx_SpecifyOut( TPRTID src, uchar Changer_flg , long mChange );
short if_acx_ShtSpecifyOut( TPRTID src, uchar Changer_flg , CBILLKIND cbillkind );
short if_acx_AnswerRead( TPRTID src, uchar Changer_flg );
short if_acx_ResultGet(TPRTID src, tprmsgdevreq2_t *Rcvbuf);
short if_acx_StateRead( TPRTID src, uchar Changer_flg );

short if_acx_nearend_chk(void);
short if_acx_nearfull_chk(void);
short if_acx_nearfull_chk_main(int typ);
long  if_acx_ShtPriceData( CBILLKIND cbillkind, short type);
long  if_acx_CinPriceData( short acb_select );
char  *if_acx_PickData_LabelGet( int status );
char  *if_acx_StockStatus_LabelGet( int status );
short if_acx_StockStateChk( STOCK_STATE stock_state );

short if_acr_Reset(TPRTID src);
short if_acr_Clear( TPRTID src );
short if_acr_MemoryRead( TPRTID src, char *adress );
short if_acx_sswSet( TPRTID src, short sswno );
#if 0
short if_acr_MemoryGet( TPRTID src, uchar *ptData, tprmsgdevreq2_t *Rcvbuf );
#endif
short if_acb_DateTimeSet(TPRTID src);
short if_acx_DateTimeSet( TPRTID src, uchar Changer_flg );
short if_acb200_DateTimeSet(TPRTID src);
short if_acb_ErrlogRead( TPRTID src, ushort BlockNo );
short if_acb_ErrlogGet( TPRTID src, ERRLOGDATA *ErrlogData , tprmsgdevreq2_t *Rcvbuf );
short if_acb_OplogRead( TPRTID src, ushort BlockNo );
short if_acb_OplogGet( TPRTID src, OPLOGDATA *ptOplogData , tprmsgdevreq2_t *Rcvbuf );
short if_acb_StateSet(TPRTID src, NEAREND *nearend);
short if_acb_NearRead( TPRTID src );
short if_acb_NearGet( TPRTID src,  NEARDATA *ptNearData, tprmsgdevreq2_t *Rcvbuf );
short if_acx_Transmit(TPRTID src, int InOut, size_t len, uchar *SendData);
short if_acx_RcvDLEChk(TPRTID src, uchar Rcvdata);
short if_acx_RcvHeadChk(TPRTID src, tprmsgdevack2_t *RcvBuf);
short if_acx_ResultChk(TPRTID src, uchar Rcvdata);
short if_acb_StockRead(TPRTID src);
short if_acr_StockRead(TPRTID src);
short if_acb10_SpecifyOut( TPRTID src, long mChange );
short if_acr_SpecifyOut( TPRTID src, long mChange );
short if_acr_ShtSpecifyOut( TPRTID src, CBILLKIND cbillkind );
ushort if_acb_RepacData( uchar *Rcvdata );
void if_acx_DecToAscii(TPRTID src, int IntDec, uchar *AsciiData);
short if_acb_StateGet(TPRTID src, STATEDATA *ptStateData , tprmsgdevreq2_t *Rcvbuf);
short if_acr_StateGet(TPRTID src, tprmsgdevreq2_t *Rcvbuf);
short if_acx_StateGet( TPRTID src, uchar Changer_flg,
                        STATEDATA *ptStatedata , tprmsgdevreq2_t *Rcvbuf  );
ushort if_acx_repack(TPRTID src, uchar *Rcvdata);
void if_acb10_StockGet( TPRTID src, COINDATA *CoinData , uchar *Rcvdata );
void if_acr_StockGet( TPRTID src, COINDATA *CoinData , uchar *Rcvdata );
short if_acb10_StateRead( TPRTID src );
short if_acr_StateRead( TPRTID src );
short if_acb10_ChangeOut( TPRTID src, uint mChange );
short if_acr_ChangeOut( TPRTID src, uint mChange );
short if_acb_EnumRead( TPRTID src, char flag );
short if_acb_EnumGet( TPRTID src,  ENUMDATA *ptEnumData, tprmsgdevreq2_t *Rcvbuf );
short if_acr_Change( TPRTID src, char ChgFlag );

void  if_acb20_StockGet( TPRTID src, COINDATA *CoinData , uchar *Rcvdata );
short if_acr20_StateRead( TPRTID src );
short if_acb20_ChangeOut( TPRTID src, uint mChange );
short if_acb20_SpecifyOut( TPRTID src, long mChange );
short if_acb20_ShtSpecifyOut( TPRTID src, CBILLKIND cbillkind );
short if_sst1_SpecifyOut( TPRTID src, long mChange );
short if_sst1_ShtSpecifyOut( TPRTID src, CBILLKIND cbillkind );
short if_acx_MemoryRead( TPRTID src, char *adress, uchar Changer_flg );
short if_acx_MemoryGet( TPRTID src, uchar *ptData, tprmsgdevreq2_t *Rcvbuf);
short if_acb10_StateSet(TPRTID src, NEAREND *nearend);
short if_acb20_StateSet(TPRTID src);
short if_acb20_sswSet(short sswno);
short if_acb20_sswCmdSend(TPRTID src, short kind, uchar sswno, uchar setdata);

short if_acx_CinStart( TPRTID src, uchar Changer_flg );
short if_acr_CinStart( TPRTID src);
short if_acb20_CinStart( TPRTID src);
short if_acx_CinStop( TPRTID src, uchar Changer_flg );
short if_acr_CinStop( TPRTID src );
short if_acb20_CinStop( TPRTID src);
short if_acx_CinEnd( TPRTID src, uchar Changer_flg );
short if_acr_CinEnd( TPRTID src);
short if_acb20_CinEnd( TPRTID src);
short if_acx_CinReStart( TPRTID src, uchar Changer_flg );
short if_acr_CinReStart( TPRTID src);
short if_acb20_CinReStart( TPRTID src);
short if_acx_CinRead( TPRTID src, uchar Changer_flg );
short if_acr_CinRead( TPRTID src);
short if_acb20_CinRead( TPRTID src);

short if_acx_CinReadGet(TPRTID src, uchar Changer_flg, CININFO *CinInfo, tprmsgdevreq2_t *Rcvbuf);
void if_acr_CinReadGet( TPRTID src, CININFO *CinInfo , uchar *Rcvdata );
void if_acb20_CinReadGet( TPRTID src, CININFO *CinInfo , uchar *Rcvdata );

short if_acx_ConnectModeSet( TPRTID src, uchar Changer_flg, uchar rad, uchar acr);
short if_acx_CalcModeSet( TPRTID src, uchar Changer_flg, uchar motion, uchar mode);
short if_acx_CalcModeGet(TPRTID src, uchar Changer_flg, uchar *mode, tprmsgdevreq2_t *Rcvbuf);

short if_acb_ssw14Set(TPRTID src);
short if_acb_ssw14_7Set(TPRTID src, short ssw14_7);
short if_acb_ssw50Set(TPRTID src);
short if_acb_ssw15Set(TPRTID src);

short if_acx_Pickup( TPRTID src, uchar Changer_flg , PICK_DATA pick_data );
short if_acr_Pickup( TPRTID src, PICK_DATA pick_data );
short if_acb20_Pickup( TPRTID src, PICK_DATA pick_data);

short if_acb_select(void);

short if_acx_LocalOpeBanSet( TPRTID src, uchar Changer_flg, uchar motion );
short if_acx_drwopen( TPRTID src, short data );

short if_acx_cmd_skip(TPRTID src, const char *func);
short if_acx_CoinInsert( TPRTID src );
short if_acx_CloseWrite( TPRTID src, uchar Changer_flg, uchar mode, long long staff_cd);
short if_acx_CloseDataGet( TPRTID src, uchar Changer_flg, CLOSE_DATA *CloseData, tprmsgdevreq2_t *Rcvbuf );
short if_acx_CloseRead( TPRTID src, uchar Changer_flg, short index_no);
short if_acx_OutErr_In( TPRTID src, uchar Changer_flg);
short if_acx_Mente_In(TPRTID src, uchar Changer_flg);
short if_acx_Mente_Out( TPRTID src, uchar Changer_flg , uint mChange );
short if_acx_Mente_SpecifyOut( TPRTID src, uchar Changer_flg , long mChange );
short if_acx_Mente_ShtSpecifyOut( TPRTID src, uchar Changer_flg , CBILLKIND cbillkind );
short if_acb_State_LastDataRead(TPRTID src, short type);
short if_acb_State_LastDataGet( TPRTID src, short type, LAST_DATA *LastData, tprmsgdevreq2_t *Rcvbuf );

/* 富士電機製釣銭釣札機ライブラリ */
short if_ecs_CinStart( TPRTID src, CINSTART_ECS CinStartEcs );
short if_ecs_CinEnd( TPRTID src, short total_sht, short motion );
short if_ecs_CinRead( TPRTID src );
short if_ecs_CinReadGet( TPRTID src, CINREAD_ECS *CinReadEcs, tprmsgdevreq2_t *Rcvbuf );
short if_ecs_Pickup( TPRTID src, PICK_ECS PickEcs );
short if_ecs_CinContinue( TPRTID src );
short if_ecs_StateRead( TPRTID src );
short if_ecs_StateGet( TPRTID src, STATE_ECS *StateEcs, tprmsgdevreq2_t *Rcvbuf );
short if_ecs_ReCalc( TPRTID src, short motion );
short if_ecs_ReCalcGet( TPRTID src, RECALCDATA *recalc, tprmsgdevreq2_t *Rcvbuf );
short if_ecs_CalcModeSet( TPRTID src, short mode );
//short if_ecs_OpeSetGp2( TPRTID src, short bill1000, short bill2000, short bill5000, short bill10000 );
//short if_ecs_OpeSetGp7( TPRTID src, short recalc_bill_mov);
//short if_ecs_OpeSetGpB( TPRTID src, short recalc_reject );
short if_ecs_OpeSet( TPRTID src, char mode, char *data );
short	if_ecs_OpeSet_Expansion( TPRTID src, char *mode, char *data );
short if_ecs_DateTimeSet( TPRTID src );
short if_ecs_MemoryRead( TPRTID src, char *address, char *size );
short if_ecs_MemoryGet( TPRTID src, LOGDATA_ECS *LogDataEcs, tprmsgdevreq2_t *Rcvbuf );
short if_ecs_DrwRead( TPRTID src );
short if_ecs_DrwGet( TPRTID src, STATE_ACXDRW *StateAcxDrw, tprmsgdevreq2_t *Rcvbuf );
#if ACX_LOG_SPEEDUP
short if_ecs_SpeedChange(TPRTID src, int mode );
short if_ecs_SpeedGet( TPRTID src ,  tprmsgdevreq2_t *Rcvbuf);
#endif
short   if_ecs_VersionRead( TPRTID src );
short   if_ecs_VersionReadGet( TPRTID src , tprmsgdevreq2_t *Rcvbuf , uchar *ecs_fw_Ver);
short   if_ecs_SettingRead( TPRTID src  , char mode);
short   if_ecs_SettindReadGet( TPRTID src , tprmsgdevreq2_t *Rcvbuf , uchar *ecs_set);
short	if_ecs_SettingRead_Expansion( TPRTID src, char *mode);
short	if_ecs_SettingReadGet_Expansion( TPRTID src , tprmsgdevreq2_t *Rcvbuf , uchar *ecs_set);
short   if_ecs_Download( TPRTID src , int type , uchar *data);
short   if_ecs_DownloadGet( TPRTID src , tprmsgdevreq2_t *Rcvbuf );
short   if_ecs_ProgramDownload( TPRTID src , int no , uchar *data );
short   if_ecs_EndDownload( TPRTID src );
short	if_ecs_PayOutRead( TPRTID src );
short	if_ecs_PayOutReadGet( TPRTID src, ECS_PAYOUT *EcsPayOut, tprmsgdevreq2_t *Rcvbuf );


/* ＮＥＣ製釣銭釣札機ライブラリ */
short if_sst1_DateTimeSet( TPRTID src );
short if_sst1_CinCancel( TPRTID src );
short if_sst1_CinCancelGet( TPRTID src, CINCANCEL_SST1 *CinCancelSst1, tprmsgdevreq2_t *Rcvbuf );
short if_sst1_LogRead( TPRTID src, uchar motion );
short if_sst1_LogGet( TPRTID src, LOGDATA_SST1 *LogDataSst1, tprmsgdevreq2_t *Rcvbuf );
short if_sst1_CoinClear( TPRTID src );
short if_sst1_FlgClear( TPRTID src, uchar bill_coin );
short if_sst1_CnctModeSet_Reset( TPRTID src );
short if_sst1_State80_Read( TPRTID src );
short if_sst1_State80_Get( TPRTID src, STATE_SST1 *StateSst1, tprmsgdevreq2_t *Rcvbuf );
short if_sst1_State01_Read( TPRTID src );
short if_sst1_State01_Get( TPRTID src, STATE_SST1 *StateSst1, tprmsgdevreq2_t *Rcvbuf );
short if_acb_State80_Read( TPRTID src );
short if_acb_State80_Get( TPRTID src, STATE_ACB *StateAcb, tprmsgdevreq2_t *Rcvbuf );

/* ＮＥＣ製釣銭釣札機(FAL2)ライブラリ */
short if_fal2_CinEnd( TPRTID src, short motion );
short if_fal2_StatSense( TPRTID src, short type, short mode );
short if_fal2_StatSenseGet( TPRTID src, STATE_FAL2 *Statefal2, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_StatSenseGet_UnitInfoChk( TPRTID src, STATE_FAL2 *StateFal2, char *device_stat );
short if_fal2_StatSenseGet_InOutSensorChk( TPRTID src, STATE_FAL2 *StateFal2 );
short if_fal2_RASRead( TPRTID src, short num );
short if_fal2_RASReadGet( TPRTID src, short num, FAL2_RASDATA *RasData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_HolderSetRead( TPRTID src, short flag, short target, short full, short nearfull, short nearend );
short if_fal2_HolderSetReadGet( TPRTID src, FAL2_HOLDER_STATE *HolderState, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_StateSetRead( TPRTID src, short flag, short num, uchar *status );
short if_fal2_StateSetReadGet( TPRTID src, FAL2_ENVIRONMENT *EnvData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_IDSetRead( TPRTID src, short flag, uchar *chg_id, uchar *bill_id, uchar *coin_id );
short if_fal2_IDSetReadGet( TPRTID src, FAL2_ID *IDData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_LifeDataClear( TPRTID src, short target, short num );
short if_fal2_VersionRead( TPRTID src );
short if_fal2_VersionReadGet( TPRTID src, FAL2_VERSION *VerData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_LocalLogRead( TPRTID src, short type, int size );
short if_fal2_LocalLogReadGet( TPRTID src, uchar *log_info, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_MemRead( TPRTID src, uchar *address, short length );
short if_fal2_MemReadGet( TPRTID src, uchar *MemData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_BillModeWrite( TPRTID src, short mode );
short if_fal2_SensorAdjDataRead( TPRTID src, short type );
short if_fal2_SensorAdjDataReadGet( TPRTID src, FAL2_SENSORADJ *SensorData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_SensorAdj( TPRTID src, short unit );
short if_fal2_StockRead( TPRTID src );
short if_fal2_StockGet( TPRTID src, COINDATA *CoinData, uchar *Rcvdata );
short if_fal2_CoinInsert( TPRTID src );
short if_fal2_AutoInspect( TPRTID src, short unit, short plan );
short if_fal2_ShutterCtrl( TPRTID src, short cmd );
short if_fal2_BuzzerCtrl( TPRTID src, short cmd, short ontime, short offtime, short retry );
short if_fal2_SensorCleanRead( TPRTID src );
short if_fal2_SensorCleanReadGet( TPRTID src, FAL2_SENSORCLEAN *SCleanData, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_ResultGet( TPRTID src, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_ResFormatChk( TPRTID src, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_DownloadStart( TPRTID src, short type );
short if_fal2_DownloadStartGet( TPRTID src, tprmsgdevreq2_t *Rcvbuf );
short if_fal2_Download( TPRTID src, int num, short type, int length, uchar *data );
short if_fal2_DownloadGet( TPRTID src, uchar *rslt, tprmsgdevreq2_t *Rcvbuf );
int   if_fal2_StSsGet_ChgDataInfo( TPRTID tid, uchar *data, FAL2_CHGINFO *ChgInfo );

short if_rt300_MemoryGet( TPRTID src, uchar *ptData, tprmsgdevreq2_t *Rcvbuf );
short if_rt300_MemoryRead( TPRTID src);
short if_acx_RjctChk( TPRTID src, COINDATA *CoinData);
#endif
/* end of if_acx.h */
