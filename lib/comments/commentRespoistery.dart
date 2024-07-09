import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'commonetsMode;.dart';


final commentProvider = Provider(
      (ref)=>
          commentRespository(firestore:
          FirebaseFirestore.instance
          ),
);
class commentRespository{
  final FirebaseFirestore firestore;
commentRespository({
    required this.firestore,
});

Future<void  > upload_comment({
    required String CommentText,
    required String videoId,
    required String display_name,
    required String profilePic,

})async{
  String commentId = const Uuid().v4();
  commentmodel comment = commentmodel(
      CommentText: CommentText,
      videoId: videoId,
      commentId: commentId,
      display_name: display_name,
      profilePic: profilePic);
  await firestore.collection("comments").doc(commentId).set(comment.toMap());
}
}