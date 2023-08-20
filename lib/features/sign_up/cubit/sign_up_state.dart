part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError {
  invalid,
}

class SignUpState extends Equatable {

  final EmailForm emailForm;
  final PasswordForm passwordForm;
  final ConfirmedPasswordForm confirmedPasswordForm;
  final FormzSubmissionStatus formzSubmissionStatus;
  final bool isValid;
  final String? errorMessage;

  SignUpState({
    this.emailForm = const EmailForm.pure(),
    this.passwordForm = const PasswordForm.pure(),
    this.confirmedPasswordForm = const ConfirmedPasswordForm.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
});

  @override
  List<Object?> get props => [emailForm, passwordForm, confirmedPasswordForm, formzSubmissionStatus, isValid, errorMessage];

  SignUpState copyWith({
    EmailForm? emailForm,
    PasswordForm? passwordForm,
    ConfirmedPasswordForm? confirmedPasswordForm,
    FormzSubmissionStatus? formzSubmissionStatus,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignUpState(
      emailForm: emailForm ?? this.emailForm,
      passwordForm: passwordForm ?? this.passwordForm,
      confirmedPasswordForm:
          confirmedPasswordForm ?? this.confirmedPasswordForm,
      formzSubmissionStatus:
          formzSubmissionStatus ?? this.formzSubmissionStatus,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
