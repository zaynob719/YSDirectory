import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final salonsOptionRF = fireStore.collection('salons');
DocumentReference salonProfileRF({
  required String salonId,
  required String salonProfileId,
}) =>
    salonsOptionRF.doc(salonId).collection("salonProfiles").doc(salonProfileId);
