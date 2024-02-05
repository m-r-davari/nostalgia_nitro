import 'package:flutter/material.dart';
import 'package:nostalgia_nitro/race_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const RacePage()));
                },
                child: const Text('Start Game')
            )
          ],
        ),
      ),
    );
  }
}
