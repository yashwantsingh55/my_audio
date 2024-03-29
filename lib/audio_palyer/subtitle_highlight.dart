import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Subtitle {
  final String text;
  final Duration start;
  final Duration end;

  Subtitle({required this.text, required this.start, required this.end});
}

class HighlightedSubtitle extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final List<Subtitle> subtitles;

  const HighlightedSubtitle(
      {Key? key, required this.audioPlayer, required this.subtitles})
      : super(key: key);

  @override
  HighlightedSubtitleState createState() => HighlightedSubtitleState();
}

class HighlightedSubtitleState extends State<HighlightedSubtitle> {
  late Stream<Duration> positionStream;
  late Subtitle currentSubtitle;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    positionStream = widget.audioPlayer.onPositionChanged;
    currentSubtitle = widget.subtitles[0];
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: positionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Duration position = snapshot.data!;
          for (int i = 0; i < widget.subtitles.length; i++) {
            Subtitle subtitle = widget.subtitles[i];
            if (position >= subtitle.start &&
                position <= subtitle.end &&
                subtitle != currentSubtitle) {
              currentSubtitle = subtitle;
              scrollController.animateTo(
                i * 100.0, // 56.0 is the height of a ListTile
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
              break;
            }
          }
        }
        return Scrollbar(
          controller: scrollController,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 4,
            ),
            controller: scrollController,
            itemCount: widget.subtitles.length,
            itemBuilder: (context, index) {
              final subtitle = widget.subtitles[index];
              return GestureDetector(
                onTap: () => widget.audioPlayer
                    .seek(subtitle.start - const Duration(seconds: 1)),
                child: SizedBox(
                  height: 100,
                  child: ListTile(
                    title: Text(
                      subtitle.text,
                      style: subtitle == currentSubtitle
                          ? const TextStyle(color: Colors.red)
                          : null,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
