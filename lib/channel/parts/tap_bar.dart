import 'package:flutter/material.dart';

class TapBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: const EdgeInsets.only(top: 14),
      child: TabBar(
        isScrollable: true,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.only(top: 12),
        tabs: const [
          Tab(text: "Home"),
          Tab(text: "Videos"),
          Tab(text: "Shorts"),
          Tab(text: "Community"),
          Tab(text: "Channel"),
          Tab(text: "Playlist"),
          Tab(text: "About"),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DefaultTabController(
      length: 7,  // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("TabBar Example"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TapBar(),  // Use the TapBar widget here
          ),
        ),
        body: const TabBarView(
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
    ),
  ));
}
