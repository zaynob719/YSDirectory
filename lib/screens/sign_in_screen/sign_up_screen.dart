import 'dart:developer';

import 'package:coveredncurly/resources/authentication_methods.dart';
import 'package:coveredncurly/screens/sign_in_screen/sign_in_screen.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:get/route_manager.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _obscureText = true;
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController confirmEmailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  bool isLoading = false;

  // @override
  // void dispose() {
  //   super.dispose();

  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 65),
            Text(
              "Register",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                //fontFamily: InknutAntiqua-bold
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Let's Get Your Hair Did Sis!",
              style: TextStyle(
                color: Color.fromARGB(255, 55, 24, 1),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
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
                        borderSide: BorderSide(
                          color: Color(0xff8B4513),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff8B4513),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      labelText: ' Country',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff8B4513),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: emailAddressController,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff8B4513),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: confirmEmailAddressController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Email address',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff8B4513),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff8B4513),
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
                  SizedBox(height: 25),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff8B4513),
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
                  SizedBox(height: 40),
                  Container(
                    child: Text(
                        "By selecting 'Sign Up!', you indicate that you have read and agree with our Terms and conditions and Privacy policy."),
                  ),
                  SizedBox(height: 30),
                  CustomMainButton(
                    child: Text(
                      "Sign Up!",
                      style: TextStyle(fontSize: 19, letterSpacing: 0.6),
                    ),
                    color: Color(0xff8B4513),
                    isLoading: false,
                    onPressed: () async {
                      setState(() {
                        isLoading = isLoading;
                      });
                      String output = await authenticationMethods.signUpUser(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          emailAddress: emailAddressController.text,
                          confirmEmailAddress:
                              confirmEmailAddressController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          country: countryController.text);
                      setState(() {
                        isLoading = false;
                      });
                      if (output == "success") {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignInScreen()));
                      } else {
                        //error message
                        Utils().showSnackBar(context: context, content: output);
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomMainButton(
                    child: Text(
                      "Back",
                      style: TextStyle(fontSize: 19, letterSpacing: 0.6),
                    ),
                    color: Color.fromARGB(255, 202, 199, 197),
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignInScreen();
                      }));
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}