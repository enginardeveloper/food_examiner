import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/keys/widget_keys.dart';
import '../../../core/spacings/app_spacing.dart';
import '../../../router/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: const Key(WidgetKeys.homeScaffoldKey),
      appBar: AppBar(
        title: Text('Home After first visit'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: Text('Dog Image Random'),
                onPressed: () {
                  context.push(AppRouter.dogImageRandomPath);
                },
            ),
            AppSpacing.verticalSpacing32,
            ElevatedButton(
              child: Text('Settings'),
              onPressed: () {
                context.push(AppRouter.settingsPath);
              },
            ),
            AppSpacing.verticalSpacing32,
            ElevatedButton(
                onPressed: () {
                  context.push(AppRouter.assetsPath);
                },
                child: Text('Assets'),),
          ],
        ),
      ),
    );
  }
}
