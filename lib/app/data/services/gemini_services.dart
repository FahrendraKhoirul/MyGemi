import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mygemi/app/data/models/gemini_pro_model.dart';

class GeminiAPI {
  static const myGeminiApi = "AIzaSyB4e9E_vKK4izqXWzo1kmnQ0FfmDXI58L8";
  static const geminiProUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";
  static const geminiProVisionUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent";
  static final dio = Dio();

  static Map<String, String> getHeader() {
    return {
      'Content-Type': 'application/json',
    };
  }

  static Future<Contents?> getGeminiPro(GeminiPro body) async {
    try {
      final response = await dio.post(geminiProUrl,
          data: body.toJson(),
          queryParameters: {"key": myGeminiApi},
          options: Options(headers: {"Content-Type": "application/json"}));

      if (response.statusCode == 200) {
        var result = Contents.fromJson(response.data["candidates"][0]);
        return result;
      } else {
        return Contents(parts: [Parts(text: response.statusMessage)]);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      if (e is DioException) {
        return Contents(parts: [Parts(text: e.message)]);
      }
      return Contents(parts: [Parts(text: e.toString())]);
    }
  }
}
