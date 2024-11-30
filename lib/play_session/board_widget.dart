import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/board_bloc/board_bloc.dart';
import '../blocs/game_bloc/game_bloc.dart';
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
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PlayerHandWidget(
                player: state.players.last,
              ),
              PlayingAreaWidget(
                pile: state.pile,
                currentPlayer: state.currentPlayer,
              ),
              PlayerHandWidget(
                player: state.players.first,
              ),
            ],
          ),
        );
      },
    );
  }
}
