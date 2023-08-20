import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError {
  invalid,
}

class ConfirmedPasswordForm extends FormzInput<String, ConfirmedPasswordValidationError> {

  final String originalPassword;

  const ConfirmedPasswordForm.pure({this.originalPassword = ''}) : super.pure('');

  const ConfirmedPasswordForm.dirty({required this.originalPassword, String value = ''}) : super.dirty(value);

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    return  originalPassword == value ? null : ConfirmedPasswordValidationError.invalid;
  }

}