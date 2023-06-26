import 'package:coveredncurly/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class socials extends StatelessWidget {
  const socials({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: brown,
        title: Text(
          "social page (include tiktok, IG and email 'yoursalondirectory@gmail.com)",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
