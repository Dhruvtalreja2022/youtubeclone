import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/Short_video/content/short_video_model.dart';
final shortVideoProvider = Provider((ref)=> ShortVideoRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance,));
class ShortVideoRepository{
  final FirebaseFirestore firestore;
  final FirebaseAuth  auth;

  ShortVideoRepository({required this.firestore, required this.auth});
  
  Future<void> addShortVideoToDatbase({
    required String caption,
    required String shortVideo,
    required DateTime datePublished,

}) async{
    ShortVideoModel shortVideoModel = ShortVideoModel(
        caption: caption,
        userId:  auth.currentUser!.uid,
        shortVideo: shortVideo,
        datePublished: datePublished,);
   await firestore.collection("shorts").add(shortVideoModel.toMap());
  }
}