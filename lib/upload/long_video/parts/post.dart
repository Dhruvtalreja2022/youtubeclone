
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../auth/provider/user_provider.dart';
import '../../../cores/cores/screens/video_model.dart';
import '../../../model/user_model.dart';
import '../Video_model.dart';

class Post extends ConsumerWidget {
  final VideoModel video;
  const Post({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel = ref.watch(anyuserProvider(video.userId));

    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoScreen(
              video: video,
            ),
          ),
        );

        await FirebaseFirestore.instance.collection("videos").doc(video.videoId).update({
          "views": FieldValue.increment(1),
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: userModel.when(
          data: (user) => _buildPostWidget(context, user),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const Text('Error loading user data'),
        ),
      ),
    );
  }

  Widget _buildPostWidget(BuildContext context, UserModel user) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: video.thumbnail ?? '',
          width: 120,
          height: 90,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 5),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.profilePic ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                video.title ?? 'No title',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.12,
          ),
          child: Row(
            children: [
              Text(
                user.displayName ?? 'Anonymous',
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  video.views == null ? "No views" : "${video.views} views",
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Text(
                video.datePublished != null ? timeago.format(video.datePublished!) : '',
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
