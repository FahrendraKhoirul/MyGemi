import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mygemi/app/widgets/global_widgets.dart';
import 'package:mygemi/constant.dart';

import '../controllers/gemini_pro_vision_controller.dart';

class GeminiProVisionView extends GetView<GeminiProVisionController> {
  const GeminiProVisionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Gemini Pro Vision',
            style: semibold18,
          ),
          centerTitle: true,
          foregroundColor: customBlack,
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.white,
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
                      return Container(
                        padding:
                            const EdgeInsets.only(bottom: defaultPadding / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userIcon("assets/images/icon_paper plane.png",
                                customGreyIcon, "You"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 39,
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: defaultPadding / 3,
                                  children:
                                      state[index].user!.image!.map((img) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              defaultRadius)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            defaultRadius),
                                        child: Image.file(
                                          File(img.path),
                                          height: 150,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
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
                                  state[index].user!.text!,
                                  style: regular14,
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            userIcon("assets/images/icon_gemini.png",
                                customBlack, "Gemini"),
                            state[index].geminiPro == null
                                ? Container(
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 39),
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballRotateChase,
                                      colors: [customBlack],
                                    )

                                    // Image.asset(
                                    //         "assets/images/icon_paper plane.png")
                                    //     .animate()
                                    //     .shake(
                                    //         delay: const Duration(
                                    //             milliseconds: 50),
                                    //         duration:
                                    //             const Duration(seconds: 3)),
                                    )
                                : Row(
                                    children: [
                                      const SizedBox(
                                        width: 39,
                                      ),
                                      Expanded(
                                          child: MarkdownBody(
                                        data: state[index].geminiPro!.text!,
                                        selectable: true,
                                        styleSheet: MarkdownStyleSheet(
                                            code: GoogleFonts.sourceCodePro(
                                                color: customBlack,
                                                fontSize: 14)),
                                      ))
                                    ],
                                  ),
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
              Obx(() {
                return controller.images.isNotEmpty
                    ? listImage(controller.images)
                    : Container();
              }),
              inputFormWithImage(controller.inputController.value, () {
                if (controller.images.isEmpty) {
                  final snackBar = SnackBar(
                    content: Text('You must include an image!',
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 16)),
                    showCloseIcon: true,
                    behavior: SnackBarBehavior.floating,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: defaultPadding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    backgroundColor: Colors.red[800],
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 150,
                        right: 20,
                        left: 20),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  controller
                      .generateContent(controller.inputController.value.text);
                  controller.inputController.value.clear();
                }
              }, () {
                controller.pickImage();
              })
            ],
          ),
        ));
  }
}
