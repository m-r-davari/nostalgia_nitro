import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/controllers/car_controller.dart';
import 'package:nostalgia_nitro/core/di/app_bindings.dart';
import 'package:nostalgia_nitro/pages/home_page.dart';
import 'package:nostalgia_nitro/controllers/race_controller.dart';
import 'package:nostalgia_nitro/pages/race_page.dart';
import 'package:nostalgia_nitro/pages/splash_page.dart';

void main() {
  AppBindings appBindings = AppBindings();
  runApp(MyApp(
    appBindings: appBindings,
  ));
}

class MyApp extends StatelessWidget {
  final AppBindings appBindings;

  const MyApp({super.key, required this.appBindings});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: "/home_page",
          page: () => const HomePage(),
          transition: Transition.fade,
        ),
        GetPage(
          name: "/race_page",
          page: () => const RacePage(),
          transition: Transition.fade,
          binding: BindingsBuilder(
            () {
              Get.put(CarController());
              Get.put(RaceController());
            },
          ),
        ),
        GetPage(
          name: "/splash_page",
          page: () => const SplashPage(),
          transition: Transition.fade,
        ),
      ],
      initialRoute: "/splash_page",
      initialBinding: appBindings,
    );
  }
}
