part of 'my_board_bloc.dart';

const MAX_CARDS = 20;


enum MyBoardStateStatus {
  initial,
  playerAddedAndCardDistributed,
  currentPlayerMoved,
  turnChanged,
  playerWin;
}

class MyBoardState extends Equatable {
   const MyBoardState(
      {required this.players,
      required this.currentPlayer,
      required this.boardStatus,
        required this.pile,
     });
  final List<MyPlayer> players;
  final MyPlayer? currentPlayer;
  final MyBoardStateStatus boardStatus;
   final List<PlayingCard> pile;
  static const int maxCards = 6;

  MyBoardState copyWith({
    MyBoardStateStatus? boardStatus,
    List<MyPlayer>? players,
    MyPlayer? currentPlayer,
    List<PlayingCard>? pile,
  }) {
    return MyBoardState(
      players: players ?? this.players,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      boardStatus: boardStatus ?? this.boardStatus,
      pile: pile ?? this.pile,
    );
  }

  MyBoardState addCardToPile({required PlayingCard card}) {
    currentPlayer!.removeCard(card);
    int nextPlayerIndex = (players.indexOf(currentPlayer!) + 1) % players.length;

    return MyBoardState(
      players: players,
      currentPlayer: players[nextPlayerIndex],
      boardStatus: MyBoardStateStatus.turnChanged,
      pile: [...pile,card],
    );
  }

  // void _maybeTrim() {
  //   if (pile.length > maxCards) {
  //     pile.removeLast();
  //   }
  // }

  @override
  List<Object?> get props => [currentPlayer, boardStatus,pile];
}

// final class MyBoardInitial extends MyBoardState {
//   @override
//   List<Object> get props => [];
// }
