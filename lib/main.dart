import 'package:YSDirectory/layout/screen_layout.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/introduction/introduction.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 1));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<List<dynamic>> _combineStreams() {
    final authStream = FirebaseAuth.instance.authStateChanges();
    final salonStream =
        FirebaseFirestore.instance.collection('salons').snapshots();
    return Rx.combineLatest2(
        authStream, salonStream, (auth, salons) => [auth, salons]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailsProvider>(
          create: (_) => UserDetailsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        home: StreamBuilder<List<dynamic>>(
          stream: _combineStreams(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const ScreenLayout();
            } else {
              return const AppIntroduction();
            }
          },
        ),
      ),
    );
  }
}
