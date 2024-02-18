import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/widgets/car_widget.dart';
import 'package:nostalgia_nitro/widgets/tile_widget.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {

  late Timer _timer;
  int _second = 3;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 150,height: 140,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Get ready'),
              const SizedBox(height: 16,),
              generateCountDown(_second),
              const SizedBox(height: 14,),
              Text('$_second'),
            ],
          ) ,
        ),
      ),
    );
  }

  Widget generateCountDown(int second){
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isModern ? ClipOval(child: Container(color: second > 2 ? Colors.grey : Colors.green,width: 17,height: 17,),)
              : TileWidget(width: 17,height: 17,color: second > 2 ? Colors.grey : Colors.black,),
          const SizedBox(width: 4,),
          isModern ? ClipOval(child: Container(color: second > 1 ? Colors.grey : Colors.green,width: 17,height: 17,),)
              : TileWidget(width: 17,height: 17,color: second > 1 ? Colors.grey : Colors.black,),
          const SizedBox(width: 4,),
          isModern ? ClipOval(child: Container(color: second > 0 ? Colors.grey : Colors.green,width: 17,height: 17,),)
              : TileWidget(width: 17,height: 17,color: second > 0 ? Colors.grey : Colors.black,),
        ],
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_second == 0) {
          setState(() {
            timer.cancel();
            Get.back();
          });
        } else {
          setState(() {
            _second--;
          });
        }
      },
    );
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}
