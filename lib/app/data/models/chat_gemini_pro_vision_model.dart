

import 'package:image_picker/image_picker.dart';

class ChatGeminiProVision {
  ChatUser? user;
  ChatModel? geminiPro;

  ChatGeminiProVision({this.user, this.geminiPro});
}

class ChatUser {
  List<XFile>? image;
  String? text;

  ChatUser({this.image, this.text});
}

class ChatModel{
  String? text;

  ChatModel({this.text});
}
