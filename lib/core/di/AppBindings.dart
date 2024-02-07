
import 'package:get/get.dart';
import 'package:nostalgia_nitro/car_controller.dart';
import 'package:nostalgia_nitro/race_controller.dart';

class AppBindings extends Bindings {

  @override
  Future<void> dependencies() async {
    Get.put<RaceController>(RaceController(),permanent: true);
    Get.put<CarController>(CarController(),permanent: true);
  }


}