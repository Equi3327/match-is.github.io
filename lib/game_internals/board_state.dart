import 'package:flutter/foundation.dart';

import 'player.dart';
import 'playing_area.dart';
import 'playing_card.dart';

class BoardState {
  /// Added this line for max cards in deck
  static const maxCards = 20;

  final VoidCallback onWin;

  // final PlayingArea areaOne = PlayingArea();

  // final PlayingArea areaTwo = PlayingArea();
  final PlayingArea playingArea = PlayingArea();

  /// Deck of cards
  final List<PlayingCard> deck =
      List.generate(maxCards, (index) => PlayingCard.random());

  ///
  // final Player firstPlayer = Player();
  // final Player secondPlayer = Player();
  late final Player firstPlayer;
  late final Player secondPlayer;

  BoardState({required this.onWin}) {
    deck.shuffle();
    // firstPlayer.hand = deck.sublist(0, maxCards~/2);
    // secondPlayer.hand = deck.sublist(maxCards~/2, maxCards);
    firstPlayer = Player(
      hand: deck.sublist(0, maxCards ~/ 2),
    );
    secondPlayer = Player(
      hand: deck.sublist(maxCards ~/ 2, maxCards),
    );
    firstPlayer.addListener(_handlePlayerChange);
    secondPlayer.addListener(_handlePlayerChange);
  }

  PlayingArea get areas => playingArea;

  void dispose() {
    firstPlayer.removeListener(_handlePlayerChange);
    secondPlayer.removeListener(_handlePlayerChange);
    playingArea.dispose();
  }

  void _handlePlayerChange() {
    if (firstPlayer.hand.isEmpty || secondPlayer.hand.isEmpty) {
      onWin();
    }
  }
}
