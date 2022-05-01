import 'package:fire_drive/model/user_modal.dart';
import 'package:fire_drive/repository/auth_repo.dart';
import 'package:fire_drive/repository/storage_repo.dart';

import '../locator.dart';

class UserController {
  UserModel? _currentUser;
  final AuthRepo _authRepo = locator.get<AuthRepo>();
  final StorageRepo _storageRepo = locator.get<StorageRepo>();
  late Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel?> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel? get currentUser => _currentUser;

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);
    if (_currentUser != null) {
      return true;
    }
    return false;
  }

  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    _currentUser = await _authRepo.signUpEmailAndPassword(
        email: email, password: password);

    if (_currentUser != null) {
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    _authRepo.signOut();
  }
}
