import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygemi/app/data/models/gemini_pro_model.dart';
import 'package:mygemi/constant.dart';

Widget inputForm(TextEditingController controller, VoidCallback func) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: SizedBox(
            height: 52,
            child: TextField(
                style: regular14,
                controller: controller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Ask something...",
                  hintStyle: regular14,
                  filled: true,
                  isDense: true,
                  fillColor: customGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: customBlack,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: customBlack,
                      width: 1.6,
                    ),
                  ),
                )),
          ),
        ),
        Flexible(
          flex: 1,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 52),
                  backgroundColor: customBlack,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius))),
              onPressed: func,
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 24.0,
              )),
        ),
      ],
    ),
  );
}

Widget inputFormWithImage(TextEditingController controller, VoidCallback func,
    VoidCallback imageFunc) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 4,
          child: SizedBox(
            height: 52,
            child: TextField(
                style: regular14,
                controller: controller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Ask something...",
                  hintStyle: regular14,
                  filled: true,
                  isDense: true,
                  fillColor: customGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: customBlack,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(
                      color: customBlack,
                      width: 1.6,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      imageFunc();
                    },
                    icon: Icon(
                      Icons.image_rounded,
                      color: customGreyText,
                      size: 24.0,
                    ),
                  ),
                )),
          ),
        ),
        Flexible(
          flex: 1,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 52),
                  backgroundColor: customBlack,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius))),
              onPressed: func,
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 24.0,
              )),
        ),
      ],
    ),
  );
}

Widget userIcon(String imgPath, Color bgColor, String userText) {
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

Widget itemChat(GeminiPro state, int index) {
  return Container(
    padding: const EdgeInsets.only(bottom: defaultPadding / 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        state.contents![index].role == "user"
            ? userIcon(
                "assets/images/icon_paper plane.png", customGreyIcon, "You")
            : userIcon("assets/images/icon_gemini.png", customBlack, "Gemini"),
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

Widget listImage(List<XFile> images) {
  return SizedBox(
    height: 100,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                Container(
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
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        images.removeAt(index);
                      },
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            color: customBlack,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
  );
}
