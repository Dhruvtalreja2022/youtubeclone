import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/upload/long_video/Video_model.dart';

final eachChannelVideoProvider = FutureProvider.family((ref,userId) async{
  final videoMap = await
  FirebaseFirestore.instance.
    collection("videos").
where("userId",isEqualTo: userId)
    .get();
    final videos = videoMap.docs;
    final List<VideoModel> videoModels = videos.map((videos)=>VideoModel.fromMap(videos.data())).toList();
    return videoModels;
});