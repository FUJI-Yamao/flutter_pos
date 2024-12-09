/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///
/// NTT-Data Library 関連ファイル
///  関連tprxソース:cm_md5.h
///


///* POINTER defines a generic pointer type */
// typedef unsigned char *POINTER;
//
// /* UINT2 defines a two byte word */
// typedef unsigned short int UINT2;
//
// /* UINT4 defines a four byte word */
// typedef unsigned long int UINT4;

/* PROTO_LIST is defined depending on how PROTOTYPES is defined above.
If using PROTOTYPES, then PROTO_LIST returns the list, otherwise it
  returns an empty list.
 */

// #if PROTOTYPES
// #define PROTO_LIST(list) list
// #else
// #define PROTO_LIST(list) ()
// #endif

/* MD5.H - header file for MD5C.C
 */

/* Copyright (C) 1991-2, RSA Data Security, Inc. Created 1991. All
rights reserved.

License to copy and use this software is granted provided that it
is identified as the "RSA Data Security, Inc. MD5 Message-Digest
Algorithm" in all material mentioning or referencing this software
or this function.

License is also granted to make and use derivative works provided
that such works are identified as "derived from the RSA Data
Security, Inc. MD5 Message-Digest Algorithm" in all material
mentioning or referencing the derived work.

RSA Data Security, Inc. makes no representations concerning either
the merchantability of this software or the suitability of this
software for any particular purpose. It is provided "as is"
without express or implied warranty of any kind.

These notices must be retained in any copies of any part of this
documentation and/or software.
 */

/* MD5 context. */
// class Md5Ctx {
//   UINT4 state[4];                                   /* state (ABCD) */
//   UINT4 count[2];        /* number of bits, modulo 2^64 (lsb first) */
//   unsigned char buffer[64];                         /* input buffer */
// }

//#if SS_CR2
const CR40_MD5_CREATE = 0;
const CR40_MD5_CHECK  = 1;
//#endif

/* end of cm_md5.h */

