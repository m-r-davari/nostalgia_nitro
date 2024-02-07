import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/asphalt_widget.dart';
import 'package:nostalgia_nitro/car_widget.dart';

class RaceController extends GetxController {

  RxList<Widget> asphalts = <Widget>[].obs;
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
          asphalts.add(Container(width: 230, height: 470,color: const Color(0xffEDEDED),alignment: Alignment.center,child: const Text('SSSSSSSSS',style: TextStyle(fontSize: 20),),));
        }
        else{
          asphalts.add(AsphaltWidget(mpcCarKeys: generateMpcKeys(),));
        }
      }
      Future.delayed(Duration.zero,(){
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: scrollSpeed.value), curve: Curves.linear);
      });
      return;
    }

    for(int i = 0 ; i < 10 ; i++){
      //asphalts.add(AsphaltWidget(key: UniqueKey(),));
      if(asphalts.length==19){
        asphalts.add(Container(width: 230, height: 470,color: const Color(0xffEDEDED),child: const Text('Resampeling'),alignment: Alignment.center,));
      }
      else{
        asphalts.add(AsphaltWidget(mpcCarKeys: generateMpcKeys(),));
      }
    }
    Future.delayed(Duration.zero,(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: scrollSpeed.value), curve: Curves.linear);
    });

  }

  void handleAccident(ScrollController scrollController){

    // //print('scroll ---> ${scrollController.position}');
    // RenderBox mainCarBox = carKey.currentContext!.findRenderObject() as RenderBox;
    // Offset mainCarPosition = mainCarBox.localToGlobal(Offset.zero);
    //
    // //find mpcCar that is in crash zone
    //
    // RenderBox mpcCarBox = carKey3.currentContext!.findRenderObject() as RenderBox;
    // Offset mpcCarPosition = mpcCarBox.localToGlobal(Offset.zero);
    //
    // // print('---car position---- $mainCarPosition');
    // // print('---mpc car position---- $mpcCarPosition');
    //
    // if(mainCarPosition.dx==mpcCarPosition.dx){//
    //   double mainCarTop = mainCarPosition.dy;
    //   double mainCarBottom = mainCarPosition.dy + carHeight;
    //   double mpcCarTop = mpcCarPosition.dy;
    //   double mpcCarBottom = mpcCarPosition.dy + carHeight;
    //   if((mpcCarBottom >= mainCarTop && mpcCarBottom <= mainCarBottom) || (mpcCarTop >= mainCarTop && mpcCarTop <= mainCarBottom)){
    //     print('**crashed**');
    //   }
    // }

  }


  List<GlobalKey> generateMpcKeys(){
    return List.generate(12, (index) => GlobalKey());
  }


}