import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/widgets/tile_widget.dart';
import 'package:nostalgia_nitro/utils/utils.dart';
import 'car_widget.dart';
import 'dart:math' as math;

class AsphaltWidget extends StatelessWidget {
  final List<GlobalKey> npcCarKeys;
  final bool isLap;

  const AsphaltWidget({Key? key, required this.npcCarKeys, this.isLap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 470,
      color: const Color(0xffEDEDED),
      child: Stack(
        children: [
          Row(
            children: [
              isModern ? generateModernSide() : generateSide(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  //color: Colors.red.withOpacity(0.5),
                  height: double.infinity,
                  child: isLap
                      ? const SizedBox()
                      : GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 3,
                          crossAxisSpacing: 15, //10
                          mainAxisSpacing: 15, //10
                          childAspectRatio: 0.75,
                          children: generateCars(),
                        ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              isModern ? generateModernSide() : generateSide(),
            ],
          ),
          isLap
              ? Positioned(
                  left: -5,
                  right: -5,
                  child: Container(
                    height: 55,
                    color: const Color(0xffEDEDED),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(
                          Icons.flag,
                          size: 40,
                          color: Colors.blueGrey,
                        ),
                        const Text(
                          'Nostalgia Nitro',
                          style: TextStyle(color: Colors.black),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: const Icon(Icons.flag, size: 40, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  List<Widget> generateCars() {
    if (npcCarKeys.isEmpty) {
      return [];
    }

    List<Widget> widLst = [];
    List<int> npcCarsIndex = [];

    int indexInRow1 = Utils.instance.getRandomNumFromRange(0, 2);
    int indexInRow2 = Utils.instance.getRandomNumFromRange(3, 5);
    int indexInRow3 = Utils.instance.getRandomNumFromRange(6, 8);
    int indexInRow4 = Utils.instance.getRandomNumFromRange(9, 11);

    //print('---- indexes ----- $indexInRow1 ---- $indexInRow2 ---- $indexInRow3 ---- $indexInRow4 ----');

    npcCarsIndex.add(indexInRow1);
    npcCarsIndex.add(indexInRow2);
    npcCarsIndex.add(indexInRow3);
    npcCarsIndex.add(indexInRow4);

    if (npcCarsIndex[0]==0 && npcCarsIndex[1]==4 && npcCarsIndex[2]==8) {
      npcCarsIndex.remove(4);
      npcCarsIndex.add(3);
      npcCarsIndex.add(5);
      //print('--- cond 1 ---');
    }
    else if (npcCarsIndex[0]==2 && npcCarsIndex[1]==4 && npcCarsIndex[2]==6) {
      npcCarsIndex.remove(6);
      npcCarsIndex.add(8);
      //print('--- cond 2 ---');
    }
    else if(npcCarsIndex[1]==3 && npcCarsIndex[2]==7 && npcCarsIndex[3]==11){
      npcCarsIndex.remove(7);
      npcCarsIndex.remove(6);
      npcCarsIndex.remove(8);
      //print('--- cond 3 ---');
    }
    else if(npcCarsIndex[1]==5 && npcCarsIndex[2]==7 && npcCarsIndex[3]==9){
      npcCarsIndex.remove(9);
      npcCarsIndex.add(10);
      //print('--- cond 4 ---');
    }
    // else if(npcCarsIndex[0]==2 && npcCarsIndex[1]==5 && npcCarsIndex[2]==8){
    //   npcCarsIndex.add(4);
    //   print('--- cond 5 ---');
    // }
    // else if(npcCarsIndex[1]==3 && npcCarsIndex[2]==6 && npcCarsIndex[3]==9){
    //   npcCarsIndex.add(7);
    //   print('--- cond 6 ---');
    // }
    else if(npcCarsIndex[0]==0 && npcCarsIndex[1]==4 && npcCarsIndex[2]==7 && npcCarsIndex[3]==11){
      npcCarsIndex.remove(11);
      //print('--- cond 7 ---');
    }
    else if(npcCarsIndex[0]==2 && npcCarsIndex[1]==4 && npcCarsIndex[2]==7 && npcCarsIndex[3]==9){
      npcCarsIndex.remove(9);
      //print('--- cond 8 ---');
    }
    // else{
    //   //print('--- cond 9 ---');
    //   /*
    //   ---- indexes ----- 0 ---- 4 ---- 7 ---- 11 ----
    //   ---- indexes ----- 2 ---- 4 ---- 7 ---- 9 ----
    //    */
    // }

    for (int i = 0; i < 12; i++) {
      if (npcCarsIndex.contains(i) ) {
        widLst.add(CarWidget(
          key: npcCarKeys[i],
          isNpc: true,
        ));
      } else {
        widLst.add(const SizedBox());
      }
    }

    return widLst;
  }

  Widget generateSide() {
    List<Widget> widLst = [];
    for (int i = 0; i < 45; i = i + 5) {
      widLst.add(
        const SizedBox(
          height: 10,
        ),
      );
      widLst.add(
        const SizedBox(
          height: 10,
        ),
      );
      widLst.add(const TileWidget(width: 10, height: 10));
      widLst.add(const TileWidget(width: 10, height: 10));
      widLst.add(const TileWidget(width: 10, height: 10));
    }
    return Column(
      children: widLst,
    );
  }

  Widget generateModernSide() {
    List<Widget> widLst = [];
    for (int i = 0; i < 45; i = i + 5) {
      widLst.add(Container(width: 10, height: 10, color: Colors.white));
      widLst.add(Container(width: 10, height: 10, color: Colors.white));
      widLst.add(Container(width: 10, height: 5, color: Colors.white));
      widLst.add(Container(width: 10, height: 5, color: Colors.amberAccent));
      widLst.add(Container(width: 10, height: 10, color: Colors.amberAccent));
      widLst.add(Container(width: 10, height: 10, color: Colors.amberAccent));
    }
    return Column(
      children: widLst,
    );
  }
}
