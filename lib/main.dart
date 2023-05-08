import 'package:coveredncurly/bindings/initial_bindings.dart';
import 'package:coveredncurly/layout/screen_layout.dart';
import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/routes/app_routes.dart';
import 'package:coveredncurly/screens/pages/DP_home_salon_page.dart';
import 'package:coveredncurly/screens/introduction/introduction.dart';
import 'package:coveredncurly/screens/pages/salon_detail_screen.dart';
import 'package:coveredncurly/screens/pages/salon_page_body.dart';
import 'package:coveredncurly/screens/salon/main_salon_detail.dart';
import 'package:coveredncurly/screens/sign_in_screen/sign_in_screen.dart';
import 'package:coveredncurly/screens/sign_in_screen/sign_up_screen.dart';
import 'package:coveredncurly/screens/splash/splash_screen.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'data_uploader_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(Duration(seconds: 1));
  //InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //getPages: AppRoutes.routes(),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            } else if (user.hasData) {
              return const ScreenLayout();
            } else {
              return SignInScreen();
            }
          }),
    );
  }
}
