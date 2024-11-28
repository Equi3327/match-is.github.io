import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../game_internals/playing_card.dart';
import '../../style/palette.dart';
import '../bloc/my_board_bloc/my_board_bloc.dart';
import '../models/my_player.dart';
import 'my_playing_card_widget.dart';

class MyPlayingAreaWidget extends StatefulWidget {
  const MyPlayingAreaWidget(
      {super.key, required this.pile, required this.currentPlayer});
  final List<PlayingCard> pile;
  final MyPlayer currentPlayer;

  @override
  State<MyPlayingAreaWidget> createState() => _MyPlayingAreaWidgetState();
}

class _MyPlayingAreaWidgetState extends State<MyPlayingAreaWidget> {
  bool isHighlighted = false;

  void _onDragLeave(MyPlayingCardDragData? data) {
    setState(() => isHighlighted = false);
  }

  bool _onDragWillAccept(DragTargetDetails<MyPlayingCardDragData>? data) {
    if (data == null || data.data.holder != widget.currentPlayer) return false;
    setState(() => isHighlighted = true);
    return true;
  }

  void _onDragAccept(DragTargetDetails<MyPlayingCardDragData> data) {
    BlocProvider.of<MyBoardBloc>(context)
        .add(MyCurrentPlayerPlayingCard(card: data.data.card));
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
        child: DragTarget<MyPlayingCardDragData>(
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
      _maxCards * _leftOffset + MyPlayingCardWidget.width;

  static const _maxHeight = _maxCards * _topOffset + MyPlayingCardWidget.height;

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
                child: MyPlayingCardWidget(
                  card: cards[i],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
