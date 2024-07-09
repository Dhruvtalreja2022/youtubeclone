import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_service.dart';
class loginPage extends ConsumerWidget{
  const loginPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("this is an title"),
      ),
      backgroundColor: Colors.grey,
      body:  SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(padding: const  EdgeInsets.only(
                top: 20,
                bottom: 25
              ),
              child: Image.asset(
            "assets/images/youtube-signin.jpg",
                height: 150,
          )
              ),
          const Text("Welcome to Youtube", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.blueGrey,
          ),),
              const Spacer(),
              Padding(
                 padding: const EdgeInsets.only(
                  bottom: 55
                ),
                child: GestureDetector(
                  onTap: () async {
                    await ref.read(authServiceProvider).signInWithGoogle();
                    
                  },
                  child: Image.asset(
                    "assets/images/signinwithgoogle.png",
                      height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}