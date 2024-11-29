import 'package:flutter/material.dart';

import '../../game_internals/player.dart';
import 'playing_card_widget.dart';

class PlayerHandWidget extends StatelessWidget {
  const PlayerHandWidget({
    super.key,
    required this.player,
    /*required this.playerTurn*/
  });
  final Player player;
  // final bool playerTurn;
  @override
  Widget build(BuildContext context) {
    // final boardState = context.watch<BoardState>();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
          constraints: const BoxConstraints(
              minHeight: PlayingCardWidget.height,
              minWidth: PlayingCardWidget.width),
          child: PlayingCardWidget(
            player: player, card: player.hand.first,
            // canBeRemoved: playerTurn,
          )
          // Wrap(
          //   alignment: WrapAlignment.center,
          //   spacing: 10,
          //   runSpacing: 10,
          //   children: [
          //     ...player.hand.map((card) => PlayingCardWidget(
          //           player: player, card: card,
          //           // canBeRemoved: playerTurn,
          //         )),
          //   ],
          // ),
          ),
    );
  }
}
