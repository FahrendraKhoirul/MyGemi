import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mygemi/constant.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Container()),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MyGemi",
                        style: bold30,
                      ),
                      Text(
                        "Dont let your Ideas die",
                        style: regular16.copyWith(color: customGreyText),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/paper planes.png",
                    width: 100,
                    height: 100,
                  ),
                  Container(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(height: 20),
              featureCard(
                  title: "Pro",
                  subtitle: "Text-only input",
                  description:
                      "The best model for scaling across\na wide range of task",
                  func: () {}),
              const SizedBox(height: 20),
              featureCard(
                  title: "Pro Vision",
                  subtitle: "Text-and-Image input",
                  description:
                      "The best image understanding model to \nhandle a broad range of application",
                  func: () {}),
              Flexible(child: Container()),
              const Center(child: Text("Powered by Gemini AI"))
            ],
          ),
        ));
  }

  Widget featureCard(
      {required String title,
      required String subtitle,
      required String description,
      required VoidCallback func}) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: customBlack),
          borderRadius: BorderRadius.circular(16),
          color: customGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: bold16,
            ),
            Text(
              subtitle,
              style: semibold14.copyWith(color: customGreyText),
            ),
            Text(
              description,
              style: regular14.copyWith(color: customGreyText),
            ),
          ],
        ),
      ),
    );
  }
}
