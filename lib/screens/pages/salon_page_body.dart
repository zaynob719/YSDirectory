import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/app_column.dart';
import 'package:coveredncurly/widgets/big_text.dart';
import 'package:coveredncurly/widgets/icon_and_text_widget.dart';
import 'package:coveredncurly/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class SalonPageBody extends StatefulWidget {
  const SalonPageBody({Key? key}) : super(key: key);

  @override
  _SalonPageBodyState createState() => _SalonPageBodyState();
}

class _SalonPageBodyState extends State<SalonPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                })),
        //slider dots
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.secondBrownColor,
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        // Popular text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Your",
                color: Color(0xFFD8BA9E),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                child: BigText(text: "Favourite Salons", color: Colors.black),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        // list of salons and images
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      bottom: 20),
                  child: Row(
                    children: [
                      //image section
                      Container(
                        width: Dimensions.ListViewImgSize,
                        height: Dimensions.ListViewImgSize,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/ysds003.png"))),
                      ),
                      // text section
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Color(0xFFF1E6DB),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: "First Named Salon"),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                SmallText(
                                    text:
                                        "Based in London, specialising in all hair types!"),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconAndTextWidget(
                                        icon: Icons.location_on_rounded,
                                        text: "1.5km",
                                        iconColor: AppColors.secondBrownColor),
                                    IconAndTextWidget(
                                        icon: Icons.comment_rounded,
                                        text: "30 rev ",
                                        iconColor: AppColors.secondBrownColor),
                                    IconAndTextWidget(
                                        icon: Icons.link_rounded,
                                        text: "socials",
                                        iconColor: AppColors.secondBrownColor)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ) // text section
                    ],
                  ));
            })
      ],
    );
  }

//slider
  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: index.isEven ? Color(0xFFD8BA9E) : Color(0xFFF1E6DB),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/ysds001.png")))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: Dimensions.pageViewTextContainer,
                  margin: EdgeInsets.only(
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      bottom: Dimensions.height40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 5)),
                        BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                        BoxShadow(color: Colors.white, offset: Offset(5, 0))
                      ]),
                  child: Container(
                    padding: EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: AppColumn(text: "CoveredNCurly salon"),
                  )),
            ),
          ],
        ));
  }
}
