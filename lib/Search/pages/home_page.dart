import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/auth/provider/channel_provider.dart';

import '../../cores/cores/screens/Error_page.dart';
import '../../cores/cores/screens/loader.dart';
import '../../upload/long_video/parts/post.dart';
class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:Consumer(
          builder: (context, ref, child) {
            return ref.watch(eachChannelVideoProvider(FirebaseAuth.instance.currentUser!.uid)).when(
              data: (videos) => Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.2,
                ),
                child: videos.length==0 ? Text("No videos try to upload one"): SizedBox(
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
      );
  }

}