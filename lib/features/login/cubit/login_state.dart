part of 'login_cubit.dart';

class LoginState extends Equatable {

  final EmailForm emailForm;
  final PasswordForm passwordForm;
  final FormzSubmissionStatus formzSubmissionStatus;
  final bool isValid;
  final String? errorMessage;

  const LoginState({
    this.emailForm = const EmailForm.pure(),
    this.passwordForm = const PasswordForm.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [emailForm, passwordForm, formzSubmissionStatus, isValid, errorMessage];

  LoginState copyWith({
    EmailForm? emailForm,
    PasswordForm? passwordForm,
    FormzSubmissionStatus? formzSubmissionStatus,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      emailForm: emailForm ?? this.emailForm,
      passwordForm: passwordForm ?? this.passwordForm,
      formzSubmissionStatus:
          formzSubmissionStatus ?? this.formzSubmissionStatus,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}