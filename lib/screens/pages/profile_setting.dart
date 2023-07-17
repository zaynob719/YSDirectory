import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    emailAddressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void updateUserDetails() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Map<String, dynamic> userDetails = {};

    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String password = passwordController.text.trim();
    String emailAddress = emailAddressController.text.trim();
    String city = cityController.text.trim();

    if (name.isNotEmpty) {
      userDetails['name'] = name;
    }
    if (lastName.isNotEmpty) {
      userDetails['lastName'] = lastName;
    }
    if (password.isNotEmpty) {
      userDetails['password'] = password;
    }
    if (emailAddress.isNotEmpty) {
      userDetails['emailAddress'] = emailAddress;
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
            SnackBar(
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
          icon: Icon(
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
              Text(
                "Name",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter new name',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Last Name",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: 'Enter last name',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Password",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Enter new password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )),
                obscureText: _obscureText,
              ),
              const SizedBox(height: 10),
              const Text(
                "Email",
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailAddressController,
                decoration: const InputDecoration(
                  hintText: "Enter new email address",
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
              const SizedBox(height: 20),
              Center(
                child: CustomMainButton(
                    child: Text(
                      'Save',
                      style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 18),
                    ),
                    color: brown,
                    isLoading: false,
                    onPressed: () {
                      updateUserDetails();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
