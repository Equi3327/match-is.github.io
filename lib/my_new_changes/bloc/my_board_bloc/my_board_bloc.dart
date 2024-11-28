import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_is/game_internals/playing_card.dart';
import 'package:match_is/my_new_changes/models/my_player.dart';

part 'my_board_event.dart';
part 'my_board_state.dart';

class MyBoardBloc extends Bloc<MyBoardEvent, MyBoardState> {
  MyBoardBloc()
      : super(
          const MyBoardState(
            currentPlayer: null,
            boardStatus: MyBoardStateStatus.initial,
            players: [],
            pile: [],
          ),
        ) {
    on<AddPlayersAndDeck>((event, emit) {
      emit(state.copyWith(
        boardStatus: MyBoardStateStatus.playerAddedAndCardDistributed,
        players: event.players,
        currentPlayer: event.players.first,
      ));
    });
    on<MyCurrentPlayerPlayingCard>((event, emit) async {
      emit(state.copyWith(
        boardStatus: MyBoardStateStatus.currentPlayerMoved,
      ));
      emit(state.addCardToPile(card: event.card));
    });
  }
}
