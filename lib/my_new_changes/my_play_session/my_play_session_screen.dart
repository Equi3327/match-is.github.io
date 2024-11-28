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
import 'my_board_widget.dart';

class MyPlaySessionScreen extends StatefulWidget {
  const MyPlaySessionScreen({super.key});

  @override
  State<MyPlaySessionScreen> createState() => _MyPlaySessionScreenState();
}

class _MyPlaySessionScreenState extends State<MyPlaySessionScreen> {
  static final _log = Logger('MyPlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;

  @override
  void initState() {
    super.initState();
    _startOfPlay = DateTime.now();
  }

  Future<void> _playerWon() async {
    _log.info('Player won');

    // TODO: replace with some meaningful score for the card game
    final score = Score(1, 1, DateTime.now().difference(_startOfPlay));

    // final playerProgress = context.read<PlayerProgress>();
    // playerProgress.setLevelReached(widget.level.number);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.congrats);

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return IgnorePointer(
      // Ignore all input during the celebration animation.
      ignoring: _duringCelebration,
      child: Scaffold(
        backgroundColor: palette.backgroundPlaySession,
        // The stack is how you layer widgets on top of each other.
        // Here, it is used to overlay the winning confetti animation on top
        // of the game.
        body: Stack(
          children: [
            // This is the main layout of the play session screen,
            // with a settings button at top, the actual play area
            // in the middle, and a back button at the bottom.
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
                // The actual UI of the game.
                BlocBuilder<MyBoardBloc, MyBoardState>(
                  builder: (context, state) {
                    if(state.boardStatus == MyBoardStateStatus.playerWin){
                      _playerWon();
                    }
                    return MyBoardWidget(boardState: state,);
                  },
                ),
                // Text("Drag cards to the two areas above."),
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
                visible: _duringCelebration,
                child: IgnorePointer(
                  child: Confetti(
                    isStopped: !_duringCelebration,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
