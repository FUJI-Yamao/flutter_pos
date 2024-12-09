/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// 関連tprxソース:tprtypes.h
///
/// ID Types -----------------------------
typedef TprSCPU = int; // sub cpu ID

/// Task ID
/// 関連tprxソース:TPRTID
typedef TprTID = int;

/// Device ID
/// 関連tprxソース:TPRDID
typedef TprDID = int;

/// IPC Message ID
/// 関連tprxソース:TPRMID
typedef TprMID = int;

//   task status ID
// Stastus Type
typedef TprTST = int; //   task status ID
typedef TprIO = int; //   device I/O
typedef TprStat = int; //   device status
