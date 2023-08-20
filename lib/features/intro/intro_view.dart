import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/keys/widget_keys.dart';
import '../../core/spacings/app_spacing.dart';
import '../app/bloc/app_bloc.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Intro first visit welcome'),
            AppSpacing.verticalSpacing32,
            ElevatedButton(
              key: const Key(WidgetKeys.introStartedButtonKey),
                child: const Text('Started'),
                onPressed: () {
                context.read<AppBloc>().add(const AppEventDisableFirstUse());
                },
            ),
          ],
        ),
      ),
    );
  }
}
