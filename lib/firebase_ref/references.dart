// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// // final fireStore = FirebaseFirestore.instance;
// // final salonsOptionRF = fireStore.collection('salons');



// FirebaseFirestore firestore = FirebaseFirestore.instance;
// CollectionReference salonsCollection = firestore.collection('salons');

// final city = <String, String>{
//   "name": "Los Angeles",
//   "state": "CA",
//   "country": "USA"
// };

// database
//     .collection("salons")
//     .doc("LA")
//     .set(city)
//     .onError((e, _) => print("Error writing document: $e"));


// // await salonsCollection.add({
// //   'name': 'Curl Talk',
// //   'address': '123 Main St',
// //   'phone': '555-555-5555',
// //   'website': 'https://www.curltalk.com',
// // });


// // DocumentReference salonProfileRF({
// //   required String salonId,
// //   required String salonProfileId,
// // }) =>
// //     salonsOptionRF.doc(salonId).collection("salonProfiles").doc(salonProfileId);

// // Reference get fireBaseStorage => FirebaseStorage.instance.ref();

// // final popularSalonRF = fireStore.collection('popularSalon');
// // DocumentReference nameRF({
// //   required String salonId,
// //   required String nameId,
// // }) =>
// //     popularSalonRF.doc(salonId).collection("names").doc(nameId);
