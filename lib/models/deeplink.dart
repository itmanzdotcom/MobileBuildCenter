import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class DeepLink extends Equatable {
  final String name;
  final String url;

  DeepLink({this.name, this.url}) : super([name, url]);

  factory DeepLink.fromJSON(Map<String, dynamic> json) {
    return DeepLink(
      name: json['name'],
      url: json['url'],
    );
  }
}

class RemoteDeepLink extends DeepLink {
  RemoteDeepLink({String name, String url}) : super(name: name, url: url);

  factory RemoteDeepLink.fromJSON(Map<String, dynamic> json) {
    return RemoteDeepLink(
      name: json['name'],
      url: json['url'],
    );
  }
}

class LocalDeepLink extends DeepLink {
  final String id;
  LocalDeepLink({@required this.id, String name, String url})
      : super(name: name, url: url);

  factory LocalDeepLink.fromJSON(Map<String, dynamic> json) {
    return LocalDeepLink(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}
