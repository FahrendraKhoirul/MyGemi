import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygemi/app/data/models/chat_gemini_pro_vision_model.dart';
import 'package:mygemi/app/data/services/gemini_services.dart';

class GeminiProVisionController extends GetxController
    with StateMixin<List<ChatGeminiProVision>> {
  RxList<ChatGeminiProVision> chats = <ChatGeminiProVision>[].obs;
  Rx<TextEditingController> inputController = TextEditingController().obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  final ImagePicker picker = ImagePicker();
  RxList<XFile> images = <XFile>[].obs;

  @override
  void onInit() {
    change(chats, status: RxStatus.empty());
    super.onInit();
  }

  void generateContent(String message) async {
    // print("Tes History:${chats.first.user!.image!.first.name}, $message");
// Assuming `images` is the list you're adding to `user.image`
    List<XFile> newImages =
        List.from(images); // Create a new list with the contents of `images`

// Create a new user with `newImages`
    ChatUser user = ChatUser(
      image: newImages,
      text: message,
    );

    ChatGeminiProVision content = ChatGeminiProVision(user: user);

    print("Tesss:${user.image!.length}, ${user.image!.first.name}}");

    // add to chats
    chats.add(content);

    // update UI
    if (chats.isNotEmpty) {
      change(chats, status: RxStatus.success());
      if (scrollController.value.hasClients) {
        scrollController.value.animateTo(
            scrollController.value.position.extentTotal,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500));
      }
    } else {
      change(chats, status: RxStatus.empty());
    }

    // CALL API
    // convert images to base64
    List<String> base64Images = [];
    for (var image in images) {
      // compress image
      XFile? compressedImage = await compressImageAndGetFile(image, image.path);
      base64Images.add(await convertImageToBase64(compressedImage!));
    }
    List<String> imagesType = [];
    for (var image in images) {
      String typeTemp = image.path.split(".").last.toLowerCase();
      if (typeTemp == "jpg") {
        typeTemp = "jpeg";
      }
      imagesType.add("image/$typeTemp");
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
            {"text": message.isEmpty ? "what it is?" : message}
          ]
        }
      ]
    };

    // delete images
    images.clear();

    // print("Test Body:$body");

    await GeminiAPI.getGeminiProVision(body).then((val) {
      // print("TESSS Result Controller:" + val.toString());
      // create gemini pro
      ChatModel geminiPro = ChatModel(text: val!);

      // add to chats
      content.geminiPro = geminiPro;

      // update UI
      if (chats.isNotEmpty) {
        change(chats, status: RxStatus.success());
        if (scrollController.value.hasClients) {
          scrollController.value.animateTo(
              scrollController.value.position.extentTotal,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 500));
        }
      } else {
        change(chats, status: RxStatus.empty());
      }
    });

    // images.clear();
  }

  Future<String> convertImageToBase64(XFile image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void pickImage() async {
    final List<XFile> imagesTemp = await picker.pickMultiImage();
    if (imagesTemp.isNotEmpty) {
      images.clear();
      images.addAll(imagesTemp);
    }
  }

  Future<XFile?> compressImageAndGetFile(XFile file, String targetPath) async {
    File imageFile = File(file.path);
    final filePath = imageFile.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_compress.jpg";
    var result = await FlutterImageCompress.compressAndGetFile(
        imageFile.path, outPath,
        quality: 80, format: CompressFormat.jpeg);
    return result;
  }
}
