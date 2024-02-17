import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/widgets/tile_widget.dart';
import 'package:nostalgia_nitro/utils/utils.dart';

GlobalKey carKey = GlobalKey();
const carHeight = 70.2; //75.0;
const carWidth = 52.7; //56.0;
bool isModern = false;//

class CarWidget extends StatelessWidget {
  final isNpc;
  final Color carColor;

  const CarWidget({Key? key, this.carColor = Colors.black, required this.isNpc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isModern
        ? Container(
            width: carWidth,
            height: carHeight,
            alignment: Alignment.center,
            child: Image.asset(
              isNpc ? 'assets/car_npc_${Utils.instance.getRandomNumFromRange(0, 2)}.png' : 'assets/car_main_0.png',
              width: 52.7,
              height: 70.2,
              fit: BoxFit.fitHeight,
            ),
          )
        : Container(
            width: carWidth, height: carHeight,
            alignment: Alignment.center,
            //color: Colors.amberAccent.withOpacity(0.6),//
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  const SizedBox(width: 10, height: 10),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                  const SizedBox(width: 10, height: 10),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                  const SizedBox(width: 10, height: 10),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                  const SizedBox(width: 10, height: 10),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                  const SizedBox(width: 10, height: 10),
                  TileWidget(
                    width: 10,
                    height: 10,
                    color: carColor,
                  ),
                ],
              ),
            ),
          );
  }
}
