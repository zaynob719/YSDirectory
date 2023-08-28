import 'package:YSDirectory/layout/screen_layout.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/location_provider.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/introduction/introduction.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:YSDirectory/utils/utils.dart';
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

  Position? position;
  String userLocation = '';
  //String address = 'search';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position newPosition = await Geolocator.getCurrentPosition();
      setState(() {
        position = newPosition;
      });
      userLocation = 'Lat: ${position?.latitude}, Long:${position?.longitude}';
      GetAddressFromLatLong(newPosition);
    } catch (error) {
      print('Error determining position: $error');
    }
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    String newAddress = '${place.street}, ${place.locality}';
    //widget.address = newAddress;
    Provider.of<LocationProvider>(context, listen: false)
        .setAddress(newAddress);

    print(newAddress);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailsProvider>(
          create: (_) => UserDetailsProvider(),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (_) => LocationProvider(),
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






// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await Future.delayed(const Duration(seconds: 1));
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Stream<List<dynamic>> _combineStreams() {
//     final authStream = FirebaseAuth.instance.authStateChanges();
//     final salonStream =
//         FirebaseFirestore.instance.collection('salons').snapshots();
//     return Rx.combineLatest2(
//         authStream, salonStream, (auth, salons) => [auth, salons]);
//   }


//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserDetailsProvider>(
//           create: (_) => UserDetailsProvider(),
//         ),
//         ChangeNotifierProvider<LocationProvider>(
//           create: (_) => LocationProvider(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(brightness: Brightness.light),
//         home: StreamBuilder<List<dynamic>>(
//           stream: _combineStreams(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return const ScreenLayout();
//             } else {
//               return SignInScreen();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

