import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsEntity extends Equatable {
  final bool useDarkMode;
  final bool usePitchBlack;
  final bool themeSetBySystem;
  final int newsReadMode;
  final bool showDailyMorningNews;
  final bool showDailyMorningHoroscope;
  final bool trendingNotifications;
  final bool commentNotifications;
  final bool messageNotifications;
  final bool otherNotifications;
  final bool newsNotifications;
  final String defaultForexCurrency;
  final int defaultHoroscopeSign;
  SettingsEntity({
    @required this.useDarkMode,
    @required this.usePitchBlack,
    @required this.themeSetBySystem,
    @required this.newsReadMode,
    @required this.showDailyMorningNews,
    @required this.showDailyMorningHoroscope,
    @required this.trendingNotifications,
    @required this.commentNotifications,
    @required this.messageNotifications,
    @required this.otherNotifications,
    @required this.newsNotifications,
    @required this.defaultForexCurrency,
    @required this.defaultHoroscopeSign,
  });

  @override
  List<Object> get props {
    return [
      useDarkMode,
      usePitchBlack,
      themeSetBySystem,
      newsReadMode,
      showDailyMorningNews,
      showDailyMorningHoroscope,
      trendingNotifications,
      commentNotifications,
      messageNotifications,
      otherNotifications,
      newsNotifications,
      defaultForexCurrency,
      defaultHoroscopeSign,
    ];
  }

  SettingsEntity copyWith({
    bool useDarkMode,
    bool usePitchBlack,
    bool themeSetBySystem,
    int newsReadMode,
    bool showDailyMorningNews,
    bool showDailyMorningHoroscope,
    bool trendingNotifications,
    bool commentNotifications,
    bool messageNotifications,
    bool otherNotifications,
    bool newsNotifications,
    String defaultForexCurrency,
    int defaultHoroscopeSign,
  }) {
    return SettingsEntity(
      useDarkMode: useDarkMode ?? this.useDarkMode,
      usePitchBlack: usePitchBlack ?? this.usePitchBlack,
      themeSetBySystem: themeSetBySystem ?? this.themeSetBySystem,
      newsReadMode: newsReadMode ?? this.newsReadMode,
      showDailyMorningNews: showDailyMorningNews ?? this.showDailyMorningNews,
      showDailyMorningHoroscope:
          showDailyMorningHoroscope ?? this.showDailyMorningHoroscope,
      trendingNotifications:
          trendingNotifications ?? this.trendingNotifications,
      commentNotifications: commentNotifications ?? this.commentNotifications,
      messageNotifications: messageNotifications ?? this.messageNotifications,
      otherNotifications: otherNotifications ?? this.otherNotifications,
      newsNotifications: newsNotifications ?? this.newsNotifications,
      defaultForexCurrency: defaultForexCurrency ?? this.defaultForexCurrency,
      defaultHoroscopeSign: defaultHoroscopeSign ?? this.defaultHoroscopeSign,
    );
  }

  @override
  bool get stringify => true;
}
