import 'package:get/get.dart';
import 'package:mygemi/app/data/models/gemini_pro_model.dart';
import 'package:mygemi/app/data/services/gemini_services.dart';

class HomeController extends GetxController {
  var chats = GeminiPro(contents: []).obs;

  void generateContent(String message) async {
    // add to chats
    Contents content = Contents(parts: [Parts(text: message)], role: "user");
    chats.value.contents?.add(content);

    // call API and store gemini response to chats
    await GeminiAPI.getGeminiPro(chats.value).then((val) {
      chats.value.contents?.add(val!);
    });
  }
}
