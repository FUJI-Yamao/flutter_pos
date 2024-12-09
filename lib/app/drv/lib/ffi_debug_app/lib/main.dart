/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'template.dart';
import 'drawer.dart';
import 'mkey.dart';
import 'scanner.dart';
import 'printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFIデバッグ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FFIデバッグ確認'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String strData = '';

  void _btnClick() {
    setState(() {
      String strPrint = '';

      strPrint = "------- Test Start -------\n";
      debugPrint("------- Test Start -------");

      // テンプレートテスト
      //strPrint = test(strPrint, 1); // 期待結果:2
      //strData += strPrint;

      // ドロアI/F-API疎通テスト
      //strPrint = drwTest(strPrint);
      //strData += strPrint;

      // メカキーI/F-API疎通テスト（リアルタイムでデバッグプリント）
      //strPrint = mkeyTest(strPrint);
      //strData += strPrint;

      // スキャナI/F-API疎通テスト（5回イベント送信・受信）
      //strPrint = scnTest(strPrint);
      //strData += strPrint;

      // プリンタI/F-API疎通テスト
      strPrint = ptrTest(strPrint);
      strData += strPrint;

      strPrint = "------- Test Finish -------\n";
      debugPrint("------- Test Finish -------");

      // 画面出力
      strData += strPrint;
    });
  }

  void _btnClickClear() {
    setState(() {
      strData = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '＋ボタンで実行、×ボタンでクリア。',
            ),
            Container(
              padding: EdgeInsets.all(20),
            ),
            Text(
              strData,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up, // childrenの先頭が下に配置されます。
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 1つ目のFAB
          FloatingActionButton(
            onPressed: _btnClickClear,
            tooltip: 'Increment',
            child: const Icon(Icons.clear),
          ),
          // 2つ目のFAB
          Container( // 余白を設けるためContainerでラップします。
            margin: EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: _btnClick,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
