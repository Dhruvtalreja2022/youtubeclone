import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/model/user_model.dart';
import 'package:newyoutube/upload/long_video/Video_model.dart';

final allchannelProvider = Provider((ref) async{
   final usersMap = await FirebaseFirestore.instance.collection("users").get();
   List<UserModel> users = usersMap.docs.map(
           (user)=> UserModel.fromMap(
             user.data(),
           )
   ).toList();
   return users;
}
);
final allusersProvider = Provider((ref)  async{
  final VideoMap = await FirebaseFirestore.instance.collection("videos").get();
  List<VideoModel> videos =
  VideoMap.docs.map(
          (videos)=> VideoModel.fromMap(videos.data(),
  )
  ).toList();
return videos;
});