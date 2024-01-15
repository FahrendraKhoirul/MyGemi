import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    itemCount: state!.contents!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            const EdgeInsets.only(bottom: defaultPadding / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.contents![index].role == "user"
                                ? userIcon("assets/images/icon_paper plane.png",
                                    customGreyIcon, "You")
                                : userIcon("assets/images/icon_gemini.png",
                                    customBlack, "Gemini"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 39,
                                ),
                                Expanded(
                                    child: Text(
                                  state.contents![index].parts![0].text!,
                                  style: regular14,
                                ))
                              ],
                            )
                          ],
                        ),
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
              inputForm(inputController, inputScrollController, () {
                controller.generateContent(inputController.text);
              })
            ],
          ),
        ));
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
