/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
/// 関連tprxソース: scpu.h
class Scpu {
  String scpucd = ""; //  Always 1 record
  String filler0 = "";
  String filler1 = "";
  String filler2 = "";
  int brgtky = 0; //  10.4 LCD Brightness Key  00H:  ----->  0FH:
  int brgtky2 = 0; //  5.7  LCD Brightness Key  00H:  ----->  0FH:
  int kvlmky = 0; //  key Volume  Key          00H:  ----->  0FH:
  int kvlmky2 = 0; //  key Volume  Key2         00H:  ----->  0FH:
  int pitchky = 0; //  Pitch(Tone) Key          01H:  ----->  08H:
  int pitchky2 = 0; //  Pitch(Tone) Key2         01H:  ----->  08H:
  int scanvlmky = 0; //  scanner Volume Key       00H:  ----->  0FH:
  int scanvlmky2 = 0; //  scanner Volume Key2      00H:  ----->  0FH:
  int scanpitchky = 0; //  scanner Pitch(Tone) key  01H:  ----->  08H:
  int scanpitchky2 = 0; //  scanner Pitch(Tone) key2 01H:  ----->  08H:
  List<int> filler = []; //  FILLER[117]
}
