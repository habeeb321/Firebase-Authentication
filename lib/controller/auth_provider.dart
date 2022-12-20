import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth fb;
  AuthProvider(this.fb);

  Stream<User?> stream() => fb.authStateChanges();
}
