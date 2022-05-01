import 'package:fire_drive/repository/auth_repo.dart';
import 'package:fire_drive/repository/storage_repo.dart';
import 'package:fire_drive/view_controller/user_controller.dart';
import 'package:mobx/mobx.dart';

import '../../locator.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

enum AuthStoreState { init, loading, loaded }

abstract class AuthStoreBase with Store {
  AuthStoreBase();

  final _userCtrl = locator.get<UserController>();

  @observable
  bool loginResponse = false;

  @observable
  ObservableFuture<bool>? _loginFuture;

  @computed
  AuthStoreState get state {
    if (_loginFuture == null) {
      return AuthStoreState.init;
    } else if ((_loginFuture != null &&
        _loginFuture!.status == FutureStatus.pending)) {
      return AuthStoreState.loading;
    } else {
      return AuthStoreState.loaded;
    }
  }

  @action
  Future<bool> login(String email, String password) async {
    _loginFuture = ObservableFuture(Future<bool>(() async => await _userCtrl
        .signInWithEmailAndPassword(email: email, password: password)));
    loginResponse = await _loginFuture!;
    return loginResponse;
  }

  @action
  Future<bool> signup(String email, String password) async {
    _loginFuture = ObservableFuture(Future<bool>(() async => await _userCtrl
        .signUpWithEmailAndPassword(email: email, password: password)));
    loginResponse = await _loginFuture!;
    return loginResponse;
  }

  @action
  Future<void> logout() async {
    _userCtrl.logout();
  }
}
