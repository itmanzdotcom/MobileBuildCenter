import 'package:equatable/equatable.dart';

import 'package:tiki_app_testing/models/app_tab.dart';

class TabEvent extends Equatable {
  TabEvent([List props = const[]]) : super(props);
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  UpdateTab(this.tab) : super([tab]);

  @override
  String toString() => "Tab selected: $tab";
}