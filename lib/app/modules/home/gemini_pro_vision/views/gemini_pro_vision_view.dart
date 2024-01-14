import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gemini_pro_vision_controller.dart';

class GeminiProVisionView extends GetView<GeminiProVisionController> {
  const GeminiProVisionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeminiProVisionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GeminiProVisionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
