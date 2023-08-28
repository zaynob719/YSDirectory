import 'dart:convert';

import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/pages/FAQPage.dart';
import 'package:YSDirectory/screens/pages/disclaimer.dart';
import 'package:YSDirectory/screens/pages/profile_setting.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:YSDirectory/screens/pages/about_ysd.dart';
import 'package:YSDirectory/widgets/user_detail_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:YSDirectory/models/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? image;
  late SharedPreferences _preferences;
  String bigFontFamily = 'InknutAntiqua';
  String smallFontFamily = 'GentiumPlus';
  String? userAvatar;

  @override
  void initState() {
    super.initState();
    loadUserAvatar(); // Load the user's avatar from SharedPreferences
  }

  void loadUserAvatar() async {
    _preferences = await SharedPreferences.getInstance();
    userAvatar = _preferences.getString('userAvatar');
    setState(() {});
  }

  void saveUserAvatar(String? avatar) async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences.setString('userAvatar', avatar ?? '');
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("Your Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: smallFontFamily,
                  fontWeight: FontWeight.bold)),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileSetting()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                UserDetailBar(
                  offset: 0,
                  //address: address,
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    if (userAvatar == null)
                      ClipOval(
                        child: Image.asset("images/profileb.png",
                            height: 100, width: 100, fit: BoxFit.cover),
                      )
                    else
                      ClipOval(
                        child: image != null
                            ? Image.memory(
                                image!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "images/profileb.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                    IconButton(
                      onPressed: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                            userAvatar = base64Encode(temp);
                            saveUserAvatar(userAvatar);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userDetailsModel.name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: smallFontFamily),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userDetailsModel.lastName,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: smallFontFamily),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  userDetailsModel.emailAddress,
                  style: TextStyle(fontFamily: smallFontFamily),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 230,
                  child: ElevatedButton(
                    onPressed: () {
                      // pop up text field to recommend salon
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orengy,
                    ),
                    child: Text(
                      "Recommend a salon!",
                      style: TextStyle(
                        fontFamily: smallFontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Saved Salons",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: smallFontFamily),
                      ),
                      const SizedBox(height: 10),
                      // TODO: Implement list of saved salons
                    ],
                  ),
                ),
                // add saved salons section on container
                // Expanded(
                //   child: Container(),
                // ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutYSD()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brown,
                    ),
                    child: Text(
                      "About YSDirectory",
                      style:
                          TextStyle(fontFamily: smallFontFamily, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FAQPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brown,
                    ),
                    child: Text(
                      "FAQs",
                      style:
                          TextStyle(fontFamily: smallFontFamily, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Disclaimer()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brown,
                    ),
                    child: Text(
                      "Disclaimers",
                      style:
                          TextStyle(fontFamily: smallFontFamily, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomMainButton(
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                          fontFamily: smallFontFamily,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    color: backgroundColor,
                    isLoading: false,
                    onPressed: signOut),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
