import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiki_app_testing/blocs/tab/tab_bloc.dart';
import 'package:tiki_app_testing/blocs/tab/tab_event.dart';
import 'package:tiki_app_testing/models/app_tab.dart';
import 'package:tiki_app_testing/utils/styles.dart';
import 'package:tiki_app_testing/widgets/tab_selector.dart';

import 'builds_view.dart';
import 'deeplinks_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final _tabBloc = BlocProvider.of<TabBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          backgroundColor: Styles.lightYellowColor,
          body: SafeArea(
            child: activeTab == AppTab.Builds ? BuildsView() : DeepLinksView(),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => _tabBloc.dispatch(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
