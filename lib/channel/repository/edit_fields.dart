import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final editSettingsProvider = Provider((ref) => EditFields(
  firestore: FirebaseFirestore.instance,
  auth: FirebaseAuth.instance,
  storage: FirebaseStorage.instance,
));

class EditFields {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  EditFields({
    Key? key,
    required this.firestore,
    required this.auth,
    required this.storage,
  });

  Future<void> editDisplayName(String displayName) async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      "displayName": displayName,
    });
  }

  Future<void> editUserName(String username) async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      "UserName": username,
    });
  }

  Future<void> editDescription(String description) async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      "description": description,
    });
  }

  Future<void> editProfilePicture(File imageFile) async {
    try {
      // Upload image to Firebase Storage
      String fileName = path.basename(imageFile.path);
      String userId = auth.currentUser!.uid;
      Reference storageRef = storage.ref().child("profilePictures/$userId/$fileName");

      await storageRef.putFile(imageFile);
      String downloadUrl = await storageRef.getDownloadURL();

      // Update Firestore with the new profile picture URL
      await firestore.collection("users").doc(userId).update({
        "profilePic": downloadUrl,
      });
    } catch (e) {
      print("Failed to upload image and update profile picture: $e");
      // Handle the error accordingly in a real app
    }
  }
}
