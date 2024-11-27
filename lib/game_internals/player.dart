import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'playing_card.dart';

class Player extends ChangeNotifier with EquatableMixin {
  // static const maxCards = 7;
  //
  // final List<PlayingCard> hand =
  //     List.generate(maxCards, (index) => PlayingCard.random());

  Player(this.playerName, {this.canMove = false, required this.hand});
  final List<PlayingCard> hand;
  final GamePlayer playerName;
  late bool canMove;

  void removeCard(PlayingCard card) {
    if (!canMove) return;
    hand.remove(card);
    canMove = !canMove;
    notifyListeners();
  }

  // void changeTurn(){
  //   canMove = !canMove;
  //   notifyListeners();
  // }

  @override
  List<Object?> get props => [ playerName,canMove];
}

enum GamePlayer { player1, player2 }
