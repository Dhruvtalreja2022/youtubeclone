import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/Short_video/repository/ShortVideoRepositary.dart';
import 'package:newyoutube/auth/pages/username_Pages.dart';

class ShortVideoDetails extends ConsumerStatefulWidget{
  final File video;

  const ShortVideoDetails({super.key, required this.video});


  @override
  ConsumerState<ShortVideoDetails> createState() => _ShortVideoDetailsState();
}

class _ShortVideoDetailsState extends ConsumerState<ShortVideoDetails> {
  final captionController = TextEditingController();
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
   return   Scaffold(
     appBar: AppBar(
      title: const Text("video Details",style: TextStyle(
        color: Colors.white,
      ),),
       centerTitle: true,
       backgroundColor: Colors.deepOrange,
     ),
     body:  SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              TextField(
               controller: captionController,
               decoration: const InputDecoration(
                 hintText: "Write a caption",
                 border: OutlineInputBorder(
                   borderSide:  BorderSide(
                     color: Colors.blue
                   )
                 )
               ),
             ),
           const Spacer(),
           Padding(
             padding: const EdgeInsets.only(bottom: 30),
             child: CustomFlatButton(text: "PUBLISH", onPressed: () async{
                await ref.watch(shortVideoProvider).addShortVideoToDatbase(
                    caption: captionController.text,
                    shortVideo: widget.video.path,
                    datePublished: date,);
             }, color: Colors.green),
           )
           ],
         ),
       ),
     ),
   );
  }
}