import 'package:flutter/cupertino.dart';

class commentmodel {
  final String CommentText;
  final String videoId;
  final String commentId;
  final String display_name;
  final String profilePic;

  commentmodel({
    required this.CommentText,
    required this.videoId,
    required this.commentId,
    required this.display_name,
    required this.profilePic,
  }
  );
Map<String, dynamic> toMap(){
  return <String,dynamic>{
    'CommentText':CommentText,
    'videoID': videoId,
    'commentId': commentId,
    'display_name': display_name,
    'profilePic': profilePic,
  };
}
factory commentmodel.fromMap(Map<String,dynamic> map){
  return commentmodel(
      CommentText: map['CommentText']as String,
      videoId: map['videoId'] as String,
      commentId: map['commentId'] as String,
      display_name: map['display_name'] as String,
      profilePic: map['profilePic'] as String,
  );
}
}