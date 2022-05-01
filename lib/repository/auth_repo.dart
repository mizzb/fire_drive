import 'package:fire_drive/model/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthRepo();

  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    var authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }

    return UserModel(authResult.user!.uid,
        displayName: authResult.user!.displayName);
  }

  Future<UserModel> signUpEmailAndPassword(
      {required String email, required String password}) async {
    var authResult;
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }

    return UserModel(authResult.user!.uid,
        displayName: authResult.user!.displayName);
  }

  Future<UserModel?> getUser() async {
    User? firebaseUser;
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      return UserModel(firebaseUser.uid, displayName: firebaseUser.displayName);
    } else {
      return null;
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    var user = _auth.currentUser;

    user?.updateDisplayName(
      displayName = displayName,
    );
  }

  Future<bool> validatePassword(String password) async {
    var firebaseUser = _auth.currentUser;
    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email!, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = _auth.currentUser;
    firebaseUser!.updatePassword(password);
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
