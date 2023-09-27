import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
          name: 'Loading...',
          city: 'Loading...',
          lastName: 'Loading...',
          emailAddress: 'Loading...',
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
}



  // Future<void> updateUserLat(double newUserLat) async {
  //   userDetails.userLat = newUserLat;
  //   notifyListeners();
  //   // Update userLat in Firebase Firestore
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userDetails.id)
  //       .update({'userLat': newUserLat});
  // }

  // Future<void> updateUserLng(double newUserLng) async {
  //   userDetails.userLng = newUserLng;
  //   notifyListeners();
  //   // Update userLng in Firebase Firestore
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userDetails.id)
  //       .update({'userLng': newUserLng});
  // }