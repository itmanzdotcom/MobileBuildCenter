import 'package:equatable/equatable.dart';

import 'package:tiki_app_testing/models/build_response.dart';

class SearchState extends Equatable {
  SearchState([List props = const []]) : super([props]);
}

class SearchUninitialized extends SearchState {
  @override
  String toString() => "SearchUninitialized";
}

class SearchLoading extends SearchState {
  @override
  String toString() => "SearchLoading";
}

 class SearchLoaded extends SearchState {
  final List<BuildInfo> builds;

  SearchLoaded(this.builds) : super([builds]);

  @override
  String toString() => "Search completed with ${builds.length} results";
 }
