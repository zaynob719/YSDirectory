import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:YSDirectory/widgets/result_widget.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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

  Future<void> updateUserProfilePicture(
      String userId, String newProfilePicture) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'profilePicture': newProfilePicture,
      });
    } catch (e) {
      print('Error updating profile picture: $e');
      // Handle the error as needed
    }
  }

  Future<void> updateProfilePictureUrl(String newUrl) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      await usersCollection.doc(firebaseAuth.currentUser!.uid).update({
        'profilePicture': newUrl,
      });
    } catch (e) {
      print('Error updating profile picture URL: $e');
      // Handle the error as needed
    }
  }

  Future<Salon?> getSalonDetailsById(String salonId) async {
    try {
      final salonDocument = await FirebaseFirestore.instance
          .collection('salons')
          .doc(salonId)
          .get();

      if (salonDocument.exists) {
        final salonData = salonDocument.data() as Map<String, dynamic>;
        return Salon.fromJson(salonData);
      } else {
        // Salon with the provided ID does not exist
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> addBookmarkToUser(String userId, String salonId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'bookmarkedSalonIds': FieldValue.arrayUnion([salonId]),
      });
    } catch (e) {
      print('Error adding bookmark to user: $e');
      // Handle the error as needed
    }
  }

  Future<void> removeBookmarkFromUser(String userId, String salonId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'bookmarkedSalonIds': FieldValue.arrayRemove([salonId]),
      });
    } catch (e) {
      print('Error removing bookmark from user: $e');
      // Handle the error as needed
    }
  }

  Future<List> getBookmarkedSalonIds(String userId) async {
    final userDocument =
        await firebaseFirestore.collection('users').doc(userId).get();
    if (userDocument.exists) {
      final data = userDocument.data() as Map<String, dynamic>;
      final bookmarkedSalonIds = (data['bookmarkedSalonIds'] as List)
          .map((dynamic item) => item.toString())
          .toList();
      return bookmarkedSalonIds ?? [];
    }
    return [];
  }
}
