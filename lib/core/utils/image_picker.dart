import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._internal();
  static final _instance = ImagePickerHelper._internal();
  factory ImagePickerHelper() => _instance;

  Future<XFile?> pickImageFromGallery() async {
    try {
      log('picking image ga');
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      return image;
    } catch (e) {
      log('error picking image $e');
    }
    return null;
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      log('picking image ca');
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      return image;
    } catch (e) {
      log('error picking image $e');
    }
    return null;
  }
}
