import 'package:equatable/equatable.dart';

import 'package:tiki_app_testing/models/build_response.dart';

class BuildInfoState extends Equatable {
  BuildInfoState([List props = const[]]) : super(props);
}

class BuildInfoLoading extends BuildInfoState {
  @override
  String toString() => "BuildInfoLoading";
}

class BuildInfoLoaded extends BuildInfoState {
  final List<BuildInfo> builds;

  BuildInfoLoaded([this.builds]);

  @override
  String toString() => "BuildInfoLoaded with length: ${this.builds.length}";
}

class BuildInfoError extends BuildInfoState {
  final String message;

  BuildInfoError([this.message]);

  @override
  String toString() => "Error when loading build info";
}