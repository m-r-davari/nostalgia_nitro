import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/widgets/asphalt_widget.dart';
import 'package:nostalgia_nitro/controllers/car_controller.dart';
import 'package:nostalgia_nitro/widgets/car_widget.dart';
import 'package:nostalgia_nitro/utils/shared_pref.dart';
import 'package:nostalgia_nitro/widgets/count_down_widget.dart';

class RaceController extends GetxController {

  ScrollController scrollController = ScrollController();
  final carController = Get.find<CarController>();
  final sharePref = Get.find<SharedPrefUtil>();
  Rx<int> hiScore = 0.obs;
  RxList<AsphaltWidget> asphalts = <AsphaltWidget>[].obs;
  Rx<int> speed = 7520.obs; //16000
  Rx<bool> isNitroActive = false.obs;
  Rx<int> score = 0.obs;
  Rx<int> lap = 0.obs;
  Rx<int> armor = 4.obs;
  Rx<double> nitroPercent = 1.0.obs;
  RenderBox? tempNpcCar;
  Rx<bool> isCrashed = false.obs;
  static int asphaltDefLength = 5;//10

  void handleAsphalts() {
    //asphalts def setting was 10 (new is 5) :
    // 10 asphalt in init widget,
    // first if condition will check the 10*2 length, if(asphalt.length==20)=> clear asphalts, then return.
    // second if condition will check if(asphalt.isEmpty) will have for (0 to 10) to add new asphalts,then return.
    // then we will have for(0 to 10), and check the doubleLength -1 if condition (asphalt.length==19) in it.

    //print('--- handling asphalt --- offset : ${scrollController.offset} --- asphalt length : ${asphalts.length}');

    if (asphalts.length == 10) {
      asphalts.clear();
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      return;
    }

    if (asphalts.isEmpty) {
      lap.value += 1;
      //scrollController.jumpTo(scrollController.position.minScrollExtent);
      asphalts.add(AsphaltWidget(key: GlobalKey(), isLap: true, npcCarKeys: const []));
      asphalts.add(AsphaltWidget(key: GlobalKey(), npcCarKeys: generateMpcKeys()));

      // for (int i = 0; i < 5; i++) {
      //   if (i == 0) {
      //     asphalts.add(AsphaltWidget(key: GlobalKey(), isLap: true, npcCarKeys: const []));
      //   } else {
      //     asphalts.add(AsphaltWidget(
      //       key: GlobalKey(),
      //       npcCarKeys: generateMpcKeys(),
      //     ));
      //   }
      // }

      Future.delayed(Duration.zero, () {
        if (isNitroActive.value) {
          speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt();
        } else {
          speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
        }
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: speed.value), curve: Curves.linear);
      });
      return;
    }

    //for (int i = 0; i < 5; i++) {}

    if (asphalts.length == 9) {
      asphalts.add(AsphaltWidget(
        key: GlobalKey(),
        isLap: true,
        npcCarKeys: const [],
      ));
    } else {
      asphalts.add(AsphaltWidget(
        key: GlobalKey(),
        npcCarKeys: generateMpcKeys(),
      ));
    }


    Future.delayed(Duration.zero, () {
      if (isNitroActive.value) {
        speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt();
      } else {
        speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
      }
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: speed.value), curve: Curves.linear);
    });
  }

  void handleAccident() async {
    final asphaltsInShow = asphalts.where((element) => (element.key as GlobalKey).currentContext != null).toList();
    // print('scroll ---> ${scrollController.offset} --- $asphaltsInShow');
    final carsInshow = asphaltsInShow.expand<GlobalKey>((element) => element.npcCarKeys.where((element) => element.currentContext != null));
    // print('cars ---> len : ${carsInshow.length} --- $carsInshow');
    if(carsInshow.isEmpty){
      return;
    }
    final carsInCrashZone = carsInshow.where((element) {
      RenderBox npcCarBox = element.currentContext!.findRenderObject() as RenderBox;
      Offset npcCarPosition = npcCarBox.localToGlobal(Offset.zero);
      return npcCarPosition.dy + carHeight > 440 && npcCarPosition.dy + carHeight < 600;
    });
    // print('cars in crash zone ---> len : ${carsInCrashZone.length} --- $carsInCrashZone');

    if (carsInCrashZone.isNotEmpty) {
      RenderBox mainCarBox = carKey.currentContext!.findRenderObject() as RenderBox;
      Offset mainCarPosition = mainCarBox.localToGlobal(Offset.zero);
      for (final carInCrashZone in carsInCrashZone) {
        RenderBox npcCarBox = carInCrashZone.currentContext!.findRenderObject() as RenderBox;
        Offset mpcCarPosition = npcCarBox.localToGlobal(Offset.zero);
        // print('mpc size --- ${mpcCarBox.size} ---- dx : ${mpcCarPosition.dx}');
        // print('main size --- ${mainCarBox.size} ---- dx : ${mainCarPosition.dx}');
        if (mainCarPosition.dx.ceil() == mpcCarPosition.dx.ceil()) {
          double mainCarTop = mainCarPosition.dy;
          double mainCarBottom = mainCarPosition.dy + carHeight;
          double npcCarTop = mpcCarPosition.dy;
          double npcCarBottom = mpcCarPosition.dy + carHeight;
          if ((npcCarBottom >= mainCarTop && npcCarBottom <= mainCarBottom) || (npcCarTop >= mainCarTop && npcCarTop <= mainCarBottom)) {
            if (tempNpcCar != npcCarBox) {
              armor.value -= 1;
              if (armor.value == 0) {
                //print('**crashed**');
                isCrashed.value = true;
                scrollController.jumpTo(scrollController.offset);
                if (hiScore.value < score.value) {
                  sharePref.saveHiScore(score.value);
                  hiScore.value = score.value;
                }
                tempNpcCar = null;
                showCrashDialog();
                break;
              }
              tempNpcCar = npcCarBox;
            }
          }
        }
      }
    }
  }

  void calculateScores(){
    score.value += 1;
  }

  void handleNitro() async {
    if (isNitroActive.value && nitroPercent.value >= 0) {
      nitroPercent -= 0.0025;
    } else if (!isNitroActive.value && nitroPercent.value <= 1) {
      nitroPercent += 0.0025;
    } else if (isNitroActive.value && nitroPercent.value <= 0) {
      isNitroActive.value = false;
      speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: speed.value), curve: Curves.linear);
    }
  }

  List<GlobalKey> generateMpcKeys() {
    return List.generate(12, (index) => GlobalKey());
  }


  Future<void> resetGame()async{
    isNitroActive.value = false;
    isCrashed.value = false;
    speed.value = 7520;
    asphalts.clear();
    for (int i = 0; i < asphaltDefLength; i++) {
      if (i == 0) {
        asphalts.add(AsphaltWidget(key: GlobalKey(), isLap: true, npcCarKeys: const []));
      } else {
        asphalts.add(AsphaltWidget(
          key: GlobalKey(),
          npcCarKeys: generateMpcKeys(),
        ));
      }
    }
    await Future.delayed(Duration.zero,);
    score.value = 0;
    lap.value = 0;
    armor.value = 4;
    nitroPercent.value = 1;
    carController.carAlignment.value = Alignment.bottomCenter;
    scrollController.jumpTo(scrollController.position.minScrollExtent+0.1);
    await showCountDownDialog();
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: speed.value), curve: Curves.linear);
  }

  void moveLeft(){
    if (carController.carAlignment.value == Alignment.bottomLeft) {
      return;
    }
    if (carController.carAlignment.value == Alignment.bottomCenter) {
      carController.carAlignment.value = Alignment.bottomLeft;
    } else if (carController.carAlignment.value == Alignment.bottomRight) {
      carController.carAlignment.value = Alignment.bottomCenter;
    }
  }

  void moveRight(){
    if (carController.carAlignment.value == Alignment.bottomRight) {
      return;
    }
    if (carController.carAlignment.value == Alignment.bottomCenter) {
      carController.carAlignment.value = Alignment.bottomRight;
    } else if (carController.carAlignment.value == Alignment.bottomLeft) {
      carController.carAlignment.value = Alignment.bottomCenter;
    }
  }

  void activeNitro(){
    if (nitroPercent.value <= 0) {
      return;
    }
    isNitroActive.value = true;
    speed.value =
        ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt(); //10000
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: speed.value), curve: Curves.linear);
  }

  void deActiveNitro(){
    if (nitroPercent.value >= 1) {
      return;
    }
    isNitroActive.value = false;
    if(isCrashed.value){
      return;
    }
    speed.value =
        ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt(); //16000;
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: speed.value), curve: Curves.linear);
  }

  void showCrashDialog(){
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Oops!'),
            content: const Text('You have crashed 💥 , no worries its just a game 😉'),
            actions: [
              ElevatedButton(
                  onPressed: ()async{
                    Get.back();
                    await resetGame();
                  },
                  child: const Text('Retry')),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Text('Exit')),
            ],
          );
        });
  }


  Future<void> showCountDownDialog()async{
    return await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (ctx) {
          return CountDownWidget();
        });
  }



}
