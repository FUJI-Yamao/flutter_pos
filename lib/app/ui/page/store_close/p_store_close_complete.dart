/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/c_store_close_complete_page.dart';

/// 精算完了画面
class StoreCloseCompletePage extends StatelessWidget {
  const StoreCloseCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('精算完了画面'),),
      body: GetBuilder(
        init: StoreCloseCompletePageController(),
        builder: (controller) => const Center(
          child: Column(
            children: [
              // 画面メッセージ
              Text('精算が完了しました', style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}

