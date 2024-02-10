import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/asphalt_widget.dart';
import 'package:nostalgia_nitro/car_controller.dart';
import 'package:nostalgia_nitro/car_holder.dart';
import 'package:nostalgia_nitro/race_controller.dart';
import 'package:nostalgia_nitro/scores_widget.dart';

class RacePage extends StatefulWidget {
  const RacePage({Key? key}) : super(key: key);

  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  final raceController = Get.find<RaceController>();
  final carController = Get.find<CarController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {

    raceController.hiScore.value = raceController.sharePref.loadHiScore();
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));
    raceController.asphalts.add(AsphaltWidget(key: GlobalKey(),npcCarKeys: raceController.generateMpcKeys(),));

    super.initState();
    Future.delayed(const Duration(milliseconds: 3000),(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);
    });
    scrollController.addListener(() {

      //adding new asphalts and removing passed ones
     //print('scroll ---> ${scrollController.position}');

      //scrollController.position.atEdge
      //scrollController.position.maxScrollExtent -  scrollController.offset < 50
      if(scrollController.position.atEdge){
        raceController.handleAsphalts(scrollController);
      }

      if(true){
        raceController.handleAccident(scrollController);
        //print('scroll ---> ${scrollController.position}');
      }

      raceController.calculateScores(scrollController);

      //handle nitro
      raceController.handleNitro(scrollController);



    });

  }

  @override
  Widget build(BuildContext context) {
    //print('---rebuildddddzzz----');
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
              height: 8,//80,
            ),
            Container(
              width: 350,
              height: 470,
              color: const Color(0xffEDEDED),//Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Obx(() => ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: scrollController,
                              reverse: true,
                              itemCount: raceController.asphalts.length,
                              //cacheExtent: 4700,
                              itemBuilder: (ctx,index){
                                return raceController.asphalts[index];
                              },
                            ),),
                        ),
                        const Positioned(left:20,right:20,bottom: 5,child: CarHolder())
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 2, color: Colors.grey, thickness: 2),
                  Container(
                    width: 120,
                    color: const Color(0xffEDEDED),
                    child: Obx(()=>ScoreWidget(score: raceController.score.value,lap: raceController.lap.value,hiScore: raceController.sharePref.loadHiScore(),armor: raceController.armor.value,nitroPercent: raceController.nitroPercent.value,)),
                  )
                ],
              ),
            ),
            SizedBox(height: 16,),
            Text('crashed : '),
            const SizedBox(
              height: 16,//100,
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
                            if(carController.carAlignment.value == Alignment.bottomLeft){
                              return;
                            }
                            if(carController.carAlignment.value == Alignment.bottomCenter){
                              carController.carAlignment.value = Alignment.bottomLeft;
                            }
                            else if(carController.carAlignment.value == Alignment.bottomRight){
                              carController.carAlignment.value = Alignment.bottomCenter;
                            }
                            //setState(() {});
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
                            if(carController.carAlignment.value == Alignment.bottomRight){
                              return;
                            }
                            if(carController.carAlignment.value == Alignment.bottomCenter){
                              carController.carAlignment.value = Alignment.bottomRight;
                            }
                            else if(carController.carAlignment.value == Alignment.bottomLeft){
                              carController.carAlignment.value = Alignment.bottomCenter;
                            }
                            //setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            size: 60,
                            color: Colors.amber,
                          )),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        if(raceController.nitroPercent.value <= 0){
                          return;
                        }
                        raceController.isNitroActive.value = true;
                        raceController.speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt();
                        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);

                      },
                      icon: const Icon(
                        Icons.arrow_circle_up,
                        size: 60,
                        color: Colors.amber,
                      )),
                  IconButton(
                      onPressed: () {
                        if(raceController.nitroPercent.value >= 1){
                          return;
                        }
                        raceController.isNitroActive.value = false;
                        raceController.speed.value = ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt(); //16000;
                        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);

                      },
                      icon: const Icon(
                        Icons.arrow_circle_down,
                        size: 60,
                        color: Colors.amber,
                      )),
                  const SizedBox(
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
