import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/pages/race_page.dart';
import 'package:nostalgia_nitro/widgets/car_widget.dart';
import 'package:nostalgia_nitro/widgets/menu_item.dart';
import 'package:nostalgia_nitro/widgets/typer_rich_text.dart';
import 'dart:js' as js;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController transUpController;
  late Animation<Offset> transUpOffset;
  //bool isModernCar = false;

  @override
  void initState() {
    super.initState();

    transUpController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    transUpOffset = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(transUpController);

    transUpOffset.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.toNamed('/race_page');
        Future.delayed(const Duration(milliseconds: 1000), () {
          transUpController.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nostalgia Nitro'),
      ),
      body: Container(
        alignment: Alignment.center,
        //padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 1,
                child: SlideTransition(
                  position: transUpOffset,
                  child: carPreview(),
                )),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.05),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  MenuItem(
                      title: 'Start',
                      subtitle:'Enjoy Sarting game',
                      onClick: () {
                        transUpController.forward();
                      },
                      trailing: InkWell(
                          onTap: () {
                            print('----infoer---');
                          },
                          child: const Icon(Icons.info_outline,color: Colors.amber,))),
                  const SizedBox(
                    height: 18,
                  ),
                  MenuItem(
                      title: 'Modern Cars ',
                      subtitle: 'Turn ON/OFF modern car',
                      onClick: () {
                        setState(() {
                          isModern = !isModern;
                        });
                      },
                      trailing: Icon(
                        isModern ? Icons.check_circle : Icons.circle_outlined,
                        color: isModern ? Colors.amber : Colors.amber,
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  MenuItem(
                      title: 'Github Star',
                      subtitle: 'Support Me by GitHub Star',
                      onClick: () {
                        js.context.callMethod('open', ['https://github.com/m-r-davari/nostalgia_nitro']);
                      },
                      trailing: const Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  MenuItem(
                      title: 'Other Projects',
                      subtitle: 'Visit my other open source projects',
                      onClick: () {
                        js.context.callMethod('open', ['https://github.com/m-r-davari']);
                      },
                      trailing: const Icon(Icons.open_in_new_outlined,color: Colors.amber,)),
                  const SizedBox(
                    height: 18,
                  ),
                  Center(
                    // width: 400,
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(text: 'Developed by '),
                        TextSpan(
                            text: " MohammadReza Davari", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        TextSpan(text: ' using '),
                        TextSpan(text: 'Flutter', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget carPreview() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 100,
        height: 150,
        child: isModern
            ? Image.asset(
                'assets/car_main.png',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 200,
              )
            : const CarWidget(carColor: Colors.blueAccent,isNpc: false),
      ),
    );
  }





}
