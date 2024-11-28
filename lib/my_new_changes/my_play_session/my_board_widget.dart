import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_is/my_new_changes/bloc/my_game_bloc/my_game_bloc.dart';

import '../bloc/my_board_bloc/my_board_bloc.dart';
import 'my_player_hand_widget.dart';
import 'my_playing_area_widget.dart';

class MyBoardWidget extends StatelessWidget {
  const MyBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBoardBloc, MyBoardState>(
      builder: (context, state) {
        if (state.boardStatus == MyBoardStateStatus.playerWin) {
          BlocProvider.of<MyGameBloc>(context).add(
            StartCelebrations(
              state.currentPlayer,
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyPlayerHandWidget(
              player: state.players.last,
            ),
            MyPlayingAreaWidget(
              pile: state.pile,
              currentPlayer: state.currentPlayer,
            ),
            MyPlayerHandWidget(
              player: state.players.first,
            ),
          ],
        );
      },
    );
  }
}
