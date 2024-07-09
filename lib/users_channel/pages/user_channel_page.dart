// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/auth/pages/username_Pages.dart';
import 'package:newyoutube/auth/provider/channel_provider.dart';
import 'package:newyoutube/auth/provider/user_provider.dart';
import 'package:newyoutube/upload/long_video/video_resoistery.dart';
import '../../cores/cores/screens/Error_page.dart';
import '../../cores/cores/screens/loader.dart';
import '../../upload/long_video/parts/post.dart';

class UserChannelPage extends StatefulWidget {
  final String userId;
  const UserChannelPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(anyuserProvider(widget.userId)).when(
                    data: (user) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset("assets/images/flutter background.png"),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 38,
                                backgroundColor: Colors.grey,
                                backgroundImage: CachedNetworkImageProvider(
                                  user.profilePic,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.displayName,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      user.userName,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                              "${user.subscription.length} subscriptions  "),
                                          TextSpan(
                                              text: "${user.videos} videos"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 20, left: 8, right: 8),
                          child: CustomFlatButton(
                            text: "SUBSCRIBE",
                            onPressed: () {},
                            color: Colors.black,
                          ),
                        ),
                        user.videos == 0
                            ? const Center(
                          child: Text(
                            "No Video",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            : Padding(
                          padding:
                          const EdgeInsets.only(left: 10, top: 14),
                          child: Text(
                            "${user.displayName}'Videos ",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => const ErrorPage(),
                    loading: () =>  loader(),
                  );
                },
              ),

              // second consumer widget

              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(eachChannelVideoProvider(widget.userId)).when(
                    data: (videos) => Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.2,
                      ),
                      child:  SizedBox(
                        height: 80,
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            if (videos.isNotEmpty) {
                              return Post(video: videos[index]);
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    error: (error, stackTrace) => const ErrorPage(),
                    loading: () => loader(),
                  );
                },
              ),
            ],
          )),
    );
  }
}
