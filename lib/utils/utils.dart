import 'dart:io';

import 'package:flutter/material.dart';
import 'package:friendfinder/utils/showSnackBar.dart';
import 'package:image_picker/image_picker.dart';

// pickImage(ImageSource source) async {
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _file = (await _imagePicker.pickImage(source: source)) as File?;
//   if (_file != null) {
//     return await _file.readAsBytes();
//   }
//   print('No Image selected');
// }
Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar( context,  e.toString());
  }
  return image;
}