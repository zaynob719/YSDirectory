import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  String uid;
  final String name;
  final String lastName;
  final String emailAddress;
  String? profilePicture;
  String city;
  double? userLat;
  double? userLng;

  UserDetailsModel({
    required this.uid,
    required this.name,
    required this.lastName,
    required this.emailAddress,
    required this.city,
    this.userLat,
    this.userLng,
    this.profilePicture,
  });

  // void updateUid(String newUid) {
  //   uid = newUid;
  // }

  void updateCity(String newCity) {
    city = newCity;
  }

  void updateUserLat(double newUserLat) {
    userLat = newUserLat;
  }

  void updateUserLng(double newUserLng) {
    userLng = newUserLng;
  }

  void updateProfilePictureUrl(String newUrl) {
    profilePicture = newUrl;
  }

  Map<String, dynamic> getJson() => {
        'uid': uid,
        'name': name,
        'lastName': lastName,
        'emailAddress': emailAddress,
        'city': city,
        'userLat': userLat,
        'userLng': userLng,
        'profilePicture': profilePicture,
      };
  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      uid: json["uid"],
      name: json["name"],
      lastName: json["lastName"],
      emailAddress: json["emailAddress"],
      city: json["city"],
      userLat: json["userLat"],
      userLng: json["userLng"],
      profilePicture: json["profilePicture"],
    );
  }
}
