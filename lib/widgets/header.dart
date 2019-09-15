import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiki_app_testing/blocs/blocs.dart';
import 'package:tiki_app_testing/models/app_tab.dart';
import 'package:tiki_app_testing/routes.dart';
import 'package:tiki_app_testing/utils/styles.dart';

class HeaderView extends StatelessWidget {
  final String title;
  final Function onSearch;
  final Function onAdd;

  HeaderView({this.title, this.onSearch, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: BlocBuilder<TabBloc, AppTab>(
          builder: (context, state) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _generateTitle(state),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Styles.lightBlackColor,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.search),
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: Styles.lightBlackColor,
                    ),
                  ),
                  state == AppTab.DeepLink ? SizedBox(width: 10) : null,
                  state == AppTab.DeepLink ? Icon(
                    Icons.add,
                    size: 30,
                    color: Styles.lightBlackColor,
                  ) : null,
                ].where((item) => item != null).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateTitle(AppTab currentTab) {
    return currentTab == AppTab.Builds
        ? "${Platform.isIOS ? 'iOS' : 'Android'} Builds"
        : "Deep Links";
  }
}
