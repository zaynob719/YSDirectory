import 'package:coveredncurly/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class discounts extends StatelessWidget {
  const discounts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: brown,
        title: Text(
          "discount page",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
