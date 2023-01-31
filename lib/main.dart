import 'package:coveredncurly/bindings/initial_bindings.dart';
import 'package:coveredncurly/routes/app_routes.dart';
import 'package:coveredncurly/screens/pages/home_salon_page.dart';
import 'package:coveredncurly/screens/introduction/introduction.dart';
import 'package:coveredncurly/screens/pages/main_page.dart';
import 'package:coveredncurly/screens/pages/salon_page_body.dart';
import 'package:coveredncurly/screens/salon/main_salon_detail.dart';
import 'package:coveredncurly/screens/splash/splash_screen.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_uploader_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.routes(),
    );
  }
}

/*Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await dep.init();
  runApp(GetMaterialApp(home: DataUploaderScreen()));
}*/
