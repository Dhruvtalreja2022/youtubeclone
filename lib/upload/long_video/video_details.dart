import 'dart:io';  // Correct import
// Removed invalid import 'dart:ui_web';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/upload/long_video/video_resoistery.dart';
import 'package:uuid/uuid.dart';

import '../../cores/methods.dart';

class VideoDetails extends ConsumerStatefulWidget {
  final File?  video;  // Define type for video

  const VideoDetails(this.video, {super.key,});

  @override
  ConsumerState<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends ConsumerState<VideoDetails> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isthumbnail = false;
  String ramdomNumber = const Uuid().v4();
  File? image;
  String VideoId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter the title",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Enter the title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Enter your description",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                maxLines: 6,
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter your description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Add space before the container
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final pickedImage = await pickImage();
                      if (pickedImage != null) {
                        setState(() {
                          image = pickedImage;
                          isthumbnail = true;
                        });
                      }
                    },
                    child: const Text(
                      "Select thumbnail",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              if (isthumbnail && image != null)
                Image.file(
                  image!,
                  height: 160,
                  width: 400,
                )
              else if (isthumbnail && image == null)
                const Text(
                  "Failed to load image",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              if (isthumbnail)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(11),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (image != null) {
                          String thumbnail = await putFileInStorage(image, ramdomNumber, "image");
                          String videourl = await putFileInStorage(widget.video, ramdomNumber, "video") ;
                          ref.watch(videoProvider).uploadVideoFirestore(
                            videoUrl: widget.video!.path,
                            thumbnail: thumbnail,
                            title: titleController.text,
                            videoId: VideoId,
                            datePublished: DateTime.now(),
                            userId:
                            FirebaseAuth.instance.currentUser!.uid,
                          );
                        }
                      },
                      child: const Text(
                        "Finish",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
