import 'package:flutter/material.dart';
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
