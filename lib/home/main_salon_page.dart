import 'dart:ui';

import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/home/salon_page_body.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/big_text.dart';
import 'package:flutter/material.dart';

class MainSalonPage extends StatefulWidget {
  const MainSalonPage({Key? key}) : super(key: key);

  @override
  _MainSalonPageState createState() => _MainSalonPageState();
}

class _MainSalonPageState extends State<MainSalonPage> {
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
    ]));
  }
}
