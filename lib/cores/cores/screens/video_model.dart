import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../auth/pages/username_Pages.dart';
import '../../../auth/provider/user_provider.dart';
import '../../../comments/Comment_Sheet.dart';
import '../../../model/user_model.dart';
import '../../../upload/long_video/Video_model.dart';
import '../../../upload/long_video/parts/post.dart';
import '../../../upload/long_video/parts/video_extra_button.dart';
import 'Error_page.dart';
import 'loader.dart';
class VideoScreen extends ConsumerStatefulWidget {
  final VideoModel video;
  const VideoScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}
class _VideoScreenState extends ConsumerState<VideoScreen> {
  VideoPlayerController? _controller;
  bool isShowIcon = false;
  bool isPlaying = false;
  bool isLiked = false;
  bool isDisliked = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
        isPlaying = true;
      });
  }

  void toggleVideoPlayer() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();
      isPlaying = false;
    } else {
      _controller!.play();
      isPlaying = true;
    }
    setState(() {});
  }

  void goBackward() {
    Duration position = _controller!.value.position;
    position -= const Duration(seconds: 10);
    _controller!.seekTo(position);
  }

  void goForward() {
    Duration position = _controller!.value.position;
    position += const Duration(seconds: 10);
    _controller!.seekTo(position);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        // Handle like logic here, e.g., increment likes count
      } else {
        // Handle unlike logic here, e.g., decrement likes count
      }
    });
  }

  void toggleDislike() {
    setState(() {
      isDisliked = !isDisliked;
      if (isDisliked) {
        // Handle dislike logic here, e.g., increment dislikes count
      } else {
        // Handle undislike logic here, e.g., decrement dislikes count
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user = ref.watch(anyuserProvider(widget.video.userId));
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _controller!.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio * 2,
              child: GestureDetector(
                onTap: () {
                  isShowIcon = !isShowIcon;
                  setState(() {});
                },
                child: Stack(
                  children: [
                    VideoPlayer(_controller!),
                    Positioned(
                      left: (screenSize.width / 2)-30,
                      bottom: (screenSize.width / 2)-45,
                      child: GestureDetector(
                        onTap: toggleVideoPlayer,
                        child: SizedBox(
                          height: 50,
                          child: Image.asset(
                            isPlaying
                                ? "assets/images/pause.png"
                                : "assets/images/play.png",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 60,
                      bottom: (screenSize.width / 2)-45,
                      child: GestureDetector(
                        onTap: goForward,
                        child: SizedBox(
                          height: 50,
                          child: Image.asset(
                            "assets/images/go ahead final.png",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: (screenSize.width / 2)-45,
                      child: GestureDetector(
                        onTap: goBackward,
                        child: SizedBox(
                          height: 50,
                          child: Image.asset(
                            "assets/images/go_back_final.png",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 7.5,
                        child: VideoProgressIndicator(
                          _controller!,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.red,
                            bufferedColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Padding(
              padding: EdgeInsets.only(top: 100),
              child: loader(),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 4),
                    child: Text(
                      widget.video.title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 5),
                          child: Text(
                            widget.video.views == 0 ? "No views" : "${widget.video.views} views",
                            style: const TextStyle(
                              fontSize: 13.4,
                              color: Color(0xff5F5F5F),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: Text(
                            "5 mins ago",
                            style: TextStyle(
                              fontSize: 13.4,
                              color: Color(0xff5F5F5F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 9, top: 9),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey,
                          backgroundImage: CachedNetworkImageProvider(user.value?.profilePic ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Text(
                            user.value?.displayName ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6, left: 6),
                          child: Text(
                            user.value?.subscription.isEmpty ?? true
                                ? "No subscriptions"
                                : "${user.value?.subscription.length} subscriptions",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 35,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 6),
                            child: CustomFlatButton(
                              text: "Subscribe",
                              onPressed: () {},
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.5, right: 9, left: 9),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked = true;
                                        isDisliked = false;
                                      });
                                    },
                                    child: Icon(
                                      isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                                      size: 15.5,
                                    ),
                                  ),
                                  const SizedBox(width: 19),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDisliked = true;
                                        isLiked = false;
                                      });
                                    },
                                    child: Icon(
                                      isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                                      size: 15.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: videoExtra(
                              text: "Share",
                              iconData: Icons.share_outlined,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: videoExtra(
                              text: "Remix",
                              iconData: Icons.video_camera_front_outlined,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: videoExtra(
                              text: "Download",
                              iconData: Icons.download_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Comment Box making
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,
                    horizontal: 12),
                    child: GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context)=> CommentSheet(
                              video: widget.video
                              ,),);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          color: Color(0xFFBDBDBD),
                        ),
                        height: 60,
                        width: 200,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("videos")
                        .where("videoId", isNotEqualTo: widget.video.videoId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const ErrorPage();
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return loader();
                      }
                      final videoDocs = snapshot.data!.docs;
                      final videos = videoDocs.map((e) => VideoModel.fromMap(e.data())).toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return Post(video: videos[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
