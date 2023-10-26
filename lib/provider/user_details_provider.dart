import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';

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
          bookmarkedSalonIds: [],
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

  void updateUserDetails({
    required String uid,
    required String name,
    required email,
    required profilePicture,
    double? userLat,
    double? userLng,
    String? city,
  }) {
    userDetails = UserDetailsModel(
      uid: uid,
      name: name,
      emailAddress: email,
      profilePicture: profilePicture,
      userLat: userLat ?? userDetails.userLat,
      userLng: userLng ?? userDetails.userLng,
      city: city ?? userDetails.city,
    );
    notifyListeners();
  }

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

  void addBookmark(String salonId) {
    userDetails.bookmarkedSalonIds.add(salonId);
    notifyListeners();
    CloudFirestoreClass().addBookmarkToUser(userDetails.uid, salonId);
  }

  void removeBookmark(String salonId) {
    userDetails.bookmarkedSalonIds.remove(salonId);
    notifyListeners();
    CloudFirestoreClass().removeBookmarkFromUser(userDetails.uid, salonId);
  }
}
