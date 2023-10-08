import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//creating ans saving the profile picture selected by user to firebase storage - then providing a url
  Future<String> saveData({
    required Uint8List file,
  }) async {
    try {
      String imageUrl = await uploadImageToStorage(
          'profileImage/${firebaseAuth.currentUser!.uid}', file);
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({'profilePicture': imageUrl});
      return imageUrl;
    } catch (err) {
      print('Error saving data: $err');
      return err.toString();
    }
  }
}
