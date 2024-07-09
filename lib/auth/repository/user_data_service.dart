import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';


final userDataServiceProvider = Provider(
      (ref)=> UserDataService(
          auth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance
      ),
);


class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  UserDataService({
    required this.auth,
    required this.firestore,
  });

  // Add user data to Firestore.
  Future<void> addUserDataToFirestore({
    required String displayName,
    required String userName,
    required String email,
    required String profilePic,
    required List<String> subscription,
    required int videos,
    required String userId,
    required String description,
    required String type,
  }) async {
    try {
      UserModel user = UserModel(
        displayName: displayName,
        userName: userName,
        email: email,
        profilePic: profilePic,
        subscription: [],
        videos: 0,
        userId: auth.currentUser!.uid,
        description: description,
        type: "user",
      );

      await firestore.collection('users').doc(auth.currentUser!.uid).set(user.toMap());
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }

  }
  Future<UserModel>fetchCurrentUserData() async{
    final currentUsermodel=
    await firestore.collection("users").doc(auth.currentUser!.uid).get();
  UserModel user = UserModel.fromMap(currentUsermodel.data()!);
  return user;
  }

  Future<UserModel> fetchnnyUserData(userid) async{
    final currentUserMap = await firestore.collection("users").doc(userid).get();
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
}
}

