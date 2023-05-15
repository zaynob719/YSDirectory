import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/screens/pages/salon_detail_screen.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/utils/utils.dart';

class BannerAddWidget extends StatefulWidget {
  final SalonModel salonModel;
  const BannerAddWidget({Key? key, required this.salonModel}) : super(key: key);

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
                  (imageUrl) => GestureDetector(
                    onTap: () {
                      // Navigate to SalonDetail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalonDetailScreen(
                            salonModel: SalonModel(
                                url:
                                    "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds004.png?alt=media&token=c8f27351-a1af-4fe6-83e7-cd64def476f7",
                                uid: "123",
                                salonName: "MeYou hair",
                                summary:
                                    "A private hijabi friendly salon that specialises in afro curly hair",
                                rating: 4,
                                noOfRating: 4,
                                salonDistance: 1.3,
                                noOfReview: 5,
                                location: "East Ham, E6 London, UK"),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'images/placeholder_image.png',
                          image: widget.salonModel.url,
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
                                widget.salonModel.salonName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'InknutAntiqua'),
                              ),
                              SizedBox(height: 1),
                              Text(
                                widget.salonModel.location,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'GentiumPlus'),
                              ),
                              SizedBox(height: 1),
                              Chip(
                                label: Text(
                                  'Hijaby space',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'GentiumPlus'),
                                ),
                                backgroundColor: tagColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
      child: GestureDetector(
        onTap: () {},
        // each one needs to go to a spacific screen
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
      ),
    );
  }
}
