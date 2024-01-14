import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

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

  static Future<List<String, dynamic>> getGeminiPro(
      Map<String, dynamic> body) async {
    try {
      final response = await dio.post(geminiProUrl,
          data: body,
          queryParameters: {"key": myGeminiApi},
          options: Options(headers: {"Content-Type": "application/json"}));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data) as Map<String, dynamic>;
        return jsonResponse['candidates'][0]["content"];
      } else {
        return {
          "statusCode": response.statusCode.toString(),
          "message": response.statusMessage
        };
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      if (e is DioException) {
        return {"message": e.response?.data['message']};
      }
      return {"message": e.toString()};
    }
  }
}
