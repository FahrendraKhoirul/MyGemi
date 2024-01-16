import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygemi/app/data/models/chat_gemini_pro_vision_model.dart';
import 'package:mygemi/app/data/services/gemini_services.dart';

class GeminiProVisionController extends GetxController
    with StateMixin<List<ChatGeminiProVision>> {
  RxList<ChatGeminiProVision> chats = <ChatGeminiProVision>[].obs;
  Rx<TextEditingController> inputController = TextEditingController().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void generateContent(List<File> images, String message) async {
    ChatGeminiProVision content = ChatGeminiProVision();

    // create user
    ChatUser user = ChatUser(
      image: images,
      text: message,
    );
    content.user = user;

    // add to chats
    chats.add(content);

    // update UI
    if (chats.value.isNotEmpty) {
      change(chats.value, status: RxStatus.success());
    } else {
      change(chats.value, status: RxStatus.empty());
    }

    // CALL API
    // convert images to base64
    List<String> base64Images = [];
    for (var image in images) {
      base64Images.add(convertImageToBase64(image));
    }
    List<String> imagesType = [];
    for (var image in images) {
      imagesType.add("image/${image.path.split(".").last.toLowerCase()}");
    }

    // create body
    Map<String, dynamic> body = {
      "contents": [
        {
          "parts": [
            ...base64Images
                .map((e) => {
                      "inline_data": {
                        "data": e,
                        "mime_type": imagesType[base64Images.indexOf(e)]
                      }
                    })
                .toList(),
            {"text": message}
          ]
        }
      ]
    };

    await GeminiAPI.getGeminiProVision(body).then((val) {
      // create gemini pro
      ChatModel geminiPro = ChatModel(text: val!);

      // add to chats
      content.geminiPro = geminiPro;

      // update UI
      if (chats.value.isNotEmpty) {
        change(chats.value, status: RxStatus.success());
      } else {
        change(chats.value, status: RxStatus.empty());
      }
    });
  }

  String convertImageToBase64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void pickI
}
