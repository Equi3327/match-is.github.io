part of 'my_game_bloc.dart';

const MAX_CARDS = 20;

List<PlayingCard> DECK =
    List.generate(MAX_CARDS, (index) => PlayingCard.random());

enum MyGameStateStatus {
  initial,
  gameStarted,
  playerWon,
  gameOver;
}

class MyGameState extends Equatable {
  final MyGameStateStatus gameStatus;
  final List<MyPlayer> players;
  final MyPlayer? champion;

  const MyGameState({
    required this.gameStatus,
    required this.players,
    this.champion,
  });

  MyGameState.initial()
      : gameStatus = MyGameStateStatus.initial,
        players = [],
        champion = null;
  const MyGameState.started({required this.players})
      : gameStatus = MyGameStateStatus.gameStarted,
        champion = null;

  MyGameState copyWith({
    MyGameStateStatus? gameStatus,
  }) {
    return MyGameState(
      players: players,
      champion: champion,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }

  @override
  List<Object?> get props => [gameStatus, players, champion];
}

// final class MyGameInitial extends MyGameState {
//   @override
//   List<Object> get props => [];
// }
//
// final class MyGameStarted extends MyGameState {
//   final List<MyPlayer> players;
//
//   MyGameStarted({required this.players});
//
//   @override
//   List<Object> get props => [
//         players,
//       ];
// }
//
// final class GameOver extends MyGameState {
//   // final List
//   @override
//   List<Object> get props => [];
// }
//
// final class PlayerWon extends MyGameState {
//   final MyPlayer champion;
//   const PlayerWon(this.champion);
//   @override
//   List<Object> get props => [champion];
// }

// final class MyGamePlayFailed extends MyGameState {
//   // final List
//   @override
//   List<Object> get props => [];
// }

// final class PlayerAdded extends MyGameState {
//   // final List
//   @override
//   List<Object> get props => [];
// }
