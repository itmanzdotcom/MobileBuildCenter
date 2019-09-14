import 'dart:io';

import 'package:tiki_app_testing/services/api_client.dart';
import 'package:tiki_app_testing/models/build_response.dart';

class BaseRepository {
  final BaseApiClient apiClient;

  BaseRepository({this.apiClient});
}

class BuildRepository extends BaseRepository {
  BuildRepository(ApiClient apiClient) : super(apiClient : apiClient);
  Future<List<BuildInfoSection>> getBuilds() async {
    final response = await apiClient.get('apps');
    final buildResponse = BuildResponse.fromJSON(response);
    if (Platform.isIOS) {
      return buildResponse.iOSBuilds;
    } else {
      return buildResponse.androidBuilds;
    }
  }
}
