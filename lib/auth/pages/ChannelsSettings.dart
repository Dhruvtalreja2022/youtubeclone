import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../channel/repository/edit_fields.dart';
import '../../cores/cores/screens/loader.dart';
import '../../widgets/edit_setting_dialogue.dart';
import '../../widgets/profie_pic_change.dart';
import '../../widgets/setting_field_items.dart';
import '../provider/user_provider.dart';

class ChannelsSettings extends ConsumerStatefulWidget {
  const ChannelsSettings({super.key});

  @override
  ConsumerState<ChannelsSettings> createState() => _ChannelsSettingsState();
}

class _ChannelsSettingsState extends ConsumerState<ChannelsSettings> {
  bool isSwitched = false;

  void _changeProfilePicture(File? imageFile) {
    if (imageFile != null) {
      // Assuming editSettingsProvider has a method to handle profile picture update
      ref.watch(editSettingsProvider).editProfilePicture(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
      data: (user) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/flutter background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 180,
                      top: 60,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                          user.profilePic,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 10,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ProfilePicPickerDialog(
                              onImageSelected: _changeProfilePicture,
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/icons/camera.png",
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SettingFieldItems(
                  identifier: "DisplayName",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SettingsDialog(
                        identifier: 'your new DisplayName',
                        onSave: (name) {
                          ref.watch(editSettingsProvider).editDisplayName(name);
                        },
                      ),
                    );
                  },
                  value: user.displayName, // Assuming `user` has a `displayName` field
                ),
                SettingFieldItems(
                  identifier: "Handle",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SettingsDialog(
                        identifier: 'your new UserName',
                        onSave: (username) {
                          ref.watch(editSettingsProvider).editUserName(username);
                        },
                      ),
                    );
                  },
                  value: user.userName, // Assuming `user` has a `userName` field
                ),
                SettingFieldItems(
                  identifier: "Description",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SettingsDialog(
                        identifier: 'your new description',
                        onSave: (description) {
                          ref.watch(editSettingsProvider).editDescription(description);
                        },
                      ),
                    );
                  },
                  value: user.description, // Assuming `user` has a `description` field
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Row(
                    children: [
                      const Text("Keep all the subscribers private"),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Changes made on your names and profile picture will only be visible to the Google customer support",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) =>  loader(),
      loading: () =>  loader(),
    );
  }
}
