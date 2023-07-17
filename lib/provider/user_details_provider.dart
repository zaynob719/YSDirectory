import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
            name: 'Loading...',
            city: 'Loading...',
            lastName: 'Loading',
            emailAddress: 'Loading',
            password: 'Loading');

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndCity();
    notifyListeners();
  }
}
