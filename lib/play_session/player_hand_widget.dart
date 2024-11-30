import 'package:flutter/material.dart';
import 'package:match_is/play_session/playing_card_image_view.dart';

import '../../game_internals/player.dart';

class PlayerHandWidget extends StatelessWidget {
  const PlayerHandWidget({
    super.key,
    required this.player,
  });
  final Player player;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: player.hand.isEmpty ? Container(
        width: 64,
        height: 89,
        decoration: const BoxDecoration(
          image:  DecorationImage(
              image: AssetImage(
                  "assets/game_assets/no_cards.png")),
          // color: palette.trueWhite,
          // border: Border.all(color: palette.ink),
          // borderRadius: BorderRadius.circular(5),
        ),
      ): PlayingCardImageViewWidget(
        player: player,
        card: player.hand.first,
        show: false,
      ),
    );
  }
}
