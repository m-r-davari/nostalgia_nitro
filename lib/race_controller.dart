import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/asphalt_widget.dart';
import 'package:nostalgia_nitro/car_widget.dart';

class RaceController extends GetxController {

  RxList<AsphaltWidget> asphalts = <AsphaltWidget>[].obs;
  Rx<int> scrollSpeed = 16000.obs;

  void handleAsphalts(var scrollController){

   // print('--- adding new asphalt --- ${scrollController.offset} --- asphalt length : ${asphalts.length}');


    if(asphalts.length == 20){
      asphalts.clear();
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      print('--- removing as-l -- : ${asphalts.length}');
      return;
    }


    if(asphalts.isEmpty){
      print('------ refull---------');
      scrollController.jumpTo(scrollController.position.minScrollExtent);
      for(int i = 0 ; i < 10 ; i++){
        if(i==0){
          //asphalts.add(Container(width: 230, height: 470,color: const Color(0xffEDEDED),alignment: Alignment.center,child: const Text('SSSSSSSSS',style: TextStyle(fontSize: 20),),));
          asphalts.add(AsphaltWidget(key: GlobalKey(),isEmpty: true,mpcCarKeys: [],));
        }
        else{
          asphalts.add(AsphaltWidget(key: GlobalKey(),mpcCarKeys: generateMpcKeys(),));
        }
      }
      Future.delayed(Duration.zero,(){
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: scrollSpeed.value), curve: Curves.linear);
      });
      return;
    }

    for(int i = 0 ; i < 10 ; i++){
      if(asphalts.length==19){
        //asphalts.add(Container(width: 230, height: 470,color: const Color(0xffEDEDED),child: const Text('Resampeling'),alignment: Alignment.center,));
        asphalts.add(AsphaltWidget(key: GlobalKey(),isEmpty: true,mpcCarKeys: [],));
      }
      else{
        asphalts.add(AsphaltWidget(key: GlobalKey(),mpcCarKeys: generateMpcKeys(),));
      }
    }
    Future.delayed(Duration.zero,(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: scrollSpeed.value), curve: Curves.linear);
    });

  }

  void handleAccident(ScrollController scrollController)async{

    final asphaltsInShow = asphalts.where((element) =>  (element.key as GlobalKey).currentContext!= null).toList();
    print('scroll ---> ${scrollController.offset} --- $asphaltsInShow');
    final carsInshow = asphaltsInShow.expand<GlobalKey>((element) => element.mpcCarKeys.where((element) => element.currentContext!=null));
    print('cars ---> len : ${carsInshow.length} --- $carsInshow');
    final carsInCrashZone = carsInshow.where((element) {
      RenderBox mpcCarBox = element.currentContext!.findRenderObject() as RenderBox;
      Offset mpcCarPosition = mpcCarBox.localToGlobal(Offset.zero);
      return mpcCarPosition.dy + carHeight > 440 && mpcCarPosition.dy + carHeight < 600;
    });
    print('cars in crash zone ---> len : ${carsInCrashZone.length} --- $carsInCrashZone');

    if (carsInCrashZone.isNotEmpty){
      RenderBox mainCarBox = carKey.currentContext!.findRenderObject() as RenderBox;
      Offset mainCarPosition = mainCarBox.localToGlobal(Offset.zero);
      for(final carInCrashZone in carsInCrashZone){
        RenderBox mpcCarBox = carInCrashZone.currentContext!.findRenderObject() as RenderBox;
        Offset mpcCarPosition = mpcCarBox.localToGlobal(Offset.zero);
        if(mainCarPosition.dx==mpcCarPosition.dx){
          double mainCarTop = mainCarPosition.dy;
          double mainCarBottom = mainCarPosition.dy + carHeight;
          double mpcCarTop = mpcCarPosition.dy;
          double mpcCarBottom = mpcCarPosition.dy + carHeight;
          if((mpcCarBottom >= mainCarTop && mpcCarBottom <= mainCarBottom) || (mpcCarTop >= mainCarTop && mpcCarTop <= mainCarBottom)){
            print('**crashed**');
            scrollController.jumpTo(scrollController.offset);
            break;
          }
        }
      }

    }


  }


  List<GlobalKey> generateMpcKeys(){
    return List.generate(12, (index) => GlobalKey());
  }


}