import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/score.dart';
import '../../style/confetti.dart';
import '../../style/my_button.dart';
import '../../style/palette.dart';
import '../blocs/board_bloc/board_bloc.dart';
import '../blocs/game_bloc/game_bloc.dart';
import 'board_widget.dart';

class PlaySessionScreen extends StatefulWidget {
  const PlaySessionScreen({super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state.gameStatus == GameStateStatus.gameOver) {
          final score = Score(1, 1, const Duration(milliseconds: 6000));
          GoRouter.of(context).go('/play/won', extra: {'score': score, "didPlayerWin": state.players.first == state.champion});
        }
      },
      builder: (context, state) {
        switch (state.gameStatus) {
          case GameStateStatus.initial:
            return Container();
          case GameStateStatus.gameStarted ||
                GameStateStatus.playerWon ||
                GameStateStatus.gameOver:
            bool duringCelebration =
                state.gameStatus == GameStateStatus.playerWon;
            if (duringCelebration) {
              final audioController = context.read<AudioController>();
              audioController.playSfx(SfxType.congrats);
            }
            return IgnorePointer(
              ignoring: duringCelebration,
              child: Scaffold(
                backgroundColor: palette.trueWhite,
                body: Stack(
                  children: [
                    BlocProvider(
                      create: (context) =>
                          BoardBloc(players: state.players),
                      child: const BoardWidget(),
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
