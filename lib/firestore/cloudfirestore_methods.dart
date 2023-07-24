import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/models/user_details_model.dart';
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

  final CollectionReference _feedbackCollection =
      FirebaseFirestore.instance.collection('feedbacks');

  Future<void> uploadFeedbackToDatabase({
    required String subject,
    required String emailAddress, //user email
    required String message,
    //required String timestamp,
  }) async {
    await _feedbackCollection.add({
      "subject": subject,
      "userEmail": emailAddress,
      "message": message,
      //"timestamp": timestamp,
    });
  }
}
