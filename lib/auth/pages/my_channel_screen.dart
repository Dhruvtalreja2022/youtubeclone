import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../channel/parts/tap_bar.dart';
import '../../channel/parts/toHeader.dart';
import '../../cores/ImageButton.dart';
import '../../cores/cores/screens/loader.dart';
import '../provider/user_provider.dart';

// Define the color variable
const Color softBlueGreyBackGround = Color(0xFFE0E0E0); // Example color, adjust as needed

class MyChannelScreen extends ConsumerWidget {
  const MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
      data: (currentuser) => DefaultTabController(
        length: 7,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  TopHeader(user: currentuser),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "More about this channel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 8),
                        Container(
                          decoration: const BoxDecoration(
                            color: softBlueGreyBackGround,
                            borderRadius: BorderRadius.all(
                              Radius.circular(9),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Manage videos",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 48,
                          child: ImageButton(
                            image: "pen.png",
                            onPressed: () {},
                            haveColor: true,
                          ),
                        ),
                        const SizedBox(width: 8), // Space between buttons
                        SizedBox(
                          width: 48,
                          child: ImageButton(
                            image: "time-watched.png",
                            onPressed: () {},
                            haveColor: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TapBar(), // Creating the TabBar
                  const Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text("Home")),
                        Center(child: Text("Videos")),
                        Center(child: Text("Shorts")),
                        Center(child: Text("Community")),
                        Center(child: Text("Channel")),
                        Center(child: Text("Playlist")),
                        Center(child: Text("About")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => loader() ,// Ensure `Loader` returns a Widget
      loading: () => loader(),
    );
  }
}
