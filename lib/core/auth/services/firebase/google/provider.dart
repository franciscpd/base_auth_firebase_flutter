import 'dart:async';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_auth_base/flutter_auth_base.dart';
import 'package:ezsale/core/auth/services/firebase/user.dart';
import 'package:ezsale/core/auth/services/firebase/auth_service.dart';
import 'package:ezsale/core/auth/services/firebase/user_acceptance_callback.dart';

class FirebaseGoogleProvider extends AuthProvider implements LinkableProvider {
  FirebaseGoogleProvider(
    {
      @required FirebaseAuthService service,
      UserAcceptanceCallback hasUserAcceptedTerms
    }
  )
  : _service = service,
    _hasUserAcceptedTerms = hasUserAcceptedTerms;

  final UserAcceptanceCallback _hasUserAcceptedTerms;
  final FirebaseAuthService _service;

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: ['email'],
  );

  @override
  String get providerName => 'google';

  @override
  String get providerDisplayName => 'Google';

  @override
  Future<AuthUser> linkAccount(Map<String, String> args) async {
    var account = await _googleSignIn.signIn();

    if (account == null) {
      return null;
    }

    GoogleSignInAuthentication signInAuth = await account.authentication;
     var credential = fb.GoogleAuthProvider.getCredential(
      accessToken: signInAuth.accessToken,
      idToken: signInAuth.idToken,
    );
    var user = await _service.auth.currentUser();
    await user.linkWithCredential(credential);
    user = await _service.auth.currentUser();
    return _service.authUserChanged.value = new FirebaseUser(user);
  }

  @override
  Future<AuthUser> signIn(Map<String, String> args, {termsAccepted = false}) async {
    var account = await _googleSignIn.signIn();

    if (account == null) {
      return null;
    }

    GoogleSignInAuthentication signInAuth = await account.authentication;
    var credential = fb.GoogleAuthProvider.getCredential(
      accessToken: signInAuth.accessToken,
      idToken: signInAuth.idToken,
    );
    var result = await _service.auth.signInWithCredential(credential);

    if (!termsAccepted && _hasUserAcceptedTerms != null) {
      bool accepted = await _hasUserAcceptedTerms(result.user?.uid);
      if (!accepted) {
        throw new UserAcceptanceRequiredException(args);
      }
    }

    return _service.authUserChanged.value = new FirebaseUser(result.user);
  }

  @override
  Future<AuthUser> changePassword(Map<String, String> args) async {
    throw new UnsupportedError('Cannot change Google password ');
  }

  @override
  Future<AuthUser> changePrimaryIdentifier(Map<String, String> args) async {
    throw new UnsupportedError('Cannot change Google email ');
  }

  @override
  Future<AuthUser> create(Map<String, String> args,
      {termsAccepted = false}) async {
    throw new UnsupportedError('Cannot create Google password ');
  }

  @override
  Future<AuthUser> sendPasswordReset(Map<String, String> args) async {
    throw new UnsupportedError('Cannot reset Google password ');
  }

  @override
  Future<AuthUser> sendVerification(Map<String, String> args) async {
    throw new UnsupportedError('Cannot send Google verification email ');
  }

}
