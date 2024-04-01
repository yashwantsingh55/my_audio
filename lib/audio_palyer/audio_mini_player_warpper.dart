// create statelss widget MiniPlayer

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/player.dart';

import '../player/audio_player_controller.dart';

class AudioMiniPlayerWrapper extends StatelessWidget {
  const AudioMiniPlayerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioPlayerController>(builder: (controller) {
      return Material(
        child: GestureDetector(
          onTap: () {
            // Get.to(() => const AudioScreen(),);
            debugPrint("Current Page :- ${Get.currentRoute}");
          },
          child: (Get.currentRoute == '/AudioScreen')
              ? const SizedBox.shrink()
              : AudioMiniPlayer(
                  isPlaying: controller.player.playing,
                  duration: controller.duration.value,
                  position: controller.position.value,
                  playerState: controller.playerState.value,
                  onPlay: () => controller.player.playing
                      ? controller.pauseAudio()
                      : controller.playAudio(),
                  // need to slide the from bottom to top
                ).animate().slideY(
                  begin: 1.0,
                  end: 0.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn),
        ),
      );
    });
  }
}
