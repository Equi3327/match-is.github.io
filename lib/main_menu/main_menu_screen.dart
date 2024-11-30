import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../blocs/game_bloc/game_bloc.dart';
import '../game_internals/player.dart';
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
      backgroundColor: palette.trueWhite,
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.1,
            child: const Text(
              'Match Is!',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                BlocProvider.of<GameBloc>(context).add(
                  PlayGame(
                    Player(
                      playerName: GamePlayer.player1,
                    ),
                  ),
                );
                GoRouter.of(context).go('/play');
              },
              child: const Text('Play'),
            ),
            // _gap,
            // MyButton(
            //   onPressed: () => GoRouter.of(context).push('/settings'),
            //   child: const Text('Settings'),
            // ),
            // _gap,
            // Padding(
            //   padding: const EdgeInsets.only(top: 32),
            //   child: ValueListenableBuilder<bool>(
            //     valueListenable: settingsController.audioOn,
            //     builder: (context, audioOn, child) {
            //       return IconButton(
            //         onPressed: () => settingsController.toggleAudioOn(),
            //         icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
            //       );
            //     },
            //   ),
            // ),
            // _gap,
            // const Text('Music by Mr Smith'),
            // _gap,
          ],
        ),
      ),
    );
  }

  // static const _gap = SizedBox(height: 10);
}
