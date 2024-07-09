import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newyoutube/upload/long_video/parts/post.dart';
import '../../cores/cores/screens/Error_page.dart';
import '../../cores/cores/screens/loader.dart';
import 'Video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("videos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  loader();
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return  ErrorPage();
          }

          final videoDocs = snapshot.data!.docs;
          if (videoDocs.isEmpty) {
            return const Center(child: Text('No videos found'));
          }

          // Parse video documents into VideoModel objects
          final videos = videoDocs.map((doc) {
            try {
              return VideoModel.fromMap(doc.data());
            } catch (e) {
              print('Error parsing video: $e');
              return null; // Handle potential parsing errors
            }
          }).whereType<VideoModel>().toList();

          if (videos.isEmpty) {
            return const Center(child: Text('No valid videos found'));
          }

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              // Check if videos[index] is not null before passing to Post widget
              if (videos[index] != null) {
                return Post(video: videos[index]!);
              } else {
                // Handle the case where videos[index] is null (optional)
                return Container(); // Replace with appropriate UI or widget
              }
            },
          );
        },
      ),
    );
  }
}
