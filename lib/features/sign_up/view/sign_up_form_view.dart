import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexaminer/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.formzSubmissionStatus.isSuccess) {
          Navigator.pop(context);
        } else if (state.formzSubmissionStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const SizedBox(height: 8,),
            _PasswordInput(),
            const SizedBox(height: 8,),
            _ConfirmedPasswordInput(),
            const SizedBox(height: 8,),
            _SignUpButton(),
          ],),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.emailForm != current.emailForm,
      builder: (context, state) {
        return TextField(
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'e-posta',
              helperText: '',
              errorText: state.passwordForm.displayError != null
                  ? 'invalid password'
                  : null,
            ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
        previous.passwordForm != current.passwordForm,
        builder: (context, state) {
          return TextField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              helperText: '',
              errorText: state.passwordForm.displayError != null
                  ? 'invalid password'
                  : null,
            ),
          );
        }
    );
  }
}

class _ConfirmedPasswordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
      previous.passwordForm != current.passwordForm ||
          previous.confirmedPasswordForm != current.confirmedPasswordForm,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPassword_textField'),
          onChanged: (confirmedPassword) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(
                  confirmedPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPasswordForm.displayError != null
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.formzSubmissionStatus.isInProgress ?
        const CircularProgressIndicator() :
        ElevatedButton(
          key: const Key('signUpForm_signUp_raisedButton'),
          style:
          ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blue,
          ),
          onPressed: state.isValid
              ? () => context.read<SignUpCubit>().signUpFormSubmitted()
              : null,
          child: const Text('Kayıt Ol '),
        );
      },
    );
  }
}

