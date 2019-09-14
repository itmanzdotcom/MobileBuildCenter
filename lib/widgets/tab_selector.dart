import 'package:flutter/material.dart';

import 'package:tiki_app_testing/models/app_tab.dart';
import 'package:tiki_app_testing/utils/styles.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Styles.lightYellowColor,
      iconSize: 30,
      currentIndex: AppTab.values.indexOf(activeTab),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.Builds ? Icons.view_list : Icons.link,
          ),
          title: Text(tab == AppTab.Builds ? "Builds" : "Deep Links"),
        );
      }).toList(),
    );
  }
}
