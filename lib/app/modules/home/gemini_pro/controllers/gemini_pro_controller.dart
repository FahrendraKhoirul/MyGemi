import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygemi/app/data/models/gemini_pro_model.dart';
import 'package:mygemi/app/data/services/gemini_services.dart';

class GeminiProController extends GetxController with StateMixin<GeminiPro> {
  var chats = GeminiPro(contents: []).obs;
  Rx<TextEditingController> inputController = TextEditingController().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;

  @override
  void onInit() {
    change(chats.value, status: RxStatus.empty());
    super.onInit();
  }

  void generateContent(String message) async {
    // add to chats
    Contents content = Contents(parts: [Parts(text: message)], role: "user");
    chats.value.contents?.add(content);

    if (chats.value.contents != null) {
      change(chats.value, status: RxStatus.success());
      if (scrollController.value.hasClients) {
        scrollController.value.animateTo(
            scrollController.value.position.extentTotal,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500));
      }
    } else {
      change(chats.value, status: RxStatus.empty());
    }

    // call API and store gemini response to chats
    await GeminiAPI.getGeminiPro(chats.value).then((val) {
      chats.value.contents?.add(val!);
      print("TESSS RESPONSE :" + val!.parts.toString());
    });

    // update UI
    if (chats.value.contents != null) {
      change(chats.value, status: RxStatus.success());
      if (scrollController.value.hasClients) {
        scrollController.value.animateTo(
          scrollController.value.position.extentTotal,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    } else {
      change(chats.value, status: RxStatus.empty());
    }
  }
}
