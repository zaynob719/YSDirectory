import 'dart:ui';

import 'package:coveredncurly/colors/colors.dart';
import 'package:coveredncurly/home/salon_page_body.dart';
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
          margin: EdgeInsets.only(top: 60, bottom: 15),
          padding: EdgeInsets.only(left: 22, right: 22),
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
                width: 45,
                height: 45,
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ))
            ],
          ),
        ),
      ),
      SalonPageBody(),
    ]));
  }
}
