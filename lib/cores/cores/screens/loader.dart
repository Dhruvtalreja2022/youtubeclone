import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class loader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
      )
    );
  }
}