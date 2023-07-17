import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/models/salon_model.dart';
import 'package:YSDirectory/screens/pages/about_ysd.dart';
import 'package:YSDirectory/screens/pages/addReviewPage.dart';
import 'package:YSDirectory/screens/pages/discounts.dart';
import 'package:YSDirectory/screens/pages/profile_page.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/screens/pages/ContactUs.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/result_widget.dart';

class BannerAddWidget extends StatefulWidget {
  const BannerAddWidget({Key? key}) : super(key: key);

  @override
  _BannerAddWidgetState createState() => _BannerAddWidgetState();
}

class _BannerAddWidgetState extends State<BannerAddWidget> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<Salon> salons = [];
  final _controller = PageController();
  double _currentPageValue = 0.0;
  double homeScreenFeatureDimension = 120;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPageValue = _controller.page!;
      });
    });

    db
        .collection('salons')
        .limit(
            3) // Fetch only the first 5 salons (change this to new added salons)
        .get()
        .then((snapshot) {
      setState(() {
        salons =
            snapshot.docs.map((doc) => Salon.fromJson(doc.data())).toList();
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
            children: salons.asMap().entries.map((entry) {
              final index = entry.key;
              final salon = entry.value;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalonDetailScreen(salon: salon),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: Opacity(
                        opacity: 0.6,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/placeholder_image.png',
                          image: salons[index].url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            salons[index].salonName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'InknutAntiqua'),
                          ),
                          SizedBox(height: 1),
                          Text(
                            salons[index].location,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GentiumPlus',
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          SizedBox(height: 1),
                          Chip(
                            label: Text(
                              salons[index].category,
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
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        //dots indicator under image slider
        DotsIndicator(
          dotsCount: 3,
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
                appOffersHomePageFromIndex(0, 110), //saved
                appOffersHomePageFromIndex(1, 110), //ysd socials
                appOffersHomePageFromIndex(2, 110), //discounts
                appOffersHomePageFromIndex(3, 110), //about ysd
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget appOffersHomePageFromIndex(int index, double height) {
    void navigateToScreen() {
      switch (index) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfilePage()));
          break;
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ContactUs()));
          break;
        case 2:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const discounts()));
          break;
        case 3:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutYSD()));
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: navigateToScreen, //navigation list at the top
        child: Container(
          height: height,
          width: height,
          decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(appOffersHomePage[index]),
                SizedBox(
                  height: 5,
                ),
                Text(
                  appOffersHomePageNames[index],
                  style: TextStyle(fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
