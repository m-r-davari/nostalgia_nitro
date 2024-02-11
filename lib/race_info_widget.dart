import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/race_controller.dart';
import 'package:nostalgia_nitro/tile_widget.dart';

class RaceInfoWidget extends StatelessWidget {

  RaceInfoWidget({super.key});

  final raceController = Get.find<RaceController>();

  @override
  Widget build(BuildContext context) {
    //print('---rebuildddddzzz--info--');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Hi Score'),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(child: Obx(()=>Text(raceController.hiScore.value.toString(),maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold),))),
        ),
        const SizedBox(height: 24,),
        const Divider(height: 1,thickness: 0.8,indent: 8,endIndent: 8,color: Colors.grey,),
        const SizedBox(height: 24,),
        const Text('Score'),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(child: Obx(()=>Text(raceController.score.value.toString(),maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold),))),
        ),
        const SizedBox(height: 16,),
        const Text('Lap'),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(child: Obx(()=>Text(raceController.lap.value.toString(),maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold),))),
        ),
        const SizedBox(height: 24,),
        const Divider(height: 1,thickness: 0.8,indent: 8,endIndent: 8,color: Colors.grey,),
        const SizedBox(height: 24,),
        const Text('Armor'),
        const SizedBox(height: 8,),
        Obx(() => generateArmor(raceController.armor.value)),
        const SizedBox(height: 24,),
        const Divider(height: 1,thickness: 0.8,indent: 8,endIndent: 8,color: Colors.grey,),
        const SizedBox(height: 24,),//
        Stack(
          alignment: Alignment.center,
          children: [
            const Text('Nitro'),
            SizedBox(width: 50,height: 50,child: Obx(()=>CircularProgressIndicator(value: raceController.nitroPercent.value,color: Colors.black,backgroundColor: Colors.grey))),
          ],
        )
      ],
    );
  }



  Widget generateArmor(int armor){
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TileWidget(width: 17,height: 17,color: armor > 0 ? Colors.black : Colors.grey,),
          const SizedBox(width: 4,),
          TileWidget(width: 17,height: 17,color: armor > 1 ? Colors.black : Colors.grey,),
          const SizedBox(width: 4,),
          TileWidget(width: 17,height: 17,color: armor > 2 ? Colors.black : Colors.grey,),
          const SizedBox(width: 4,),
          TileWidget(width: 17,height: 17,color: armor > 3 ? Colors.black : Colors.grey,),
        ],
      ),
    );
  }





}
