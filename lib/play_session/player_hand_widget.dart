import 'package:flutter/material.dart';
import 'package:match_is/play_session/playing_card_image_view.dart';

import '../../game_internals/player.dart';
import 'card_movement_animation.dart';

class PlayerHandWidget extends StatelessWidget {
  const PlayerHandWidget({
    super.key,
    required this.player, required this.currentPlayer,
  });
  final Player player;
  final Player currentPlayer;
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
      ):
    // CardMovementAnimation(
    //   cardWidget:  PlayingCardImageViewWidget(
    //     player: player,
    //     card: player.hand.first,
    //     show: false,
    //   ),
    //   startPosition: Offset(100, 500), // Example deck position
    //   endPosition: Offset(200, 300),  // Example playing area position
    //   onAnimationComplete: () {
    //     // context.read<YourBloc>().add(AnimationCompletedEvent());
    //   },
    // ),
      Stack(
        alignment: Alignment.center,
        children: [
          PlayingCardImageViewWidget(
            player: player,
            card: player.hand.first,
            show: false,
          ),
          Align(
            alignment: Alignment.lerp(Alignment.topCenter, Alignment.topRight, 0.5)!,
            child: currentPlayer.playerName == player.playerName ? Text("${player.playerName == GamePlayer.player2 ? "AI's":"Your"} turn"):const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
