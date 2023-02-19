import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/firebase_ref/loading_status.dart';
import 'package:coveredncurly/firebase_ref/references.dart';
import 'package:coveredncurly/models/salon_slider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

class UploadData extends GetxController {
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
    final new_salonsInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/new_salon") && path.contains(".json"))
        .toList();
    List<SalonSliderModel> popularSalons = [];
    for (var new_salon in new_salonsInAssets) {
      String stringNewSalonContent = await rootBundle.loadString(new_salon);
      popularSalons
          .add(SalonSliderModel.fromJson(json.decode(stringNewSalonContent)));
    }

    var batch = fireStore.batch();

    for (var new_salon in popularSalons) {
      batch.set(popularSalonRF.doc(new_salon.id), {
        "total_size": new_salon.totalSize,
        "type_id": new_salon.typeId,
        "offset": new_salon.offset,
        "salons_count": new_salon.salons == null ? 0 : new_salon.salons!.length
      });
      for (var salons in new_salon.salons!) {
        final namePath = nameRF(salonId: new_salon.id, nameId: salons.id);
        batch.set(namePath, {
          "name": salons.name,
          "stars": salons.stars,
          "location": salons.location,
        });
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed; //1
  }
}
