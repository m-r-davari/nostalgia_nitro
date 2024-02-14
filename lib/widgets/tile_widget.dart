import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const TileWidget({Key? key, this.width = 5 ,this.height = 5,this.color= Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(border: Border.all(color: color, width: width - (width - 1)), color: Colors.transparent),
      padding: EdgeInsets.all(width - (width - 1)),
      child: Container(
        color: color,
      ),
    );;
  }
}
