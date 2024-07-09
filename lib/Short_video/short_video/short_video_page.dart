import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newyoutube/Short_video/content/short_video_model.dart';
import 'package:newyoutube/cores/cores/screens/Error_page.dart';
import 'package:newyoutube/cores/cores/screens/loader.dart';

import '../widgets/shortvideotile.dart';

class ShortVideoPage extends StatelessWidget{
  const ShortVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Padding(
          padding: EdgeInsets.only(top: 20),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("shorts").snapshots(),
          builder: (context,snapshot){
              if(snapshot.data==null||!snapshot.hasData){
                return ErrorPage();
              }
              else if (snapshot.connectionState==ConnectionState.waiting){
                return loader();
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    final shortVideoMaps = snapshot.data!.docs;
                    ShortVideoModel shortvideo = ShortVideoModel.fromMap(shortVideoMaps[index].data());
                    return Shortvideotile(shortvideomodel: shortvideo,);
                  });
          },),
        ),
      ),
    );
  }

}