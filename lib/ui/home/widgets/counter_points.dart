import 'package:flutter/material.dart';

class CounterPoints extends StatelessWidget {
  const CounterPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: const [
            Text('Rojas'),
            Text('1'),
          ],
        ),
        Column(
          children: const [
            Text('Amarillas'),
            Text('1'),
          ],
        ),
      ],
    );
  }
}
