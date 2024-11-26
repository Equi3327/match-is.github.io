enum CardSuit {
  // clubs(1),
  // spades(2),
  // hearts(3),
  // diamonds(4);
  clover("clover"),
  spade("spade"),
  heart("heart"),
  diamond("diamond");

  final String internalRepresentation;

  const CardSuit(this.internalRepresentation);

  // String get asCharacter {
  //   switch (this) {
  //     case CardSuit.spade:
  //       return '♠';
  //     case CardSuit.heart:
  //       return '♥';
  //     case CardSuit.diamond:
  //       return '♦';
  //     case CardSuit.clover:
  //       return '♣';
  //   }
  // }

  // CardSuitColor get color {
  //   switch (this) {
  //     case CardSuit.spade:
  //     case CardSuit.clover:
  //       return CardSuitColor.black;
  //     case CardSuit.heart:
  //     case CardSuit.diamond:
  //       return CardSuitColor.red;
  //   }
  // }

  @override
  String toString() => internalRepresentation;
}

enum CardSuitColor {
  black("black"),
  red("red");

  final String internalRepresentation;
  const CardSuitColor(this.internalRepresentation);
  @override
  String toString() => internalRepresentation;
}
