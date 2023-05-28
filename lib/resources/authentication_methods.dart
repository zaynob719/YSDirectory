import 'package:coveredncurly/models/user_details_model.dart';
import 'package:coveredncurly/resources/cloudfirestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  Future<String> signUpUser(
      {required String firstName,
      required String lastName,
      required String emailAddress,
      required String confirmEmailAddress,
      required String password,
      required String confirmPassword,
      required String city}) async {
    firstName.trim();
    lastName.trim();
    emailAddress.trim();
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
        UserDetailsModel user = UserDetailsModel(
            name: firstName,
            lastName: lastName,
            emailAddress: emailAddress,
            password: password,
            city: city);
        await cloudFirestoreClass.uploadNameAndAddressToDatabase(user: user);
        output = "success";
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
      output = "Please fill up all the fields";
    }
    return output;
  }
}
