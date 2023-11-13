import 'package:YSDirectory/screens/sign_in_screen/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<bool> _values = [
    true,
    true,
  ];
  int count = 1;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailAddressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void updateUserDetails() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Map<String, dynamic> userDetails = {};

    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String city = cityController.text.trim();

    if (name.isNotEmpty) {
      userDetails['name'] = name;
    }
    if (lastName.isNotEmpty) {
      userDetails['lastName'] = lastName;
    }
    if (city.isNotEmpty) {
      userDetails['city'] = city;
    }

    if (userDetails.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update(userDetails)
          .then((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              content: Text('Details successfully updated '),
            ),
          );
          Navigator.pop(context);
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating user details: $error')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Update Details",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'GentiumPlus',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter new name',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Last Name",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter last name',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Location",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  hintText: "Enter new location",
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: CustomMainButton(
                    color: orengy,
                    isLoading: isLoading,
                    onPressed: () {
                      updateUserDetails();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 18),
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Communication preferences",
                style: TextStyle(
                    fontFamily: 'GentiumPlus',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Manage your YSDirectory communication preferences below. By opting in, you'll receive YSDirectory communication when a new salon guide is added, to prompt you to add a review and/or when discounts are on offer via the channels you choose.",
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 14),
              ),
              const SizedBox(height: 25),
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Push notifications',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: 'GentiumPlus',
                          ),
                    ),
                    trailing: CupertinoSwitch(
                      value: _values[0],
                      onChanged: (bool value) {
                        setState(() {
                          _values[0] = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Via email',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: 'GentiumPlus',
                          ),
                    ),
                    trailing: CupertinoSwitch(
                      value: _values[1],
                      onChanged: (bool value) {
                        setState(() {
                          _values[1] = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "You can revoke your consent for each communication channel above by clicking the rrelevant button. If you withdraw your consent, you'll no longet receive Your Salon Direcory communication. ",
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 5,
                indent: 10,
                endIndent: 10,
                thickness: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "CAUTION!\nThe button below will permeently delete your account from our database. You'll have to recreate a new account if you want to continue using YSDirectory's services",
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CustomMainButton(
                    color: tagColor,
                    isLoading: isLoading,
                    onPressed: () async {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        try {
                          await user.delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                              content: Text("Account succesfully deleted "),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));

                          // Navigate to the login screen.
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: brown,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                              content: Text("Error deleting user: $e"),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Delete account',
                      style: TextStyle(
                          fontFamily: 'GentiumPlus',
                          fontSize: 18,
                          color: Colors.red),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
