import 'package:flutter/material.dart';
import 'package:mypaws/src/pages/feed/found%20pet/found_pet_feed_controller.dart';
import 'package:get/get.dart';

class FoundPetFeed extends GetView<FoundPetController> {
  const FoundPetFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                  Text("Found Pet Feed"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}