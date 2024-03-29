import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioMiniPlayer extends StatelessWidget {
  final String title;
  final String location;
  final String likes;
  final AudioPlayer player;

  const AudioMiniPlayer({
    super.key,
    required this.player,
    required this.title,
    required this.location,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 25,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? 'Title'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(location ?? 'Location'),
                    Container(
                      width: 1,
                      height: 12,
                      color: Colors.purple,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    const SizedBox(width: 4),
                    Image.asset('flag.png', height: 12, width: 12),
                    const SizedBox(width: 4),
                    Text(likes ?? '3k Likes'),
                  ],
                )
              ],
            ),
          ),

          // play and pause button
          OutlinedButton(
            onPressed: () {
              if (player.state == PlayerState.playing) {
                player.pause();
              } else {
                player.resume();
              }
            },
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: const BorderSide(color: Colors.blue, width: 2),
            ),
            child: player.state == PlayerState.playing
                ? const Icon(
                    Icons.pause,
                    color: Colors.blue,
                  )
                : const Icon(
                    Icons.play_arrow,
                    color: Colors.blue,
                  ),
          ),
        ],
      ),
    );
  }
}
