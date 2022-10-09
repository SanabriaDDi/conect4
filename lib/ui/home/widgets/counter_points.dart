import 'package:conect4/ui/home/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPoints extends StatelessWidget {
  const CounterPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        return Column(
          children: [
            Divider(
              color: state.playerTurn == PlayerTurn.redPlayer
                  ? Colors.red
                  : Colors.yellow,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'TURNO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.playerTurn == PlayerTurn.redPlayer
                          ? 'ROJO'
                          : 'AMARILLO',
                      style: TextStyle(
                          color: state.playerTurn == PlayerTurn.redPlayer
                              ? Colors.red
                              : Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: state.playerTurn == PlayerTurn.redPlayer
                  ? Colors.red
                  : Colors.yellow,
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                const Text('Partidas ganadas'),
                const SizedBox(height: 16),
                Row(
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
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
