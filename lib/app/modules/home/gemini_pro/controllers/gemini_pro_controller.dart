import 'package:get/get.dart';
import 'package:mygemi/app/data/models/gemini_pro_model.dart';
import 'package:mygemi/app/data/services/gemini_services.dart';

class GeminiProController extends GetxController with StateMixin<GeminiPro> {
  var chats = GeminiPro(contents: []).obs;
  var isThinking = false.obs;

  @override
  void onInit() {
    change(chats.value, status: RxStatus.empty());
    super.onInit();
    // generateContent("Hello Gemini!");
  }

  void generateContent(String message) async {
    // add to chats
    isThinking.value = false;
    Contents content = Contents(parts: [Parts(text: message)], role: "user");
    chats.value.contents?.add(content);

    // update UI
    if (chats.value.contents != null) {
      change(chats.value, status: RxStatus.success());
    } else {
      change(chats.value, status: RxStatus.empty());
    }

    // call API and store gemini response to chats
    await GeminiAPI.getGeminiPro(chats.value).then((val) {
      chats.value.contents?.add(val!);
      isThinking.value = true;
      print("TESSS RESPONSE :" + val!.parts.toString());
    });

    // update UI
    if (chats.value.contents != null) {
      change(chats.value, status: RxStatus.success());
    } else {
      change(chats.value, status: RxStatus.empty());
    }
  }
}
