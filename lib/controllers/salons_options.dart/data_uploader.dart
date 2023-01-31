import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/firebase_ref/loading_status.dart';
import 'package:coveredncurly/firebase_ref/references.dart';
import 'package:coveredncurly/models/salon_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus =
      LoadingStatus.loading.obs; // loading status is observable

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0

    await Firebase.initializeApp();
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //load file and print path
    final salonsInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/salon") && path.contains(".json"))
        .toList();
    List<SalonListModel> salonsOptions = [];
    for (var salon in salonsInAssets) {
      String stringSalonContent = await rootBundle.loadString(salon);
      salonsOptions
          .add(SalonListModel.fromJson(json.decode(stringSalonContent)));
    }
    //print('Items number ${salons[0].id}');
    var batch = fireStore.batch();

    for (var salon in salonsOptions) {
      batch.set(salonsOptionRF.doc(salon.id), {
        "title": salon.title,
        "image_url": salon.imageUrl,
        "description": salon.description,
        "salons_count": salon.salons == null ? 0 : salon.salons!.length
      });
      for (var salons in salon.salons!) {
        final salonProfilePath =
            salonProfileRF(salonId: salon.id, salonProfileId: salons.id);
        batch.set(salonProfilePath, {
          "salonprofile": salons.salonProfile,
          "star": salons.star,
          "location": salons.location,
        });
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed; //1
  }
}
