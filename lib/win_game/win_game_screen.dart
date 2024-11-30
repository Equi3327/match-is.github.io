import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../game_internals/score.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;
  final bool didPlayerWin;

  const WinGameScreen({
    super.key,
    required this.score,
    required this.didPlayerWin,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();


    return Scaffold(
      backgroundColor: palette.trueWhite,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'You ${didPlayerWin ? "won!":"lost!"}',
                style: const TextStyle(
                  // fontFamily: 'Permanent Marker',
                  fontSize: 50,
                ),
              ),
            ),
          ],
        ),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
