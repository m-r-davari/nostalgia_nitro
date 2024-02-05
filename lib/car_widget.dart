import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/tile_widget.dart';

class CarWidget extends StatelessWidget {
  final Color carColor;
  const CarWidget({Key? key,this.carColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,height: 75,
      alignment: Alignment.center,
      color: Colors.amberAccent.withOpacity(0.6),
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          const SizedBox(width:10,height: 10),
          TileWidget(width:10,height: 10,color: carColor,),
          const SizedBox(width:10,height: 10),
          TileWidget(width:10,height: 10,color: carColor,),
          TileWidget(width:10,height: 10,color: carColor,),
          TileWidget(width:10,height: 10,color: carColor,),
          const SizedBox(width:10,height: 10),
          TileWidget(width:10,height: 10,color: carColor,),
          const SizedBox(width:10,height: 10),
          TileWidget(width:10,height: 10,color: carColor,),
          const SizedBox(width:10,height: 10),
          TileWidget(width:10,height: 10,color: carColor,),
        ],
      ),
    );
  }
}
