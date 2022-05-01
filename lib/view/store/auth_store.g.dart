// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on AuthStoreBase, Store {
  Computed<AuthStoreState>? _$stateComputed;

  @override
  AuthStoreState get state =>
      (_$stateComputed ??= Computed<AuthStoreState>(() => super.state,
              name: 'AuthStoreBase.state'))
          .value;

  late final _$loginResponseAtom =
      Atom(name: 'AuthStoreBase.loginResponse', context: context);

  @override
  bool get loginResponse {
    _$loginResponseAtom.reportRead();
    return super.loginResponse;
  }

  @override
  set loginResponse(bool value) {
    _$loginResponseAtom.reportWrite(value, super.loginResponse, () {
      super.loginResponse = value;
    });
  }

  late final _$_loginFutureAtom =
      Atom(name: 'AuthStoreBase._loginFuture', context: context);

  @override
  ObservableFuture<bool>? get _loginFuture {
    _$_loginFutureAtom.reportRead();
    return super._loginFuture;
  }

  @override
  set _loginFuture(ObservableFuture<bool>? value) {
    _$_loginFutureAtom.reportWrite(value, super._loginFuture, () {
      super._loginFuture = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthStoreBase.login', context: context);

  @override
  Future<bool> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$signupAsyncAction =
      AsyncAction('AuthStoreBase.signup', context: context);

  @override
  Future<bool> signup(String email, String password) {
    return _$signupAsyncAction.run(() => super.signup(email, password));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
loginResponse: ${loginResponse},
state: ${state}
    ''';
  }
}
