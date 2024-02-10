import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/tile_widget.dart';
import 'package:nostalgia_nitro/utils.dart';
import 'car_widget.dart';

class AsphaltWidget extends StatelessWidget {

  final List<GlobalKey> npcCarKeys;
  final bool isEmpty;
  const AsphaltWidget({Key? key,required this.npcCarKeys,this.isEmpty = false}) : super(key: key);


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
                child: isEmpty ? const Center(child: Text('New Lap')) : GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,//10
                  mainAxisSpacing: 15,//10
                  childAspectRatio: 0.75,
                  children: generateCars(),
                ),
              )
          ),
          const SizedBox(width: 10,),
          generateSide()
        ],
      ),
    );
  }

  List<Widget> generateCars(){
    //widget.hasKey ? CarWidget(key: carKey3,carColor: Colors.red,) : Container(),
    List<Widget> widLst = [];
    List<int> npcCarsIndex = [];
    npcCarsIndex.add(Utils.generateRandomNumFromRange(0, 2));
    npcCarsIndex.add(Utils.generateRandomNumFromRange(3, 5));
    npcCarsIndex.add(Utils.generateRandomNumFromRange(6, 8));
    npcCarsIndex.add(Utils.generateRandomNumFromRange(9, 11));

    for(int i = 0 ; i < 12 ; i++){
      if(npcCarsIndex.contains(i)){
        widLst.add(CarWidget(key: npcCarKeys[i],isNpc: true,));
      }
      else{
        widLst.add(Container());
      }
    }

    return widLst;

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
