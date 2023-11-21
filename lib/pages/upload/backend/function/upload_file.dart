import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<void> uploadFile(PlatformFile? mediaFile) async {
  // Generate a unique filename or use your own logic
  final fileName =
      'tap2x_${DateTime.now().millisecondsSinceEpoch}.${mediaFile!.path!.split('.').last}';

  // Combine the custom prefix and filename to create a custom path
  final path = 'displayPictures/$fileName';

  // Get the file from the device
  final file = File(mediaFile.path!);

  // Create a reference with the custom path
  final ref = FirebaseStorage.instance.ref().child(path);

  // Upload the file
  final uploadTask = ref.putFile(file);

  // Wait for the upload to complete
  final snapshot = await uploadTask.whenComplete(() {});

  // Get the download URL
  final urlDownload = await snapshot.ref.getDownloadURL();

  // Print the download URL
  debugPrint('Download URL: $urlDownload');
}
