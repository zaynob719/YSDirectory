// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coveredncurly/firebase_ref/references.dart';
// import 'package:coveredncurly/models/salon_list_model.dart';
// import 'package:coveredncurly/services/firebase_storage_service.dart';
// import 'package:get/get.dart';

// //learning video
// class SalonOptionsController extends GetxController {
//   final allSalonImages = <String>[].obs;
//   final allSalons = <SalonListModel>[].obs;

//   @override
//   void onReady() {
//     getAllSalons();
//     super.onReady();
//   }

//   Future<void> getAllSalons() async {
//     List<String> imgName = ["ysds001", "ysds002", "ysds003", "ysds004"];
//     try {
//       QuerySnapshot<Map<String, dynamic>> data = await salonsOptionRF.get();
//       final salonList =
//           data.docs.map((salon) => SalonListModel.fromSnapshot(salon)).toList();
//       allSalons.assignAll(salonList);

//       for (var salon in salonList) {
//         final imgUrl =
//             await Get.find<FireBaseStorageService>().getImage(salon.title);
//         salon.imageUrl = imgUrl;
//       }
//       allSalons.assignAll(salonList);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
