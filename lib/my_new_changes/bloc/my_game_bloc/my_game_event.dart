part of 'my_game_bloc.dart';

sealed class MyGameEvent extends Equatable {
  const MyGameEvent();
}

class StartGame extends MyGameEvent {
  const StartGame(this.players);
  final List<MyPlayer> players;
  @override
  List<Object?> get props => [players];
}

class EndGame extends MyGameEvent {
  const EndGame();

  @override
  List<Object?> get props => [];
}