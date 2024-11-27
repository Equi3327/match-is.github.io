import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_board_bloc/my_board_bloc.dart';
import 'my_player_hand_widget.dart';
import 'my_playing_area_widget.dart';

class MyBoardWidget extends StatefulWidget {
  const MyBoardWidget({super.key});

  @override
  State<MyBoardWidget> createState() => _MyBoardWidgetState();
}

class _MyBoardWidgetState extends State<MyBoardWidget> {
  @override
  Widget build(BuildContext context) {
    //  initial,
    //   playerAddedAndCardDistributed,
    //   currentPlayerMoved,
    //   turnChanged;
    // final boardState = context.watch<BoardState>();
    // debugPrint("_BoardWidgetState players ${boardState.players.first} :: ${boardState.players.last}");
    // debugPrint("_BoardWidgetState currentPlayer ${boardState.currentPlayer} ");
    return BlocConsumer<MyBoardBloc, MyBoardState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // final
        switch (state.boardStatus) {
          case MyBoardStateStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case MyBoardStateStatus.playerAddedAndCardDistributed ||MyBoardStateStatus.currentPlayerMoved || MyBoardStateStatus.turnChanged:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyPlayerHandWidget(
                  player: state.players.last,
                  // playerTurn: boardState.currentPlayer == boardState.secondPlayer,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: Wrap(
                //     alignment: WrapAlignment.center,
                //     spacing: 20,
                //     runSpacing: 20,
                //     children: [
                MyPlayingAreaWidget(
                  pile: state.pile,
                  currentPlayer: state.currentPlayer!,
                ),
                //       PlayingAreaWidget(boardState.areaTwo),
                //     ],
                //   ),
                // ),
                MyPlayerHandWidget(
                  player: state.players.first,
                  // playerTurn:  boardState.currentPlayer == boardState.firstPlayer,
                ),
              ],
            );
        }
      },
    );
  }
}
