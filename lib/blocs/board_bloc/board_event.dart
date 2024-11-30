part of 'board_bloc.dart';

sealed class BoardEvent extends Equatable {
  const BoardEvent();
}

class CurrentPlayerPlayingCard extends BoardEvent {
  const CurrentPlayerPlayingCard({required this.card});
  final PlayingCard card;
  @override
  List<Object?> get props => [card];
}

class RestartGame extends BoardEvent {
  const RestartGame(this.players);
  final List<Player> players;
  @override
  List<Object?> get props => [players];
}