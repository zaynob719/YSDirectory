import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/utils/utils.dart';

class BannerAddWidget extends StatefulWidget {
  const BannerAddWidget({Key? key}) : super(key: key);

  @override
  _BannerAddWidgetState createState() => _BannerAddWidgetState();
}

class _BannerAddWidgetState extends State<BannerAddWidget> {
  final _controller = PageController();
  double _currentPageValue = 0.0;
  double homeScreenFeatureDimension = 120; //screenSize.width / 5;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPageValue = _controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Column(
      children: [
        //image slider
        SizedBox(
          height: 200,
          child: PageView(
            controller: _controller,
            children: newSalonAdd
                .map(
                  (imageUrl) => Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'images/placeholder_image.png',
                        image: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Salon Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'InknutAntiqua'),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'Salon Address, Salon Address EE4',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'GentiumPlus'),
                            ),
                            SizedBox(height: 1),
                            Chip(
                              label: Text(
                                'Hijabi space',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'GentiumPlus'),
                              ),
                              backgroundColor: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        //dots indicator under image slider
        DotsIndicator(
          dotsCount: newSalonAdd.length,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.secondBrownColor,
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.white,
          width: screenSize.width,
          height: homeScreenFeatureDimension, //size of the white container
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appOffersHomePageFromIndex(0, 110),
                appOffersHomePageFromIndex(1, 110),
                appOffersHomePageFromIndex(2, 110),
                appOffersHomePageFromIndex(3, 110),
                appOffersHomePageFromIndex(4, 110),
                appOffersHomePageFromIndex(5, 110),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget appOffersHomePageFromIndex(int index, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: height,
        width: height,
        decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 3),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(appOffersHomePage[index]),
            SizedBox(
              height: 5,
            ),
            Text(
              appOffersHomePageNames[index],
              style: TextStyle(fontFamily: 'GentiumPlus'),
            ),
          ]),
        ),
      ),
    );
  }
}
