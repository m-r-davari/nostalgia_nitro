import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/asphalt_widget.dart';
import 'package:nostalgia_nitro/car_widget.dart';
import 'package:nostalgia_nitro/dash_border.dart';
import 'package:nostalgia_nitro/tile_widget.dart';

class RacePage extends StatefulWidget {
  const RacePage({Key? key}) : super(key: key);

  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  ScrollController scrollController = ScrollController();
  List<Widget> asphalts = [];
  Alignment carAlignment = Alignment.bottomCenter;

  @override
  void initState() {
    asphalts.add(AsphaltWidget(key: UniqueKey(),hasKey: true,));
    asphalts.add(AsphaltWidget(key: UniqueKey(),));
    //asphalts.add(AsphaltWidget());
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000),(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
    });
    scrollController.addListener(() {


      //adding new asphalts and removing passed ones

     //print('scroll ---> ${scrollController.position}');

      if(scrollController.position.atEdge){//scrollController.position.maxScrollExtent -  scrollController.offset < 50
        print('--- adding new asphalt --- ${scrollController.offset} --- asphalt length : ${asphalts.length}');
        asphalts.add(AsphaltWidget(key: UniqueKey(),));
        setState(() {});
        Future.delayed(Duration.zero,(){
          scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
        });
        // setState(() {});

        if(asphalts.length > 3){
          Future.delayed(Duration(milliseconds: 2000),(){
            asphalts.removeAt(0);
            print('--- removing as-l -- : ${asphalts.length}');
          });
        }



        // if(asphalts.length>5){
        //   Future.delayed(Duration.zero,(){
        //     print('--- removing --- as-l : ${asphalts.length} ');
        //     asphalts.removeAt(0);
        //     asphalts.removeAt(0);
        //     asphalts.removeAt(0);
        //   });
        // }


      }



/*      print('scroll ---> ${scrollController.position}');
      RenderBox mainCarBox = carKey.currentContext!.findRenderObject() as RenderBox;
      Offset mainCarPosition = mainCarBox.localToGlobal(Offset.zero);
      RenderBox mpcCarBox = carKey3.currentContext!.findRenderObject() as RenderBox;
      Offset mpcCarPosition = mpcCarBox.localToGlobal(Offset.zero);

      print('---car position---- $mainCarPosition');
      print('---mpc car position---- $mpcCarPosition');

      if(mainCarPosition.dx==mpcCarPosition.dx){//
        double mainCarTop = mainCarPosition.dy;
        double mainCarBottom = mainCarPosition.dy + carHeight;
        double mpcCarTop = mpcCarPosition.dy;
        double mpcCarBottom = mpcCarPosition.dy + carHeight;
        if((mpcCarBottom >= mainCarTop && mpcCarBottom <= mainCarBottom) || (mpcCarTop >= mainCarTop && mpcCarTop <= mainCarBottom)){
          print('**crashed**');
        }
      }*/

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Race Page'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              width: 350,
              height: 470,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: scrollController,
                          reverse: true,
                          itemCount: asphalts.length,
                          // addAutomaticKeepAlives: false,
                          // cacheExtent: 470,
                          // itemExtent: 470,
                          itemBuilder: (ctx,index){
                            // print('---- asphalt index $index');
                            return asphalts[index];
                          },
                        ),
                        Positioned(left:20,right:20,bottom: 5,child: Align(alignment: carAlignment,child: CarWidget(carColor: Colors.blueAccent,key: carKey,),))
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 2, color: Colors.grey, thickness: 2),
                  Container(
                    width: 120,
                    color: Color(0xffEDEDED),
                    child: Center(
                      child: Text('Scores '),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16,),
            Text('crashed : '),
            const SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if(carAlignment == Alignment.bottomLeft){
                              return;
                            }
                            if(carAlignment == Alignment.bottomCenter){
                              carAlignment = Alignment.bottomLeft;
                            }
                            else if(carAlignment == Alignment.bottomRight){
                              carAlignment = Alignment.bottomCenter;
                            }
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_circle_left,
                            size: 60,
                            color: Colors.amber,
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: () {
                            if(carAlignment == Alignment.bottomRight){
                              return;
                            }
                            if(carAlignment == Alignment.bottomCenter){
                              carAlignment = Alignment.bottomRight;
                            }
                            else if(carAlignment == Alignment.bottomLeft){
                              carAlignment = Alignment.bottomCenter;
                            }
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            size: 60,
                            color: Colors.amber,
                          )),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        //asphalts.removeLast();

                        setState(() {
                          asphalts.removeAt(0);
                        });
                        //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 2000), curve: Curves.linear);
                        // print('----removed ---- ${asphalts.length}');
                        // asphalts.removeAt(0);
                        // asphalts.removeAt(0);
                        // print('----removed ---- ${asphalts.length}');
                      },
                      icon: Icon(
                        Icons.arrow_circle_up,
                        size: 60,
                        color: Colors.amber,
                      )),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }





}
