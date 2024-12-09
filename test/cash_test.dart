/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// import 'package:flutter_pos/app/regs/checker/rc_stl_cal.dart';
// import 'package:flutter_pos/app/regs/checker/rc_touch_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

enum Test { A, B }

Future<void> main() async {
  Test a = Test.A;
  debugPrint("before ${a.name}");
  test(a);
  debugPrint("after ${a.name}");
  // var dbAccess = DbManipulation();
  // await dbAccess.openDB();
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const BackEndTestWidget());
  //   await tester.tap(find.byIcon(Icons.add));
  // });
}

void test(Test before) {
  before = Test.B;
  debugPrint("method ${before.name}");
}
//
// class BackEndTestWidget extends HookConsumerWidget {
//   const BackEndTestWidget({super.key});
//
//   /// メイン処理
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter Demo'),
//         ),
//         body: const Center(
//           child: Text('backendTest'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             test(ref);
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
//
//   Future<void> test(WidgetRef ref) async {
//     // テストコードを記載する.
//     // 商品登録.
//     //await testPlu(ref);
//
//     // 小計計算.
//     // await testSTLCalc(ref);
//     // 訂正.
//     // await testDelete(ref);
//
//     //現計計算
//     //await testCash(ref);
//
//     printItem();
//   }
//
//   /// 商品登録テストコード-
//   Future<void> testPlu(WidgetRef ref) async {
//     // // 1.pluを指定せずに呼び出す.
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyPlu.keyId, null);
//     // //
//     // // 2.DBに存在しないpluを指定する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "0234567890101");
//     //
//     // // 3.DBに存在するpluを指定する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     //
//     // 4.既に1件以上登録がある状態 pluを指定せずに呼び出す
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyPlu.keyId, null);
//     //
//     // 5.既に1件以上登録がある状態 DBに存在しないpluを指定する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "0234567890101");
//
//     // 6.既に1件以上登録がある状態.前回登録したものを同じIDで登録
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     //
//     // 7.既に1件以上登録がある状態.前回登録したものを別IDで登録
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890102");
//     //
//     // 8.1件目の登録処理が終わっていないうちに2件目を登録しようとする
//     Future<void> result =
//         TchKeyDispatch.rcDTchByKeyId(FuncKey.keyPlu.keyId, "1234567890101");
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyPlu.keyId, "1234567890102");
//     await result;
//   }
//
//   /// 訂正テストコード-
//   Future<void> testDelete(WidgetRef ref) async {
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyPlu.keyId, "1234567890101");
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyPlu.keyId, "1234567890102");
//     // // 1.直前に登録された訂正されていないものを直前訂正する
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCorr.keyId, null);
//     // printItem();
//     // // 2.既に直前訂正済みのものを直前訂正する
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCorr.keyId, null);
//
//     // 3.指定訂正済みのものを直前訂正する
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 2);
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCorr.keyId, null);
//
//     // 4.直前訂正されているものを指定訂正する
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCorr.keyId, null);
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 2);
//
//     //5.直前訂正されていないものを指定訂正する
//     //  await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 2);
//
//     //6 指定訂正されているものをもう一度指定訂正する
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 1);
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 1);
//
//     //7 登録されている商品数を超えたIDを指定して指定訂正する
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyVoid.keyId, 3);
//   }
//
//   /// 小計テストコード-
//   Future<void> testSTLCalc(WidgetRef ref) async {
//     // 小計計算.1
//
//     // 1.何もない状態で小計計算.
//     //StlItemCalcMain.rcStlItemCalcMain(ref, StlCalc.incMbrRbt);
//
//     // 2.訂正された商品がなく、複数個登録している状態で小計計算処理を実行する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890102");
//     // StlItemCalcMain.rcStlItemCalcMain(ref, StlCalc.incMbrRbt);
//
//     // // 3.直前訂正された商品が1つ以上ある状態で小計計算処理を実行する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890102");
//     // // 直前訂正
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCorr.keyId, null);
//
//     // 4.指定訂正された商品が一つ以上ある状態で小計計算処理を実行する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890102");
//     // // 指定訂正
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 2);
//
//     // // 5.直前訂正と指定訂正された商品がある状態で小計計算処理を実行する
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890102");
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890101");
//     // // 指定訂正
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyVoid.keyId, 2);
//     // // 直前訂正
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCorr.keyId, null);
//
//     // 6.全ての商品を訂正した状態で小計計算処理を実行する
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyPlu.keyId, "1234567890102");
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyPlu.keyId, "1234567890101");
//     // 指定訂正
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyVoid.keyId, 1);
//     // 直前訂正
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyCorr.keyId, null);
//
//     // 合計計算処理呼び出し.
//     StlItemCalcMain.rcStlItemCalcMain(StlCalc.incMbrRbt);
//   }
//
//   /// 現計テストコード
//   Future<void> testCash(WidgetRef ref) async {
//     // テストコードを記載する.
//     // 1.何もない状態で現計.
//     await TchKeyDispatch.rcDTchByKeyId(FuncKey.keyCash.keyId, null);
//     // 2.商品を登録した状態で現計処理
//     // await TchKeyDispatch.rcDTchByKeyId(
//     //     ref, FuncKey.keyPlu.keyId, "1234567890102");
//     // await TchKeyDispatch.rcDTchByKeyId(ref, FuncKey.keyCash.keyId, null);
//   }
//
//   void printItem() {
//     RegsMem mem = RegsMem();
//     debugPrint("------------------------------------------");
//     debugPrint("アイテム数:${mem.tTtllog.getItemLogCount()}");
//     debugPrint("小計価格:${mem.tTtllog.getSubTtlTaxInAmt()}");
//
//     debugPrint("▼▼▼アイテム情報▼▼▼");
//     int i = 0;
//     int nullStart = -1;
//     for (int i = 0; i < mem.tItemLog.length; i++) {
//       TItemLog? item = mem.tItemLog[i];
//       if (item == null) {
//         nullStart = i;
//         continue;
//       } else if (nullStart != -1) {
//         if (nullStart == i - 1) {
//           debugPrint("★アイテム[$nullStart]:null");
//         } else {
//           debugPrint("★アイテム[$nullStart~$i]:null");
//         }
//         nullStart = -1;
//       }
//       debugPrint("★アイテム[$i]:${item.getSeqNo()}");
//       debugPrint("plu:${item.t10000.pluCd1_1}:${item.getItemName()}");
//       debugPrint("qty:${item.getItemQty()}");
//       debugPrint("price:${item.getItemPrc()}");
//       debugPrint("tax:${item.getItemTaxStr()}");
//       debugPrint("deleteType:${item.getDeletedKind()}");
//     }
//     debugPrint("▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲");
//   }
//}
