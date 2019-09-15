import 'package:flutter/material.dart';
import 'blocs/app_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes.dart';
import 'locator.dart';
import 'package:tiki_app_testing/views/main_view.dart';
import 'package:tiki_app_testing/views/search_view.dart';
import 'blocs/blocs.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BuildInfoBloc>(
          builder: (context) => BuildInfoBloc(),
        ),
      ],
      child: BuildCenterApp(),
    ),
  );
}

class BuildCenterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mobile Build Center",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.main:
            return FadeRoute(
              widget: MultiBlocProvider(
                providers: [
                  BlocProvider<TabBloc>(
                    builder: (context) => TabBloc(),
                  ),
                ],
                child: MainView(),
              ),
            );
          case AppRoutes.search:
            return FadeRoute(
              widget: MultiBlocProvider(
                providers: [
                  BlocProvider<SearchBloc>(
                    builder: (context) => SearchBloc(),
                  ),
                ],
                child: SearchView(),
              ),
            );
        }
        return FadeRoute(widget: Container());
      },
    );
  }
}
