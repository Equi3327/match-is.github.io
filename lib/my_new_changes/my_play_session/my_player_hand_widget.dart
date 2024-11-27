import 'package:flutter/material.dart';

import '../models/my_player.dart';
import 'my_playing_card_widget.dart';

class MyPlayerHandWidget extends StatelessWidget {
  const MyPlayerHandWidget({super.key, required this.player, /*required this.playerTurn*/});
  final MyPlayer player;
  // final bool playerTurn;
  @override
  Widget build(BuildContext context) {
    // final boardState = context.watch<BoardState>();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: MyPlayingCardWidget.height),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            ...player.hand.map((card) =>
                MyPlayingCardWidget(player: player, card: card,
                  // canBeRemoved: playerTurn,
                )),
          ],
        ),
      ),
    );
  }
}