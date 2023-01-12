import 'dart:ui';

import 'package:coveredncurly/main.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/app_column.dart';
import 'package:coveredncurly/widgets/app_icon.dart';
import 'package:coveredncurly/widgets/expandable_text_widget.dart';
import 'package:coveredncurly/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/widgets/big_text.dart';
import 'package:coveredncurly/widgets/icon_and_text_widget.dart';

class PopularSalonDetail extends StatelessWidget {
  const PopularSalonDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.PopularSalonImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/blacksalon.jpeg"))),
              )),
          //icons
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width30,
              right: Dimensions.width30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios),
                  AppIcon(icon: Icons.bookmark_border_outlined),
                ],
              )),
          // salon name
          Positioned(
              top: Dimensions.salonTagInfoPage200,
              left: Dimensions.width30,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: [
                  BigText(
                    text: "Salon name",
                    color: Colors.white,
                  ),
                ]),
              ])),
          //location
          Positioned(
              top: Dimensions.salonTagInfoPage240,
              left: Dimensions.width30,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: [
                  SmallText(
                    text: "South Croydon, CR2",
                    color: Colors.white,
                  ),
                ]),
              ])),
          //distance
          Positioned(
              top: Dimensions.salonTagInfoPage260,
              left: Dimensions.width30,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: [
                  SmallText(
                    text: "20 mins away",
                    color: Colors.white,
                  ),
                ]),
              ])),
          //tag
          Positioned(
              left: Dimensions.width30,
              top: Dimensions.salonTagInfoPage180,
              width: 110,
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.tagColor),
                alignment: Alignment.center,
                child: SmallText(text: "hijabi friendly"),
              )),
          //top column
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.PopularSalonImgSize - 40,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //guide tab
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        bottom: Dimensions.height10 / 2,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.secondBrownColor),
                    child: Row(
                      children: [
                        Icon(
                          Icons.note_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        SmallText(
                          text: "Guide",
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  //reviews tab
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        bottom: Dimensions.height10 / 2,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.tagColor),
                    child: Row(
                      children: [
                        Icon(
                          Icons.reviews_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        SmallText(text: "Reviews")
                      ],
                    ),
                  ),
                  //socials tab
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        bottom: Dimensions.height10 / 2,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.tagColor),
                    child: Row(
                      children: [
                        Icon(
                          Icons.link_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        SmallText(text: "Socials")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
