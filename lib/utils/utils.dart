import 'dart:math';

import 'package:flutter/material.dart';

class Utils {

  static final Utils instance = Utils._();
  Utils._();
  final Random _random = Random();

  int getRandomNumFromRange(int min, int max) => min + _random.nextInt((max+1) - min);//

  bool getRandomBool() {
    final num = _random.nextInt(1);
    if(num==0){
      return false;
    }
    else{
      return true;
    }
  }

  Color getRandomColor(){
    var generatedColor = _random.nextInt(Colors.primaries.length);
    return Colors.primaries[generatedColor];
  }

}