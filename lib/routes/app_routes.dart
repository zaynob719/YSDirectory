import 'package:coveredncurly/screens/introduction/introduction.dart';
import 'package:coveredncurly/screens/pages/home_screen.dart';
import 'package:coveredncurly/screens/splash/splash_screen.dart';
import 'package:coveredncurly/services/firebase_storage_service.dart';
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
