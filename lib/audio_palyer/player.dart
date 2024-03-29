import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_audio/audio_palyer/wave_slider.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({
    super.key,
    required this.duration,
    required this.position,
    required this.playerState,
    required this.onPlay,
    required this.onSeek,
    required this.onForwardOrBackward,
  });

  final Duration duration;
  final Duration position;
  final PlayerState playerState;

  // function handler on play , pause, seek, stop
  final void Function()? onPlay;
  final void Function()? onForwardOrBackward;
  final dynamic Function(double) onSeek;

  bool get isPlaying => playerState == PlayerState.playing;
  bool get isPaused => playerState == PlayerState.paused;

  // utils
  String _formatDuration(Duration duration) {
    final hours = duration.inHours.remainder(60).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MusicSlider(
          boxSpace: 0.3,
          fillColors: const [Color(0xffAD3F24)],
          emptyColors: const [Colors.grey],
          height: 50,
          division: 60,
          onChanged: onSeek,
          sliderValue: (position.inMilliseconds > 0 &&
                  position.inMilliseconds < duration.inMilliseconds)
              ? position.inMilliseconds / duration.inMilliseconds
              : 0.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(position),
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              _formatDuration(duration),
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: IconButton(
                key: const Key('play_button'),
                onPressed: isPlaying ? null : onPlay,
                iconSize: 48.0,
                icon: Icon(Icons.play_arrow_rounded, color: color, size: 48),
                color: color,
              ),
            ),
            IconButton(
              key: const Key('pause_button'),
              onPressed: onPlay,
              iconSize: 48.0,
              icon: isPlaying
                  ? const Icon(Icons.pause_rounded)
                  : const Icon(Icons.play_arrow_rounded),
              color: color,
            ),
            IconButton(
              key: const Key('stop_button'),
              // onPressed: isPlaying || isPaused ? onPause : null,
              onPressed: () {},
              iconSize: 48.0,
              icon: Icon(Icons.play_arrow_rounded, color: color, size: 48),
              color: color,
            ),
          ],
        ),
      ],
    );
  }
}

// create widget mini audio player

class AudioMiniPlayer extends StatelessWidget {
  const AudioMiniPlayer({
    super.key,
    required this.duration,
    required this.position,
    required this.playerState,
    this.onPause,
    this.onPlay,
  });

  final Duration duration;
  final Duration position;
  final PlayerState playerState;

  final void Function()? onPlay;
  final void Function()? onPause;

  bool get isPlaying => playerState == PlayerState.playing;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 25,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFiFNp3oXpYvA9Lwqk3M-PQy25VWsWY6ZjuKi89i0lDQ&s',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Title',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          const Text('Location',
                              style: TextStyle(
                                  // color: darkBlue2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            width: 1,
                            height: 12,
                            color: Colors.purple,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          const SizedBox(width: 4),
                          // Image.asset('flag.png', height: 12, width: 12),
                          const Icon(Icons.flag, size: 16),
                          const SizedBox(width: 4),
                          const Text('3k Likes',
                              style: TextStyle(
                                  // color: darkBlue2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                ),

                // play and pause button
                OutlinedButton(
                  onPressed: onPlay,
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: const BorderSide(color: Colors.red, width: 2),
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: ((position.inMilliseconds > 0 &&
                    position.inMilliseconds < duration.inMilliseconds)
                ? position.inMilliseconds / duration.inMilliseconds
                : 0.0),
          ),
        ],
      ),
    );
  }
}
