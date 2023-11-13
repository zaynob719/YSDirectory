import 'package:YSDirectory/firestore/add_data_firestore.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/pages/FAQPage.dart';
import 'package:YSDirectory/screens/pages/disclaimer.dart';
import 'package:YSDirectory/screens/pages/profile_setting.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/screens/show_more.dart';
import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:YSDirectory/screens/pages/about_ysd.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:YSDirectory/widgets/user_detail_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final Function(int)? onNoOfReviewUpdated;
  const ProfilePage({
    Key? key,
    this.onNoOfReviewUpdated,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  String bigFontFamily = 'InknutAntiqua';
  String smallFontFamily = 'GentiumPlus';

  List<Salon> salons = [];
  Map<String, double> salonDistances = {};
  List<String> bookmarkedSalonIds = [];

  @override
  void initState() {
    super.initState();
    fetchSavedSalons();
  }

  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('user_uid');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
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
          content: Text('Error signing out: $e'),
        ),
      );
    }
  }

  void selectImage() async {
    List<int>? imgData = await pickImage(ImageSource.gallery);
    Uint8List? img;

    if (imgData != null) {
      img = Uint8List.fromList(imgData);
      String imageUrl = await StoreData().saveData(file: img);
      String currentUid = FirebaseAuth.instance.currentUser!.uid;

      UserDetailsProvider userDetailsProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      if (userDetailsProvider.userDetails.uid == currentUid) {
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

  Future<List<Salon>> fetchSavedSalons() async {
    final userDetailsProvider =
        Provider.of<UserDetailsProvider>(context, listen: false);
    final userId = userDetailsProvider.userDetails.uid;
    final bookmarkedSalonIds =
        await CloudFirestoreClass().getBookmarkedSalonIds(userId);

    final List<Salon> savedSalons = [];

    for (final salonId in bookmarkedSalonIds) {
      final Salon? salon =
          await CloudFirestoreClass().getSalonDetailsById(salonId);
      if (salon != null) {
        savedSalons.add(salon);
      }
    }
    return savedSalons;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'My recommendation',
        'body':
            'Hello, I think you should add such salons on the app: Name: , Location: , Contact details (this can be social media related or via email/phone number: )'
      }),
    );
    launchUrl(emailLaunchUri);
    // final String emailLaunchString = Uri.encodeFull(emailLaunchUri.toString());
    // _launchURL(emailLaunchString);
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
          centerTitle: true,
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
                      bottom: -10,
                      right: -10,
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
                      userDetailsModel.lastName ?? "!",
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
                      _launchEmail("yoursalondirectory@gmail.com");
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
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: smallFontFamily),
                      ),
                      const SizedBox(height: 15),
                      FutureBuilder<List<Salon>>(
                        future: fetchSavedSalons(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error.toString()}");
                          } else if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                "No salons here yet. \nJust tap on the bookmark icon on the salon detail page!",
                                style: TextStyle(
                                    fontFamily: 'GentiumPlus',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.4)),
                              ),
                            );
                          } else {
                            final savedSalons = snapshot.data!;
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: savedSalons.map((salon) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SalonDetailScreen(
                                                  salon: salon,
                                                  onNoOfReviewUpdated:
                                                      onNoOfReviewUpdated),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 150,
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image:
                                                      NetworkImage(salon.url),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${salon.totalRating}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'GentiumPlus',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        letterSpacing: 0.7,
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 14,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          salon.salonName,
                                          style: TextStyle(
                                            fontFamily: smallFontFamily,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          salon.location,
                                          style: TextStyle(
                                            fontFamily: smallFontFamily,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
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
                        style: TextStyle(
                            fontFamily: smallFontFamily, fontSize: 18),
                      ),
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
                    color: backgroundColor,
                    isLoading: false,
                    onPressed: () => signOut(context),
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                          fontFamily: smallFontFamily,
                          fontSize: 18,
                          color: Colors.black),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
