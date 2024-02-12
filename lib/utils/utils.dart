import 'dart:math';

import 'package:flutter/material.dart';

class Utils {

  static int generateRandomNumFromRange(int min, int max){
    return Random.secure().nextInt(max) + min ;
  }

  double generateUniqueRandomDouble(double min, double max) {
    // Create an instance of Random..
    final random = Random();

    // Create a set to store unique random doubles
    Set<double> uniqueNumbers = Set<double>();

    // Generate a unique random double
    double randomDouble;
    do {
      randomDouble = min + random.nextDouble() * (max - min);
    } while (!uniqueNumbers.add(randomDouble));

    // Return the unique random double.
    return randomDouble;
  }


  Color getRandomColor(){
    var generatedColor = Random().nextInt(Colors.primaries.length);
    return Colors.primaries[generatedColor];
  }

}