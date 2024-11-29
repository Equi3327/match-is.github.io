import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game_internals/playing_card.dart';
import '../../style/palette.dart';
import '../blocs/board_bloc/board_bloc.dart';
import '../game_internals/player.dart';
import 'playing_card_widget.dart';

class PlayingAreaWidget extends StatefulWidget {
  const PlayingAreaWidget(
      {super.key, required this.pile, required this.currentPlayer});
  final List<PlayingCard> pile;
  final Player currentPlayer;

  @override
  State<PlayingAreaWidget> createState() => _PlayingAreaWidgetState();
}

class _PlayingAreaWidgetState extends State<PlayingAreaWidget> {
  bool isHighlighted = false;

  void _onDragLeave(PlayingCardDragData? data) {
    setState(() => isHighlighted = false);
  }

  bool _onDragWillAccept(DragTargetDetails<PlayingCardDragData>? data) {
    if (data == null || data.data.holder != widget.currentPlayer) return false;
    setState(() => isHighlighted = true);
    return true;
  }

  void _onDragAccept(DragTargetDetails<PlayingCardDragData> data) {
    BlocProvider.of<BoardBloc>(context)
        .add(CurrentPlayerPlayingCard(card: data.data.card));
    setState(() => isHighlighted = false);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    debugPrint("widget.pile length:: ${widget.pile.length}");
    return LimitedBox(
      maxHeight: 200,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DragTarget<PlayingCardDragData>(
          builder: (context, candidateData, rejectedData) => SizedBox(
            height: 100,
            child: Material(
              color: isHighlighted ? palette.accept : palette.trueWhite,
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: palette.redPen,
                // onTap: _onAreaTap,
                child: _CardStack(widget.pile),
              ),
            ),
          ),
          onWillAcceptWithDetails: _onDragWillAccept,
          onLeave: _onDragLeave,
          onAcceptWithDetails: _onDragAccept,
        ),
      ),
    );
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
                child: PlayingCardWidget(
                  card: cards[i],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
