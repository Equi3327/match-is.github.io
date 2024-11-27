import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'card_suit.dart';

class PlayingCard  extends Equatable {
  static final _random = Random();

  final CardSuit suit;

  final CardSuitColor suitColor;

  const PlayingCard(this.suit, this.suitColor);

  // factory PlayingCard.fromJson(Map<String, dynamic> json) {
  //   return PlayingCard(
  //     CardSuit.values
  //         .singleWhere((e) => e.internalRepresentation == json['suit']),
  //     json['value'],
  //   );
  // }

  factory PlayingCard.random([Random? random]) {
    random ??= _random;
    return PlayingCard(
      CardSuit.values[random.nextInt(CardSuit.values.length)],
      CardSuitColor.values[random.nextInt(CardSuitColor.values.length)],
    );
  }

  // @override
  // int get hashCode => suit;

  // @override
  // bool operator ==(Object other) {
  //   return other is PlayingCard && other.suit == suit;
  // }

  // Map<String, dynamic> toJson() => {
  //       'suit': suit.internalRepresentation,
  //       'value': value,
  //     };

  // @override
  // String toString() {
  //   return '${suit.internalRepresentation}${suitColor.internalRepresentation}';
  // }

  @override
  List<Object> get props => [suit,suitColor];
}
