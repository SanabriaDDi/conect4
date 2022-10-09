import 'package:conect4/ui/home/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => context.read<BoardCubit>().initialBoard(),
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
