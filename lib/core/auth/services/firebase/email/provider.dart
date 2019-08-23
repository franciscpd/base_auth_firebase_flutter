import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_auth_base/flutter_auth_base.dart';
import 'package:ezsale/core/auth/services/firebase/user.dart';
import 'package:ezsale/core/auth/services/firebase/auth_service.dart';
import 'package:ezsale/core/auth/services/firebase/user_acceptance_callback.dart';

class FirebaseEmailProvider extends AuthProvider implements LinkableProvider {
  FirebaseEmailProvider(
    {
      @required FirebaseAuthService service,
      UserAcceptanceCallback hasUserAcceptedTerms
    }
  )
  : _service = service,
    _hasUserAcceptedTerms = hasUserAcceptedTerms;

  final UserAcceptanceCallback _hasUserAcceptedTerms;
  final FirebaseAuthService _service;

  @override
  String get providerName => 'password';

  @override
  String get providerDisplayName => 'Email with Password';

  @override
  Future<AuthUser> create(Map<String, String> args, {termsAccepted = false}) async {
    if (!termsAccepted) {
      throw new UserAcceptanceRequiredException(args);
    } else {
      var result = await _service.auth.createUserWithEmailAndPassword(
        email: args['email'], password: args['password']
      );

      return _service.authUserChanged.value = FirebaseUser(result.user);
    }
  }

  @override
  Future<AuthUser> signIn(Map<String, String> args, {termsAccepted = false}) async {
    var result = await _service.auth.signInWithEmailAndPassword(
      email: args['email'], password: args['password']
    );

    if (!termsAccepted && _hasUserAcceptedTerms != null) {
      bool accepted = await _hasUserAcceptedTerms(result.user?.uid);
      if (!accepted) {
        throw new UserAcceptanceRequiredException(args);
      }
    }

    return _service.authUserChanged.value = new FirebaseUser(result.user);
  }

  @override
  Future<AuthUser> sendPasswordReset(Map<String, String> args) async {
    await _service.auth.sendPasswordResetEmail(email: args['email']);

    return _service.authUserChanged.value;
  }

  @override
  Future<AuthUser> sendVerification(Map<String, String> args) async {
    var user = await _service.auth.currentUser();

    await user.sendEmailVerification();

    return _service.authUserChanged.value;
  }

  @override
  Future<AuthUser> changePassword(Map<String, String> args) async {
    throw new UnimplementedError('Change password is not available');
  }

  @override
  Future<AuthUser> changePrimaryIdentifier(Map<String, String> args) async {
    throw new UnimplementedError('Change email is not available');
  }

  @override
  Future<AuthUser> linkAccount(Map<String, String> args) async {
    try {
      var user = await _service.auth.currentUser();
      await user.linkWithCredential(fb.EmailAuthProvider.getCredential(
        email: args['email'], password: args['password']
      ));
      user = await _service.auth.currentUser();
      return _service.authUserChanged.value = new FirebaseUser(user);
    } on PlatformException catch (error) {
      if (error.details.toString().startsWith('This operation is sensitive')) {
        throw new AuthRequiredException();
      }

      throw error;
    }
  }
}
