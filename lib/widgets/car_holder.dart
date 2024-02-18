import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/controllers/car_controller.dart';
import 'package:nostalgia_nitro/widgets/car_widget.dart';
import 'package:nostalgia_nitro/controllers/race_controller.dart';

class CarHolder extends GetWidget<CarController> {
  const CarHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: controller.focusNode,
      autofocus: true,
      onKeyEvent: controller.handleKeyPressed,
      child: Obx(
        () => Align(
          alignment: controller.carAlignment.value,
          child: CarWidget(
            carColor: Colors.blueAccent,
            key: carKey,
            isNpc: false,
          ),
        ),
      ),
    );
  }
}
