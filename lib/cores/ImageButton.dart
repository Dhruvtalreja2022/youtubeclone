import 'package:flutter/material.dart';
// Custom ImageButton
const Color softBlueGreyBackGround = Color(0xFFE0E0E0);
const Color kDeepGreyFont = Color(0xff606060);
class ImageButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final bool haveColor;

  const ImageButton({
    super.key,
    required this.image,
    required this.onPressed,
    required this.haveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:const EdgeInsets.only(left: 4, right: 4),
        child: Container(
          padding: const EdgeInsets.only(top: 7.6, bottom: 7.6),
          decoration: BoxDecoration(
             color: haveColor ? softBlueGreyBackGround : null,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
            )
          ),
          child: Image.asset("assets/icons/$image",
          height: 23,
          ),
        ),
      ),
    );
  }
}