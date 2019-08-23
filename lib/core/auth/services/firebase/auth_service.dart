import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_auth_base/flutter_auth_base.dart';
import 'package:ezsale/core/auth/services/firebase/user.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService() : auth = fb.FirebaseAuth.instance {
    auth.onAuthStateChanged.listen((user) {
      _authChangeNotifier.value = new FirebaseUser(user);
      return true;
    });
  }

  final fb.FirebaseAuth auth;

  final ValueNotifier<AuthUser> _authChangeNotifier =
    new ValueNotifier<AuthUser>(new FirebaseUser(null));

  @override
  ValueNotifier<AuthUser> get authUserChanged => _authChangeNotifier;

  @override
  List<AuthProvider> authProviders = new List<AuthProvider>();

  @override
  List<LinkableProvider> linkProviders = new List<LinkableProvider>();

  AuthOptions _options = new AuthOptions(
    canVerifyAccount: true,
    canChangePassword: false,
    canChangeEmail: false,
    canLinkAccounts: true,
    canChangeDisplayName: true,
    canSendForgotEmail: true,
    canDeleteAccount: false,
  );

  @override
  AuthOptions get options => _options;

  @override
  PhotoUrlProvider postAuthPhotoProvider;

  @override
  PhotoUrlProvider preAuthPhotoProvider;

  @override
  Future<AuthUser> currentUser() async {
    var user = await auth.currentUser();

    return new FirebaseUser(user);
  }

  @override
  Future<String> currentUserToken({bool refresh = false}) async {
    var user = await auth.currentUser();

    if (user == null) {
      return null;
    }

    var token = await user.getIdToken(refresh: refresh);

    return token.toString();
  }

  @override
  Future<AuthUser> refreshUser() async {
    var user = await auth.currentUser();
    await user.reload();
    user = await auth.currentUser();

    return _authChangeNotifier.value = new FirebaseUser(user);
  }

  @override
  Future<AuthUser> setUserDisplayName(String name) async {
    var user = await auth.currentUser();
    var userUpdateInfo = new fb.UserUpdateInfo();
    userUpdateInfo.displayName = name;

    await user.updateProfile(userUpdateInfo);

    var newUser = await auth.currentUser();
    return authUserChanged.value = new FirebaseUser(newUser);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();

    var user = await auth.currentUser();

    return _authChangeNotifier.value = new FirebaseUser(user);
  }

  @override
  Future<void> closeAccount(Map<String, String> reauthenticationArgs) {
    throw new UnimplementedError('Closing account is not avalilable');
  }
}
