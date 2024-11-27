import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:match_is/my_new_changes/bloc/my_board_bloc/my_board_bloc.dart';
import 'package:match_is/my_new_changes/models/my_player.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/playing_card.dart';
import '../settings/settings.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.1,
            child: const Text(
              'Match Is!',
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1,
              ),
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                final List<PlayingCard> deck =
                    List.generate(MAX_CARDS, (index) => PlayingCard.random());
                BlocProvider.of<MyBoardBloc>(context).add(
                  AddPlayersAndDeck(
                    players: [
                      MyPlayer(
                        playerName: MyGamePlayer.player1,
                        hand: deck.sublist(0, MAX_CARDS ~/ 2),
                        // canMove: true,
                      ),
                      MyPlayer(
                        playerName: MyGamePlayer.player2,
                        hand: deck.sublist(MAX_CARDS ~/ 2, MAX_CARDS),
                        // canMove: false,
                      )
                    ],
                  ),
                );
                GoRouter.of(context).go('/play');
              },
              child: const Text('Play'),
            ),
            _gap,
            MyButton(
              onPressed: () => GoRouter.of(context).push('/settings'),
              child: const Text('Settings'),
            ),
            _gap,
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.audioOn,
                builder: (context, audioOn, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleAudioOn(),
                    icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                  );
                },
              ),
            ),
            _gap,
            const Text('Music by Mr Smith'),
            _gap,
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
