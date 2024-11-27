import 'package:equatable/equatable.dart';

import '../../game_internals/playing_card.dart';

class MyPlayer extends Equatable {
  // static const maxCards = 7;
  //
  // final List<PlayingCard> hand =
  //     List.generate(maxCards, (index) => PlayingCard.random());

  const MyPlayer({required this.playerName, required this.hand});
  final List<PlayingCard> hand;
  final MyGamePlayer playerName;

  void removeCard(PlayingCard card) {
    hand.remove(card);
    // canMove = !canMove;
  }

  // void changeTurn(){
  //   canMove = !canMove;
  //   notifyListeners();
  // }

  @override
  List<Object?> get props => [ playerName,hand];
}

enum MyGamePlayer { player1, player2 }