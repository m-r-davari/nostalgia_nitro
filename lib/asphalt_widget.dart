import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/tile_widget.dart';
import 'package:nostalgia_nitro/utils.dart';
import 'car_widget.dart';

class AsphaltWidget extends StatefulWidget {

  final Function(GlobalKey)? carInCrashZone;
  final List<GlobalKey> mpcCarKeys;
  final bool isEmpty;
  const AsphaltWidget({Key? key,required this.mpcCarKeys, this.carInCrashZone ,this.isEmpty = false}) : super(key: key);

  @override
  State<AsphaltWidget> createState() => _AsphaltWidgetState();
}

class _AsphaltWidgetState extends State<AsphaltWidget> {

  List<Widget> carsList = [];

  @override
  void initState() {
    if(!widget.isEmpty){
      carsList = generateCars();
    }
    super.initState();
  }

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
                child: widget.isEmpty ? Text('**Empty**') : GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,//10
                  mainAxisSpacing: 15,//10
                  childAspectRatio: 0.75,
                  children: carsList,
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
    List<int> mpcCarsIndex = [];
    mpcCarsIndex.add(Utils.generateRandomNumFromRange(0, 2));
    mpcCarsIndex.add(Utils.generateRandomNumFromRange(3, 5));
    mpcCarsIndex.add(Utils.generateRandomNumFromRange(6, 8));
    mpcCarsIndex.add(Utils.generateRandomNumFromRange(9, 11));

    for(int i = 0 ; i < 12 ; i++){
      if(mpcCarsIndex.contains(i)){
        widLst.add(CarWidget(key: widget.mpcCarKeys[i],));
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
