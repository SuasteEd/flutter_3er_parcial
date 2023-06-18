import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    await Firebase.initializeApp();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  // Future<bool> login(String email, String password) async {
  //   await Firebase.initializeApp();
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //      User? user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //   }
  // }

  Future<void> logout() async {
    await Firebase.initializeApp();
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> resetPassword(String email) async {
    await Firebase.initializeApp();
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> changePassword(String password) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> changeEmail(String email) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> deleteAccount() async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> reauthenticate(String password) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!
          .reauthenticateWithCredential(EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: password,
      ));
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> updateProfile(String name) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> updatePhoto(String photo) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.updatePhotoURL(photo);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> updateEmail(String email) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> updatePassword(String password) async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> sendEmailVerification() async {
    await Firebase.initializeApp();
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }



}
