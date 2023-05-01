// import 'package:cloud_firestore/cloud_firestore.dart';

// class SalonListModel {
//   String uid;
//   String title;
//   String? imageUrl;
//   String description;
//   List<Salons>? salons;
//   int salonsCount;

//   SalonListModel(
//       {required this.uid,
//       required this.title,
//       this.imageUrl,
//       required this.description,
//       required this.salonsCount,
//       this.salons});

//   SalonListModel.fromJson(Map<String, dynamic> json)
//       : uid = json['uid'] as String,
//         title = json['title'] as String,
//         imageUrl = json['image_url'] as String,
//         description = json['description'] as String,
//         salonsCount = 0,
//         salons = (json['salons'] as List)
//             .map((dynamic e) => Salons.fromJson(e as Map<String, dynamic>))
//             .toList();

//   SalonListModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
//       : uid = json.id,
//         title = json['title'],
//         imageUrl = json['image_url'],
//         description = json['description'],
//         salonsCount = json['salons_count'] as int,
//         salons = [];

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uid'] = this.uid;
//     data['title'] = this.title;
//     data['image_url'] = this.imageUrl;
//     data['description'] = this.description;
//     return data;
//   }
// }

// class Salons {
//   String uid;
//   String salonProfile;
//   String star;
//   String location;

//   Salons(
//       {required this.uid,
//       required this.salonProfile,
//       required this.star,
//       required this.location});

//   Salons.fromJson(Map<String, dynamic> json)
//       : uid = json['uid'],
//         salonProfile = json['salonProfile'],
//         star = json['star'],
//         location = json['location'];

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uid'] = this.uid;
//     data['salonProfile'] = this.salonProfile;
//     data['star'] = this.star;
//     data['location'] = this.location;
//     return data;
//   }
// }
