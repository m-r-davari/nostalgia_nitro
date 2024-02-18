
import 'package:get/get.dart';
import 'package:nostalgia_nitro/controllers/car_controller.dart';
import 'package:nostalgia_nitro/utils/shared_pref.dart';
import 'package:nostalgia_nitro/controllers/race_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppBindings extends Bindings {

  @override
  Future<void> dependencies() async {
    await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);
    Get.put<SharedPrefUtil>(SharedPrefUtil(Get.find<SharedPreferences>()),permanent: true);
  }


}