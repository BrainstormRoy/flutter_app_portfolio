import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

Future createUser(User user) async {
  try {
    // Reference to the document in the 'users' collection with a unique ID
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    user.id = docUser.id; // add document id as user id

    // Convert User object to a Map for Firestore storage
    final json = user.toJson();

    // Set the data in the Firestore document
    await docUser.set(json);

    debugPrint('User document created successfully.');
  } catch (error) {
    // Handle errors, e.g., print the error message
    debugPrint('Error creating user document: $error');
  }
}
