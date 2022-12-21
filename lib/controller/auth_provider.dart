import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth fb;
  AuthProvider(this.fb);
  bool isLoading = false;

  Stream<User?> stream() => fb.authStateChanges();
  bool get loading => isLoading;

  Future<void> signOut() async {
    await fb.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await fb.signInWithEmailAndPassword(email: email, password: password);
      fb.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await fb.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
}
