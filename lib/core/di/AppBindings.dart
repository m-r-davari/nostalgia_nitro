
import 'package:get/get.dart';
import 'package:nostalgia_nitro/car_controller.dart';
import 'package:nostalgia_nitro/utils/shared_pref.dart';
import 'package:nostalgia_nitro/race_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppBindings extends Bindings {

  @override
  Future<void> dependencies() async {
    await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);
    Get.put<SharedPrefUtil>(SharedPrefUtil(Get.find<SharedPreferences>()),permanent: true);
    Get.put<CarController>(CarController(),permanent: true);
  }


}