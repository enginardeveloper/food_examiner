import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexaminer/configs/app_config.dart';
import 'package:foodexaminer/core/bloc_core/ui_status_state.dart';
import 'package:foodexaminer/core/dimensions/app_dimensions.dart';
import 'package:foodexaminer/core/spacings/app_spacing.dart';
import 'package:foodexaminer/features/dog_image_random/bloc/dog_image_random_notification.dart';
import 'package:foodexaminer/widgets/pages/error_page.dart';
import 'package:logger/logger.dart';

import '../../../injector/injector.dart';
import '../../../services/log_service/log_service.dart';
import '../../../widgets/pages/loading_page.dart';
import '../bloc/dog_image_random_bloc.dart';

class DogImageRandomView extends StatefulWidget {

  const DogImageRandomView({super.key});

  @override
  State<DogImageRandomView> createState() => _DogImageRandomViewState();

}

class _DogImageRandomViewState extends State<DogImageRandomView> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DogImageRandomBloc>(
      create: (context) => Injector.instance<DogImageRandomBloc>(),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
        bottomNavigationBar: _ButtonBar(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Text('Dog Image Random Page');
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _Body extends StatelessWidget {
  const _Body();


  @override
  Widget build(BuildContext context) {
    LogService _logService = Injector.instance<LogService>();

    return Center(
      child: BlocConsumer<DogImageRandomBloc, DogImageRandomState>(
        listenWhen: (prev, next) => prev.notification != next.notification,
        listener: (context, state) {
          _logService.i("====DogImageRandomState11 $state.notification");
          if (state.notification == null)
            return;
          if (state.notification is NotificationNotifySuccess) {
            Flushbar(
              message: (state.notification as NotificationNotifySuccess)
                  .message,
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.green,
            ).show(context);
          } else if (state.notification is NotificationNotifyFailed) {
            Flushbar(
              message: (state.notification as NotificationNotifyFailed).message,
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.green,
            ).show(context);
          }
        },
        buildWhen: (prev, next) =>
        prev.statusState != next.statusState ||
            prev.isBusy != next.isBusy,
        builder: (context, state) {
          Widget widget = Container();

          _logService.i("===state.statusState: $state.statusState");

          if (state.statusState is UIStatusInitial)
            widget = const Text('Press Button');
          if (state.statusState is UIStatusLoading)
            widget = LoadingPage();
          if (state.statusState is UIStatusLoadFailed)
            widget = ErrorPage(
              content: (state.notification as UIStatusLoadFailed)
                  .message,
            );
          if (state.statusState is UIStatusLoadSuccess)
            widget = Image.network(state.dogImage.message,);

          return Stack(
            alignment: Alignment.center,
            children: [
              widget,
              if (state.isBusy) LoadingPage(),
            ],
          );
        },
      ),
    );
  }

}

class _ButtonBar extends StatelessWidget {
  const _ButtonBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.basePadding,
          vertical: AppDimensions.basePadding,
        ),
        child: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<DogImageRandomBloc>().add(
                    const DogImageRandomEventRandomRequested(),
                );
              },
              child: Text('Load Image'),
            ),
          ),
        ],),
      ),
    );
  }
}