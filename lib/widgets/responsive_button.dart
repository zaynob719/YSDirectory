import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  String? text;
  ResponsiveButton(
      {Key? key, this.width = 120, this.text, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      width: isResponsive == true ? double.maxFinite : width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: AppColors.secondBrownColor),
      child: Row(
        mainAxisAlignment: isResponsive == true
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          isResponsive == true
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: AppText(
                    text: "Book salon now",
                    color: Colors.white,
                  ))
              : Container(),
          Image.asset("images/arrow.png")
        ],
      ),
    ));
  }
}
