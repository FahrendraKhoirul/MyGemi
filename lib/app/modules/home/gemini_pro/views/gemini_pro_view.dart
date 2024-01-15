import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mygemi/app/data/models/gemini_pro_model.dart';
import 'package:mygemi/app/widgets/global_widgets.dart';
import 'package:mygemi/constant.dart';

import '../controllers/gemini_pro_controller.dart';

class GeminiProView extends GetView<GeminiProController> {
  const GeminiProView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('GeminiProView'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.only(
              top: 0, bottom: 0, left: defaultPadding, right: defaultPadding),
          child: Column(
            children: [
              Expanded(
                  child: controller.obx(
                (state) {
                  return ListView.builder(
                    controller: controller.scrollController.value,
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    itemCount: state!.contents!.length,
                    itemBuilder: (context, index) {
                      return state.contents![index].role == "user"
                          ? itemChat(state, index)
                              .animate(delay: const Duration(milliseconds: 250))
                              .fadeIn()
                          : itemChat(state, index)
                              .animate(delay: const Duration(milliseconds: 500))
                              .fadeIn();
                    },
                  );
                },
                onEmpty: Center(
                    child: Image.asset(
                  "assets/images/paper planes.png",
                  width: 100,
                )),
              )),
              inputForm(controller.inputController.value, () {
                controller
                    .generateContent(controller.inputController.value.text);
                controller.inputController.value.clear();
              })
            ],
          ),
        ));
  }

  Container itemChat(GeminiPro state, int index) {
    return Container(
      padding: const EdgeInsets.only(bottom: defaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.contents![index].role == "user"
              ? userIcon(
                  "assets/images/icon_paper plane.png", customGreyIcon, "You")
              : userIcon(
                  "assets/images/icon_gemini.png", customBlack, "Gemini"),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 39,
              ),
              Expanded(
                  child: MarkdownBody(
                data: state.contents![index].parts![0].text!,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                    code: GoogleFonts.sourceCodePro(
                        color: customBlack, fontSize: 14)),
              ))
            ],
          )
        ],
      ),
    );
  }

  Row userIcon(String imgPath, Color bgColor, String userText) {
    return Row(
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Image.asset(imgPath),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          userText,
          style: semibold14,
        ),
      ],
    );
  }
}
