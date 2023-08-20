import '../../../model/my_user.dart';

abstract class AuthenticationRepository {

  Future<void> signUp({required String email, required String password});

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logOut();

  Future<bool> isLoggedIn();

  Stream<MyUser> get myUser;

  MyUser get currentMyUser;


}
