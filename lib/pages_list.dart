import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:newyoutube/Search/pages/search_Secrean.dart';
import 'package:newyoutube/Short_video/short_video/short_video_page.dart';
import 'package:newyoutube/upload/long_video/long_video_screen.dart';
List pages=  [
  const SearchSecrean(),
  const LongVideoScreen(),
  const ShortVideoPage(),
  const  Center(
     child: Text("Upload"),
  ),
 const  Center(
    child: Text("subscriptions"),
  ),
  const Center(
    child: Text("You"),
  ),
  const Center(
    child: Text("Home"),
  ),
];