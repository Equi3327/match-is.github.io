import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../game_internals/playing_card.dart';
import '../../game_internals/card_suit.dart';
import '../../game_internals/player.dart';

part 'game_event.dart';
part 'game_state.dart';

const _celebrationDuration = Duration(milliseconds: 2000);

const _preCelebrationDuration = Duration(milliseconds: 500);

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<PlayGame>((event, emit) {
      /// TODO Add logic to add second player
      // DECK.shuffle();
      final secondPlayer = Player(playerName: GamePlayer.player2);
      event.player.hand.addAll(DECK.sublist(0, MAX_CARDS ~/ 2));
      secondPlayer.hand.addAll(DECK.sublist(MAX_CARDS ~/ 2, MAX_CARDS));
      emit(GameState.started(players: [event.player, secondPlayer]));
    });
    on<StartCelebrations>((event, emit) async {
      await Future<void>.delayed(_preCelebrationDuration);
      emit(state.copyWith(gameStatus: GameStateStatus.playerWon,champion: event.champion));
      await Future<void>.delayed(_celebrationDuration);
      emit(state.copyWith(gameStatus: GameStateStatus.gameOver));
    });
    // on<RestartGame>((event, emit) {
    //   // emit(GameState.initial());
    //   event.players.first.hand.clear();
    //   event.players.first.hand.clear();
    //   DECK.shuffle();
    //   event.players.first.hand.addAll(DECK.sublist(0, MAX_CARDS ~/ 2));
    //   event.players.last.hand.addAll(DECK.sublist(MAX_CARDS ~/ 2, MAX_CARDS));
    //   emit(GameState.restarted( event.players));
    // });
    on<EndGame>((event, emit) {
      emit(GameState.initial());
    });
  }
}
