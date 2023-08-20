import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodexaminer/data/repository/remote/authentication_repository/impl/authentication_repository_impl.dart';
import 'package:foodexaminer/services/log_service/log_service.dart';
import 'package:formz/formz.dart';

import '../../../data/repository/remote/authentication_repository/authentication_repository.dart';
import '../../../widgets/forms/email_form.dart';
import '../../../widgets/forms/password_form.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final LogService _logService;

  LoginCubit({required AuthenticationRepository authenticationRepository, required LogService logService}) :
        _logService = logService,
        _authenticationRepository = authenticationRepository,
        super(LoginState());

  void emailChanged(String value) {
    final emailForm = EmailForm.dirty(value);
    emit(
      state.copyWith(
        emailForm: emailForm,
        isValid: Formz.validate([emailForm, state.passwordForm]),
      ),
    );
  }

  void passwordChanged(String value) {
    final passwordForm = PasswordForm.dirty(value);
    emit(
      state.copyWith(
        passwordForm: passwordForm,
        isValid: Formz.validate([passwordForm, state.emailForm]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.isValid) return;
    emit(
      state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress,
      ),
    );
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.emailForm.value,
        password: state.passwordForm.value,
      );
      emit(
        state.copyWith(
          formzSubmissionStatus: FormzSubmissionStatus.success,
        ),
      );
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          formzSubmissionStatus: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure),
      );
    }
  }

}
