// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// class SalonModel {
//   final String url;
//   final String uid;
//   final String salonName;
//   final String summary;
//   final int rating;
//   final int noOfRating;
//   final double salonDistance;
//   final int noOfReview;
//   final String location;

//   SalonModel({
//     required this.url,
//     required this.uid,
//     required this.salonName,
//     required this.summary,
//     required this.rating,
//     required this.noOfRating,
//     required this.salonDistance,
//     required this.noOfReview,
//     required this.location,
//   });

//   Map<String, dynamic> getJson() {
//     return {
//       'url': url,
//       'uid': uid,
//       'salonName': salonName,
//       'summary': summary,
//       'rating': rating,
//       'noOfRating': noOfRating,
//       'salonDistance': salonDistance,
//       'noOfReview': noOfReview,
//       'location': location,
//     };
//   }

//   factory SalonModel.getModelFromJson({required Map<String, dynamic> json}) {
//     return SalonModel(
//         url: json["url"],
//         uid: json["uid"],
//         salonName: json["salonName"],
//         summary: json["summary"],
//         rating: json["rating"],
//         noOfRating: json["noOfRating"],
//         salonDistance: json["salonDistance"],
//         noOfReview: json["noOfReview"],
//         location: json["location"]);
//   }

//   static fromFirestore(QueryDocumentSnapshot<Object?> doc) {}
// }
