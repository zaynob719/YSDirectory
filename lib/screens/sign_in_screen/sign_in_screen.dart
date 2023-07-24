import 'dart:ui';

import 'package:YSDirectory/layout/screen_layout.dart';
import 'package:YSDirectory/firestore/authentication_methods.dart';
import 'package:YSDirectory/screens/sign_in_screen/resetPasswordScreen.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_up_screen.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:get/route_manager.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  'images/logo_name.png',
                  height: 200,
                  width: 150,
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
                              return SignUpScreen();
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
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Forgotten your password?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown,
                      fontFamily: 'GentiumPlus',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomMainButton(
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 19,
                        letterSpacing: 0.6,
                        fontFamily: 'GentiumPlus',
                      ),
                    ),
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
                    })
              ],
            ),
          ),
          //),
        ],
      ),
    );
  }
}
