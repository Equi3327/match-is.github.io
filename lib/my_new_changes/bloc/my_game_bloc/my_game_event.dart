part of 'my_game_bloc.dart';

sealed class MyGameEvent extends Equatable {
  const MyGameEvent();
}

class PlayGame extends MyGameEvent {
  const PlayGame(this.player);
  /// TODO for multiplayer add current player to the game
  final MyPlayer player;
  @override
  List<Object?> get props => [player];
}

class StartCelebrations extends MyGameEvent {
  const StartCelebrations(this.champion);
  final MyPlayer champion;
  @override
  List<Object?> get props => [champion];
}

class EndGame extends MyGameEvent {
  const EndGame();

  @override
  List<Object?> get props => [];
}
