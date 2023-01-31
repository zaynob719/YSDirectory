import 'dart:ui';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/screens/pages/salon_page_body.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/big_text.dart';
import 'package:flutter/material.dart';

class HomeSalonPage extends StatefulWidget {
  const HomeSalonPage({Key? key}) : super(key: key);

  @override
  _HomeSalonPageState createState() => _HomeSalonPageState();
}

class _HomeSalonPageState extends State<HomeSalonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "YSDirectory",
                      color: AppColors.secondBrownColor,
                      size: 24,
                    ),
                  ],
                ),
                Center(
                    child: Container(
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: Dimensions.iconSize24,
                  ),
                ))
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: SalonPageBody(),
        ))
      ]),
    );
  }
}
