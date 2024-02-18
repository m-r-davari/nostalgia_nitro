import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/widgets/asphalt_widget.dart';
import 'package:nostalgia_nitro/controllers/car_controller.dart';
import 'package:nostalgia_nitro/widgets/car_holder.dart';
import 'package:nostalgia_nitro/utils/dash_border.dart';
import 'package:nostalgia_nitro/controllers/race_controller.dart';
import 'package:nostalgia_nitro/widgets/race_info_widget.dart';

class RacePage extends StatefulWidget {
  const RacePage({Key? key}) : super(key: key);

  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {
  final raceController = Get.find<RaceController>();
  final carController = Get.find<CarController>();
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = raceController.scrollController;
    raceController.hiScore.value = raceController.sharePref.loadHiScore();
    raceController.asphalts.add(AsphaltWidget(
      isLap: true,
      key: GlobalKey(),
      npcCarKeys: raceController.generateMpcKeys(),
    ),);
    raceController.asphalts.add(AsphaltWidget(
      key: GlobalKey(),
      npcCarKeys: raceController.generateMpcKeys(),
    ));
    raceController.asphalts.add(AsphaltWidget(
      key: GlobalKey(),
      npcCarKeys: raceController.generateMpcKeys(),
    ),);
    raceController.asphalts.add(AsphaltWidget(
      key: GlobalKey(),
      npcCarKeys: raceController.generateMpcKeys(),
    ));
    raceController.asphalts.add(AsphaltWidget(
      key: GlobalKey(),
      npcCarKeys: raceController.generateMpcKeys(),
    ),);

    scrollController.addListener(() {

      //print('--- handling asphalt --- offset : ${scrollController.offset} --- asphalt length : ${raceController.asphalts.length}');

      //scrollController.position.atEdge
      //scrollController.position.maxScrollExtent -  scrollController.offset < 50
      if (scrollController.position.atEdge) {
        raceController.handleAsphalts();
      }


      if(scrollController.offset>470){
        raceController.calculateScores();
        raceController.handleAccident();
      }

      raceController.handleNitro();

    });

    super.initState();
    Future.delayed(Duration.zero,()async{
      await raceController.showCountDownDialog();
      raceController.speed.value = 7520;
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);
    });

    // Future.delayed(const Duration(milliseconds: 3000), () {
    //   raceController.speed.value = 7520;//((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt();
    //   scrollController.animateTo(scrollController.position.maxScrollExtent,
    //       duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);
    // });

  }

  @override
  Widget build(BuildContext context) {
    //print('---rebuildddddzzz--race--');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nostalgia Nitro'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 361,
                  height: 480,
                  decoration: BoxDecoration(border: DashedBorder.all(dashLength: 20, width: 5, color: Colors.blueGrey, isOnlyCorner: true)),
                ),
                Container(
                  width: 350,
                  height: 470,
                  color: const Color(0xffEDEDED), //Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                              child: Obx(
                                () => ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  controller: scrollController,
                                  reverse: true,
                                  itemCount: raceController.asphalts.length,
                                  //cacheExtent: 4700,
                                  itemBuilder: (ctx, index) {
                                    return raceController.asphalts[index];
                                  },
                                ),
                              ),
                            ),
                            const Positioned(left: 20, right: 20, bottom: 5, child: CarHolder())
                          ],
                        ),
                      ),
                      const VerticalDivider(width: 2, color: Colors.grey, thickness: 2),
                      Container(
                        width: 120,
                        color: const Color(0xffEDEDED),
                        child: RaceInfoWidget(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 400,
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (carController.carAlignment.value == Alignment.bottomLeft) {
                              return;
                            }
                            if (carController.carAlignment.value == Alignment.bottomCenter) {
                              carController.carAlignment.value = Alignment.bottomLeft;
                            } else if (carController.carAlignment.value == Alignment.bottomRight) {
                              carController.carAlignment.value = Alignment.bottomCenter;
                            }
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
                            if (carController.carAlignment.value == Alignment.bottomRight) {
                              return;
                            }
                            if (carController.carAlignment.value == Alignment.bottomCenter) {
                              carController.carAlignment.value = Alignment.bottomRight;
                            } else if (carController.carAlignment.value == Alignment.bottomLeft) {
                              carController.carAlignment.value = Alignment.bottomCenter;
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            size: 60,
                            color: Colors.amber,
                          )),
                    ],
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.amber,
                      child: InkWell(
                        onTapDown: (details) {
                          //activating nitro
                          if (raceController.nitroPercent.value <= 0) {
                            return;
                          }
                          raceController.isNitroActive.value = true;
                          raceController.speed.value =
                              ((scrollController.position.maxScrollExtent - scrollController.offset) * 2).toInt(); //10000
                          scrollController.animateTo(scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);
                        },
                        onTapUp: (details) {
                          //deactivating
                          if (raceController.nitroPercent.value >= 1) {
                            return;
                          }
                          raceController.isNitroActive.value = false;
                          if(raceController.isCrashed.value){
                            return;
                          }
                          raceController.speed.value =
                              ((scrollController.position.maxScrollExtent - scrollController.offset) * 4).toInt(); //16000;
                          scrollController.animateTo(scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: raceController.speed.value), curve: Curves.linear);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.flash_on,
                            size: 38,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }


}
