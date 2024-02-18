import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nostalgia_nitro/controllers/race_controller.dart';

class CarController extends GetxController {

  late RaceController raceController;
  Rx<Alignment> carAlignment = Alignment.bottomCenter.obs;
  final FocusNode focusNode = FocusNode();

  @override
  void onReady() {
    raceController = Get.find<RaceController>();
  }

  handleKeyPressed(KeyEvent event) {

    //print(' ---- key event --- $event -- ${event.logicalKey == LogicalKeyboardKey.space} --');
    if(event.logicalKey == LogicalKeyboardKey.space){
      if (event is KeyDownEvent) {
        raceController.activeNitro();
      }
      else if(event is KeyUpEvent){
        raceController.deActiveNitro();
      }
    }

    if(event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.arrowLeft){
      raceController.moveLeft();
    }

    if(event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.arrowRight){
      raceController.moveRight();
    }

  }



}