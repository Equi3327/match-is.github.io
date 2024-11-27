import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/player.dart';
import '../game_internals/playing_area.dart';
import '../game_internals/playing_card.dart';
import '../style/palette.dart';
import 'playing_card_widget.dart';

class PlayingAreaWidget extends StatefulWidget {
  final PlayingArea area;

  const PlayingAreaWidget(this.area, {super.key, required this.currentPlayer});
  final Player currentPlayer;

  @override
  State<PlayingAreaWidget> createState() => _PlayingAreaWidgetState();
}

class _PlayingAreaWidgetState extends State<PlayingAreaWidget> {
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    debugPrint("PlayingAreaWidget currentPlayer ${widget.currentPlayer}");
    return LimitedBox(
      maxHeight: 200,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DragTarget<PlayingCardDragData>(
          builder: (context, candidateData, rejectedData) => SizedBox(
            height: 100,
            child: Material(
              color: isHighlighted ? palette.accept : palette.trueWhite,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: palette.redPen,
                onTap: _onAreaTap,
                child: StreamBuilder(
                  // Rebuild the card stack whenever the area changes
                  // (either by a player action, or remotely).
                  stream: widget.area.allChanges,
                  builder: (context, child) => _CardStack(widget.area.cards),
                ),
              ),
            ),
          ),
          onWillAccept: _onDragWillAccept,
          onLeave: _onDragLeave,
          onAccept: _onDragAccept,
        ),
      ),
    );
  }

  void _onAreaTap() {
    widget.area.removeFirstCard();

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.huhsh);
  }

  void _onDragAccept(PlayingCardDragData data) {
    // debugPrint("PlayingAreaWidget currentPlayer ${widget.currentPlayer}");
    // debugPrint("PlayingAreaWidget PlayingCardDragData holder${data.holder}");
    // if (widget.currentPlayer != data.holder) {
    //   // debugPrint("PlayingAreaWidget PlayingCardDragData widget.currentPlayer != data.holder");
    //   // throw Exception("It's not this player's turn!");
    //   return;
    // }
    // widget.area.playerChanges;
    debugPrint("+++++++++++++++++++++++++++++++");
    widget.area.acceptCard(data.card);
    data.holder.removeCard(data.card);
    // widget.currentPlayer =
    // debugPrint("PlayingAreaWidget holderremoveCard${data.holder}");
    setState(() => isHighlighted = false);
  }

  void _onDragLeave(PlayingCardDragData? data) {
    setState(() => isHighlighted = false);
  }

  bool _onDragWillAccept(PlayingCardDragData? data) {
    if (data == null /*|| widget.currentPlayer != data.holder*/) return false;
    setState(() => isHighlighted = true);
    return true;
  }
}

class _CardStack extends StatelessWidget {
  static const int _maxCards = 6;

  static const _leftOffset = 10.0;

  static const _topOffset = 5.0;

  static const double _maxWidth =
      _maxCards * _leftOffset + PlayingCardWidget.width;

  static const _maxHeight = _maxCards * _topOffset + PlayingCardWidget.height;

  final List<PlayingCard> cards;

  const _CardStack(this.cards);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _maxWidth,
        height: _maxHeight,
        child: Stack(
          children: [
            for (var i = max(0, cards.length - _maxCards);
                i < cards.length;
                i++)
              Positioned(
                top: i * _topOffset,
                left: i * _leftOffset,
                child: PlayingCardWidget(cards[i],
                  // canBeRemoved: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
