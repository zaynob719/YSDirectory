import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
final salonsOptionRF = fireStore.collection('salons');
DocumentReference salonProfileRF({
  required String salonId,
  required String salonProfileId,
}) =>
    salonsOptionRF.doc(salonId).collection("salonProfiles").doc(salonProfileId);

Reference get fireBaseStorage => FirebaseStorage.instance.ref();

// final popularSalonRF = fireStore.collection('popularSalon');
// DocumentReference nameRF({
//   required String salonId,
//   required String nameId,
// }) =>
//     popularSalonRF.doc(salonId).collection("names").doc(nameId);
