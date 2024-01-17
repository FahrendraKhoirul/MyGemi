import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
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
          title: Text(
            'Gemini Pro Chat',
            style: semibold18,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: customBlack,
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
}
