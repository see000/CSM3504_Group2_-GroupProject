import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final UserCredential authResult = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    final User? user = authResult.user;
    return user;
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User? user = authResult.user;

    return user;
  }

  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    final User? user = authResult.user;
    return user;
  }

  Future<void> grantAccess(String email) async {
    final firestore = FirebaseFirestore.instance;
    final userRef =
        firestore.collection('users').where('email', isEqualTo: email);
    final snapShot = await userRef.get();

    if (snapShot.docs.length == 1) {
      snapShot.docs[0].reference.update({'isAuthorized': true});
    }
  }
}
