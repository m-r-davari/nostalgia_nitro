import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/tile_widget.dart';

class ScoreWidget extends StatelessWidget {
  final int score;
  final int lap;
  final int hiScore;
  final int armor;
  final double nitroPercent;
  const ScoreWidget({super.key,required this.score,required this.lap,required this.hiScore,required this.armor,required this.nitroPercent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Hi Score'),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(child: Text(hiScore.toString(),maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold),)),
        ),
        const SizedBox(height: 24,),
        const Divider(height: 1,thickness: 0.8,indent: 8,endIndent: 8,color: Colors.grey,),
        const SizedBox(height: 24,),
        const Text('Score'),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(child: Text(score.toString(),maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold),)),
        ),
        const SizedBox(height: 16,),
        const Text('Lap'),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FittedBox(child: Text(lap.toString(),maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold),)),
        ),
        const SizedBox(height: 24,),
        const Divider(height: 1,thickness: 0.8,indent: 8,endIndent: 8,color: Colors.grey,),
        const SizedBox(height: 24,),
        const Text('Armor'),
        const SizedBox(height: 8,),
        generateArmor(armor),
        const SizedBox(height: 24,),
        const Divider(height: 1,thickness: 0.8,indent: 8,endIndent: 8,color: Colors.grey,),
        const SizedBox(height: 24,),//
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Text('Nitro'),
              SizedBox(width: 50,height: 50,child: CircularProgressIndicator(value: nitroPercent,color: Colors.black,backgroundColor: Colors.grey)),
            ],
          )
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
