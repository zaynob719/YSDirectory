import 'package:coveredncurly/controllers/salons_options.dart/salon_options_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalonOptionsController _salonOptionsController = Get.find();
    return Scaffold(
        body: Obx(() => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  child: SizedBox(
                height: 200,
                width: 200,
                child: CachedNetworkImage(
                  imageUrl: _salonOptionsController.allSalons[index].imageUrl!,

                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ), //this shows progress while loading image
                  errorWidget: (context, url, error) =>
                      Image.asset("images/logo.png"),
                  //show logo image if there is an error loading salon image
                ),
              ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: _salonOptionsController.allSalons.length)));
  }
}
