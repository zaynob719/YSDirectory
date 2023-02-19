import 'package:coveredncurly/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => FireBaseStorageService());
  }
}
