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
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: [
                          AsphaltWidget(),
                          AsphaltWidget(),
                          AsphaltWidget(),
                          AsphaltWidget(),
                        ],
                      ),
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_circle_left,
                            size: 60,
                            color: Colors.amber,
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_circle_right,
                            size: 60,
                            color: Colors.amber,
                          )),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
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
