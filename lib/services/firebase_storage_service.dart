import 'package:coveredncurly/firebase_ref/references.dart';
import 'package:get/get.dart';

class FireBaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = fireBaseStorage
          .child("salons_options_images")
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();

      return imgUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
