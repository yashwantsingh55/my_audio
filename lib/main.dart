import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:my_audio/audio_palyer/audio_mini_player_warpper.dart';
import 'package:my_audio/home_screen.dart';
import 'package:my_audio/player/audio_player_controller.dart';

// Three main widget
// Audio controller on global level maintain session.
// 1. AudioPlayerWidget
// 3. AudioMiniPlayer
// 2. HighlightedSubtitle
// 4. MusicSlider

// handle the proper disposal of audio player

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            child!,
            const Positioned(
                bottom: 60, right: 0, left: 0, child: AudioMiniPlayerWrapper())
          ],
        );
      },
      home: const HomeScreen(),
      initialBinding: AudioPlayerControllerBinding(),
    );
  }
}
