import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/playing_card.dart';
import '../../style/palette.dart';
import '../../game_internals/player.dart';

class PlayingCardWidget extends StatelessWidget {
  const PlayingCardWidget({super.key, required this.card,  this.player, required this.show});
  static const double width = 64;

  static const double height = 89;

  final PlayingCard card;
  final bool show;

  final Player? player;
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final cardWidget = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                "assets/game_assets/${show == true ? card.suit.internalRepresentation : "card_background"}.png")),
        color: palette.trueWhite,
        border: Border.all(color: palette.ink),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    // /// Cards that aren't in a player's hand are not draggable.
    if (player == null) return cardWidget;

    return Draggable(
      feedback: Transform.rotate(
        angle: 0.1,
        child: cardWidget,
      ),
      data: PlayingCardDragData(card, player!),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: cardWidget,
      ),
      onDragStarted: () {
        final audioController = context.read<AudioController>();
        audioController.playSfx(SfxType.huhsh);
      },
      onDragEnd: (details) {
        final audioController = context.read<AudioController>();
        audioController.playSfx(SfxType.wssh);
      },
      child: cardWidget,
    );
  }
}

@immutable
class PlayingCardDragData {
  final PlayingCard card;

  final Player holder;

  const PlayingCardDragData(this.card, this.holder);
}
