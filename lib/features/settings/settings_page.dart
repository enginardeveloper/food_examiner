import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/dimensions/app_dimensions.dart';
import '../app/bloc/app_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.basePadding),
        child: Column(children: [
           const _DarkModeRow(),
        ],),
      ),
    );
  }

}

class _DarkModeRow extends StatelessWidget {

   const _DarkModeRow();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.select((AppBloc appBloc) =>
    appBloc.state.isDarkMode);
    print("======isDarkMode in settings_page: $isDarkMode");
    return SwitchListTile(
      value: isDarkMode,
      onChanged: (value) {
        context.read<AppBloc>().add(const AppEventDarkModeChanged());
      },
      title: Text('Dark Mode'),
    );
  }

}