part of 'news_detail_bloc.dart';

abstract class NewsDetailEvent extends Equatable {
  const NewsDetailEvent();
}

class GetNewsDetailEvent extends NewsDetailEvent {
  GetNewsDetailEvent();

  @override
  List<Object> get props => [];
}
