import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/PopularSalonsWidget.dart';
import 'package:coveredncurly/widgets/banner_add_widget.dart';
import 'package:coveredncurly/widgets/category_chip_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/PopularSalonsWidget.dart';
import 'package:coveredncurly/widgets/banner_add_widget.dart';
import 'package:coveredncurly/widgets/category_chip_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;

  void resetSelectedCategory() {
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'InknutAntiqua',
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'YS',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Directory',
                style: TextStyle(
                  color: brown,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryChipWidget(
              categoryList: [
                "Hijaby space",
                "Kids space",
                "Afrocare",
                "Location",
                "Mobile",
                "Ratings",
                "Curls",
                "Essentials",
                "Reservations",
                "Last minute",
              ],
            ),
            const BannerAddWidget(),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Salons",
                  style: TextStyle(
                      fontFamily: 'InknutAntiqua',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: PopularSalonsWidget(),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                // Your code here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    brown, // Change the background color of the button
              ),
              child: Text(
                'Show more',
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                  TextSpan(
                    text:
                        'Disclaimer: The information displayed may not be accurate. Please contact the salon specifically for updated information. Read our ',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontFamily: 'GentiumPlus'),
                    children: [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
// Add your logic here for what happens when the user taps the button
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
