import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gemini_pro_controller.dart';

class GeminiProView extends GetView<GeminiProController> {
  const GeminiProView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GeminiProView'),
          centerTitle: true,
        ),
        body: controller.obx(
          (state) {
            return ListView.builder(
              itemCount: state!.contents!.length,
              itemBuilder: (context, index) {
                
                return Container(child: Text("asdasd"),);
                // return Container(child: Text(state.contents[index].),);
              },
            );
          },
          onEmpty: Center(
              child: Image.asset(
            "assets/images/paper planes.png",
            width: 100,
          )),
        ));
  }
}
