import 'package:YSDirectory/layout/screen_layout.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/introduction/introduction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
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

  Future<bool> getSeenFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('seen_flag') ?? false;
    return seen;
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
        home: FutureBuilder<bool>(
          future: getSeenFlag(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return StreamBuilder<List<dynamic>?>(
                  stream: _combineStreams(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const ScreenLayout();
                    } else {
                      return const AppIntroduction();
                    }
                  },
                );
              } else {
                // Show the introduction screen for first-time users
                return const AppIntroduction();
              }
            } else {
              // Handle loading state or error
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
