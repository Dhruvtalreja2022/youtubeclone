import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/provider/user_provider.dart';
import '../cores/cores/screens/Error_page.dart';
import '../cores/cores/screens/loader.dart';
import '../upload/long_video/Video_model.dart';
import 'commentRespoistery.dart';
import 'comment_tile.dart';
import 'commonetsMode;.dart';
class CommentSheet extends ConsumerStatefulWidget {
  final VideoModel video;
  const CommentSheet({required this.video});

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).whenData((user) => user);

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6, // Increased height for better usability
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(Icons.comment_outlined),
                        SizedBox(width: 20),
                        Text(
                          "Comments...",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "Remember to keep the comments respectful and follow our community guidelines.",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("comments")
                  .where("videoID", isEqualTo: widget.video.videoId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  loader();
                }
                else if (snapshot.data==null || !snapshot.hasData) {
                  return const ErrorPage();
                }
                final commentsMaps = snapshot.data!.docs;
                final List<commentmodel> comments = commentsMaps
                    .map((comment) => commentmodel.fromMap(comment.data() as Map<String,dynamic>))
                    .toList();

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return commenttile(comment: comments[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 8, left: 8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Add a Comment",
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await ref.watch(commentProvider).upload_comment(
                      CommentText: commentController.text,
                      videoId: widget.video.videoId,
                      display_name: user.value!.displayName,
                      profilePic: user.value!.profilePic,
                    );
                  },
                  icon: const Icon(
                    Icons.send_sharp,
                    color: Colors.black,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
