import 'dart:async';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_auth_base/flutter_auth_base.dart';
import 'package:ezsale/core/auth/services/firebase/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:ezsale/core/auth/services/firebase/auth_service.dart';
import 'package:ezsale/core/auth/services/firebase/user_acceptance_callback.dart';

class FirebaseFacebookProvider extends AuthProvider implements LinkableProvider {
  FirebaseFacebookProvider(
    {
      @required FirebaseAuthService service,
      UserAcceptanceCallback hasUserAcceptedTerms
    }
  )
  : _service = service,
    _hasUserAcceptedTerms = hasUserAcceptedTerms;

  final UserAcceptanceCallback _hasUserAcceptedTerms;
  final FirebaseAuthService _service;

  FacebookLogin _facebookLogin = new FacebookLogin();

  @override
  String get providerName => 'facebook';

  @override
  String get providerDisplayName => 'Facebook';

  @override
  Future<AuthUser> linkAccount(Map<String, String> args) async {
    var facebook = await _facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    switch (facebook.status) {
      case FacebookLoginStatus.loggedIn:
        var user = await _service.auth.currentUser();
        var credential = fb.FacebookAuthProvider.getCredential(
          accessToken: facebook.accessToken.token,
        );

        await user.linkWithCredential(credential);
        user = await _service.auth.currentUser();
        return _service.authUserChanged.value = new FirebaseUser(user);

        break;
      default:
        return null;
    }
  }

  @override
  Future<AuthUser> signIn(Map<String, String> args, {termsAccepted = false}) async {
    var facebook = await _facebookLogin.logInWithReadPermissions(['email', 'public_profile']);

    switch (facebook.status) {
      case FacebookLoginStatus.loggedIn:
        var credential = fb.FacebookAuthProvider.getCredential(
          accessToken: facebook.accessToken.token,
        );

        var result = await _service.auth.signInWithCredential(credential);
        if (!termsAccepted && _hasUserAcceptedTerms != null) {
          bool accepted = await _hasUserAcceptedTerms(result.user?.uid);
          if (!accepted) {
            throw new UserAcceptanceRequiredException(args);
          }
        }

        return _service.authUserChanged.value = new FirebaseUser(result.user);
        break;
      default:
        return null;
    }
  }

  @override
  Future<AuthUser> changePassword(Map<String, String> args) async {
    throw new UnsupportedError('Cannot change Facebook password ');
  }

  @override
  Future<AuthUser> changePrimaryIdentifier(Map<String, String> args) async {
    throw new UnsupportedError('Cannot change Facebook email ');
  }

  @override
  Future<AuthUser> create(Map<String, String> args,
      {termsAccepted = false}) async {
    throw new UnsupportedError('Cannot create Facebook password ');
  }

  @override
  Future<AuthUser> sendPasswordReset(Map<String, String> args) async {
    throw new UnsupportedError('Cannot reset Facebook password ');
  }

  @override
  Future<AuthUser> sendVerification(Map<String, String> args) async {
    throw new UnsupportedError('Cannot send Facebook verification email ');
  }

}
