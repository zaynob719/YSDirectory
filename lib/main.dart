import 'package:coveredncurly/layout/screen_layout.dart';
import 'package:coveredncurly/provider/user_details_provider.dart';
import 'package:coveredncurly/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
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
      ),
    );
  }
}
