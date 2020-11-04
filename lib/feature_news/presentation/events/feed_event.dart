import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NewsChangeEvent extends Equatable {
  final Object data;
  final String eventType;

  NewsChangeEvent({@required this.data, @required this.eventType});

  @override
  List<Object> get props => [data, eventType];
}
