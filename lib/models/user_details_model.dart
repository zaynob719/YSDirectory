import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  final String? id;
  final String name;
  final String lastName;
  final String emailAddress;
  String city;
  double? userLat;
  double? userLng;
  UserDetailsModel(
      {this.id,
      required this.name,
      required this.lastName,
      required this.emailAddress,
      required this.city,
      this.userLat,
      this.userLng});

  void updateCity(String newCity) {
    city = newCity;
  }

  void updateUserLat(double newUserLat) {
    userLat = newUserLat;
  }

  void updateUserLng(double newUserLng) {
    userLng = newUserLng;
  }

  Map<String, dynamic> getJson() => {
        'name': name,
        'lastName': lastName,
        'emailAddress': emailAddress,
        'city': city,
        'userLat': userLat,
        'userLng': userLng,
      };
  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      name: json["name"],
      lastName: json["lastName"],
      emailAddress: json["emailAddress"],
      city: json["city"],
      userLat: json["userLat"],
      userLng: json["userLng"],
    );
  }
}
