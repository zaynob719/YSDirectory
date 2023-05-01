import 'package:coveredncurly/models/user_details_model.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:coveredncurly/widgets/user_detail_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Zaynob Sumon";
  String avatarUrl = "https://picsum.photos/200";
  String bigFontFamily = 'InknutAntiqua';
  String smallFontFamily = 'GentiumPlus';

  @override
  Widget build(BuildContext context) {
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
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UserDetailBar(
                  offset: 0,
                  userDetails: UserDetailsModel(
                      name: "Zaynob", country: "United Kingdom"),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                SizedBox(height: 10),
                Text(
                  //"${userDetails.name}",
                  userName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: smallFontFamily),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(10),
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
                      SizedBox(height: 10),
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
                      // handle YSDirectory button click, then on the page add a section 'looking for after care? check out covered and curly
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
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      // handle disclaimers button click
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
                SizedBox(height: 20),
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
                    onPressed: () {}),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
