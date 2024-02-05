import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/tile_widget.dart';

import 'car_widget.dart';

class AsphaltWidget extends StatefulWidget {
  const AsphaltWidget({Key? key}) : super(key: key);

  @override
  State<AsphaltWidget> createState() => _AsphaltWidgetState();
}

class _AsphaltWidgetState extends State<AsphaltWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 470,
      color: const Color(0xffEDEDED),
      child: Row(
        children: [
          generateSide(),
          const SizedBox(width: 10,),
          Expanded(
              child: Container(
                //color: Colors.red.withOpacity(0.5),
                height: double.infinity,
                child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                  children: [
                    Container(),
                    CarWidget(),
                    Container(),
                    Container(),
                    Container(),
                    CarWidget(),
                    CarWidget(),
                  ],
                ),
              )
          ),
          const SizedBox(width: 10,),
          generateSide()
        ],
      ),
    );
  }


  Widget generateSide() {
    List<Widget> widLst = [];
    for (int i = 0; i < 45; i=i+5) {

      widLst.add(const SizedBox(height: 10,),);
      widLst.add(const SizedBox(height: 10,),);
      widLst.add(const TileWidget(width:10,height: 10));
      widLst.add(const TileWidget(width:10,height: 10));
      widLst.add(const TileWidget(width:10,height: 10));

    }
    return Column(children: widLst,);
  }


}
