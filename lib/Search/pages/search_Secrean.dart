import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newyoutube/Search/provider/Search_window_provider.dart';
import 'package:newyoutube/Search/widgets/SearchChannelTile.dart';
import 'package:newyoutube/account/items.dart';
import 'package:newyoutube/cores/custom_button.dart';
import 'package:newyoutube/model/user_model.dart';
import 'package:newyoutube/upload/long_video/Video_model.dart';
import 'package:newyoutube/upload/long_video/parts/post.dart';

class SearchSecrean extends ConsumerStatefulWidget{
  const SearchSecrean({super.key});

  @override

  ConsumerState<SearchSecrean> createState() => _SearchSecreanState();
}

class _SearchSecreanState extends ConsumerState<SearchSecrean> {
  List foundItems =[];
  List Result = [];
  Future<void>filterList(String keywordSelected) async{
    List<UserModel> users = await ref.watch(allchannelProvider);
    final List<VideoModel> videos = await ref.watch(allusersProvider);

    final foundVideos = videos.where((videos){
      return videos.title.toString().toLowerCase().contains(keywordSelected);
    }).toList();

    final foundChannels = users.where((user){
      return user.displayName.toString().toLowerCase().contains(keywordSelected);
    }).toList();

    Result.addAll(foundChannels);
    Result.addAll(foundVideos);
    setState(() {
      Result.shuffle();
      foundItems = Result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){ }, icon: const Icon(Icons.arrow_back_ios_new_rounded)),

                    SizedBox(
                      width: 280,
                      height: 40,
                      child: TextFormField(
                        onChanged: (value) async{
                          await filterList(value);
                        },
                        decoration: const InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 60,
                      child: CustomButton(iconData: Icons.search_sharp,
                          onTap: (){},
                          haveColor: true),
                    )
                  ],
                ),
                Expanded(child: ListView.builder(
                    itemCount: foundItems.length,
                    itemBuilder: (count,index){
                      List<Widget> ItemsWidget =[];
                      final selectedItems = foundItems[index];

                      if(selectedItems.type == 'videos'){
                        ItemsWidget.add(Post(video: selectedItems));
                      }
                      if (selectedItems.type == "users"){
                        ItemsWidget.add( Searchchanneltile(
                          userModel: selectedItems,
                        ));
                      }
                      else {
                        return const SizedBox(

                        );
                      }
                      return ItemsWidget[0];
                    }))
              ],
            )
        )));

  }
}