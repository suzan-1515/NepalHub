part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class InitialNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final List<News> news;

  LoadedNewsState({
    @required this.news,
  }) : assert(news != null);
}

class ErrorNewsState extends NewsState {
  final String message;

  ErrorNewsState({
    @required this.message,
  }) : assert(message != null);
}
