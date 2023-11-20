import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Future<bool> isLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

  // Add other authentication methods if needed

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

/* 
FirebaseAuth auth = FirebaseAuth.instance;
User? user = auth.currentUser;
 */