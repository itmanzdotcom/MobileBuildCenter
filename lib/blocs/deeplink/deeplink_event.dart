import 'package:equatable/equatable.dart';

import 'package:tiki_app_testing/models/deeplink_tab.dart';

class DeepLinkEvent extends Equatable {
  DeepLinkEvent([List props = const []]) : super([props]);
}

class FetchDeepLink extends Equatable {
  final DeepLinkTab currentTab;

  FetchDeepLink([this.currentTab]) : super([currentTab]);

  @override
  String toString() => "Fetch DeepLink";
}
