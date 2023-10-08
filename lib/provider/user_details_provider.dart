import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
          uid: 'no user',
          name: 'no user',
          city: 'no user',
          lastName: 'no user',
          emailAddress: 'no user',
          profilePicture:
              "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fprofileb.png?alt=media&token=91b54dc7-cb7c-4d3e-bf09-5f1247219255&_gl=1*1e0fxe9*_ga*MzE1NDgyMTQyLjE2NzE1NzQ2OTI.*_ga_CW55HF8NVT*MTY5NjUxNDM5Ny4xNzguMS4xNjk2NTIxMjA1LjQ5LjAuMA..",
          userLat: 0.0,
          userLng: 0.0,
        );

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndCity();
    notifyListeners();
  }

  void updateUserCity(String newCity) {
    userDetails.city = newCity;
    notifyListeners();
  }

  void updateUserLat(double newUserLat) {
    userDetails.userLat = newUserLat;
    notifyListeners();
  }

  void updateUserLng(double newUserLng) {
    userDetails.userLng = newUserLng;
    notifyListeners();
  }

  // void updateUid(String newUid) {
  //   userDetails.uid = newUid;
  //   notifyListeners();
  // }

  Future<void> updateProfilePictureUrl(String newUrl) async {
    if (userDetails != null) {
      userDetails!.updateProfilePictureUrl(newUrl);
      notifyListeners();
      try {
        await CloudFirestoreClass().updateProfilePictureUrl(newUrl);
      } catch (e) {
        // Handle any errors
        print('Error updating profile picture URL: $e');
      }
    }
  }
  // Future<void> updateProfilePictureUrl(String newUrl) async {
  //   userDetails.updateProfilePictureUrl(newUrl);
  //   notifyListeners();
  //   try {
  //     await CloudFirestoreClass().updateProfilePictureUrl(newUrl);
  //   } catch (e) {
  //     // Handle any errors
  //     print('Error updating profile picture URL: $e');
  //   }
  // }
}
