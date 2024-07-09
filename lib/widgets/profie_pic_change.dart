import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicPickerDialog extends StatefulWidget {
  final Function(File? imageFile) onImageSelected;

  const ProfilePicPickerDialog({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  State<ProfilePicPickerDialog> createState() => _ProfilePicPickerDialogState();
}

class _ProfilePicPickerDialogState extends State<ProfilePicPickerDialog> {
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      widget.onImageSelected(File(pickedFile.path));
    } else {
      widget.onImageSelected(null);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Change Profile Picture"),
      content: const Text("Choose an option to change your profile picture."),
      actions: [
        TextButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          child: const Text("Gallery"),
        ),
        TextButton(
          onPressed: () => _pickImage(ImageSource.camera),
          child: const Text("Camera"),
        ),
      ],
    );
  }
}
