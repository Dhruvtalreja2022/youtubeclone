import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../account/account_page.dart';
import '../../cores/ImageButton.dart';
import '../../cores/cores/screens/loader.dart';
import '../../features/content/bottom_navigation.dart';
import '../../features/upload/upload_bottom_sheet.dart';
import '../../pages_list.dart';
import '../provider/user_provider.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/youtube.jpg",
                    height: 36,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 42,
                          width: 42,
                          child: ImageButton(
                            image: "cast.png",
                            onPressed: () {
                              // Add your onPressed functionality here
                            },
                            haveColor: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 38,
                          width: 38,
                          child: ImageButton(
                            image: "notification.png",
                            onPressed: () {},
                            haveColor: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 42,
                          width: 42,
                          child: ImageButton(
                            image: "search.png",
                            onPressed: () {
                              // Add your onPressed functionality here
                            },
                            haveColor: false,
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return ref.watch(currentUserProvider).when(
                            data: (currentUser) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context)=>  AccountPage(user: currentUser,)
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(currentUser.profilePic),
                                ),
                              ),
                            ),
                            error: (error, stackTrace) => const Placeholder(),
                            loading: () => loader(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: pages[currentIndex] )
            // Additional content for the column goes here
          ],
        ),
      ),
      bottomNavigationBar:  BottomNavigation(
        onPressed: (int index) {
        if(index!=2){
          currentIndex = index;
          setState((){

          });
        }
        else{
          showModalBottomSheet(context: context, builder: (context)=>  CreateBottomSheet(),
          );
        }
      },),
    );
  }
}
