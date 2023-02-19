import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/app_button.dart';
import 'package:coveredncurly/widgets/app_large_text.dart';
import 'package:coveredncurly/widgets/app_text.dart';
import 'package:coveredncurly/widgets/big_text.dart';
import 'package:coveredncurly/widgets/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AppIntroduction extends StatefulWidget {
  const AppIntroduction({Key? key}) : super(key: key);

  @override
  _AppIntroductionState createState() => _AppIntroductionState();
}

class _AppIntroductionState extends State<AppIntroduction> {
  List images = [
    "options.jpeg",
    "reviewsY.jpeg",
    "world.jpeg",
  ];

  List text = ["Guides", "Reviews", "Near you"];
  List smallText = [
    "More information about how the guides are created & how many are currently on here",
    "More information about how premium members are able to read and write reviews",
    "More information about how users can suggest international salons. Treat your hair on holiday"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: images.length,
            itemBuilder: (_, index) {
              return Container(
                //images
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "images/" + images[index]), //list of images above
                        fit: BoxFit.cover)),
                child: Container(
                  margin: const EdgeInsets.only(top: 115, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //slide text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(
                              text: text[
                                  index]), //list of text above - large text
                          Container(
                            width: 250,
                            child: AppText(
                                text: smallText[
                                    index], //list of text above - small text
                                color: AppColors.textColor2,
                                size: 16),
                          ),
                          SizedBox(
                            height: 320,
                          ),
                          if (index == images.length - 1)
                            Container(
                              height: 60,
                              width: 325,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.brown),
                              child: AppButton(
                                onTap: () => Get.offAndToNamed("/home"),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 35,
                                ),
                              ),
                            ),
                        ],
                      ),
                      //slide dots
                      Column(
                        children: List.generate(3, (indexDots) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: 8,
                            height: index == indexDots ? 35 : 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index == indexDots
                                    ? AppColors.secondBrownColor
                                    : AppColors.secondBrownColor
                                        .withOpacity(0.3)),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
