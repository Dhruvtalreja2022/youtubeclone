import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../cores/ImageItem.dart";
class Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 35,
              child: ImageItem(
                itemText: "Your Channel",
                imageName: "your-channel.png",
                itemClicked: () {
                  // Add navigation or functionality here
                },
              ),
            ),
            const SizedBox(height: 6.5),
            SizedBox(
              height: 34,
              child: ImageItem(
                itemText: "Turn on Incognito",
                imageName: "your-channel.png", // Assuming correct icon name
                itemClicked: () {
                  // Add navigation or functionality here
                },
              ),
            ),
            const SizedBox(height: 6.5),
            SizedBox(
              height: 34,
              child: ImageItem(
                itemText: "Add Account",
                imageName: "add-account.png",
                itemClicked: () {
                  // Add navigation or functionality here
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Divider(
                color: CupertinoColors.extraLightBackgroundGray,
                thickness: 1.2, // Enhanced thickness for better visibility
              ),
            ),
            const SizedBox(height: 6.5),
            SizedBox(
              height: 31,
              child: ImageItem(
                itemText: "Time watched",
                imageName: "time-watched.png",
                itemClicked: () {
                  // Add navigation or functionality here
                },
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              height: 31,
              child: ImageItem(
                imageName: "your-data.png",
                itemClicked: () {
                  // Add navigation or functionality here
                },
                itemText: "Your data in Youtube",
                haveColor: false,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 1.2, // Enhanced thickness for better visibility
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 33,
              child: ImageItem(
                imageName: "settings.png",
                itemClicked: () {
                  // Add navigation or functionality here
                },
                itemText: "Settings",
                haveColor: false,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 35,
              child: ImageItem(
                imageName: "help.png",
                itemClicked: () {
                  // Add navigation or functionality here
                },
                itemText: "Help & feedback",
                haveColor: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
