import 'package:get/get.dart';

import '../controllers/gemini_pro_vision_controller.dart';

class GeminiProVisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeminiProVisionController>(
      () => GeminiProVisionController(),
    );
  }
}
