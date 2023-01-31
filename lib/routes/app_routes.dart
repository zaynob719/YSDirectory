import 'package:coveredncurly/controllers/salons_options.dart/salon_options_controller.dart';
import 'package:coveredncurly/firebase_ref/references.dart';
import 'package:coveredncurly/screens/home/home_screen.dart';
import 'package:coveredncurly/screens/introduction/introduction.dart';
import 'package:coveredncurly/screens/pages/home_salon_page.dart';
import 'package:coveredncurly/screens/pages/salon_page_body.dart';
import 'package:coveredncurly/screens/salon/main_salon_detail.dart';
import 'package:coveredncurly/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/introduction", page: () => MainSalonDetail()),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(SalonOptionsController());
            })),
      ];
}
