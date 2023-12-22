import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickedImage});
  final void Function(File pickedImage) onPickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  void _bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: const Text('Camera'),
              onPressed: _pickImageCamera,
              icon: const Icon(
                Icons.add_a_photo,
              ),
            ),
            TextButton.icon(
              label: const Text('Gallery'),
              onPressed: _pickImageGallery,
              icon: const Icon(
                Icons.photo,
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickImageCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    widget.onPickedImage(_pickedImage!);
  }

  void _pickImageGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    widget.onPickedImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        Positioned(
          bottom: -11,
          right: -11,
          child: IconButton(
            onPressed: _bottomSheet,
            icon: const Icon(Icons.add),
            iconSize: 35,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
