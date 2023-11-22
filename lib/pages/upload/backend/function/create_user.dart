import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

Future<void> uploadFileAndCreateUser(Users user, PlatformFile mediaFile) async {
  try {
    // Generate a unique filename or use your own logic
    final fileName =
        'tap2x_${DateTime.now().millisecondsSinceEpoch}.${mediaFile.path!.split('.').last}';

    // Combine the custom prefix and filename to create a custom path
    final path = 'displayPictures/$fileName';

    // Get the file from the device
    final file = File(mediaFile.path!);

    // Create a reference with the custom path
    final ref = FirebaseStorage.instance.ref().child(path);

    final metadata =
        SettableMetadata(contentType: 'images/${mediaFile.extension}');
    // Upload the file
    final uploadTask = ref.putFile(file, metadata);

    // Wait for the upload to complete
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL
    final urlDownload = await snapshot.ref.getDownloadURL();

    // Assign the download URL to the user object
    user.dpUrl = urlDownload;

    // Reference to the document in the 'users' collection with a unique ID
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    user.id = docUser.id; // add document id as user id

    // Assign the download URL to the user object
    user.dpUrl = urlDownload;

    // Convert User object to a Map for Firestore storage
    final json = user.toJson();

    // Set the data in the Firestore document
    await docUser.set(json);

    debugPrint('File uploaded and user document created successfully.');
  } catch (error) {
    // Handle errors, e.g., print the error message
    debugPrint('Error uploading file and creating user document: $error');
  }
}

Future<void> updateFileAndUserData(Users user, PlatformFile? mediaFile) async {
  try {
    // Generate a unique filename or use your own logic
    if (mediaFile!.path!.isNotEmpty) {
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
    }
    // final fileName =
    //     'tap2x_${DateTime.now().millisecondsSinceEpoch}.${mediaFile!.path!.split('.').last}';

    // // Combine the custom prefix and filename to create a custom path
    // final path = 'displayPictures/$fileName';

    // // Get the file from the device
    // final file = File(mediaFile.path!);

    // // Create a reference with the custom path
    // final ref = FirebaseStorage.instance.ref().child(path);

    // // Upload the file
    // final uploadTask = ref.putFile(file);

    // // Wait for the upload to complete
    // final snapshot = await uploadTask.whenComplete(() {});

    // // Get the download URL
    // final urlDownload = await snapshot.ref.getDownloadURL();

    // Assign the updated download URL to the user object
    // !user.dpUrl = urlDownload;

    // Reference to the document in the 'users' collection with the specified ID
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.id);

    // Assign the updated download URL to the user object
    // !user.dpUrl = urlDownload;

    // Convert User object to a Map for Firestore storage
    final json = user.toJson();

    // Update the data in the Firestore document
    await docUser.update(json);

    debugPrint('File updated and user document updated successfully.');
  } catch (error) {
    // Handle errors, e.g., print the error message
    debugPrint('Error updating file and user document: $error');
  }
}
