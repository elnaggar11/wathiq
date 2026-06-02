import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:path_provider/path_provider.dart';

Future<File?> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

// Future<File?> pickFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'], // Add extensions you want
//   );

//   if (result != null) {
//     // Get the file path
//     String? filePath = result.files.single.path;
//     if (filePath != null) {
//       return File(filePath);
//     }
//   }
//   return null;
// }

Future<File?> pickFile() async {
  try {
    // Launch file picker
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      withData: false, // avoid loading bytes into memory
    );

    if (result == null) {
      print('User canceled file picker.');
      return null;
    }

    final PlatformFile picked = result.files.single;
    String? rawPath = picked.path;

    // If path is null or file doesn't exist, fallback to writing bytes to temp
    File file;
    if (rawPath != null && await File(rawPath).exists()) {
      file = File(rawPath);
    } else if (picked.bytes != null) {
      final tempDir = await getTemporaryDirectory();
      final fileName = picked.name;
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(picked.bytes!);
      file = tempFile;
    } else {
      throw Exception('Unable to retrieve file from picker.');
    }

    // Copy to app documents directory for stable access (optional)
    final appDocDir = await getApplicationDocumentsDirectory();
    final destPath = '${appDocDir.path}/${basename(file.path)}';
    final preparedFile = await file.copy(destPath);
    print('Prepared file at: ${preparedFile.path}');

    return preparedFile;
  } catch (e, stack) {
    print('Error in pickAndPrepareFile: $e');
    print(stack);
    return null;
  }
}
