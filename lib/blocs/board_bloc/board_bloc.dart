import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_is/game_internals/playing_card.dart';
import 'package:match_is/game_internals/player.dart';

import '../game_bloc/game_bloc.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final List<Player> players;
  BoardBloc({required this.players})
      : super(BoardState.initial(
          players: players,
          currentPlayer: players.first,
        )) {
    on<CurrentPlayerPlayingCard>((event, emit) async {
      emit(state.copyWith(
        boardStatus: BoardStateStatus.currentPlayerMoved,
      ));
      emit(state.addCardToPile(card: event.card));
      if (state.boardStatus != BoardStateStatus.playerWin &&
          state.currentPlayer == state.players.last) {
        await Future.delayed(const Duration(seconds: 5));
        add(AIPlayerPlayingCard(card: state.currentPlayer.hand.first));
      }
    });
    on<AIPlayerPlayingCard>((event, emit) async {
      emit(state.copyWith(
        boardStatus: BoardStateStatus.currentPlayerMoved,
      ));
      emit(state.addCardToPile(card: event.card));
      // if(state.boardStatus != BoardStateStatus.playerWin && state.currentPlayer == state.players.last){
      //   await Future.delayed(const Duration(seconds: 5));
      //   add(CurrentPlayerPlayingCard(card: state.currentPlayer.hand.first));
      // }
    });
    on<RestartGame>((event, emit) {

      event.players.first.hand.clear();
      event.players.first.hand.clear();
      DECK.shuffle();
      event.players.first.hand.addAll(DECK.sublist(0, MAX_CARDS ~/ 2));
      event.players.last.hand.addAll(DECK.sublist(MAX_CARDS ~/ 2, MAX_CARDS));
      emit(
        BoardState.initial(
          players: players,
          currentPlayer: players.first,
        ),
      );
    });
  }
}
