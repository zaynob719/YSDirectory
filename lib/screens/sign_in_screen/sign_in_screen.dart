import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/layout/screen_layout.dart';
import 'package:YSDirectory/firestore/authentication_methods.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/sign_in_screen/resetPasswordScreen.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_up_screen.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  TextEditingController cityController = TextEditingController();

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
      String city = '${place.street}, ${place.locality}';
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

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await firebaseAuth.signInWithCredential(credential);
        final User? user = authResult.user;
        if (user != null) {
          final String uid = user.uid;
          final String displayName = user.displayName ?? "";
          final String email = user.email ?? "";
          final String photoURL = user.photoURL ?? "";
          await _determinePosition();

          UserDetailsModel userDetailsModel = UserDetailsModel(
            uid: uid,
            name: displayName,
            emailAddress: email,
            profilePicture: photoURL,
            userLat: position?.latitude ?? 0.0,
            userLng: position?.longitude ?? 0.0,
            city: cityController.text,
          );

          Provider.of<UserDetailsProvider>(context, listen: false)
              .updateUserDetails(
            uid: uid,
            name: displayName,
            email: email,
            profilePicture: photoURL,
            userLat: position?.latitude ?? 0.0,
            userLng: position?.longitude ?? 0.0,
            //city: cityController.text,
          );

          await cloudFirestoreClass.uploadNameAndCityToDatabase(
              user: userDetailsModel);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScreenLayout()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              content: Text(
                'Google sign-in failed. Please try again.',
              ),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            content: Text(
              'The account already exists with a different credential',
            ),
          ),
        );
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            content: Text(
              'Error occurred while accessing credentials. Try again.',
            ),
          ),
        );
      }
    } catch (e) {
      // Handle other sign-in errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          content: Text('Error occurred using Google Sign In. Try again.'),
        ),
      );
    }
  }

  Future<void> _signInWithApple() async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );

      final UserCredential authResult =
          await firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      if (user != null) {
        // Extract user details from Apple Sign-In
        String uid = user.uid;
        String name = result.givenName ?? "Add name in settings";
        String email = result.email ?? "";
        String profilePicture =
            "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fprofileb.png?alt=media&token=91b54dc7-cb7c-4d3e-bf09-5f1247219255&_gl=1*1e0fxe9*_ga*MzE1NDgyMTQyLjE2NzE1NzQ2OTI.*_ga_CW55HF8NVT*MTY5NjUxNDM5Ny4xNzguMS4xNjk2NTIxMjA1LjQ5LjAuMA.."; // You can set the profile picture URL here

        Provider.of<UserDetailsProvider>(context, listen: false)
            .updateUserDetails(
          uid: uid,
          name: name,
          email: email,
          profilePicture: profilePicture,
        );

        await _determinePosition();

        UserDetailsModel userDetails =
            Provider.of<UserDetailsProvider>(context, listen: false)
                .userDetails;
        await CloudFirestoreClass()
            .uploadNameAndCityToDatabase(user: userDetails);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenLayout()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            content: Text(
              'Apple Sign-In Failed: User is null.',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: brown,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          content: Text(
            'Apple Sign-In Error: $e',
          ),
        ),
      );
    }
  }

  @override
  int _selectedIndex = 0;
  bool _obscureText = true;
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown),
              color: AppColors.mainBrownColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'images/originalLogo.png.png',
                  height: 250,
                  width: 200,
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              color: Colors.brown,
                              fontSize: 24,
                              fontWeight: _selectedIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const SignUpScreen();
                            }));
                            setState(() {
                              _selectedIndex = 1;
                            });
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              color: Colors.brown,
                              fontSize: 24,
                              fontWeight: _selectedIndex == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 2,
                        color: AppColors.mainBrownColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailAddressController,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: brown,
                      ),
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
                        borderSide: const BorderSide(
                          color: brown,
                        ),
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
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 50,
                        height: 50,
                        thickness: 1,
                        color: Colors.black54,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or Sign in with ",
                        style: TextStyle(
                          fontFamily: 'GentiumPlus',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 50,
                        height: 50,
                        thickness: 1,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _signInWithGoogle,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Image.asset(
                            "images/google-logo-9822.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _signInWithApple,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Image.asset(
                            "images/png-apple-logo-9713.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      )
                    ]),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown,
                      fontFamily: 'GentiumPlus',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text.rich(
                    TextSpan(
                      text:
                          "By proceeding you are agreeing to Your Salon Directoy's ",
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontFamily: 'GentiumPlus',
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: 'Terms and Conditions ',
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Add CC website
                            },
                        ),
                        const TextSpan(
                          text: ' and ',
                          style: TextStyle(fontFamily: 'GentiumPlus'),
                        ),
                        TextSpan(
                          text: ' Privacy Policy!',
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Add CC website
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 15,
                ),
                CustomMainButton(
                    color: orengy,
                    isLoading: isLoading,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      String output = await authenticationMethods.signInUser(
                          emailAddress: emailAddressController.text,
                          password: passwordController.text);
                      setState(() {
                        isLoading = false;
                      });
                      if (output == "success") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenLayout()),
                        );
                      } else {
                        Utils().showSnackBar(context: context, content: output);
                      }
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        fontFamily: 'GentiumPlus',
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
