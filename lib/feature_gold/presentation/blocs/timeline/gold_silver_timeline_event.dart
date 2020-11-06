part of 'gold_silver_timeline_bloc.dart';

abstract class GoldSilverTimelineEvent extends Equatable {
  const GoldSilverTimelineEvent();

  @override
  List<Object> get props => [];
}

class GetGoldSilverTimelineEvent extends GoldSilverTimelineEvent {
  final Language language;
  final GoldSilverEntity goldSilver;

  GetGoldSilverTimelineEvent(
      {this.language = Language.ENGLISH, @required this.goldSilver});

  @override
  List<Object> get props => [language, goldSilver];
}

class RefreshGoldSilverTimelineEvent extends GoldSilverTimelineEvent {
  final Language language;
  final GoldSilverEntity goldSilver;

  RefreshGoldSilverTimelineEvent(
      {this.language = Language.ENGLISH, @required this.goldSilver});

  @override
  List<Object> get props => [language, goldSilver];
}
