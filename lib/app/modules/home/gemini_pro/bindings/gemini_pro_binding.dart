import 'package:get/get.dart';

import '../controllers/gemini_pro_controller.dart';

class GeminiProBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeminiProController>(
      () => GeminiProController(),
    );
  }
}
