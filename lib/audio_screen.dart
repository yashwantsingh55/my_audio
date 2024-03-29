import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/player.dart';
import 'package:my_audio/audio_palyer/subtitle_highlight.dart';
import 'package:my_audio/controller/audio_controller.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Player with Subtitles'),
        ),
        body: Column(
          children: [
            // Image.network(
            //     'https://images.unsplash.com/photo-1630484163294-4b3b3b3b3b3b'),
            Expanded(
              child: HighlightedSubtitle(
                  audioPlayer: controller.player,
                  subtitles: controller.subtitles),
            ),
            // player able to play audio, pause audio, seek audio, forward and backward audio
            AudioPlayerWidget(
              duration: controller.duration.value,
              position: controller.position.value,
              playerState: controller.playerState.value,
              onPlay: () => controller.playerState.value != PlayerState.playing
                  ? controller.play()
                  : controller.pause(),
              onSeek: (value) => controller.seekTo(value),
              onForwardOrBackward: () {},
            )
          ],
        ),
      );
    });
  }
}
