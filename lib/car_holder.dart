import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/car_controller.dart';
import 'package:nostalgia_nitro/car_widget.dart';
import 'package:nostalgia_nitro/race_controller.dart';

class CarHolder extends GetWidget<CarController> {

  const CarHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Align(alignment: controller.carAlignment.value,child: CarWidget(carColor: Colors.blueAccent,key: carKey,),));
  }

}
