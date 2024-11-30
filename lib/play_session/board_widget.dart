import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/board_bloc/board_bloc.dart';
import '../blocs/game_bloc/game_bloc.dart';
import '../style/my_button.dart';
import 'player_hand_widget.dart';
import 'playing_area_widget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        if (state.boardStatus == BoardStateStatus.playerWin) {
          BlocProvider.of<GameBloc>(context).add(
            StartCelebrations(
              state.currentPlayer,
            ),
          );
        }
        if (state.boardStatus == BoardStateStatus.playerDraw) {
          BlocProvider.of<BoardBloc>(context).add(RestartGame(state.players));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PlayerHandWidget(
                    player: state.players.last,
                    currentPlayer: state.currentPlayer,
                  ),
                  PlayingAreaWidget(
                    pile: state.pile,
                    currentPlayer: state.currentPlayer,
                  ),
                  PlayerHandWidget(
                    player: state.players.first,
                    currentPlayer: state.currentPlayer,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: MyButton(
                  //     onPressed: () => BlocProvider.of<BoardBloc>(context).add(CurrentPlayerPlayingCard(card: null)),
                  //     child: const Text('Play'),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                onPressed: state.currentPlayer != state.players.first
                    ? null
                    : () => BlocProvider.of<BoardBloc>(context).add(
                          CurrentPlayerPlayingCard(
                            card: state.currentPlayer.hand.first,
                          ),
                        ),
                child: const Text('Play Card'),
              ),
            ),
          ],
        );
      },
    );
  }
}
