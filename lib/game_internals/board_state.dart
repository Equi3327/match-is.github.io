import 'package:flutter/foundation.dart';

import 'player.dart';
import 'playing_area.dart';
import 'playing_card.dart';

class BoardState{
  /// Added this line for max cards in deck
  static const maxCards = 20;

  final VoidCallback onWin;

  final PlayingArea playingArea = PlayingArea();

  /// Deck of cards
  final List<PlayingCard> deck =
      List.generate(maxCards, (index) => PlayingCard.random());

  final List<Player> players = [];

  late Player currentPlayer;

  BoardState({required this.onWin}) {
    deck.shuffle();
    players.addAll([
      Player(
        GamePlayer.player1,
        hand: deck.sublist(0, maxCards ~/ 2),
        // canMove: true,
      ),
      Player(
        GamePlayer.player2,
        hand: deck.sublist(maxCards ~/ 2, maxCards),
        // canMove: false,
      )
    ]);
    // players.forEach((player) {
    //   player.addListener((){
    //     _handlePlayerChange(player);
    //   });
    // });
    currentPlayer = players.first; //firstPlayer;
    currentPlayer.canMove = true;
    debugPrint("initializing currentPlayer $currentPlayer");
    debugPrint("initializing players.first ${players.first}");
    // firstPlayer.addListener(_handlePlayerChange);
    // secondPlayer.addListener(_handlePlayerChange);
    // currentPlayer.addListener(_handlePlayerChange);
  }

  PlayingArea get areas => playingArea;

  void dispose() {
    // firstPlayer.removeListener(_handlePlayerChange);
    // secondPlayer.removeListener(_handlePlayerChange);
    // players.forEach((player) {
    //   player.removeListener((){
    //     _handlePlayerChange(player);
    //   });
    // });
    playingArea.dispose();
  }

  void _handlePlayerChange(Player player) {
    debugPrint("player ___ handlePlayerChange --------- player $player");
    if (currentPlayer.hand.isEmpty) {
      onWin();
      // return;
    } else {
      currentPlayer.canMove = !currentPlayer.canMove;
      debugPrint("entering turn changing canMove to False............. currentPlayer $currentPlayer");
      int nextPlayerIndex = (players.indexOf(currentPlayer) + 1) % players.length;
      currentPlayer = players[nextPlayerIndex];
      currentPlayer.canMove = !currentPlayer.canMove;
      debugPrint("changing......changing canMove to True.for other player...... currentPlayer $currentPlayer");
      // currentPlayer.notifyListeners();
      // currentPlayer.notifyListeners();
    }
    // debugPrint("_handlePlayerChange currentPlayer ${currentPlayer.hand.length}");
    // if (firstPlayer.hand.isEmpty || secondPlayer.hand.isEmpty) {
    //   onWin();
    //   // return;
    // }
    // else{
    //   switchPlayer();
    // }
    // if(){
    //
    // }
    // else {
    // switchPlayer();
    // }
  }

  void switchPlayer() {
    // currentPlayer = currentPlayer == firstPlayer ? secondPlayer : firstPlayer;
    // debugPrint("switchPlayer switchPlayer ${currentPlayer.hand.length}");
    // currentPlayer.notifyListeners();
  }
}
