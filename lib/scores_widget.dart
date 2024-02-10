import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int score;
  const ScoreWidget({super.key,required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Score : '),
        const SizedBox(height: 16,),
        FittedBox(child: Text(score.toString(),maxLines: 1,))
      ],
    );
  }
}
