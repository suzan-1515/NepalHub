import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_sources_use_case.dart';

part 'news_filter_event.dart';
part 'news_filter_state.dart';

class NewsFilterBloc extends Bloc<NewsFilterEvent, NewsFilterState> {
  final UseCase _getNewsSourcesUseCase;

  NewsFilterBloc({@required UseCase getNewsSourcesUseCase})
      : this._getNewsSourcesUseCase = getNewsSourcesUseCase,
        super(InitialState());

  SortBy selectedSortBy = SortBy.RECENT;
  NewsSourceEntity selectedSource;
  List<NewsSourceEntity> sources;

  @override
  Stream<NewsFilterState> mapEventToState(
    NewsFilterEvent event,
  ) async* {
    if (state is SourceLoadingState) return;
    if (event is GetNewsFilterSourcesEvent) {
      yield SourceLoadingState();
      try {
        final List<NewsSourceEntity> sources = await _getNewsSourcesUseCase
            .call(GetNewsSourcesUseCaseParams(language: event.language));
        if (sources == null || sources.isEmpty) {
          yield SourceEmptyState(message: 'News sources not available');
        } else {
          this.sources = sources;
          yield SourceLoadSuccessState(sources: this.sources);
        }
      } catch (e) {
        log('News by source load error.', error: e);
        yield SourceLoadErrorState(message: 'Error loading news sources.');
      }
    } else if (event is NewsFilterSortByChangedEvent) {
      selectedSortBy = event.sortBy;
      yield SortByChangedState(sortBy: event.sortBy);
    } else if (event is NewsFilterSourceChangedEvent) {
      selectedSource = event.source;
      yield SourceChangedState(source: event.source);
    }
  }
}
