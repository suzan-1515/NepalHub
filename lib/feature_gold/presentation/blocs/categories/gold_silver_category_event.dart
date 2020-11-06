part of 'gold_silver_category_bloc.dart';

abstract class GoldCategoryEvent extends Equatable {
  const GoldCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetGoldCategories extends GoldCategoryEvent {
  final Language language;

  GetGoldCategories({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}
