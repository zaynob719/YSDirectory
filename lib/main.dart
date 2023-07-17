import 'package:YSDirectory/layout/screen_layout.dart';
import 'package:YSDirectory/models/review_count_model.dart';
import 'package:YSDirectory/provider/location_provider.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart' as geo;
//import 'package:geocoding/geocoding.dart';
//import 'package:YSDirectory/models/locationData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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

  loc.Location location = loc.Location();
  bool _serviceEnabled = false;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.denied;
  loc.LocationData? _locationData;
  String _currentAddress = '';

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _locationData = await location.getLocation();
      Provider.of<LocationProvider>(context, listen: false)
          .updateLocation(_locationData);
      await updateCurrentAddress();
      print('Longitude: ${_locationData!.longitude}');
      print('Latitude: ${_locationData!.latitude}');
    }
    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
      });
      Provider.of<LocationProvider>(context, listen: false)
          .updateLocation(currentLocation);
    });
  }

  Future<void> updateCurrentAddress() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        _locationData!.latitude!,
        _locationData!.longitude!,
      );
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        setState(() {
          _currentAddress =
              '${placemark.street}, ${placemark.locality}, ${placemark.country}';
        });
      }
    } catch (e) {
      print('Failed to get current address: $e');
    }
  }

  Future<void> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle denied permission
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle denied permission forever
      return;
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle location services disabled
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      return null;
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle denied permission forever
      return null;
    }

    Position? position = await Geolocator.getCurrentPosition();
    return position;
  }

  // void getLocation() async {
  //   await getLocationPermission();
  //   Position? position = await getCurrentLocation();
  //   if (position != null) {
  //     double latitude = position.latitude;
  //     double longitude = position.longitude;
  //     // Use the latitude and longitude values as needed
  //     print('Latitude: $latitude, Longitude: $longitude');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailsProvider>(
          create: (_) => UserDetailsProvider(),
        ),
        ChangeNotifierProvider<ReviewCountModel>(
          create: (_) => ReviewCountModel(),
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
              return SignInScreen();
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
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   Stream<List<dynamic>> _combineStreams() {
//     final authStream = FirebaseAuth.instance.authStateChanges();
//     final salonStream =
//         FirebaseFirestore.instance.collection('salons').snapshots();
//     return Rx.combineLatest2(
//         authStream, salonStream, (auth, salons) => [auth, salons]);
//   }

//   Location location = new Location();
//   bool _serviceEnabled = false;
//   PermissionStatus _permissionGranted = PermissionStatus.denied;
//   LocationData _locationData;

//   Future<dynamic> getLocation() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) _serviceEnabled = await location.requestService();

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//     }
//     _locationData = await location.getLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserDetailsProvider>(
//           create: (_) => UserDetailsProvider(),
//         ),
//         ChangeNotifierProvider<ReviewCountModel>(
//           create: (_) => ReviewCountModel(),
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
