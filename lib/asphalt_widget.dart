import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/tile_widget.dart';
import 'package:nostalgia_nitro/utils.dart';
import 'car_widget.dart';
import 'dart:math' as math;

class AsphaltWidget extends StatelessWidget {
  final List<GlobalKey> npcCarKeys;
  //final bool isEmpty;
  final bool isLap;

  const AsphaltWidget({Key? key, required this.npcCarKeys, this.isLap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 470,
      color: const Color(0xffEDEDED),
      child: Row(
        children: [
          generateSide(),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              //color: Colors.red.withOpacity(0.5),
              height: double.infinity,
              child: npcCarKeys.isEmpty
                  ? Center(
                      child: isLap
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    left: -25,
                                    right: -25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Icon(
                                          Icons.flag_outlined,
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
                                          child: const Icon(Icons.flag_outlined, size: 40, color: Colors.blueGrey),
                                        ),
                                      ],
                                    ))
                              ],
                            )
                          : const SizedBox(),
                    )
                  : GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      //10
                      mainAxisSpacing: 15,
                      //10
                      childAspectRatio: 0.75,
                      children: generateCars(),
                    ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          generateSide()
        ],
      ),
    );
  }

  List<Widget> generateCars() {
    List<Widget> widLst = [];
    List<int> npcCarsIndex = [];
    npcCarsIndex.add(Utils.generateRandomNumFromRange(0, 2));
    npcCarsIndex.add(Utils.generateRandomNumFromRange(3, 5));
    npcCarsIndex.add(Utils.generateRandomNumFromRange(6, 8));
    npcCarsIndex.add(Utils.generateRandomNumFromRange(9, 11));

    for (int i = 0; i < 12; i++) {
      if (npcCarsIndex.contains(i)) {
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
      if (isLap && i <= 10) {
        widLst.add(
          const SizedBox(
            height: 10,
          ),
        );
        continue;
      }
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
}
