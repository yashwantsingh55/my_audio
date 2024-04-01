import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_screen.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Detail'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Get.to(() => const AudioScreen());
        },
        child: const Text('Play Audio'),
      )),
    );
  }
}
