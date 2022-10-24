import 'package:conect4/ui/home/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () => context.read<BoardCubit>().initialBoard(),
                  child: const Icon(Icons.refresh_outlined),
                ),
                const SizedBox(height: 12),
                const Text('Reiniciar partida actual'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () =>
                      context.read<BoardCubit>().reloadCounterGames(),
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(height: 12),
                const Text('Borrar contador'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
