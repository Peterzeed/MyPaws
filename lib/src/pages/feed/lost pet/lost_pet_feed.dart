import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypaws/src/pages/feed/lost%20pet/lost_pet_controller.dart';

class LostPetFeed extends GetView<LostPetController> {
  const LostPetFeed({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
                Text("Lost Pet Feed"),
            ],
          ),
        ),
      ),
    );
  }
}