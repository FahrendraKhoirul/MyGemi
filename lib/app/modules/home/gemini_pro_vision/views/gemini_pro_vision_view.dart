import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygemi/app/widgets/global_widgets.dart';
import 'package:mygemi/constant.dart';

import '../controllers/gemini_pro_vision_controller.dart';

class GeminiProVisionView extends GetView<GeminiProVisionController> {
  const GeminiProVisionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GeminiProVisionView'),
          centerTitle: true,
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
                    itemCount: state!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(state[index].user!.text!),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(state[index].geminiPro!.text!)
                        ],
                      );
                    },
                  );
                },
                onEmpty: Center(
                    child: Image.asset(
                  "assets/images/paper planes.png",
                  width: 100,
                )),
              )),
              Obx(() {
                return controller.images.isNotEmpty
                    ? listImage(controller.images)
                    : Container();
              }),
              inputFormWithImage(controller.inputController.value, () {
                controller.generateContent(
                    controller.images, controller.inputController.value.text);
                controller.inputController.value.clear();
              }, () {
                controller.pickImage();
              })
            ],
          ),
        ));
  }

  // Container itemChat(GeminiPro state, int index) {
  //   return Container(
  //     padding: const EdgeInsets.only(bottom: defaultPadding / 2),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         state.contents![index].role == "user"
  //             ? userIcon(
  //                 "assets/images/icon_paper plane.png", customGreyIcon, "You")
  //             : userIcon(
  //                 "assets/images/icon_gemini.png", customBlack, "Gemini"),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Row(
  //           children: [
  //             const SizedBox(
  //               width: 39,
  //             ),
  //             Expanded(
  //                 child: Text(
  //               state.contents![index].parts![0].text!,
  //               style: regular14,
  //             ))
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

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

  Widget listImage(List<XFile> images) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              // rounded border with black color and shadow
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(color: customBlack, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: customBlack.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(defaultRadius),
                child: Image.file(
                  File(images[index].path),
                  height: 120,
                  // width: with minimal 50 if image is not square
                  fit: BoxFit.fitHeight,
                ),
              ),
            );
          }),
    );
  }
}
