import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_palyer/player.dart';
import 'package:my_audio/audio_palyer/subtitle_highlight.dart';
import 'package:my_audio/player/audio_player_controller.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioPlayerController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Player with Subtitles'),
        ),
        body: Column(
          children: [
            // Image.network(
            //     'https://images.unsplash.com/photo-1630484163294-4b3b3b3b3b3b'),
            // Expanded(
            //   child: HighlightedSubtitle(
            //       audioPlayer: controller.player,
            //       subtitles: controller.subtitles),
            // ),
            // player able to play audio, pause audio, seek audio, forward and backward audio
            Expanded(
              child: HighlightedSubtitle(
                  audioPlayer: controller.player,
                  subtitles: controller.subtitles),
            ),
            AudioPlayerWidget(
              isPlaying: controller.player.playing,
              duration: controller.duration.value,
              position: controller.position.value,
              playerState: controller.playerState.value,
              onPlay: () => controller.player.playing
                  ? controller.pauseAudio()
                  : controller.playAudio(),
              onSeek: (value) => controller.seekAudio(value),
              onBackward: () => controller.previousAudio(),
              onForward: () => controller.nextAudio(),
            )
          ],
        ),
      );
    });
  }
}
