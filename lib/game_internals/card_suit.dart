enum CardSuit {
  club("club"),
  spade("spade"),
  heart("heart"),
  diamond("diamond");

  final String internalRepresentation;

  const CardSuit(this.internalRepresentation);

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
