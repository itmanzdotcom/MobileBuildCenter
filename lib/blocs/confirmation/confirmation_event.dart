import 'package:equatable/equatable.dart';

class ConfirmationEvent extends Equatable {
  ConfirmationEvent([List props = const []]) : super(props);
}

class OpenConfirmation extends ConfirmationEvent {
  final String content;

  OpenConfirmation(this.content) : super([content]);

  @override
  String toString() => "Open confirmation with content: ${this.content}";
}

class CloseConfirmation extends ConfirmationEvent {
  @override
  String toString() => "Close confirmation";
}