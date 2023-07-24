import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  final String? id;
  final String name;
  final String lastName;
  final String emailAddress;
  //final String password;
  final String city;
  UserDetailsModel(
      {this.id,
      required this.name,
      required this.lastName,
      required this.emailAddress,
      //required this.password,
      required this.city});

  Map<String, dynamic> getJson() => {
        'name': name,
        'lastName': lastName,
        'emailAddress': emailAddress,
        //'password': password,
        'city': city
      };
  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
        //id: document.id,
        name: json["name"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        //password: json["password"],
        city: json["city"]);
  }
}
