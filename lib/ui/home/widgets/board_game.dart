import 'package:flutter/material.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Expanded(child: BoardColumn()),
          Expanded(child: BoardColumn()),
          Expanded(child: BoardColumn()),
          Expanded(child: BoardColumn()),
          Expanded(child: BoardColumn()),
          Expanded(child: BoardColumn()),
          Expanded(child: BoardColumn()),
        ],
      ),
    );
  }
}

class BoardColumn extends StatelessWidget {
  const BoardColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        FreeSpaceCircle(),
        FreeSpaceCircle(),
        FreeSpaceCircle(),
        FreeSpaceCircle(),
        FreeSpaceCircle(),
        FreeSpaceCircle(),
      ],
    );
  }
}

class FreeSpaceCircle extends StatelessWidget {
  const FreeSpaceCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
      ),
    );
  }
}
