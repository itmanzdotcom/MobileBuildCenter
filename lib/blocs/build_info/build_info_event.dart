import 'package:equatable/equatable.dart';

class BuildInfoEvent extends Equatable {
  BuildInfoEvent([List props = const []]) : super(props);
}

class FetchBuildInfo extends BuildInfoEvent {
  @override
  String toString() => "FetchBuildInfo";
}