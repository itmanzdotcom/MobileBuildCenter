import 'package:tiki_app_testing/models/build_response.dart';

class SearchRepository {
  Future<List<BuildInfo>> searchBuilds(String keyword, List<BuildInfo> builds) async {
    return builds.where((item) {
      final lowerCaseKeyword = keyword.toLowerCase();
      if (lowerCaseKeyword.isNotEmpty) {
        return item.name.toLowerCase().contains(lowerCaseKeyword)
            || item.version.contains(lowerCaseKeyword);
      }
      return false;
    }).toList();
  }
}
