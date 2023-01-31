import 'package:coveredncurly/controllers/salons_options.dart/salon_options_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalonOptionsController _salonOptionsController = Get.find();
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext context, index) {
            return ClipRRect(
              child: SizedBox(
                height: 200,
                width: 200,
                child: FadeInImage(
                  image: NetworkImage(
                      _salonOptionsController.allSalonImages[index]),
                  placeholder: AssetImage("images/logo.png"),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
          itemCount: _salonOptionsController.allSalonImages.length),
    );
  }
}
