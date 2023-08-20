import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:foodexaminer/services/log_service/impl/debug_log_service_impl.dart';
import 'package:foodexaminer/services/log_service/log_service.dart';
import 'package:meta/meta.dart';
import '../../../../../services/cache_client_service/cache_client_service.dart';
import '../../../../../services/cache_client_service/impl/cache_client_service_impl.dart';
import '../../../../model/my_user.dart';
import '../authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  AuthenticationRepositoryImpl({
    LogService? logService,
    CacheClientService? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,

  })
      : _logService = logService ?? DebugLogServiceImpl(),
        _cache = cache ?? CacheClientServiceImpl(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClientService _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final LogService _logService;

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @override
  Stream<MyUser> get myUser {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {

      if (firebaseUser == null)
        _logService.i("===== firebaseUser is null");
      else
        _logService.i("===== firebaseUser is" + firebaseUser.uid);
      final myUser = firebaseUser == null ? MyUser.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: myUser);
      return myUser;


    });
  }

  @override
  Future<bool> isLoggedIn() async {
    if (_firebaseAuth.currentUser == null) {
      _logService.i("===== _firebaseAuth.currentUser is null");
      _cache.write(key: userCacheKey, value: MyUser.empty);
      return false;
    } else {
      _logService.i("===== _firebaseAuth.currentUser is not null");

      try {
        IdTokenResult? result = await _firebaseAuth.currentUser!.getIdTokenResult(true);

        if (result == null) {
          _cache.write(key: userCacheKey, value: MyUser.empty);
          return false;
        } else {
          if (_firebaseAuth.currentUser!.emailVerified) {
            _cache.write(key: userCacheKey, value: _firebaseAuth.currentUser!.toUser);
            return true;
          }
          else {
            _cache.write(key: userCacheKey, value: MyUser.empty);
            return false;
          }
        }
      } catch (e, stackTrace) {
        print(e.toString());
        _logService.e('AuthenticationRepositoryImpl in isLoggedIn', e, stackTrace);
        return false;
      }
    }
  }

  @override
  MyUser get currentMyUser {
    return _cache.read<MyUser>(key: userCacheKey) ?? MyUser.empty;
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

}

class SignUpWithEmailAndPasswordFailure implements Exception {

  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}


class LogInWithEmailAndPasswordFailure implements Exception {

  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}


class LogInWithGoogleFailure implements Exception {

  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}


extension on firebase_auth.User {
  MyUser get toUser {
    return MyUser(id: uid, email: email, name: displayName,);
  }
}