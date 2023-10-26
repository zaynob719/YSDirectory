import 'package:YSDirectory/calculateDistance.dart';
//import 'package:YSDirectory/fie/authentication_methods.dart';
import 'package:YSDirectory/firestore/authentication_methods.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController confirmEmailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isLoading = false;

//TO-DO - dispose of the controller when no longer used
// @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _determinePosition();
  }

  Position? position;
  String userLocation = '';
  late final Salon? salon;

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

      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        position = newPosition;
      });
      _updateUserDetails(position);
    } catch (error) {
      //print('Error determining position: $error');
    }
  }

  Future<void> _updateUserDetails(Position? position) async {
    if (position != null) {
      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemark[0];
      cityController.text = '${place.street}, ${place.locality}';
      double userLat = position.latitude;
      double userLng = position.longitude;

      // Update user details using Provider
      Provider.of<UserDetailsProvider>(context, listen: false)
          .updateUserCity('${place.street}, ${place.locality}');
      Provider.of<UserDetailsProvider>(context, listen: false)
          .updateUserLat(userLat);
      Provider.of<UserDetailsProvider>(context, listen: false)
          .updateUserLng(userLng);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Register",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GentiumPlus'),
            ),
            const SizedBox(height: 10),
            const Text(
              "Let's Get Your Hair Did Sis!",
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'GentiumPlus'),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: ' City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: emailAddressController,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: confirmEmailAddressController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )),
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )),
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                      TextSpan(
                        text:
                            'Disclaimer: The information displayed may not be accurate. Please contact the salon specifically for updated information. Read our ',
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontFamily: 'GentiumPlus',
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Add your logic here for what happens when the user taps the button
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  CustomMainButton(
                    color: orengy,
                    isLoading: false,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      String output = await authenticationMethods.signUpUser(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        emailAddress: emailAddressController.text,
                        confirmEmailAddress: confirmEmailAddressController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        city: cityController.text,
                        userLat: userDetails.userLat,
                        userLng: userDetails.userLng,
                        profilePicture:
                            "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fprofileb.png?alt=media&token=91b54dc7-cb7c-4d3e-bf09-5f1247219255&_gl=1*1e0fxe9*_ga*MzE1NDgyMTQyLjE2NzE1NzQ2OTI.*_ga_CW55HF8NVT*MTY5NjUxNDM5Ny4xNzguMS4xNjk2NTIxMjA1LjQ5LjAuMA..",
                      );
                      if (output == "success") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignInScreen()));
                      } else {
                        //error message
                        Utils().showSnackBar(context: context, content: output);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text(
                      "Sign Up!",
                      style: TextStyle(
                          fontSize: 19,
                          letterSpacing: 0.6,
                          fontFamily: 'GentiumPlus'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomMainButton(
                    color: const Color.fromARGB(255, 202, 199, 197),
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignInScreen();
                      }));
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 19,
                          letterSpacing: 0.6,
                          fontFamily: 'GentiumPlus'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
