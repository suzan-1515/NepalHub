import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NewsFeedEvent extends Equatable {
  final String feedId;
  final String eventType;

  NewsFeedEvent({@required this.feedId, @required this.eventType});

  @override
  List<Object> get props => [feedId, eventType];
}
