part of 'game_bloc.dart';

const MAX_CARDS = 20;

List<PlayingCard> DECK =
    List.generate(MAX_CARDS, (index) => PlayingCard.random());

enum GameStateStatus {
  initial,
  gameStarted,
  playerWon,
  gameOver;
}

class GameState extends Equatable {
  final GameStateStatus gameStatus;
  final List<Player> players;
  final Player? champion;

  const GameState({
    required this.gameStatus,
    required this.players,
    this.champion,
  });

  GameState.initial()
      : gameStatus = GameStateStatus.initial,
        players = [],
        champion = null;

  const GameState.started({required this.players})
      : gameStatus = GameStateStatus.gameStarted,
        champion = null;

  GameState copyWith({
    GameStateStatus? gameStatus,
  }) {
    return GameState(
      players: players,
      champion: champion,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }

  @override
  List<Object?> get props => [gameStatus, players, champion];
}
