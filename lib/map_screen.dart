import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_audio/location_detail_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.to(() => const LocationDetailScreen());
        },
        child: const Text(
          'Navigate to LocationDetailScreen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
