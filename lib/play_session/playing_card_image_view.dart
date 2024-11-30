import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_is/play_session/playing_card_widget.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/player.dart';
import '../game_internals/playing_card.dart';
import '../style/palette.dart';

class PlayingCardImageViewWidget extends StatelessWidget {
  const PlayingCardImageViewWidget(
      {super.key, required this.card, this.player, required this.show});
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
    final cardWidgetNew = Container(
      width: width + 8 * (player!.hand.length - 1),
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                "assets/game_assets/${show == true ? card.suit.internalRepresentation : "card_background_${player!.hand.length}"}.png")),
        color: palette.trueWhite,
        border: Border.all(color: palette.ink),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    // if (player == null) return cardWidget;
    return cardWidgetNew;
    // return Draggable(
    //   feedback: Transform.rotate(
    //     angle: 0.1,
    //     child: cardWidget,
    //   ),
    //   data: PlayingCardDragData(card, player!),
    //   childWhenDragging: Opacity(
    //     opacity: 0.5,
    //     child: Container(
    //       width: width + 8 * (player!.hand.length - 2),
    //       height: height,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //             image: AssetImage(
    //                 "assets/game_assets/${show == true ? card.suit.internalRepresentation : "card_background_${player!.hand.length - 1}"}.png")),
    //         color: palette.trueWhite,
    //         border: Border.all(color: palette.ink),
    //         borderRadius: BorderRadius.circular(5),
    //       ),
    //     ),
    //   ),
    //   onDragStarted: () {
    //     final audioController = context.read<AudioController>();
    //     audioController.playSfx(SfxType.huhsh);
    //   },
    //   onDragEnd: (details) {
    //     final audioController = context.read<AudioController>();
    //     audioController.playSfx(SfxType.wssh);
    //   },
    //   child: Container(
    //     width: width + 8 * (player!.hand.length - 1),
    //     height: height,
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: AssetImage(
    //               "assets/game_assets/${show == true ? card.suit.internalRepresentation : "card_background_${player!.hand.length}"}.png")),
    //       color: palette.trueWhite,
    //       border: Border.all(color: palette.ink),
    //       borderRadius: BorderRadius.circular(5),
    //     ),
    //   ),
    // );
  }
}
