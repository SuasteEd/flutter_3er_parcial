import 'package:examen_3er_parcial/repositories/sign_up_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'inputs/sign_up.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _firebaseAuth;

  SignUpRepositoryImpl(this._firebaseAuth);

  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);
      await userCredential.user!
          .updateDisplayName('${data.name} ${data.lastname}');
      return SignUpResponse(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(error: e.message);
    }
  }
}
