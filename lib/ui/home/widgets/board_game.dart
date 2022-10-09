import 'package:conect4/ui/home/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Owner { red, yellow, free }

class BoardGame extends StatelessWidget {
  const BoardGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade600,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(4, 8),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      child: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: state.board
                .map((e) => Expanded(
                      child: InkWell(
                        child: BoardColumn(
                          column: e,
                        ),
                        onTap: () {
                          context.read<BoardCubit>().updateChip(
                              columnPositionX: state.board.indexOf(e));
                        },
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}

class BoardColumn extends StatelessWidget {
  const BoardColumn({Key? key, required this.column}) : super(key: key);

  final List<CircleOwner> column;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: column.map((owner) => Chip(owner: owner)).toList(),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip({Key? key, required this.owner}) : super(key: key);

  final CircleOwner owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: owner == CircleOwner.yellowPlayer
            ? Colors.yellow
            : owner == CircleOwner.redPlayer
                ? Colors.red
                : Colors.white,
      ),
    );
  }
}
