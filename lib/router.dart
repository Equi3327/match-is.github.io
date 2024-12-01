import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'game_internals/score.dart';
import 'main_menu/main_menu_screen.dart';
import 'play_session/play_session_screen.dart';
import 'style/my_transition.dart';
import 'style/palette.dart';
import 'win_game/win_game_screen.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildMyTransition<void>(
            key: const ValueKey('play'),
            color: context.watch<Palette>().trueBlack,
            child: const PlaySessionScreen(
              key: Key('level selection'),
            ),
          ),
          routes: [
            GoRoute(
              path: 'won',
              redirect: (context, state) {
                if (state.extra == null) {
                  return '/';
                }
                return null;
              },
              pageBuilder: (context, state) {
                final map = state.extra! as Map<String, dynamic>;
                final score = map['score'] as Score;
                final didPlayerWin = map['didPlayerWin'] as bool;

                return buildMyTransition<void>(
                  key: const ValueKey('won'),
                  color: context.watch<Palette>().trueBlack,
                  child: WinGameScreen(
                    score: score,
                    key: const Key('win game'), didPlayerWin: didPlayerWin,
                  ),
                );
              },
            )
          ],
        ),
        // GoRoute(
        //   path: 'settings',
        //   builder: (context, state) =>
        //       const SettingsScreen(key: Key('settings')),
        // ),
      ],
    ),
  ],
);