part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();
}

class PlayGame extends GameEvent {
  const PlayGame(this.player);

  /// TODO for multiplayer add current player to the game
  final Player player;
  @override
  List<Object?> get props => [player];
}

class StartCelebrations extends GameEvent {
  const StartCelebrations(this.champion);
  final Player champion;
  @override
  List<Object?> get props => [champion];
}

// class RestartGame extends GameEvent {
//   const RestartGame(this.players);
//   final List<Player> players;
//   @override
//   List<Object?> get props => [players];
// }

class EndGame extends GameEvent {
  const EndGame();

  @override
  List<Object?> get props => [];
}
