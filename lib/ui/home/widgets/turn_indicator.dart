import 'package:conect4/ui/home/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TurnIndicator extends StatelessWidget {
  const TurnIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.winner == null) ...[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'TURNO DE JUGADOR',
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
            ] else ...[
              const Text(
                'JUGADOR GANADOR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.winner == PlayerTurn.redPlayer ? 'ROJO' : 'AMARILLO',
                style: TextStyle(
                  color: state.winner == PlayerTurn.redPlayer
                      ? Colors.red
                      : Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
