import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexaminer/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:foodexaminer/features/sign_up/view/sign_up_form_view.dart';

import '../../../injector/injector.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<SignUpCubit>(
      create: (context) => Injector.instance<SignUpCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
