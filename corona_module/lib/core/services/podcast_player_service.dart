import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

import '../models/app_error.dart';
import '../models/podcast.dart';
import '../models/podcast_player_data.dart';

class PodcastPlayerService {
  static const String PLAYER_ID = 'podcast_player';

  AssetsAudioPlayer _player;

  PodcastPlayerData _state;
  PodcastPlayerData get state => _state;

  Future<void> init(Podcast podcast) async {
    _player = AssetsAudioPlayer.withId(PLAYER_ID);

    try {
      await _player.open(
        Audio.network(
          podcast.audioUrl,
          metas: Metas(
            title: podcast.title,
            artist: podcast.source,
            image: MetasImage.network(podcast.imageUrl),
          ),
        ),
        playSpeed: 1.0,
        autoStart: true,
        showNotification: false,
        respectSilentMode: false,
      );
    } catch (e) {
      print(e.toString());
      throw AppError(message: 'Couldn\'t play ${podcast.title}.');
    }

    _state = PodcastPlayerData(
      speed: 1.0,
      duration: _player.current.value.audio.duration,
      currentPodcast: podcast,
      isPlaying: _player.isPlaying,
      currentPosition: _player.currentPosition,
    );
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
    _player.dispose();
  }

  Future<void> seekTo(Duration duration) async {
    await _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    state.speed = speed;
    await _player.setPlaySpeed(speed);
  }
}
