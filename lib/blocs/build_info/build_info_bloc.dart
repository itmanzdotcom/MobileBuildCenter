import 'package:bloc/bloc.dart';

import 'package:tiki_app_testing/repository/build_repository.dart';

import 'build_info_event.dart';
import 'build_info_state.dart';

class BuildInfoBloc extends Bloc<BuildInfoEvent, BuildInfoState> {
  final BuildRepository buildRepository;

  BuildInfoBloc({this.buildRepository});

  @override
  get initialState => BuildInfoUninitialized();

  @override
  Stream<BuildInfoState> mapEventToState(BuildInfoEvent event) async* {
    if (event is FetchBuildInfo) {
      try {
        final buildSections = await this.buildRepository.getBuilds();
        var builds = [];
        buildSections.forEach((item) => builds.addAll(item.builds));
          yield BuildInfoLoaded(builds);
      } catch (e) {
        yield BuildInfoError(e.toString());
      }
    }
  }
}
