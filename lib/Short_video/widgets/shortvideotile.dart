import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../content/short_video_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class Shortvideotile extends StatefulWidget {
  final ShortVideoModel shortvideomodel;
  const Shortvideotile({super.key, required this.shortvideomodel});

  @override
  State<Shortvideotile> createState() => _ShortvideotileState();
}

class _ShortvideotileState extends State<Shortvideotile> {
  VideoPlayerController? shortVideoController;

  @override
  void initState() {
    super.initState();
    shortVideoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.shortvideomodel.shortVideo),
    )..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    shortVideoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: shortVideoController!.value.isInitialized ? Column(
        children: [
            GestureDetector(
              onTap: (){
                if(!shortVideoController!.value.isPlaying){
                  shortVideoController!.play();
                }
                else {
                  shortVideoController!.pause();
                }
              },
              child: AspectRatio(
                aspectRatio: 11 / 16,
                child: VideoPlayer(shortVideoController!),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 10, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.shortvideomodel.caption,style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:  20),),
                Text(timeago.format(widget.shortvideomodel.datePublished))

              ],
            ),
          )
        ],
      ):  Center(child: CircularProgressIndicator()),
    );
  }
}
