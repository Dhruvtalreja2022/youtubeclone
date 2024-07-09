import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'commonetsMode;.dart';

final commentsProvider = FutureProvider.family((ref, videoId) async {
  final commentsMap = await FirebaseFirestore.instance
      .collection("comments")
      .where("videoId", isEqualTo: videoId)
      .get();

  final List<commentmodel> comments = commentsMap.docs
      .map(
        (comment) => commentmodel.fromMap(
      comment.data(),
    ),
  )
      .toList();

  return comments;
});