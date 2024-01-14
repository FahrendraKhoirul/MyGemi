import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/gemini_pro/bindings/gemini_pro_binding.dart';
import '../modules/home/gemini_pro/views/gemini_pro_view.dart';
import '../modules/home/gemini_pro_vision/bindings/gemini_pro_vision_binding.dart';
import '../modules/home/gemini_pro_vision/views/gemini_pro_vision_view.dart';
import '../modules/home/views/home_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.GEMINI_PRO,
          page: () => const GeminiProView(),
          binding: GeminiProBinding(),
        ),
        GetPage(
          name: _Paths.GEMINI_PRO_VISION,
          page: () => const GeminiProVisionView(),
          binding: GeminiProVisionBinding(),
        ),
      ],
    ),
  ];
}
