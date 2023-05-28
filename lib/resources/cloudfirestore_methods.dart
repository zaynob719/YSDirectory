import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/models/user_details_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  Future uploadNameAndAddressToDatabase(
      {required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toJson());
  }

  Future getNameAndCity() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );
    return userModel;
  }

  final CollectionReference _salons =
      FirebaseFirestore.instance.collection('salons');

  // Future<String> uploadSalonToDatabse({
  //   required Uint8List? image,
  //   required String salonName,
  //   required String summary,
  //   required int rating,
  //   required int noOfRating,
  //   required double salonDistance,
  //   required int noOfReview,
  //   required String location,
  //   required int uid,
  // }) async {
  //   salonName.trim();
  //   String output = "something went wrong";

  // if (image! = null && salonName!=""){
  //   try{
  //     // do more stuff

  //     output = "success";
  //   } catch (e){
  //     output= e.toString();
  //   }
  // }else {
  //   output = "please fill in all the fields";
  // }
  // return output;

  //}
//}
}
