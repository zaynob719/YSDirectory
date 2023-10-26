import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  Future<String> signUpUser({
    required String firstName,
    required String lastName,
    required String emailAddress,
    required String confirmEmailAddress,
    required String password,
    required String confirmPassword,
    required String city,
    double? userLat,
    double? userLng,
    String? profilePicture,
  }) async {
    firstName.trim();
    lastName.trim();
    emailAddress.trim();
    confirmEmailAddress.trim();
    confirmPassword.trim();
    password.trim();
    city.trim();
    String output = "Ops! Something went wrong";
    if (firstName != "" &&
        lastName != "" &&
        emailAddress != "" &&
        confirmEmailAddress != "" &&
        password != "" &&
        confirmPassword != "" &&
        city != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: emailAddress, password: confirmPassword);
        User? user = firebaseAuth.currentUser;

        if (user != null) {
          UserDetailsModel userDetailsModel = UserDetailsModel(
            uid: user.uid,
            name: firstName,
            lastName: lastName,
            emailAddress: emailAddress,
            city: city,
            userLat: userLat,
            userLng: userLng,
            profilePicture: profilePicture,
          );
          await cloudFirestoreClass.uploadNameAndCityToDatabase(
              user: userDetailsModel);
          output = "success";
        } else {
          output = "User creation failed";
        }
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields";
    }
    return output;
  }

  Future<String> signInUser({
    required String emailAddress,
    required String password,
  }) async {
    emailAddress.trim();
    password.trim();
    String output = "Ops! Something went wrong";
    if (emailAddress != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: emailAddress, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill in all the fields";
    }
    return output;
  }
}
