import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nostalgia_nitro/widgets/car_widget.dart';
import 'package:nostalgia_nitro/widgets/menu_item.dart';
import 'dart:js' as js;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController transUpController;
  late Animation<Offset> transUpOffset;
  Color trailColor = Colors.amberAccent;

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
                  //color: Colors.deepPurple.withOpacity(0.05),
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
                      subtitle:'Enjoy playing the game',
                      onClick: () {
                        transUpController.forward();
                      },
                      trailing: InkWell(
                          onTap: () {
                            print('----infoer---');
                          },
                          child: Icon(Icons.play_arrow,size: 26,color: trailColor,))),
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
                        color: trailColor,
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  MenuItem(
                      title: 'Github Star',
                      subtitle: 'Support me by GitHub Star',
                      onClick: () {
                        js.context.callMethod('open', ['https://github.com/m-r-davari/nostalgia_nitro']);
                      },
                      trailing: Icon(
                        Icons.star,
                        color: trailColor,
                      )),
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
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(onTap: (){
                        js.context.callMethod('open', ['https://www.linkedin.com/in/m-r-davari92/']);
                      },child: Image.asset('assets/linkedin.png',width: 23,height: 22,)),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(onTap: (){
                        js.context.callMethod('open', ['mailto:m.r.davari92@gmail.com']);
                      },child: Image.asset('assets/gmail.png',width: 25,height: 25,)),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(onTap: (){
                        js.context.callMethod('open', ['https://github.com/m-r-davari']);
                      },child: Image.asset('assets/github.png',width: 25,height: 25,)),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(onTap: (){
                        js.context.callMethod('open', ['https://pub.dev/publishers/mobilesoft98.dev/packages']);
                      },child: Image.asset('assets/pubdev.png',width: 24,height: 23,)),
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
                'assets/car_main_0.png',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 200,
              )
            : const CarWidget(carColor: Colors.blueAccent,isNpc: false),
      ),
    );
  }





}
