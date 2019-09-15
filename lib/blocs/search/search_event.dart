import 'package:equatable/equatable.dart';

import 'package:tiki_app_testing/models/build_response.dart';

class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super([props]);
}

class SearchBuilds extends SearchEvent {
  final String keyword;
  final List<BuildInfo> builds;

  SearchBuilds(this.keyword, this.builds) : super([keyword, builds]);

  @override
  String toString() => "Start search $keyword";
}
