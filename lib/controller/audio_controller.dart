import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/subtitle_highlight.dart';

// create binding for audio controller
class AudioControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioController>(() => AudioController(), fenix: true);
  }
}

class AudioController extends GetxController with StateMixin<dynamic> {
  late AudioPlayer _player;
  List<Subtitle> subtitles = [];
  var playerState = PlayerState.stopped.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  // getter for player
  AudioPlayer get player => _player;

  // getter for isPlaying
  bool get isPlaying => playerState.value == PlayerState.playing;

  @override
  void onInit() {
    super.onInit();

    // Start playing the audio when the controller is initialized.
    _playAudio();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  Future<void> _playAudio() async {
    _player = AudioPlayer();

    subtitles = generateSubtitles(
        'Welcome to the BAPS Hindu Mandir Abu Dhabi Welcome Centre! Explore Hindu traditions, engage with knowledgeable volunteers, and discover serenity in our vibrant cultural space. Begin ');

    // Load the audio file
    await _player.setSource(AssetSource('ambient_c_motion.mp3'));

    // Set the release mode to keep the source after playback has completed.
    _player.setReleaseMode(ReleaseMode.stop);

    // Start playing the audio
    await _player.resume();
    // Update player state
    playerState.value = _player.state;

    player.getDuration().then((value) {
      duration.value = value ?? Duration.zero;
      update();
    });

    player.getCurrentPosition().then((value) {
      position.value = value ?? Duration.zero;
    });

    // Listen for duration changes
    _player.onDurationChanged.listen((d) {
      duration.value = d;
      update();
    });
    // Listen for position changes
    _player.onPositionChanged.listen((p) {
      position.value = p;
      update();
    });
    // Listen for player state changes
    _player.onPlayerStateChanged.listen((s) {
      playerState.value = s;
      update();
    });
  }

  // function to genearte the subtitle text multiple time to make it longer but with continenour start and end time
  List<Subtitle> generateSubtitles(String text) {
    final List<Subtitle> subtitles = [];
    for (int i = 0; i < 50; i += 3) {
      subtitles.add(Subtitle(
          text: text,
          start: Duration(seconds: i),
          end: Duration(seconds: i + 3)));
    }
    return subtitles;
  }

  void play() async {
    await _player.resume();
    playerState.value = PlayerState.playing;
  }

  void pause() async {
    await _player.pause();
    playerState.value = PlayerState.paused;
  }

  void stop() async {
    await _player.stop();
    playerState.value = PlayerState.stopped;
    position.value = Duration.zero;
  }

  void seekTo(double value) {
    final durationValue = duration.value;
    final positionInMillis = (value * durationValue.inMilliseconds).round();
    _player.seek(Duration(milliseconds: positionInMillis));
  }
}
