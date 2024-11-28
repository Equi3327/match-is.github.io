import 'package:flutter/material.dart';

import '../bloc/my_board_bloc/my_board_bloc.dart';
import 'my_player_hand_widget.dart';
import 'my_playing_area_widget.dart';

class MyBoardWidget extends StatelessWidget {
  const MyBoardWidget({super.key, required this.boardState});
  final MyBoardState boardState;
  @override
  Widget build(BuildContext context) {
    return boardState.boardStatus != MyBoardStateStatus.initial
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyPlayerHandWidget(
                player: boardState.players.last,
              ),
              MyPlayingAreaWidget(
                pile: boardState.pile,
                currentPlayer: boardState.currentPlayer!,
              ),
              MyPlayerHandWidget(
                player: boardState.players.first,
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
