import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tiki_app_testing/repository/build_repository.dart';
import 'package:tiki_app_testing/models/build_response.dart';

import 'build_info_event.dart';
import 'build_info_state.dart';

class BuildInfoBloc extends Bloc<BuildInfoEvent, BuildInfoState> {
  final BuildRepository buildRepository = BuildRepository();

  @override
  get initialState => BuildInfoUninitialized();

  @override
  Stream<BuildInfoState> mapEventToState(BuildInfoEvent event) async* {
    if (event is FetchBuildInfo) {
      try {
        final buildSections = await this.buildRepository.getBuilds();
        List<BuildInfo> builds = [];
        buildSections.forEach((item) => builds.addAll(item.builds));
          yield BuildInfoLoaded(builds);
      } catch (e) {
        yield BuildInfoError(e.toString());
      }
    }

    if (event is SelectBuild) {
      _launchUrl(event.info.link);
    }
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
