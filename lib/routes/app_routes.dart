import 'package:YSDirectory/screens/introduction/introduction.dart';
import 'package:YSDirectory/screens/pages/home_screen.dart';
import 'package:YSDirectory/screens/splash/splash_screen.dart';
import 'package:YSDirectory/services/firebase_storage_service.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
          name: "/introduction",
          page: () => const AppIntroduction(),
        ),
        // GetPage(
        //     name: "/home",
        //     page: () => const HomeScreen(),
        //     binding: BindingsBuilder(() {
        //       Get.put(SalonOptionsController());
        //     })),
      ];
}
