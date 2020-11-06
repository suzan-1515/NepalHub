import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_category_entity.dart';
import 'package:samachar_hub/feature_gold/domain/usecases/usecases.dart';

part 'gold_silver_category_event.dart';
part 'gold_silver_category_state.dart';

class GoldCategoryBloc extends Bloc<GoldCategoryEvent, GoldCategoryState> {
  final GetGoldSilverCategoriesUseCase _getGoldCategoriesUseCase;
  GoldCategoryBloc(
      {@required GetGoldSilverCategoriesUseCase getGoldCategoriesUseCase})
      : _getGoldCategoriesUseCase = getGoldCategoriesUseCase,
        super(GoldCategoryInitialState());

  @override
  Stream<GoldCategoryState> mapEventToState(
    GoldCategoryEvent event,
  ) async* {
    if (event is GetGoldCategories) {
      if (state is GoldCategoryLoadingState) return;
      yield GoldCategoryLoadingState();
      try {
        final List<GoldSilverCategoryEntity> currencies =
            await _getGoldCategoriesUseCase.call(
          GetGoldSilverCategoriesUseCaseParams(language: event.language),
        );
        if (currencies == null || currencies.isEmpty) {
          yield GoldCategoryEmptyState(
              message: 'Gold/Silver category not available.');
        } else
          yield GoldCategoryLoadSuccessState(categories: currencies);
      } catch (e) {
        log('Gold category load error: ', error: e);
        yield GoldCategoryLoadErrorState(
            message:
                'Unable to load gold/silver categories. Make sure you are connected to Internet.');
      }
    }
  }
}
