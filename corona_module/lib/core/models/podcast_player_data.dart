import 'package:flutter/material.dart';

import 'podcast.dart';

class PodcastPlayerData {
  double speed;
  final Duration duration;
  final Podcast currentPodcast;
  final Stream<bool> isPlaying;
  final Stream<Duration> currentPosition;

  PodcastPlayerData({
    @required this.speed,
    @required this.duration,
    @required this.currentPodcast,
    @required this.isPlaying,
    @required this.currentPosition,
  })  : assert(speed != null),
        assert(duration != null),
        assert(currentPodcast != null),
        assert(isPlaying != null),
        assert(currentPosition != null);

  List<double> get speedValues =>
      const [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  PodcastPlayerData copyWith({
    double speed,
    Duration duration,
    Podcast currentPodcast,
    Stream<bool> isPlaying,
    Stream<Duration> currentPosition,
  }) {
    return PodcastPlayerData(
      speed: speed ?? this.speed,
      duration: duration ?? this.duration,
      currentPodcast: currentPodcast ?? this.currentPodcast,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  @override
  String toString() {
    return 'PodcastPlayerData(currentPodcast: $currentPodcast, speed: $speed, duration: $duration, isPlaying: $isPlaying, currentPosition: $currentPosition)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PodcastPlayerData &&
        o.speed == speed &&
        o.duration == duration &&
        o.currentPodcast == currentPodcast &&
        o.isPlaying == isPlaying &&
        o.currentPosition == currentPosition;
  }

  @override
  int get hashCode {
    return currentPodcast.hashCode ^
        speed.hashCode ^
        duration.hashCode ^
        isPlaying.hashCode ^
        currentPosition.hashCode;
  }
}
