import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/user_model.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
        
      );

      User? user = userCredential.user;

      await createAuthUser(user!.uid, userModel);
    } catch (e) {
      print('Error al registrar el usuario');
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

  Future<void> createAuthUser(String uid, UserModel user) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    await users.doc(uid).set({
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'birthday': user.birthday,
    });
    print('Se ha creado el usuario');
  } catch (e) {
    print('Error al crear el usuario');
  }

  // UserLocal user = UserLocal(
  //   name: _nameController.text,
  //   lastname: _lastnameController.text,
  //   age: int.parse(_ageController.text),
  //   gender: _genderController.text,
  //   email: _emailController.text,
  //   password: _passwordController.text,
  // );
  // controller.addUser(user);
}



}
