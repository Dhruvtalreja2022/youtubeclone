import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'commonetsMode;.dart';

class commenttile extends StatelessWidget{
  final commentmodel comment;
  const commenttile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: [
            Row(
            children: [
              CircleAvatar(
                radius: 15,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(comment.profilePic),
              ),
              Text(comment.display_name,style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),),
              const Text("A moment Ago"),
              const Spacer(),
              const Icon(Icons.more_vert_sharp)
            ],
          ),
          Text(comment.CommentText)
        ],
      ),
    );
  }
}