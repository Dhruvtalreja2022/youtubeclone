import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/user_data_service.dart';

final formKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayname;
  final String profilePic;
  final String email;

  const UsernamePage({
    super.key,
    required this.displayname,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Username(
        displayname: widget.displayname,
        profilePic: widget.profilePic,
        email: widget.email,
      ),
    );
  }
}

// Custom Flat Button
class CustomFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CustomFlatButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class Username extends ConsumerStatefulWidget {
  final String displayname;
  final String profilePic;
  final String email;

  const Username({
    super.key,
    required this.displayname,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<Username> createState() => _UsernameState();
}

class _UsernameState extends ConsumerState<Username> {
  final TextEditingController usernameController = TextEditingController();
  bool isUsernameValid = true;

  void validateUsername(String username) async {
    if (username.isEmpty) {
      setState(() {
        isUsernameValid = false;
      });
      return;
    }

    final usermap = await FirebaseFirestore.instance.collection("user").get();
    final users = usermap.docs.map((user) => user.data()['username']).toList();

    setState(() {
      isUsernameValid = !users.contains(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 26,
            horizontal: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter the Username",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    onChanged: validateUsername,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (username) {
                      if (!isUsernameValid) {
                        return 'Username is already taken';
                      }
                      if (username == null || username.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    controller: usernameController,
                    decoration: InputDecoration(
                      suffixIcon: isUsernameValid
                          ? const Icon(Icons.verified_user_rounded)
                          : const Icon(Icons.error_outline),
                      suffixIconColor:
                      isUsernameValid ? Colors.green : Colors.red,
                      hintText: "Enter your name",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                const EdgeInsets.only(bottom: 30.0, left: 8, right: 8),
                child: CustomFlatButton(
                  text: "CONTINUE",
                  onPressed: () async {
                    if (formKey.currentState?.validate() == true) {
                      await ref.read(userDataServiceProvider).addUserDataToFirestore(
                        displayName: widget.displayname,
                        userName: usernameController.text,
                        email: widget.email,
                        profilePic: widget.profilePic,
                        subscription: [],
                        videos: 0,
                        userId: '', // Set the userId when available
                        description: ' ', // Default description
                        type: '', // Default type
                      );
                    }
                  },
                  color: isUsernameValid
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
