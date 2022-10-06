import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Reiniciar partida'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Borrar contador'),
        ),
      ],
    );
  }
}
