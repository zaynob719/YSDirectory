import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/models/review_model.dart';
import 'package:coveredncurly/models/user_details_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  Future uploadNameAndCityToDatabase({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future<UserDetailsModel> getNameAndCity() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    if (snap.exists && snap.data() != null) {
      UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
        (snap.data() as dynamic),
      );
      return userModel;
    } else {
      throw Exception("User details not found.");
    }
  }

  final CollectionReference _salons =
      FirebaseFirestore.instance.collection('salons');

  Future<void> uploadReviewToDatabase(
      {required String id, required ReviewModel model}) async {
    await _salons.doc(id).collection("reviews").doc().set(model.toJson());
  }

  // final CollectionReference _salons =
  //     FirebaseFirestore.instance.collection('salons');

  // Future<void> uploadReviewToDatabase(
  //     {required String id, required ReviewModel model}) async {
  //   await FirebaseFirestore.instance
  //       .collection("salons")
  //       .doc(id)
  //       .collection("reviews")
  //       .add(model.toJson());
  // }
}
