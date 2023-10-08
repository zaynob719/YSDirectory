import 'dart:convert';

import 'package:YSDirectory/firestore/add_data_firestore.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
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
  Uint8List? _image;
  String bigFontFamily = 'InknutAntiqua';
  String smallFontFamily = 'GentiumPlus';

  @override
  void initState() {
    super.initState();
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

  // void selectImage() async {
  //   List<int>? imgData = await pickImage(ImageSource.gallery);
  //   Uint8List? img;

  //   if (imgData != null) {
  //     img = Uint8List.fromList(imgData);
  //     String imageUrl = await StoreData().saveData(file: img);
  //     UserDetailsProvider userDetailsProvider =
  //         Provider.of<UserDetailsProvider>(context, listen: false);
  //     userDetailsProvider.updateProfilePictureUrl(imageUrl);
  //     userDetailsProvider.userDetails.profilePicture = imageUrl;
  //   }

  //   setState(() {
  //     _image = img;
  //   });
  // }
  void selectImage() async {
    List<int>? imgData = await pickImage(ImageSource.gallery);
    Uint8List? img;

    if (imgData != null) {
      img = Uint8List.fromList(imgData);
      String imageUrl = await StoreData().saveData(file: img);

      // Get the current user's UID
      String currentUid = FirebaseAuth.instance.currentUser!.uid;

      UserDetailsProvider userDetailsProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);

      // Check if the current user's UID matches the UID in userDetailsModel
      if (userDetailsProvider.userDetails.uid == currentUid) {
        // Update the profile picture only if it's the current user
        userDetailsProvider.updateProfilePictureUrl(imageUrl);
        userDetailsProvider.userDetails.profilePicture = imageUrl;
      }
    }
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    String response = await StoreData().saveData(file: _image!);

    if (response == 'success') {
      // Handle success, e.g., show a success message
    } else {
      // Handle the case where there was an error, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileSetting()));
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
                    _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: lightBrown,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundColor: lightBrown,
                            backgroundImage: NetworkImage(userDetailsModel
                                    .profilePicture ??
                                "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fprofileb.png?alt=media&token=91b54dc7-cb7c-4d3e-bf09-5f1247219255&_gl=1*1e0fxe9*_ga*MzE1NDgyMTQyLjE2NzE1NzQ2OTI.*_ga_CW55HF8NVT*MTY5NjUxNDM5Ny4xNzguMS4xNjk2NTIxMjA1LjQ5LjAuMA.."),
                          ),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                          ),
                        ),
                      ),
                      bottom: -10,
                      right: -10,
                    ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQPage()));
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
                              builder: (context) => const Disclaimer()));
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
