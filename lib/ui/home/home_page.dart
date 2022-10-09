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
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: paddingNotificationsBar),
              child: Column(
                children: const [
                  Text('Conecta 4'),
                  FlutterLogo(
                    size: 32,
                  ),
                  SizedBox(height: 16),
                  BoardGame(),
                  SizedBox(height: 32),
                  CounterPoints()
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ActionButtons(),
            ),
          ],
        ),
      ),
    );
  }
}
