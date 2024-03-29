// create statelss widget MiniPlayer

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/player.dart';
import 'package:my_audio/controller/audio_controller.dart';

class AudioMiniPlayerWrapper extends StatelessWidget {
  const AudioMiniPlayerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (controller) {
      return Material(
        child: GestureDetector(
          onTap: () {
            // Get.to(() => const AudioScreen(),);

            debugPrint("Current Page :- ${Get.currentRoute}");
          },
          child: (Get.currentRoute == '/AudioScreen')
              ? const SizedBox.shrink()
              : AudioMiniPlayer(
                  duration: controller.duration.value,
                  position: controller.position.value,
                  playerState: controller.playerState.value,
                  onPlay: () => controller.isPlaying
                      ? controller.pause()
                      : controller.play(),
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
