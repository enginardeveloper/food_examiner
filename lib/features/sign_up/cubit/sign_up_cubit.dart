import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodexaminer/widgets/forms/confirmed_password_form.dart';
import 'package:foodexaminer/widgets/forms/password_form.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/remote/authentication_repository/authentication_repository.dart';
import '../../../data/repository/remote/authentication_repository/impl/authentication_repository_impl.dart';
import '../../../services/log_service/log_service.dart';
import '../../../widgets/forms/email_form.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  final LogService _logService;

  SignUpCubit(
      {required AuthenticationRepository authenticationRepository,
      required LogService logService})
      : _authenticationRepository = authenticationRepository,
        _logService = logService,
        super(SignUpState());

  void emailChanged(String value) {
    final emailForm = EmailForm.dirty(value);
    emit(
      state.copyWith(
        emailForm: emailForm,
        isValid: Formz.validate([
          emailForm,
          state.passwordForm,
          state.confirmedPasswordForm,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final passwordForm = PasswordForm.dirty(value);
    final confirmedPasswordForm = ConfirmedPasswordForm.dirty(
      originalPassword: passwordForm.value,
      value: state.confirmedPasswordForm.value,
    );
    emit(
      state.copyWith(
        passwordForm: passwordForm,
        isValid: Formz.validate([
          state.emailForm,
          passwordForm,
          confirmedPasswordForm,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPasswordForm.dirty(
      originalPassword: state.passwordForm.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPasswordForm: confirmedPassword,
        isValid: Formz.validate([
          state.emailForm,
          state.passwordForm,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.signUp(
          email: state.emailForm.value, password: state.passwordForm.value);
      emit(
        state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.success,
        ),
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure),
      );
    }
  }
}
