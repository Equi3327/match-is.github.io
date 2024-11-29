import 'dart:math';

import 'package:equatable/equatable.dart';

import 'card_suit.dart';

class PlayingCard extends Equatable {
  static final _random = Random();

  final CardSuit suit;

  // final CardSuitColor suitColor;

  const PlayingCard(
    this.suit,
    // this.suitColor,
  );

  factory PlayingCard.random([Random? random]) {
    random ??= _random;
    return PlayingCard(
      CardSuit.values[random.nextInt(CardSuit.values.length)],
      // CardSuitColor.values[random.nextInt(CardSuitColor.values.length)],
    );
  }

  @override
  List<Object> get props => [
        suit,
        // suitColor,
      ];
}
