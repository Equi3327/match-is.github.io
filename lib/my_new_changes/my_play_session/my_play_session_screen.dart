import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:match_is/my_new_changes/bloc/my_board_bloc/my_board_bloc.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/score.dart';
import '../../style/confetti.dart';
import '../../style/my_button.dart';
import '../../style/palette.dart';
import '../bloc/my_game_bloc/my_game_bloc.dart';
import 'my_board_widget.dart';

class MyPlaySessionScreen extends StatefulWidget {
  const MyPlaySessionScreen({super.key});

  @override
  State<MyPlaySessionScreen> createState() => _MyPlaySessionScreenState();
}

class _MyPlaySessionScreenState extends State<MyPlaySessionScreen> {
  static final _log = Logger('MyPlaySessionScreen');

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return BlocConsumer<MyGameBloc, MyGameState>(
      listener: (context, state) {
        if (state.gameStatus == MyGameStateStatus.gameOver) {
          final score = Score(1, 1, const Duration(milliseconds: 6000));
          GoRouter.of(context).go('/play/won', extra: {'score': score});
        }
      },
      builder: (context, state) {
        switch (state.gameStatus) {
          case MyGameStateStatus.initial:
            return Container();
          case MyGameStateStatus.gameStarted ||
                MyGameStateStatus.playerWon ||
                MyGameStateStatus.gameOver:
            bool duringCelebration =
                state.gameStatus == MyGameStateStatus.playerWon;
            if (duringCelebration) {
              final audioController = context.read<AudioController>();
              audioController.playSfx(SfxType.congrats);
            }
            return IgnorePointer(
              ignoring: duringCelebration,
              child: Scaffold(
                backgroundColor: palette.backgroundPlaySession,
                body: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkResponse(
                            onTap: () => GoRouter.of(context).push('/settings'),
                            child: Image.asset(
                              'assets/images/settings.png',
                              semanticLabel: 'Settings',
                            ),
                          ),
                        ),
                        const Spacer(),
                        BlocProvider(
                          create: (context) =>
                              MyBoardBloc(players: state.players),
                          child: const MyBoardWidget(),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyButton(
                            onPressed: () => GoRouter.of(context).go('/'),
                            child: const Text('Back'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox.expand(
                      child: Visibility(
                        visible: duringCelebration,
                        child: IgnorePointer(
                          child: Confetti(
                            isStopped: !duringCelebration,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
