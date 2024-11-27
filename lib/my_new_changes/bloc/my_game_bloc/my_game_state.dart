part of 'my_game_bloc.dart';

sealed class MyGameState extends Equatable {
  const MyGameState();
}

final class MyGameInitial extends MyGameState {
  // final List
  @override
  List<Object> get props => [];
}

final class MyGameStarted extends MyGameState {
  // final List
  @override
  List<Object> get props => [];
}

final class MyGamePlayFailed extends MyGameState {
  // final List
  @override
  List<Object> get props => [];
}

// final class MyGameEnded extends MyGameState {
//   // final List
//   @override
//   List<Object> get props => [];
// }