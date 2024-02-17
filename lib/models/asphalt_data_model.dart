import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/utils/utils.dart';

class AsphaltDataModel {

  List<int> mpcCarindexes = List<int>.filled(12, 0,growable: false);
  Color color;

  AsphaltDataModel.generate({this.color = Colors.black}){
    List<int> mpcCarsIndex = [];
    mpcCarsIndex.add(Utils.instance.getRandomNumFromRange(0, 2));
    mpcCarsIndex.add(Utils.instance.getRandomNumFromRange(3, 5));
    mpcCarsIndex.add(Utils.instance.getRandomNumFromRange(6, 8));
    mpcCarsIndex.add(Utils.instance.getRandomNumFromRange(9, 11));

    for(int i = 0 ; i < 12 ; i++){
      if(mpcCarsIndex.contains(i)){
        mpcCarindexes[i] = 1;
      }
      else{
        mpcCarindexes[i] = 0;
      }
    }

  }

}