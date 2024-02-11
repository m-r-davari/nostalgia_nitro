import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/asphalt_widget.dart';
import 'package:nostalgia_nitro/car_widget.dart';
import 'package:nostalgia_nitro/core/shared_pref.dart';

class RaceController extends GetxController {

  final sharePref = Get.find<SharedPrefUtil>();
  Rx<int> hiScore = 0.obs;
  RxList<AsphaltWidget> asphalts = <AsphaltWidget>[].obs;
  Rx<int> speed = 16000.obs;
  Rx<bool> isNitroActive = false.obs;
  Rx<int> score = 0.obs;
  Rx<int> lap = 0.obs;
  Rx<int> armor = 4.obs;
  Rx<double> nitroPercent = 1.0.obs;
  RenderBox? tempNpcCar;

  void handleAsphalts(ScrollController scrollController){

   // print('--- adding new asphalt --- ${scrollController.offset} --- asphalt length : ${asphalts.length}');


    if(asphalts.length == 20){
      asphalts.clear();
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      //print('--- removing as-l -- : ${asphalts.length}');
      return;
    }


    if(asphalts.isEmpty){
      //print('------ refull---------');
      lap.value += 1;
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      for(int i = 0 ; i < 10 ; i++){
        if(i==0){
          asphalts.add(AsphaltWidget(key: GlobalKey(),isEmpty: true,npcCarKeys: [],));
        }
        else{
          asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: generateMpcKeys(),));
        }
      }
      Future.delayed(Duration.zero,(){
        if(isNitroActive.value){
          speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt();
        }
        else{
          speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
        }
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: speed.value), curve: Curves.linear);
      });
      return;
    }

    for(int i = 0 ; i < 10 ; i++){
      if(asphalts.length==19){
        asphalts.add(AsphaltWidget(key: GlobalKey(),isEmpty: true,npcCarKeys: [],));
      }
      else{
        asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: generateMpcKeys(),));
      }
    }
    Future.delayed(Duration.zero,(){
      if(isNitroActive.value){
        speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt();
      }
      else{
        speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
      }
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: speed.value), curve: Curves.linear);
    });

  }

  void handleAccident(ScrollController scrollController)async{

    final asphaltsInShow = asphalts.where((element) =>  (element.key as GlobalKey).currentContext!= null).toList();
    // print('scroll ---> ${scrollController.offset} --- $asphaltsInShow');
    final carsInshow = asphaltsInShow.expand<GlobalKey>((element) => element.npcCarKeys.where((element) => element.currentContext!=null));
    // print('cars ---> len : ${carsInshow.length} --- $carsInshow');
    final carsInCrashZone = carsInshow.where((element) {
      RenderBox npcCarBox = element.currentContext!.findRenderObject() as RenderBox;
      Offset npcCarPosition = npcCarBox.localToGlobal(Offset.zero);
      return npcCarPosition.dy + carHeight > 440 && npcCarPosition.dy + carHeight < 600;
    });
    // print('cars in crash zone ---> len : ${carsInCrashZone.length} --- $carsInCrashZone');

    if (carsInCrashZone.isNotEmpty){
      RenderBox mainCarBox = carKey.currentContext!.findRenderObject() as RenderBox;
      Offset mainCarPosition = mainCarBox.localToGlobal(Offset.zero);
      for(final carInCrashZone in carsInCrashZone){
        RenderBox npcCarBox = carInCrashZone.currentContext!.findRenderObject() as RenderBox;
        Offset mpcCarPosition = npcCarBox.localToGlobal(Offset.zero);
        // print('mpc size --- ${mpcCarBox.size} ---- dx : ${mpcCarPosition.dx}');
        // print('main size --- ${mainCarBox.size} ---- dx : ${mainCarPosition.dx}');
        if(mainCarPosition.dx.ceil()==mpcCarPosition.dx.ceil()){
          double mainCarTop = mainCarPosition.dy;
          double mainCarBottom = mainCarPosition.dy + carHeight;
          double npcCarTop = mpcCarPosition.dy;
          double npcCarBottom = mpcCarPosition.dy + carHeight;
          if((npcCarBottom >= mainCarTop && npcCarBottom <= mainCarBottom) || (npcCarTop >= mainCarTop && npcCarTop <= mainCarBottom)){
            if(tempNpcCar!=npcCarBox){
              armor.value -= 1;
              if(armor.value==0){
                print('**crashed**');
                scrollController.jumpTo(scrollController.offset);
                if(hiScore.value < score.value){
                  sharePref.saveHiScore(score.value);
                }
                tempNpcCar = null;
                break;
              }
              tempNpcCar = npcCarBox;
            }

          }
        }
      }

    }


  }

  void calculateScores(ScrollController scrollController)async{
    score.value += 1;
  }

  void handleNitro(ScrollController scrollController)async{
    if(isNitroActive.value && nitroPercent.value >= 0){
      nitroPercent -= 0.0025;
    }
    else if(!isNitroActive.value && nitroPercent.value <= 1){
      nitroPercent += 0.0025;
    }
    else if(isNitroActive.value && nitroPercent.value <= 0){
      isNitroActive.value = false;
      speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: speed.value), curve: Curves.linear);
    }
  }

  List<GlobalKey> generateMpcKeys(){
    return List.generate(12, (index) => GlobalKey());
  }


}