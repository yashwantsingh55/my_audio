import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/audio_mini_player_warpper.dart';
import 'package:my_audio/controller/audio_controller.dart';
import 'package:my_audio/home_screen.dart';

// Three main widget
// Audio controller on global level maintain session.
// 1. AudioPlayerWidget
// 3. AudioMiniPlayer
// 2. HighlightedSubtitle
// 4. MusicSlider

// handle the proper disposal of audio player

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return Column(
          children: [Expanded(child: child!), const AudioMiniPlayerWrapper()],
        );
      },
      home: const HomeScreen(),
      initialBinding: AudioControllerBinding(),
    );
  }
}
