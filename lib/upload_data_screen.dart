import 'package:coveredncurly/controllers/popular_salons.dart/upload_data.dart';
import 'package:coveredncurly/controllers/salons_options.dart/data_uploader.dart';
import 'package:coveredncurly/firebase_ref/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class UploadDataScreen extends StatelessWidget {
  UploadDataScreen({Key? key}) : super(key: key);
  UploadData controller = Get.put(UploadData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(() => Text(
          controller.loadingStatus.value == LoadingStatus.completed
              ? "Uploading completed"
              : "Uploading...")),
    ));
  }
}
