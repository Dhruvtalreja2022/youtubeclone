import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newyoutube/auth/pages/username_Pages.dart';
import 'package:newyoutube/model/user_model.dart';
import 'package:newyoutube/users_channel/pages/user_channel_page.dart';

class Searchchanneltile extends StatelessWidget{
  final UserModel userModel;
  const Searchchanneltile({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UserChannelPage(userId: userModel.userId)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                CircleAvatar(
              radius: 42.5,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(userModel.profilePic),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45,),
              child: Column(
                children: [
                   Text(userModel.displayName,style: const  TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                  ),),
                   Text(userModel.userName,style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),),
                   Text(userModel.subscription.toString(), style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey
                  ),),
                  const SizedBox(height: 8,),
                  SizedBox(
                    height: 40,
                      width: 140,
                    child: CustomFlatButton(
                        text: "Subscribe", onPressed: (){
                    }, color: Colors.black),
                  )
                ],
              ),
            ),
           const Spacer()
          ],
        ),
      ),
    );
  }

}