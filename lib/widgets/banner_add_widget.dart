import 'package:YSDirectory/models/user_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BannerAddWidget extends StatefulWidget {
  final UserDetailsModel? user;
  const BannerAddWidget({Key? key, this.user}) : super(key: key);

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

    //this fetches 3 of the latest salons added.
    db
        .collection('salons')
        .orderBy('timestamp', descending: true)
        .limit(3)
        .get()
        .then((snapshot) {
      setState(() {
        salons =
            snapshot.docs.map((doc) => Salon.fromJson(doc.data())).toList();
      });
    });
  }

  void onNoOfReviewUpdated(int noOfReviews) {}

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
                      builder: (context) => SalonDetailScreen(
                        salon: salon,
                        onNoOfReviewUpdated: onNoOfReviewUpdated,
                      ),
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
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'InknutAntiqua'),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            salons[index].location,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GentiumPlus',
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 1),
                          Chip(
                            label: Text(
                              salons[index].category,
                              style: const TextStyle(
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
        const SizedBox(
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
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          orengy,
                          Color.fromARGB(255, 242, 211, 182)
                        ]),
                        width: 6,
                      ),
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.white),
                  child: const Icon(
                    Icons.bookmark_rounded,
                    size: 40,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          orengy,
                          Color.fromARGB(255, 237, 223, 210)
                        ]),
                        width: 6,
                      ),
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.white),
                  child: const Icon(
                    Icons.contact_support_rounded,
                    size: 40,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const discounts()));
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(colors: [
                          orengy,
                          Color.fromARGB(255, 184, 141, 101)
                        ]),
                        width: 6,
                      ),
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.white),
                  child: const Icon(
                    Icons.discount_rounded,
                    size: 40,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutYSD()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: const GradientBoxBorder(
                      gradient: LinearGradient(
                          colors: [orengy, Color.fromARGB(255, 231, 223, 216)]),
                      width: 6,
                    ),
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.white),
                child: Image.asset(
                  'images/originalLogo.png.png',
                  height: 60,
                  width: 60,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Widget appOffersHomePageFromIndex(int index, double height) {
  //   void navigateToScreen() {
  //     switch (index) {
  //       case 0:
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const ProfilePage()));
  //         break;
  //       case 1:
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ContactUs(user: widget.user)));
  //         break;
  //       case 2:
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const discounts()));
  //         break;
  //       case 3:
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const AboutYSD()));
  //         break;
  //     }
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 5),
  //     child: GestureDetector(
  //       onTap: navigateToScreen,
  //       child: Container(
  //         height: height,
  //         width: height,
  //         decoration: ShapeDecoration(
  //           color: Colors.white,
  //           shadows: const [
  //             BoxShadow(
  //               color: tagColor,
  //               spreadRadius: 1,
  //             ),
  //           ],
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ),
  //         child: Center(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Image.asset(appOffersHomePage[index]),
  //               const SizedBox(
  //                 height: 5,
  //               ),
  //               Text(
  //                 appOffersHomePageNames[index],
  //                 style: const TextStyle(fontFamily: 'GentiumPlus'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
