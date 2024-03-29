import 'package:just_audio/just_audio.dart';

class AudioPlayerSingleton{

  late AudioPlayer _audioPlayer;
  AudioPlayerSingleton._(){
    _audioPlayer = AudioPlayer();
  }

  static final AudioPlayerSingleton _instance = AudioPlayerSingleton._();

  static final AudioPlayerSingleton instance = _instance;

  AudioPlayer get getAudioPlayer => _audioPlayer;

}