import 'package:equatable/equatable.dart';

import 'playing_card.dart';

class Player extends Equatable {
  // static const maxCards = 7;
  //
  // final List<PlayingCard> hand =
  //     List.generate(maxCards, (index) => PlayingCard.random());

  Player({required this.playerName});
  final List<PlayingCard> hand = [];
  final GamePlayer playerName;

  void removeCard(PlayingCard card) {
    hand.remove(card);
    // canMove = !canMove;
  }

  // void changeTurn(){
  //   canMove = !canMove;
  //   notifyListeners();
  // }

  @override
  List<Object?> get props => [playerName, hand];
}

enum GamePlayer { player1, player2 }
