import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  final String? id;
  final String name;
  final String lastName;
  final String emailAddress;
  final String city;
  UserDetailsModel(
      {this.id,
      required this.name,
      required this.lastName,
      required this.emailAddress,
      required this.city});

  Map<String, dynamic> getJson() => {
        'name': name,
        'lastName': lastName,
        'emailAddress': emailAddress,
        'city': city
      };
  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
        name: json["name"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        city: json["city"]);
  }
}
