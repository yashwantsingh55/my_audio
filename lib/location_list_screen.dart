import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/audio_screen.dart';

class LocationListScreen extends StatelessWidget {
  final List<String> locations = [
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4',
    'Location 5',
    'Location 6',
    'Location 7',
    'Location 8',
    'Location 9',
    // Add more locations as needed
  ];

  LocationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(() => const AudioScreen(),
                  transition: Transition.downToUp);
            },
            title: Text(locations[index]),
            trailing: const Icon(Icons.play_arrow),
          );
        },
      ),
    );
  }
}
