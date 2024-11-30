part of 'board_bloc.dart';

enum BoardStateStatus {
  initial,
  currentPlayerMoved,
  turnChanged,
  playerDraw,
  playerWin;
}

class BoardState extends Equatable {
  const BoardState({
    required this.players,
    required this.currentPlayer,
    required this.boardStatus,
    required this.pile,
  });
  final List<Player> players;
  final Player currentPlayer;
  final BoardStateStatus boardStatus;
  final List<PlayingCard> pile;
  static const int maxCards = 6;

  BoardState.initial({required this.players, required this.currentPlayer})
      : boardStatus = BoardStateStatus.initial,
        pile = [];

  BoardState copyWith({
    BoardStateStatus? boardStatus,
    List<Player>? players,
    Player? currentPlayer,
    List<PlayingCard>? pile,
  }) {
    return BoardState(
      players: players ?? this.players,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      boardStatus: boardStatus ?? this.boardStatus,
      pile: pile ?? this.pile,
    );
  }

  BoardState addCardToPile({required PlayingCard card}) {
    currentPlayer.removeCard(card);

    if (pile.isNotEmpty && pile.last == card) {
      return BoardState(
        players: players,
        currentPlayer: currentPlayer,
        boardStatus: BoardStateStatus.playerWin,
        pile: [...pile, card],
      );
    }
    int nextPlayerIndex = (players.indexOf(currentPlayer) + 1) % players.length;
    if (players.every((player)=> player.hand.isEmpty)) {
      return BoardState(
        players: players,
        currentPlayer: players[nextPlayerIndex],
        boardStatus: BoardStateStatus.playerDraw,
        pile: [...pile, card],
      );
    }
    return BoardState(
      players: players,
      currentPlayer: players[nextPlayerIndex],
      boardStatus: BoardStateStatus.turnChanged,
      pile: [...pile, card],
    );
  }

  @override
  List<Object?> get props => [currentPlayer, boardStatus, pile];
}
