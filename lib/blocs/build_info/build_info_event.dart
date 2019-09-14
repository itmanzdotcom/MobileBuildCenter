import 'package:equatable/equatable.dart';

import 'package:tiki_app_testing/models/build_response.dart';

class BuildInfoEvent extends Equatable {
  BuildInfoEvent([List props = const []]) : super(props);
}

class FetchBuildInfo extends BuildInfoEvent {
  @override
  String toString() => "FetchBuildInfo";
}

class SelectBuild extends BuildInfoEvent {
  final BuildInfo info;

  SelectBuild(this.info) : super([info]);

  @override
  String toString() => "Select build: $info";
}