// create statelss widget MiniPlayer

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/player.dart';
import 'package:my_audio/audio_screen.dart';
import 'package:my_audio/controller/audio_controller.dart';

class AudioMiniPlayerWrapper extends StatelessWidget {
  const AudioMiniPlayerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (controller) {
      return Material(
        child: GestureDetector(
          onTap: () {
            Get.to(() => const AudioScreen());
          },
          child: AudioMiniPlayer(
            duration: controller.duration.value,
            position: controller.position.value,
            playerState: controller.playerState.value,
            onPlay: () {
              if (controller.playerState.value != PlayerState.playing) {
                controller.play();
              } else {
                controller.pause();
              }
            },
          ),
        ),
      );
    });
  }
}
