import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_is/game_internals/playing_card.dart';
import 'package:match_is/game_internals/player.dart';

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
    });
  }
}
