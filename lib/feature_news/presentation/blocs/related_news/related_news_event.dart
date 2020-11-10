part of 'related_news_bloc.dart';

abstract class RelatedNewsEvent extends Equatable {
  const RelatedNewsEvent();
  @override
  List<Object> get props => [];
}

class GetRelatedNewsEvent extends RelatedNewsEvent {}
