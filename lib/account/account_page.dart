
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newyoutube/auth/pages/my_channel_screen.dart';

import '../model/user_model.dart';
import 'items.dart';


class AccountPage extends StatelessWidget {
  final UserModel user;

  const AccountPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blueGrey,
                backgroundImage: CachedNetworkImageProvider(user.profilePic),
              ),
            ),
            // Profile info
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyChannelScreen()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        user.displayName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "@${user.userName}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const Text("manage your Google Account",style: TextStyle(
                      color: Colors.blue,
                      fontWeight:  FontWeight.w700,
                      fontSize: 20,
                    ),)
                  ],
                ),
              ),
            ),
            // Item list
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Items(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: const Text("Privacy Policy . Terms of Serives",style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
