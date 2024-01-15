import 'dart:io';

class ChatGeminiProVision {
  ChatUser? user;
  ChatModel? geminiPro;

  ChatGeminiProVision({this.user, this.geminiPro});
}

class ChatUser {
  List<File>? image;
  String? text;

  ChatUser({this.image, this.text});
}

class ChatModel{
  String? text;

  ChatModel({this.text});
}
