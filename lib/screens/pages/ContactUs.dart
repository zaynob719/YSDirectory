import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "Contact us",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
