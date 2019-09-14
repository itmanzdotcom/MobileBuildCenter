import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tiki_app_testing/utils/constants.dart';

@immutable
class BuildResponse extends Equatable {
  final List<BuildInfoSection> androidBuilds;
  final List<BuildInfoSection> iOSBuilds;

  BuildResponse({this.androidBuilds, this.iOSBuilds});

  factory BuildResponse.fromJSON(Map<String, dynamic> json) {
    final _androidBuilds = json['android'].map((item) => BuildInfoSection.fromJSON(item)).toList();
    final _iOSBuilds = json['ios'].map((item) => BuildInfoSection.fromJSON(item)).toList();

    return BuildResponse(androidBuilds: _androidBuilds, iOSBuilds: _iOSBuilds);
  }
}

@immutable
class BuildInfoSection extends Equatable {
  final String version;
  final List<BuildInfo> builds;

  BuildInfoSection({this.version, this.builds});

  factory BuildInfoSection.fromJSON(Map<String, dynamic> json) {
    return BuildInfoSection(
      version: json['name'],
      builds: (json['versions'] as List).map((item) => BuildInfo.fromJSON(item)).toList(),
    );
  }
}

@immutable
class BuildInfo extends Equatable {
  final String name;
  final String platform;
  final String version;
  final String link;
  final String icon;

  BuildInfo({
    this.name,
    this.version,
    this.platform,
    this.link,
    this.icon,
  });

  factory BuildInfo.fromJSON(Map<String, dynamic> json) {
    final platformStr = json['platform'];
    var linkStr = json['link'];
    if (platformStr == 'ios') {
      linkStr = "${Constants.iOSLinkPrefix}$linkStr";
    }

    return BuildInfo(
      name: json['name'],
      version: json['version'],
      platform: platformStr,
      link: linkStr,
      icon: json['icon'],
    );
  }
}
