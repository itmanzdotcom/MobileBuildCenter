import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search_event.dart';
import 'search_state.dart';

import 'package:tiki_app_testing/repository/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _searchRepository = SearchRepository();

  @override
  SearchState get initialState => SearchUninitialized();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchBuilds) {
      yield SearchLoading();
      final filteredBuilds = await _searchRepository.searchBuilds(event.keyword, event.builds);
      yield SearchLoaded(filteredBuilds);
    }
  }

  @override
  Stream<SearchState> transformEvents(Stream<SearchEvent> events, Stream<SearchState> Function(SearchEvent event) next) {
    final observableStream = events as Observable<SearchEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! SearchBuilds);
    });
    final debounceStream = observableStream.where((event) {
      return (event is SearchBuilds);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }
}
