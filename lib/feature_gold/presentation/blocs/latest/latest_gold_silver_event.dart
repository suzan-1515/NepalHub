part of 'latest_gold_silver_bloc.dart';

abstract class GoldSilverEvent extends Equatable {
  const GoldSilverEvent();

  @override
  List<Object> get props => [];
}

class GetLatestGoldSilverEvent extends GoldSilverEvent {
  final Language language;

  GetLatestGoldSilverEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}

class RefreshLatestGoldSilverEvent extends GoldSilverEvent {
  final Language language;

  RefreshLatestGoldSilverEvent({this.language = Language.ENGLISH});
  @override
  List<Object> get props => [language];
}
