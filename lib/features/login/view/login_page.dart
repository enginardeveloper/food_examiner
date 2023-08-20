import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexaminer/features/login/cubit/login_cubit.dart';

import '../../../injector/injector.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {

    return BlocProvider<LoginCubit>(
      create: (context) => Injector.instance<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Giriş yap'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
