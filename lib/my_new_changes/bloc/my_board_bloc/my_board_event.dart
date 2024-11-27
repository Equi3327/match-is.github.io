part of 'my_board_bloc.dart';

sealed class MyBoardEvent extends Equatable {
  const MyBoardEvent();
}

class MyCurrentPlayerPlayingCard extends MyBoardEvent {
  const MyCurrentPlayerPlayingCard({required this.card});
  final PlayingCard card;
  // final MyPlayer pl
  @override
  List<Object?> get props => [card];
}

class AddPlayersAndDeck extends MyBoardEvent {
  const AddPlayersAndDeck({required this.players});
  // final PlayingCard card;
  final List<MyPlayer> players;
  @override
  List<Object?> get props => [players];
}