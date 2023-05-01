import 'package:coveredncurly/resources/authentication_methods.dart';
import 'package:coveredncurly/screens/sign_in_screen/sign_up_screen.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/utils/colors.dart';
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
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.40,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'images/logo.png',
                  height: 200,
                  width: 150,
                ),
                SizedBox(height: 30),
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
                              color: Color(0xff8B4513),
                              fontSize: 20,
                              fontWeight: _selectedIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
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
                              color: Color(0xff8B4513),
                              fontSize: 20,
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
          SizedBox(height: 40),
          //Expanded(
          //child:
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                SizedBox(height: 10),
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgotten Password?',
                    style: TextStyle(color: Color(0xff8B4513)),
                  ),
                ),
                SizedBox(height: 20),
                CustomMainButton(
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 19, letterSpacing: 0.6),
                    ),
                    color: Color(0xff8B4513),
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
                        //main functions
                      } else {
                        //error
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