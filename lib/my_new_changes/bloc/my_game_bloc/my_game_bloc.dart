import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:match_is/my_new_changes/models/my_player.dart';

import '../../../game_internals/playing_card.dart';

part 'my_game_event.dart';
part 'my_game_state.dart';

const _celebrationDuration = Duration(milliseconds: 2000);

const _preCelebrationDuration = Duration(milliseconds: 500);

class MyGameBloc extends Bloc<MyGameEvent, MyGameState> {
  MyGameBloc() : super(MyGameState.initial()) {
    on<PlayGame>((event, emit) {
      /// TODO Add logic to add second player
      DECK.shuffle();
      final secondPlayer = MyPlayer(playerName: MyGamePlayer.player2);
      event.player.hand.addAll(DECK.sublist(0, MAX_CARDS ~/ 2));
      secondPlayer.hand.addAll(DECK.sublist(MAX_CARDS ~/ 2, MAX_CARDS));
      emit(MyGameState.started(players: [event.player, secondPlayer]));
    });
    on<StartCelebrations>((event, emit) async {
      await Future<void>.delayed(_preCelebrationDuration);
      emit(state.copyWith(gameStatus:MyGameStateStatus.playerWon));
      await Future<void>.delayed(_celebrationDuration);
      emit(state.copyWith(gameStatus:MyGameStateStatus.gameOver));
    });
    on<EndGame>((event, emit) {
      emit(MyGameState.initial());
    });
  }
}
