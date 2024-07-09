import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../auth/pages/my_channel_screen.dart';
class videoExtra extends StatelessWidget{
  final String text;
  final IconData iconData;
  const videoExtra({super.key, required this.text, required this.iconData});
  @override
  Widget build(BuildContext context) {
   return Container(
     padding: const  EdgeInsets.symmetric(
       horizontal: 12,
       vertical: 3,
     ),
     decoration: const BoxDecoration(
       color: softBlueGreyBackGround,
       borderRadius: BorderRadius.all(
         Radius.circular(25)
       )
     ),
     child: Row(
       children: [
         Icon(iconData),
         const SizedBox(width: 6),
         Text(text),
       ],
     ),
   );
  }
  
}