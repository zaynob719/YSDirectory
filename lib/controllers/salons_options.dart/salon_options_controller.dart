import 'package:coveredncurly/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class SalonOptionsController extends GetxController {
  final allSalonImages = <String>[].obs;
  @override
  void onReady() {
    getAllSalons();
    super.onReady();
  }

  Future<void> getAllSalons() async {
    List<String> imgName = ["ysds001", "ysds002", "ysds003", "ysds004"];
    try {
      for (var img in imgName) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
        allSalonImages.add(imgUrl!);
      }
    } catch (e) {
      print(e);
    }
  }
}
