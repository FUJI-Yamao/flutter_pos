/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: apl_cnv.h - enum DATALOG_KIND
enum DataLogKind {
  D_ITEMLOG,
  D_BDLLOG,
  D_STMLOG,
  D_CRDTLOG,
  D_TTLLOG,
  D_LOG_MAX
}

///  関連tprxソース: apl_cnv.h - struct t_LogParam
class TLogParam {
  int	compCd = 0;
  int		streCd = 0;
  /// char		sale_date[9];	/* YYYYMMDD */
  String		saleDate = '';
  int		macNo = 0;
  int		receiptNo = 0;
  int		printNo = 0;
  /// char		*pIPaddr;		/* db_WebLogin()で使用 */
  String		pIPaddr = '';
  /// postgresのコネクション変数　　PGconn		*localCon;	/* main:4 で使用する. */
  var localCon;
  /// char		temp_name[32];	/* main:4 で使用する. 再作成などで作成したテンポラリテーブル名 */
  String	tempName = '';
  /// char		*tableDateName;	// 99日返品
  String	tableDateName = '';
}

///  関連tprxソース: apl_cnv.h - struct t_log_sts
class TLogSts {
  int posi = 0;
  double data = 0.0;
  int dataTyp = 1;	/* 0:short 1:int 2:long 3:double 4:char 5:char(1) 6:long long*/
  int dataSiz = 0;
}

///  関連tprxソース: apl_cnv.h - struct t_log_data
class TLogData {
  double data = 0.0;
  int dataTyp = 1;	/* 0:short 1:int 2:long 3:double 4:char 5:char(1) 6:long long */
  int dataSiz = 0;
  String logPosiName = "";
  double logPosiData = 0.0;
}

///  関連tprxソース: apl_cnv.h - struct t_log_sts_void
class TLogStsVoid {
  double data = 0.0;
  int dataTyp = 0;  /* data_typ 4 is 0 only , set null */
  int dataSiz = 0;
  int flg = 0;  /* 0:0  1:1  2:minus set */
}

///  関連tprxソース: apl_cnv.h - struct t_log_data_void
class TLogDataVoid {
  double data = 0.0;
  int dataTyp = 0;  /* data_typ 4 is 0 only , set null */
  int dataSiz = 0;
  int flg = 0;  /* 0:0  1:1  2:minus set */
}

///  関連tprxソース: apl_cnv.h - struct t_log_sts_ref
class TLogStsRef {
  double data = 0.0;
  int dataTyp = 0;  /* data_typ 4 is 0 only , set null */
  int dataSiz = 0;
  int flg = 0;  /* 0:0  1:1  2:minus set */
}

///  関連tprxソース: apl_cnv.h - struct t_log_data_ref
class TLogDataRef {
  double data = 0.0;
  int dataTyp = 0;  /* data_typ 4 is 0 only , set null */
  int dataSiz = 0;
  int flg = 0;  /* 0:0  1:1  2:minus set */
}

///  関連tprxソース: apl_cnv.h - struct t_func_data
class TFuncData {
  int funcCd = 0;
  int cnctSeqNoMax = 0;
  int stsNum = 0;
  int stsSiz = 0;
  TLogSts tLogSts = TLogSts();
  int dataNum = 0;
  int dataSiz = 0;
  TLogData tLogData = TLogData();
  int stsVoidNum = 0;
  int stsVoidSiz = 0;
  TLogStsVoid tLogStsVoid = TLogStsVoid();
  int dataVoidNum = 0;
  int dataVoidSiz = 0;
  TLogDataVoid tLogDataVoid = TLogDataVoid();
  int stsRefNum = 0;
  int stsRefSiz = 0;
  TLogStsRef tLogStsRef = TLogStsRef();
  int dataRefNum = 0;
  int dataRefSiz = 0;
  TLogDataRef tLogDataRef = TLogDataRef();

  ///各種パラメタに値を設定する関数
  TFuncData(int funcCd, int cnctSeqNoMax,
      int stsNum, int stsSiz, TLogSts tLogSts,
      int dataNum, int dataSiz, TLogData tLogData,
      int stsVoidNum, int stsVoidSiz, TLogStsVoid tLogStsVoid,
      int dataVoidNum, int dataVoidSiz, TLogDataVoid tLogDataVoid,
      int stsRefNum, int stsRefSiz, TLogStsRef tLogStsRef,
      int dataRefNum, int dataRefSiz, TLogDataRef tLogDataRef) {
    this.funcCd = funcCd;
    this.cnctSeqNoMax = cnctSeqNoMax;
    this.stsNum = stsNum;
    this.stsSiz = stsSiz;
    this.tLogSts = tLogSts;
    this.dataNum = dataNum;
    this.dataSiz = dataSiz;
    this.tLogData = tLogData;
    this.stsVoidNum = stsVoidNum;
    this.stsVoidSiz = stsVoidSiz;
    this.tLogStsVoid = tLogStsVoid;
    this.dataVoidNum = dataVoidNum;
    this.dataVoidSiz = dataVoidSiz;
    this.tLogDataVoid = tLogDataVoid;
    this.stsRefNum = stsRefNum;
    this.stsRefSiz = stsRefSiz;
    this.tLogStsRef = tLogStsRef;
    this.dataRefNum = dataRefNum;
    this.dataRefSiz = dataRefSiz;
    this.tLogDataRef = tLogDataRef;
  }
}
