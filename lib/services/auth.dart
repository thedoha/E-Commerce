import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signUp(String mail, String pass) async {
    final authResult =
        await _auth.createUserWithEmailAndPassword(email: mail, password: pass);

    return authResult;
  }

  Future<AuthResult> signIn(String mail, String pass) async {
    final authResult =
        await _auth.signInWithEmailAndPassword(email: mail, password: pass);
    return authResult;
  }


Future<void>signOut()
  async{
    await _auth.signOut();
  }
}
