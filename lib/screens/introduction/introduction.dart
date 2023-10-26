import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/app_large_text.dart';
import 'package:YSDirectory/widgets/app_text.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppIntroduction extends StatefulWidget {
  const AppIntroduction({Key? key}) : super(key: key);

  @override
  _AppIntroductionState createState() => _AppIntroductionState();
}

class _AppIntroductionState extends State<AppIntroduction> {
  final String seenFlagKey = 'seen_flag';

  Future<void> checkAndUpdateSeenFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool(seenFlagKey) ?? false;

    if (!seen) {
      // If the user hasn't seen the introduction screen yet, mark it as seen and show it.
      await prefs.setBool(seenFlagKey, true);
    } else {
      // If the user has seen the introduction screen, navigate to another screen (e.g., SignInScreen).
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return SignInScreen();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    checkAndUpdateSeenFlag();
  }

  List images = [
    "options.jpeg",
    "reviewsY.jpeg",
    "world.jpeg",
  ];

  List text = ["Guides", "Reviews", "Near you"];
  List smallText = [
    "Discover your perfect salon with concise, well reaserched guides",
    "Browse honest and accurate reviews from fellow users for your best salon experience",
    "Locate nearby salons for a convenient beauty treatment – anytime, anywhere."
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
                        image: AssetImage("images/" + images[index]),
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
                          Text(text[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'InknutAntiqua'))
                              .animate()
                              .fade(duration: 2000.ms)
                              .slideY(curve: Curves.easeIn),
                          Container(
                            width: 250,
                            child: AppText(
                                text: smallText[index],
                                color: AppColors.textColor2,
                                size: 18),
                          ),
                          const SizedBox(
                            height: 320,
                          ),
                          if (index == images.length - 1)
                            Container(
                              height: 60,
                              width: 342,
                              child: CustomMainButton(
                                color: orengy,
                                isLoading: false,
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignInScreen();
                                  }));
                                },
                                child: const Text(
                                  "Discover, Book, and Shine!", //or Salons, Your Way!
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontFamily: 'GentiumPlus'),
                                )
                                    .animate()
                                    .fade(delay: 1000.ms, duration: 1500.ms)
                                    .tint(color: Colors.white)
                                    .then()
                                    .shake(),
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
