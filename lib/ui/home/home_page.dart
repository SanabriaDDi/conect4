import 'package:conect4/ui/home/board_cubit.dart';
import 'package:conect4/ui/home/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingNotificationsBar = MediaQuery.of(context).padding.top;

    return BlocProvider(
      create: (context) => BoardCubit()..initialBoard(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              margin: EdgeInsets.only(top: paddingNotificationsBar),
              child: Column(
                children: const [
                  SizedBox(height: 16),
                  CounterPoints(),
                  SizedBox(height: 16),
                  BoardGame(),
                  SizedBox(height: 32),
                  TurnIndicator(),
                  SizedBox(height: 36),
                  ActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
