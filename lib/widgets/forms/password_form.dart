import 'package:formz/formz.dart';

enum PasswordValidationError {
  invalid,
}

class PasswordForm extends FormzInput<String, PasswordValidationError> {

  const PasswordForm.pure() : super.pure('');

  const PasswordForm.dirty([super.value = '']) : super.dirty();
  //const PasswordForm.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
  RegExp(r'^.{6,}$');
  // RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }

}