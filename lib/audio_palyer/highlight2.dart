import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HighlightedSubtitle2 extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final List<String> subtitles;

  const HighlightedSubtitle2({
    Key? key,
    required this.audioPlayer,
    required this.subtitles,
  }) : super(key: key);

  @override
  HighlightedSubtitleState createState() => HighlightedSubtitleState();
}

class HighlightedSubtitleState extends State<HighlightedSubtitle2> {
  Timer? _timer;
  int _currentIndex = 0;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    widget.audioPlayer.positionStream.listen((position) {
      final intervalInSeconds =
          widget.audioPlayer.duration!.inSeconds / widget.subtitles.length;
      final interval = Duration(seconds: intervalInSeconds.round());
      final newIndex = position.inSeconds ~/ interval.inSeconds;
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
          scrollController.animateTo(
            _currentIndex * 100.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      controller: scrollController,
      itemCount: widget.subtitles.length,
      itemBuilder: (context, index) {
        final subtitle = widget.subtitles[index];
        return GestureDetector(
          onTap: () => widget.audioPlayer.seek(Duration(seconds: index)),
          child: ListTile(
            subtitle: Text(
              index.toString(),
            ),
            title: Text(
              subtitle,
              style: index == _currentIndex
                  ? const TextStyle(color: Colors.red)
                  : null,
            ),
          ),
        );
      },
    );
  }
}
