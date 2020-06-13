import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/models/app_error.dart';
import '../../core/models/news.dart';
import '../../core/services/nepal_api_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NepalApiService apiService;

  NewsBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  NewsState get initialState => InitialNewsState();

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetNewsEvent) {
      yield LoadingNewsState();
      try {
        final List<News> news = await apiService.fetchNews(0);
        yield LoadedNewsState(news: news);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorNewsState(message: e.message);
      }
    }
  }
}
