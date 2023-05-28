import 'package:coveredncurly/models/user_details_model.dart';
import 'package:coveredncurly/provider/user_details_provider.dart';
import 'package:coveredncurly/screens/pages/disclaimer.dart';
import 'package:coveredncurly/screens/sign_in_screen/sign_in_screen.dart';
import 'package:coveredncurly/screens/splash/splash_screen.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:coveredncurly/screens/pages/about_ysd.dart';
import 'package:coveredncurly/widgets/user_detail_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? image;
  String bigFontFamily = 'InknutAntiqua';
  String smallFontFamily = 'GentiumPlus';

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
          backgroundColor: Colors.white,
          title: Text("Your Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: smallFontFamily,
                  fontWeight: FontWeight.bold)),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                // handle edit button click
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
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    image == null
                        ? CircleAvatar(
                            radius: 50,
                            child: Image.network("https://picsum.photos/200",
                                height: screenSize.height / 10,
                                fit: BoxFit.cover),
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: Image.memory(
                              image!,
                              height: screenSize.height / 10,
                              fit: BoxFit.cover,
                            ),
                          ),
                    IconButton(
                      onPressed: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "${userDetailsModel.name}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: smallFontFamily),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      // random generation of a salon
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkerBrown,
                    ),
                    child: Text(
                      "Direct me!",
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutYSD()));
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
                      // handle FAQs button click
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
