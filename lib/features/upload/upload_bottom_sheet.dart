import 'package:flutter/material.dart';
import '../../cores/ImageItem.dart';
import '../../cores/methods.dart';

class CreateBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFFFFF),
      child: Padding(
        padding: const EdgeInsets.only(left: 7, top: 12),
        child: SizedBox(
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12), // Added space between header and first item
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Upload a Short Video",
                  itemClicked: () async{
                    // Implement your functionality here
                    // await pickShortVideo(context);
                    // Uncomment and define this if required
                    await pickShortVideo(context);
                  },
                  imageName: "short-video.png",
                  haveColor: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Upload a Video",
                  itemClicked: () async {
                    await pickVideo(context);
                  },
                  imageName: "upload.png",
                  haveColor: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Go Live",
                  itemClicked: () {
                    // Implement your functionality here
                  },
                  imageName: "go-live.png",
                  haveColor: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Create a Post",
                  itemClicked: () {
                    // Implement your functionality here
                  },
                  imageName: "create-post.png",
                  haveColor: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
