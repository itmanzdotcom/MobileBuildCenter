import 'package:flutter/material.dart';
import 'blocs/app_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes.dart';
import 'locator.dart';
import 'package:tiki_app_testing/views/main_view.dart';
import 'blocs/blocs.dart';


void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  setupLocator();
  runApp(BuildCenterApp());
}

class BuildCenterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mobile Build Center",
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      routes: {
        AppRoutes.main: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                builder: (context) => TabBloc(),
              ),
              BlocProvider<BuildInfoBloc>(
                builder: (context) => BuildInfoBloc(),
              ),
            ],
            child: MainView(),
          );
        }
      },
    );
  }
}